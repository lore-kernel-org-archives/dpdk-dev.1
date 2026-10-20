Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92B606A322
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 574164064F;
	Tue, 20 Oct 2026 11:42:54 +0200 (CEST)
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com
 [115.124.28.170])
 by mails.dpdk.org (Postfix) with ESMTP id E55EA40270
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:42:51 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08164316|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00405544-0.00118809-0.994757;
 FP=10175283083069625556|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033071099199; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.jliCkLs_1792489368; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.jliCkLs_1792489368 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 20 Oct 2026 17:42:48 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: allow MTU change when port is started
Date: Tue, 20 Oct 2026 02:42:27 -0700
Message-Id: <20261020094227.166491-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020094227.166491-1-dimon.zhao@nebula-matrix.com>
References: <20261020094227.166491-1-dimon.zhao@nebula-matrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the dev_started check in nbl_mtu_set() to allow MTU
configuration while the port is started.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index e41732ccd3..2c1e39f559 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -753,18 +753,11 @@ int nbl_xstats_reset(struct rte_eth_dev *eth_dev)
 
 int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu)
 {
-	struct rte_eth_dev_data *dev_data = eth_dev->data;
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
 	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
 	int ret;
 
-	/* mtu setting is forbidden if port is started */
-	if (dev_data->dev_started) {
-		NBL_LOG(ERR, "port %d must be stopped before configuration", dev_data->port_id);
-		return -EBUSY;
-	}
-
 	ret = disp_ops->set_mtu(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id, mtu);
 	if (ret)
 		return ret;
-- 
2.34.1

