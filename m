Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386EDCA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 11:44:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2956640F16;
	Tue,  6 Oct 2026 13:43:57 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 53B9F40A81
 for <dev@dpdk.org>; Tue,  6 Oct 2026 13:43:52 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 35E571A019B;
 Tue,  6 Oct 2026 13:43:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 01CF31A019A;
 Tue,  6 Oct 2026 13:43:52 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7233B180022D;
 Tue,  6 Oct 2026 19:43:51 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 4/6] crypto/dpaa2_sec: add missing ECN capability
Date: Tue,  6 Oct 2026 17:13:44 +0530
Message-Id: <20261006114346.1229651-5-g.singh@nxp.com>
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

Set the .ecn = 1 flag in both tunnel-mode security capability
entries to advertise that the driver supports ECN (Explicit
Congestion Notification) copying during IPsec encap/decap.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index b9a6440f78..94ba321c72 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -973,6 +973,7 @@ static const struct rte_security_capability dpaa2_sec_security_cap[] = {
 				.copy_df = 1,
 				.copy_dscp = 1,
 				.dec_ttl = 1,
+				.ecn = 1,
 				.esn = 1,
 			},
 			.replay_win_sz_max = 1024
@@ -992,6 +993,7 @@ static const struct rte_security_capability dpaa2_sec_security_cap[] = {
 				.copy_df = 1,
 				.copy_dscp = 1,
 				.dec_ttl = 1,
+				.ecn = 1,
 				.esn = 1,
 			},
 			.replay_win_sz_max = 1024
-- 
2.25.1

