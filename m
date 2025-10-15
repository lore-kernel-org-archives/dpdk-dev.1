Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D361CCD190
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57449402EB;
	Wed, 15 Oct 2025 09:15:43 +0200 (CEST)
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.83.148.184]) by mails.dpdk.org (Postfix) with ESMTP id C4B27402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:15:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512541; x=1792048541;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=5MbYyvTtVdDvgX+ThZEUyYlcY/Rqu11qeXckc/JOfT8=;
 b=MVH25fxlfePsYFdRpWPCfMufjZ/aoNKDzEkcGu9hGgUE6EeSu1zUznRl
 pCroYWwZXXd/uue4OVatPuIZGxY8xU2TK1vIk6yrvS1fpaiPAzmq3aPtK
 PijnjAe2lPYSl+5ldtj4Lc8XKF9S/gF53tMn34Lxkisg6tidKxKwisP0s
 hWCiWm5ahlHuYiux7w9JRUcIC/vEXFErSKrrxMzg5Dy2gePZk3n56/+Zv
 8DErNZNIsLfh0CfCKl1n11w0qmjBB9JT5o/HNtriokgh6ZXlk+zHBnHq7
 mc48yoLKaZnvho901wcRtIstFEwYFS7Ef3hX78BSDa0KQC731YaODwJ/J Q==;
X-CSE-ConnectionGUID: 6WyL1JGYQTOFISw3f1Qerg==
X-CSE-MsgGUID: N4eZu/l5TQafVzCXp1zXvA==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4717145"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:15:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:14339]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.112:2525]
 with esmtp (Farcaster)
 id 9f25b1ca-69f8-4677-ac56-191999179432; Wed, 15 Oct 2025 07:15:39 +0000 (UTC)
X-Farcaster-Flow-ID: 9f25b1ca-69f8-4677-ac56-191999179432
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:15:33 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:15:32 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 15/21] net/ena/base: style changes in hal
Date: Wed, 15 Oct 2025 10:15:21 +0300
Message-ID: <20251015071521.992-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

1. Change the variable declaration order according to
   Reverse Christmas Tree notation. This also includes
   assigning variables after and not during declaration
   if there's a dependency and RCT notation is broken.
2. Remove unnecessary spaces between variable declarations.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c     | 71 ++++++++++++++++--------------
 drivers/net/ena/base/ena_eth_com.c |  4 +-
 2 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index e7033cf327..aba52cabae 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -283,8 +283,8 @@ static struct ena_comp_ctx *__ena_com_submit_admin_cmd(struct ena_com_admin_queu
 
 static int ena_com_init_comp_ctxt(struct ena_com_admin_queue *admin_queue)
 {
-	struct ena_com_dev *ena_dev = admin_queue->ena_dev;
 	size_t size = admin_queue->q_depth * sizeof(struct ena_comp_ctx);
+	struct ena_com_dev *ena_dev = admin_queue->ena_dev;
 	struct ena_comp_ctx *comp_ctx;
 	u16 i;
 
@@ -867,12 +867,13 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
  */
 static u32 ena_com_reg_bar_read32(struct ena_com_dev *ena_dev, u16 offset)
 {
+	volatile struct ena_admin_ena_mmio_req_read_less_resp *read_resp;
 	struct ena_com_mmio_read *mmio_read = &ena_dev->mmio_read;
-	volatile struct ena_admin_ena_mmio_req_read_less_resp *read_resp =
-		mmio_read->read_resp;
+	u32 timeout = mmio_read->reg_read_to;
 	u32 mmio_read_reg, ret, i;
 	unsigned long flags = 0;
-	u32 timeout = mmio_read->reg_read_to;
+
+	read_resp = mmio_read->read_resp;
 
 	ENA_MIGHT_SLEEP();
 
@@ -947,8 +948,8 @@ static int ena_com_destroy_io_sq(struct ena_com_dev *ena_dev,
 				 struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_aq_destroy_sq_cmd destroy_cmd;
 	struct ena_admin_acq_destroy_sq_resp_desc destroy_resp;
+	struct ena_admin_aq_destroy_sq_cmd destroy_cmd;
 	u8 direction;
 	int ret;
 
@@ -1020,8 +1021,8 @@ static void ena_com_io_queue_free(struct ena_com_dev *ena_dev,
 static int wait_for_reset_state(struct ena_com_dev *ena_dev, u32 timeout,
 				u16 exp_state)
 {
-	u32 val, exp = 0;
 	ena_time_t timeout_stamp;
+	u32 val, exp = 0;
 
 	/* Convert timeout from resolution of 100ms to us resolution. */
 	timeout_stamp = ENA_GET_SYSTEM_TIMEOUT(100 * 1000 * timeout);
@@ -1063,6 +1064,7 @@ bool ena_com_indirection_table_config_supported(struct ena_com_dev *ena_dev)
 	return ena_com_check_supported_feature_id(ena_dev,
 						  ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG);
 }
+
 static int ena_com_get_feature_ex(struct ena_com_dev *ena_dev,
 				  struct ena_admin_get_feat_resp *get_resp,
 				  enum ena_admin_aq_feature_id feature_id,
@@ -1345,8 +1347,10 @@ static int ena_com_indirect_table_allocate(struct ena_com_dev *ena_dev)
 static void ena_com_indirect_table_destroy(struct ena_com_dev *ena_dev)
 {
 	struct ena_rss *rss = &ena_dev->rss;
-	size_t tbl_size = (1ULL << rss->tbl_log_size) *
-		sizeof(struct ena_admin_rss_ind_table_entry);
+	size_t tbl_size;
+
+	tbl_size = (1ULL << rss->tbl_log_size) *
+		   sizeof(struct ena_admin_rss_ind_table_entry);
 
 	if (rss->rss_ind_tbl)
 		ENA_MEM_FREE_COHERENT(ena_dev->dmadev,
@@ -1367,8 +1371,8 @@ static int ena_com_create_io_sq(struct ena_com_dev *ena_dev,
 				struct ena_com_io_sq *io_sq, u16 cq_idx)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_aq_create_sq_cmd create_cmd;
 	struct ena_admin_acq_create_sq_resp_desc cmd_completion;
+	struct ena_admin_aq_create_sq_cmd create_cmd;
 	u8 direction;
 	int ret;
 
@@ -1523,8 +1527,8 @@ int ena_com_create_io_cq(struct ena_com_dev *ena_dev,
 			 struct ena_com_io_cq *io_cq)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_aq_create_cq_cmd create_cmd;
 	struct ena_admin_acq_create_cq_resp_desc cmd_completion;
+	struct ena_admin_aq_create_cq_cmd create_cmd;
 	int ret;
 
 	memset(&create_cmd, 0x0, sizeof(create_cmd));
@@ -1627,8 +1631,8 @@ int ena_com_destroy_io_cq(struct ena_com_dev *ena_dev,
 			  struct ena_com_io_cq *io_cq)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_aq_destroy_cq_cmd destroy_cmd;
 	struct ena_admin_acq_destroy_cq_resp_desc destroy_resp;
+	struct ena_admin_aq_destroy_cq_cmd destroy_cmd;
 	int ret;
 
 	memset(&destroy_cmd, 0x0, sizeof(destroy_cmd));
@@ -1678,9 +1682,9 @@ void ena_com_admin_aenq_enable(struct ena_com_dev *ena_dev)
 int ena_com_set_aenq_config(struct ena_com_dev *ena_dev, u32 groups_flag)
 {
 	struct ena_com_admin_queue *admin_queue;
-	struct ena_admin_set_feat_cmd cmd;
-	struct ena_admin_set_feat_resp resp;
 	struct ena_admin_get_feat_resp get_resp;
+	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
 	ret = ena_com_get_feature(ena_dev, &get_resp, ENA_ADMIN_AENQ_CONFIG, 0);
@@ -1744,9 +1748,9 @@ int ena_com_get_dma_width(struct ena_com_dev *ena_dev)
 
 int ena_com_validate_version(struct ena_com_dev *ena_dev)
 {
-	u32 ver;
-	u32 ctrl_ver;
 	u32 ctrl_ver_masked;
+	u32 ctrl_ver;
+	u32 ver;
 
 	/* Make sure the ENA version and the controller version are at least
 	 * as the driver expects
@@ -2551,11 +2555,11 @@ static ena_aenq_handler ena_com_get_specific_aenq_cb(struct ena_com_dev *ena_dev
  */
 void ena_com_aenq_intr_handler(struct ena_com_dev *ena_dev, void *data)
 {
-	struct ena_admin_aenq_entry *aenq_e;
 	struct ena_admin_aenq_common_desc *aenq_common;
 	struct ena_com_aenq *aenq  = &ena_dev->aenq;
-	ena_aenq_handler handler_cb;
+	struct ena_admin_aenq_entry *aenq_e;
 	u16 masked_head, processed = 0;
+	ena_aenq_handler handler_cb;
 	u8 phase;
 
 	masked_head = aenq->head & (aenq->q_depth - 1);
@@ -2654,7 +2658,6 @@ bool ena_com_aenq_has_keep_alive(struct ena_com_dev *ena_dev)
 	return false;
 }
 
-
 int ena_com_dev_reset(struct ena_com_dev *ena_dev,
 		      enum ena_regs_reset_reason_types reset_reason)
 {
@@ -2843,8 +2846,8 @@ int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32
 int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 {
 	struct ena_com_admin_queue *admin_queue;
-	struct ena_admin_set_feat_cmd cmd;
 	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_MTU)) {
@@ -2879,10 +2882,10 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
+	struct ena_admin_get_feat_resp get_resp;
+	struct ena_admin_set_feat_resp resp;
 	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_set_feat_cmd cmd;
-	struct ena_admin_set_feat_resp resp;
-	struct ena_admin_get_feat_resp get_resp;
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev,
@@ -2990,8 +2993,8 @@ int ena_com_fill_hash_function(struct ena_com_dev *ena_dev,
 int ena_com_get_hash_function(struct ena_com_dev *ena_dev,
 			      enum ena_admin_hash_functions *func)
 {
-	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_get_feat_resp get_resp;
+	struct ena_rss *rss = &ena_dev->rss;
 	int rc;
 
 	if (unlikely(!func))
@@ -3030,8 +3033,8 @@ int ena_com_get_hash_ctrl(struct ena_com_dev *ena_dev,
 			  enum ena_admin_flow_hash_proto proto,
 			  u16 *fields)
 {
-	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_get_feat_resp get_resp;
+	struct ena_rss *rss = &ena_dev->rss;
 	int rc;
 
 	rc = ena_com_get_feature_ex(ena_dev, &get_resp,
@@ -3050,10 +3053,10 @@ int ena_com_get_hash_ctrl(struct ena_com_dev *ena_dev,
 int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
+	struct ena_admin_feature_rss_hash_control *hash_ctrl;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_feature_rss_hash_control *hash_ctrl = rss->hash_ctrl;
-	struct ena_admin_set_feat_cmd cmd;
 	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev,
@@ -3063,6 +3066,8 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 		return ENA_COM_UNSUPPORTED;
 	}
 
+	hash_ctrl = rss->hash_ctrl;
+
 	memset(&cmd, 0x0, sizeof(cmd));
 
 	cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
@@ -3095,9 +3100,8 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 
 int ena_com_set_default_hash_ctrl(struct ena_com_dev *ena_dev)
 {
+	struct ena_admin_feature_rss_hash_control *hash_ctrl;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_feature_rss_hash_control *hash_ctrl =
-		rss->hash_ctrl;
 	u16 available_fields = 0;
 	int rc, i;
 
@@ -3106,6 +3110,8 @@ int ena_com_set_default_hash_ctrl(struct ena_com_dev *ena_dev)
 	if (unlikely(rc))
 		return rc;
 
+	hash_ctrl = rss->hash_ctrl;
+
 	hash_ctrl->selected_fields[ENA_ADMIN_RSS_TCP4].fields =
 		ENA_ADMIN_RSS_L3_SA | ENA_ADMIN_RSS_L3_DA |
 		ENA_ADMIN_RSS_L4_DP | ENA_ADMIN_RSS_L4_SP;
@@ -3158,8 +3164,8 @@ int ena_com_fill_hash_ctrl(struct ena_com_dev *ena_dev,
 			   enum ena_admin_flow_hash_proto proto,
 			   u16 hash_fields)
 {
+	struct ena_admin_feature_rss_hash_control *hash_ctrl;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_feature_rss_hash_control *hash_ctrl = rss->hash_ctrl;
 	u16 supported_fields;
 	int rc;
 
@@ -3173,6 +3179,8 @@ int ena_com_fill_hash_ctrl(struct ena_com_dev *ena_dev,
 	if (unlikely(rc))
 		return rc;
 
+	hash_ctrl = rss->hash_ctrl;
+
 	/* Make sure all the fields are supported */
 	supported_fields = hash_ctrl->supported_fields[proto].fields;
 	if ((hash_fields & supported_fields) != hash_fields) {
@@ -3211,8 +3219,8 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_set_feat_cmd cmd;
 	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev,
@@ -3262,8 +3270,8 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 
 int ena_com_indirect_table_get(struct ena_com_dev *ena_dev, u32 *ind_tbl)
 {
-	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_get_feat_resp get_resp;
+	struct ena_rss *rss = &ena_dev->rss;
 	u32 tbl_size;
 	int i, rc;
 
@@ -3436,9 +3444,8 @@ int ena_com_set_host_attributes(struct ena_com_dev *ena_dev)
 {
 	struct ena_host_attribute *host_attr = &ena_dev->host_attr;
 	struct ena_com_admin_queue *admin_queue;
-	struct ena_admin_set_feat_cmd cmd;
 	struct ena_admin_set_feat_resp resp;
-
+	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
 	/* Host attribute config is called before ena_com_get_dev_attr_feat
diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index c1e3c55f82..653df389c4 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -487,15 +487,15 @@ int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
 		       struct ena_com_tx_ctx *ena_tx_ctx,
 		       int *nb_hw_desc)
 {
-	struct ena_eth_io_tx_desc *desc = NULL;
 	struct ena_com_buf *ena_bufs = ena_tx_ctx->ena_bufs;
 	void *buffer_to_push = ena_tx_ctx->push_header;
 	u16 header_len = ena_tx_ctx->header_len;
+	struct ena_eth_io_tx_desc *desc = NULL;
 	u16 num_bufs = ena_tx_ctx->num_bufs;
 	u16 start_tail = io_sq->tail;
-	int i, rc;
 	bool have_meta;
 	u64 addr_hi;
+	int i, rc;
 
 	ENA_WARN(io_sq->direction != ENA_COM_IO_QUEUE_DIRECTION_TX,
 		 ena_com_io_sq_to_ena_dev(io_sq), "wrong Q type");
-- 
2.17.1

