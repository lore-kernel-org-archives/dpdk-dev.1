Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D24BC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 22:30:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 197064026E;
	Thu, 13 Aug 2026 00:30:22 +0200 (CEST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mails.dpdk.org (Postfix) with ESMTP id BD46440264
 for <dev@dpdk.org>; Thu, 13 Aug 2026 00:30:20 +0200 (CEST)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e024d2129so2273650b3a.2
 for <dev@dpdk.org>; Wed, 12 Aug 2026 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786573820; x=1787178620; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=adPjl1o7nkM3brKIjetApW+MqrXRA2CxGOB3BRIGkSM=;
 b=I9H/7xG8UmRo/SfSHtl+TmMG7+PrBLj5171kSfO6GFh5hi7XQufIhQlRiaY3+TPLtw
 8R4VavYwuqdd/D/A+/ba/G4Rqe04U42TiZciuB3xKXI2Yg+f2P7Mtj3cz5Q9gWptSOim
 it47ns8t+hqVtOSd1dUtUXhvMhqJaejayql0zta14cfepXCp6uydK3U+uOlIlRGzofO4
 rAwdqOAqvoLQAtANBe+zjdltslgmdexQjOr36qieK/LJe+ja9YBVMP3c291YJSojF8Bk
 vVgEieWrsh/j9Eg8q4S066JecVib6ULxOi38vrRZGuh6tvIZsK6L/bMQaF3z5E827olY
 4xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573820; x=1787178620;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=adPjl1o7nkM3brKIjetApW+MqrXRA2CxGOB3BRIGkSM=;
 b=ekt6JOE9mel63MySBTUvxG/GDy5mt+e3fUpxBG00zQKTPNFIfOk7lPgtDVRfs0YgAW
 l6en/cM5syvykRr595V3S8+wj0It4ZGLDdO69jjCfN8CB4MwUc8EXmsaB8kkF0WDm1kP
 vaBlOxT+kTUDwikN8JntxG0ciLj1ZnrabCMORrCQ0j/m9sm6mh+FXJU6IfkjIAb/4itv
 8tqpPArWZh5wAKW8wR9/CkekOZCn6oRYuXPWwYP6e2VNPeki2pRdv0KWN355r7QUW5IZ
 tHJ6ii+FCj3nJlX/r9f19og3huNroXRpRnQi6Dzyxf8ZUB03KU72NYvkV6cyy9QBarZL
 g8Nw==
X-Gm-Message-State: AOJu0Yw4kqXk943v1gC77667lWA9SxwWo/GOwERjMwcu9xEue/YRZiT9
 k63zc38kQb3o43jDIkf2j+5S21/IeIfu5/4uYVUspmsNnSJECBTJqMNOMDjtwvv1eVY+9kbJFH0
 SNdFjZ8oguuGjxA==
X-Received: from pfbhg3.prod.google.com ([2002:a05:6a00:8603:b0:848:8808:ae6b])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12d6:b0:848:50a5:a70b with SMTP id
 d2e1a72fcca58-84fc6dc6b8cmr1229374b3a.21.1786573819262; 
 Wed, 12 Aug 2026 15:30:19 -0700 (PDT)
Date: Wed, 12 Aug 2026 15:30:17 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812223017.2980190-1-joshwash@google.com>
Subject: [PATCH] eal: introduce division round up macro
From: Joshua Washington <joshwash@google.com>
To: Reshma Pattan <reshma.pattan@intel.com>,
 Chaoyong He <chaoyong.he@corigine.com>, 
 Julien Aube <julien_dpdk@jaube.fr>, Potnuri Bharat Teja <bharat@chelsio.com>, 
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>, 
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>, 
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Xingui Yang <yangxingui@huawei.com>, 
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, 
 Praveen Shetty <praveen.shetty@intel.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>, 
 Alok Prasad <palok@marvell.com>, Wenbo Cao <caowenbo@mucse.com>,
 Rosen Xu <rosen.xu@altera.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

A number of drivers define the DIV_ROUND_UP macro -- add it to
RTE_COMMON so that other code looking to use that functionality doesn't
have to re-define it.

Replace usage of DIV_ROUND_UP in existing places with RTE_DIV_ROUND_UP.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 app/proc-info/main.c                        |  3 +--
 drivers/common/nfp/nfp_platform.h           |  2 --
 drivers/net/bnx2x/bnx2x.c                   |  4 ++--
 drivers/net/bnx2x/bnx2x.h                   | 11 ++++-------
 drivers/net/cxgbe/base/t4_hw.c              |  4 ++--
 drivers/net/cxgbe/base/t4vf_hw.c            | 10 +++++-----
 drivers/net/cxgbe/cxgbe_compat.h            |  3 +--
 drivers/net/cxgbe/cxgbe_filter.c            |  6 +++---
 drivers/net/cxgbe/cxgbe_ofld.h              |  4 ++--
 drivers/net/cxgbe/sge.c                     | 14 +++++++-------
 drivers/net/ena/base/ena_eth_com.h          |  4 ++--
 drivers/net/ena/base/ena_plat_dpdk.h        |  1 -
 drivers/net/hinic/base/hinic_compat.h       |  5 +----
 drivers/net/hns3/hns3_ethdev.h              |  2 --
 drivers/net/hns3/hns3_fdir.c                |  2 +-
 drivers/net/hns3/hns3_regs.c                |  8 ++++----
 drivers/net/hns3/hns3_rss.c                 |  8 ++++----
 drivers/net/intel/i40e/base/i40e_osdep.h    |  3 +--
 drivers/net/intel/ice/base/ice_osdep.h      |  3 +--
 drivers/net/intel/idpf/base/idpf_osdep.h    |  3 +--
 drivers/net/nfp/nfdk/nfp_nfdk.h             |  5 +++--
 drivers/net/nfp/nfdk/nfp_nfdk_dp.c          |  3 ++-
 drivers/net/nfp/nfpcore/nfp_nsp.c           |  2 +-
 drivers/net/qede/base/bcm_osal.h            |  2 --
 drivers/net/qede/base/ecore_chain.h         |  2 +-
 drivers/net/qede/base/ecore_cxt.c           | 20 +++++++++++---------
 drivers/net/qede/base/ecore_init_fw_funcs.c | 21 ++++++++++++---------
 drivers/net/qede/base/ecore_mcp.c           |  6 +++---
 drivers/net/qede/qede_debug.c               | 16 ++++++++--------
 drivers/net/rnp/base/rnp_osdep.h            |  5 ++---
 drivers/net/rnp/rnp_rxtx.c                  |  2 +-
 drivers/raw/ifpga/base/opae_osdep.h         |  3 +--
 lib/eal/include/rte_common.h                |  5 +++++
 33 files changed, 92 insertions(+), 100 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 5925bbb765..9c22fb8f01 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -48,7 +48,6 @@
 
 #define ETHDEV_FWVERS_LEN 32
 #define RTE_RETA_CONF_GROUP_NUM 32
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define EEPROM_DUMP_CHUNKSIZE 1024
 
 #define STATS_BDR_FMT "========================================"
@@ -1830,7 +1829,7 @@ show_port_rss_reta_info(void)
 			return;
 		}
 
-		num = DIV_ROUND_UP(dev_info.reta_size, RTE_ETH_RETA_GROUP_SIZE);
+		num = RTE_DIV_ROUND_UP(dev_info.reta_size, RTE_ETH_RETA_GROUP_SIZE);
 		memset(reta_conf, 0, sizeof(reta_conf));
 		for (i = 0; i < num; i++)
 			reta_conf[i].mask = ~0ULL;
diff --git a/drivers/common/nfp/nfp_platform.h b/drivers/common/nfp/nfp_platform.h
index 0b02fcf1e8..814f90b5a2 100644
--- a/drivers/common/nfp/nfp_platform.h
+++ b/drivers/common/nfp/nfp_platform.h
@@ -10,8 +10,6 @@
 
 #include <rte_bitops.h>
 
-#define DIV_ROUND_UP(n, d)             (((n) + (d) - 1) / (d))
-
 #define DMA_BIT_MASK(n)    ((1ULL << (n)) - 1)
 
 #define BITS_PER_LONG      (__SIZEOF_LONG__ * 8)
diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 8790c858d5..ce9dbdf7c6 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -2334,8 +2334,8 @@ static void bnx2x_ilt_set_info(struct bnx2x_softc *sc)
 		ilt_client->start = line;
 
 		/* 4 bytes for each cid */
-		line += DIV_ROUND_UP(sc->qm_cid_count * QM_QUEUES_PER_FUNC * 4,
-				     QM_ILT_PAGE_SZ);
+		line += RTE_DIV_ROUND_UP(sc->qm_cid_count * QM_QUEUES_PER_FUNC * 4,
+					 QM_ILT_PAGE_SZ);
 
 		ilt_client->end = (line - 1);
 	}
diff --git a/drivers/net/bnx2x/bnx2x.h b/drivers/net/bnx2x/bnx2x.h
index 35206b4758..0cdd118ad5 100644
--- a/drivers/net/bnx2x/bnx2x.h
+++ b/drivers/net/bnx2x/bnx2x.h
@@ -37,9 +37,6 @@
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) RTE_DIM(arr)
 #endif
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-#endif
 #ifndef roundup
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #endif
@@ -393,7 +390,7 @@ union cdu_context {
 #define CNIC_ISCSI_CID_MAX 256
 #define CNIC_FCOE_CID_MAX  2048
 #define CNIC_CID_MAX       (CNIC_ISCSI_CID_MAX + CNIC_FCOE_CID_MAX)
-#define CNIC_ILT_LINES     DIV_ROUND_UP(CNIC_CID_MAX, ILT_PAGE_CIDS)
+#define CNIC_ILT_LINES     RTE_DIV_ROUND_UP(CNIC_CID_MAX, ILT_PAGE_CIDS)
 
 #define QM_ILT_PAGE_SZ_HW  0
 #define QM_ILT_PAGE_SZ     (4096 << QM_ILT_PAGE_SZ_HW) /* 4K */
@@ -405,7 +402,7 @@ union cdu_context {
 /*#define TM_CONN_NUM        (CNIC_STARTING_CID+CNIC_ISCSI_CXT_MAX) */
 #define TM_CONN_NUM        1024
 #define TM_ILT_SZ          (8 * TM_CONN_NUM)
-#define TM_ILT_LINES       DIV_ROUND_UP(TM_ILT_SZ, TM_ILT_PAGE_SZ)
+#define TM_ILT_LINES       RTE_DIV_ROUND_UP(TM_ILT_SZ, TM_ILT_PAGE_SZ)
 
 /* SRC (Searcher) host DB constants */
 #define SRC_ILT_PAGE_SZ_HW 0
@@ -414,7 +411,7 @@ union cdu_context {
 #define SRC_CONN_NUM       (1 << SRC_HASH_BITS) /* 1024 */
 #define SRC_ILT_SZ         (sizeof(struct src_ent) * SRC_CONN_NUM)
 #define SRC_T2_SZ          SRC_ILT_SZ
-#define SRC_ILT_LINES      DIV_ROUND_UP(SRC_ILT_SZ, SRC_ILT_PAGE_SZ)
+#define SRC_ILT_LINES      RTE_DIV_ROUND_UP(SRC_ILT_SZ, SRC_ILT_PAGE_SZ)
 
 struct hw_context {
     struct bnx2x_dma    vcxt_dma;
@@ -1258,7 +1255,7 @@ struct bnx2x_softc {
 #define BNX2X_L2_CID_COUNT(sc)                                             \
 	(BNX2X_NUM_ETH_QUEUES(sc) * ECORE_MULTI_TX_COS + 2 * CNIC_SUPPORT(sc))
 #define L2_ILT_LINES(sc)                                \
-	(DIV_ROUND_UP(BNX2X_L2_CID_COUNT(sc), ILT_PAGE_CIDS))
+	(RTE_DIV_ROUND_UP(BNX2X_L2_CID_COUNT(sc), ILT_PAGE_CIDS))
 
 	int qm_cid_count;
 
diff --git a/drivers/net/cxgbe/base/t4_hw.c b/drivers/net/cxgbe/base/t4_hw.c
index d02da39b84..944e173da2 100644
--- a/drivers/net/cxgbe/base/t4_hw.c
+++ b/drivers/net/cxgbe/base/t4_hw.c
@@ -2630,8 +2630,8 @@ static int t4_get_exprom_version(struct adapter *adapter, u32 *vers)
 		unsigned char hdr_arr[16];      /* must start with 0x55aa */
 		unsigned char hdr_ver[4];       /* Expansion ROM version */
 	} *hdr;
-	u32 exprom_header_buf[DIV_ROUND_UP(sizeof(struct exprom_header),
-					   sizeof(u32))];
+	u32 exprom_header_buf[RTE_DIV_ROUND_UP(sizeof(struct exprom_header),
+					       sizeof(u32))];
 	int ret;
 
 	ret = t4_read_flash(adapter, FLASH_EXP_ROM_START,
diff --git a/drivers/net/cxgbe/base/t4vf_hw.c b/drivers/net/cxgbe/base/t4vf_hw.c
index 573ccb1b05..561e4a91a4 100644
--- a/drivers/net/cxgbe/base/t4vf_hw.c
+++ b/drivers/net/cxgbe/base/t4vf_hw.c
@@ -362,8 +362,8 @@ int t4vf_query_params(struct adapter *adapter, unsigned int nparams,
 	cmd.op_to_vfn = cpu_to_be32(V_FW_CMD_OP(FW_PARAMS_CMD) |
 				    F_FW_CMD_REQUEST |
 				    F_FW_CMD_READ);
-	len16 = DIV_ROUND_UP(offsetof(struct fw_params_cmd,
-			     param[nparams]), 16);
+	len16 = RTE_DIV_ROUND_UP(offsetof(struct fw_params_cmd,
+					  param[nparams]), 16);
 	cmd.retval_len16 = cpu_to_be32(V_FW_CMD_LEN16(len16));
 	for (i = 0, p = &cmd.param[0]; i < nparams; i++, p++)
 		p->mnem = cpu_to_be32(*params++);
@@ -458,8 +458,8 @@ int t4vf_set_params(struct adapter *adapter, unsigned int nparams,
 	cmd.op_to_vfn = cpu_to_be32(V_FW_CMD_OP(FW_PARAMS_CMD) |
 				    F_FW_CMD_REQUEST |
 				    F_FW_CMD_WRITE);
-	len16 = DIV_ROUND_UP(offsetof(struct fw_params_cmd,
-			     param[nparams]), 16);
+	len16 = RTE_DIV_ROUND_UP(offsetof(struct fw_params_cmd,
+					  param[nparams]), 16);
 	cmd.retval_len16 = cpu_to_be32(V_FW_CMD_LEN16(len16));
 	for (i = 0, p = &cmd.param[0]; i < nparams; i++, p++) {
 		p->mnem = cpu_to_be32(*params++);
@@ -626,7 +626,7 @@ static int t4vf_get_port_stats_fw(struct adapter *adapter, int pidx,
 		struct fw_vi_stats_cmd cmd, rpl;
 		size_t len = (offsetof(struct fw_vi_stats_cmd, u) +
 			      sizeof(struct fw_vi_stats_ctl));
-		size_t len16 = DIV_ROUND_UP(len, 16);
+		size_t len16 = RTE_DIV_ROUND_UP(len, 16);
 		int ret;
 
 		memset(&cmd, 0, sizeof(cmd));
diff --git a/drivers/net/cxgbe/cxgbe_compat.h b/drivers/net/cxgbe/cxgbe_compat.h
index e74d476f6d..14ebe914eb 100644
--- a/drivers/net/cxgbe/cxgbe_compat.h
+++ b/drivers/net/cxgbe/cxgbe_compat.h
@@ -166,11 +166,10 @@ typedef uint64_t  dma_addr_t;
 typedef char *caddr_t;
 #endif
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 static inline uint8_t hweight32(uint32_t word32)
 {
diff --git a/drivers/net/cxgbe/cxgbe_filter.c b/drivers/net/cxgbe/cxgbe_filter.c
index 5a7efe7a73..83f86a747a 100644
--- a/drivers/net/cxgbe/cxgbe_filter.c
+++ b/drivers/net/cxgbe/cxgbe_filter.c
@@ -219,7 +219,7 @@ static inline void mk_set_tcb_field_ulp(struct filter_entry *f,
 
 	txpkt->cmd_dest = cpu_to_be32(V_ULPTX_CMD(ULP_TX_PKT) |
 				      V_ULP_TXPKT_DEST(0));
-	txpkt->len = cpu_to_be32(DIV_ROUND_UP(sizeof(*req), 16));
+	txpkt->len = cpu_to_be32(RTE_DIV_ROUND_UP(sizeof(*req), 16));
 	sc->cmd_more = cpu_to_be32(V_ULPTX_CMD(ULP_TX_SC_IMM));
 	sc->len = cpu_to_be32(sizeof(*req) - sizeof(struct work_request_hdr));
 	OPCODE_TID(req) = cpu_to_be32(MK_OPCODE_TID(CPL_SET_TCB_FIELD, f->tid));
@@ -371,7 +371,7 @@ static void mk_abort_req_ulp(struct cpl_abort_req *abort_req,
 
 	txpkt->cmd_dest = cpu_to_be32(V_ULPTX_CMD(ULP_TX_PKT) |
 				      V_ULP_TXPKT_DEST(0));
-	txpkt->len = cpu_to_be32(DIV_ROUND_UP(sizeof(*abort_req), 16));
+	txpkt->len = cpu_to_be32(RTE_DIV_ROUND_UP(sizeof(*abort_req), 16));
 	sc->cmd_more = cpu_to_be32(V_ULPTX_CMD(ULP_TX_SC_IMM));
 	sc->len = cpu_to_be32(sizeof(*abort_req) -
 			      sizeof(struct work_request_hdr));
@@ -395,7 +395,7 @@ static void mk_abort_rpl_ulp(struct cpl_abort_rpl *abort_rpl,
 
 	txpkt->cmd_dest = cpu_to_be32(V_ULPTX_CMD(ULP_TX_PKT) |
 				      V_ULP_TXPKT_DEST(0));
-	txpkt->len = cpu_to_be32(DIV_ROUND_UP(sizeof(*abort_rpl), 16));
+	txpkt->len = cpu_to_be32(RTE_DIV_ROUND_UP(sizeof(*abort_rpl), 16));
 	sc->cmd_more = cpu_to_be32(V_ULPTX_CMD(ULP_TX_SC_IMM));
 	sc->len = cpu_to_be32(sizeof(*abort_rpl) -
 			      sizeof(struct work_request_hdr));
diff --git a/drivers/net/cxgbe/cxgbe_ofld.h b/drivers/net/cxgbe/cxgbe_ofld.h
index fd1e7d8002..ef56eef426 100644
--- a/drivers/net/cxgbe/cxgbe_ofld.h
+++ b/drivers/net/cxgbe/cxgbe_ofld.h
@@ -14,7 +14,7 @@
 	(w)->wr.wr_hi = cpu_to_be32(V_FW_WR_OP(FW_TP_WR) | \
 				V_FW_WR_IMMDLEN(sizeof(*w) - sizeof(w->wr))); \
 	(w)->wr.wr_mid = cpu_to_be32( \
-				V_FW_WR_LEN16(DIV_ROUND_UP(sizeof(*w), 16)) | \
+				V_FW_WR_LEN16(RTE_DIV_ROUND_UP(sizeof(*w), 16)) | \
 				V_FW_WR_FLOWID(tid)); \
 	(w)->wr.wr_lo = cpu_to_be64(0); \
 } while (0)
@@ -27,7 +27,7 @@
 #define INIT_ULPTX_WR(w, wrlen, atomic, tid) do { \
 	(w)->wr.wr_hi = cpu_to_be32(V_FW_WR_OP(FW_ULPTX_WR) | \
 				    V_FW_WR_ATOMIC(atomic)); \
-	(w)->wr.wr_mid = cpu_to_be32(V_FW_WR_LEN16(DIV_ROUND_UP(wrlen, 16)) | \
+	(w)->wr.wr_mid = cpu_to_be32(V_FW_WR_LEN16(RTE_DIV_ROUND_UP(wrlen, 16)) | \
 				     V_FW_WR_FLOWID(tid)); \
 	(w)->wr.wr_lo = cpu_to_be64(0); \
 } while (0)
diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c
index e9d45f24c4..eb25d80e33 100644
--- a/drivers/net/cxgbe/sge.c
+++ b/drivers/net/cxgbe/sge.c
@@ -459,7 +459,7 @@ static inline unsigned int sgl_len(unsigned int n)
  */
 static inline unsigned int flits_to_desc(unsigned int n)
 {
-	return DIV_ROUND_UP(n, 8);
+	return RTE_DIV_ROUND_UP(n, 8);
 }
 
 /**
@@ -505,7 +505,7 @@ static inline unsigned int calc_tx_flits(const struct rte_mbuf *m,
 
 	hdrlen = is_eth_imm(m);
 	if (hdrlen)
-		return DIV_ROUND_UP(m->pkt_len + hdrlen, sizeof(__be64));
+		return RTE_DIV_ROUND_UP(m->pkt_len + hdrlen, sizeof(__be64));
 
 	/*
 	 * Otherwise, we're going to have to construct a Scatter gather list
@@ -779,7 +779,7 @@ static inline void ship_tx_pkt_coalesce_wr(struct adapter *adap,
 	wr = (void *)&q->desc[q->pidx];
 	vmwr = (void *)&q->desc[q->pidx];
 
-	wr_mid = V_FW_WR_LEN16(DIV_ROUND_UP(q->coalesce.flits, 2));
+	wr_mid = V_FW_WR_LEN16(RTE_DIV_ROUND_UP(q->coalesce.flits, 2));
 	ndesc = flits_to_desc(q->coalesce.flits);
 	wr->equiq_to_len16 = htonl(wr_mid);
 	wr->plen = cpu_to_be16(q->coalesce.len);
@@ -866,7 +866,7 @@ static inline int should_tx_packet_coalesce(struct sge_eth_txq *txq,
 
 	/* If coalescing is on, the mbuf is added to a pkts WR */
 	if (q->coalesce.idx) {
-		ndesc = DIV_ROUND_UP(q->coalesce.flits + flits, 8);
+		ndesc = RTE_DIV_ROUND_UP(q->coalesce.flits + flits, 8);
 		credits = txq_avail(q) - ndesc;
 
 		if (unlikely(wraps_around(q, ndesc)))
@@ -950,7 +950,7 @@ static inline int tx_do_packet_coalesce(struct sge_eth_txq *txq,
 		mc->cmd_dest = htonl(V_ULPTX_CMD(4) | V_ULP_TXPKT_DEST(0) |
 				     V_ULP_TXPKT_FID(adap->sge.fw_evtq.cntxt_id) |
 				     F_ULP_TXPKT_RO);
-		mc->len = htonl(DIV_ROUND_UP(flits, 2));
+		mc->len = htonl(RTE_DIV_ROUND_UP(flits, 2));
 		sc_imm = (struct ulptx_idata *)(mc + 1);
 		sc_imm->cmd_more = htonl(V_ULPTX_CMD(ULP_TX_SC_IMM) |
 					 F_ULP_TX_SC_MORE);
@@ -1116,7 +1116,7 @@ int t4_eth_xmit(struct sge_eth_txq *txq, struct rte_mbuf *mbuf,
 		goto out_free;
 	}
 
-	wr_mid = V_FW_WR_LEN16(DIV_ROUND_UP(flits, 2));
+	wr_mid = V_FW_WR_LEN16(RTE_DIV_ROUND_UP(flits, 2));
 	if (Q_IDXDIFF(&txq->q, equeidx)  >= 64) {
 		txq->q.equeidx = txq->q.pidx;
 		wr_mid |= F_FW_WR_EQUEQ;
@@ -1322,7 +1322,7 @@ static int ctrl_xmit(struct sge_ctrl_txq *q, struct rte_mbuf *mbuf)
 	}
 
 	reclaim_completed_tx_imm(&q->q);
-	ndesc = DIV_ROUND_UP(mbuf->pkt_len, sizeof(struct tx_desc));
+	ndesc = RTE_DIV_ROUND_UP(mbuf->pkt_len, sizeof(struct tx_desc));
 	t4_os_lock(&q->ctrlq_lock);
 
 	q->full = txq_avail(&q->q) < ndesc ? 1 : 0;
diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index f773699467..4c82415181 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -160,8 +160,8 @@ static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
 
 	if (num_descs > llq_info->descs_num_before_header) {
 		descs_after_first_entry = num_descs - llq_info->descs_num_before_header;
-		num_entries_needed += DIV_ROUND_UP(descs_after_first_entry,
-						   llq_info->descs_per_entry);
+		num_entries_needed += RTE_DIV_ROUND_UP(descs_after_first_entry,
+						       llq_info->descs_per_entry);
 	}
 
 	ena_trc_dbg(ena_com_io_sq_to_ena_dev(io_sq),
diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index c84420de22..9c8a96c918 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -304,7 +304,6 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 			rte_write64_relaxed(*from, to);			       \
 	} while(0)
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 
 #define ENA_FFS(x) ffs(x)
 
diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index 707a3b92b9..f4398a7847 100644
--- a/drivers/net/hinic/base/hinic_compat.h
+++ b/drivers/net/hinic/base/hinic_compat.h
@@ -70,11 +70,8 @@ typedef uint64_t  dma_addr_t;
 #define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
 #define lower_32_bits(n) ((u32)(n))
 
-/* Returns X / Y, rounding up.  X must be nonnegative to round correctly. */
-#define DIV_ROUND_UP(X, Y) (((X) + ((Y) - 1)) / (Y))
-
 /* Returns X rounded up to the nearest multiple of Y. */
-#define ROUND_UP(X, Y) (DIV_ROUND_UP(X, Y) * (Y))
+#define ROUND_UP(X, Y) (RTE_DIV_ROUND_UP(X, Y) * (Y))
 
 #undef  ALIGN
 #define ALIGN(x, a)  RTE_ALIGN(x, a)
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index 209b042816..b4feff4b94 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -978,8 +978,6 @@ static inline struct hns3_vf *HNS3_DEV_HW_TO_VF(struct hns3_hw *hw)
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #define rounddown(x, y) ((x) - ((x) % (y)))
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-
 /*
  * Because hardware always access register in little-endian mode based on hns3
  * network engine, so driver should also call rte_cpu_to_le_32 to convert data
diff --git a/drivers/net/hns3/hns3_fdir.c b/drivers/net/hns3/hns3_fdir.c
index 50572ae430..dfcc5c0d99 100644
--- a/drivers/net/hns3/hns3_fdir.c
+++ b/drivers/net/hns3/hns3_fdir.c
@@ -129,7 +129,7 @@ static const struct key_info tuple_key_info[] = {
 #define MAX_KEY_LENGTH		400
 #define MAX_200B_KEY_LENGTH	200
 #define MAX_META_DATA_LENGTH	16
-#define MAX_KEY_DWORDS	DIV_ROUND_UP(MAX_KEY_LENGTH / HNS3_BITS_PER_BYTE, 4)
+#define MAX_KEY_DWORDS	RTE_DIV_ROUND_UP(MAX_KEY_LENGTH / HNS3_BITS_PER_BYTE, 4)
 #define MAX_KEY_BYTES	(MAX_KEY_DWORDS * 4)
 
 enum HNS3_FD_PACKET_TYPE {
diff --git a/drivers/net/hns3/hns3_regs.c b/drivers/net/hns3/hns3_regs.c
index 5c74f9ae2e..066b836556 100644
--- a/drivers/net/hns3/hns3_regs.c
+++ b/drivers/net/hns3/hns3_regs.c
@@ -1034,8 +1034,8 @@ hns3_get_32_bit_regs(struct hns3_hw *hw, uint32_t regs_num, struct rte_dev_reg_i
 	if (regs_num == 0)
 		return 0;
 
-	cmd_num = DIV_ROUND_UP(regs_num + HNS3_32_BIT_DESC_NODATA_LEN,
-			       HNS3_32_BIT_REG_RTN_DATANUM);
+	cmd_num = RTE_DIV_ROUND_UP(regs_num + HNS3_32_BIT_DESC_NODATA_LEN,
+				   HNS3_32_BIT_REG_RTN_DATANUM);
 	desc = rte_zmalloc("hns3-32bit-regs",
 			   sizeof(struct hns3_cmd_desc) * cmd_num, 0);
 	if (desc == NULL) {
@@ -1093,8 +1093,8 @@ hns3_get_64_bit_regs(struct hns3_hw *hw, uint32_t regs_num, struct rte_dev_reg_i
 	if (regs_num == 0)
 		return 0;
 
-	cmd_num = DIV_ROUND_UP(regs_num + HNS3_64_BIT_DESC_NODATA_LEN,
-			       HNS3_64_BIT_REG_RTN_DATANUM);
+	cmd_num = RTE_DIV_ROUND_UP(regs_num + HNS3_64_BIT_DESC_NODATA_LEN,
+				   HNS3_64_BIT_REG_RTN_DATANUM);
 	desc = rte_zmalloc("hns3-64bit-regs",
 			   sizeof(struct hns3_cmd_desc) * cmd_num, 0);
 	if (desc == NULL) {
diff --git a/drivers/net/hns3/hns3_rss.c b/drivers/net/hns3/hns3_rss.c
index 508b3e26d0..6cb8d9482d 100644
--- a/drivers/net/hns3/hns3_rss.c
+++ b/drivers/net/hns3/hns3_rss.c
@@ -295,7 +295,7 @@ hns3_rss_set_algo_key(struct hns3_hw *hw, uint8_t hash_algo,
 
 	req = (struct hns3_rss_generic_config_cmd *)desc.data;
 
-	max_bd_num = DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
+	max_bd_num = RTE_DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
 	for (idx = 0; idx < max_bd_num; idx++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_GENERIC_CONFIG,
 					  false);
@@ -335,7 +335,7 @@ hns3_rss_get_algo_key(struct hns3_hw *hw,  uint8_t *hash_algo,
 	int ret;
 
 	req = (struct hns3_rss_generic_config_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
+	max_bd_num = RTE_DIV_ROUND_UP(key_len, HNS3_RSS_HASH_KEY_NUM);
 	for (idx = 0; idx < max_bd_num; idx++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_GENERIC_CONFIG,
 					  true);
@@ -381,7 +381,7 @@ hns3_set_rss_indir_table(struct hns3_hw *hw, uint16_t *indir, uint16_t size)
 	int ret;
 
 	req = (struct hns3_rss_indirection_table_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
+	max_bd_num = RTE_DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
 	for (i = 0; i < max_bd_num; i++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_INDIR_TABLE,
 					  false);
@@ -431,7 +431,7 @@ hns3_get_rss_indir_table(struct hns3_hw *hw, uint16_t *indir, uint16_t size)
 	int ret;
 
 	req = (struct hns3_rss_indirection_table_cmd *)desc.data;
-	max_bd_num = DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
+	max_bd_num = RTE_DIV_ROUND_UP(size, HNS3_RSS_CFG_TBL_SIZE);
 	for (i = 0; i < max_bd_num; i++) {
 		hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_RSS_INDIR_TABLE,
 					  true);
diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/net/intel/i40e/base/i40e_osdep.h
index 9c5a94f055..93620f5c50 100644
--- a/drivers/net/intel/i40e/base/i40e_osdep.h
+++ b/drivers/net/intel/i40e/base/i40e_osdep.h
@@ -227,12 +227,11 @@ struct i40e_spinlock {
 #define i40e_memset(a, b, c, d) memset((a), (b), (c))
 #define i40e_memcpy(a, b, c, d) memcpy((a), (b), (c))
 
-#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us_sleep(x)
 #define i40e_usec_delay(x) DELAY(x)
 #define i40e_msec_delay(x) DELAY(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000*(x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #endif /* _I40E_OSDEP_H_ */
diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index 5d92cf5aa4..3ef52eae6d 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -311,13 +311,12 @@ ice_hweight32(u32 num)
 	return bits;
 }
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define ice_usec_delay(x, y) rte_delay_us(x)
 #define ice_msec_delay(x, y) rte_delay_us(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 struct ice_list_entry {
 	LIST_ENTRY(ice_list_entry) next;
diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
index 67bc33f2e6..64bbd00eea 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/base/idpf_osdep.h
@@ -291,13 +291,12 @@ idpf_hweight32(u32 num)
 	return bits;
 }
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define DELAY(x) rte_delay_us(x)
 #define idpf_usec_delay(x) rte_delay_us(x)
 #define idpf_msec_delay(x, y) rte_delay_us(1000 * (x))
 #define udelay(x) DELAY(x)
 #define msleep(x) DELAY(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #ifndef IDPF_DBG_TRACE
 #define IDPF_DBG_TRACE	  BIT_ULL(0)
diff --git a/drivers/net/nfp/nfdk/nfp_nfdk.h b/drivers/net/nfp/nfdk/nfp_nfdk.h
index 64c2b31308..b831e0d69e 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk.h
+++ b/drivers/net/nfp/nfdk/nfp_nfdk.h
@@ -168,8 +168,9 @@ static inline uint16_t
 nfp_net_nfdk_headlen_to_segs(uint16_t headlen)
 {
 	/* First descriptor fits less data, so adjust for that */
-	return DIV_ROUND_UP(headlen + NFDK_TX_MAX_DATA_PER_DESC - NFDK_TX_MAX_DATA_PER_HEAD,
-			NFDK_TX_MAX_DATA_PER_DESC);
+	return RTE_DIV_ROUND_UP(headlen + NFDK_TX_MAX_DATA_PER_DESC -
+				NFDK_TX_MAX_DATA_PER_HEAD,
+				NFDK_TX_MAX_DATA_PER_DESC);
 }
 
 /* Set TX CSUM offload flags in TX descriptor of nfdk */
diff --git a/drivers/net/nfp/nfdk/nfp_nfdk_dp.c b/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
index 15867ab62f..86b3c5b64a 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
+++ b/drivers/net/nfp/nfdk/nfp_nfdk_dp.c
@@ -103,7 +103,8 @@ nfp_net_nfdk_tx_maybe_close_block(struct nfp_net_txq *txq,
 	n_descs = nfp_net_nfdk_headlen_to_segs(pkt_temp->data_len);
 	while (pkt_temp->next != NULL) {
 		pkt_temp = pkt_temp->next;
-		n_descs += DIV_ROUND_UP(pkt_temp->data_len, NFDK_TX_MAX_DATA_PER_DESC);
+		n_descs += RTE_DIV_ROUND_UP(pkt_temp->data_len,
+					    NFDK_TX_MAX_DATA_PER_DESC);
 	}
 
 	if (unlikely(n_descs > NFDK_TX_DESC_GATHER_MAX))
diff --git a/drivers/net/nfp/nfpcore/nfp_nsp.c b/drivers/net/nfp/nfpcore/nfp_nsp.c
index 43c13baabe..bd02efcc4a 100644
--- a/drivers/net/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/nfp/nfpcore/nfp_nsp.c
@@ -542,7 +542,7 @@ nfp_nsp_command_buf_dma_sg(struct nfp_nsp *nsp,
 	struct nfp_nsp_dma_desc *descs;
 
 	chunk_size = RTE_BIT64(chunk_order);
-	nseg = DIV_ROUND_UP(max_size, chunk_size);
+	nseg = RTE_DIV_ROUND_UP(max_size, chunk_size);
 
 	/* Malloc memory */
 	total_len = sizeof(struct nfp_nsp_dma_buf) +
diff --git a/drivers/net/qede/base/bcm_osal.h b/drivers/net/qede/base/bcm_osal.h
index 357981f63d..a2f3bc838b 100644
--- a/drivers/net/qede/base/bcm_osal.h
+++ b/drivers/net/qede/base/bcm_osal.h
@@ -396,8 +396,6 @@ int qede_save_fw_dump(uint16_t port_id);
 
 /* Utility functions */
 
-#define RTE_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-#define DIV_ROUND_UP(size, to_what) RTE_DIV_ROUND_UP(size, to_what)
 #define RTE_ROUNDUP(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #define ROUNDUP(value, to_what) RTE_ROUNDUP((value), (to_what))
 
diff --git a/drivers/net/qede/base/ecore_chain.h b/drivers/net/qede/base/ecore_chain.h
index c69920be54..50b3196f02 100644
--- a/drivers/net/qede/base/ecore_chain.h
+++ b/drivers/net/qede/base/ecore_chain.h
@@ -157,7 +157,7 @@ struct ecore_chain {
 	UNUSABLE_ELEMS_PER_PAGE(elem_size, mode)))
 
 #define ECORE_CHAIN_PAGE_CNT(elem_cnt, elem_size, mode)		\
-	DIV_ROUND_UP(elem_cnt, USABLE_ELEMS_PER_PAGE(elem_size, mode))
+	RTE_DIV_ROUND_UP(elem_cnt, USABLE_ELEMS_PER_PAGE(elem_size, mode))
 
 #define is_chain_u16(p)	((p)->cnt_type == ECORE_CHAIN_CNT_TYPE_U16)
 #define is_chain_u32(p)	((p)->cnt_type == ECORE_CHAIN_CNT_TYPE_U32)
diff --git a/drivers/net/qede/base/ecore_cxt.c b/drivers/net/qede/base/ecore_cxt.c
index d3025724b6..f877d31ecc 100644
--- a/drivers/net/qede/base/ecore_cxt.c
+++ b/drivers/net/qede/base/ecore_cxt.c
@@ -341,7 +341,8 @@ static void ecore_ilt_cli_adv_line(struct ecore_hwfn *p_hwfn,
 		p_cli->first.val = *p_line;
 
 	p_cli->active = true;
-	*p_line += DIV_ROUND_UP(p_blk->total_size, p_blk->real_size_in_page);
+	*p_line += RTE_DIV_ROUND_UP(p_blk->total_size,
+				    p_blk->real_size_in_page);
 	p_cli->last.val = *p_line - 1;
 
 	DP_VERBOSE(p_hwfn, ECORE_MSG_ILT,
@@ -761,7 +762,7 @@ static enum _ecore_status_t ecore_cxt_src_t2_alloc(struct ecore_hwfn *p_hwfn)
 	/* use the same page size as the SRC ILT client */
 	psz = ILT_PAGE_IN_BYTES(p_src->p_size.val);
 	p_t2 = &p_mngr->src_t2;
-	p_t2->num_pages = DIV_ROUND_UP(total_size, psz);
+	p_t2->num_pages = RTE_DIV_ROUND_UP(total_size, psz);
 
 	/* allocate t2 */
 	p_t2->dma_mem = OSAL_ZALLOC(p_hwfn->p_dev, GFP_KERNEL,
@@ -877,7 +878,8 @@ ecore_ilt_blk_alloc(struct ecore_hwfn *p_hwfn,
 
 	sz_left = p_blk->total_size;
 	lines_to_skip = p_blk->dynamic_line_cnt;
-	lines = DIV_ROUND_UP(sz_left, p_blk->real_size_in_page) - lines_to_skip;
+	lines = RTE_DIV_ROUND_UP(sz_left, p_blk->real_size_in_page) -
+		lines_to_skip;
 	line = p_blk->start_line + start_line_offset -
 	       p_hwfn->p_cxt_mngr->pf_start_line;
 	first_skipped_line = line + p_blk->dynamic_line_offset;
@@ -1000,7 +1002,7 @@ __ecore_cid_map_alloc_single(struct ecore_hwfn *p_hwfn, u32 type,
 	if (!cid_count)
 		return ECORE_SUCCESS;
 
-	size = MAP_WORD_SIZE * DIV_ROUND_UP(cid_count, BITS_PER_MAP_WORD);
+	size = MAP_WORD_SIZE * RTE_DIV_ROUND_UP(cid_count, BITS_PER_MAP_WORD);
 	p_map->cid_map = OSAL_ZALLOC(p_hwfn->p_dev, GFP_KERNEL, size);
 	if (p_map->cid_map == OSAL_NULL)
 		return ECORE_NOMEM;
@@ -1217,8 +1219,8 @@ void ecore_cxt_mngr_setup(struct ecore_hwfn *p_hwfn)
 		p_cfg = &p_mngr->conn_cfg[type];
 		if (p_cfg->cid_count) {
 			p_map = &p_mngr->acquired[type];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   BITS_PER_MAP_WORD) *
+			len = RTE_DIV_ROUND_UP(p_map->max_count,
+					       BITS_PER_MAP_WORD) *
 			      MAP_WORD_SIZE;
 			OSAL_MEM_ZERO(p_map->cid_map, len);
 		}
@@ -1228,8 +1230,8 @@ void ecore_cxt_mngr_setup(struct ecore_hwfn *p_hwfn)
 
 		for (vf = 0; vf < max_num_vfs; vf++) {
 			p_map = &p_mngr->acquired_vf[type][vf];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   BITS_PER_MAP_WORD) *
+			len = RTE_DIV_ROUND_UP(p_map->max_count,
+					       BITS_PER_MAP_WORD) *
 			      MAP_WORD_SIZE;
 			OSAL_MEM_ZERO(p_map->cid_map, len);
 		}
@@ -2184,7 +2186,7 @@ static u16 ecore_blk_calculate_pages(struct ecore_ilt_cli_blk *p_blk)
 	if (p_blk->real_size_in_page == 0)
 		return 0;
 
-	return DIV_ROUND_UP(p_blk->total_size, p_blk->real_size_in_page);
+	return RTE_DIV_ROUND_UP(p_blk->total_size, p_blk->real_size_in_page);
 }
 
 u16 ecore_get_cdut_num_pf_init_pages(struct ecore_hwfn *p_hwfn)
diff --git a/drivers/net/qede/base/ecore_init_fw_funcs.c b/drivers/net/qede/base/ecore_init_fw_funcs.c
index 4e4d1dc374..e3a39d0958 100644
--- a/drivers/net/qede/base/ecore_init_fw_funcs.c
+++ b/drivers/net/qede/base/ecore_init_fw_funcs.c
@@ -24,9 +24,11 @@ static u16 task_region_offsets[1][NUM_OF_CONNECTION_TYPES] = {
 
 /* General constants */
 #define QM_PQ_MEM_4KB(pq_size) \
-	(pq_size ? DIV_ROUND_UP((pq_size + 1) * QM_PQ_ELEMENT_SIZE, 0x1000) : 0)
+	(pq_size \
+		? RTE_DIV_ROUND_UP((pq_size + 1) * QM_PQ_ELEMENT_SIZE, 0x1000) \
+		: 0)
 #define QM_PQ_SIZE_256B(pq_size) \
-	(pq_size ? DIV_ROUND_UP(pq_size, 0x100) - 1 : 0)
+	(pq_size ? RTE_DIV_ROUND_UP(pq_size, 0x100) - 1 : 0)
 #define QM_INVALID_PQ_ID		0xffff
 
 /* Max link speed (in Mbps) */
@@ -1313,10 +1315,10 @@ void ecore_init_brb_ram(struct ecore_hwfn *p_hwfn,
 	u32 active_port_blocks, reg_offset = 0;
 	u8 port, active_ports = 0;
 
-	tc_headroom_blocks = (u32)DIV_ROUND_UP(req->headroom_per_tc,
-					       BRB_BLOCK_SIZE);
-	min_pkt_size_blocks = (u32)DIV_ROUND_UP(req->min_pkt_size,
-						BRB_BLOCK_SIZE);
+	tc_headroom_blocks = (u32)RTE_DIV_ROUND_UP(req->headroom_per_tc,
+						   BRB_BLOCK_SIZE);
+	min_pkt_size_blocks = (u32)RTE_DIV_ROUND_UP(req->min_pkt_size,
+						    BRB_BLOCK_SIZE);
 	total_blocks = ECORE_IS_K2(p_hwfn->p_dev) ? BRB_TOTAL_RAM_BLOCKS_K2 :
 						    BRB_TOTAL_RAM_BLOCKS_BB;
 
@@ -1334,8 +1336,9 @@ void ecore_init_brb_ram(struct ecore_hwfn *p_hwfn,
 		u8 tc;
 
 		/* Calculate per-port sizes */
-		tc_guaranteed_blocks = (u32)DIV_ROUND_UP(req->guranteed_per_tc,
-							 BRB_BLOCK_SIZE);
+		tc_guaranteed_blocks =
+			(u32)RTE_DIV_ROUND_UP(req->guranteed_per_tc,
+					      BRB_BLOCK_SIZE);
 		port_blocks = req->num_active_tcs[port] ? active_port_blocks :
 							  0;
 		port_guaranteed_blocks = req->num_active_tcs[port] *
@@ -2059,7 +2062,7 @@ void ecore_enable_context_validation(struct ecore_hwfn *p_hwfn,
 	ecore_wr(p_hwfn, p_ptt, CDU_REG_TCFC_CTX_VALID0, ctx_validation);
 }
 
-#define PHYS_ADDR_DWORDS        DIV_ROUND_UP(sizeof(dma_addr_t), 4)
+#define PHYS_ADDR_DWORDS        RTE_DIV_ROUND_UP(sizeof(dma_addr_t), 4)
 #define OVERLAY_HDR_SIZE_DWORDS (sizeof(struct fw_overlay_buf_hdr) / 4)
 
 static u32 ecore_get_overlay_addr_ram_addr(struct ecore_hwfn *p_hwfn,
diff --git a/drivers/net/qede/base/ecore_mcp.c b/drivers/net/qede/base/ecore_mcp.c
index ec83b244e6..07ba41e1a8 100644
--- a/drivers/net/qede/base/ecore_mcp.c
+++ b/drivers/net/qede/base/ecore_mcp.c
@@ -713,7 +713,7 @@ ecore_mcp_cmd_and_union(struct ecore_hwfn *p_hwfn,
 	}
 #endif
 	if (ECORE_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP)) {
-		max_retries = DIV_ROUND_UP(max_retries, 1000);
+		max_retries = RTE_DIV_ROUND_UP(max_retries, 1000);
 		usecs *= 1000;
 	}
 
@@ -4243,8 +4243,8 @@ ecore_mcp_resc_lock(struct ecore_hwfn *p_hwfn, struct ecore_ptt *p_ptt,
 		if (retry_cnt) {
 			if (p_params->sleep_b4_retry) {
 				u16 retry_interval_in_ms =
-					DIV_ROUND_UP(p_params->retry_interval,
-						     1000);
+					RTE_DIV_ROUND_UP(p_params->retry_interval,
+							 1000);
 
 				OSAL_MSLEEP(retry_interval_in_ms);
 			} else {
diff --git a/drivers/net/qede/qede_debug.c b/drivers/net/qede/qede_debug.c
index 1d3147b724..c4cf40b15d 100644
--- a/drivers/net/qede/qede_debug.c
+++ b/drivers/net/qede/qede_debug.c
@@ -332,7 +332,7 @@ struct split_type_defs {
 
 #define BYTES_IN_DWORD			sizeof(u32)
 /* In the macros below, size and offset are specified in bits */
-#define CEIL_DWORDS(size)		DIV_ROUND_UP(size, 32)
+#define CEIL_DWORDS(size)		RTE_DIV_ROUND_UP(size, 32)
 #define FIELD_BIT_OFFSET(type, field)	type ## _ ## field ## _ ## OFFSET
 #define FIELD_BIT_SIZE(type, field)	type ## _ ## field ## _ ## SIZE
 #define FIELD_DWORD_OFFSET(type, field) \
@@ -3060,7 +3060,7 @@ static u32 qed_grc_dump_big_ram(struct ecore_hwfn *p_hwfn,
 		return offset + ram_size;
 
 	/* Dump Big RAM */
-	for (i = 0; i < DIV_ROUND_UP(ram_size, BRB_REG_BIG_RAM_DATA_SIZE);
+	for (i = 0; i < RTE_DIV_ROUND_UP(ram_size, BRB_REG_BIG_RAM_DATA_SIZE);
 	     i++) {
 		u32 addr, len;
 
@@ -4161,8 +4161,8 @@ static enum dbg_status qed_mcp_trace_dump(struct ecore_hwfn *p_hwfn,
 
 	/* Find trace data size */
 	trace_data_size_dwords =
-	    DIV_ROUND_UP(trace_data_size_bytes + sizeof(struct mcp_trace),
-			 BYTES_IN_DWORD);
+	    RTE_DIV_ROUND_UP(trace_data_size_bytes + sizeof(struct mcp_trace),
+			     BYTES_IN_DWORD);
 
 	/* Dump trace data section header and param */
 	offset += qed_dump_section_hdr(dump_buf + offset,
@@ -4817,10 +4817,10 @@ static u32 qed_ilt_dump(struct ecore_hwfn *p_hwfn,
 		offset += num_pages * PAGE_MEM_DESC_SIZE_DWORDS;
 	}
 
-	valid_conn_pf_pages = DIV_ROUND_UP(valid_conn_pf_cids,
-					   num_cids_per_page);
-	valid_conn_vf_pages = DIV_ROUND_UP(valid_conn_vf_cids,
-					   num_cids_per_page);
+	valid_conn_pf_pages = RTE_DIV_ROUND_UP(valid_conn_pf_cids,
+					       num_cids_per_page);
+	valid_conn_vf_pages = RTE_DIV_ROUND_UP(valid_conn_vf_cids,
+					       num_cids_per_page);
 
 	/* Dump ILT pages IDs */
 	offset += qed_ilt_dump_pages_section(p_hwfn,
diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
index 58dcb40f90..b0e7906fab 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -53,10 +53,9 @@ typedef uint64_t u64;
 #define cpu_to_le32(v)	rte_cpu_to_le_32((u32)(v))
 #endif
 
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d)      (((n) + (d) - 1) / (d))
+#ifndef BITS_TO_LONGS
 #define BITS_PER_BYTE           (8)
-#define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+#define BITS_TO_LONGS(nr)       RTE_DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
 #define fls(n)	rte_fls_u32(n)
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 81e8c6ba44..143cd11ffe 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1165,7 +1165,7 @@ rnp_calc_pkt_desc(struct rte_mbuf *tx_pkt)
 	uint16_t count = 0;
 
 	while (txd != NULL) {
-		count += DIV_ROUND_UP(txd->data_len, RNP_MAX_TSO_SEG_LEN);
+		count += RTE_DIV_ROUND_UP(txd->data_len, RNP_MAX_TSO_SEG_LEN);
 		txd = txd->next;
 	}
 
diff --git a/drivers/raw/ifpga/base/opae_osdep.h b/drivers/raw/ifpga/base/opae_osdep.h
index e35a21c80e..b0045a36a0 100644
--- a/drivers/raw/ifpga/base/opae_osdep.h
+++ b/drivers/raw/ifpga/base/opae_osdep.h
@@ -71,10 +71,9 @@ struct uuid {
 } while (0)
 #endif
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define udelay(x) opae_udelay(x)
 #define msleep(x) opae_udelay(1000 * (x))
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
 
 #define time_after(a, b)	((long)((b) - (a)) < 0)
 #define time_before(a, b)	time_after(b, a)
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 79d2a0ab93..168b0fe592 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -717,6 +717,11 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 		(ceil - (v)) > ((v) - floor) ? floor : ceil;	\
 	})
 
+/**
+ * Macro to divide dividend n by divisor d, rounding up if d does not divide n.
+ */
+#define RTE_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
 /**
  * Checks if a pointer is aligned to a given power-of-two value
  *
-- 
2.55.0.691.gc56d675ccc-goog

