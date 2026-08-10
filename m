Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A3AC5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 11:30:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4839740E35;
	Mon, 10 Aug 2026 13:30:00 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id BE47D40DD6
 for <dev@dpdk.org>; Mon, 10 Aug 2026 13:29:54 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A344B1A0026;
 Mon, 10 Aug 2026 13:29:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DCEA1A0029;
 Mon, 10 Aug 2026 13:29:54 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DD28C18000B5;
 Mon, 10 Aug 2026 19:29:53 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 4/6] crypto/dpaa2_sec: increase ivsize range for AES-CTR
Date: Mon, 10 Aug 2026 16:59:49 +0530
Message-Id: <20260810112951.2879825-5-g.singh@nxp.com>
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

Widen the AES-CTR IV size range from the fixed 16-byte value to
[12, 16] with a 4-byte increment. This allows 96-bit IVs (the
standard NIST SP 800-38A recommendation) in addition to 128-bit
IVs, aligning with common usage and test-vector expectations.

The change applies to both dpaa2_sec_capabilities and
dpaa2_pdcp_capabilities.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
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
2.25.1

