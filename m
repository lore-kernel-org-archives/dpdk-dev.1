Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA19DCF34A1
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 13:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D658D40265;
	Wed, 19 Nov 2025 14:03:49 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 1901E40262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 14:03:49 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 8BD93EC0211;
 Wed, 19 Nov 2025 08:03:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 08:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1763557428; x=1763643828; bh=63oxyiJtKig7055z3BwGp
 y4kdcEFRD6zqMe7XzF7Qbw=; b=YvECPNUGN/lCDBQnKtad10l0PNkKxC/ISyqJB
 8bRRebTuktqRQsXsZljuGYfWy6ja+2yBLmGqmOy1RSVP2+kQvbAxVDNqqkGbRBZe
 5CUbCNGHa1qXfQz6/Uz4Ep7gHZm7DQwk6+LjrepJwpIm31tpVh23TKF/M8F1ZEJe
 g1lzCahy1KGa0+ZjqJB1Uq/a3zyy4zbV0bMRtW9bFkZPW/WPg1HAvDhLFCuMozu2
 aV5MSWIGgiuGfMQtfniVXSQgV4i4gyA2Cr3UGxpQBCoImnnt5AQj6CVfoGoynqf8
 cMLtGoGx4IYtbL15A24/JpQfCq9dpI+RBSOxyUoI1/ZPgXEIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1763557428; x=1763643828; bh=63oxyiJtKig7055z3BwGpy4kdcEFRD6zqMe
 7XzF7Qbw=; b=d/MK8LXsenADpcj8ojHiTcb1gKkTFS8K6QOOn3zh7w5PKKyCYPy
 cdYsGb3i1ZCTcmV9bXlI4ZXNvSWgfRqbU4gUQfCRp+YWBJqoDPEgzJ/AwgXjcVzx
 TdtGGMbzYz+Ib0eqgY1sLuRuyhht6RrluAjO9g2ID4YNgH4bfwk8YBpc7UPqDbkN
 a+LGDDQFpvTEqoiTSFYWG4I4elZH+VLrEoNeIYIjU4Z4jAECR6F4yCqiii24iwyb
 V9NzpmqOPzdKln74zstarhIkzKFfhqjHp4eAqTUyBGVJhF1HA6kaB7rOUI87bXhk
 ZHoy6sBcS2LD+cezUhBrPnE3Zuy2JwtepOg==
X-ME-Sender: <xms:M8AdaeCvYJsRVgKJABGq_obmIhhn6osfmHGFsemHFCEVWwPr4sRx5g>
 <xme:M8AdaUb1kl-wnPm_RgvfSywdUQbNIWqo_ltXkOo1ckgaqfhLpoXeQYL2awVMG--OS
 QeJ5ZmBz2FdTeNHbMuiSQKsqeFKEQHU3AIngQstzXapAzTbDyrwLA>
X-ME-Received: <xmr:M8AdaeltQlp1rNMtHa0Z0Ig_mT3sCa0i0Pb1hNn71fSnlJaIgBtBUy4XRQyctYzcya6hEaoCoA31FOiiKFPeRm4Cq7yEPWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegvdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepjhhirgifvghnfihusehtrhhushhtnhgvthhitgdrtghomhdprhgtphhtthhopeih
 rghnghigihhnghhuiheshhhurgifvghirdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvg
 hnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopeiirghihihufigrnhhgseht
 rhhushhtnhgvthhitgdrtghomhdprhgtphhtthhopegtkhhmsehnrghprghtvggthhdrtg
 homhdprhgtphhtthhopehsihhlqdhplhhvsehnrghprghtvggthhdrtghomhdprhgtphht
 thhopegtrhhishhtihgrnhdrughumhhithhrvghstghusehinhhtvghlrdgtohhmpdhrtg
 hpthhtohepjhhirghnfigrnhhgsehtrhhushhtnhgvthhitgdrtghomh
X-ME-Proxy: <xmx:M8AdaRqNBTs75ICz3_-Vrogrgk7CBYFnIHOy9Usf8X3ti2MT1wEWdA>
 <xmx:M8AdaYCpa4YtpFJX9rFaf4RjHaTC89DjOKwpQqEhWaiItDgwvILcDA>
 <xmx:M8AdacFozmqe6QKOf0qffDeaZQ9pv7zRGSYeBcEVwzZWRHvJUcOb2A>
 <xmx:M8Adaa2WdiL9eF_Kb0fe11y2VaHuC2vfxtnwrkMZr4atbPhGW2g6VA>
 <xmx:NMAdaRZaFEPP_s-IVqs78W4PxFyjyxZaK7WQ1SHF80NlQJ8_PTpgnHoI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 08:03:45 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jian Wang <jianwang@trustnetic.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH] drivers/net: fix Tx packet prepare
Date: Wed, 19 Nov 2025 14:03:33 +0100
Message-ID: <20251119130333.2697937-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
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

After removing callback checks from ethdev fast path,
some drivers crashed because tx_pkt_prepare was set to NULL.

Some drivers (hns3, ngbe, txgbe) need to use rte_eth_tx_pkt_prepare_dummy
when configuring queues.
Other drivers (ntnic, softnic) does not need to set tx_pkt_prepare
as it was set by eth_dev_set_dummy_fops() called by rte_eth_dev_allocate().

Bugzilla ID: 1834
Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")

Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/hns3/hns3_rxtx.c          | 4 ++--
 drivers/net/ngbe/ngbe_rxtx.c          | 2 +-
 drivers/net/ntnic/ntnic_ethdev.c      | 1 -
 drivers/net/softnic/rte_eth_softnic.c | 1 -
 drivers/net/txgbe/txgbe_rxtx.c        | 2 +-
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index df703134be..3a99923220 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -4561,7 +4561,7 @@ hns3_set_rxtx_function(struct rte_eth_dev *eth_dev)
 	} else {
 		eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
 		eth_dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
-		eth_dev->tx_pkt_prepare = NULL;
+		eth_dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 	}
 
 	hns3_trace_rxtx_function(eth_dev);
@@ -4917,7 +4917,7 @@ void
 hns3_stop_tx_datapath(struct rte_eth_dev *dev)
 {
 	dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
-	dev->tx_pkt_prepare = NULL;
+	dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 	hns3_eth_dev_fp_ops_config(dev);
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index 66d72c88df..91e215694c 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -1921,7 +1921,7 @@ ngbe_set_tx_function(struct rte_eth_dev *dev, struct ngbe_tx_queue *txq)
 	if (txq->offloads == 0 &&
 			txq->tx_free_thresh >= RTE_PMD_NGBE_TX_MAX_BURST) {
 		PMD_INIT_LOG(DEBUG, "Using simple tx code path");
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 		if (txq->tx_free_thresh <= RTE_NGBE_TX_MAX_FREE_BUF_SZ &&
 				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128 &&
 				(rte_eal_process_type() != RTE_PROC_PRIMARY ||
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 23c3452d2d..89e751e7e0 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2561,7 +2561,6 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		NT_LOG_DBGX(DBG, NTNIC, "Setting up RX functions for SCG");
 		eth_dev->rx_pkt_burst = eth_dev_rx_scg;
 		eth_dev->tx_pkt_burst = eth_dev_tx_scg;
-		eth_dev->tx_pkt_prepare = NULL;
 
 		struct rte_eth_link pmd_link;
 		pmd_link.link_speed = RTE_ETH_SPEED_NUM_NONE;
diff --git a/drivers/net/softnic/rte_eth_softnic.c b/drivers/net/softnic/rte_eth_softnic.c
index 91a1c3a98e..868e194509 100644
--- a/drivers/net/softnic/rte_eth_softnic.c
+++ b/drivers/net/softnic/rte_eth_softnic.c
@@ -312,7 +312,6 @@ pmd_ethdev_register(struct rte_vdev_device *vdev,
 	/* dev */
 	dev->rx_pkt_burst = pmd_rx_pkt_burst;
 	dev->tx_pkt_burst = pmd_tx_pkt_burst;
-	dev->tx_pkt_prepare = NULL;
 	dev->dev_ops = &pmd_ops;
 	dev->device = &vdev->device;
 
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 78199ea00b..e2cd9b8841 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -2344,7 +2344,7 @@ txgbe_set_tx_function(struct rte_eth_dev *dev, struct txgbe_tx_queue *txq)
 #endif
 			txq->tx_free_thresh >= RTE_PMD_TXGBE_TX_MAX_BURST) {
 		PMD_INIT_LOG(DEBUG, "Using simple tx code path");
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 		if (txq->tx_free_thresh <= RTE_TXGBE_TX_MAX_FREE_BUF_SZ &&
 				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128 &&
 				(rte_eal_process_type() != RTE_PROC_PRIMARY ||
-- 
2.51.0

