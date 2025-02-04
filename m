Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3193FC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:23:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E35F840EE2;
	Tue,  4 Feb 2025 17:23:02 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 455A64042E
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id E1989210C33A; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1989210C33A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686167;
 bh=8ExafJgLh1IxftT5BWlc87g++0TfLbSnzKlAjZo3A/I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pet9sw7Sxr1prZvKejhzFUlk11+PYPAa3ukkmyvsdtJd61b/vVhGaG45Y1VDUHndo
 /+KHmFhSVBgPWg9JsNXudChQlBXoxbObYd7c0AUyOBPo1EF7lajVXQaZaIoXp+HWTZ
 Octw+ze0inF8KMyCPWldr3GJlapNOS6J3lIWboYk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v20 14/27] common/idpf: remove use of VLAs for Windows built
 code
Date: Tue,  4 Feb 2025 08:21:51 -0800
Message-Id: <1738686124-16173-15-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

From: Tyler Retzlaff <roretzla@linux.microsoft.com>

MSVC does not support VLAs, replace VLAs with standard C arrays
or alloca(). alloca() is available for all toolchain/platform
combinations officially supported by DPDK.

Signed-off-by: Tyler Retzlaff <roretzla@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/common/idpf/idpf_common_rxtx.c        | 2 +-
 drivers/common/idpf/idpf_common_rxtx_avx512.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/common/idpf/idpf_common_rxtx.c b/drivers/common/idpf/idpf_common_rxtx.c
index a04e54ce26..e04ab40fa2 100644
--- a/drivers/common/idpf/idpf_common_rxtx.c
+++ b/drivers/common/idpf/idpf_common_rxtx.c
@@ -569,7 +569,7 @@ idpf_split_rx_bufq_refill(struct idpf_rx_queue *rx_bufq)
 	uint16_t nb_refill = rx_bufq->rx_free_thresh;
 	uint16_t nb_desc = rx_bufq->nb_rx_desc;
 	uint16_t next_avail = rx_bufq->rx_tail;
-	struct rte_mbuf *nmb[rx_bufq->rx_free_thresh];
+	struct rte_mbuf **nmb = alloca(sizeof(struct rte_mbuf *) * rx_bufq->rx_free_thresh);
 	uint64_t dma_addr;
 	uint16_t delta;
 	int i;
diff --git a/drivers/common/idpf/idpf_common_rxtx_avx512.c b/drivers/common/idpf/idpf_common_rxtx_avx512.c
index 81052e72c1..6fbfee1b2d 100644
--- a/drivers/common/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/common/idpf/idpf_common_rxtx_avx512.c
@@ -998,7 +998,8 @@ idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
-	struct rte_mbuf *m, *free[txq->rs_thresh];
+	struct rte_mbuf *m;
+	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->rs_thresh);
 
 	/* check DD bits on threshold descriptor */
 	if ((txq->tx_ring[txq->next_dd].qw1 &
@@ -1322,7 +1323,8 @@ idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
-	struct rte_mbuf *m, *free[txq->rs_thresh];
+	struct rte_mbuf *m;
+	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->rs_thresh);
 
 	n = txq->rs_thresh;
 
-- 
2.47.2.vfs.0.1

