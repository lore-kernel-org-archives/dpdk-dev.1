Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928D7CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:21:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3193940DD5;
	Fri, 16 Oct 2026 13:20:47 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4C01340671
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:20:09 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2FFC82001F8;
 Fri, 16 Oct 2026 13:20:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03F1A20000B;
 Fri, 16 Oct 2026 13:20:09 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 727EE18000B1;
 Fri, 16 Oct 2026 19:20:08 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v27 20/25] net/dpaa: create max Rx queues in FMCLESS mode
Date: Fri, 16 Oct 2026 16:49:53 +0530
Message-Id: <20261016111958.163060-21-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016111958.163060-1-hemant.agrawal@nxp.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

In FMCLESS mode, create DPAA_MAX_NUM_PCD_QUEUES Rx frame queues
instead of one per lcore, since several queues may be polled from
the same core. configure() selects how many are used.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index f044a0a3b9..cefeb2ce0f 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2296,8 +2296,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 				dpaa_intf->name);
 		}
 	} else {
-		/* FMCLESS mode, load balance to multiple cores.*/
-		num_rx_fqs = rte_lcore_count();
+		/* FMCLESS: create the max; configure() picks how many are used. */
+		num_rx_fqs = DPAA_MAX_NUM_PCD_QUEUES;
 	}
 
 	/* Each device can not have more than DPAA_MAX_NUM_PCD_QUEUES RX
-- 
2.25.1

