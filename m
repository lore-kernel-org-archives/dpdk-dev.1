Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B9BFC617E
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Jan 2026 17:41:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B22340267;
	Sat,  3 Jan 2026 18:41:00 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C67F240262
 for <dev@dpdk.org>; Sat,  3 Jan 2026 18:40:58 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CE0A4208CF
 for <dev@dpdk.org>; Sat,  3 Jan 2026 18:40:57 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sat, 3 Jan 2026 18:40:56 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] mbuf: optimize detach direct buffer
Date: Sat,  3 Jan 2026 17:40:54 +0000
Message-ID: <20260103174054.121246-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jan 2026 17:40:56.0285 (UTC)
 FILETIME=[1D6EC0D0:01DC7CD8]
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

When rte_pktmbuf_prefree_seg() resets an mbuf about to be freed, it
doesn't write the fields that already have the required values. This
saves a memory store operation when all the fields already have the
required values.

This patch adds the same optimization to __rte_pktmbuf_free_direct(),
to improve the performance for freeing a direct buffer being detached from
a packet mbuf, i.e. saving a memory store operation when all the fields
(of the buffer being freed) already have the required values.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 2004391f57..592af2388c 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -1334,17 +1334,23 @@ static inline void
 __rte_pktmbuf_free_direct(struct rte_mbuf *m)
 {
 	struct rte_mbuf *md;
+	bool refcnt_not_one;
 
 	RTE_ASSERT(RTE_MBUF_CLONED(m));
 
 	md = rte_mbuf_from_indirect(m);
 
-	if (rte_mbuf_refcnt_update(md, -1) == 0) {
-		md->next = NULL;
-		md->nb_segs = 1;
+	refcnt_not_one = unlikely(rte_mbuf_refcnt_read(md) != 1);
+	if (refcnt_not_one && __rte_mbuf_refcnt_update(md, -1) != 0)
+		return;
+
+	if (refcnt_not_one)
 		rte_mbuf_refcnt_set(md, 1);
-		rte_mbuf_raw_free(md);
-	}
+	if (md->nb_segs != 1)
+		md->nb_segs = 1;
+	if (md->next != NULL)
+		md->next = NULL;
+	rte_mbuf_raw_free(md);
 }
 
 /**
-- 
2.43.0

