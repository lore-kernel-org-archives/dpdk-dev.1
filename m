Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF44E66884
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 19:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CF2F402A7;
	Fri, 19 Dec 2025 20:16:15 +0100 (CET)
Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
 by mails.dpdk.org (Postfix) with ESMTP id 4AF3B40276
 for <dev@dpdk.org>; Fri, 19 Dec 2025 20:16:13 +0100 (CET)
Received: (qmail 13731 invoked from network); 19 Dec 2025 19:16:12 -0000
Received: from il-bld.in.telka.sk (HELO il-bld.localdomain) (il-bld@10.0.0.17)
 by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384
 encrypted); 19 Dec 2025 19:16:12 -0000
Received: by il-bld.localdomain (Postfix, from userid 5001)
 id 23FF02A771; Fri, 19 Dec 2025 20:16:11 +0100 (CET)
From: Marcel Telka <marcel@telka.sk>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, Marcel Telka <marcel@telka.sk>
Subject: [PATCH] eal: update comment for eal_get_virtual_area()
Date: Fri, 19 Dec 2025 20:15:54 +0100
Message-ID: <20251219191554.939982-1-marcel@telka.sk>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Bugzilla ID: 1853

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 lib/eal/common/eal_common_memory.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..b8e0d4c29a 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -33,11 +33,10 @@
 #include "malloc_heap.h"
 
 /*
- * Try to mmap *size bytes in /dev/zero. If it is successful, return the
- * pointer to the mmap'd area and keep *size unmodified. Else, retry
- * with a smaller zone: decrease *size by hugepage_sz until it reaches
- * 0. In this case, return NULL. Note: this function returns an address
- * which is a multiple of hugepage size.
+ * Try to mmap *size bytes. If it is successful, return the pointer to the
+ * mmap'd area and keep *size unmodified. Else, retry with a smaller zone:
+ * decrease *size by page_sz until it reaches 0. In this case, return NULL.
+ * Note: this function returns an address which is a multiple of page size.
  */
 
 #define MEMSEG_LIST_FMT "memseg-%" PRIu64 "k-%i-%i"
