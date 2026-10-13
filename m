Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99964CC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:10:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C790540682;
	Tue, 13 Oct 2026 17:10:48 +0200 (CEST)
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [34.218.115.239])
 by mails.dpdk.org (Postfix) with ESMTP id 5328E40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904246; x=1823440246;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=XuVMStfgkTKlPsd6qiKTIOdDjD3FmUeTOIo5UvRNbrQ=;
 b=lK+QaYl5kpSaY9p/v9OtKn0nnGc/y3VVYgzNy5dc4CQ+LHCnFBZIM8HV
 4w7+x6r8EMK6JIMohBlhd4icHt+LWnTbRIiRIZYwmtVsZkNL4Mm14J0h5
 XoTnNVr4K4MMctJAyApbjVnZ5jTD3UEksNtVJURm4muOY+D/18pFlQyAB
 KENYtqe1+8H0cvl81/SkIaaJ6+C2IIgnrZ6Yq4QfMfmbYGKaLRbMXeaLs
 8IFa0q3bTzHQXl0ISfybtGZgF6GlJNNrZpdmdm1vGhSkyoVo/rhvwVWe8
 MFmKPgDe2Ux/19d6iAQhe8DlFgp5gAHiRoEyETzn/jYrcOAXxcpdjowLW w==;
X-CSE-ConnectionGUID: KFv/+b9ORZaruohcKj7yJA==
X-CSE-MsgGUID: f+NHgAvURy+v1bULzx966g==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="30917419"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:10:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:26134]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.46:2525]
 with esmtp (Farcaster)
 id ff4452cc-cf81-49a1-bfc3-2eb14f4c675c; Tue, 13 Oct 2026 15:10:42 +0000 (UTC)
X-Farcaster-Flow-ID: ff4452cc-cf81-49a1-bfc3-2eb14f4c675c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:10:42 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:10:41 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 09/13] net/ena/base: split LLQ info into datapath and config
Date: Tue, 13 Oct 2026 18:10:27 +0300
Message-ID: <20261013151027.9678-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
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

struct ena_com_io_sq embeds the full struct ena_com_llq_info, although
the Tx datapath reads only a small subset of its fields. The remaining
members are consumed exclusively during device configuration.

Split struct ena_com_llq_info into struct ena_com_llq_info_common,
holding the fields read on the datapath (desc_list_entry_size,
descs_num_before_header, descs_per_entry, max_entries_in_tx_burst and
disable_meta_caching), and the configuration-only members, which remain
in the original structure.

Introduce struct ena_com_llq_info_runtime, comprising the common fields
and entries_in_tx_burst_left, and embed it in struct ena_com_io_sq in
place of the full structure.

No functional change.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.c     | 66 ++++++++++++++++--------------
 drivers/net/ena/base/ena_com.h     | 20 ++++++---
 drivers/net/ena/base/ena_eth_com.c | 18 ++++----
 drivers/net/ena/base/ena_eth_com.h | 14 +++----
 4 files changed, 66 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 268c04f617..7ec36b8814 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -367,7 +367,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 	} else {
 		/* Allocate bounce buffers */
 		io_sq->bounce_buf_ctrl.buffer_size =
-			ena_dev->llq_info.desc_list_entry_size;
+			ena_dev->llq_info.common.desc_list_entry_size;
 		io_sq->bounce_buf_ctrl.buffers_num =
 			ENA_COM_BOUNCE_BUFFER_CNTRL_CNT;
 		io_sq->bounce_buf_ctrl.next_to_use = 0;
@@ -387,20 +387,20 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			return ENA_COM_NO_MEM;
 		}
 
-		memcpy(&io_sq->llq_info, &ena_dev->llq_info,
-		       sizeof(io_sq->llq_info));
+		memcpy(&io_sq->llq_runtime.common, &ena_dev->llq_info.common,
+		       sizeof(io_sq->llq_runtime.common));
 
 		/* Initiate the first bounce buffer */
 		io_sq->llq_buf_ctrl.curr_llq_entry =
 			ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
 		memset(io_sq->llq_buf_ctrl.curr_llq_entry,
-		       0x0, io_sq->llq_info.desc_list_entry_size);
+		       0x0, io_sq->llq_runtime.common.desc_list_entry_size);
 		io_sq->llq_buf_ctrl.descs_left_in_line =
-			io_sq->llq_info.descs_num_before_header;
+			io_sq->llq_runtime.common.descs_num_before_header;
 
-		if (io_sq->llq_info.max_entries_in_tx_burst > 0)
-			io_sq->entries_in_tx_burst_left =
-				io_sq->llq_info.max_entries_in_tx_burst;
+		if (io_sq->llq_runtime.common.max_entries_in_tx_burst > 0)
+			io_sq->llq_runtime.entries_in_tx_burst_left =
+				io_sq->llq_runtime.common.max_entries_in_tx_burst;
 	}
 
 	io_sq->tail = 0;
@@ -775,7 +775,7 @@ static int ena_com_set_llq(struct ena_com_dev *ena_dev)
 
 	cmd.u.llq.header_location_ctrl_enabled = llq_info->header_location_ctrl;
 	cmd.u.llq.entry_size_ctrl_enabled = llq_info->desc_list_entry_size_ctrl;
-	cmd.u.llq.desc_num_before_header_enabled = llq_info->descs_num_before_header;
+	cmd.u.llq.desc_num_before_header_enabled = llq_info->common.descs_num_before_header;
 	cmd.u.llq.descriptors_stride_ctrl_enabled = llq_info->desc_stride_ctrl;
 
 	cmd.u.llq.accel_mode.u.set.enabled_flags =
@@ -845,17 +845,17 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 	supported_feat = llq_features->entry_size_ctrl_supported;
 	if (likely(supported_feat & llq_default_cfg->llq_ring_entry_size)) {
 		llq_info->desc_list_entry_size_ctrl = llq_default_cfg->llq_ring_entry_size;
-		llq_info->desc_list_entry_size = llq_default_cfg->llq_ring_entry_size_value;
+		llq_info->common.desc_list_entry_size = llq_default_cfg->llq_ring_entry_size_value;
 	} else {
 		if (supported_feat & ENA_ADMIN_LIST_ENTRY_SIZE_128B) {
 			llq_info->desc_list_entry_size_ctrl = ENA_ADMIN_LIST_ENTRY_SIZE_128B;
-			llq_info->desc_list_entry_size = 128;
+			llq_info->common.desc_list_entry_size = 128;
 		} else if (supported_feat & ENA_ADMIN_LIST_ENTRY_SIZE_192B) {
 			llq_info->desc_list_entry_size_ctrl = ENA_ADMIN_LIST_ENTRY_SIZE_192B;
-			llq_info->desc_list_entry_size = 192;
+			llq_info->common.desc_list_entry_size = 192;
 		} else if (supported_feat & ENA_ADMIN_LIST_ENTRY_SIZE_256B) {
 			llq_info->desc_list_entry_size_ctrl = ENA_ADMIN_LIST_ENTRY_SIZE_256B;
-			llq_info->desc_list_entry_size = 256;
+			llq_info->common.desc_list_entry_size = 256;
 		} else {
 			ena_trc_err(ena_dev, "Invalid entry_size_ctrl, supported: 0x%x\n",
 				    supported_feat);
@@ -865,35 +865,40 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 		ena_trc_err(ena_dev, "Default llq ring entry size is not supported, performing fallback, default: 0x%x, supported: 0x%x, used: 0x%x\n",
 			    llq_default_cfg->llq_ring_entry_size,
 			    supported_feat,
-			    llq_info->desc_list_entry_size);
+			    llq_info->common.desc_list_entry_size);
 	}
-	if (unlikely(llq_info->desc_list_entry_size & 0x7)) {
+	if (unlikely(llq_info->common.desc_list_entry_size & 0x7)) {
 		/* The desc list entry size should be whole multiply of 8
 		 * This requirement comes from __iowrite64_copy()
 		 */
 		ena_trc_err(ena_dev, "Illegal entry size %d\n",
-			    llq_info->desc_list_entry_size);
+			    llq_info->common.desc_list_entry_size);
 		return ENA_COM_INVAL;
 	}
 
 	if (llq_info->desc_stride_ctrl == ENA_ADMIN_MULTIPLE_DESCS_PER_ENTRY)
-		llq_info->descs_per_entry = llq_info->desc_list_entry_size /
+		llq_info->common.descs_per_entry = llq_info->common.desc_list_entry_size /
 			sizeof(struct ena_eth_io_tx_desc);
 	else
-		llq_info->descs_per_entry = 1;
+		llq_info->common.descs_per_entry = 1;
 
 	supported_feat = llq_features->desc_num_before_header_supported;
 	if (likely(supported_feat & llq_default_cfg->llq_num_decs_before_header)) {
-		llq_info->descs_num_before_header = llq_default_cfg->llq_num_decs_before_header;
+		llq_info->common.descs_num_before_header =
+		llq_default_cfg->llq_num_decs_before_header;
 	} else {
 		if (supported_feat & ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_2) {
-			llq_info->descs_num_before_header = ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_2;
+			llq_info->common.descs_num_before_header =
+			ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_2;
 		} else if (supported_feat & ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_1) {
-			llq_info->descs_num_before_header = ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_1;
+			llq_info->common.descs_num_before_header =
+			ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_1;
 		} else if (supported_feat & ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_4) {
-			llq_info->descs_num_before_header = ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_4;
+			llq_info->common.descs_num_before_header =
+			ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_4;
 		} else if (supported_feat & ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_8) {
-			llq_info->descs_num_before_header = ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_8;
+			llq_info->common.descs_num_before_header =
+			ENA_ADMIN_LLQ_NUM_DESCS_BEFORE_HEADER_8;
 		} else {
 			ena_trc_err(ena_dev, "Invalid descs_num_before_header, supported: 0x%x\n",
 				    supported_feat);
@@ -903,19 +908,19 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 		ena_trc_err(ena_dev, "Default llq num descs before header is not supported, performing fallback, default: 0x%x, supported: 0x%x, used: 0x%x\n",
 			    llq_default_cfg->llq_num_decs_before_header,
 			    supported_feat,
-			    llq_info->descs_num_before_header);
+			    llq_info->common.descs_num_before_header);
 	}
 	/* Check for accelerated queue supported */
 	llq_accel_mode_get = llq_features->accel_mode.u.get;
 
-	llq_info->disable_meta_caching =
+	llq_info->common.disable_meta_caching =
 		!!(llq_accel_mode_get.supported_flags &
 		   BIT(ENA_ADMIN_DISABLE_META_CACHING));
 
 	if (llq_accel_mode_get.supported_flags & BIT(ENA_ADMIN_LIMIT_TX_BURST))
-		llq_info->max_entries_in_tx_burst =
+		llq_info->common.max_entries_in_tx_burst =
 			llq_accel_mode_get.max_tx_burst_size /
-			llq_default_cfg->llq_ring_entry_size_value;
+			llq_info->common.desc_list_entry_size;
 
 	rc = ena_com_set_llq(ena_dev);
 	if (unlikely(rc))
@@ -1055,7 +1060,8 @@ static void ena_com_io_queue_free(struct ena_com_dev *ena_dev,
 	if (io_sq->bounce_buf_ctrl.base_buffer) {
 		ENA_MEM_FREE(ena_dev->dmadev,
 			     io_sq->bounce_buf_ctrl.base_buffer,
-			     (io_sq->llq_info.desc_list_entry_size * ENA_COM_BOUNCE_BUFFER_CNTRL_CNT));
+			     (io_sq->llq_runtime.common.desc_list_entry_size *
+				ENA_COM_BOUNCE_BUFFER_CNTRL_CNT));
 		io_sq->bounce_buf_ctrl.base_buffer = NULL;
 	}
 }
@@ -3586,8 +3592,8 @@ int ena_com_config_dev_mode(struct ena_com_dev *ena_dev,
 	if (unlikely(rc))
 		return rc;
 
-	ena_dev->tx_max_header_size = llq_info->desc_list_entry_size -
-		(llq_info->descs_num_before_header * sizeof(struct ena_eth_io_tx_desc));
+	ena_dev->tx_max_header_size = llq_info->common.desc_list_entry_size -
+		(llq_info->common.descs_num_before_header * sizeof(struct ena_eth_io_tx_desc));
 
 	if (unlikely(ena_dev->tx_max_header_size == 0)) {
 		ena_trc_err(ena_dev, "The size of the LLQ entry is smaller than needed\n");
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index 1a64bf8ac5..df7e0786bf 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -84,18 +84,27 @@ struct ena_com_tx_meta {
 	u16 l4_hdr_len; /* In words */
 };
 
-struct ena_com_llq_info {
-	u16 header_location_ctrl;
-	u16 desc_stride_ctrl;
-	u16 desc_list_entry_size_ctrl;
+struct ena_com_llq_info_common {
 	u16 desc_list_entry_size;
 	u16 descs_num_before_header;
 	u16 descs_per_entry;
 	u16 max_entries_in_tx_burst;
 	bool disable_meta_caching;
+};
+
+struct ena_com_llq_info {
+	struct ena_com_llq_info_common common;
+	u16 header_location_ctrl;
+	u16 desc_stride_ctrl;
+	u16 desc_list_entry_size_ctrl;
 	u8 feature_version;
 };
 
+struct ena_com_llq_info_runtime {
+	struct ena_com_llq_info_common common;
+	u16 entries_in_tx_burst_left;
+};
+
 struct ena_com_io_cq {
 	struct ena_com_io_desc_addr cdesc_addr;
 	void *bus;
@@ -156,7 +165,7 @@ struct ena_com_io_sq {
 
 	u32 msix_vector;
 	struct ena_com_tx_meta cached_tx_meta;
-	struct ena_com_llq_info llq_info;
+	struct ena_com_llq_info_runtime llq_runtime;
 	struct ena_com_llq_pkt_ctrl llq_buf_ctrl;
 	struct ena_com_io_bounce_buffer_control bounce_buf_ctrl;
 
@@ -171,7 +180,6 @@ struct ena_com_io_sq {
 	u8 phase;
 	u8 desc_entry_size;
 	u8 dma_addr_bits;
-	u16 entries_in_tx_burst_left;
 } ____cacheline_aligned;
 
 struct ena_com_admin_cq {
diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index 63624d169b..ea0fb374db 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -112,7 +112,7 @@ static void *get_sq_desc_regular_queue(struct ena_com_io_sq *io_sq)
 static int ena_com_write_bounce_buffer_to_dev(struct ena_com_io_sq *io_sq,
 						     u8 *bounce_buffer)
 {
-	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
+	struct ena_com_llq_info_common *llq_info = &io_sq->llq_runtime.common;
 	u16 dst_tail_mask;
 	u32 dst_offset;
 
@@ -120,16 +120,16 @@ static int ena_com_write_bounce_buffer_to_dev(struct ena_com_io_sq *io_sq,
 	dst_offset = dst_tail_mask * llq_info->desc_list_entry_size;
 
 	if (is_llq_max_tx_burst_exists(io_sq)) {
-		if (unlikely(!io_sq->entries_in_tx_burst_left)) {
+		if (unlikely(!io_sq->llq_runtime.entries_in_tx_burst_left)) {
 			ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
 				    "Error: trying to send more packets than tx burst allows\n");
 			return ENA_COM_NO_SPACE;
 		}
 
-		io_sq->entries_in_tx_burst_left--;
+		io_sq->llq_runtime.entries_in_tx_burst_left--;
 		ena_trc_dbg(ena_com_io_sq_to_ena_dev(io_sq),
 			    "Decreasing entries_in_tx_burst_left of queue %u to %u\n",
-			    io_sq->qid, io_sq->entries_in_tx_burst_left);
+			    io_sq->qid, io_sq->llq_runtime.entries_in_tx_burst_left);
 	}
 
 	/* Make sure everything was written into the bounce buffer before
@@ -156,7 +156,7 @@ static int ena_com_write_header_to_llq_entry(struct ena_com_io_sq *io_sq,
 					  u16 header_len)
 {
 	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
-	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
+	struct ena_com_llq_info_common *llq_info = &io_sq->llq_runtime.common;
 	u8 *curr_llq_entry = pkt_ctrl->curr_llq_entry;
 	u16 header_offset;
 
@@ -207,7 +207,7 @@ static void *get_sq_desc_llq(struct ena_com_io_sq *io_sq)
 static int ena_com_write_and_advance_llq_entry(struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
-	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
+	struct ena_com_llq_info_common *llq_info = &io_sq->llq_runtime.common;
 	int rc;
 
 	rc = ena_com_write_bounce_buffer_to_dev(io_sq,
@@ -230,7 +230,7 @@ static int ena_com_write_and_advance_llq_entry(struct ena_com_io_sq *io_sq)
 static int ena_com_close_llq_entry(struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
-	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
+	struct ena_com_llq_info_common *llq_info = &io_sq->llq_runtime.common;
 	int rc;
 
 	if (unlikely(!ena_com_sq_is_llq(io_sq)))
@@ -268,7 +268,7 @@ static void *get_tx_sq_desc(struct ena_com_io_sq *io_sq)
 static int ena_com_sq_update_llq_tail(struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
-	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
+	struct ena_com_llq_info_common *llq_info = &io_sq->llq_runtime.common;
 	int rc;
 
 	if (!pkt_ctrl->descs_left_in_line) {
@@ -439,7 +439,7 @@ static int ena_com_create_and_store_tx_meta_desc(struct ena_com_io_sq *io_sq,
 	/* When disable meta caching is set, don't bother to save the meta and
 	 * compare it to the stored version, just create the meta
 	 */
-	if (io_sq->llq_info.disable_meta_caching) {
+	if (io_sq->llq_runtime.common.disable_meta_caching) {
 		*have_meta = true;
 		return ena_com_create_meta(io_sq, ena_meta);
 	}
diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index 503cf45cf7..514df12e9d 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -118,7 +118,7 @@ static inline bool ena_com_sq_have_enough_space(struct ena_com_io_sq *io_sq,
 	 * (one for the header line and one to compensate the devision
 	 * down calculation.
 	 */
-	temp = required_buffers / io_sq->llq_info.descs_per_entry + 2;
+	temp = required_buffers / io_sq->llq_runtime.common.descs_per_entry + 2;
 
 	return ena_com_free_q_entries(io_sq) > temp;
 }
@@ -137,13 +137,13 @@ static inline bool ena_com_meta_desc_changed(struct ena_com_io_sq *io_sq,
 static inline bool is_llq_max_tx_burst_exists(struct ena_com_io_sq *io_sq)
 {
 	return likely(ena_com_sq_is_llq(io_sq)) &&
-	       (io_sq->llq_info.max_entries_in_tx_burst > 0);
+	       (io_sq->llq_runtime.common.max_entries_in_tx_burst > 0);
 }
 
 static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
 					      struct ena_com_tx_ctx *ena_tx_ctx)
 {
-	struct ena_com_llq_info *llq_info;
+	struct ena_com_llq_info_common *llq_info;
 	int descs_after_first_entry;
 	int num_entries_needed = 1;
 	u16 num_descs;
@@ -151,7 +151,7 @@ static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
 	if (!is_llq_max_tx_burst_exists(io_sq))
 		return false;
 
-	llq_info = &io_sq->llq_info;
+	llq_info = &io_sq->llq_runtime.common;
 	num_descs = ena_tx_ctx->num_bufs;
 
 	if (llq_info->disable_meta_caching ||
@@ -168,7 +168,7 @@ static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
 		    "Queue: %d num_descs: %d num_entries_needed: %d\n",
 		    io_sq->qid, num_descs, num_entries_needed);
 
-	return num_entries_needed > io_sq->entries_in_tx_burst_left;
+	return num_entries_needed > io_sq->llq_runtime.entries_in_tx_burst_left;
 }
 
 static inline void ena_com_write_rx_sq_doorbell(struct ena_com_io_sq *io_sq)
@@ -184,7 +184,7 @@ static inline void ena_com_write_rx_sq_doorbell(struct ena_com_io_sq *io_sq)
 
 static inline void ena_com_write_tx_sq_doorbell(struct ena_com_io_sq *io_sq)
 {
-	u16 max_entries_in_tx_burst = io_sq->llq_info.max_entries_in_tx_burst;
+	u16 max_entries_in_tx_burst = io_sq->llq_runtime.common.max_entries_in_tx_burst;
 	u16 tail = io_sq->tail;
 
 	ena_trc_dbg(ena_com_io_sq_to_ena_dev(io_sq),
@@ -197,7 +197,7 @@ static inline void ena_com_write_tx_sq_doorbell(struct ena_com_io_sq *io_sq)
 		ena_trc_dbg(ena_com_io_sq_to_ena_dev(io_sq),
 			    "Reset available entries in tx burst for queue %d to %d\n",
 			    io_sq->qid, max_entries_in_tx_burst);
-		io_sq->entries_in_tx_burst_left = max_entries_in_tx_burst;
+		io_sq->llq_runtime.entries_in_tx_burst_left = max_entries_in_tx_burst;
 	}
 }
 
-- 
2.17.1

