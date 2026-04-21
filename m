Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EB7F8924C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:24:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E681A4029D;
	Tue, 21 Apr 2026 12:24:14 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B9CCA4027C
 for <dev@dpdk.org>; Tue, 21 Apr 2026 12:24:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 68A4223C33;
 Tue, 21 Apr 2026 12:24:13 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 21 Apr 2026 12:24:11 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] ring: add cache guard after ring elements table
Date: Tue, 21 Apr 2026 10:23:58 +0000
Message-ID: <20260421102358.118204-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Apr 2026 10:24:11.0507 (UTC)
 FILETIME=[FEC7F430:01DCD178]
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

Added cache guard after the table holding the ring elements, to avoid
false sharing conflicts caused by next-line hardware prefetchers when
accessing elements at the end of the ring table.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ring/rte_ring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index f10050a1c4..9ccc62cd42 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -73,8 +73,11 @@ rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
 		return -EINVAL;
 	}
 
+	static_assert(sizeof(struct rte_ring) == RTE_CACHE_LINE_ROUNDUP(sizeof(struct rte_ring)),
+			"Size of struct rte_ring not cache line aligned");
 	sz = sizeof(struct rte_ring) + (ssize_t)count * esize;
 	sz = RTE_ALIGN(sz, RTE_CACHE_LINE_SIZE);
+	sz += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
 	return sz;
 }
 
-- 
2.43.0

