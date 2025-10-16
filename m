Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB32CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:28:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 741C542792;
	Thu, 16 Oct 2025 12:28:15 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id EDD7F40269;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2B95202EE3;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D7202013AD;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0B350180007B;
 Thu, 16 Oct 2025 18:28:09 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: stable@dpdk.org,
	Brick Yang <brick.yang@nxp.com>
Subject: [PATCH v2 04/15] net/dpaa2: fix to recv packets with additional parse
 errors
Date: Thu, 16 Oct 2025 15:57:54 +0530
Message-ID: <20251016102805.2453687-5-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
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

From: Brick Yang <brick.yang@nxp.com>

Also receive packets with HW parser length errors.
Thus this option allows HW to not drop packets for any kind of parser
errors.

Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
Cc: stable@dpdk.org

Signed-off-by: Brick Yang <brick.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 41678ce09b..0fd577c448 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1240,7 +1240,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		err_cfg.errors = DPNI_ERROR_L3CE | DPNI_ERROR_L4CE;
 
 		/* if packet with parse error are not to be dropped */
-		err_cfg.errors |= DPNI_ERROR_PHE;
+		err_cfg.errors |= DPNI_ERROR_PHE | DPNI_ERROR_BLE;
 
 		err_cfg.error_action = DPNI_ERROR_ACTION_CONTINUE;
 	}
-- 
2.43.0

