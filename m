Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8DCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 03:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58DD140E2B;
	Tue, 29 Sep 2026 05:52:52 +0200 (CEST)
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com
 [115.124.28.146])
 by mails.dpdk.org (Postfix) with ESMTP id 5402540E1F;
 Tue, 29 Sep 2026 05:52:49 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07902521|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0021618-0.00108671-0.996751;
 FP=10121512566554891476|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037006180; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.jQwErir_1790653965; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.jQwErir_1790653965 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 29 Sep 2026 11:52:45 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 1/1] net/nbl: fix incorrect MTU stored in rxmode
Date: Mon, 28 Sep 2026 20:52:35 -0700
Message-Id: <20260929035236.126778-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929035236.126778-1-dimon.zhao@nebula-matrix.com>
References: <20260929035236.126778-1-dimon.zhao@nebula-matrix.com>
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

The ethdev layer already updates dev->data->mtu on success.
After rte_eth_dev_configure(), dev_conf.rxmode.mtu becomes stale
and should not be modified by mtu_set.

Additionally, the original code assigned frame_size (MTU + overhead)
instead of MTU, confusing frame length with MTU.

Fixes: 75cdda36a4c5 ("net/nbl: support MTU update")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 320f26619f..e41732ccd3 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -757,16 +757,14 @@ int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu)
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
 	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
-	uint32_t frame_size = mtu + NBL_ETH_OVERHEAD;
 	int ret;
 
-	/* mtu setting is forbidden if port is start */
+	/* mtu setting is forbidden if port is started */
 	if (dev_data->dev_started) {
 		NBL_LOG(ERR, "port %d must be stopped before configuration", dev_data->port_id);
 		return -EBUSY;
 	}
 
-	dev_data->dev_conf.rxmode.mtu = frame_size;
 	ret = disp_ops->set_mtu(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id, mtu);
 	if (ret)
 		return ret;
-- 
2.34.1

