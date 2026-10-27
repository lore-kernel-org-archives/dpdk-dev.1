Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F1606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:33:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F3B14064E;
	Tue, 27 Oct 2026 10:33:45 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 78B3D4025A
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:33:41 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3480C1A015B;
 Tue, 27 Oct 2026 10:33:41 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F34731A0161;
 Tue, 27 Oct 2026 10:33:40 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 223FB18000B1;
 Tue, 27 Oct 2026 17:33:40 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, hemant.agrawal@nxp.com,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 2/2] bus/dpaa: fix unneeded conditional in bman_release
Date: Tue, 27 Oct 2026 15:03:35 +0530
Message-Id: <20261027093335.4109017-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261027093335.4109017-1-g.singh@nxp.com>
References: <20261027063131.3979699-2-g.singh@nxp.com>
 <20261027093335.4109017-1-g.singh@nxp.com>
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

bman_release() computed i = num - 1 before the num == 0 bounds check,
which only exists under RTE_LIBRTE_DPAA_HWDEBUG. With that debug flag
disabled and num == 0, i wraps to UINT32_MAX, and the subsequent
'if (i)' guard is then always taken regardless of num, relying on the
for loop's own bound to do nothing. The indirection added no value and
obscured the num == 0 handling.

Drop the i = num - 1 initializer and the if (i) wrapper, relying
solely on the for (i = 1; i < num; i++) loop condition, matching the
simpler pattern already used in bman_release_fast().

Fixes: f38f61e982f8 ("bus/dpaa: add BMAN hardware interfaces")

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index 76e612662f..31114b2d57 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -304,7 +304,7 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 {
 	struct bman_portal *p;
 	struct bm_rcr_entry *r;
-	u32 i = num - 1;
+	u32 i;
 	u8 avail;
 
 #ifdef RTE_LIBRTE_DPAA_HWDEBUG
@@ -329,11 +329,9 @@ int bman_release(struct bman_pool *pool, const struct bm_buffer *bufs, u8 num,
 	r->bufs[0].opaque =
 		cpu_to_be64(((u64)pool->params.bpid << 48) |
 			    (bufs[0].opaque & MAX_U48));
-	if (i) {
-		for (i = 1; i < num; i++)
-			r->bufs[i].opaque =
-				cpu_to_be64(bufs[i].opaque & MAX_U48);
-	}
+	for (i = 1; i < num; i++)
+		r->bufs[i].opaque =
+			cpu_to_be64(bufs[i].opaque & MAX_U48);
 
 	bm_rcr_pvb_commit(&p->p, BM_RCR_VERB_CMD_BPID_SINGLE |
 			  (num & BM_RCR_VERB_BUFCOUNT_MASK));
-- 
2.25.1

