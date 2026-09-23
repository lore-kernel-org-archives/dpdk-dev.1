Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC9C982FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 03:26:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 631B7427E9;
	Wed, 23 Sep 2026 05:26:02 +0200 (CEST)
Received: from flow-b4-smtp.messagingengine.com
 (flow-b4-smtp.messagingengine.com [202.12.124.139])
 by mails.dpdk.org (Postfix) with ESMTP id 9C1E240DD2
 for <dev@dpdk.org>; Wed, 23 Sep 2026 05:26:00 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailflow.stl.internal (Postfix) with ESMTP id AFFB0130053A;
 Tue, 22 Sep 2026 23:25:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 22 Sep 2026 23:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1790133957; x=
 1790141157; bh=hbVeRZnB0d3DIWgxoDJDog3vQcWAddf1tn8yI4sUPbs=; b=c
 SIObHlJ3kBBOr8NkJ+q99zVslpgyN++PYauJKfJKtJmzX2U9Fz4lj4KjLgLctlRX
 40oUqZLpmr5D2bsYRGHGtTGIX8ko3ZS0KCO4OIF2z7fJuq6kmtkZ1vbP5dFVRUm7
 K5573tBwiCbwkEmBjpHty2bf+n0Gjlw1WAk0r/m8RI21SUr0QJZcp55aPTb3rfDD
 Hq4PCGpQtPFvoqDYRLFDanBVf119MSBGfRBh7MYYnApeJ4Fl1ox5fecA05Sd7Ehw
 5igH4xtGN9HHNoBijnM+nxdv7ck8qV4sQg1v+w71FpJwz+sC2ts9sMY/tkG4si02
 liqe+xyNNp61IoWxg0Hew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790133957; x=1790141157; bh=h
 bVeRZnB0d3DIWgxoDJDog3vQcWAddf1tn8yI4sUPbs=; b=qjblOCNoSCc6zcInP
 pRt/6rxav2HyTy8NGkepEKSJgF+KothBX8xJ81kkwOQf2DBRJnJjZOqrsU6yDyYt
 VwOTFUX0fSDQ9orlnKmySOCQHrSIBtk4FmWgAWAqkvWkN+SsKtCqIKdTWRsACpTE
 Q0oDSgb2Wn5lodUyOUcf2rVsN5x/q36Ugmf+2JEIC7wo1rGqt0Uim+WFUYsLlsb3
 LvfQObXhi5oFacJEMuchvaJQvVR0i+Cfy7YJe1yiJOorQd2ogTxeooL5OOFILyAj
 Ce8dPmsdkW5NnWCQYkUXaPtxCvP8ZHF9yEjRjbbBoRZgHEivmgYnXg7+Emvw/iC5
 LiihA==
X-ME-Sender: <xms:wUazah6Byc7C_SdC2SUFTjv_7S6DI6vtSPwk1o0Uhf2JpWhh6Jm_fA>
 <xme:wUazap7Ti3o-KKTdEEWAuHZ9vN-91_cRKRCs5JNkBLXyJermwOJNbL94WfV7e1eAL
 R9kmF7_IwX0HkMZ6Q9yxkavj1akDjhPkGzWg-_igkC1_76koR2opmU>
X-ME-Received: <xmr:wUazanfCAfqDu4_v6lDX_ZYg64SmCH8C98HXaU5F8XdKRixXNdeLJk9uw7_fZuyUa84pLLiC7Z2O_GkqLQdVldk48ONo>
X-ME-Proxy-Cause: dmFkZTE4CKREfokxeVwlXzNEcxv7yA8PLvUgmma3E7HbK4sw4eEaui9lrjX4PQFw/72k2u
 nzC8I+XcDoBzH6OMfXIkNpSd6U1Zm0spQhiWg+7uw1r1OwRU6YryXYPVUA65imQyPDoh8m
 CVgDQlgOCMy9mc9I6MwFQEvQb4LGTIMxxCmjfBBjR/33vTXe/A4bnYmfW3oa8i93HFJn1m
 hLGcBlof6dLNEejVJFIwlEd9yH3LTCYhCgyZn0JrGxuWzxmQCT/uuf1Atu+NhEH7aCZZTx
 y02KYNKqpKzk5UJ0L9cCUJ1S1PDAEpTsYb5SOd/WTxE09HouxAeyOB7+rYxwrv2IBOqoEg
 EZSjuBtZT7xhOrO1FkGNBuRDl6C9X2IisYtHMMkH2etwk5x7Ry6ISk8mCevpAgNFCw4MMR
 Iy0lPXFFjsQoRN0Bx8GWoVOj/jDs+Xo1duSRmXnnaPZkdipbRHqk9Bz5ILw00UvCksqicv
 ynUWtt6PRO2BoDGpD8IhI5gsSG8PLRTM79aYGPkftzaqi1LkigmOOBzntBNfaozWURs/+d
 KPtxNCkxpmeT//4AjWSdpUJHP0RX8OGdUs+Jcl5YK3ZyAXSGS3U2COMmTGa01puA2QNMok
 PolDHGllh+PR4L/+DN40UHKj1lvCfqpqRShCI+WcTaYDMwBnGrjFzrARGY+w
X-ME-Proxy: <xmx:wUazar3JPOpMHXUOzyWxp4oDHPAoReUqmcFnpmPB9ZT9hVVkkzAvpA>
 <xmx:wUazakzA93kYJGGi8uwRE6Bp9CBrA2z6YnSkbi7_2oA8N_R-rLx8TA>
 <xmx:wUazaoWJ0SBd08mfDQczIDUig80Ybi8mX5Z5rGSCcBFvUJLmh9QYRg>
 <xmx:wUazam3eMQEaNl97Y0ZSrtwA3BV8ykA6cvDYyWe4E5pYDIO7qzaeFw>
 <xmx:xUazakjz6SsoC8Ap_INGPET47bFImTPqEAFtKah9e6C_9aLFdPEQF9RV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 23:25:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,	Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>,
 Wajeeh Atrash <atrwajee@amazon.com>,	Gagandeep Singh <g.singh@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>,
 John Daley <johndale@cisco.com>,	Hyong Youb Kim <hyonkim@cisco.com>,
 Gaetan Rivet <grive@u256.net>,	Joshua Washington <joshwash@google.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,	Andrew Boyer <andrew.boyer@amd.com>,
 Rosen Xu <rosen.xu@altera.com>,	Wei Hu <weh@microsoft.com>,
 Jakub Grajciar <jgrajcia@cisco.com>,	Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,	Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>,	Suanming Mou <suanmingm@nvidia.com>,
 Zyta Szpak <zyta@marvell.com>,	Liron Himi <lironh@marvell.com>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Martin Spinler <spinler@cesnet.cz>,	Jiawen Wu <jiawenwu@trustnetic.com>,
 Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,
 Howard Wang <howard_wang@realsil.com.cn>,	Chunhao Lin <hau@realtek.com>,
 Xing Wang <xing_wang@realsil.com.cn>,	Javen Xu <javen_xu@realsil.com.cn>,
 Wenbo Cao <caowenbo@mucse.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jie Liu <liujie5@linkdatatechnology.com>,
 Jerin Jacob <jerinj@marvell.com>,	Maciej Czekaj <mczekaj@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Renyong Wan <wanry@yunsilicon.com>,	Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>,
 Junlong Wang <wang.junlong1@zte.com.cn>,	Ming Ran <ran.ming@zte.com.cn>
Subject: [PATCH 3/3] doc: simplify NIC feature matrices
Date: Wed, 23 Sep 2026 05:20:51 +0200
Message-ID: <20260923032502.770744-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923032502.770744-1-thomas@monjalon.net>
References: <20260923032502.770744-1-thomas@monjalon.net>
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

Remove rows which are not useful in the NIC feature overview:
documentation availability, basic stats and link status.
The last two are always implemented so they are not really useful
in the matrix but their description are kept in features.rst.

Merge Rx/Tx variants when the support is identical:
descriptor status and runtime queue setup.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/nics/features.rst           | 87 ++++++--------------------
 doc/guides/nics/features/af_xdp.ini    |  2 -
 doc/guides/nics/features/afpacket.ini  |  2 -
 doc/guides/nics/features/ark.ini       |  2 -
 doc/guides/nics/features/atlantic.ini  |  5 +-
 doc/guides/nics/features/avp.ini       |  2 -
 doc/guides/nics/features/axgbe.ini     |  2 -
 doc/guides/nics/features/bnx2x.ini     |  3 -
 doc/guides/nics/features/bnxt.ini      | 10 +--
 doc/guides/nics/features/cnxk.ini      |  9 +--
 doc/guides/nics/features/cnxk_vec.ini  |  9 +--
 doc/guides/nics/features/cnxk_vf.ini   |  9 +--
 doc/guides/nics/features/cpfl.ini      |  2 -
 doc/guides/nics/features/cxgbe.ini     |  3 -
 doc/guides/nics/features/cxgbevf.ini   |  3 -
 doc/guides/nics/features/default.ini   | 11 +---
 doc/guides/nics/features/dpaa.ini      |  3 -
 doc/guides/nics/features/dpaa2.ini     |  3 -
 doc/guides/nics/features/e1000.ini     |  5 +-
 doc/guides/nics/features/ena.ini       |  4 --
 doc/guides/nics/features/enetc.ini     |  3 -
 doc/guides/nics/features/enetc4.ini    |  3 -
 doc/guides/nics/features/enetc4_vf.ini |  3 -
 doc/guides/nics/features/enetfec.ini   |  2 -
 doc/guides/nics/features/enic.ini      |  3 -
 doc/guides/nics/features/failsafe.ini  |  6 +-
 doc/guides/nics/features/fm10k.ini     |  5 +-
 doc/guides/nics/features/fm10k_vf.ini  |  2 -
 doc/guides/nics/features/gve.ini       |  3 -
 doc/guides/nics/features/hinic.ini     |  2 -
 doc/guides/nics/features/hinic3.ini    |  5 +-
 doc/guides/nics/features/hns3.ini      |  8 +--
 doc/guides/nics/features/hns3_vf.ini   |  8 +--
 doc/guides/nics/features/i40e.ini      |  8 +--
 doc/guides/nics/features/iavf.ini      |  8 +--
 doc/guides/nics/features/ice.ini       |  5 +-
 doc/guides/nics/features/ice_dcf.ini   |  1 -
 doc/guides/nics/features/idpf.ini      |  2 -
 doc/guides/nics/features/igb.ini       |  5 +-
 doc/guides/nics/features/igb_vf.ini    |  5 +-
 doc/guides/nics/features/igc.ini       |  5 +-
 doc/guides/nics/features/ionic.ini     |  6 +-
 doc/guides/nics/features/ipn3ke.ini    |  8 +--
 doc/guides/nics/features/ixgbe.ini     |  5 +-
 doc/guides/nics/features/ixgbe_vf.ini  |  5 +-
 doc/guides/nics/features/mana.ini      |  3 -
 doc/guides/nics/features/memif.ini     |  3 -
 doc/guides/nics/features/mlx4.ini      |  3 -
 doc/guides/nics/features/mlx5.ini      |  7 +--
 doc/guides/nics/features/mvneta.ini    |  3 -
 doc/guides/nics/features/mvpp2.ini     |  3 -
 doc/guides/nics/features/nbl.ini       |  1 -
 doc/guides/nics/features/netvsc.ini    |  3 -
 doc/guides/nics/features/nfb.ini       |  3 -
 doc/guides/nics/features/nfp.ini       |  3 -
 doc/guides/nics/features/ngbe.ini      |  5 +-
 doc/guides/nics/features/ngbe_vf.ini   |  5 +-
 doc/guides/nics/features/ntnic.ini     |  2 -
 doc/guides/nics/features/octeon_ep.ini |  3 -
 doc/guides/nics/features/octeontx.ini  |  3 -
 doc/guides/nics/features/pcap.ini      |  3 -
 doc/guides/nics/features/pfe.ini       |  3 -
 doc/guides/nics/features/qede.ini      |  3 -
 doc/guides/nics/features/qede_vf.ini   |  3 -
 doc/guides/nics/features/r8169.ini     |  2 -
 doc/guides/nics/features/rnp.ini       |  2 -
 doc/guides/nics/features/sfc.ini       |  8 +--
 doc/guides/nics/features/sxe2.ini      |  5 +-
 doc/guides/nics/features/tap.ini       |  3 -
 doc/guides/nics/features/thunderx.ini  |  3 -
 doc/guides/nics/features/txgbe.ini     |  5 +-
 doc/guides/nics/features/txgbe_vf.ini  |  5 +-
 doc/guides/nics/features/vhost.ini     |  2 -
 doc/guides/nics/features/virtio.ini    |  3 -
 doc/guides/nics/features/vmxnet3.ini   |  3 -
 doc/guides/nics/features/xsc.ini       |  2 -
 doc/guides/nics/features/zxdh.ini      |  2 -
 77 files changed, 60 insertions(+), 339 deletions(-)

diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index 43eda7867d..2d098af677 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -157,6 +157,18 @@ This is required for use deferred start configuration option.
   ``rte_eth_dev_tx_queue_start()``, ``rte_eth_dev_tx_queue_stop()``.
 
 
+.. _nic_features_runtime_queue_setup:
+
+Runtime queue setup
+-------------------
+
+Supports Rx and Tx queue setup after the device has started.
+
+* **[provides] rte_eth_dev_info**: ``dev_capa:RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP``,
+  ``dev_capa:RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP``.
+* **[related]  API**: ``rte_eth_dev_info_get()``.
+
+
 .. _nic_features_mtu_update:
 
 MTU update
@@ -703,28 +715,17 @@ Supports IEEE1588/802.1AS timestamping.
   ``rte_eth_timesync_read_time()``, ``rte_eth_timesync_write_time()``.
 
 
-.. _nic_features_rx_descriptor_status:
+.. _nic_features_descriptor_status:
 
-Rx descriptor status
---------------------
+Descriptor status
+-----------------
 
-Supports check the status of a Rx descriptor. When ``rx_descriptor_status`` is
-used, status can be "Available", "Done" or "Unavailable".
+Supports checking the status of Rx and Tx descriptors.
+Rx status can be "Available", "Done" or "Unavailable".
+Tx status can be "Full", "Done" or "Unavailable".
 
-* **[implements] rte_eth_dev**: ``rx_descriptor_status``.
-* **[related]    API**: ``rte_eth_rx_descriptor_status()``.
-
-
-.. _nic_features_tx_descriptor_status:
-
-Tx descriptor status
---------------------
-
-Supports checking the status of a Tx descriptor. Status can be "Full", "Done"
-or "Unavailable."
-
-* **[implements] rte_eth_dev**: ``tx_descriptor_status``.
-* **[related]    API**: ``rte_eth_tx_descriptor_status()``.
+* **[implements] rte_eth_dev**: ``rx_descriptor_status``, ``tx_descriptor_status``.
+* **[related]    API**: ``rte_eth_rx_descriptor_status()``, ``rte_eth_tx_descriptor_status()``.
 
 
 .. _nic_features_tx_queue_count:
@@ -947,54 +948,6 @@ x86-64
 
 Support 64bits x86 architecture.
 
-.. _nic_features_usage_doc:
-
-Usage doc
----------
-
-Documentation describes usage.
-
-See ``doc/guides/nics/*.rst``
-
-
-.. _nic_features_design_doc:
-
-Design doc
-----------
-
-Documentation describes design.
-
-See ``doc/guides/nics/*.rst``.
-
-
-.. _nic_features_perf_doc:
-
-Perf doc
---------
-
-Documentation describes performance values.
-
-See ``dpdk.org/doc/perf/*``.
-
-.. _nic_features_runtime_rx_queue_setup:
-
-Runtime Rx queue setup
-----------------------
-
-Supports Rx queue setup after device started.
-
-* **[provides] rte_eth_dev_info**: ``dev_capa:RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP``.
-* **[related]  API**: ``rte_eth_dev_info_get()``.
-
-.. _nic_features_runtime_tx_queue_setup:
-
-Runtime Tx queue setup
-----------------------
-
-Supports Tx queue setup after device started.
-
-* **[provides] rte_eth_dev_info**: ``dev_capa:RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP``.
-* **[related]  API**: ``rte_eth_dev_info_get()``.
 
 .. _nic_features_burst_mode_info:
 
diff --git a/doc/guides/nics/features/af_xdp.ini b/doc/guides/nics/features/af_xdp.ini
index 57614fae94..933b727ed7 100644
--- a/doc/guides/nics/features/af_xdp.ini
+++ b/doc/guides/nics/features/af_xdp.ini
@@ -4,12 +4,10 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Timestamp offload    = Y
-Basic stats          = Y
 Stats per queue      = Y
 Multiprocess aware   = Y
 x86-64               = Y
diff --git a/doc/guides/nics/features/afpacket.ini b/doc/guides/nics/features/afpacket.ini
index 391f79b173..bc669dfb8a 100644
--- a/doc/guides/nics/features/afpacket.ini
+++ b/doc/guides/nics/features/afpacket.ini
@@ -4,8 +4,6 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Promiscuous mode     = Y
 MTU update           = Y
-Basic stats          = Y
 Stats per queue      = Y
diff --git a/doc/guides/nics/features/ark.ini b/doc/guides/nics/features/ark.ini
index 87b4209165..42d6035805 100644
--- a/doc/guides/nics/features/ark.ini
+++ b/doc/guides/nics/features/ark.ini
@@ -7,8 +7,6 @@
 Speed capabilities   = Y
 Queue start/stop     = Y
 Scattered Rx         = Y
-Basic stats          = Y
 Stats per queue      = Y
 Linux                = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/atlantic.ini b/doc/guides/nics/features/atlantic.ini
index 29969c1493..948f75cdf7 100644
--- a/doc/guides/nics/features/atlantic.ini
+++ b/doc/guides/nics/features/atlantic.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Queue start/stop     = Y
 MTU update           = Y
@@ -24,9 +23,7 @@ MACsec offload       = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
diff --git a/doc/guides/nics/features/avp.ini b/doc/guides/nics/features/avp.ini
index f2f115ba61..0382796ee0 100644
--- a/doc/guides/nics/features/avp.ini
+++ b/doc/guides/nics/features/avp.ini
@@ -4,12 +4,10 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Scattered Rx         = Y
 Promiscuous mode     = Y
 Unicast MAC filter   = Y
 VLAN offload         = Y
-Basic stats          = Y
 Stats per queue      = Y
 Linux                = Y
 x86-64               = Y
diff --git a/doc/guides/nics/features/axgbe.ini b/doc/guides/nics/features/axgbe.ini
index ce4a5075f4..e2178be2d5 100644
--- a/doc/guides/nics/features/axgbe.ini
+++ b/doc/guides/nics/features/axgbe.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Scattered Rx         = Y
 TSO                  = Y
 Promiscuous mode     = Y
@@ -17,7 +16,6 @@ VLAN filter          = Y
 CRC offload          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Basic stats          = Y
 FW version           = Y
 Multiprocess aware   = Y
 Linux                = Y
diff --git a/doc/guides/nics/features/bnx2x.ini b/doc/guides/nics/features/bnx2x.ini
index 979bace466..f498d92e81 100644
--- a/doc/guides/nics/features/bnx2x.ini
+++ b/doc/guides/nics/features/bnx2x.ini
@@ -5,14 +5,11 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Link status event    = Y
 Promiscuous mode     = Y
 Unicast MAC filter   = Y
 Multicast MAC filter = Y
 SR-IOV               = Y
-Basic stats          = Y
 Extended stats       = Y
 Linux                = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/bnxt.ini b/doc/guides/nics/features/bnxt.ini
index f632de135a..e9e8138070 100644
--- a/doc/guides/nics/features/bnxt.ini
+++ b/doc/guides/nics/features/bnxt.ini
@@ -6,13 +6,11 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Fast mbuf free       = Y
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Burst mode info      = Y
 MTU update           = Y
 Scattered Rx         = Y
@@ -38,9 +36,7 @@ Inner L4 checksum    = Y
 Packet type parsing  = Y
 Timesync             = Y
 VLAN offload         = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
@@ -53,8 +49,6 @@ Linux                = Y
 ARMv8                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
-Perf doc             = Y
 
 [rte_flow items]
 any                  = Y
diff --git a/doc/guides/nics/features/cnxk.ini b/doc/guides/nics/features/cnxk.ini
index dc75947d86..e0d86dfb8c 100644
--- a/doc/guides/nics/features/cnxk.ini
+++ b/doc/guides/nics/features/cnxk.ini
@@ -9,10 +9,8 @@ Rx interrupt         = Y
 Lock-free Tx queue   = Y
 SR-IOV               = Y
 Multiprocess aware   = Y
-Link status          = Y
 Link status event    = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Burst mode info      = Y
 Fast mbuf free       = Y
 Free Tx mbuf on demand = Y
@@ -40,10 +38,8 @@ Inner L4 checksum    = Y
 Packet type parsing  = Y
 Timesync             = Y
 Timestamp offload    = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
+Descriptor status    = Y
 Tx queue count       = Y
-Basic stats          = Y
 Stats per queue      = Y
 Extended stats       = Y
 FW version           = Y
@@ -51,7 +47,6 @@ Module EEPROM dump   = Y
 Registers dump       = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
 
 [rte_flow items]
 any                  = Y
diff --git a/doc/guides/nics/features/cnxk_vec.ini b/doc/guides/nics/features/cnxk_vec.ini
index 92a486664f..c90b6b8d21 100644
--- a/doc/guides/nics/features/cnxk_vec.ini
+++ b/doc/guides/nics/features/cnxk_vec.ini
@@ -9,10 +9,8 @@ Rx interrupt         = Y
 Lock-free Tx queue   = Y
 SR-IOV               = Y
 Multiprocess aware   = Y
-Link status          = Y
 Link status event    = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Burst mode info      = Y
 Fast mbuf free       = Y
 Free Tx mbuf on demand = Y
@@ -33,9 +31,7 @@ L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Stats per queue      = Y
 Extended stats       = Y
 FW version           = Y
@@ -43,7 +39,6 @@ Module EEPROM dump   = Y
 Registers dump       = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
 
 [rte_flow items]
 any                  = Y
diff --git a/doc/guides/nics/features/cnxk_vf.ini b/doc/guides/nics/features/cnxk_vf.ini
index a55f0e7ce5..98e21e14ce 100644
--- a/doc/guides/nics/features/cnxk_vf.ini
+++ b/doc/guides/nics/features/cnxk_vf.ini
@@ -8,10 +8,8 @@ Speed capabilities   = Y
 Rx interrupt         = Y
 Lock-free Tx queue   = Y
 Multiprocess aware   = Y
-Link status          = Y
 Link status event    = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Burst mode info      = Y
 Fast mbuf free       = Y
 Free Tx mbuf on demand = Y
@@ -29,9 +27,7 @@ L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Stats per queue      = Y
 Extended stats       = Y
 FW version           = Y
@@ -39,7 +35,6 @@ Module EEPROM dump   = Y
 Registers dump       = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
 
 [rte_flow items]
 any                  = Y
diff --git a/doc/guides/nics/features/cpfl.ini b/doc/guides/nics/features/cpfl.ini
index 4eadaca6e7..6aa4a8a7ef 100644
--- a/doc/guides/nics/features/cpfl.ini
+++ b/doc/guides/nics/features/cpfl.ini
@@ -8,7 +8,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Queue start/stop     = Y
 MTU update           = Y
 Scattered Rx         = P
@@ -20,7 +19,6 @@ L3 checksum offload  = P
 L4 checksum offload  = P
 Timestamp offload    = P
 Packet type parsing  = Y
-Basic stats          = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
diff --git a/doc/guides/nics/features/cxgbe.ini b/doc/guides/nics/features/cxgbe.ini
index 0d67ca8720..ec4269d259 100644
--- a/doc/guides/nics/features/cxgbe.ini
+++ b/doc/guides/nics/features/cxgbe.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Queue start/stop     = Y
 MTU update           = Y
 Scattered Rx         = Y
@@ -22,7 +21,6 @@ FEC                  = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
@@ -33,7 +31,6 @@ FreeBSD              = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
 
 [rte_flow items]
 eth                  = P
diff --git a/doc/guides/nics/features/cxgbevf.ini b/doc/guides/nics/features/cxgbevf.ini
index a34fddd64e..a921cda6b1 100644
--- a/doc/guides/nics/features/cxgbevf.ini
+++ b/doc/guides/nics/features/cxgbevf.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Queue start/stop     = Y
 MTU update           = Y
 Scattered Rx         = Y
@@ -18,7 +17,6 @@ VLAN offload         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
@@ -26,4 +24,3 @@ Multiprocess aware   = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/default.ini b/doc/guides/nics/features/default.ini
index 8303a530c1..393e115914 100644
--- a/doc/guides/nics/features/default.ini
+++ b/doc/guides/nics/features/default.ini
@@ -9,7 +9,6 @@
 [Features]
 Speed capabilities   =
 Link speed configuration =
-Link status          =
 Link status event    =
 Removal event        =
 Queue status event   =
@@ -18,8 +17,7 @@ Lock-free Tx queue   =
 Fast mbuf free       =
 Free Tx mbuf on demand =
 Queue start/stop     =
-Runtime Rx queue setup =
-Runtime Tx queue setup =
+Runtime queue setup  =
 Shared Rx queue      =
 Burst mode info      =
 Power mgmt address monitor =
@@ -60,10 +58,8 @@ Inner L3 checksum    =
 Inner L4 checksum    =
 Packet type parsing  =
 Timesync             =
-Rx descriptor status =
-Tx descriptor status =
+Descriptor status    =
 Tx queue count       =
-Basic stats          =
 Extended stats       =
 Stats per queue      =
 FW version           =
@@ -82,9 +78,6 @@ Power8               =
 rv64                 =
 x86-32               =
 x86-64               =
-Usage doc            =
-Design doc           =
-Perf doc             =
 
 [rte_flow items]
 aggr_affinity        =
diff --git a/doc/guides/nics/features/dpaa.ini b/doc/guides/nics/features/dpaa.ini
index 4f31b61de1..cb9353caaf 100644
--- a/doc/guides/nics/features/dpaa.ini
+++ b/doc/guides/nics/features/dpaa.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Burst mode info      = Y
 MTU update           = Y
@@ -21,8 +20,6 @@ L4 checksum offload  = Y
 Packet type parsing  = Y
 Timesync             = Y
 Timestamp offload    = Y
-Basic stats          = Y
 Extended stats       = Y
 FW version           = Y
 ARMv8                = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/dpaa2.ini b/doc/guides/nics/features/dpaa2.ini
index 4788afef8d..622e6df971 100644
--- a/doc/guides/nics/features/dpaa2.ini
+++ b/doc/guides/nics/features/dpaa2.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Link status event    = Y
 Burst mode info      = Y
 Rx interrupt         = Y
@@ -26,12 +25,10 @@ L4 checksum offload  = Y
 Packet type parsing  = Y
 Timesync             = Y
 Timestamp offload    = Y
-Basic stats          = Y
 Extended stats       = Y
 FW version           = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
 
 [rte_flow items]
 ah                   = Y
diff --git a/doc/guides/nics/features/e1000.ini b/doc/guides/nics/features/e1000.ini
index a9cbed1c3c..71439551f0 100644
--- a/doc/guides/nics/features/e1000.ini
+++ b/doc/guides/nics/features/e1000.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Free Tx mbuf on demand = Y
@@ -21,9 +20,7 @@ VLAN offload         = Y
 QinQ offload         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 FreeBSD              = Y
 Linux                = Y
 Windows              = Y
diff --git a/doc/guides/nics/features/ena.ini b/doc/guides/nics/features/ena.ini
index 1fe7a71e3d..037e0bad60 100644
--- a/doc/guides/nics/features/ena.ini
+++ b/doc/guides/nics/features/ena.ini
@@ -4,7 +4,6 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Fast mbuf free       = Y
@@ -17,12 +16,9 @@ RSS key update       = Y
 RSS reta update      = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Basic stats          = Y
 Extended stats       = Y
 Multiprocess aware   = Y
 Linux                = Y
 ARMv8                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
-Design doc           = Y
diff --git a/doc/guides/nics/features/enetc.ini b/doc/guides/nics/features/enetc.ini
index c197e280bf..f5e8322e67 100644
--- a/doc/guides/nics/features/enetc.ini
+++ b/doc/guides/nics/features/enetc.ini
@@ -5,8 +5,6 @@
 ;
 [Features]
 Packet type parsing  = Y
-Link status          = Y
-Basic stats          = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 MTU update           = Y
@@ -16,4 +14,3 @@ L3 checksum offload  = P
 L4 checksum offload  = P
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index a427c68344..9a84a4fced 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -6,7 +6,6 @@
 [Features]
 Link status event    = Y
 Speed capabilities   = Y
-Link status          = Y
 LRO                  = Y
 TSO                  = Y
 Promiscuous mode     = Y
@@ -15,7 +14,6 @@ Unicast MAC filter   = Y
 VLAN filter          = Y
 RSS hash             = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Registers dump       = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
@@ -24,4 +22,3 @@ Queue start/stop     = Y
 Scattered Rx         = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/enetc4_vf.ini b/doc/guides/nics/features/enetc4_vf.ini
index 4ef2b9b9ba..0d7fa57e87 100644
--- a/doc/guides/nics/features/enetc4_vf.ini
+++ b/doc/guides/nics/features/enetc4_vf.ini
@@ -7,7 +7,6 @@
 Link status event    = Y
 Rx interrupt         = Y
 Speed capabilities   = Y
-Link status          = Y
 LRO                  = Y
 TSO                  = Y
 Promiscuous mode     = Y
@@ -15,7 +14,6 @@ Allmulticast mode    = Y
 VLAN filter          = Y
 RSS hash             = Y
 Packet type parsing  = Y
-Basic stats          = Y
 FW version           = Y
 Registers dump       = Y
 L3 checksum offload  = Y
@@ -25,4 +23,3 @@ Queue start/stop     = Y
 Scattered Rx         = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/enetfec.ini b/doc/guides/nics/features/enetfec.ini
index 2a34351b43..3c0e61cefc 100644
--- a/doc/guides/nics/features/enetfec.ini
+++ b/doc/guides/nics/features/enetfec.ini
@@ -8,7 +8,5 @@ Promiscuous mode     = Y
 VLAN offload	     = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Basic stats	     = Y
 Linux		     = Y
 ARMv8		     = Y
-Usage doc	     = Y
diff --git a/doc/guides/nics/features/enic.ini b/doc/guides/nics/features/enic.ini
index 6dbea9f36e..e9030d529b 100644
--- a/doc/guides/nics/features/enic.ini
+++ b/doc/guides/nics/features/enic.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
@@ -29,14 +28,12 @@ L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Basic stats          = Y
 FW version           = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
 
 [rte_flow items]
 ecpri                = Y
diff --git a/doc/guides/nics/features/failsafe.ini b/doc/guides/nics/features/failsafe.ini
index 00dcd0e03b..c7c696fbbd 100644
--- a/doc/guides/nics/features/failsafe.ini
+++ b/doc/guides/nics/features/failsafe.ini
@@ -4,13 +4,11 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Fast mbuf free       = Y
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
@@ -19,11 +17,9 @@ Multicast MAC filter = Y
 VLAN filter          = Y
 Flow control         = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Stats per queue      = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/fm10k.ini b/doc/guides/nics/features/fm10k.ini
index e2701d2d47..32e3f90c93 100644
--- a/doc/guides/nics/features/fm10k.ini
+++ b/doc/guides/nics/features/fm10k.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
@@ -25,9 +24,7 @@ VLAN offload         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 Multiprocess aware   = Y
diff --git a/doc/guides/nics/features/fm10k_vf.ini b/doc/guides/nics/features/fm10k_vf.ini
index ba8bc861b1..1620c4ac54 100644
--- a/doc/guides/nics/features/fm10k_vf.ini
+++ b/doc/guides/nics/features/fm10k_vf.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
@@ -19,7 +18,6 @@ VLAN offload         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 Multiprocess aware   = Y
diff --git a/doc/guides/nics/features/gve.ini b/doc/guides/nics/features/gve.ini
index 117ad4fc65..9f3835edf6 100644
--- a/doc/guides/nics/features/gve.ini
+++ b/doc/guides/nics/features/gve.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Queue start/stop     = Y
 MTU update           = Y
 TSO                  = Y
@@ -14,12 +13,10 @@ RSS key update       = Y
 RSS reta update      = Y
 L4 checksum offload  = Y
 Timestamp offload    = Y
-Basic stats          = Y
 FreeBSD              = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
 
 [rte_flow items]
 ah                   = Y
diff --git a/doc/guides/nics/features/hinic.ini b/doc/guides/nics/features/hinic.ini
index ada6607fe9..ae478d7cd8 100644
--- a/doc/guides/nics/features/hinic.ini
+++ b/doc/guides/nics/features/hinic.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Link status event    = Y
 Queue start/stop     = Y
 MTU update           = Y
@@ -28,7 +27,6 @@ L3 checksum offload  = Y
 L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 Flow control         = Y
diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
index 74fea318ee..6cdd240a82 100644
--- a/doc/guides/nics/features/hinic3.ini
+++ b/doc/guides/nics/features/hinic3.ini
@@ -6,11 +6,9 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 MTU update           = Y
 Scattered Rx         = Y
 TSO                  = Y
@@ -33,7 +31,6 @@ L4 checksum offload  = Y
 Inner L3 checksum    = P
 Inner L4 checksum    = P
 Packet type parsing  = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
diff --git a/doc/guides/nics/features/hns3.ini b/doc/guides/nics/features/hns3.ini
index 5326d20e72..65b6e3076b 100644
--- a/doc/guides/nics/features/hns3.ini
+++ b/doc/guides/nics/features/hns3.ini
@@ -6,12 +6,10 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Burst mode info      = Y
 Fast mbuf free       = Y
 Free Tx mbuf on demand = Y
@@ -38,9 +36,7 @@ L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
diff --git a/doc/guides/nics/features/hns3_vf.ini b/doc/guides/nics/features/hns3_vf.ini
index 8ef771d04a..7281156789 100644
--- a/doc/guides/nics/features/hns3_vf.ini
+++ b/doc/guides/nics/features/hns3_vf.ini
@@ -4,12 +4,10 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Burst mode info      = Y
 Free Tx mbuf on demand = Y
 MTU update           = Y
@@ -31,9 +29,7 @@ L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Tx descriptor status = Y
-Rx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 Registers dump       = Y
diff --git a/doc/guides/nics/features/i40e.ini b/doc/guides/nics/features/i40e.ini
index fb00b69830..bb8f95ad9c 100644
--- a/doc/guides/nics/features/i40e.ini
+++ b/doc/guides/nics/features/i40e.ini
@@ -6,13 +6,11 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Fast mbuf free       = P
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Burst mode info      = Y
 Power mgmt address monitor = Y
 Scattered Rx         = Y
@@ -39,9 +37,7 @@ Inner L3 checksum    = P
 Inner L4 checksum    = P
 Packet type parsing  = Y
 Timesync             = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 FW version           = Y
 Module EEPROM dump   = Y
diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index e324a7aecb..4d95e2a0fc 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -7,12 +7,10 @@
 ; is selected.
 ;
 [Features]
-Link status          = Y
 Rx interrupt         = Y
 Free Tx mbuf on demand = Y
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Burst mode info      = Y
 Power mgmt address monitor = Y
 MTU update           = Y
@@ -37,9 +35,7 @@ Timestamp offload    = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = P
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 893d09e9ec..7b4e60285e 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -9,7 +9,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 FEC                  = Y
 Rx interrupt         = Y
@@ -41,9 +40,7 @@ Inner L3 checksum    = P
 Inner L4 checksum    = P
 Packet type parsing  = Y
 Timesync             = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 FW version           = Y
 Module EEPROM dump   = Y
diff --git a/doc/guides/nics/features/ice_dcf.ini b/doc/guides/nics/features/ice_dcf.ini
index 0e86338990..9ce5918be3 100644
--- a/doc/guides/nics/features/ice_dcf.ini
+++ b/doc/guides/nics/features/ice_dcf.ini
@@ -25,7 +25,6 @@ VLAN filter          = Y
 Traffic manager      = Y
 VLAN offload         = Y
 Extended stats       = Y
-Basic stats          = Y
 Power mgmt address monitor = Y
 Linux                = Y
 x86-32               = Y
diff --git a/doc/guides/nics/features/idpf.ini b/doc/guides/nics/features/idpf.ini
index f546648924..af64de5fd7 100644
--- a/doc/guides/nics/features/idpf.ini
+++ b/doc/guides/nics/features/idpf.ini
@@ -8,7 +8,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Queue start/stop     = Y
 MTU update           = Y
 Scattered Rx         = P
@@ -21,7 +20,6 @@ L4 checksum offload  = P
 Timestamp offload    = P
 Timesync             = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
diff --git a/doc/guides/nics/features/igb.ini b/doc/guides/nics/features/igb.ini
index ee2408f3ee..4ee500e114 100644
--- a/doc/guides/nics/features/igb.ini
+++ b/doc/guides/nics/features/igb.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = P
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 MTU update           = Y
@@ -31,9 +30,7 @@ L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
 Timesync             = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 FW version           = Y
 EEPROM dump          = Y
diff --git a/doc/guides/nics/features/igb_vf.ini b/doc/guides/nics/features/igb_vf.ini
index 07698f7660..cdcd8d3de6 100644
--- a/doc/guides/nics/features/igb_vf.ini
+++ b/doc/guides/nics/features/igb_vf.ini
@@ -4,7 +4,6 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Rx interrupt         = Y
 Scattered Rx         = Y
 TSO                  = Y
@@ -18,9 +17,7 @@ QinQ offload         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Registers dump       = Y
 FreeBSD              = Y
diff --git a/doc/guides/nics/features/igc.ini b/doc/guides/nics/features/igc.ini
index d6db18c1e8..c19818a2b9 100644
--- a/doc/guides/nics/features/igc.ini
+++ b/doc/guides/nics/features/igc.ini
@@ -5,13 +5,11 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 FW version           = Y
 LED                  = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
+Descriptor status    = Y
 MTU update           = Y
 Scattered Rx         = Y
 TSO                  = Y
@@ -24,7 +22,6 @@ CRC offload          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Timesync             = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 Rx interrupt         = Y
diff --git a/doc/guides/nics/features/ionic.ini b/doc/guides/nics/features/ionic.ini
index 64b2316288..1ea3e39910 100644
--- a/doc/guides/nics/features/ionic.ini
+++ b/doc/guides/nics/features/ionic.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Fast mbuf free       = Y
 Queue start/stop     = Y
@@ -28,12 +27,9 @@ CRC offload          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
 Linux                = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/ipn3ke.ini b/doc/guides/nics/features/ipn3ke.ini
index e412978820..29f40a5b11 100644
--- a/doc/guides/nics/features/ipn3ke.ini
+++ b/doc/guides/nics/features/ipn3ke.ini
@@ -5,12 +5,10 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 Scattered Rx         = Y
 TSO                  = Y
 Promiscuous mode     = Y
@@ -35,9 +33,7 @@ Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
 Timesync             = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 FW version           = Y
 Module EEPROM dump   = Y
diff --git a/doc/guides/nics/features/ixgbe.ini b/doc/guides/nics/features/ixgbe.ini
index cb9331dbcd..1c8dd2ba33 100644
--- a/doc/guides/nics/features/ixgbe.ini
+++ b/doc/guides/nics/features/ixgbe.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
@@ -40,9 +39,7 @@ Inner L3 checksum    = P
 Inner L4 checksum    = P
 Packet type parsing  = Y
 Timesync             = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
diff --git a/doc/guides/nics/features/ixgbe_vf.ini b/doc/guides/nics/features/ixgbe_vf.ini
index 299ccd4b61..ecd499cfc1 100644
--- a/doc/guides/nics/features/ixgbe_vf.ini
+++ b/doc/guides/nics/features/ixgbe_vf.ini
@@ -4,7 +4,6 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Rx interrupt         = Y
 Power mgmt address monitor = Y
 MTU update           = Y
@@ -27,9 +26,7 @@ L4 checksum offload  = P
 Inner L3 checksum    = P
 Inner L4 checksum    = P
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Registers dump       = Y
 FreeBSD              = Y
diff --git a/doc/guides/nics/features/mana.ini b/doc/guides/nics/features/mana.ini
index db555ffe27..c7c8215aab 100644
--- a/doc/guides/nics/features/mana.ini
+++ b/doc/guides/nics/features/mana.ini
@@ -5,15 +5,12 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = P
 Removal event        = Y
 Rx interrupt         = Y
 RSS hash             = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Basic stats          = Y
 MTU update           = Y
 Multiprocess aware   = Y
 Linux                = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/memif.ini b/doc/guides/nics/features/memif.ini
index 0368b7a02c..0b273e98ae 100644
--- a/doc/guides/nics/features/memif.ini
+++ b/doc/guides/nics/features/memif.ini
@@ -4,10 +4,7 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
-Basic stats          = Y
 ARMv8                = Y
 Power8               = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/mlx4.ini b/doc/guides/nics/features/mlx4.ini
index 03f59a5f8b..d7b3900ce1 100644
--- a/doc/guides/nics/features/mlx4.ini
+++ b/doc/guides/nics/features/mlx4.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Link status event    = Y
 Removal event        = Y
 Rx interrupt         = Y
@@ -27,7 +26,6 @@ L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Stats per queue      = Y
 FW version           = Y
 Multiprocess aware   = Y
@@ -35,7 +33,6 @@ Linux                = Y
 Power8               = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
 
 [rte_flow items]
 eth                  = P
diff --git a/doc/guides/nics/features/mlx5.ini b/doc/guides/nics/features/mlx5.ini
index ae8c83057b..2b9dd2edd8 100644
--- a/doc/guides/nics/features/mlx5.ini
+++ b/doc/guides/nics/features/mlx5.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Link status event    = Y
 Removal event        = Y
 Rx interrupt         = Y
@@ -40,9 +39,7 @@ Timestamp offload    = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
@@ -54,8 +51,6 @@ ARMv8                = Y
 Power8               = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
-Design doc           = Y
 
 [rte_flow items]
 aggr_affinity        = Y
diff --git a/doc/guides/nics/features/mvneta.ini b/doc/guides/nics/features/mvneta.ini
index 446987e1b5..0214f18d1c 100644
--- a/doc/guides/nics/features/mvneta.ini
+++ b/doc/guides/nics/features/mvneta.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Unicast MAC filter   = Y
@@ -13,6 +12,4 @@ CRC offload          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 ARMv8                = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/mvpp2.ini b/doc/guides/nics/features/mvpp2.ini
index ccc2c2d4f8..d8b890a6f3 100644
--- a/doc/guides/nics/features/mvpp2.ini
+++ b/doc/guides/nics/features/mvpp2.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
@@ -19,10 +18,8 @@ CRC offload          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Extended stats       = Y
 ARMv8                = Y
-Usage doc            = Y
 
 [rte_flow items]
 eth                  = P
diff --git a/doc/guides/nics/features/nbl.ini b/doc/guides/nics/features/nbl.ini
index 3c49077dd9..5935092a49 100644
--- a/doc/guides/nics/features/nbl.ini
+++ b/doc/guides/nics/features/nbl.ini
@@ -10,7 +10,6 @@ Scattered Rx         = Y
 Promiscuous mode     = Y
 Unicast MAC filter   = Y
 VLAN offload         = P
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 Linux                = Y
diff --git a/doc/guides/nics/features/netvsc.ini b/doc/guides/nics/features/netvsc.ini
index 32df77a03e..fa8c2ac132 100644
--- a/doc/guides/nics/features/netvsc.ini
+++ b/doc/guides/nics/features/netvsc.ini
@@ -5,12 +5,10 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Free Tx mbuf on demand = Y
 Scattered Rx         = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
-Basic stats          = Y
 Stats per queue      = Y
 Extended stats       = Y
 Multiprocess aware   = Y
@@ -19,5 +17,4 @@ ARMv7                = Y
 ARMv8                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
 MTU update           = Y
diff --git a/doc/guides/nics/features/nfb.ini b/doc/guides/nics/features/nfb.ini
index 7ac89fc15f..cad780b8ba 100644
--- a/doc/guides/nics/features/nfb.ini
+++ b/doc/guides/nics/features/nfb.ini
@@ -5,17 +5,14 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
 Timestamp offload    = P
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
 Multiprocess aware   = Y
 Linux                = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/nfp.ini b/doc/guides/nics/features/nfp.ini
index 124663ae00..38b0110fa0 100644
--- a/doc/guides/nics/features/nfp.ini
+++ b/doc/guides/nics/features/nfp.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
@@ -23,7 +22,6 @@ FEC                  = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Stats per queue      = Y
 EEPROM dump          = Y
 Module EEPROM dump   = Y
@@ -31,7 +29,6 @@ LED                  = Y
 Linux                = Y
 Multiprocess aware   = Y
 x86-64               = Y
-Usage doc            = Y
 
 [rte_flow items]
 conntrack            = Y
diff --git a/doc/guides/nics/features/ngbe.ini b/doc/guides/nics/features/ngbe.ini
index 7b1f12bf95..1de30c5de8 100644
--- a/doc/guides/nics/features/ngbe.ini
+++ b/doc/guides/nics/features/ngbe.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Free Tx mbuf on demand = Y
@@ -34,9 +33,7 @@ Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
 Timesync             = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
diff --git a/doc/guides/nics/features/ngbe_vf.ini b/doc/guides/nics/features/ngbe_vf.ini
index 5207d56dbf..7b2ea5d32a 100644
--- a/doc/guides/nics/features/ngbe_vf.ini
+++ b/doc/guides/nics/features/ngbe_vf.ini
@@ -4,7 +4,6 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Unicast MAC filter   = Y
 Multicast MAC filter = Y
 Rx interrupt         = Y
@@ -24,10 +23,8 @@ L4 checksum offload  = P
 Inner L3 checksum    = P
 Inner L4 checksum    = P
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
+Descriptor status    = Y
 Free Tx mbuf on demand = Y
-Basic stats          = Y
 Extended stats       = Y
 Registers dump       = Y
 Multiprocess aware   = Y
diff --git a/doc/guides/nics/features/ntnic.ini b/doc/guides/nics/features/ntnic.ini
index a5aadf33ee..5ebbd8a79b 100644
--- a/doc/guides/nics/features/ntnic.ini
+++ b/doc/guides/nics/features/ntnic.ini
@@ -6,13 +6,11 @@
 [Features]
 FW version           = Y
 Speed capabilities   = Y
-Link status          = Y
 Queue start/stop     = Y
 Unicast MAC filter   = Y
 Multicast MAC filter = Y
 RSS hash             = Y
 RSS key update       = Y
-Basic stats          = Y
 Extended stats       = Y
 MTU update           = Y
 Linux                = Y
diff --git a/doc/guides/nics/features/octeon_ep.ini b/doc/guides/nics/features/octeon_ep.ini
index d52491afa3..2c1c65a94d 100644
--- a/doc/guides/nics/features/octeon_ep.ini
+++ b/doc/guides/nics/features/octeon_ep.ini
@@ -8,8 +8,5 @@ Speed capabilities   = P
 SR-IOV               = Y
 Linux                = Y
 x86-64               = Y
-Basic stats          = Y
-Link status          = Y
 MTU update           = Y
 Multiprocess aware   = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/octeontx.ini b/doc/guides/nics/features/octeontx.ini
index 46ae8318a9..97ff2f5cae 100644
--- a/doc/guides/nics/features/octeontx.ini
+++ b/doc/guides/nics/features/octeontx.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Lock-free Tx queue   = Y
 Queue start/stop     = P
@@ -24,8 +23,6 @@ Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
 Flow control         = Y
-Basic stats          = Y
 Extended stats       = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 38dd298603..8dddf76321 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,11 +4,9 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Link status event    = Y
 Queue start/stop     = Y
 Timestamp offload    = P
-Basic stats          = Y
 Stats per queue      = Y
 VLAN offload         = Y
 Multiprocess aware   = Y
@@ -20,4 +18,3 @@ ARMv8                = Y
 Power8               = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/pfe.ini b/doc/guides/nics/features/pfe.ini
index a360dd40e0..d76895da3a 100644
--- a/doc/guides/nics/features/pfe.ini
+++ b/doc/guides/nics/features/pfe.ini
@@ -4,14 +4,11 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/qede.ini b/doc/guides/nics/features/qede.ini
index e6fe2d4aeb..6df2590c55 100644
--- a/doc/guides/nics/features/qede.ini
+++ b/doc/guides/nics/features/qede.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 MTU update           = Y
 Scattered Rx         = Y
 LRO                  = Y
@@ -26,7 +25,6 @@ L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 Registers dump       = Y
@@ -36,7 +34,6 @@ Linux                = Y
 ARMv8                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
 
 [rte_flow items]
 ipv4                 = Y
diff --git a/doc/guides/nics/features/qede_vf.ini b/doc/guides/nics/features/qede_vf.ini
index 6cf146341f..8e06a15f32 100644
--- a/doc/guides/nics/features/qede_vf.ini
+++ b/doc/guides/nics/features/qede_vf.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 MTU update           = Y
 Scattered Rx         = Y
 Promiscuous mode     = Y
@@ -23,7 +22,6 @@ VLAN offload         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 Multiprocess aware   = Y
@@ -33,4 +31,3 @@ x86-32               = Y
 x86-64               = Y
 LRO                  = Y
 TSO                  = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/r8169.ini b/doc/guides/nics/features/r8169.ini
index 3660b5c86e..acdb5176da 100644
--- a/doc/guides/nics/features/r8169.ini
+++ b/doc/guides/nics/features/r8169.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 MTU update           = Y
 Scattered Rx         = Y
@@ -19,7 +18,6 @@ RSS reta update      = Y
 Flow control         = Y
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Basic stats          = Y
 FW version           = Y
 Linux                = Y
 x86-32               = Y
diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 801a8de711..db47f552f4 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -5,14 +5,12 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Link status event    = Y
 Packet type parsing  = Y
 L3 checksum offload  = P
 L4 checksum offload  = P
 Inner L3 checksum    = P
 Inner L4 checksum    = P
-Basic stats          = Y
 Stats per queue      = Y
 Extended stats       = Y
 Queue start/stop     = Y
diff --git a/doc/guides/nics/features/sfc.ini b/doc/guides/nics/features/sfc.ini
index f9654e69ed..6068486cc0 100644
--- a/doc/guides/nics/features/sfc.ini
+++ b/doc/guides/nics/features/sfc.ini
@@ -6,13 +6,11 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Fast mbuf free       = Y
 Queue start/stop     = Y
-Runtime Rx queue setup = Y
-Runtime Tx queue setup = Y
+Runtime queue setup  = Y
 MTU update           = Y
 Scattered Rx         = Y
 TSO                  = Y
@@ -32,9 +30,7 @@ L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 FW version           = Y
 Multiprocess aware   = Y
diff --git a/doc/guides/nics/features/sxe2.ini b/doc/guides/nics/features/sxe2.ini
index 3c1e6a8a39..69df286fd7 100644
--- a/doc/guides/nics/features/sxe2.ini
+++ b/doc/guides/nics/features/sxe2.ini
@@ -8,7 +8,6 @@
 ;
 [Features]
 Speed capabilities   = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Fast mbuf free       = P
@@ -27,8 +26,7 @@ L4 checksum offload  = Y
 Timestamp offload    = P
 Inner L3 checksum    = P
 Inner L4 checksum    = P
-Rx descriptor status = Y
-Tx descriptor status = Y
+Descriptor status    = Y
 MTU update           = Y
 TSO                  = P
 Promiscuous mode     = Y
@@ -41,7 +39,6 @@ VLAN filter          = Y
 Inline crypto        = Y
 Packet type parsing  = Y
 Timesync             = Y
-Basic stats          = Y
 Extended stats       = Y
 FW version           = Y
 Module EEPROM dump   = Y
diff --git a/doc/guides/nics/features/tap.ini b/doc/guides/nics/features/tap.ini
index fd04e3bbd6..b30e0c6b72 100644
--- a/doc/guides/nics/features/tap.ini
+++ b/doc/guides/nics/features/tap.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
@@ -20,7 +19,6 @@ Flow control         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Multiprocess aware   = Y
 Linux                = Y
 ARMv7                = Y
@@ -28,7 +26,6 @@ ARMv8                = Y
 Power8               = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
 
 [rte_flow items]
 eth                  = P
diff --git a/doc/guides/nics/features/thunderx.ini b/doc/guides/nics/features/thunderx.ini
index 2ab8db7239..9c004013a3 100644
--- a/doc/guides/nics/features/thunderx.ini
+++ b/doc/guides/nics/features/thunderx.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Queue start/stop     = Y
 MTU update           = Y
@@ -22,10 +21,8 @@ VLAN offload         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Stats per queue      = Y
 Registers dump       = Y
 Multiprocess aware   = Y
 Linux                = Y
 ARMv8                = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/txgbe.ini b/doc/guides/nics/features/txgbe.ini
index a9f043a04f..bb780f5304 100644
--- a/doc/guides/nics/features/txgbe.ini
+++ b/doc/guides/nics/features/txgbe.ini
@@ -6,7 +6,6 @@
 [Features]
 Speed capabilities   = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Queue start/stop     = Y
@@ -38,9 +37,7 @@ Inner L3 checksum    = P
 Inner L4 checksum    = P
 Packet type parsing  = Y
 Timesync             = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
-Basic stats          = Y
+Descriptor status    = Y
 Extended stats       = Y
 Stats per queue      = Y
 FW version           = Y
diff --git a/doc/guides/nics/features/txgbe_vf.ini b/doc/guides/nics/features/txgbe_vf.ini
index d071717f09..696acc8fc5 100644
--- a/doc/guides/nics/features/txgbe_vf.ini
+++ b/doc/guides/nics/features/txgbe_vf.ini
@@ -4,7 +4,6 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Unicast MAC filter   = Y
 Multicast MAC filter = Y
 Rx interrupt         = Y
@@ -27,10 +26,8 @@ L4 checksum offload  = P
 Inner L3 checksum    = P
 Inner L4 checksum    = P
 Packet type parsing  = Y
-Rx descriptor status = Y
-Tx descriptor status = Y
+Descriptor status    = Y
 Free Tx mbuf on demand = Y
-Basic stats          = Y
 Extended stats       = Y
 Registers dump       = Y
 Multiprocess aware   = Y
diff --git a/doc/guides/nics/features/vhost.ini b/doc/guides/nics/features/vhost.ini
index 15f4dfe5e8..1ec8c6c7bf 100644
--- a/doc/guides/nics/features/vhost.ini
+++ b/doc/guides/nics/features/vhost.ini
@@ -4,11 +4,9 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Free Tx mbuf on demand = Y
 Queue status event   = Y
 L4 checksum offload  = P
-Basic stats          = Y
 Extended stats       = Y
 x86-32               = Y
 x86-64               = Y
diff --git a/doc/guides/nics/features/virtio.ini b/doc/guides/nics/features/virtio.ini
index f0a1a564f9..90e9a34fa2 100644
--- a/doc/guides/nics/features/virtio.ini
+++ b/doc/guides/nics/features/virtio.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Link status event    = Y
 Rx interrupt         = Y
 Scattered Rx         = P
@@ -17,7 +16,6 @@ RSS hash             = P
 RSS key update       = Y
 RSS reta update      = Y
 VLAN filter          = Y
-Basic stats          = Y
 Stats per queue      = Y
 Extended stats       = P
 Multiprocess aware   = Y
@@ -27,5 +25,4 @@ ARMv7                = Y
 ARMv8                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
 MTU update           = Y
diff --git a/doc/guides/nics/features/vmxnet3.ini b/doc/guides/nics/features/vmxnet3.ini
index 749887d642..54f98b9d6d 100644
--- a/doc/guides/nics/features/vmxnet3.ini
+++ b/doc/guides/nics/features/vmxnet3.ini
@@ -5,7 +5,6 @@
 ;
 [Features]
 Speed capabilities   = P
-Link status          = Y
 Link status event    = Y
 MTU update           = Y
 LRO                  = Y
@@ -18,10 +17,8 @@ VLAN filter          = Y
 VLAN offload         = Y
 L4 checksum offload  = Y
 Packet type parsing  = Y
-Basic stats          = Y
 Extended stats       = Y
 Stats per queue      = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
-Usage doc            = Y
diff --git a/doc/guides/nics/features/xsc.ini b/doc/guides/nics/features/xsc.ini
index c6243c18df..4ad1857c64 100644
--- a/doc/guides/nics/features/xsc.ini
+++ b/doc/guides/nics/features/xsc.ini
@@ -4,7 +4,6 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
-Link status          = Y
 Link status event    = Y
 MTU update           = Y
 TSO                  = Y
@@ -17,7 +16,6 @@ L3 checksum offload  = Y
 L4 checksum offload  = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
-Basic stats          = Y
 Stats per queue      = Y
 FW version           = Y
 Module EEPROM dump   = Y
diff --git a/doc/guides/nics/features/zxdh.ini b/doc/guides/nics/features/zxdh.ini
index a721f7051e..d7f58aeb04 100644
--- a/doc/guides/nics/features/zxdh.ini
+++ b/doc/guides/nics/features/zxdh.ini
@@ -11,7 +11,6 @@ SR-IOV               = Y
 Multiprocess aware   = Y
 Scattered Rx         = Y
 Link speed configuration = Y
-Link status          = Y
 Link status event    = Y
 Unicast MAC filter   = Y
 Multicast MAC filter = Y
@@ -23,7 +22,6 @@ QinQ offload         = Y
 RSS hash             = Y
 RSS reta update      = Y
 Inner RSS            = Y
-Basic stats          = Y
 Stats per queue      = Y
 MTU update           = Y
 L3 checksum offload  = Y
-- 
2.55.0

