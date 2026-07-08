Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BCBC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 17:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA92402CF;
	Wed,  8 Jul 2026 19:42:25 +0200 (CEST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id B10F940268
 for <dev@dpdk.org>; Wed,  8 Jul 2026 19:42:23 +0200 (CEST)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso471553a34.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783532543; x=1784137343; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g611U77uXz6gls4H/Cl7yiRNPg9axzS4h+hNj6xIWzY=;
 b=Pxvfa3xQeqpOkMHbh3VGzwMsv8JDhWuTSIXfrZHs5ZMlmAjME2/ROpbnZsEE/A0zSP
 O+ADyB8rKzmm4D+a3XIN2kCSDoQErtL1bxbQ6GmEneUiUo5sVvblMfXXal2IQZAJhhOI
 jQewu3Vkh5/FyJXiMv1I1A2WRSbrYaF5/u4Uv0XzmqcKju7efCR6inb4ttMtg2IOzSIW
 EqKnHiQHDomlGrtagpsl8+mUbrZIbD+Vq51g6cR/8n8zhbBv6QUDdAzu0ussTWrRCz/t
 iLVGJCaSAeZOiOrPFdVwe3Rd3970V2QijyRKoxLZ2KhGJsBg7e4+yyFO5tDszUZi/F2M
 jMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783532543; x=1784137343;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g611U77uXz6gls4H/Cl7yiRNPg9axzS4h+hNj6xIWzY=;
 b=kd0F6aGPozIhenVPDzmUsHc0SCtmlU5SSQQeGK9Inq0HIblM9T9Jo4+nvAbiYX+pIA
 WVJ0HRSsrARfbAOaRCx/hmdCrdMZN2hcefdlx6Uv6MVb9/pj/TedtBNINdHVFY+wKfOe
 g0y91/MmzIkNAcy5n6Tl90fCi77spFwqya1vW0bQ0NXvaoG4YYPhzSiWGJ1VVd9j4P/x
 1QviZl873YD9+fosyVhR/PhiXzd7cucTzeVc12Sagg/PD8FAenH+eXKQv0BC3OS2pBbK
 Fo0FIKe0YPAagOKOKoGlbWvC2CpTcK5jKjXJ+3TNwMd9xxQ1mkm5PsZzvJfCFFq5q9bn
 ZgqQ==
X-Gm-Message-State: AOJu0Yzxo87/G2BIiLsxazHnZ76tgFiZNHfyE/fTp7yxgS/3I3Rg9GVM
 MvhYzaXiFTj3kd9QI7kYSNuNaTPtHOLk+OSeNdqyMh25AbgqgvuOlLqE
X-Gm-Gg: AfdE7ckvFiDSCrdparuB3FwBAA6+QXMLREmWCueRtXQv3XUieulPa0c7BlSb/HyM819
 yN7iorchqbgDdg0rIArD93M4ziAWxtKN9ozsJLzxzSqM2aPNBnbztmti2BxGsL9fHWSDhyhN+l8
 y6twFEoi45ZGCqFWix/0BixwxyoyF9DwTD/a8+kbQ/OJ1902reHZy8j7hgkf7XP0i685qQSybxu
 sEJ0klV55f1ZLcKjN80+OO+fKRBoFJ9Cdk08cspP2ssH1HmESqvErzKDw7UWeWem1jBhkQpddWX
 24nv/E9+DtfGpPhcoxgBiO8Q8b2c592bNoMznpclOqpict7dyQtJbh+h2M2RWgikj2BCo6RjMnP
 HAgsExveNR4VIVoIIBBpiR3SORnqUvZ3O3uZdQfn0/yNDlCtcumW2D/I0Mj64YCDmobb45Y2N/C
 0kSmhiTA==
X-Received: by 2002:a05:6820:2d43:b0:6a1:5347:2af9 with SMTP id
 006d021491bc7-6a36db4308dmr2486525eaf.36.1783532542703; 
 Wed, 08 Jul 2026 10:42:22 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a36a5ef513sm2629835eaf.6.2026.07.08.10.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:42:22 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Weijun Pan <wpan3636@gmail.com>
Subject: [RFC PATCH] net/bonding: reject control operations in secondary
Date: Wed,  8 Jul 2026 12:42:04 -0500
Message-Id: <20260708174204.72574-1-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The bonding PMD installs safe secondary burst functions when real
secondary datapath support is not available. This avoids crashes, but
secondary processes must not be able to change bonding control-plane
state if the primary process is the owner of that state.

Reject bonding control-plane operations from secondary processes. This
keeps bonding configuration and LACP state owned by the primary process
and is a prerequisite for future limited secondary datapath support.

Bugzilla ID: 1900

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
 drivers/net/bonding/rte_eth_bond_8023ad.c | 31 ++++++++++++
 drivers/net/bonding/rte_eth_bond_api.c    | 47 +++++++++++++++++
 drivers/net/bonding/rte_eth_bond_pmd.c    | 61 +++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index d1f30229d0..685255ffc3 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1428,11 +1428,24 @@ rte_eth_bond_8023ad_conf_get(uint16_t port_id,
 	return 0;
 }
 
+static int
+bond_8023ad_primary_only(const char *op)
+{
+	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
+		return 0;
+
+	RTE_BOND_LOG(ERR, "%s not supported in secondary process", op);
+	return -ENOTSUP;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_agg_selection_set)
 int
 rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 		enum rte_bond_8023ad_agg_selection agg_selection)
 {
+	if (bond_8023ad_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct rte_eth_dev *bond_dev;
 	struct bond_dev_private *internals;
 	struct mode8023ad_private *mode4;
@@ -1506,6 +1519,9 @@ int
 rte_eth_bond_8023ad_setup(uint16_t port_id,
 		struct rte_eth_bond_8023ad_conf *conf)
 {
+	if (bond_8023ad_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct rte_eth_dev *bond_dev;
 	int err;
 
@@ -1590,6 +1606,9 @@ int
 rte_eth_bond_8023ad_ext_collect(uint16_t port_id, uint16_t member_id,
 				int enabled)
 {
+	if (bond_8023ad_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct port *port;
 	int res;
 
@@ -1612,6 +1631,9 @@ int
 rte_eth_bond_8023ad_ext_distrib(uint16_t port_id, uint16_t member_id,
 				int enabled)
 {
+	if (bond_8023ad_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct port *port;
 	int res;
 
@@ -1664,6 +1686,9 @@ int
 rte_eth_bond_8023ad_ext_slowtx(uint16_t port_id, uint16_t member_id,
 		struct rte_mbuf *lacp_pkt)
 {
+	if (bond_8023ad_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct port *port;
 	int res;
 
@@ -1725,6 +1750,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_enable)
 int
 rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 {
+	if (bond_8023ad_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
@@ -1754,6 +1782,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_disable)
 int
 rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 {
+	if (bond_8023ad_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct rte_eth_dev *dev;
 	struct bond_dev_private *internals;
 
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index d9b6f1c417..3b754bf8e0 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -150,10 +150,24 @@ deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
 	}
 }
 
+static int
+bond_api_primary_only(const char *op)
+{
+	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
+		return 0;
+
+	RTE_BOND_LOG(ERR, "%s not supported in secondary process", op);
+	return -1;
+}
+
+
 RTE_EXPORT_SYMBOL(rte_eth_bond_create)
 int
 rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct bond_dev_private *internals;
 	struct rte_eth_dev *bond_dev;
 	char devargs[52];
@@ -193,6 +207,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_free)
 int
 rte_eth_bond_free(const char *name)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	return rte_vdev_uninit(name);
 }
 
@@ -638,6 +655,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_member_add)
 int
 rte_eth_bond_member_add(uint16_t bonding_port_id, uint16_t member_port_id)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
@@ -777,6 +797,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_member_remove)
 int
 rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 	int retval;
@@ -800,6 +823,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_mode_set)
 int
 rte_eth_bond_mode_set(uint16_t bonding_port_id, uint8_t mode)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct rte_eth_dev *bonding_eth_dev;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
@@ -832,6 +858,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_primary_set)
 int
 rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct bond_dev_private *internals;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
@@ -921,6 +950,9 @@ int
 rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 		struct rte_ether_addr *mac_addr)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
@@ -947,6 +979,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_mac_address_reset)
 int
 rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct rte_eth_dev *bonding_eth_dev;
 	struct bond_dev_private *internals;
 
@@ -989,6 +1024,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_xmit_policy_set)
 int
 rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct bond_dev_private *internals;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
@@ -1034,6 +1072,9 @@ RTE_EXPORT_SYMBOL(rte_eth_bond_link_monitoring_set)
 int
 rte_eth_bond_link_monitoring_set(uint16_t bonding_port_id, uint32_t internal_ms)
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct bond_dev_private *internals;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
@@ -1063,6 +1104,9 @@ rte_eth_bond_link_down_prop_delay_set(uint16_t bonding_port_id,
 				       uint32_t delay_ms)
 
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct bond_dev_private *internals;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
@@ -1091,6 +1135,9 @@ int
 rte_eth_bond_link_up_prop_delay_set(uint16_t bonding_port_id, uint32_t delay_ms)
 
 {
+	if (bond_api_primary_only(__func__) != 0)
+		return -1;
+
 	struct bond_dev_private *internals;
 
 	if (valid_bonding_port_id(bonding_port_id) != 0)
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..b6e38d4a60 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2052,9 +2052,22 @@ bond_ethdev_primary_set(struct bond_dev_private *internals,
 static int
 bond_ethdev_promiscuous_enable(struct rte_eth_dev *eth_dev);
 
+static int
+bond_ethdev_primary_only(const char *op)
+{
+	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
+		return 0;
+
+	RTE_BOND_LOG(ERR, "%s not supported in secondary process", op);
+	return -ENOTSUP;
+}
+
 static int
 bond_ethdev_start(struct rte_eth_dev *eth_dev)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_dev_private *internals;
 	int i;
 
@@ -2186,6 +2199,9 @@ bond_ethdev_free_queues(struct rte_eth_dev *dev)
 int
 bond_ethdev_stop(struct rte_eth_dev *eth_dev)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_dev_private *internals = eth_dev->data->dev_private;
 	uint16_t i;
 	int ret;
@@ -2400,6 +2416,9 @@ bond_ethdev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 static int
 bond_ethdev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	int res;
 	uint16_t i;
 	struct bond_dev_private *internals = dev->data->dev_private;
@@ -2431,6 +2450,9 @@ bond_ethdev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		uint16_t nb_rx_desc, unsigned int socket_id __rte_unused,
 		const struct rte_eth_rxconf *rx_conf, struct rte_mempool *mb_pool)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_rx_queue *bd_rx_q = (struct bond_rx_queue *)
 			rte_zmalloc_socket(NULL, sizeof(struct bond_rx_queue),
 					0, dev->data->numa_node);
@@ -2455,6 +2477,9 @@ bond_ethdev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc, unsigned int socket_id __rte_unused,
 		const struct rte_eth_txconf *tx_conf)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_tx_queue *bd_tx_q  = (struct bond_tx_queue *)
 			rte_zmalloc_socket(NULL, sizeof(struct bond_tx_queue),
 					0, dev->data->numa_node);
@@ -2697,6 +2722,9 @@ bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 static int
 bond_ethdev_stats_reset(struct rte_eth_dev *dev)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_dev_private *internals = dev->data->dev_private;
 	int i;
 	int err;
@@ -2714,6 +2742,9 @@ bond_ethdev_stats_reset(struct rte_eth_dev *dev)
 static int
 bond_ethdev_promiscuous_enable(struct rte_eth_dev *eth_dev)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_dev_private *internals = eth_dev->data->dev_private;
 	int i;
 	int ret = 0;
@@ -2768,6 +2799,9 @@ bond_ethdev_promiscuous_enable(struct rte_eth_dev *eth_dev)
 static int
 bond_ethdev_promiscuous_disable(struct rte_eth_dev *dev)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_dev_private *internals = dev->data->dev_private;
 	int i;
 	int ret = 0;
@@ -2871,6 +2905,9 @@ bond_ethdev_promiscuous_update(struct rte_eth_dev *dev)
 static int
 bond_ethdev_allmulticast_enable(struct rte_eth_dev *eth_dev)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_dev_private *internals = eth_dev->data->dev_private;
 	int i;
 	int ret = 0;
@@ -2925,6 +2962,9 @@ bond_ethdev_allmulticast_enable(struct rte_eth_dev *eth_dev)
 static int
 bond_ethdev_allmulticast_disable(struct rte_eth_dev *eth_dev)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct bond_dev_private *internals = eth_dev->data->dev_private;
 	int i;
 	int ret = 0;
@@ -3186,6 +3226,9 @@ static int
 bond_ethdev_rss_reta_update(struct rte_eth_dev *dev,
 		struct rte_eth_rss_reta_entry64 *reta_conf, uint16_t reta_size)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	unsigned i, j;
 	int result = 0;
 	int member_reta_size;
@@ -3246,6 +3289,9 @@ static int
 bond_ethdev_rss_hash_update(struct rte_eth_dev *dev,
 		struct rte_eth_rss_conf *rss_conf)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	int i, result = 0;
 	struct bond_dev_private *internals = dev->data->dev_private;
 	struct rte_eth_rss_conf bond_rss_conf;
@@ -3295,6 +3341,9 @@ bond_ethdev_rss_hash_conf_get(struct rte_eth_dev *dev,
 static int
 bond_ethdev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct rte_eth_dev *member_eth_dev;
 	struct bond_dev_private *internals = dev->data->dev_private;
 	int ret, i;
@@ -3324,6 +3373,9 @@ static int
 bond_ethdev_mac_address_set(struct rte_eth_dev *dev,
 			struct rte_ether_addr *addr)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	if (mac_address_set(dev, addr)) {
 		RTE_BOND_LOG(ERR, "Failed to update MAC address");
 		return -EINVAL;
@@ -3345,6 +3397,9 @@ bond_ethdev_mac_addr_add(struct rte_eth_dev *dev,
 			struct rte_ether_addr *mac_addr,
 			__rte_unused uint32_t index, uint32_t vmdq)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	struct rte_eth_dev *member_eth_dev;
 	struct bond_dev_private *internals = dev->data->dev_private;
 	int ret, i;
@@ -3381,6 +3436,9 @@ bond_ethdev_mac_addr_add(struct rte_eth_dev *dev,
 static void
 bond_ethdev_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return;
+
 	struct rte_eth_dev *member_eth_dev;
 	struct bond_dev_private *internals = dev->data->dev_private;
 	int i;
@@ -3965,6 +4023,9 @@ bond_remove(struct rte_vdev_device *dev)
 static int
 bond_ethdev_configure(struct rte_eth_dev *dev)
 {
+	if (bond_ethdev_primary_only(__func__) != 0)
+		return -ENOTSUP;
+
 	const char *name = dev->device->name;
 	struct bond_dev_private *internals = dev->data->dev_private;
 	struct rte_kvargs *kvlist = internals->kvlist;
-- 
2.34.1

