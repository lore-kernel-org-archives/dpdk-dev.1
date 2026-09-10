Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E041C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBD8642D68;
	Thu, 10 Sep 2026 15:52:13 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id C7A61427E0
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:09 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AA08B1A0446;
 Thu, 10 Sep 2026 15:52:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 734DD1A0054;
 Thu, 10 Sep 2026 15:52:09 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 090F018000B6;
 Thu, 10 Sep 2026 21:52:07 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 05/47] crypto/dpaa2_sec: add missing ECN capability
Date: Thu, 10 Sep 2026 19:21:16 +0530
Message-ID: <20260910135158.2181141-6-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

Set the .ecn = 1 flag in both tunnel-mode security capability
entries to advertise that the driver supports ECN (Explicit
Congestion Notification) copying during IPsec encap/decap.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index 7e18e83858..16b8273a79 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -1004,6 +1004,7 @@ static const struct rte_security_capability dpaa2_sec_security_cap[] = {
 				.copy_df = 1,
 				.copy_dscp = 1,
 				.dec_ttl = 1,
+				.ecn = 1,
 				.esn = 1,
 			},
 			.replay_win_sz_max = 1024
@@ -1023,6 +1024,7 @@ static const struct rte_security_capability dpaa2_sec_security_cap[] = {
 				.copy_df = 1,
 				.copy_dscp = 1,
 				.dec_ttl = 1,
+				.ecn = 1,
 				.esn = 1,
 			},
 			.replay_win_sz_max = 1024
-- 
2.43.0

