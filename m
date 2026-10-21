Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E0606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SbTadF4f
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99C8940B8F;
	Wed, 21 Oct 2026 12:31:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 94D1F40DCB
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/g7h9xP42wdNZPOZRBm+LWikqJQpKTPxcbox851y4o=;
 b=SbTadF4fKVNw2VGCYKvtfH5pt4XVjjLGdLFZ9GNmiFuDacXX3j0mRd9DD6sg7E7wj2Kkco
 weJN0jDxOeHEe1lyT/xtQ+xfbRMkGXV8tO5BwlVcN3aEfFLNHGC+Qx/tC+8VG1aidr2/CE
 +rhwPmfwb0Q3ZWJ9P9DuCCsJnvP64Ws=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-qJ1yd7z0OAeGPUfEEgx7rQ-1; Wed,
 21 Oct 2026 10:31:37 +0000
X-MC-Unique: qJ1yd7z0OAeGPUfEEgx7rQ-1
X-Mimecast-MFC-AGG-ID: qJ1yd7z0OAeGPUfEEgx7rQ_1792578694
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4073D1800BDD; Wed, 21 Oct 2026 10:31:34 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB34E418; Wed, 21 Oct 2026 10:31:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Selwin Sebastian <selwin.sebastian@amd.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Zyta Szpak <zyta@marvell.com>,
 Liron Himi <lironh@marvell.com>, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Junlong Wang <wang.junlong1@zte.com.cn>,
 Ming Ran <ran.ming@zte.com.cn>
Subject: [PATCH v2 12/12] ethdev: check unknown Rx/Tx multi-queue modes
Date: Wed, 21 Oct 2026 12:30:26 +0200
Message-ID: <20261021103027.2050351-13-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uNVBNjNYn0QGQ6htS5giZPJIIiV7RbTZxgSse_0DDr0_1792578694
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add validation in rte_eth_dev_configure() to reject invalid multi-queue
mode values early, before passing them to drivers.
If we do not enforce valid values are passed by an application,
this application might face issues in the future when we add more modes.

For Rx mq_mode, reject any bits outside the defined RSS, DCB, and VMDq
flags.
For Tx mq_mode, reject values greater than RTE_ETH_MQ_TX_VMDQ_ONLY.

Thanks to this, many drivers can stop caring about unexpected modes.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- updated axgbe, igc, thunderx, 

---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/axgbe/axgbe_ethdev.c       | 21 ++-------------------
 drivers/net/bnxt/bnxt_rxq.c            | 14 ++------------
 drivers/net/cnxk/cnxk_ethdev.c         | 11 -----------
 drivers/net/cnxk/cnxk_rep_ops.c        | 14 --------------
 drivers/net/intel/cpfl/cpfl_ethdev.c   | 13 -------------
 drivers/net/intel/e1000/igb_ethdev.c   | 15 +--------------
 drivers/net/intel/e1000/igc_ethdev.c   | 19 -------------------
 drivers/net/intel/e1000/igc_txrx.c     | 19 +++----------------
 drivers/net/intel/idpf/idpf_ethdev.c   |  6 ------
 drivers/net/mvneta/mvneta_ethdev.c     |  7 -------
 drivers/net/mvpp2/mrvl_ethdev.c        |  7 -------
 drivers/net/nbl/nbl_dev/nbl_dev.c      |  6 ------
 drivers/net/nfp/nfp_net_common.c       |  8 --------
 drivers/net/octeontx/octeontx_ethdev.c | 10 ----------
 drivers/net/qede/qede_ethdev.c         |  5 -----
 drivers/net/sfc/sfc_repr.c             | 14 --------------
 drivers/net/sfc/sfc_rx.c               | 22 ++--------------------
 drivers/net/sfc/sfc_tx.c               |  9 ---------
 drivers/net/thunderx/nicvf_ethdev.c    | 20 ++++----------------
 drivers/net/virtio/virtio_ethdev.c     | 14 --------------
 drivers/net/zxdh/zxdh_ethdev.c         | 19 -------------------
 lib/ethdev/rte_ethdev.c                | 17 +++++++++++++++++
 23 files changed, 32 insertions(+), 259 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index caffd2a611..4c00f51d89 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -433,6 +433,7 @@ API Changes
   * VMDq modes (Rx ``RTE_ETH_MQ_RX_VMDQ_FLAG``,
     Tx ``RTE_ETH_MQ_TX_VMDQ_DCB``/``RTE_ETH_MQ_TX_VMDQ_ONLY``) are rejected
     if the driver reports no VMDq pool.
+  * Unknown Rx and Tx modes are rejected.
 
 * ethdev: Updated VMDq related API.
 
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 93e198ba95..2411e74d97 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -353,20 +353,6 @@ axgbe_dev_configure(struct rte_eth_dev *dev)
 	return 0;
 }
 
-static int
-axgbe_dev_rx_mq_config(struct rte_eth_dev *dev)
-{
-	struct axgbe_port *pdata = dev->data->dev_private;
-
-	if (dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS)
-		pdata->rss_enable = 1;
-	else if (dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_NONE)
-		pdata->rss_enable = 0;
-	else
-		return  -1;
-	return 0;
-}
-
 static int
 axgbe_dev_start(struct rte_eth_dev *dev)
 {
@@ -379,11 +365,8 @@ axgbe_dev_start(struct rte_eth_dev *dev)
 	PMD_INIT_FUNC_TRACE();
 
 	/* Multiqueue RSS */
-	ret = axgbe_dev_rx_mq_config(dev);
-	if (ret) {
-		PMD_DRV_LOG_LINE(ERR, "Unable to config RX MQ");
-		return ret;
-	}
+	pdata->rss_enable = dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS;
+
 	ret = axgbe_phy_reset(pdata);
 	if (ret) {
 		PMD_DRV_LOG_LINE(ERR, "phy reset failed");
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 9743296b39..11115db1fd 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -85,18 +85,8 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
 
 	bp->nr_vnics = 0;
 
-	/* Multi-queue mode */
-	switch (dev_conf->rxmode.mq_mode) {
-	case RTE_ETH_MQ_RX_NONE:
-	case RTE_ETH_MQ_RX_RSS:
-		pools = bp->rx_cosq_cnt ? bp->rx_cosq_cnt : pools;
-		break;
-	default:
-		PMD_DRV_LOG_LINE(ERR, "Unsupported mq_mode %d",
-				 dev_conf->rxmode.mq_mode);
-		return -EINVAL;
-	}
-
+	if (bp->rx_cosq_cnt)
+		pools = bp->rx_cosq_cnt;
 	pools = RTE_MIN(pools, bp->rx_cp_nr_rings);
 	nb_q_per_grp = bp->rx_cp_nr_rings / pools;
 	PMD_DRV_LOG_LINE(DEBUG, "pools = %u nb_q_per_grp = %u",
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 9a4da870cd..0bd0302d6a 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -1485,17 +1485,6 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		goto fail_configure;
 	}
 
-	if (rxmode->mq_mode != RTE_ETH_MQ_RX_NONE &&
-	    rxmode->mq_mode != RTE_ETH_MQ_RX_RSS) {
-		plt_err("Unsupported mq rx mode %d", rxmode->mq_mode);
-		goto fail_configure;
-	}
-
-	if (txmode->mq_mode != RTE_ETH_MQ_TX_NONE) {
-		plt_err("Unsupported mq tx mode %d", txmode->mq_mode);
-		goto fail_configure;
-	}
-
 	/* Free the resources allocated from the previous configure */
 	if (dev->configured == 1) {
 		/* Unregister queue irq's */
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_ops.c
index d472cc4b08..d4f260af20 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -142,20 +142,6 @@ rep_eth_conf_chk(const struct rte_eth_conf *conf)
 		ret = -EINVAL;
 	}
 
-	switch (conf->rxmode.mq_mode) {
-	case RTE_ETH_MQ_RX_NONE:
-		break;
-	default:
-		plt_err("Rx mode MQ modes other than none not supported");
-		ret = -EINVAL;
-		break;
-	}
-
-	if (conf->txmode.mq_mode != RTE_ETH_MQ_TX_NONE) {
-		plt_err("Tx mode MQ modes not supported");
-		ret = -EINVAL;
-	}
-
 	if (conf->lpbk_mode != 0) {
 		plt_err("loopback not supported");
 		ret = -EINVAL;
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 57a46b0ecc..1667ff69a4 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -707,12 +707,6 @@ cpfl_dev_configure(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 
-	if (conf->txmode.mq_mode != RTE_ETH_MQ_TX_NONE) {
-		PMD_INIT_LOG(ERR, "Multi-queue TX mode %d is not supported",
-			     conf->txmode.mq_mode);
-		return -ENOTSUP;
-	}
-
 	if (conf->lpbk_mode != 0) {
 		PMD_INIT_LOG(ERR, "Loopback operation mode %d is not supported",
 			     conf->lpbk_mode);
@@ -739,13 +733,6 @@ cpfl_dev_configure(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 
-	if (conf->rxmode.mq_mode != RTE_ETH_MQ_RX_RSS &&
-	    conf->rxmode.mq_mode != RTE_ETH_MQ_RX_NONE) {
-		PMD_INIT_LOG(ERR, "RX mode %d is not supported.",
-			     conf->rxmode.mq_mode);
-		return -EINVAL;
-	}
-
 	if (base->caps.rss_caps != 0 && dev->data->nb_rx_queues != 0) {
 		ret = cpfl_init_rss(vport);
 		if (ret != 0) {
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index 181af58169..c65a468b26 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -1179,25 +1179,12 @@ igb_check_mq_mode(struct rte_eth_dev *dev)
 			return -EINVAL;
 		}
 	} else {
-		/* To no break software that set invalid mode, only display
-		 * warning if invalid mode is used.
-		 */
-		if (rx_mq_mode != RTE_ETH_MQ_RX_NONE &&
-		    rx_mq_mode != RTE_ETH_MQ_RX_VMDQ_ONLY &&
-		    rx_mq_mode != RTE_ETH_MQ_RX_RSS) {
+		if (rx_mq_mode == RTE_ETH_MQ_RX_VMDQ_RSS) {
 			/* RSS together with VMDq not supported*/
 			PMD_INIT_LOG(ERR, "RX mode %d is not supported.",
 				     rx_mq_mode);
 			return -EINVAL;
 		}
-
-		if (tx_mq_mode != RTE_ETH_MQ_TX_NONE &&
-		    tx_mq_mode != RTE_ETH_MQ_TX_VMDQ_ONLY) {
-			PMD_INIT_LOG(WARNING, "TX mode %d is not supported."
-					" Due to txmode is meaningless in this"
-					" driver, just ignore.",
-					tx_mq_mode);
-		}
 	}
 	return 0;
 }
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 73dd5dd1a3..2c8ff57e6b 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -344,30 +344,11 @@ static const struct eth_dev_ops eth_igc_ops = {
 static int
 igc_check_mq_mode(struct rte_eth_dev *dev)
 {
-	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
-	enum rte_eth_tx_mq_mode tx_mq_mode = dev->data->dev_conf.txmode.mq_mode;
-
 	if (RTE_ETH_DEV_SRIOV(dev).active != 0) {
 		PMD_INIT_LOG(ERR, "SRIOV is not supported.");
 		return -EINVAL;
 	}
 
-	if (rx_mq_mode != RTE_ETH_MQ_RX_NONE &&
-		rx_mq_mode != RTE_ETH_MQ_RX_RSS) {
-		/* RSS together with VMDq not supported*/
-		PMD_INIT_LOG(ERR, "RX mode %d is not supported.",
-				rx_mq_mode);
-		return -EINVAL;
-	}
-
-	/* To no break software that set invalid mode, only display
-	 * warning if invalid mode is used.
-	 */
-	if (tx_mq_mode != RTE_ETH_MQ_TX_NONE)
-		PMD_INIT_LOG(WARNING,
-			"TX mode %d is not supported. Due to meaningless in this driver, just ignore",
-			tx_mq_mode);
-
 	return 0;
 }
 
diff --git a/drivers/net/intel/e1000/igc_txrx.c b/drivers/net/intel/e1000/igc_txrx.c
index d61fdb33a8..dca66c3c2c 100644
--- a/drivers/net/intel/e1000/igc_txrx.c
+++ b/drivers/net/intel/e1000/igc_txrx.c
@@ -991,23 +991,10 @@ igc_dev_mq_rx_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	switch (dev->data->dev_conf.rxmode.mq_mode) {
-	case RTE_ETH_MQ_RX_RSS:
-		igc_rss_configure(dev);
-		break;
-	case RTE_ETH_MQ_RX_NONE:
-		/*
-		 * configure RSS register for following,
-		 * then disable the RSS logic
-		 */
-		igc_rss_configure(dev);
+	igc_rss_configure(dev);
+	if (dev->data->dev_conf.rxmode.mq_mode != RTE_ETH_MQ_RX_RSS)
 		igc_rss_disable(dev);
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "rx mode(%d) not supported!",
-			dev->data->dev_conf.rxmode.mq_mode);
-		return -EINVAL;
-	}
+
 	return 0;
 }
 
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index fbd50d0a91..0b645206e7 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -650,12 +650,6 @@ idpf_dev_configure(struct rte_eth_dev *dev)
 		return -ENOTSUP;
 	}
 
-	if (conf->txmode.mq_mode != RTE_ETH_MQ_TX_NONE) {
-		PMD_INIT_LOG(ERR, "Multi-queue TX mode %d is not supported",
-			     conf->txmode.mq_mode);
-		return -ENOTSUP;
-	}
-
 	if (conf->lpbk_mode != 0) {
 		PMD_INIT_LOG(ERR, "Loopback operation mode %d is not supported",
 			     conf->lpbk_mode);
diff --git a/drivers/net/mvneta/mvneta_ethdev.c b/drivers/net/mvneta/mvneta_ethdev.c
index eef9758224..975d3da81e 100644
--- a/drivers/net/mvneta/mvneta_ethdev.c
+++ b/drivers/net/mvneta/mvneta_ethdev.c
@@ -120,13 +120,6 @@ mvneta_dev_configure(struct rte_eth_dev *dev)
 	struct mvneta_priv *priv = dev->data->dev_private;
 	struct neta_ppio_params *ppio_params;
 
-	if (dev->data->dev_conf.rxmode.mq_mode != RTE_ETH_MQ_RX_NONE) {
-		MVNETA_LOG(INFO, "Unsupported RSS and rx multi queue mode %d",
-			dev->data->dev_conf.rxmode.mq_mode);
-		if (dev->data->nb_rx_queues > 1)
-			return -EINVAL;
-	}
-
 	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)
 		priv->multiseg = 1;
 
diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index 2df3a77e7f..9be3e5a92d 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -483,13 +483,6 @@ mrvl_dev_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	if (dev->data->dev_conf.rxmode.mq_mode != RTE_ETH_MQ_RX_NONE &&
-	    dev->data->dev_conf.rxmode.mq_mode != RTE_ETH_MQ_RX_RSS) {
-		MRVL_LOG(INFO, "Unsupported rx multi queue mode %d",
-			dev->data->dev_conf.rxmode.mq_mode);
-		return -EINVAL;
-	}
-
 	if (dev->data->dev_conf.rxmode.mtu > priv->max_mtu) {
 		MRVL_LOG(ERR, "MTU %u is larger than max_mtu %u",
 			 dev->data->dev_conf.rxmode.mtu,
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index e41732ccd3..d28eea082f 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -14,7 +14,6 @@ static int nbl_dev_port_configure(struct nbl_adapter *adapter)
 int nbl_dev_configure(struct rte_eth_dev *eth_dev)
 {
 	struct rte_eth_dev_data *dev_data = eth_dev->data;
-	enum rte_eth_rx_mq_mode rx_mq_mode = eth_dev->data->dev_conf.rxmode.mq_mode;
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	int ret;
 
@@ -23,11 +22,6 @@ int nbl_dev_configure(struct rte_eth_dev *eth_dev)
 
 	NBL_LOG(DEBUG, "Begin to configure the device, state: %d", adapter->state);
 
-	if (rx_mq_mode != RTE_ETH_MQ_RX_NONE && rx_mq_mode != RTE_ETH_MQ_RX_RSS) {
-		NBL_LOG(ERR, "Rx mq mode %d is not supported", rx_mq_mode);
-		return -ENOTSUP;
-	}
-
 	dev_data->dev_conf.intr_conf.lsc = 0;
 
 	switch (adapter->state) {
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index f9957086d2..97841c00b5 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -357,22 +357,14 @@ nfp_net_configure(struct rte_eth_dev *dev)
 	struct nfp_net_hw *hw;
 	struct rte_eth_conf *dev_conf;
 	struct rte_eth_rxmode *rxmode;
-	struct rte_eth_txmode *txmode;
 
 	hw = nfp_net_get_hw(dev);
 	dev_conf = &dev->data->dev_conf;
 	rxmode = &dev_conf->rxmode;
-	txmode = &dev_conf->txmode;
 
 	if ((rxmode->mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) != 0)
 		rxmode->offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
-	/* Checking TX mode */
-	if (txmode->mq_mode != RTE_ETH_MQ_TX_NONE) {
-		PMD_DRV_LOG(ERR, "TX mq_mode DCB and VMDq not supported.");
-		return -EINVAL;
-	}
-
 	/* Checking MTU set */
 	if (rxmode->mtu > hw->max_mtu + NFP_ETH_OVERHEAD) {
 		PMD_DRV_LOG(ERR, "MTU (%u) larger than the maximum possible frame size (%u).",
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index e0df23049c..bde4c2c615 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -494,16 +494,6 @@ octeontx_dev_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	if (txmode->mq_mode) {
-		octeontx_log_err("tx mq_mode DCB or VMDq not supported");
-		return -EINVAL;
-	}
-
-	if (rxmode->mq_mode != RTE_ETH_MQ_RX_NONE) {
-		octeontx_log_err("unsupported rx qmode %d", rxmode->mq_mode);
-		return -EINVAL;
-	}
-
 	if (!(txmode->offloads & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE)) {
 		PMD_INIT_LOG(NOTICE, "cant disable lockfree tx");
 		txmode->offloads |= RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index c41177b86a..93fc75ad0a 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -1289,11 +1289,6 @@ static int qede_dev_configure(struct rte_eth_dev *eth_dev)
 		DP_NOTICE(edev, false,
 			  "Invalid devargs supplied, requested change will not take effect\n");
 
-	if (!(rxmode->mq_mode == RTE_ETH_MQ_RX_NONE ||
-	      rxmode->mq_mode == RTE_ETH_MQ_RX_RSS)) {
-		DP_ERR(edev, "Unsupported multi-queue mode\n");
-		return -ENOTSUP;
-	}
 	/* Flow director mode check */
 	if (qede_check_fdir_support(eth_dev))
 		return -ENOTSUP;
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index 079d02dff1..629cb7af1c 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -389,20 +389,6 @@ sfc_repr_check_conf(struct sfc_repr *sr, const struct rte_eth_conf *conf)
 		ret = -EINVAL;
 	}
 
-	switch (conf->rxmode.mq_mode) {
-	case RTE_ETH_MQ_RX_NONE:
-		break;
-	default:
-		sfcr_err(sr, "Rx mode MQ modes other than none not supported");
-		ret = -EINVAL;
-		break;
-	}
-
-	if (conf->txmode.mq_mode != RTE_ETH_MQ_TX_NONE) {
-		sfcr_err(sr, "Tx mode MQ modes not supported");
-		ret = -EINVAL;
-	}
-
 	if (conf->lpbk_mode != 0) {
 		sfcr_err(sr, "loopback not supported");
 		ret = -EINVAL;
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index aa59931f06..70ad3bf00c 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1665,23 +1665,11 @@ sfc_rx_qinit_info(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 	return 0;
 }
 
-static int
+static void
 sfc_rx_check_mode(struct sfc_adapter *sa, struct rte_eth_rxmode *rxmode)
 {
 	uint64_t offloads_supported = sfc_rx_get_dev_offload_caps(sa) |
 				      sfc_rx_get_queue_offload_caps(sa);
-	int rc = 0;
-
-	switch (rxmode->mq_mode) {
-	case RTE_ETH_MQ_RX_NONE:
-	case RTE_ETH_MQ_RX_RSS:
-		/* No special checks are required */
-		break;
-	default:
-		sfc_err(sa, "Rx multi-queue mode %u not supported",
-			rxmode->mq_mode);
-		rc = EINVAL;
-	}
 
 	/*
 	 * Requested offloads are validated against supported by ethdev,
@@ -1699,8 +1687,6 @@ sfc_rx_check_mode(struct sfc_adapter *sa, struct rte_eth_rxmode *rxmode)
 		sfc_warn(sa, "Rx outer IPv4 checksum offload cannot be disabled - always on");
 		rxmode->offloads |= RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM;
 	}
-
-	return rc;
 }
 
 /**
@@ -1759,9 +1745,7 @@ sfc_rx_configure(struct sfc_adapter *sa)
 	sfc_log_init(sa, "nb_rx_queues=%u (old %u)",
 		     nb_rx_queues, sas->ethdev_rxq_count);
 
-	rc = sfc_rx_check_mode(sa, &dev_conf->rxmode);
-	if (rc != 0)
-		goto fail_check_mode;
+	sfc_rx_check_mode(sa, &dev_conf->rxmode);
 
 	if (nb_rxq_total == sas->rxq_count) {
 		reconfigure = true;
@@ -1872,8 +1856,6 @@ sfc_rx_configure(struct sfc_adapter *sa)
 fail_rxqs_ctrl_alloc:
 fail_rxqs_alloc:
 	sfc_rx_close(sa);
-
-fail_check_mode:
 	sfc_log_init(sa, "failed %d", rc);
 	return rc;
 }
diff --git a/drivers/net/sfc/sfc_tx.c b/drivers/net/sfc/sfc_tx.c
index fac56cb27c..a860265c6a 100644
--- a/drivers/net/sfc/sfc_tx.c
+++ b/drivers/net/sfc/sfc_tx.c
@@ -314,15 +314,6 @@ sfc_tx_check_mode(struct sfc_adapter *sa, const struct rte_eth_txmode *txmode)
 	uint64_t dev_tx_offload_cap = sfc_tx_get_dev_offload_caps(sa);
 	int rc = 0;
 
-	switch (txmode->mq_mode) {
-	case RTE_ETH_MQ_TX_NONE:
-		break;
-	default:
-		sfc_err(sa, "Tx multi-queue mode %u not supported",
-			txmode->mq_mode);
-		rc = EINVAL;
-	}
-
 	if ((dev_tx_offload_cap & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) != 0 &&
 	    (txmode->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) == 0) {
 		sfc_err(sa, "There is no FAST_FREE flag in the attempted Tx mode configuration");
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 30d03f4db9..2ed4390522 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -892,7 +892,7 @@ nicvf_configure_rss(struct rte_eth_dev *dev)
 {
 	struct nicvf *nic = nicvf_pmd_priv(dev);
 	uint64_t rsshf;
-	int ret = -EINVAL;
+	int ret;
 
 	rsshf = nicvf_rss_ethdev_to_nic(nic,
 			dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf);
@@ -901,10 +901,10 @@ nicvf_configure_rss(struct rte_eth_dev *dev)
 		    dev->data->nb_rx_queues,
 		    dev->data->dev_conf.lpbk_mode, rsshf);
 
-	if (dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_NONE)
-		ret = nicvf_rss_term(nic);
-	else if (dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS)
+	if (dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS)
 		ret = nicvf_rss_config(nic, dev->data->nb_rx_queues, rsshf);
+	else
+		ret = nicvf_rss_term(nic);
 	if (ret)
 		PMD_INIT_LOG(ERR, "Failed to configure RSS %d", ret);
 
@@ -1990,7 +1990,6 @@ nicvf_dev_configure(struct rte_eth_dev *dev)
 	struct rte_eth_dev_data *data = dev->data;
 	struct rte_eth_conf *conf = &data->dev_conf;
 	struct rte_eth_rxmode *rxmode = &conf->rxmode;
-	struct rte_eth_txmode *txmode = &conf->txmode;
 	struct nicvf *nic = nicvf_pmd_priv(dev);
 	uint8_t cqcount;
 
@@ -2004,17 +2003,6 @@ nicvf_dev_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	if (txmode->mq_mode) {
-		PMD_INIT_LOG(INFO, "Tx mq_mode DCB or VMDq not supported");
-		return -EINVAL;
-	}
-
-	if (rxmode->mq_mode != RTE_ETH_MQ_RX_NONE &&
-		rxmode->mq_mode != RTE_ETH_MQ_RX_RSS) {
-		PMD_INIT_LOG(INFO, "Unsupported rx qmode %d", rxmode->mq_mode);
-		return -EINVAL;
-	}
-
 	if (conf->dcb_capability_en) {
 		PMD_INIT_LOG(INFO, "DCB enable not supported");
 		return -EINVAL;
diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index a6fe4f3023..e6ad2de4ba 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -2241,20 +2241,6 @@ virtio_dev_configure(struct rte_eth_dev *dev)
 	PMD_INIT_LOG(DEBUG, "configure");
 	req_features = VIRTIO_PMD_DEFAULT_GUEST_FEATURES;
 
-	if (rxmode->mq_mode != RTE_ETH_MQ_RX_NONE && rxmode->mq_mode != RTE_ETH_MQ_RX_RSS) {
-		PMD_DRV_LOG(ERR,
-			"Unsupported Rx multi queue mode %d",
-			rxmode->mq_mode);
-		return -EINVAL;
-	}
-
-	if (txmode->mq_mode != RTE_ETH_MQ_TX_NONE) {
-		PMD_DRV_LOG(ERR,
-			"Unsupported Tx multi queue mode %d",
-			txmode->mq_mode);
-		return -EINVAL;
-	}
-
 	if (dev->data->dev_conf.intr_conf.rxq) {
 		ret = virtio_init_device(dev, hw->req_guest_features);
 		if (ret < 0)
diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
index 7c2f894642..f3efc927b2 100644
--- a/drivers/net/zxdh/zxdh_ethdev.c
+++ b/drivers/net/zxdh/zxdh_ethdev.c
@@ -1038,25 +1038,6 @@ zxdh_dev_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	if (rxmode->mq_mode != RTE_ETH_MQ_RX_RSS && rxmode->mq_mode != RTE_ETH_MQ_RX_NONE) {
-		PMD_DRV_LOG(ERR, "Unsupported Rx multi queue mode %d", rxmode->mq_mode);
-		return -EINVAL;
-	}
-
-	if (txmode->mq_mode != RTE_ETH_MQ_TX_NONE) {
-		PMD_DRV_LOG(ERR, "Unsupported Tx multi queue mode %d", txmode->mq_mode);
-		return -EINVAL;
-	}
-	if (rxmode->mq_mode != RTE_ETH_MQ_RX_RSS && rxmode->mq_mode != RTE_ETH_MQ_RX_NONE) {
-		PMD_DRV_LOG(ERR, "Unsupported Rx multi queue mode %d", rxmode->mq_mode);
-		return -EINVAL;
-	}
-
-	if (txmode->mq_mode != RTE_ETH_MQ_TX_NONE) {
-		PMD_DRV_LOG(ERR, "Unsupported Tx multi queue mode %d", txmode->mq_mode);
-		return -EINVAL;
-	}
-
 	ret = zxdh_features_update(hw, rxmode, txmode);
 	if (ret < 0)
 		return ret;
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 0988f69275..8f91a353d9 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1526,6 +1526,23 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
+#define RX_MQ_MODE_KNOWN_FLAGS \
+	(RTE_ETH_MQ_RX_RSS_FLAG | RTE_ETH_MQ_RX_DCB_FLAG | RTE_ETH_MQ_RX_VMDQ_FLAG)
+
+	if ((dev_conf->rxmode.mq_mode & ~RX_MQ_MODE_KNOWN_FLAGS) != 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u invalid rx mq_mode 0x%x",
+			port_id, dev_conf->rxmode.mq_mode);
+		ret = -EINVAL;
+		goto rollback;
+	}
+
+	if (dev_conf->txmode.mq_mode > RTE_ETH_MQ_TX_VMDQ_ONLY) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u invalid tx mq_mode %u",
+			port_id, dev_conf->txmode.mq_mode);
+		ret = -EINVAL;
+		goto rollback;
+	}
+
 	if (dev_info.flow_type_rss_offloads == 0 &&
 			(dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) != 0) {
 		if (nb_rx_q > 1) {
-- 
2.54.0

