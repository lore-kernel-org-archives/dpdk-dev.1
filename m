Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1021C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:54:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03DDA427CB;
	Thu,  3 Sep 2026 15:54:07 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A2EEC4279D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:03 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 81EF220004C;
 Thu,  3 Sep 2026 15:54:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4AEBF200029;
 Thu,  3 Sep 2026 15:54:03 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BA4F0180006C;
 Thu,  3 Sep 2026 21:54:01 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 04/45] crypto/dpaa2_sec: increase ivsize range for AES-CTR
Date: Thu,  3 Sep 2026 19:23:12 +0530
Message-ID: <20260903135353.3358303-5-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

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
index 1824cc4a60..7e18e83858 100644
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
@@ -855,9 +855,9 @@ static const struct rte_cryptodev_capabilities dpaa2_pdcp_capabilities[] = {
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
2.43.0

