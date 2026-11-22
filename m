Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2F606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=DO7qh6U7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 065FD4064F;
	Sun, 22 Nov 2026 15:23:01 +0100 (CET)
Received: from lf-1-17.ptr.blmpb.com (lf-1-17.ptr.blmpb.com [103.149.242.17])
 by mails.dpdk.org (Postfix) with ESMTPS id BCAC74042C
 for <dev@dpdk.org>; Sun, 22 Nov 2026 15:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1795357372; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Mcq9Gy2ydg79hsRN51vNuIg5izltwADX4d+67XH0m2k=;
 b=DO7qh6U7CN70mxVgHr80qoXreufrV54iIQN7jXJRTSgxv4//+Gi2FWp2trTRKagym53co3
 bHOctViUMtoj0M4KwGJO/dFgNA2ikr46SJbD4OxlOiGJG9uhUBmnseRLPcb9D6jvqP0QD1
 JBVShEKixHskn7zw669nSVf+KsmNFj7dK32mIErRTF1kTdffprlDeMjeJ9aeYBBXvqv43f
 OrkHPFjmUCUmj7FzG+sJ+WlBc0QroZSNgaPeIqhRfxnM5SWG6ULWFbabfVNWlO/+17sFr1
 8ERsQBhAUPQZT9r9QVv8K2Y5kS3zeLa1RczJB77uRfbjkkK4LoEf96H/wmEIaQ==
To: <dev@dpdk.org>
Subject: [PATCH v5 4/4] net/xsc: rename jumbo buffer fields
Date: Sun, 22 Nov 2026 22:22:37 +0800
References: <1795357356.312312@yunsilicon.com>
Message-Id: <1795357357.189606@yunsilicon.com>
In-Reply-To: <1795357356.312312@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26b02faba+399239+dpdk.org+wanry@yunsilicon.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Received: from [192.168.0.85] ([114.92.245.110]) by smtp.feishu.cn with ESMTPS;
 Sun, 22 Nov 2026 22:22:49 +0800
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The names are the other way round: jumbo_buffer_pa holds the virtual
address and jumbo_buffer_va holds the IOVA, which is why the bug went
unnoticed.

Rename them to jumbo_buf and jumbo_iova with matching types, which also
removes the casts.

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c |  4 ++--
 drivers/net/xsc/xsc_dev.h |  4 ++--
 drivers/net/xsc/xsc_rx.c  | 22 +++++++++++-----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index f048efd7..f1abe560 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -151,8 +151,8 @@ xsc_dev_close(struct xsc_dev *xdev, int repr_id)
 		 * The buffer is shared by all the ports, the other Rx
 		 * queues hold its IOVA until the device is stopped.
 		 */
-		rte_free(xdev->jumbo_buffer_pa);
-		xdev->jumbo_buffer_pa = NULL;
+		rte_free(xdev->jumbo_buf);
+		xdev->jumbo_buf = NULL;
 	}
 
 	return ret;
diff --git a/drivers/net/xsc/xsc_dev.h b/drivers/net/xsc/xsc_dev.h
index d4a7d90b..3473333c 100644
--- a/drivers/net/xsc/xsc_dev.h
+++ b/drivers/net/xsc/xsc_dev.h
@@ -189,8 +189,8 @@ struct xsc_dev {
 	void *dev_priv;
 	char name[PCI_PRI_STR_SIZE];
 	void *bar_addr;
-	void *jumbo_buffer_pa;
-	void *jumbo_buffer_va;
+	void *jumbo_buf;
+	rte_iova_t jumbo_iova;
 	uint64_t bar_len;
 	int ctrl_fd;
 	rte_intr_callback_fn intr_cb;
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 30b40df3..f7529371 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -206,27 +206,27 @@ xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
 	uint32_t log2ds = rte_log2_u32(rx_ds_num);
 	uintptr_t addr;
 	struct rte_mbuf *mbuf;
-	void *jumbo_buffer_pa = xdev->jumbo_buffer_pa;
-	void *jumbo_buffer_va = xdev->jumbo_buffer_va;
+	void *jumbo_buf = xdev->jumbo_buf;
+	rte_iova_t jumbo_iova = xdev->jumbo_iova;
 	volatile struct xsc_wqe_data_seg *seg;
 	volatile struct xsc_wqe_data_seg *seg_next;
 
-	if (rx_ds_num != 1 && jumbo_buffer_pa == NULL) {
-		jumbo_buffer_pa = rte_malloc(NULL, XSC_MAX_RECV_LEN, 0);
-		if (jumbo_buffer_pa == NULL) {
+	if (rx_ds_num != 1 && jumbo_buf == NULL) {
+		jumbo_buf = rte_malloc(NULL, XSC_MAX_RECV_LEN, 0);
+		if (jumbo_buf == NULL) {
 			PMD_DRV_LOG(ERR, "Failed to malloc jumbo_buffer");
 			return -ENOMEM;
 		}
 
-		jumbo_buffer_va = (void *)rte_malloc_virt2iova(jumbo_buffer_pa);
-		if ((rte_iova_t)jumbo_buffer_va == RTE_BAD_IOVA) {
+		jumbo_iova = rte_malloc_virt2iova(jumbo_buf);
+		if (jumbo_iova == RTE_BAD_IOVA) {
 			PMD_DRV_LOG(ERR, "Failed to get IOVA of jumbo_buffer");
-			rte_free(jumbo_buffer_pa);
+			rte_free(jumbo_buf);
 			return -EFAULT;
 		}
 
-		xdev->jumbo_buffer_pa = jumbo_buffer_pa;
-		xdev->jumbo_buffer_va = jumbo_buffer_va;
+		xdev->jumbo_buf = jumbo_buf;
+		xdev->jumbo_iova = jumbo_iova;
 	}
 
 	for (i = 0; (i != wqe_n); ++i) {
@@ -246,7 +246,7 @@ xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
 		if (rx_ds_num != 1) {
 			seg_next = seg + 1;
 			*seg_next = (struct xsc_wqe_data_seg){
-				.va = rte_cpu_to_le_64((uint64_t)jumbo_buffer_va),
+				.va = rte_cpu_to_le_64(jumbo_iova),
 				.seg_len = rte_cpu_to_le_32(XSC_MAX_RECV_LEN - seg_len),
 				.lkey = 0,
 			};
