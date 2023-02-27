import { createStore } from "vuex";

const store = createStore({
  state() {
    return {
      isSigned: false, // 로그인 여부
      user: {
        id: 0, // 사용자 아이디 저장
        walletAddress: null
      },
      // 구매중인 아이템 정보
      purchasingItem: null,
      purchaseTransactions: [],
      saleTransactions: []
    }
  },
  mutations: {
    setIsSigned(state, isSigned) {
      console.log('issigned:', isSigned);
      state.isSigned = isSigned;
    },
    setUserId(state, id) {
      state.user.id = id;
    },
    setWalletAddress(state, address) {
      state.user.walletAddress = address;
    },
    setPurchasingItem(state, item) {
      state.purchasingItem = item;
    },
    setPurchaseTransactions(state, txes) {
      state.purchaseTransactions = txes;
    },
    addPurchaseTransaction(state, tx) {
      state.purchaseTransactions.push(tx);
    },
    setSaleTransactions(state, txes) {
      state.saleTransactions = txes;
    },
    logout(state) {
      state.isSigned = false;
      state.user.id = 0;
      state.user.walletAddress = null;
    }
  },
  actions: {},
  modules: {}
})

export default store;
