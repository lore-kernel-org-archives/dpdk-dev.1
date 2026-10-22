Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEC7606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ko772OyV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B78A40A75;
	Thu, 22 Oct 2026 19:45:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4B93840264
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792691136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=085+MIMmp8ZqJWtzSIIOYwBJ1VkBWzEr5OmLGSVkv98=;
 b=Ko772OyVSLMHUgRizlYiiuRL7feUSWv4cOY+GZGgtd6kI1NQObt1hH7Ir0vyqUkiqlKk8k
 oqJE/P6TSp7Bs5r+vesDpicxqnITbuxOdYHe6SbtRjSRXpS4wo33j6MhN61YVLfrynL/rF
 1mGVdpULHnqeXcf6B/60zViB09B1Qz0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-dBBGUfgCP7iJ8hNEHnGBNA-1; Thu,
 22 Oct 2026 13:45:24 -0400
X-MC-Unique: dBBGUfgCP7iJ8hNEHnGBNA-1
X-Mimecast-MFC-AGG-ID: dBBGUfgCP7iJ8hNEHnGBNA_1792691121
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35F981955EA8; Thu, 22 Oct 2026 17:45:21 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 124B01800495; Thu, 22 Oct 2026 17:45:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Gaetan Rivet <grive@u256.net>, Rosen Xu <rosen.xu@altera.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Jing Chen <jing.d.chen@intel.com>, Jeff Shaw <jeffrey.b.shaw@intel.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>, Andy Pei <andy.pei@intel.com>,
 Dan Wei <dan.wei@intel.com>
Subject: [PATCH v3 06/13] drivers/net: fix reported VMDq capability
Date: Thu, 22 Oct 2026 19:44:33 +0200
Message-ID: <20261022174447.412638-7-david.marchand@redhat.com>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z3Dby31gSoAHzOidjWaGvIuahEoDVoVrXsf-1TBiCYc_1792691121
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some PF drivers (dpaa, dpaa2) and VF drivers (ixgbe, ngbe, txgbe)
are announcing some VMDq capability though this support is not documented,
and no action is taken if the feature is requested.

fm10k announces capability for VF device, but rejects it at configure
time.

failsafe may support VMDq, as it only passes the requests to the ports
attached to it, hence mark it as partial support.

Fixes: fe3a45fd4104 ("ixgbe: add VMDq support")
Fixes: 7e72cbfa320b ("fm10k: add reta query/update")
Fixes: 799db4568c76 ("net/dpaa: support device info and speed capability")
Fixes: 762b275f20f8 ("net/dpaa2: add missing device info fields")
Fixes: c01c748e4ae6 ("net/ipn3ke: add new driver")
Fixes: 5dec0169554b ("net/txgbe: support VF get information")
Fixes: 66070ca419c1 ("net/ngbe: add hardware configuration for VF device")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
Changes since v1:
- moved net/atlantic and net/cxgbe changes where needed (later in this
  series),
- added comment on failsafe in commitlog,
- fixed ipn3ke,

---
 doc/guides/nics/features/failsafe.ini  | 1 +
 doc/guides/nics/features/ipn3ke.ini    | 1 -
 drivers/net/dpaa/dpaa_ethdev.c         | 1 -
 drivers/net/dpaa2/dpaa2_ethdev.c       | 1 -
 drivers/net/intel/fm10k/fm10k_ethdev.c | 9 ++-------
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 4 ----
 drivers/net/ngbe/ngbe_ethdev_vf.c      | 1 -
 drivers/net/txgbe/txgbe_ethdev_vf.c    | 1 -
 8 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/doc/guides/nics/features/failsafe.ini b/doc/guides/nics/features/failsafe.ini
index c7c696fbbd..09afdc1963 100644
--- a/doc/guides/nics/features/failsafe.ini
+++ b/doc/guides/nics/features/failsafe.ini
@@ -13,6 +13,7 @@ MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
+VMDq                 = P
 Multicast MAC filter = Y
 VLAN filter          = Y
 Flow control         = Y
diff --git a/doc/guides/nics/features/ipn3ke.ini b/doc/guides/nics/features/ipn3ke.ini
index 29f40a5b11..ba43b9d91c 100644
--- a/doc/guides/nics/features/ipn3ke.ini
+++ b/doc/guides/nics/features/ipn3ke.ini
@@ -18,7 +18,6 @@ Multicast MAC filter = Y
 RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
-VMDq                 = Y
 SR-IOV               = Y
 DCB                  = Y
 VLAN filter          = Y
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 1aaf97f175..7d45386a9d 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -662,7 +662,6 @@ static int dpaa_eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_mac_addrs = DPAA_MAX_MAC_FILTER;
 	dev_info->max_hash_mac_addrs = 0;
 	dev_info->max_vfs = 0;
-	dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
 	dev_info->flow_type_rss_offloads = DPAA_RSS_OFFLOAD_ALL;
 
 	if (fif->mac_type == fman_mac_1g) {
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 8ae4fd89c5..07e89d5c39 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -452,7 +452,6 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 
 	dev_info->max_hash_mac_addrs = 0;
 	dev_info->max_vfs = 0;
-	dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
 	dev_info->flow_type_rss_offloads = DPAA2_RSS_OFFLOAD_ALL;
 	/* DPAA2 has no software-visible indirection table: incoming packets are
 	 * dispatched to FQs via 'queue_id = hash % dist_size'. We expose the
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 3b2daba79e..9b123c0b2c 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -411,7 +411,6 @@ static int
 fm10k_check_mq_mode(struct rte_eth_dev *dev)
 {
 	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
-	struct fm10k_hw *hw = FM10K_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct rte_eth_vmdq_rx_conf *vmdq_conf;
 	uint16_t nb_rx_q = dev->data->nb_rx_queues;
 
@@ -425,11 +424,6 @@ fm10k_check_mq_mode(struct rte_eth_dev *dev)
 	if (!(rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG))
 		return 0;
 
-	if (hw->mac.type == fm10k_mac_vf) {
-		PMD_INIT_LOG(ERR, "VMDQ mode is not supported in VF.");
-		return -EINVAL;
-	}
-
 	/* Check VMDQ queue pool number */
 	if (vmdq_conf->nb_queue_pools >
 			sizeof(vmdq_conf->pool_map[0].pools) * CHAR_BIT ||
@@ -1386,7 +1380,8 @@ fm10k_dev_infos_get(struct rte_eth_dev *dev,
 	dev_info->max_vfs            = pdev->max_vfs;
 	dev_info->vmdq_pool_base     = 0;
 	dev_info->vmdq_queue_base    = 0;
-	dev_info->max_vmdq_pools     = RTE_ETH_32_POOLS;
+	if (hw->mac.type != fm10k_mac_vf)
+		dev_info->max_vmdq_pools = RTE_ETH_32_POOLS;
 	dev_info->vmdq_queue_num     = FM10K_MAX_QUEUES_PF;
 	dev_info->rx_queue_offload_capa = fm10k_get_rx_queue_offloads_capa(dev);
 	dev_info->rx_offload_capa = fm10k_get_rx_port_offloads_capa(dev) |
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 44eb932058..50e44484b1 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -4076,10 +4076,6 @@ ixgbevf_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->max_mac_addrs = hw->mac.num_rar_entries;
 	dev_info->max_hash_mac_addrs = IXGBE_VMDQ_NUM_UC_MAC;
 	dev_info->max_vfs = pci_dev->max_vfs;
-	if (hw->mac.type == ixgbe_mac_82598EB)
-		dev_info->max_vmdq_pools = RTE_ETH_16_POOLS;
-	else
-		dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
 	dev_info->rx_queue_offload_capa = ixgbe_get_rx_queue_offloads(dev);
 	dev_info->rx_offload_capa = (ixgbe_get_rx_port_offloads(dev) |
 				     dev_info->rx_queue_offload_capa);
diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index c440e02369..55cbffaf2c 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -475,7 +475,6 @@ ngbevf_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->max_mac_addrs = hw->mac.num_rar_entries;
 	dev_info->max_hash_mac_addrs = NGBE_VMDQ_NUM_UC_MAC;
 	dev_info->max_vfs = pci_dev->max_vfs;
-	dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
 	dev_info->rx_queue_offload_capa = ngbe_get_rx_queue_offloads(dev);
 	dev_info->rx_offload_capa = (ngbe_get_rx_port_offloads(dev) |
 				     dev_info->rx_queue_offload_capa);
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 341f62bc75..3cf33a8bd6 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -575,7 +575,6 @@ txgbevf_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->max_mac_addrs = hw->mac.num_rar_entries;
 	dev_info->max_hash_mac_addrs = TXGBE_VMDQ_NUM_UC_MAC;
 	dev_info->max_vfs = pci_dev->max_vfs;
-	dev_info->max_vmdq_pools = RTE_ETH_64_POOLS;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 	dev_info->rx_queue_offload_capa = txgbe_get_rx_queue_offloads(dev);
 	dev_info->rx_offload_capa = (txgbe_get_rx_port_offloads(dev) |
-- 
2.54.0

