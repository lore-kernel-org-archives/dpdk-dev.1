Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B363CC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 10:18:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3A2B40E26;
	Mon, 13 Jul 2026 12:18:08 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id CB79F40E2E;
 Mon, 13 Jul 2026 12:18:06 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B230B200077;
 Mon, 13 Jul 2026 12:18:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C1712000AF;
 Mon, 13 Jul 2026 12:18:06 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 428BE1800226;
 Mon, 13 Jul 2026 18:18:05 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v5 12/18] net/dpaa: fix xstat name for tx undersized counter
Date: Mon, 13 Jul 2026 15:47:41 +0530
Message-Id: <20260713101747.2947405-13-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713101747.2947405-1-hemant.agrawal@nxp.com>
References: <20260713092616.2902828-1-hemant.agrawal@nxp.com>
 <20260713101747.2947405-1-hemant.agrawal@nxp.com>
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

The xstat entry mapping to 'tund' (TX undersized) was incorrectly
labeled as 'rx_undersized'. Fix the prefix to 'tx_undersized'.

Fixes: b21ed3e2a16d ("net/dpaa: support extended statistics")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index f679a6e781..da83b45831 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -125,7 +125,7 @@ static const struct rte_dpaa_xstats_name_off dpaa_xstats_strings[] = {
 		offsetof(struct dpaa_if_stats, terr)},
 	{"tx_vlan_frame",
 		offsetof(struct dpaa_if_stats, tvlan)},
-	{"rx_undersized",
+	{"tx_undersized",
 		offsetof(struct dpaa_if_stats, tund)},
 	{"rx_frame_counter",
 		offsetof(struct dpaa_if_rx_bmi_stats, fmbm_rfrc)},
-- 
2.25.1

