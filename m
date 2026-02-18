Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD59E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8883402C5;
	Wed, 18 Feb 2026 11:45:49 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 6F0C5402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:45:48 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6845F7A0169;
 Wed, 18 Feb 2026 05:45:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 18 Feb 2026 05:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1771411547; x=1771497947; bh=cGPZxjqR8+4cMcybVYaNN
 AIyiu7Kmr170A55P8pNUnM=; b=klJq84Ev04tE3CYQLooXyY60nroCv+TdpXBMB
 YWPe33qBk8dJ0BexKU/rYuTJiT2fQRa/iiGZngI5jxYfCh40lu4+/Wfh+gbLOIiq
 C2wF4av452gxVSkG8e6DjSf8oW18eKiWY0SCyHFtgbq/DGN5WKX4q/O0x2QLQnpW
 BAi0kyoIgvL+C7TIqUHkJvZqA+fRXmL+E0rmDQoRjrwNy4P7jT/S0FnbaiOat7wl
 ONa5nf3g6wLnpPdUELiegJYaONQwpU7WbmftBopo7ZbuYueB4uADhu8JRkDdjkL0
 tumOe/okYbY0EypQpYx86sugQoMXYTgcWXKf8aOFGUYjY8Oog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1771411547; x=1771497947; bh=cGPZxjqR8+4cMcybVYaNNAIyiu7Kmr170A5
 5P8pNUnM=; b=AKD4XjQGTPSH/Ixs+RGnn0gWb39wPsrnIyTI4SC7ZYHYI5YS4Yn
 F6FgDnHt5IwMVGknAz/GeAMHiO3zOusXwXaNwWi0vZGGC2zCHuTa4bO7o45QOcnb
 R95tfX8ZkWCF1obHw79ye3ipIe7PRjOaKtGhIZzzfoYhn1fTezEqjMrUrP/P7+Lt
 Ts/523TkqA9vtITSMdXWDudD/Vwq/a0u/GZHSSGHjQ3ANVbxryvEp/aH0z/QdxW3
 EHwUZlGO9kEwsCLcSIRDsX0BLwKofGgCgh+i1bKCoq6CFabKVQbd7hD5T3xUVRlb
 lAXfp8K/ltCnyzUQ3YkDimv7+E5WFsTfblA==
X-ME-Sender: <xms:WpiVaW__gelKsXYP0c3QEoONWARZSa0aoduwXPJddRrMTNmtZI3RNA>
 <xme:WpiVaQzceEanprwyUQD-Sue3rd7ODd-RdLoGwxImdQHgdfLDznSN5QvpsDxK7FH91
 HcloxW5DW8hZxwxzKw5oL9kor71xw4bKonZWhHKfTWM1KiJ7F75hg>
X-ME-Received: <xmr:WpiVab7UEk6GVWyquPDmsVu9cFrZMOMeDGFPR9MKjdZLnsobDJpAmccaUIE6_k3em3wJT1NRQzYP0-ngyC37MmApluBN7CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddvgeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopeifrghnghhfvghifhgvihegtdeshhhurgifvghirdgtohhmpdhrtghpthhtoheprghn
 ughrvgifrdgsohihvghrsegrmhgurdgtohhmpdhrtghpthhtohepjhhirgifvghnfihuse
 htrhhushhtnhgvthhitgdrtghomhdprhgtphhtthhopeiirghihihufigrnhhgsehtrhhu
 shhtnhgvthhitgdrtghomhdprhgtphhtthhopehvrghtthhunhhurhhusehmrghrvhgvlh
 hlrdgtohhmpdhrtghpthhtoheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvght
 lhgrsghsrdhruhdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvg
 hlrdgtohhm
X-ME-Proxy: <xmx:WpiVaf9DuJoh9EG8jxSgz69sDPqW2GR_sdciuv-_d3SsSi9uOgFfxw>
 <xmx:WpiVaYrLLNI6eDSczMau_vOPCC0z9ohP1k0E5u-jVQqUzJkGR9RtYw>
 <xmx:WpiVaYrDEYA2dk94edn72J29nbnJbzO-0ktm6aRkpXzvRWhVpC31XA>
 <xmx:WpiVaT3MtJSWTIXeHwmJGk-rNGdwx_V3E46gVhWLuEr5ic7iDeEceQ>
 <xmx:W5iVacvZLyJk9fzX_tefgfMUxucwo1ZO5Tho_FukK_o66sY_WMsTW0fS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 05:45:44 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>, Andrew Boyer <andrew.boyer@amd.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] drivers/net: remove redundant callbacks cleanup
Date: Wed, 18 Feb 2026 11:45:24 +0100
Message-ID: <20260218104524.2780167-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
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

Some callbacks are set to NULL in the release process.
It is not needed as it is already done in rte_eth_dev_release_port()
called by rte_eth_dev_close(), rte_eth_dev_destroy()
or rte_eth_dev_pci_generic_remove().

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/hinic3/hinic3_ethdev.c    |  4 ----
 drivers/net/ionic/ionic_ethdev.c      |  5 -----
 drivers/net/ngbe/ngbe_ethdev_vf.c     |  3 ---
 drivers/net/octeon_ep/otx_ep_ethdev.c | 10 +---------
 drivers/net/sfc/sfc_repr.c            |  4 ----
 drivers/net/txgbe/txgbe_ethdev_vf.c   |  3 ---
 6 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 0e25175ba1..0f72728a95 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2044,10 +2044,6 @@ hinic3_dev_release(struct rte_eth_dev *eth_dev)
 	hinic3_free_nic_hwdev(nic_dev->hwdev);
 	hinic3_free_hwdev(nic_dev->hwdev);
 
-	eth_dev->rx_pkt_burst = NULL;
-	eth_dev->tx_pkt_burst = NULL;
-	eth_dev->dev_ops = NULL;
-
 	rte_free(nic_dev->hwdev);
 	nic_dev->hwdev = NULL;
 }
diff --git a/drivers/net/ionic/ionic_ethdev.c b/drivers/net/ionic/ionic_ethdev.c
index 6e9cd5f7eb..d2888d9650 100644
--- a/drivers/net/ionic/ionic_ethdev.c
+++ b/drivers/net/ionic/ionic_ethdev.c
@@ -1112,11 +1112,6 @@ eth_ionic_dev_uninit(struct rte_eth_dev *eth_dev)
 	if (eth_dev->state != RTE_ETH_DEV_UNUSED)
 		ionic_dev_close(eth_dev);
 
-	eth_dev->dev_ops = NULL;
-	eth_dev->rx_pkt_burst = NULL;
-	eth_dev->tx_pkt_burst = NULL;
-	eth_dev->tx_pkt_prepare = NULL;
-
 	return 0;
 }
 
diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index e575c47049..6406df40d0 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -746,9 +746,6 @@ ngbevf_dev_close(struct rte_eth_dev *dev)
 	 **/
 	ngbevf_remove_mac_addr(dev, 0);
 
-	dev->rx_pkt_burst = NULL;
-	dev->tx_pkt_burst = NULL;
-
 	/* Disable the interrupts for VF */
 	ngbevf_intr_disable(dev);
 
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index f7f927a4e7..99be30523a 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -656,12 +656,8 @@ otx_ep_dev_close(struct rte_eth_dev *eth_dev)
 	struct otx_ep_device *otx_epvf;
 	uint32_t num_queues, q_no;
 
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
-		eth_dev->dev_ops = NULL;
-		eth_dev->rx_pkt_burst = NULL;
-		eth_dev->tx_pkt_burst = NULL;
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
-	}
 
 	otx_epvf = OTX_EP_DEV(eth_dev);
 	otx_ep_mbox_send_dev_exit(eth_dev);
@@ -731,10 +727,6 @@ otx_ep_eth_dev_uninit(struct rte_eth_dev *eth_dev)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
 		otx_ep_mbox_uninit(eth_dev);
 
-	eth_dev->dev_ops = NULL;
-	eth_dev->rx_pkt_burst = NULL;
-	eth_dev->tx_pkt_burst = NULL;
-
 	return 0;
 }
 
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index fbb5f58a8e..4ccdf8358b 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -820,10 +820,6 @@ sfc_repr_dev_close(struct rte_eth_dev *dev)
 
 	sfc_mae_clear_switch_port(srs->switch_domain_id, srs->switch_port_id);
 
-	dev->rx_pkt_burst = NULL;
-	dev->tx_pkt_burst = NULL;
-	dev->dev_ops = NULL;
-
 	sfc_repr_unlock(sr);
 	sfc_repr_lock_fini(sr);
 
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index f6fd2b1557..39a5fff65c 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -862,9 +862,6 @@ txgbevf_dev_close(struct rte_eth_dev *dev)
 	 **/
 	txgbevf_remove_mac_addr(dev, 0);
 
-	dev->rx_pkt_burst = NULL;
-	dev->tx_pkt_burst = NULL;
-
 	/* Disable the interrupts for VF */
 	txgbevf_intr_disable(dev);
 
-- 
2.52.0

