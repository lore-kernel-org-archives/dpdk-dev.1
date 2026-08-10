Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5079C5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 11:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00ECA40E40;
	Mon, 10 Aug 2026 13:29:58 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 285BB40DD6;
 Mon, 10 Aug 2026 13:29:54 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 098161A001F;
 Mon, 10 Aug 2026 13:29:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B7AA91A0025;
 Mon, 10 Aug 2026 13:29:53 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 306E318000B1;
 Mon, 10 Aug 2026 19:29:53 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com, stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 2/6] crypto/dpaa2_sec: fix FLE pool leak on sec FD build
 failure
Date: Mon, 10 Aug 2026 16:59:47 +0530
Message-Id: <20260810112951.2879825-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260810112951.2879825-1-g.singh@nxp.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

When build_sec_fd fails at index loop inside the enqueue burst loops,
the previously built FD entries (indices 0..loop-1) were never freed.
The cleanup loop iterated in the wrong direction, starting at the
failed index and going up to frames_to_send, which are entries that
were never built. This caused silent FLE pool exhaustion, after which
every subsequent build_sec_fd returned -ENOMEM, enqueue_burst
returned 0 indefinitely, and the crypto-perf test hung.

Fix both dpaa2_sec_enqueue_burst and dpaa2_sec_enqueue_burst_ordered
by clamping frames_to_send to loop + 1 and iterating from 0 to
free all allocated FLE buffers including the failed entry.

Fixes: 623326dded ("crypto/dpaa2_sec: introduce poll mode driver")
Cc: stable@dpdk.org
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 2a015a3d82..15152cc5a1 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1550,6 +1550,9 @@ dpaa2_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 			ret = build_sec_fd(*ops, &fd_arr[loop], bpid, dpaa2_qp);
 			if (ret) {
 				DPAA2_SEC_DP_DEBUG("FD build failed");
+				frames_to_send = loop + 1;
+				for (loop = 0; loop < frames_to_send; loop++)
+					free_fle(&fd_arr[loop], dpaa2_qp);
 				goto skip_tx;
 			}
 			ops++;
@@ -1909,6 +1912,9 @@ dpaa2_sec_enqueue_burst_ordered(void *qp, struct rte_crypto_op **ops,
 			ret = build_sec_fd(*ops, &fd_arr[loop], bpid, dpaa2_qp);
 			if (ret) {
 				DPAA2_SEC_DP_DEBUG("FD build failed");
+				frames_to_send = loop + 1;
+				for (loop = 0; loop < frames_to_send; loop++)
+					free_fle(&fd_arr[loop], dpaa2_qp);
 				goto skip_tx;
 			}
 			ops++;
-- 
2.25.1

