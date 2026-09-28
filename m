Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E4CC9833E
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:36:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B284E409FA;
	Mon, 28 Sep 2026 10:36:33 +0200 (CEST)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com
 [115.124.28.123])
 by mails.dpdk.org (Postfix) with ESMTP id F40A140269;
 Mon, 28 Sep 2026 10:36:28 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09334932|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00175121-0.00241498-0.995834;
 FP=9598510078058058964|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033022149254;
 MF=dimon.zhao@nebula-matrix.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.jQ-Zo0c_1790584585; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.jQ-Zo0c_1790584585 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 28 Sep 2026 16:36:26 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: allow MTU change when port is started
Date: Mon, 28 Sep 2026 01:36:16 -0700
Message-Id: <20260928083616.118559-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928083616.118559-1-dimon.zhao@nebula-matrix.com>
References: <20260928083616.118559-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Remove the dev_started check in nbl_mtu_set() to allow MTU
configuration while the port is started.

Fixes: 75cdda36a4c5 ("net/nbl: support MTU update")
Cc: stable@dpdk.org
Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 320f26619f..1c04fb8bfd 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -760,12 +760,6 @@ int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu)
 	uint32_t frame_size = mtu + NBL_ETH_OVERHEAD;
 	int ret;
 
-	/* mtu setting is forbidden if port is start */
-	if (dev_data->dev_started) {
-		NBL_LOG(ERR, "port %d must be stopped before configuration", dev_data->port_id);
-		return -EBUSY;
-	}
-
 	dev_data->dev_conf.rxmode.mtu = frame_size;
 	ret = disp_ops->set_mtu(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id, mtu);
 	if (ret)
-- 
2.34.1

