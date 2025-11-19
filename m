Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A8CF31AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 12:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9415402EB;
	Wed, 19 Nov 2025 13:04:06 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 73A5340265;
 Wed, 19 Nov 2025 13:04:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 415C0214DC;
 Wed, 19 Nov 2025 13:04:05 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 19 Nov 2025 13:04:04 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	dev@dpdk.org
Cc: stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] mbuf: fix packet copy
Date: Wed, 19 Nov 2025 12:04:03 +0000
Message-ID: <20251119120403.907511-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Nov 2025 12:04:05.0146 (UTC)
 FILETIME=[9A10EFA0:01DC594C]
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

Requests for copying the at the end of a packet incorrectly returned NULL,
as if copying past the end of a packet.

When allocating copies from a mempool using pinned external buffers, the
external flag was not preserved in these mbufs.

Fixes: c3a90c381daa ("mbuf: add a copy routine")

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 0d931c7a15..e639aff03e 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -675,7 +675,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 	__rte_mbuf_sanity_check(m, 1);
 
 	/* check for request to copy at offset past end of mbuf */
-	if (unlikely(off >= m->pkt_len))
+	if (unlikely(off > m->pkt_len))
 		return NULL;
 
 	mc = rte_pktmbuf_alloc(mp);
@@ -688,8 +688,8 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 
 	__rte_pktmbuf_copy_hdr(mc, m);
 
-	/* copied mbuf is not indirect or external */
-	mc->ol_flags = m->ol_flags & ~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERNAL);
+	/* copy flags except indirect and external, and preserve flags of newly allocated mbuf */
+	mc->ol_flags |= m->ol_flags & ~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERNAL);
 
 	prev = &mc->next;
 	m_last = mc;
-- 
2.43.0

