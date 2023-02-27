<template>
  <div class="sf-container">
    <ul v-if="activeCount > 0" class="progressbar">
      <li :class="{ active: activeCount >= 1 }">
        <h5>입금대기중</h5>
        <p>{{ history[0].when }}</p>
        <div v-if="isCancelled" class="text-danger">
          <h5>거래취소</h5>
          <p>{{ history[1].when }}</p>
        </div>
        <div v-if="isRefunded && activeCount == 1" class="text-danger">
          <h5>환불완료</h5>
          <p>{{ history[1].when }}</p>
        </div>
      </li>
      <li :class="{ active: activeCount >= 2 }">
        <h5>입금완료</h5>
        <p v-if="activeCount >= 2">{{ history[1].when }}</p>
        <div v-if="isRefunded && activeCount == 2" class="text-danger">
          <h5>환불완료</h5>
          <p>{{ history[2].when }}</p>
        </div>
      </li>
      <li :class="{ active: activeCount >= 3 }">
        <h5>배송완료</h5>
        <p v-if="activeCount >= 3">{{ history[2].when }}</p>
      </li>
      <li :class="{ active: activeCount >= 4 }">
        <h5>거래완료</h5>
        <p v-if="activeCount >= 4">{{ history[3].when }}</p>
      </li>
      <li :class="{ active: activeCount >= 5 }">
        <h5>거래종료</h5>
        <p v-if="activeCount >= 5">{{ history[4].when }}</p>
      </li>
    </ul>
  </div>
</template>

<script>
import { ref, watch } from 'vue'

// 스텝 개수, 이름, 아이콘, 완료 단계, 애니메이션
export default {
  name: "StepFlow",
  props: ["history"],
  setup(props) {
    const activeCount = ref(0);
    const isCancelled = ref(false);
    const isRefunded = ref(false);

    watch(() => props.history, () => {

      if (!props.history || (props.history && props.history.length === 0)) return;
      if (props.history.filter(h => h.state === "Cancelled").length === 1) {
        isCancelled.value = true;
        activeCount.value = 1;
      } else if (props.history.filter(h => h.state === "Refunded").length === 1) {
        isRefunded.value = true;
        switch(props.history.length) {
          case 3:
            activeCount.value = 1;
            break;
          case 4:
            activeCount.value = 2;
            break;
        }
      } else {
        activeCount.value = props.history.length;
      }
    })

    return {
      activeCount,
      isCancelled,
      isRefunded
    }
  }
};
</script>

<style>
.progressbar {
  counter-reset: step;
}
.progressbar li {
  list-style-type: none;
  width: 20%;
  float: left;
  font-size: 17px;
  position: relative;
  text-align: center;
  text-transform: uppercase;
  color: #7d7d7d;
}
.progressbar li:before {
  width: 30px;
  height: 30px;
  content: counter(step);
  counter-increment: step;
  line-height: 30px;
  border: 2px solid #7d7d7d;
  display: block;
  text-align: center;
  margin: 0 auto 10px auto;
  border-radius: 50%;
  background-color: white;
}
.progressbar li:after {
  width: 100%;
  height: 2px;
  content: "";
  position: absolute;
  background-color: #7d7d7d;
  top: 15px;
  left: -50%;
  z-index: -1;
}
.progressbar li:first-child:after {
  content: none;
}
.progressbar li.active {
  color: #0070bc;
}
.progressbar li.active:before {
  border-color: #0070bc;
}
.progressbar li.active + li:after {
  background-color: #0070bc;
}
</style>
