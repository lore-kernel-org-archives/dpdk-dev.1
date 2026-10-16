Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692FACCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7570F40A70;
	Fri, 16 Oct 2026 15:06:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B5B2F4067A
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792155999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8zmCmqEttH9X67wSMwwPFb73unxY7+L1R54T/ZFX1g=;
 b=EXF9Dx7IwICm1XGE0WhOw8+/TdTcwH5CTNK7G+Ol3H0zIDzdvuw4cOMRBeISq/GsBPEkNw
 0SFtEWxEVG6PH3JPJhllBAu16JXa/clsBw9ncKvk8Gv202a7k5gNtgbUMUI4/PU3zXdATq
 UdPr613o1NHfGIGSoyf4/5RBSq7RS3A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-Mef2enU7NeqRa60Evs_uAg-1; Fri,
 16 Oct 2026 13:06:33 +0000
X-MC-Unique: Mef2enU7NeqRa60Evs_uAg-1
X-Mimecast-MFC-AGG-ID: Mef2enU7NeqRa60Evs_uAg_1792155991
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7A381955F0F; Fri, 16 Oct 2026 13:06:29 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11D8E1956086; Fri, 16 Oct 2026 13:06:23 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Gaetan Rivet <grive@u256.net>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Wei Hu <weh@microsoft.com>, Praveen Shetty <praveen.shetty@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Renyong Wan <wanry@yunsilicon.com>,
 Na Na <nana@yunsilicon.com>, Rong Qian <qianr@yunsilicon.com>,
 Xiaoxiong Zhang <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>,
 Beilei Xing <beilei.xing@intel.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>, Mingxia Liu <mingxia.liu@intel.com>
Subject: [PATCH 6/8] drivers/net: fix reported RSS capability
Date: Fri, 16 Oct 2026 15:05:52 +0200
Message-ID: <20261016130555.1685102-7-david.marchand@redhat.com>
In-Reply-To: <20261016130555.1685102-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VVnLkJ2AkXcDz5ErewWnq8B8RVJxdgMZLI7aj3NL2IQ_1792155991
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Some drivers (idpf, cpfl) report RSS support even if lacking HW support.
On the other hand, some driver do have support but do not advertise it
(either in dev_info, or in the documentation).

Fixes: 70675bcc3a57 ("net/idpf: support RSS")
Fixes: cfbc66551a14 ("net/cpfl: support RSS")
Fixes: 5fb899f4b225 ("net/xsc: support RSS configuration")
Fixes: ff8db3711b29 ("net/nbl: support infos query")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/nics/features/failsafe.ini     | 1 +
 doc/guides/nics/features/nbl.ini          | 1 +
 doc/guides/nics/features/netvsc.ini       | 1 +
 drivers/net/intel/cpfl/cpfl_ethdev.c      | 3 ++-
 drivers/net/intel/cpfl/cpfl_representor.c | 4 +++-
 drivers/net/intel/idpf/idpf_ethdev.c      | 3 ++-
 drivers/net/xsc/xsc_ethdev.c              | 2 ++
 7 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/features/failsafe.ini b/doc/guides/nics/features/failsafe.ini
index 09afdc1963..b778a40be6 100644
--- a/doc/guides/nics/features/failsafe.ini
+++ b/doc/guides/nics/features/failsafe.ini
@@ -18,6 +18,7 @@ Multicast MAC filter = Y
 VLAN filter          = Y
 Flow control         = Y
 Packet type parsing  = Y
+RSS hash             = P
 Stats per queue      = Y
 ARMv7                = Y
 ARMv8                = Y
diff --git a/doc/guides/nics/features/nbl.ini b/doc/guides/nics/features/nbl.ini
index 5935092a49..e799840e40 100644
--- a/doc/guides/nics/features/nbl.ini
+++ b/doc/guides/nics/features/nbl.ini
@@ -9,6 +9,7 @@ MTU update           = Y
 Scattered Rx         = Y
 Promiscuous mode     = Y
 Unicast MAC filter   = Y
+RSS hash             = Y
 VLAN offload         = P
 Extended stats       = Y
 Stats per queue      = Y
diff --git a/doc/guides/nics/features/netvsc.ini b/doc/guides/nics/features/netvsc.ini
index fa8c2ac132..7bc7148f95 100644
--- a/doc/guides/nics/features/netvsc.ini
+++ b/doc/guides/nics/features/netvsc.ini
@@ -8,6 +8,7 @@ Speed capabilities   = P
 Free Tx mbuf on demand = Y
 Scattered Rx         = Y
 Promiscuous mode     = Y
+RSS hash             = Y
 Allmulticast mode    = Y
 Stats per queue      = Y
 Extended stats       = Y
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 32e0f81d99..0863043a2e 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -212,7 +212,8 @@ cpfl_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->hash_key_size = vport->rss_key_size;
 	dev_info->reta_size = vport->rss_lut_size;
 
-	dev_info->flow_type_rss_offloads = CPFL_RSS_OFFLOAD_ALL;
+	if (base->caps.rss_caps != 0)
+		dev_info->flow_type_rss_offloads = CPFL_RSS_OFFLOAD_ALL;
 
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM           |
diff --git a/drivers/net/intel/cpfl/cpfl_representor.c b/drivers/net/intel/cpfl/cpfl_representor.c
index 60b72b5ec1..bb28c0b989 100644
--- a/drivers/net/intel/cpfl/cpfl_representor.c
+++ b/drivers/net/intel/cpfl/cpfl_representor.c
@@ -195,6 +195,7 @@ cpfl_repr_dev_info_get(struct rte_eth_dev *ethdev,
 		       struct rte_eth_dev_info *dev_info)
 {
 	struct cpfl_repr *repr = CPFL_DEV_TO_REPR(ethdev);
+	struct cpfl_adapter_ext *adapter = repr->itf.adapter;
 
 	dev_info->device = ethdev->device;
 	dev_info->max_mac_addrs = 1;
@@ -203,7 +204,8 @@ cpfl_repr_dev_info_get(struct rte_eth_dev *ethdev,
 	dev_info->min_rx_bufsize = CPFL_MIN_BUF_SIZE;
 	dev_info->max_rx_pktlen = CPFL_MAX_FRAME_SIZE;
 
-	dev_info->flow_type_rss_offloads = CPFL_RSS_OFFLOAD_ALL;
+	if (adapter->base.caps.rss_caps != 0)
+		dev_info->flow_type_rss_offloads = CPFL_RSS_OFFLOAD_ALL;
 
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP		|
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index e9e9781fdd..5a8c783013 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -169,7 +169,8 @@ idpf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->hash_key_size = vport->rss_key_size;
 	dev_info->reta_size = vport->rss_lut_size;
 
-	dev_info->flow_type_rss_offloads = IDPF_RSS_OFFLOAD_ALL;
+	if (adapter->caps.rss_caps != 0)
+		dev_info->flow_type_rss_offloads = IDPF_RSS_OFFLOAD_ALL;
 
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM           |
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 5fbe68782e..8ac7fecd3a 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -469,6 +469,8 @@ xsc_ethdev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->if_index = priv->ifindex;
 	info->speed_capa = priv->xdev->link_speed_capa;
 	info->hash_key_size = XSC_RSS_HASH_KEY_LEN;
+	info->flow_type_rss_offloads = RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP |
+		RTE_ETH_RSS_TCP;
 	info->tx_desc_lim.nb_seg_max = 8;
 	info->tx_desc_lim.nb_mtu_seg_max = 8;
 	info->switch_info.name = dev->data->name;
-- 
2.54.0

