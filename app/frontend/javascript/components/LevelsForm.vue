<template>
  <div class="levels-form">
    <div
      v-for="(level, index) in levels"
      :key="index"
      class="levels-field"
      :class="{ destroyed: level.destroy }"
    >
      <p class="levels-number">Lv {{ index + 1 }}</p>
      <input
        type="hidden"
        :name="`dungeon[levels_attributes][${index}][number]`"
        :id="`dungeon_levels_attributes_${index}_number`"
        :value="index + 1"
      />
      <input
        v-model="level.title"
        type="text"
        class="levels-title"
        :name="`dungeon[levels_attributes][${index}][title]`"
        :id="`dungeon_levels_attributes_${index}_title`"
        @keydown.13.prevent
        required
      />
      <p class="levels-days">
        <input
          min="1"
          max="31"
          type="number"
          v-model="level.days"
          :name="`dungeon[levels_attributes][${index}][days]`"
          :id="`dungeon_levels_attributes_${index}_days`"
          required
        />
        日
      </p>
      <input
        type="hidden"
        :value="level.id"
        :name="`dungeon[levels_attributes][${index}][id]`"
        :id="`dungeon_levels_attributes_${index}_id`"
        v-if="isEditPage"
      />
      <input
        type="hidden"
        :name="`dungeon[levels_attributes][${index}][_destroy]`"
        :id="`dungeon_levels_attributes_${index}__destroy`"
        :value="level.destroy ? '1' : '0'"
        style="display: none;"
        v-if="isEditPage"
      />
      <div class="levels-btns">
        <i
          class="delete fas fa-trash-alt"
          @click="deleteLevel(index)"
          v-if="index == levels.length - toDestroy.length - 1"
        >
        </i>
        <i
          class="cancel fas fa-undo fa-lg"
          @click="cancelDeleteLevel(index)"
          v-if="level.destroy == true"
        >
        </i>
      </div>
    </div>

    <p v-if="error" class="levels-error">{{ error }}</p>

    <div class="levels-wrap">
      <div class="levels-add">
        <i class="add fas fa-plus" @click="addLevel"></i>
      </div>
      <div class="levels-total">
        <span v-if="totalDays >= 66">OK</span>
        <p>合計 {{ totalDays }}日</p>
      </div>
    </div>

    <div class="levels-submit">
      <p v-if="totalDays < 66" class="levels-error">
        合計日数が66日以上になるように設定してください
      </p>
      <input
        type="submit"
        name="commit"
        :value="isEditPage ? '更新する' : '作成する'"
        :data-disable-with="isEditPage ? '更新する' : '作成する'"
        :disabled="totalDays < 66"
        :data-confirm="isEditPage ? confirmMessage : ''"
      />
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'LevelsForm',
  props: ['dungeonId'],
  data() {
    return {
      levels: [
        {
          title: '〜を毎日〜する',
          days: 10,
        },
        {
          title: '〜を毎日〜する',
          days: 10,
        },
        {
          title: '〜を毎日〜する',
          days: 10,
        },
        {
          title: '〜を毎日〜する',
          days: 10,
        },
        {
          title: '〜を毎日〜する',
          days: 10,
        },
      ],
      additionalLevels: [],
      error: null,
      isEditPage: false,
      confirmMessage:
        'ダンジョンを編集すると、このダンジョンを攻略中の他のユーザーのダンジョン情報も変更されます。\nよろしいですか？',
    }
  },
  computed: {
    toDestroy() {
      return this.levels.filter(level => level.destroy)
    },
    totalDays() {
      let daysNotDestroyed = this.levels.filter(level => !level.destroy)
      let daysList = daysNotDestroyed.map(level => parseInt(level.days))
      let result = daysList.reduce((total, days) => total + days)
      if (!isNaN(result)) {
        return result
      } else {
        return ''
      }
    },
  },
  created() {
    if (this.dungeonId) {
      axios
        .get(`/api/dungeons/${this.dungeonId}/levels`)
        .then(res => (this.levels = res.data))
      this.isEditPage = true
    }
  },
  watch: {
    levels() {
      this.error = null
    },
  },
  methods: {
    addLevel() {
      if (this.levels.length >= 10) {
        this.error = 'レベルが設定できるのは１０までです'
      } else if (this.toDestroy.length > 0) {
        return (this.error =
          '新しいレベルを追加するには、レベルの削除をキャンセルしてください')
      } else {
        const additionalLevel = {
          title: '',
          days: 0,
        }
        this.levels.push(additionalLevel)
        this.additionalLevels.push(additionalLevel)
      }
    },
    deleteLevel(index) {
      if (this.isEditPage && this.additionalLevels.length == 0) {
        this.levels[index]['destroy'] = true
      } else {
        this.levels.splice(index, 1)
        this.additionalLevels.splice(-1, 1)
      }
    },
    cancelDeleteLevel(index) {
      this.levels.forEach((level, i) => {
        if (index >= i) {
          level.destroy = false
        }
      })
    },
  },
}
</script>

<style lang="scss" scoped></style>
