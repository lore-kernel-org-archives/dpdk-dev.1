Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B65CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 11:44:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 355EB40EE3;
	Tue,  6 Oct 2026 13:43:56 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id EE85140A81
 for <dev@dpdk.org>; Tue,  6 Oct 2026 13:43:51 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CE2A71A01A4;
 Tue,  6 Oct 2026 13:43:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9AB791A019A;
 Tue,  6 Oct 2026 13:43:51 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 20F0118000B1;
 Tue,  6 Oct 2026 19:43:51 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 3/6] crypto/dpaa2_sec: increase ivsize range for AES-CTR
Date: Tue,  6 Oct 2026 17:13:43 +0530
Message-Id: <20261006114346.1229651-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006114346.1229651-1-g.singh@nxp.com>
References: <20260930070809.1929564-1-g.singh@nxp.com>
 <20261006114346.1229651-1-g.singh@nxp.com>
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

Widen the AES-CTR IV size range from the fixed 16-byte value to
[12, 16] with a 4-byte increment. This allows 96-bit IVs (the
standard NIST SP 800-38A recommendation) in addition to 128-bit
IVs, aligning with common usage and test-vector expectations.

The change applies to both dpaa2_sec_capabilities and
dpaa2_pdcp_capabilities.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index ff32f3d860..b9a6440f78 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -625,9 +625,9 @@ static const struct rte_cryptodev_capabilities dpaa2_sec_capabilities[] = {
 					.increment = 8
 				},
 				.iv_size = {
-					.min = 16,
+					.min = 12,
 					.max = 16,
-					.increment = 0
+					.increment = 4
 				},
 			}, }
 		}, }
@@ -824,9 +824,9 @@ static const struct rte_cryptodev_capabilities dpaa2_pdcp_capabilities[] = {
 					.increment = 8
 				},
 				.iv_size = {
-					.min = 16,
+					.min = 12,
 					.max = 16,
-					.increment = 0
+					.increment = 4
 				}
 			}, }
 		}, }
-- 
2.25.1

