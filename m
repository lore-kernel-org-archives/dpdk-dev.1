Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7714606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29BAB4066C;
	Thu, 26 Nov 2026 08:34:48 +0100 (CET)
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com
 [115.124.28.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 88DB540284
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:43 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712908|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.0389827-0.00785645-0.953161;
 FP=15449031208222754773|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037006180; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1Yu._1795678479; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1Yu._1795678479 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:40 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 06/11] net/nbl: add draco device layer
Date: Thu, 26 Nov 2026 15:34:23 +0800
Message-ID: <20261126073430.3168813-7-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use common SNIC device lifecycle callbacks for leonis and draco.
Connect draco channel setup and teardown, mailbox interrupts,
MAC and multicast rules, statistics and link state initialization.

Reject draco PFs operating without kernel coexistence.

Keep draco device configuration disabled until its datapath
extended headers are implemented.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c | 62 +++++++++++++------------------
 drivers/net/nbl/nbl_dispatch.c    |  2 +-
 2 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index f5880f9..643cc74 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -20,6 +20,10 @@ int nbl_dev_configure(struct rte_eth_dev *eth_dev)
 	if (dev_data == NULL || adapter == NULL)
 		return -EINVAL;
 
+	/* Keep the draco datapath disabled until its extended headers are supported. */
+	if (adapter->caps.product_type == NBL_DRACO_TYPE)
+		return -ENOTSUP;
+
 	NBL_LOG(DEBUG, "Begin to configure the device, state: %d", adapter->state);
 
 	dev_data->dev_conf.intr_conf.lsc = 0;
@@ -837,12 +841,21 @@ static int nbl_dev_teardown_chan_queue(struct nbl_adapter *adapter)
 	return ret;
 }
 
-static int nbl_dev_leonis_init(void *adapter)
+static int nbl_dev_snic_init(void *p)
 {
-	return nbl_dev_setup_chan_queue((struct nbl_adapter *)adapter);
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+
+	if (adapter->caps.product_type == NBL_DRACO_TYPE &&
+	    !NBL_IS_COEXISTENCE(common) && !common->is_vf) {
+		NBL_LOG(ERR, "draco PF only supports coexistence");
+		return -ENOTSUP;
+	}
+
+	return nbl_dev_setup_chan_queue(adapter);
 }
 
-static void nbl_dev_leonis_uninit(void *adapter)
+static void nbl_dev_snic_uninit(void *adapter)
 {
 	nbl_dev_teardown_chan_queue((struct nbl_adapter *)adapter);
 }
@@ -959,7 +972,7 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 	return ret;
 }
 
-static int nbl_dev_leonis_start(void *p)
+static int nbl_dev_snic_start(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
@@ -977,7 +990,7 @@ static int nbl_dev_leonis_start(void *p)
 	return 0;
 }
 
-static void nbl_dev_leonis_stop(void *p)
+static void nbl_dev_snic_stop(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
@@ -1326,41 +1339,18 @@ int nbl_dev_start(void *p)
 	return 0;
 }
 
-static int nbl_dev_draco_init(void *adapter)
-{
-	RTE_SET_USED(adapter);
-	/* Keep probing disabled until the Draco device layer is implemented. */
-	return -ENOTSUP;
-}
-
-static void nbl_dev_draco_uninit(void *adapter)
-{
-	RTE_SET_USED(adapter);
-}
-
-static int nbl_dev_draco_start(void *adapter)
-{
-	RTE_SET_USED(adapter);
-	return 0;
-}
-
-static void nbl_dev_draco_stop(void *adapter)
-{
-	RTE_SET_USED(adapter);
-}
-
 const struct nbl_product_dev_ops nbl_product_dev_ops[NBL_PRODUCT_MAX] = {
 	[NBL_LEONIS_TYPE] = {
-		.dev_init	= nbl_dev_leonis_init,
-		.dev_uninit	= nbl_dev_leonis_uninit,
-		.dev_start	= nbl_dev_leonis_start,
-		.dev_stop	= nbl_dev_leonis_stop,
+		.dev_init	= nbl_dev_snic_init,
+		.dev_uninit	= nbl_dev_snic_uninit,
+		.dev_start	= nbl_dev_snic_start,
+		.dev_stop	= nbl_dev_snic_stop,
 	},
 	[NBL_DRACO_TYPE] = {
-		.dev_init	= nbl_dev_draco_init,
-		.dev_uninit	= nbl_dev_draco_uninit,
-		.dev_start	= nbl_dev_draco_start,
-		.dev_stop	= nbl_dev_draco_stop,
+		.dev_init	= nbl_dev_snic_init,
+		.dev_uninit	= nbl_dev_snic_uninit,
+		.dev_start	= nbl_dev_snic_start,
+		.dev_stop	= nbl_dev_snic_stop,
 	},
 };
 
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index 1bca326..dae62e1 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -1469,7 +1469,7 @@ static int nbl_disp_draco_init(void *p)
 	struct nbl_common_info *common = disp_mgt->common;
 	int ret;
 
-	if (common->devfd == -1 && !common->is_vf)
+	if (!NBL_IS_COEXISTENCE(common) && !common->is_vf)
 		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
 	else
 		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
-- 
2.53.0

