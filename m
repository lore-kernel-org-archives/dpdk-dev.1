Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E299606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=LbrKO3tK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42879402D5;
	Tue, 17 Nov 2026 07:45:35 +0100 (CET)
Received: from lf-2-19.ptr.blmpb.com (lf-2-19.ptr.blmpb.com [101.36.218.19])
 by mails.dpdk.org (Postfix) with ESMTPS id B23504042C
 for <dev@dpdk.org>; Tue, 17 Nov 2026 07:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794897924; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=w+Uwn/28dttfbVD59znpR6uNmIO/3o819yohxi0x/DI=;
 b=LbrKO3tKz9JTgOofepqP84rktgTrzAVi8+BLV6l+M6Hr+RzRMSwKoU4/3ig+8cOP+Z9Lah
 Y1sgIMwGCKuiO/RPYMXBSyPGtDRhfMViS41Cm0YAaZlaluKER8gUhwg3OXcKVXUxbGPcW7
 f8iUcovCajKqXQecs2t66n6pngflOxLIiaQ8mUFgwVFJAU5BdK6ON1Q/EdMBnyjWjPcXAq
 38MSQwJ5WdX3t9bPjP88M3cbA1WLml5h26PFJmQnvaEfSX7Z6kZK0/aCEOw24c3l/pIuTR
 UuyJ4QSMxdXDYc52Xqz5R4ygs0lkN2RxhtRrehvl6aMqEXFVm2ttt1Ak8vyDZg==
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Date: Tue, 17 Nov 2026 14:45:14 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
From: "Renyong Wan" <wanry@yunsilicon.com>
In-Reply-To: <1794897914.9800@yunsilicon.com>
X-Lms-Return-Path: <lba+26afbf802+0d6350+dpdk.org+wanry@yunsilicon.com>
Received: from [10.211.5.164] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS;
 Tue, 17 Nov 2026 14:45:21 +0800
To: <dev@dpdk.org>
Subject: [PATCH v3 3/3] net/xsc: rename jumbo buffer fields
Message-Id: <1794897914.1170@yunsilicon.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
References: <1794897914.9800@yunsilicon.com>
Content-Transfer-Encoding: 7bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
index c0a03795..c369ad3a 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -149,8 +149,8 @@ xsc_dev_close(struct xsc_dev *xdev, int repr_id)
 		ret = xdev->dev_ops->dev_close(xdev);
 
 	/* Removal closes the device again, do not free it twice. */
-	rte_free(xdev->jumbo_buffer_pa);
-	xdev->jumbo_buffer_pa = NULL;
+	rte_free(xdev->jumbo_buf);
+	xdev->jumbo_buf = NULL;
 
 	return ret;
 }
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
