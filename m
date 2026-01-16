Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A1D47CD0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 11:16:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B34142D90;
	Fri, 16 Jan 2026 12:16:46 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D7C754060F;
 Fri, 16 Jan 2026 12:16:44 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 05F802061A;
 Fri, 16 Jan 2026 12:16:44 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 16 Jan 2026 12:16:43 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	dev@dpdk.org
Cc: stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2] mbuf: fix packet copy
Date: Fri, 16 Jan 2026 11:16:21 +0000
Message-ID: <20260116111621.300891-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119120403.907511-1-mb@smartsharesystems.com>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2026 11:16:43.0543 (UTC)
 FILETIME=[984C3A70:01DC86D9]
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

mbuf: fix packet copy

Requests for copying the at the end of a packet incorrectly returned NULL,
as if copying past the end of a packet.

When allocating the mbuf for the copy from a mempool using pinned external
buffers, the external flag in this mbuf was not preserved.

Fixes: c3a90c381daa ("mbuf: add a copy routine")

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
v2:
* Improved comment about preserving flags for newly allocated mbuf
  potentially using pinned external buffer.
* Added missing spaces in expression. (Stephen)
---
 lib/mbuf/rte_mbuf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index 0d931c7a15..a5d16e4c97 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -675,7 +675,7 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 	__rte_mbuf_sanity_check(m, 1);
 
 	/* check for request to copy at offset past end of mbuf */
-	if (unlikely(off >= m->pkt_len))
+	if (unlikely(off > m->pkt_len))
 		return NULL;
 
 	mc = rte_pktmbuf_alloc(mp);
@@ -688,8 +688,12 @@ rte_pktmbuf_copy(const struct rte_mbuf *m, struct rte_mempool *mp,
 
 	__rte_pktmbuf_copy_hdr(mc, m);
 
-	/* copied mbuf is not indirect or external */
-	mc->ol_flags = m->ol_flags & ~(RTE_MBUF_F_INDIRECT|RTE_MBUF_F_EXTERNAL);
+	/*
+	 * copy flags except indirect and external,
+	 * while preserving flags of newly allocated mbuf
+	 * (specifically RTE_MBUF_F_EXTERNAL if using pinned external buffer)
+	 */
+	mc->ol_flags |= m->ol_flags & ~(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL);
 
 	prev = &mc->next;
 	m_last = mc;
-- 
2.43.0

