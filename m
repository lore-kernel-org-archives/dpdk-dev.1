Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C79C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 08:03:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB3D640691;
	Tue, 24 Jun 2025 10:03:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D992240666
 for <dev@dpdk.org>; Tue, 24 Jun 2025 10:03:43 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AFD922087C;
 Tue, 24 Jun 2025 10:03:43 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 24 Jun 2025 10:03:42 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 1/3] eal/unix: fix log message for madvise() failure
Date: Tue, 24 Jun 2025 08:03:31 +0000
Message-ID: <20250624080333.127618-2-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624080333.127618-1-mb@smartsharesystems.com>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <20250624080333.127618-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Jun 2025 08:03:42.0898 (UTC)
 FILETIME=[80998920:01DBE4DE]
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

In eal_mem_set_dump(), when madvise() failed, an incorrect reason was
logged.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/unix/eal_unix_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
index 61e914b8db..650151facb 100644
--- a/lib/eal/unix/eal_unix_memory.c
+++ b/lib/eal/unix/eal_unix_memory.c
@@ -89,7 +89,7 @@ eal_mem_set_dump(void *virt, size_t size, bool dump)
 	int ret = madvise(virt, size, flags);
 	if (ret) {
 		EAL_LOG(DEBUG, "madvise(%p, %#zx, %d) failed: %s",
-				virt, size, flags, strerror(rte_errno));
+				virt, size, flags, strerror(errno));
 		rte_errno = errno;
 	}
 	return ret;
-- 
2.43.0

