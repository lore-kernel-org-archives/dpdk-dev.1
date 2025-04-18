Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFC3C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 19:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 186EC40673;
	Fri, 18 Apr 2025 21:33:16 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 60BF340653;
 Fri, 18 Apr 2025 21:33:14 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id C4D7A20BCAD3; Fri, 18 Apr 2025 12:33:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4D7A20BCAD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1745004793;
 bh=Ss1IyKsUsbiEw54Pz/F1OAODUfMCht252RQwHw4MSPE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P+U9pG1YQH3syA16xfyaKUjv5crd2dwgzMhiT4Lm02eGgKLpvORD0y8ux4cTivMQ4
 LqklYAfa1jIu1hyApff5DUW7nBS9iGwl8AQ29aHXwSiORro37ojJoWMn3VXmEVBm0l
 R/xeGpoppGrFDgCsIpz8UBh7n5+dF6Poq67ikBfM=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH 4/4] net/netvsc: Use Hyper-V page size for the driver
Date: Fri, 18 Apr 2025 12:32:50 -0700
Message-Id: <1745004770-9795-5-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
References: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
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

From: Long Li <longli@microsoft.com>

The driver should always use Hyper-V page size for implementing RNDIS and
calculating PFN (Page Frame Number) for communicating with Hyper-V VSP.

It should not use system page size as it may be different to the Hyper-V
page size.

Fixes: 4e9c73e96e ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_rndis.c | 14 +++++++-------
 drivers/net/netvsc/hn_rxtx.c  | 16 ++++++++--------
 drivers/net/netvsc/hn_var.h   |  4 ----
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index 12bea33e37..7c54eebcef 100644
--- a/drivers/net/netvsc/hn_rndis.c
+++ b/drivers/net/netvsc/hn_rndis.c
@@ -67,7 +67,7 @@ hn_rndis_rid(struct hn_data *hv)
 
 static void *hn_rndis_alloc(size_t size)
 {
-	return rte_zmalloc("RNDIS", size, rte_mem_page_size());
+	return rte_zmalloc("RNDIS", size, HYPERV_PAGE_SIZE);
 }
 
 #ifdef RTE_LIBRTE_NETVSC_DEBUG_DUMP
@@ -266,17 +266,17 @@ static int hn_nvs_send_rndis_ctrl(struct hn_data *hv,
 		return -EINVAL;
 	}
 
-	if (unlikely(reqlen > rte_mem_page_size())) {
+	if (unlikely(reqlen > HYPERV_PAGE_SIZE)) {
 		PMD_DRV_LOG(ERR, "RNDIS request %u greater than page size",
 			    reqlen);
 		return -EINVAL;
 	}
 
-	sg.page = addr / rte_mem_page_size();
-	sg.ofs  = addr & PAGE_MASK;
+	sg.page = addr / HYPERV_PAGE_SIZE;
+	sg.ofs  = addr & HYPERV_PAGE_MASK;
 	sg.len  = reqlen;
 
-	if (sg.ofs + reqlen >  rte_mem_page_size()) {
+	if (sg.ofs + reqlen >  HYPERV_PAGE_SIZE) {
 		PMD_DRV_LOG(ERR, "RNDIS request crosses page boundary");
 		return -EINVAL;
 	}
@@ -481,7 +481,7 @@ hn_rndis_query(struct hn_data *hv, uint32_t oid,
 		return -ENOMEM;
 
 	comp_len = sizeof(*comp) + odlen;
-	comp = rte_zmalloc("QUERY", comp_len, rte_mem_page_size());
+	comp = rte_zmalloc("QUERY", comp_len, HYPERV_PAGE_SIZE);
 	if (!comp) {
 		error = -ENOMEM;
 		goto done;
@@ -738,7 +738,7 @@ hn_rndis_set(struct hn_data *hv, uint32_t oid, const void *data, uint32_t dlen)
 	int error;
 
 	reqlen = sizeof(*req) + dlen;
-	req = rte_zmalloc("RNDIS_SET", reqlen, rte_mem_page_size());
+	req = rte_zmalloc("RNDIS_SET", reqlen, HYPERV_PAGE_SIZE);
 	if (!req)
 		return -ENOMEM;
 
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index ffa6937ce2..44faf22da7 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -1432,10 +1432,10 @@ static unsigned int hn_get_slots(const struct rte_mbuf *m)
 
 	while (m) {
 		unsigned int size = rte_pktmbuf_data_len(m);
-		unsigned int offs = rte_mbuf_data_iova(m) & PAGE_MASK;
+		unsigned int offs = rte_mbuf_data_iova(m) & HYPERV_PAGE_MASK;
 
-		slots += (offs + size + rte_mem_page_size() - 1) /
-				rte_mem_page_size();
+		slots += (offs + size + HYPERV_PAGE_SIZE - 1) /
+				HYPERV_PAGE_SIZE;
 		m = m->next;
 	}
 
@@ -1450,13 +1450,13 @@ static unsigned int hn_fill_sg(struct vmbus_gpa *sg,
 
 	while (m) {
 		rte_iova_t addr = rte_mbuf_data_iova(m);
-		unsigned int page = addr / rte_mem_page_size();
-		unsigned int offset = addr & PAGE_MASK;
+		unsigned int page = addr / HYPERV_PAGE_SIZE;
+		unsigned int offset = addr & HYPERV_PAGE_MASK;
 		unsigned int len = rte_pktmbuf_data_len(m);
 
 		while (len > 0) {
 			unsigned int bytes = RTE_MIN(len,
-					rte_mem_page_size() - offset);
+					HYPERV_PAGE_SIZE - offset);
 
 			sg[segs].page = page;
 			sg[segs].ofs = offset;
@@ -1499,8 +1499,8 @@ static int hn_xmit_sg(struct hn_tx_queue *txq,
 	addr = txq->tx_rndis_iova +
 		((char *)txd->rndis_pkt - (char *)txq->tx_rndis);
 
-	sg[0].page = addr / rte_mem_page_size();
-	sg[0].ofs = addr & PAGE_MASK;
+	sg[0].page = addr / HYPERV_PAGE_SIZE;
+	sg[0].ofs = addr & HYPERV_PAGE_MASK;
 	sg[0].len = RNDIS_PACKET_MSG_OFFSET_ABS(hn_rndis_pktlen(txd->rndis_pkt));
 	segs = 1;
 
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index 0f638bc5fd..f946b3d8ef 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -31,10 +31,6 @@
 
 #define HN_RX_EXTMBUF_ENABLE	0
 
-#ifndef PAGE_MASK
-#define PAGE_MASK (rte_mem_page_size() - 1)
-#endif
-
 struct hn_data;
 struct hn_txdesc;
 
-- 
2.34.1

