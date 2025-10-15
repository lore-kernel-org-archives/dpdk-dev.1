Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C94CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:11:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C17140E44;
	Wed, 15 Oct 2025 14:11:49 +0200 (CEST)
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
 by mails.dpdk.org (Postfix) with ESMTP id B942940A6C
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530307; x=1792066307;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=L6Q8W6tMRiz+t3hOM4QqQwC2fHoxsy84U6poWdw+vWo=;
 b=nowSjpuwSCArl0jhRDUynJcIdrkhU84h9BF2MJeqG7fN8nEQqel5F8qC
 Y+ACd61dFatd+7EpeQvzF9+ItwSWu7kcstRbBebj2tQW6wHBN2UOWyESt
 9d79j/3qQfC2Bqq4TEITif3QWtjbkfVn1AxDt2sh0zENwT1ihuIPpSysi
 1SY7B9bPSUO7UIynMjaJVhTiPZxqle4y6bZkz0kLRTRufnzD0JNH6lqNF
 /CTrtQ6fXdGwbG91C6aThFaHDH4s0UTXBgserHpBxkEH6xcmaCuPM6bC2
 ziv9vfSkpmNSjlKSPw8s44qwWvwWQkrbhEevhYpRuQO31bf+QNgLCGnr7 A==;
X-CSE-ConnectionGUID: tSghjOj5TGq8p70bqV8yYg==
X-CSE-MsgGUID: KoBpZoWrQYuXMNioTeaJvw==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4931699"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:11:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:16148]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.122:2525]
 with esmtp (Farcaster)
 id 3b5eddb4-773b-49ad-ab55-12b1d6447ce5; Wed, 15 Oct 2025 12:11:46 +0000 (UTC)
X-Farcaster-Flow-ID: 3b5eddb4-773b-49ad-ab55-12b1d6447ce5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:11:42 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:11:41 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 14/20] net/ena/base: style changes in hal
Date: Wed, 15 Oct 2025 15:11:04 +0300
Message-ID: <20251015121104.2877-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
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
index 3c7860ffb0..4ba8211c2f 100644
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
 
@@ -846,12 +846,13 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
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
 
@@ -926,8 +927,8 @@ static int ena_com_destroy_io_sq(struct ena_com_dev *ena_dev,
 				 struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_aq_destroy_sq_cmd destroy_cmd;
 	struct ena_admin_acq_destroy_sq_resp_desc destroy_resp;
+	struct ena_admin_aq_destroy_sq_cmd destroy_cmd;
 	u8 direction;
 	int ret;
 
@@ -999,8 +1000,8 @@ static void ena_com_io_queue_free(struct ena_com_dev *ena_dev,
 static int wait_for_reset_state(struct ena_com_dev *ena_dev, u32 timeout,
 				u16 exp_state)
 {
-	u32 val, exp = 0;
 	ena_time_t timeout_stamp;
+	u32 val, exp = 0;
 
 	/* Convert timeout from resolution of 100ms to us resolution. */
 	timeout_stamp = ENA_GET_SYSTEM_TIMEOUT(100 * 1000 * timeout);
@@ -1042,6 +1043,7 @@ bool ena_com_indirection_table_config_supported(struct ena_com_dev *ena_dev)
 	return ena_com_check_supported_feature_id(ena_dev,
 						  ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG);
 }
+
 static int ena_com_get_feature_ex(struct ena_com_dev *ena_dev,
 				  struct ena_admin_get_feat_resp *get_resp,
 				  enum ena_admin_aq_feature_id feature_id,
@@ -1324,8 +1326,10 @@ static int ena_com_indirect_table_allocate(struct ena_com_dev *ena_dev)
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
@@ -1346,8 +1350,8 @@ static int ena_com_create_io_sq(struct ena_com_dev *ena_dev,
 				struct ena_com_io_sq *io_sq, u16 cq_idx)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_aq_create_sq_cmd create_cmd;
 	struct ena_admin_acq_create_sq_resp_desc cmd_completion;
+	struct ena_admin_aq_create_sq_cmd create_cmd;
 	u8 direction;
 	int ret;
 
@@ -1502,8 +1506,8 @@ int ena_com_create_io_cq(struct ena_com_dev *ena_dev,
 			 struct ena_com_io_cq *io_cq)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_aq_create_cq_cmd create_cmd;
 	struct ena_admin_acq_create_cq_resp_desc cmd_completion;
+	struct ena_admin_aq_create_cq_cmd create_cmd;
 	int ret;
 
 	memset(&create_cmd, 0x0, sizeof(create_cmd));
@@ -1606,8 +1610,8 @@ int ena_com_destroy_io_cq(struct ena_com_dev *ena_dev,
 			  struct ena_com_io_cq *io_cq)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
-	struct ena_admin_aq_destroy_cq_cmd destroy_cmd;
 	struct ena_admin_acq_destroy_cq_resp_desc destroy_resp;
+	struct ena_admin_aq_destroy_cq_cmd destroy_cmd;
 	int ret;
 
 	memset(&destroy_cmd, 0x0, sizeof(destroy_cmd));
@@ -1657,9 +1661,9 @@ void ena_com_admin_aenq_enable(struct ena_com_dev *ena_dev)
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
@@ -1723,9 +1727,9 @@ int ena_com_get_dma_width(struct ena_com_dev *ena_dev)
 
 int ena_com_validate_version(struct ena_com_dev *ena_dev)
 {
-	u32 ver;
-	u32 ctrl_ver;
 	u32 ctrl_ver_masked;
+	u32 ctrl_ver;
+	u32 ver;
 
 	/* Make sure the ENA version and the controller version are at least
 	 * as the driver expects
@@ -2529,11 +2533,11 @@ static ena_aenq_handler ena_com_get_specific_aenq_cb(struct ena_com_dev *ena_dev
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
@@ -2632,7 +2636,6 @@ bool ena_com_aenq_has_keep_alive(struct ena_com_dev *ena_dev)
 	return false;
 }
 
-
 int ena_com_dev_reset(struct ena_com_dev *ena_dev,
 		      enum ena_regs_reset_reason_types reset_reason)
 {
@@ -2821,8 +2824,8 @@ int ena_com_get_customer_metrics(struct ena_com_dev *ena_dev, char *buffer, u32
 int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 {
 	struct ena_com_admin_queue *admin_queue;
-	struct ena_admin_set_feat_cmd cmd;
 	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_MTU)) {
@@ -2857,10 +2860,10 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
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
@@ -2968,8 +2971,8 @@ int ena_com_fill_hash_function(struct ena_com_dev *ena_dev,
 int ena_com_get_hash_function(struct ena_com_dev *ena_dev,
 			      enum ena_admin_hash_functions *func)
 {
-	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_get_feat_resp get_resp;
+	struct ena_rss *rss = &ena_dev->rss;
 	int rc;
 
 	if (unlikely(!func))
@@ -3008,8 +3011,8 @@ int ena_com_get_hash_ctrl(struct ena_com_dev *ena_dev,
 			  enum ena_admin_flow_hash_proto proto,
 			  u16 *fields)
 {
-	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_get_feat_resp get_resp;
+	struct ena_rss *rss = &ena_dev->rss;
 	int rc;
 
 	rc = ena_com_get_feature_ex(ena_dev, &get_resp,
@@ -3028,10 +3031,10 @@ int ena_com_get_hash_ctrl(struct ena_com_dev *ena_dev,
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
@@ -3041,6 +3044,8 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 		return ENA_COM_UNSUPPORTED;
 	}
 
+	hash_ctrl = rss->hash_ctrl;
+
 	memset(&cmd, 0x0, sizeof(cmd));
 
 	cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
@@ -3073,9 +3078,8 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 
 int ena_com_set_default_hash_ctrl(struct ena_com_dev *ena_dev)
 {
+	struct ena_admin_feature_rss_hash_control *hash_ctrl;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_feature_rss_hash_control *hash_ctrl =
-		rss->hash_ctrl;
 	u16 available_fields = 0;
 	int rc, i;
 
@@ -3084,6 +3088,8 @@ int ena_com_set_default_hash_ctrl(struct ena_com_dev *ena_dev)
 	if (unlikely(rc))
 		return rc;
 
+	hash_ctrl = rss->hash_ctrl;
+
 	hash_ctrl->selected_fields[ENA_ADMIN_RSS_TCP4].fields =
 		ENA_ADMIN_RSS_L3_SA | ENA_ADMIN_RSS_L3_DA |
 		ENA_ADMIN_RSS_L4_DP | ENA_ADMIN_RSS_L4_SP;
@@ -3136,8 +3142,8 @@ int ena_com_fill_hash_ctrl(struct ena_com_dev *ena_dev,
 			   enum ena_admin_flow_hash_proto proto,
 			   u16 hash_fields)
 {
+	struct ena_admin_feature_rss_hash_control *hash_ctrl;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_feature_rss_hash_control *hash_ctrl = rss->hash_ctrl;
 	u16 supported_fields;
 	int rc;
 
@@ -3151,6 +3157,8 @@ int ena_com_fill_hash_ctrl(struct ena_com_dev *ena_dev,
 	if (unlikely(rc))
 		return rc;
 
+	hash_ctrl = rss->hash_ctrl;
+
 	/* Make sure all the fields are supported */
 	supported_fields = hash_ctrl->supported_fields[proto].fields;
 	if ((hash_fields & supported_fields) != hash_fields) {
@@ -3189,8 +3197,8 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_admin_queue *admin_queue = &ena_dev->admin_queue;
 	struct ena_rss *rss = &ena_dev->rss;
-	struct ena_admin_set_feat_cmd cmd;
 	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev,
@@ -3240,8 +3248,8 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 
 int ena_com_indirect_table_get(struct ena_com_dev *ena_dev, u32 *ind_tbl)
 {
-	struct ena_rss *rss = &ena_dev->rss;
 	struct ena_admin_get_feat_resp get_resp;
+	struct ena_rss *rss = &ena_dev->rss;
 	u32 tbl_size;
 	int i, rc;
 
@@ -3414,9 +3422,8 @@ int ena_com_set_host_attributes(struct ena_com_dev *ena_dev)
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

