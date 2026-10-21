Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38957606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VGx12l3e
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99D62406B6;
	Wed, 21 Oct 2026 12:31:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3738E406A2
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYkEgdppEmhkjdpQJZsKr6KijtblU9eUx/CoUbTNWdQ=;
 b=VGx12l3eye2GxNlc6Yioa0BZCtvxpi6JDnXZ7g1fZXgmgTgY5V5sdLZ71BHU30nuyzS/7Q
 M+sr1w8w8EfWjA0+V2AvOMWQ57RiPnXBYPpMXwIFnX+qEhNHg1Ow6kDiTns6usuuPYH5Dp
 ai+iltDbdCPY8c/Qmc5Y74y98zIP3OU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-CxV5LecGMQOUSF31P9qLgg-1; Wed,
 21 Oct 2026 10:31:28 +0000
X-MC-Unique: CxV5LecGMQOUSF31P9qLgg-1
X-Mimecast-MFC-AGG-ID: CxV5LecGMQOUSF31P9qLgg_1792578686
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29C6A1800C32; Wed, 21 Oct 2026 10:31:25 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D87D430000E7; Wed, 21 Oct 2026 10:31:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH v2 11/12] ethdev: check RSS availability
Date: Wed, 21 Oct 2026 12:30:25 +0200
Message-ID: <20261021103027.2050351-12-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sYB9VjeQyVHtskTTXYLfaPk6uU2xbswuSlzVb7O2HUM_1792578686
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

Add RSS capability check in rte_eth_dev_configure() using
dev_info.flow_type_rss_offloads.

When zero, reject Rx modes with RTE_ETH_MQ_RX_RSS_FLAG.

If a driver does not advertise RSS, don't request it in test
applications or examples, as role model citizens.

Remove redundant RSS checks from drivers.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- updated all test applications and examples,
- relaxed check on RSS request for only one rxq,
- cleaned up unreachable code in cnxk and sfc representor code,

---
 app/graph/ethdev.c                            |  7 +++--
 app/test-eventdev/test_perf_common.c          |  2 ++
 app/test-eventdev/test_pipeline_common.c      |  2 ++
 devtools/check-doc-vs-code.sh                 |  4 ++-
 doc/guides/rel_notes/release_26_11.rst        |  2 ++
 drivers/net/cnxk/cnxk_rep_ops.c               | 21 ++------------
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  3 --
 drivers/net/nfp/nfp_net_common.c              |  7 -----
 drivers/net/octeontx/octeontx_ethdev.c        |  3 +-
 drivers/net/sfc/sfc_repr.c                    | 29 ++++---------------
 drivers/net/sfc/sfc_rx.c                      |  9 +-----
 examples/distributor/main.c                   |  2 ++
 examples/dma/dmafwd.c                         |  2 ++
 .../pipeline_worker_generic.c                 |  2 ++
 .../eventdev_pipeline/pipeline_worker_tx.c    |  2 ++
 examples/ip_reassembly/main.c                 |  2 ++
 examples/ipsec-secgw/ipsec-secgw.c            |  2 ++
 examples/l2fwd-event/l2fwd_common.c           |  2 ++
 examples/l3fwd-graph/main.c                   |  2 ++
 examples/l3fwd/main.c                         |  3 +-
 .../client_server_mp/mp_server/init.c         | 10 ++++++-
 examples/multi_process/symmetric_mp/main.c    |  2 ++
 examples/ntb/ntb_fwd.c                        |  2 ++
 examples/pipeline/obj.c                       |  7 +++--
 examples/qos_meter/main.c                     |  4 +++
 examples/server_node_efd/efd_server/init.c    |  3 ++
 lib/ethdev/rte_ethdev.c                       | 13 +++++++++
 27 files changed, 80 insertions(+), 69 deletions(-)

diff --git a/app/graph/ethdev.c b/app/graph/ethdev.c
index 2f4cf65c96..ee4b9014e8 100644
--- a/app/graph/ethdev.c
+++ b/app/graph/ethdev.c
@@ -426,8 +426,11 @@ ethdev_process(const char *name, struct ethdev_config *params)
 	if (rss) {
 		uint64_t rss_hf = RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP | RTE_ETH_RSS_UDP;
 
-		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_RSS;
-		port_conf.rx_adv_conf.rss_conf.rss_hf = rss_hf & port_info.flow_type_rss_offloads;
+		rss_hf &= port_info.flow_type_rss_offloads;
+		if (rss_hf != 0) {
+			port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_RSS;
+			port_conf.rx_adv_conf.rss_conf.rss_hf = rss_hf;
+		}
 	}
 
 	numa_node = rte_eth_dev_socket_id(port_id);
diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index 8201f2351a..a7858854eb 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -1917,6 +1917,8 @@ perf_ethdev_setup(struct evt_test *test, struct evt_options *opt)
 
 		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 			dev_info.flow_type_rss_offloads;
+		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+			local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf !=
 				port_conf.rx_adv_conf.rss_conf.rss_hf) {
 			evt_info("Port %u modified RSS hash function based on hardware support,"
diff --git a/app/test-eventdev/test_pipeline_common.c b/app/test-eventdev/test_pipeline_common.c
index eaf895869f..b6af0ad987 100644
--- a/app/test-eventdev/test_pipeline_common.c
+++ b/app/test-eventdev/test_pipeline_common.c
@@ -379,6 +379,8 @@ pipeline_ethdev_setup(struct evt_test *test, struct evt_options *opt)
 
 		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 			dev_info.flow_type_rss_offloads;
+		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+			local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf !=
 				port_conf.rx_adv_conf.rss_conf.rss_hf) {
 			evt_info("Port %u modified RSS hash function based on hardware support,"
diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index d4e045ca2c..a7b0f400d2 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -183,6 +183,8 @@ check_mq_caps() # <driver>
 
 	check_mq_cap $1 "DCB" "get_dcb_info" '\.get_dcb_info[[:space:]]*=' \
 		'RTE_ETH_MQ_(RX|TX).*DCB'
+	check_mq_cap $1 "RSS hash" "flow_type_rss_offloads" \
+		'flow_type_rss_offloads[[:space:]]*\|?=' 'RTE_ETH_MQ_RX.*RSS'
 	check_mq_cap $1 "VMDq" "max_vmdq_pools" 'max_vmdq_pools[[:space:]]*=' \
 		'RTE_ETH_MQ_(RX|TX).*VMDQ'
 }
@@ -203,7 +205,7 @@ if has_code_change 'RTE_FLOW_.*_TYPE_' ||
 		check_rte_flow $driver
 	done
 fi
-if has_code_change 'get_dcb_info|max_vmdq_pools|RTE_ETH_MQ_.*DCB|RTE_ETH_MQ_.*VMDQ' ||
+if has_code_change 'get_dcb_info|flow_type_rss_offloads|max_vmdq_pools|RTE_ETH_MQ_' ||
 		has_file_change 'doc/guides/nics/features'; then
 	for driver in $(changed_net_drivers); do
 		check_mq_caps $driver
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9341769c32..caffd2a611 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -428,6 +428,8 @@ API Changes
 
   * DCB modes (Rx ``RTE_ETH_MQ_RX_DCB_FLAG``, Tx ``RTE_ETH_MQ_TX_DCB``/``RTE_ETH_MQ_TX_VMDQ_DCB``)
     are rejected if the driver has no ``get_dcb_info`` callback.
+  * RSS mode (Rx ``RTE_ETH_MQ_RX_RSS_FLAG``) is rejected if the driver reports no
+    ``flow_type_rss_offloads``.
   * VMDq modes (Rx ``RTE_ETH_MQ_RX_VMDQ_FLAG``,
     Tx ``RTE_ETH_MQ_TX_VMDQ_DCB``/``RTE_ETH_MQ_TX_VMDQ_ONLY``) are rejected
     if the driver reports no VMDq pool.
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_ops.c
index 4a9c027bf5..d472cc4b08 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -133,9 +133,8 @@ cnxk_rep_representor_info_get(struct rte_eth_dev *ethdev, struct rte_eth_represe
 }
 
 static int
-rep_eth_conf_chk(const struct rte_eth_conf *conf, uint16_t nb_rx_queues)
+rep_eth_conf_chk(const struct rte_eth_conf *conf)
 {
-	const struct rte_eth_rss_conf *rss_conf;
 	int ret = 0;
 
 	if (conf->link_speeds != 0) {
@@ -144,24 +143,10 @@ rep_eth_conf_chk(const struct rte_eth_conf *conf, uint16_t nb_rx_queues)
 	}
 
 	switch (conf->rxmode.mq_mode) {
-	case RTE_ETH_MQ_RX_RSS:
-		if (nb_rx_queues != 1) {
-			plt_err("Rx RSS is not supported with %u queues", nb_rx_queues);
-			ret = -EINVAL;
-			break;
-		}
-
-		rss_conf = &conf->rx_adv_conf.rss_conf;
-		if (rss_conf->rss_key != NULL || rss_conf->rss_key_len != 0 ||
-		    rss_conf->rss_hf != 0) {
-			plt_err("Rx RSS configuration is not supported");
-			ret = -EINVAL;
-		}
-		break;
 	case RTE_ETH_MQ_RX_NONE:
 		break;
 	default:
-		plt_err("Rx mode MQ modes other than RSS not supported");
+		plt_err("Rx mode MQ modes other than none not supported");
 		ret = -EINVAL;
 		break;
 	}
@@ -205,7 +190,7 @@ cnxk_rep_dev_configure(struct rte_eth_dev *ethdev)
 	struct rte_eth_dev_data *ethdev_data = ethdev->data;
 	int rc = -1;
 
-	rc = rep_eth_conf_chk(&ethdev_data->dev_conf, ethdev_data->nb_rx_queues);
+	rc = rep_eth_conf_chk(&ethdev_data->dev_conf);
 	if (rc)
 		goto fail;
 
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index c235373daf..57a46b0ecc 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -752,9 +752,6 @@ cpfl_dev_configure(struct rte_eth_dev *dev)
 			PMD_INIT_LOG(ERR, "Failed to init rss");
 			return ret;
 		}
-	} else if (conf->rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
-		PMD_INIT_LOG(ERR, "RSS is not supported.");
-		return -ENOTSUP;
 	}
 
 	vport->max_pkt_len =
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index afa0bc0faf..f9957086d2 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -373,13 +373,6 @@ nfp_net_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	/* Checking RX mode */
-	if ((rxmode->mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) != 0 &&
-			(hw->super.cap & NFP_NET_CFG_CTRL_RSS_ANY) == 0) {
-		PMD_DRV_LOG(ERR, "RSS not supported.");
-		return -EINVAL;
-	}
-
 	/* Checking MTU set */
 	if (rxmode->mtu > hw->max_mtu + NFP_ETH_OVERHEAD) {
 		PMD_DRV_LOG(ERR, "MTU (%u) larger than the maximum possible frame size (%u).",
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index e173535d29..e0df23049c 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -499,8 +499,7 @@ octeontx_dev_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	if (rxmode->mq_mode != RTE_ETH_MQ_RX_NONE &&
-		rxmode->mq_mode != RTE_ETH_MQ_RX_RSS) {
+	if (rxmode->mq_mode != RTE_ETH_MQ_RX_NONE) {
 		octeontx_log_err("unsupported rx qmode %d", rxmode->mq_mode);
 		return -EINVAL;
 	}
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index 2be17d3c8f..079d02dff1 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -378,10 +378,8 @@ sfc_repr_dev_stop(struct rte_eth_dev *dev)
 }
 
 static int
-sfc_repr_check_conf(struct sfc_repr *sr, uint16_t nb_rx_queues,
-		    const struct rte_eth_conf *conf)
+sfc_repr_check_conf(struct sfc_repr *sr, const struct rte_eth_conf *conf)
 {
-	const struct rte_eth_rss_conf *rss_conf;
 	int ret = 0;
 
 	sfcr_info(sr, "entry");
@@ -392,25 +390,10 @@ sfc_repr_check_conf(struct sfc_repr *sr, uint16_t nb_rx_queues,
 	}
 
 	switch (conf->rxmode.mq_mode) {
-	case RTE_ETH_MQ_RX_RSS:
-		if (nb_rx_queues != 1) {
-			sfcr_err(sr, "Rx RSS is not supported with %u queues",
-				 nb_rx_queues);
-			ret = -EINVAL;
-			break;
-		}
-
-		rss_conf = &conf->rx_adv_conf.rss_conf;
-		if (rss_conf->rss_key != NULL || rss_conf->rss_key_len != 0 ||
-		    rss_conf->rss_hf != 0) {
-			sfcr_err(sr, "Rx RSS configuration is not supported");
-			ret = -EINVAL;
-		}
-		break;
 	case RTE_ETH_MQ_RX_NONE:
 		break;
 	default:
-		sfcr_err(sr, "Rx mode MQ modes other than RSS not supported");
+		sfcr_err(sr, "Rx mode MQ modes other than none not supported");
 		ret = -EINVAL;
 		break;
 	}
@@ -452,8 +435,7 @@ sfc_repr_check_conf(struct sfc_repr *sr, uint16_t nb_rx_queues,
 
 
 static int
-sfc_repr_configure(struct sfc_repr *sr, uint16_t nb_rx_queues,
-		   const struct rte_eth_conf *conf)
+sfc_repr_configure(struct sfc_repr *sr, const struct rte_eth_conf *conf)
 {
 	int ret;
 
@@ -461,7 +443,7 @@ sfc_repr_configure(struct sfc_repr *sr, uint16_t nb_rx_queues,
 
 	SFC_ASSERT(sfc_repr_lock_is_locked(sr));
 
-	ret = sfc_repr_check_conf(sr, nb_rx_queues, conf);
+	ret = sfc_repr_check_conf(sr, conf);
 	if (ret != 0)
 		goto fail_check_conf;
 
@@ -491,8 +473,7 @@ sfc_repr_dev_configure(struct rte_eth_dev *dev)
 	case SFC_ETHDEV_CONFIGURED:
 		/* FALLTHROUGH */
 	case SFC_ETHDEV_INITIALIZED:
-		ret = sfc_repr_configure(sr, dev_data->nb_rx_queues,
-					 &dev_data->dev_conf);
+		ret = sfc_repr_configure(sr, &dev_data->dev_conf);
 		break;
 	default:
 		sfcr_err(sr, "unexpected adapter state %u to configure",
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index 1d4101b9e9..aa59931f06 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1668,21 +1668,14 @@ sfc_rx_qinit_info(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 static int
 sfc_rx_check_mode(struct sfc_adapter *sa, struct rte_eth_rxmode *rxmode)
 {
-	struct sfc_adapter_shared * const sas = sfc_sa2shared(sa);
 	uint64_t offloads_supported = sfc_rx_get_dev_offload_caps(sa) |
 				      sfc_rx_get_queue_offload_caps(sa);
-	struct sfc_rss *rss = &sas->rss;
 	int rc = 0;
 
 	switch (rxmode->mq_mode) {
 	case RTE_ETH_MQ_RX_NONE:
-		/* No special checks are required */
-		break;
 	case RTE_ETH_MQ_RX_RSS:
-		if (rss->context_type == EFX_RX_SCALE_UNAVAILABLE) {
-			sfc_err(sa, "RSS is not available");
-			rc = EINVAL;
-		}
+		/* No special checks are required */
 		break;
 	default:
 		sfc_err(sa, "Rx multi-queue mode %u not supported",
diff --git a/examples/distributor/main.c b/examples/distributor/main.c
index 0905482cf0..344da03814 100644
--- a/examples/distributor/main.c
+++ b/examples/distributor/main.c
@@ -135,6 +135,8 @@ port_init(uint16_t port, struct rte_mempool *mbuf_pool)
 
 	port_conf.rx_adv_conf.rss_conf.rss_hf &=
 		dev_info.flow_type_rss_offloads;
+	if (port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 	if (port_conf.rx_adv_conf.rss_conf.rss_hf !=
 			port_conf_default.rx_adv_conf.rss_conf.rss_hf) {
 		printf("Port %u modified RSS hash function based on hardware support,"
diff --git a/examples/dma/dmafwd.c b/examples/dma/dmafwd.c
index 8d195faddb..fea1c3e669 100644
--- a/examples/dma/dmafwd.c
+++ b/examples/dma/dmafwd.c
@@ -922,6 +922,8 @@ port_init(uint16_t portid, struct rte_mempool *mbuf_pool)
 
 	local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 		dev_info.flow_type_rss_offloads;
+	if (local_port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+		local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 	ret = rte_eth_dev_configure(portid, nb_queues, 1, &local_port_conf);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE, "Cannot configure device:"
diff --git a/examples/eventdev_pipeline/pipeline_worker_generic.c b/examples/eventdev_pipeline/pipeline_worker_generic.c
index c0de5b1e11..77d9d91043 100644
--- a/examples/eventdev_pipeline/pipeline_worker_generic.c
+++ b/examples/eventdev_pipeline/pipeline_worker_generic.c
@@ -338,6 +338,8 @@ port_init(uint8_t port, struct rte_mempool *mbuf_pool)
 
 	port_conf.rx_adv_conf.rss_conf.rss_hf &=
 		dev_info.flow_type_rss_offloads;
+	if (port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 	if (port_conf.rx_adv_conf.rss_conf.rss_hf !=
 			port_conf_default.rx_adv_conf.rss_conf.rss_hf) {
 		printf("Port %u modified RSS hash function based on hardware support,"
diff --git a/examples/eventdev_pipeline/pipeline_worker_tx.c b/examples/eventdev_pipeline/pipeline_worker_tx.c
index a3090e3b49..174976a1b5 100644
--- a/examples/eventdev_pipeline/pipeline_worker_tx.c
+++ b/examples/eventdev_pipeline/pipeline_worker_tx.c
@@ -683,6 +683,8 @@ port_init(uint8_t port, struct rte_mempool *mbuf_pool)
 
 	port_conf.rx_adv_conf.rss_conf.rss_hf &=
 		dev_info.flow_type_rss_offloads;
+	if (port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 	if (port_conf.rx_adv_conf.rss_conf.rss_hf !=
 			port_conf_default.rx_adv_conf.rss_conf.rss_hf) {
 		printf("Port %u modified RSS hash function based on hardware support,"
diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 0814d47a66..321a50b1f6 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -1102,6 +1102,8 @@ main(int argc, char **argv)
 
 		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 			dev_info.flow_type_rss_offloads;
+		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+			local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf !=
 				port_conf.rx_adv_conf.rss_conf.rss_hf) {
 			printf("Port %u modified RSS hash function based on hardware support,"
diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index 4816bcdd82..2741faf04e 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -2016,6 +2016,8 @@ port_init(uint16_t portid, uint64_t req_rx_offloads, uint64_t req_tx_offloads,
 
 	local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 		dev_info.flow_type_rss_offloads;
+	if (local_port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+		local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 	if (local_port_conf.rx_adv_conf.rss_conf.rss_hf !=
 			port_conf.rx_adv_conf.rss_conf.rss_hf) {
 		printf("Port %u modified RSS hash function based on hardware support,"
diff --git a/examples/l2fwd-event/l2fwd_common.c b/examples/l2fwd-event/l2fwd_common.c
index b4d5edfde0..caacf6cd63 100644
--- a/examples/l2fwd-event/l2fwd_common.c
+++ b/examples/l2fwd-event/l2fwd_common.c
@@ -48,6 +48,8 @@ l2fwd_event_init_ports(struct l2fwd_resources *rsrc)
 				  port_id, strerror(-ret));
 		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 			dev_info.flow_type_rss_offloads;
+		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+			local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf !=
 				port_conf.rx_adv_conf.rss_conf.rss_hf) {
 			printf("Port %u modified RSS hash function based on hardware support,"
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 4fa302f5b0..08fe177fc2 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -1092,6 +1092,8 @@ main(int argc, char **argv)
 
 		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 			dev_info.flow_type_rss_offloads;
+		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+			local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf !=
 		    port_conf.rx_adv_conf.rss_conf.rss_hf) {
 			printf("Port %u modified RSS hash function based on "
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 6866811526..9532150a47 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -1394,7 +1394,8 @@ l3fwd_poll_resource_setup(void)
 		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 			dev_info.flow_type_rss_offloads;
 
-		if (disable_rss == 1 || dev_info.max_rx_queues == 1)
+		if (disable_rss == 1 || dev_info.max_rx_queues == 1 ||
+				local_port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
 			local_port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 
 		if (local_port_conf.rx_adv_conf.rss_conf.rss_hf !=
diff --git a/examples/multi_process/client_server_mp/mp_server/init.c b/examples/multi_process/client_server_mp/mp_server/init.c
index f3b9b49380..09cb363ab8 100644
--- a/examples/multi_process/client_server_mp/mp_server/init.c
+++ b/examples/multi_process/client_server_mp/mp_server/init.c
@@ -91,7 +91,7 @@ static int
 init_port(uint16_t port_num)
 {
 	/* for port configuration all features are off by default */
-	const struct rte_eth_conf port_conf = {
+	struct rte_eth_conf port_conf = {
 		.rxmode = {
 			.mq_mode = RTE_ETH_MQ_RX_RSS
 		}
@@ -99,6 +99,7 @@ init_port(uint16_t port_num)
 	const uint16_t rx_rings = 1, tx_rings = num_clients;
 	uint16_t rx_ring_size = RTE_MP_RX_DESC_DEFAULT;
 	uint16_t tx_ring_size = RTE_MP_TX_DESC_DEFAULT;
+	struct rte_eth_dev_info dev_info;
 
 	uint16_t q;
 	int retval;
@@ -106,6 +107,13 @@ init_port(uint16_t port_num)
 	printf("Port %u init ... ", port_num);
 	fflush(stdout);
 
+	retval = rte_eth_dev_info_get(port_num, &dev_info);
+	if (retval != 0)
+		return retval;
+
+	if (dev_info.flow_type_rss_offloads == 0)
+		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+
 	/* Standard DPDK port initialisation - config port, then set up
 	 * rx and tx rings */
 	if ((retval = rte_eth_dev_configure(port_num, rx_rings, tx_rings,
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index e2d185ab1b..d250a738f8 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -228,6 +228,8 @@ smp_port_init(uint16_t port, struct rte_mempool *mbuf_pool,
 
 	rss_hf_tmp = port_conf.rx_adv_conf.rss_conf.rss_hf;
 	port_conf.rx_adv_conf.rss_conf.rss_hf &= info.flow_type_rss_offloads;
+	if (port_conf.rx_adv_conf.rss_conf.rss_hf == 0)
+		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 	if (port_conf.rx_adv_conf.rss_conf.rss_hf != rss_hf_tmp) {
 		printf("Port %u modified RSS hash function based on hardware support,"
 			"requested:%#"PRIx64" configured:%#"PRIx64"\n",
diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
index bbacce97db..30716d427d 100644
--- a/examples/ntb/ntb_fwd.c
+++ b/examples/ntb/ntb_fwd.c
@@ -1310,6 +1310,8 @@ main(int argc, char **argv)
 
 		eth_pconf.rx_adv_conf.rss_conf.rss_hf &=
 				ethdev_info.flow_type_rss_offloads;
+		if (eth_pconf.rx_adv_conf.rss_conf.rss_hf == 0)
+			eth_pconf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 		ret = rte_eth_dev_configure(eth_port_id, num_queues,
 					    num_queues, &eth_pconf);
 		if (ret)
diff --git a/examples/pipeline/obj.c b/examples/pipeline/obj.c
index d39034ec22..9f49df190e 100644
--- a/examples/pipeline/obj.c
+++ b/examples/pipeline/obj.c
@@ -118,8 +118,11 @@ ethdev_config(const char *name, struct ethdev_params *params)
 	if (rss) {
 		uint64_t rss_hf = RTE_ETH_RSS_IP | RTE_ETH_RSS_TCP | RTE_ETH_RSS_UDP;
 
-		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_RSS;
-		port_conf.rx_adv_conf.rss_conf.rss_hf = rss_hf & port_info.flow_type_rss_offloads;
+		rss_hf &= port_info.flow_type_rss_offloads;
+		if (rss_hf != 0) {
+			port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_RSS;
+			port_conf.rx_adv_conf.rss_conf.rss_hf = rss_hf;
+		}
 	}
 
 	numa_node = rte_eth_dev_socket_id(port_id);
diff --git a/examples/qos_meter/main.c b/examples/qos_meter/main.c
index da1b0b2287..59759355cd 100644
--- a/examples/qos_meter/main.c
+++ b/examples/qos_meter/main.c
@@ -336,6 +336,8 @@ main(int argc, char **argv)
 		conf.txmode.offloads |= RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 
 	conf.rx_adv_conf.rss_conf.rss_hf &= dev_info.flow_type_rss_offloads;
+	if (conf.rx_adv_conf.rss_conf.rss_hf == 0)
+		conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 	if (conf.rx_adv_conf.rss_conf.rss_hf !=
 			port_conf.rx_adv_conf.rss_conf.rss_hf) {
 		printf("Port %u modified RSS hash function based on hardware support,"
@@ -382,6 +384,8 @@ main(int argc, char **argv)
 		conf.txmode.offloads |= RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 
 	conf.rx_adv_conf.rss_conf.rss_hf &= dev_info.flow_type_rss_offloads;
+	if (conf.rx_adv_conf.rss_conf.rss_hf == 0)
+		conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
 	if (conf.rx_adv_conf.rss_conf.rss_hf !=
 			port_conf.rx_adv_conf.rss_conf.rss_hf) {
 		printf("Port %u modified RSS hash function based on hardware support,"
diff --git a/examples/server_node_efd/efd_server/init.c b/examples/server_node_efd/efd_server/init.c
index 9a20831a0d..9644627219 100644
--- a/examples/server_node_efd/efd_server/init.c
+++ b/examples/server_node_efd/efd_server/init.c
@@ -118,6 +118,9 @@ init_port(uint16_t port_num)
 		port_conf.txmode.offloads |=
 			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 
+	if (dev_info.flow_type_rss_offloads == 0)
+		port_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+
 	/*
 	 * Standard DPDK port initialisation - config port, then set up
 	 * rx and tx rings.
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 39a895c9e4..0988f69275 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1526,6 +1526,19 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
+	if (dev_info.flow_type_rss_offloads == 0 &&
+			(dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) != 0) {
+		if (nb_rx_q > 1) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support RSS rx mode",
+				port_id);
+			ret = -EINVAL;
+			goto rollback;
+		}
+		RTE_ETHDEV_LOG_LINE(NOTICE, "Ethdev port_id=%u does not support RSS rx mode, ignoring",
+			port_id);
+		dev->data->dev_conf.rxmode.mq_mode &= ~RTE_ETH_MQ_RX_RSS_FLAG;
+	}
+
 	dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf =
 		rte_eth_rss_hf_refine(dev_conf->rx_adv_conf.rss_conf.rss_hf);
 
-- 
2.54.0

