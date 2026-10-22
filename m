Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD91606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QXx+GyBK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 854D240A87;
	Thu, 22 Oct 2026 19:45:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 02CDA4067B
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792691151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQqpfz7ht5/dnnO3+r/u/cLsA05Podez8ptYFOQIpPw=;
 b=QXx+GyBK4l5PdkGBbB0n/94l6Z5wJKHDYalyG7x+Vk0FvojUt/No4z9+iOI/uX01m8QKsd
 XCgLGKZHBZY4o8XLA575k+kZXRST7qou9eevdSegOCLexhe41z9M/xOHFmvBhivh4OPU8+
 Xsh0D2M8yKglyB7nOqwKEs0bcipufyg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-avzEMAksOEy-vNv8MtjPTQ-1; Thu,
 22 Oct 2026 13:45:49 -0400
X-MC-Unique: avzEMAksOEy-vNv8MtjPTQ-1
X-Mimecast-MFC-AGG-ID: avzEMAksOEy-vNv8MtjPTQ_1792691147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32AC21955DAE; Thu, 22 Oct 2026 17:45:46 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C51CB1955F22; Thu, 22 Oct 2026 17:45:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stable@dpdk.org, Renyong Wan <wanry@yunsilicon.com>,
 Gaetan Rivet <grive@u256.net>, Rosen Xu <rosen.xu@altera.com>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Wei Hu <weh@microsoft.com>, Praveen Shetty <praveen.shetty@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>, Dan Wei <dan.wei@intel.com>,
 Andy Pei <andy.pei@intel.com>, Beilei Xing <beilei.xing@intel.com>,
 Junfeng Guo <junfengg@nvidia.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 Mingxia Liu <mingxia.liu@intel.com>
Subject: [PATCH v3 11/13] drivers/net: fix reported RSS capability
Date: Thu, 22 Oct 2026 19:44:38 +0200
Message-ID: <20261022174447.412638-12-david.marchand@redhat.com>
In-Reply-To: <20261022174447.412638-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4FTvGRbRHcgzjx94rNg8-B2f_R2CwUhlwoDtf4Se8lA_1792691147
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

Some drivers (idpf, cpfl) report RSS support even if lacking HW support.
On the other hand, some driver do have support but do not advertise it
(either in dev_info, or in the documentation).

failsafe may support RSS, as it only passes the requests to the ports
attached to it, hence mark it as partial support.

Fixes: c01c748e4ae6 ("net/ipn3ke: add new driver")
Fixes: 70675bcc3a57 ("net/idpf: support RSS")
Fixes: cfbc66551a14 ("net/cpfl: support RSS")
Fixes: 5fb899f4b225 ("net/xsc: support RSS configuration")
Fixes: 9f75cad1287f ("net/xsc: add PCT interfaces")
Fixes: ff8db3711b29 ("net/nbl: support infos query")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Renyong Wan <wanry@yunsilicon.com>
---
Changes since v1:
- fixed ip3nke,
- moved all RSS capabilities under check for idpf and cpfl,
- adjusted xsc RSS capabilities,

---
 doc/guides/nics/features/failsafe.ini     | 1 +
 doc/guides/nics/features/ipn3ke.ini       | 3 ---
 doc/guides/nics/features/nbl.ini          | 1 +
 doc/guides/nics/features/netvsc.ini       | 1 +
 drivers/net/intel/cpfl/cpfl_ethdev.c      | 9 +++++----
 drivers/net/intel/cpfl/cpfl_representor.c | 4 +++-
 drivers/net/intel/idpf/idpf_ethdev.c      | 9 +++++----
 drivers/net/xsc/xsc_ethdev.c              | 4 ++++
 8 files changed, 20 insertions(+), 12 deletions(-)

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
diff --git a/doc/guides/nics/features/ipn3ke.ini b/doc/guides/nics/features/ipn3ke.ini
index 6abaf9e4f9..1f9a28f198 100644
--- a/doc/guides/nics/features/ipn3ke.ini
+++ b/doc/guides/nics/features/ipn3ke.ini
@@ -15,9 +15,6 @@ Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
 Multicast MAC filter = Y
-RSS hash             = Y
-RSS key update       = Y
-RSS reta update      = Y
 SR-IOV               = Y
 VLAN filter          = Y
 Flow control         = Y
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
index 32e0f81d99..c235373daf 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -209,10 +209,11 @@ cpfl_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_mtu = vport->max_mtu;
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
-	dev_info->hash_key_size = vport->rss_key_size;
-	dev_info->reta_size = vport->rss_lut_size;
-
-	dev_info->flow_type_rss_offloads = CPFL_RSS_OFFLOAD_ALL;
+	if (base->caps.rss_caps != 0) {
+		dev_info->hash_key_size = vport->rss_key_size;
+		dev_info->reta_size = vport->rss_lut_size;
+		dev_info->flow_type_rss_offloads = CPFL_RSS_OFFLOAD_ALL;
+	}
 
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
index e9e9781fdd..fbd50d0a91 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -166,10 +166,11 @@ idpf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_mtu = vport->max_mtu;
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
-	dev_info->hash_key_size = vport->rss_key_size;
-	dev_info->reta_size = vport->rss_lut_size;
-
-	dev_info->flow_type_rss_offloads = IDPF_RSS_OFFLOAD_ALL;
+	if (adapter->caps.rss_caps != 0) {
+		dev_info->hash_key_size = vport->rss_key_size;
+		dev_info->reta_size = vport->rss_lut_size;
+		dev_info->flow_type_rss_offloads = IDPF_RSS_OFFLOAD_ALL;
+	}
 
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM           |
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 5fbe68782e..20d6f58f68 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -469,6 +469,10 @@ xsc_ethdev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->if_index = priv->ifindex;
 	info->speed_capa = priv->xdev->link_speed_capa;
 	info->hash_key_size = XSC_RSS_HASH_KEY_LEN;
+	info->flow_type_rss_offloads = RTE_ETH_RSS_IP | RTE_ETH_RSS_UDP |
+		RTE_ETH_RSS_TCP | RTE_ETH_RSS_L3_SRC_ONLY |
+		RTE_ETH_RSS_L3_DST_ONLY | RTE_ETH_RSS_L4_SRC_ONLY |
+		RTE_ETH_RSS_L4_DST_ONLY | RTE_ETH_RSS_LEVEL_INNERMOST;
 	info->tx_desc_lim.nb_seg_max = 8;
 	info->tx_desc_lim.nb_mtu_seg_max = 8;
 	info->switch_info.name = dev->data->name;
-- 
2.54.0

