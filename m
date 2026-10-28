Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0D606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 08:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C74A9402D4;
	Wed, 28 Oct 2026 09:51:58 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTPS id C0E47400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 09:51:56 +0100 (CET)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 807BF200006;
 Wed, 28 Oct 2026 09:51:56 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4ADEC20001B;
 Wed, 28 Oct 2026 09:51:56 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5FE0718000B5;
 Wed, 28 Oct 2026 16:51:55 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, jun.yang@nxp.com,
 Gagandeep Singh <g.singh@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/1] bus/dpaa: fix maybe-uninitialized in bman_release_fast
Date: Wed, 28 Oct 2026 14:21:51 +0530
Message-Id: <20261028085154.699656-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028085154.699656-1-g.singh@nxp.com>
References: <20261028085154.699656-1-g.singh@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stephen Hemminger <stephen@networkplumber.org>

The conversion loop is bounded only by num, which is not checked
unless RTE_LIBRTE_DPAA_HWDEBUG is set. GCC on ppc64le and riscv
therefore warns that bm_bufs[0] may be read uninitialized when
copying the first entry into the RCR.

Convert entry 0 unconditionally, as bman_release() does.

Fixes: e55e2e2d0c66 ("bus/dpaa: optimize DPAA multi-entry buffer pool operations")
Cc: jun.yang@nxp.com

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/dpaa/base/qbman/bman.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index 2b081cb78a..76e612662f 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -279,7 +279,8 @@ bman_release_fast(struct bman_pool *pool, const uint64_t *bufs,
 	if (unlikely(!r))
 		return -EBUSY;
 
-	for (i = 0; i < num; i++)
+	bm_buffer_set64_to_be(&bm_bufs[0], bufs[0]);
+	for (i = 1; i < num; i++)
 		bm_buffer_set64_to_be(&bm_bufs[i], bufs[i]);
 
 	/* bufs[0] overlaps the verb, which bm_rcr_pvb_commit() writes last
-- 
2.25.1

