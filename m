Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9399BC624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B560442E7D;
	Thu,  3 Sep 2026 15:54:45 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2536142E62
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:37 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A9C1200492;
 Thu,  3 Sep 2026 15:54:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8D43200480;
 Thu,  3 Sep 2026 15:54:36 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BA05018000B7;
 Thu,  3 Sep 2026 21:54:35 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 34/45] net/dpaa2: remove unused soft parser Tx code
Date: Thu,  3 Sep 2026 19:23:42 +0530
Message-ID: <20260903135353.3358303-35-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Remove the soft parser related code from the Tx path. The soft parser
can only be loaded before Linux boots, so this code was never reachable
at runtime.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index eda88a7bed..5c6a77d2f8 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -169,16 +169,6 @@ dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 			ext_packet_type |= RTE_PTYPE_INNER_L3_IPV4;
 		}
 	}
-	if (priv->sp_protocol) {
-		if (frc_parse->fafe2) {
-			frc_parse->fafe2 = 0;
-			ext_packet_type |= RTE_PTYPE_TUNNEL_GENEVE;
-		}
-		if (frc_parse->sum_l.l4.fafe3) {
-			frc_parse->sum_l.l4.fafe3 = 0;
-			ext_packet_type |= RTE_PTYPE_INNER_L3_IPV4;
-		}
-	}
 	switch (frc) {
 	case DPAA2_PKT_TYPE_IPV4_UDP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
-- 
2.43.0

