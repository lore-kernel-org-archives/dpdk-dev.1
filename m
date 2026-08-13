Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCBFC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:05:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03C6042E3A;
	Thu, 13 Aug 2026 20:05:35 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 8BE6D42E7D
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:05:33 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so112934a91.2
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644333;
 x=1787249133; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0wjMqKSi5E8JfwTmbpr5TcCW4O2CE31d1ZxAAnNe+9c=;
 b=kHbmEakGGbjhgz0S6o+Q+izTiqjOLz7Q7rR33T2IXFsq+g5veHixMed357uXLZ79X4
 XByDNdE30V4e/moO2QjBUf/0LynCsVPL59iUtXTb3cQo0wXfsdsn4S5sLL/dFXlKs0dk
 ZGhsJOPdX/K7qx/I0hp8KDYtds74brfRJuQva5IQmTVnnPzxRhuSS+BZY4Rylmx4kqgV
 I77pIOcv89niIiOn6+PAcatY/ykr0XQBShCrR9I6vgliQRe8JLExPXMPv8FZQGxASDgN
 P3TB8nbV/9ZFqS4z7X9Ai6PH/KlFTYZBckVc0a0HcqcHSyjvuNvB2Z37+xS9QpoZGa8Q
 G+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644333; x=1787249133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0wjMqKSi5E8JfwTmbpr5TcCW4O2CE31d1ZxAAnNe+9c=;
 b=Os4i3GC0uBV2WxQmiv/LUgVafccO9wGunJKKkvJXaNR2LsPZnrczLtTSOztJOMm8ni
 Pm7uoorYt6CGWT/kBiacz0zRLhY4SGqrEulbqXe/9cwegUSMVNjE+itRfC4IHmLBVkjx
 CdWWaaaNQeoTmrRcgZR8VlEc1wQcGcMa5/ZAlWJxeRhYs70Hkc9Cuy8Wn7yVBh4SANKf
 YIIpqvth8StpEGXWXcEAjxeChXidA7kowtplkZmAODMlx0YsGOyyl0jz8njcvDU+lrGX
 +2rhqHctJaR+8d/Sy1AD2+QH4Xjy4ecBLs6EYPdv+rX7wIr9+3zdLd9HX2wXaOl5XyfZ
 zIjA==
X-Gm-Message-State: AOJu0YwrZSA5tv9IH9H2cTFdlgF3DXK7k4OupmjgFFmyykusRwPjy8qN
 6Ts3LBzJ45ZQc1isYPjpGLNqKLm4QDWd6ZOLFaCI1iAxT7yXw7jlMWWthQffyp54mF50Q7YGEAU
 QNNTbAkc=
X-Gm-Gg: AR+sD13SoggNZhKNMn85l0Koj5R2SxStPRZ27kt7rj9Df8PoUhtFKcc/XaHJzTMVoik
 N8fGRezCdIx+pwiCHR3MugCEDjPxV5xPlkmlmj39//Nh6XvSzuXNw1SAZGbTY1gBGTr3f0dKjTm
 jqL5VHLBRSo63qWC4Jv16soodcV8pd3NFuv25f55mHVTnlBpY/QfoPmhptD5ZRDjq4rF9Lo51tb
 mycfDBZWaDp9JW+k9Y0NF0hpaLhK7dkZuINpkj5WY1ffz5PV4BuWhEP+qhTXJ7sFMke08pqdyfU
 a0XKhfBiM670TXSJNCWdsrVsrEugfRRdeaSdqO1mvGhHA2sxa/GdkfscuSeNkztYNt6PwdaS4Ql
 8TvT2skpogO22RjECbcyr+zpLpV1o0EmzKM2h5Uc6gZ9wXM/n2ZsBUnleWXzi/i5EPGzoRMsGVy
 z0VeL6A91blNhl3gEv5sbYV4oFGT54/cmhfijOmPUpZ3N5jEtkFiatm6w1T3s3jKkJhEZ1uhip7
 0Vq3dNzBI3Qz54TOR4PZ3zFh20=
X-Received: by 2002:a17:90b:4a03:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-3931e2069f5mr7068803a91.11.1786644331883; 
 Thu, 13 Aug 2026 11:05:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:05:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>,
 Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Andrew Boyer <andrew.boyer@amd.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Liron Himi <lironh@marvell.com>, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Martin Spinler <spinler@cesnet.cz>, Chaoyong He <chaoyong.he@corigine.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Wenbo Cao <caowenbo@mucse.com>, Jie Liu <liujie5@linkdatatechnology.com>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>, Junlong Wang <wang.junlong1@zte.com.cn>,
 Ming Ran <ran.ming@zte.com.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 15/16] ethdev: remove queue stats counter limit
Date: Thu, 13 Aug 2026 10:55:14 -0700
Message-ID: <20260813180402.622784-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

Queue stats were passed back from drivers in arrays of
RTE_ETHDEV_QUEUE_STAT_CNTRS entries, limiting reporting to the first 16
queues unless DPDK was rebuilt with a larger value.

Replace the arrays with one counter structure per queue, allocated by
ethdev and sized to the number of queues configured on the port.
Queue counts are already validated by rte_eth_dev_configure(), so no
additional limit is needed.

Drop the per-queue error counter. Only a few drivers filled it, and
errors are still counted by the port level ierrors and oerrors.

RTE_ETHDEV_QUEUE_STAT_CNTRS is unused now and removed. It was defined in
ethdev_driver.h, only installed with the driver SDK, so the ABI is
unaffected.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/howto/debug_troubleshoot.rst       |  5 +-
 doc/guides/nics/bnxt.rst                      |  4 +-
 doc/guides/nics/features.rst                  |  5 +-
 doc/guides/rel_notes/release_26_11.rst        |  4 ++
 drivers/net/af_packet/rte_eth_af_packet.c     | 15 +++--
 drivers/net/af_xdp/rte_eth_af_xdp.c           | 13 ++--
 drivers/net/ark/ark_ethdev_rx.c               |  7 +-
 drivers/net/ark/ark_ethdev_tx.c               |  6 +-
 drivers/net/atlantic/atl_ethdev.c             | 13 ++--
 drivers/net/atlantic/atl_rxtx.c               |  8 +--
 drivers/net/atlantic/atl_types.h              | 15 +++--
 drivers/net/avp/avp_ethdev.c                  | 13 ++--
 drivers/net/axgbe/axgbe_ethdev.c              | 13 ++--
 drivers/net/bnxt/bnxt_ethdev.c                |  5 --
 drivers/net/bnxt/bnxt_reps.c                  |  9 ++-
 drivers/net/bnxt/bnxt_stats.c                 | 40 ++++-------
 drivers/net/cnxk/cnxk_rep_ops.c               |  8 +--
 drivers/net/cnxk/cnxk_stats.c                 | 15 ++---
 drivers/net/dpaa2/dpaa2_ethdev.c              | 17 ++---
 drivers/net/ena/ena_ethdev.c                  | 21 ++----
 drivers/net/hinic/hinic_pmd_ethdev.c          | 17 +++--
 drivers/net/hinic3/hinic3_ethdev.c            | 13 ++--
 drivers/net/intel/e1000/igc_ethdev.c          | 13 ++--
 drivers/net/intel/fm10k/fm10k_ethdev.c        | 16 +++--
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 14 ++--
 drivers/net/ionic/ionic_lif.c                 | 24 +++----
 drivers/net/mana/mana.c                       | 12 ++--
 drivers/net/memif/rte_eth_memif.c             | 16 ++---
 drivers/net/mlx4/mlx4_ethdev.c                | 14 ++--
 drivers/net/mlx5/mlx5_rx.h                    |  3 +-
 drivers/net/mlx5/mlx5_stats.c                 | 22 +++----
 drivers/net/mvpp2/mrvl_ethdev.c               | 20 +++---
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  2 -
 drivers/net/nbl/nbl_hw/nbl_txrx.c             | 12 ++--
 drivers/net/netvsc/hn_ethdev.c                | 12 ++--
 drivers/net/netvsc/hn_vf.c                    |  3 +-
 drivers/net/nfb/nfb_stats.c                   | 12 ++--
 drivers/net/nfp/flower/nfp_flower.c           |  8 +--
 .../net/nfp/flower/nfp_flower_representor.c   | 32 ++++++---
 .../net/nfp/flower/nfp_flower_representor.h   |  4 +-
 drivers/net/nfp/nfp_ethdev.c                  | 13 ++++
 drivers/net/nfp/nfp_ethdev_vf.c               | 13 ++++
 drivers/net/nfp/nfp_net_common.c              | 36 ++++------
 drivers/net/nfp/nfp_net_common.h              |  3 +-
 drivers/net/ngbe/ngbe_ethdev.c                | 34 +++-------
 drivers/net/ngbe/ngbe_ethdev.h                | 12 ----
 drivers/net/ntnic/ntnic_ethdev.c              | 12 ++--
 drivers/net/null/rte_eth_null.c               | 12 ++--
 drivers/net/octeon_ep/otx_ep_ethdev.c         | 13 ++--
 drivers/net/pcap/pcap_ethdev.c                | 14 ++--
 drivers/net/qede/qede_ethdev.c                | 36 ++--------
 drivers/net/ring/rte_eth_ring.c               | 10 ++-
 drivers/net/rnp/rnp_ethdev.c                  | 12 ++--
 drivers/net/sxe2/sxe2_cmd_chnl.c              | 20 +++---
 drivers/net/tap/rte_eth_tap.c                 | 12 ++--
 drivers/net/thunderx/nicvf_ethdev.c           | 24 +++----
 drivers/net/txgbe/txgbe_ethdev.c              | 14 ++--
 drivers/net/vhost/rte_eth_vhost.c             | 14 ++--
 drivers/net/virtio/virtio_ethdev.c            | 12 ++--
 drivers/net/vmxnet3/vmxnet3_ethdev.c          | 13 ++--
 drivers/net/xsc/xsc_ethdev.c                  | 14 ++--
 drivers/net/zxdh/zxdh_ethdev_ops.c            | 24 +++----
 lib/ethdev/ethdev_driver.h                    | 27 ++++----
 lib/ethdev/ethdev_private.c                   |  2 -
 lib/ethdev/rte_ethdev.c                       | 66 ++++++++++---------
 65 files changed, 445 insertions(+), 522 deletions(-)

diff --git a/doc/guides/howto/debug_troubleshoot.rst b/doc/guides/howto/debug_troubleshoot.rst
index c19aada6f8..969118fcfc 100644
--- a/doc/guides/howto/debug_troubleshoot.rst
+++ b/doc/guides/howto/debug_troubleshoot.rst
@@ -120,8 +120,9 @@ RX-TX port and associated cores :numref:`dtg_rx_tx_drop`.
    * Identify if there are multiple RX queue configured for port by
      ``nb_rx_queues`` using ``rte_eth_dev_info_get``.
 
-   * Using ``rte_eth_dev_stats`` fetch drops in q_errors, check if RX thread
-     is configured to fetch packets from the port queue pair.
+   * Using ``rte_eth_dev_stats`` fetch drops in ``ierrors`` and ``imissed``,
+     check if RX thread is configured to fetch packets from the port queue
+     pair.
 
    * Using ``rte_eth_dev_stats`` shows drops in ``rx_nombuf``, check if RX
      thread has enough cycles to consume the packets from the queue.
diff --git a/doc/guides/nics/bnxt.rst b/doc/guides/nics/bnxt.rst
index 45529a89ee..48b950876c 100644
--- a/doc/guides/nics/bnxt.rst
+++ b/doc/guides/nics/bnxt.rst
@@ -588,9 +588,7 @@ Basic stats include:
 * ierrors
 * oerrors
 
-By default, per-queue stats for 16 queues are supported. For more than 16
-queues, BNXT PMD should be compiled with ``RTE_ETHDEV_QUEUE_STAT_CNTRS``
-set to the desired number of queues.
+Per-queue stats are supported for all configured queues.
 
 Extended Stats
 ^^^^^^^^^^^^^^
diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index d6852b063c..43eda7867d 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -757,8 +757,9 @@ These apply to all drivers.
 Stats per queue
 ---------------
 
-Supports per queue stats: q_ipackets, q_opackets, q_ibytes, q_obytes, q_errors.
-Statistics only supplied for first ``RTE_ETHDEV_QUEUE_STAT_CNTRS`` (16) queues.
+Supports per queue stats: q_ipackets, q_opackets, q_ibytes, q_obytes.
+Statistics are supplied for all configured queues,
+subject to any hardware counter limit of the device.
 If driver does not support this feature the per queue stats will be zero.
 
 * **[implements] eth_dev_ops**: ``stats_get``, ``stats_reset``.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d29d7591e9..ed271a81f6 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -82,6 +82,10 @@ Removed Items
   ``rte_eth_dev_set_tx_queue_stats_mapping`` and ``rte_eth_dev_set_rx_queue_stats_mapping``
   were deprecated and are now removed.
 
+* ethdev: Removed the ``RTE_ETHDEV_QUEUE_STAT_CNTRS`` build time limit.
+  Per-queue xstats are now reported for all queues, not just the first 16.
+  The ``rx_qN_errors`` xstat is removed, drops are still counted in ``ierrors``.
+
 
 API Changes
 -----------
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index b0ff22ea55..a97b826305 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -515,12 +515,15 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats, struct eth_q
 		tx_err_total += internal->tx_queue[i].err_pkts;
 		tx_bytes_total += internal->tx_queue[i].tx_bytes;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = internal->rx_queue[i].rx_pkts;
-			qstats->q_ibytes[i] = internal->rx_queue[i].rx_bytes;
-			qstats->q_opackets[i] = internal->tx_queue[i].tx_pkts;
-			qstats->q_obytes[i] = internal->tx_queue[i].tx_bytes;
-			qstats->q_errors[i] = internal->rx_queue[i].rx_nombuf;
+		if (qstats != NULL) {
+			if (i < dev->data->nb_rx_queues) {
+				qstats[i].q_ipackets = internal->rx_queue[i].rx_pkts;
+				qstats[i].q_ibytes = internal->rx_queue[i].rx_bytes;
+			}
+			if (i < dev->data->nb_tx_queues) {
+				qstats[i].q_opackets = internal->tx_queue[i].tx_pkts;
+				qstats[i].q_obytes = internal->tx_queue[i].tx_bytes;
+			}
 		}
 	}
 
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..be2f5760ae 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -910,12 +910,13 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		rxq = &internals->rx_queues[i];
 		txq = rxq->pair;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rxq->stats.rx_pkts;
-			qstats->q_ibytes[i] = rxq->stats.rx_bytes;
-			qstats->q_opackets[i] = txq->stats.tx_pkts;
-			qstats->q_obytes[i] = txq->stats.tx_bytes;
-			qstats->q_errors[i] = 0; /* Not used */
+		if (qstats != NULL) {
+			qstats[i].q_ipackets = rxq->stats.rx_pkts;
+			qstats[i].q_ibytes = rxq->stats.rx_bytes;
+			if (i < dev->data->nb_tx_queues) {
+				qstats[i].q_opackets = txq->stats.tx_pkts;
+				qstats[i].q_obytes = txq->stats.tx_bytes;
+			}
 		}
 
 		ipackets += rxq->stats.rx_pkts;
diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 42f2db6610..adba943fa2 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -592,10 +592,9 @@ ark_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
 	stats->ibytes += ibytes;
 	stats->imissed += idropped;
 
-	if (qstats && queue->queue_index < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-		qstats->q_ipackets[queue->queue_index] = ipackets;
-		qstats->q_ibytes[queue->queue_index] = ibytes;
-		qstats->q_errors[queue->queue_index] = idropped;
+	if (qstats != NULL) {
+		qstats[queue->queue_index].q_ipackets = ipackets;
+		qstats[queue->queue_index].q_ibytes = ibytes;
 	}
 }
 
diff --git a/drivers/net/ark/ark_ethdev_tx.c b/drivers/net/ark/ark_ethdev_tx.c
index c9b5b005ca..0d6a94b919 100644
--- a/drivers/net/ark/ark_ethdev_tx.c
+++ b/drivers/net/ark/ark_ethdev_tx.c
@@ -433,9 +433,9 @@ ark_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats, struct eth_que
 	stats->obytes += bytes;
 	stats->oerrors += queue->tx_errors;
 
-	if (qstats && queue->queue_index < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-		qstats->q_opackets[queue->queue_index] = pkts;
-		qstats->q_obytes[queue->queue_index] = bytes;
+	if (qstats != NULL) {
+		qstats[queue->queue_index].q_opackets = pkts;
+		qstats[queue->queue_index].q_obytes = bytes;
 	}
 }
 
diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_ethdev.c
index 0b2033c084..24184bdb18 100644
--- a/drivers/net/atlantic/atl_ethdev.c
+++ b/drivers/net/atlantic/atl_ethdev.c
@@ -954,12 +954,13 @@ atl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	stats->rx_nombuf = swstats->rx_nombuf;
 
 	if (qstats != NULL) {
-		for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-			qstats->q_ipackets[i] = swstats->q_ipackets[i];
-			qstats->q_opackets[i] = swstats->q_opackets[i];
-			qstats->q_ibytes[i] = swstats->q_ibytes[i];
-			qstats->q_obytes[i] = swstats->q_obytes[i];
-			qstats->q_errors[i] = swstats->q_errors[i];
+		for (i = 0; i < dev->data->nb_rx_queues && i < AQ_HW_MAX_RX_QUEUES; i++) {
+			qstats[i].q_ipackets = swstats->rxq[i].packets;
+			qstats[i].q_ibytes = swstats->rxq[i].bytes;
+		}
+		for (i = 0; i < dev->data->nb_tx_queues && i < AQ_HW_MAX_TX_QUEUES; i++) {
+			qstats[i].q_opackets = swstats->txq[i].packets;
+			qstats[i].q_obytes = swstats->txq[i].bytes;
 		}
 	}
 	return 0;
diff --git a/drivers/net/atlantic/atl_rxtx.c b/drivers/net/atlantic/atl_rxtx.c
index 7b7bf5abbc..8d02b92304 100644
--- a/drivers/net/atlantic/atl_rxtx.c
+++ b/drivers/net/atlantic/atl_rxtx.c
@@ -1075,8 +1075,8 @@ atl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		 * of returned packets.
 		 */
 		rx_pkts[nb_rx++] = rx_mbuf_first;
-		adapter->sw_stats.q_ipackets[rxq->queue_id]++;
-		adapter->sw_stats.q_ibytes[rxq->queue_id] +=
+		adapter->sw_stats.rxq[rxq->queue_id].packets++;
+		adapter->sw_stats.rxq[rxq->queue_id].bytes +=
 			rx_mbuf_first->pkt_len;
 
 		PMD_RX_LOG(DEBUG, "add mbuf segs=%d pkt_len=%d",
@@ -1297,8 +1297,8 @@ atl_xmit_pkt(struct aq_hw_s *hw, struct atl_tx_queue *txq,
 
 	txq->tx_free -= desc_count;
 
-	adapter->sw_stats.q_opackets[txq->queue_id]++;
-	adapter->sw_stats.q_obytes[txq->queue_id] += pay_len;
+	adapter->sw_stats.txq[txq->queue_id].packets++;
+	adapter->sw_stats.txq[txq->queue_id].bytes += pay_len;
 }
 
 uint16_t
diff --git a/drivers/net/atlantic/atl_types.h b/drivers/net/atlantic/atl_types.h
index dfd7016600..be9f3aacc1 100644
--- a/drivers/net/atlantic/atl_types.h
+++ b/drivers/net/atlantic/atl_types.h
@@ -15,6 +15,8 @@
 #include <rte_common.h>
 #include <ethdev_driver.h>
 
+#include "atl_common.h"
+
 typedef uint8_t		u8;
 typedef int8_t		s8;
 typedef uint16_t	u16;
@@ -225,11 +227,14 @@ struct atl_sw_stats {
 	u64 pcrc8ec;
 
 	u64 rx_nombuf;
-	u64 q_ipackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	u64 q_opackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	u64 q_ibytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	u64 q_obytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	u64 q_errors[RTE_ETHDEV_QUEUE_STAT_CNTRS];
+	struct {
+		u64 packets;
+		u64 bytes;
+	} rxq[AQ_HW_MAX_RX_QUEUES];
+	struct {
+		u64 packets;
+		u64 bytes;
+	} txq[AQ_HW_MAX_TX_QUEUES];
 };
 
 #endif
diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index 8af6c45381..d536f764cf 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -2256,10 +2256,9 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 			stats->ibytes += rxq->bytes;
 			stats->ierrors += rxq->errors;
 
-			if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-				qstats->q_ipackets[i] += rxq->packets;
-				qstats->q_ibytes[i] += rxq->bytes;
-				qstats->q_errors[i] += rxq->errors;
+			if (qstats != NULL && i < eth_dev->data->nb_rx_queues) {
+				qstats[i].q_ipackets += rxq->packets;
+				qstats[i].q_ibytes += rxq->bytes;
 			}
 		}
 	}
@@ -2272,9 +2271,9 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 			stats->obytes += txq->bytes;
 			stats->oerrors += txq->errors;
 
-			if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-				qstats->q_opackets[i] += txq->packets;
-				qstats->q_obytes[i] += txq->bytes;
+			if (qstats != NULL && i < eth_dev->data->nb_tx_queues) {
+				qstats[i].q_opackets += txq->packets;
+				qstats[i].q_obytes += txq->bytes;
 			}
 		}
 	}
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 61725d55ca..93e198ba95 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -1156,10 +1156,9 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,
 			stats->rx_nombuf += rxq->rx_mbuf_alloc_failed;
 			stats->ierrors += rxq->errors;
 
-			if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-				qstats->q_ipackets[i] = rxq->pkts;
-				qstats->q_ibytes[i] = rxq->bytes;
-				qstats->q_errors[i] = rxq->errors + rxq->rx_mbuf_alloc_failed;
+			if (qstats != NULL && i < dev->data->nb_rx_queues) {
+				qstats[i].q_ipackets = rxq->pkts;
+				qstats[i].q_ibytes = rxq->bytes;
 			}
 		} else {
 			PMD_DRV_LOG_LINE(DEBUG, "Rx queue not setup for port %d",
@@ -1174,9 +1173,9 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,
 			stats->obytes += txq->bytes;
 			stats->oerrors += txq->errors;
 
-			if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-				qstats->q_opackets[i] = txq->pkts;
-				qstats->q_obytes[i] = txq->bytes;
+			if (qstats != NULL && i < dev->data->nb_tx_queues) {
+				qstats[i].q_opackets = txq->pkts;
+				qstats[i].q_obytes = txq->bytes;
 			}
 		} else {
 			PMD_DRV_LOG_LINE(DEBUG, "Tx queue not setup for port %d",
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 8e8ead8f61..c6f566c214 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1843,11 +1843,6 @@ int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 	struct bnxt_tx_queue *txq;
 	uint16_t queue_idx;
 
-	if (bp->rx_cp_nr_rings > RTE_ETHDEV_QUEUE_STAT_CNTRS)
-		PMD_DRV_LOG_LINE(ERR,
-			    "RxQ cnt %d > RTE_ETHDEV_QUEUE_STAT_CNTRS %d",
-			    bp->rx_cp_nr_rings, RTE_ETHDEV_QUEUE_STAT_CNTRS);
-
 	do {
 		rc = bnxt_hwrm_if_change(bp, true);
 		if (rc == 0 || rc != -EAGAIN)
diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index e26a086f41..dd0f14d5c6 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -909,11 +909,10 @@ int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev,
 		stats->imissed += rep_bp->rx_drop_pkts[i];
 
 		if (qstats) {
-			qstats->q_ipackets[i] = rep_bp->rx_pkts[i];
-			qstats->q_ibytes[i] = rep_bp->rx_bytes[i];
-			qstats->q_opackets[i] = rep_bp->tx_pkts[i];
-			qstats->q_obytes[i] = rep_bp->tx_bytes[i];
-			qstats->q_errors[i] = rep_bp->rx_drop_pkts[i];
+			qstats[i].q_ipackets = rep_bp->rx_pkts[i];
+			qstats[i].q_ibytes = rep_bp->rx_bytes[i];
+			qstats[i].q_opackets = rep_bp->tx_pkts[i];
+			qstats[i].q_obytes = rep_bp->tx_bytes[i];
 		}
 	}
 
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index ba858710a5..37b33f0505 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -576,18 +576,14 @@ static void bnxt_fill_rte_eth_stats_ext(struct rte_eth_stats *stats,
 		uint64_t ibytes = ring_stats->rx_ucast_bytes +
 				ring_stats->rx_mcast_bytes +
 				ring_stats->rx_bcast_bytes;
-		uint64_t ierrors = ring_stats->rx_discard_pkts +
-				ring_stats->rx_error_pkts;
-
 		stats->ipackets += ipackets;
 		stats->ibytes += ibytes;
 		stats->imissed += ring_stats->rx_discard_pkts;
 		stats->ierrors += ring_stats->rx_error_pkts;
 
 		if (qstats) {
-			qstats->q_ipackets[i] = ipackets;
-			qstats->q_ibytes[i] = ibytes;
-			qstats->q_errors[i] = ierrors;
+			qstats[i].q_ipackets = ipackets;
+			qstats[i].q_ibytes = ibytes;
 		}
 	} else {
 		uint64_t opackets = ring_stats->tx_ucast_pkts +
@@ -602,8 +598,8 @@ static void bnxt_fill_rte_eth_stats_ext(struct rte_eth_stats *stats,
 		stats->oerrors += ring_stats->tx_discard_pkts;
 
 		if (qstats) {
-			qstats->q_opackets[i] = opackets;
-			qstats->q_obytes[i] = obytes;
+			qstats[i].q_opackets = opackets;
+			qstats[i].q_obytes = obytes;
 		}
 	}
 }
@@ -620,18 +616,14 @@ static void bnxt_fill_rte_eth_stats(struct rte_eth_stats *stats,
 		uint64_t ibytes = ring_stats->rx_ucast_bytes +
 				ring_stats->rx_mcast_bytes +
 				ring_stats->rx_bcast_bytes;
-		uint64_t ierrors = ring_stats->rx_discard_pkts +
-				ring_stats->rx_error_pkts;
-
 		stats->ipackets += ipackets;
 		stats->ibytes += ibytes;
 		stats->imissed += ring_stats->rx_discard_pkts;
 		stats->ierrors += ring_stats->rx_error_pkts;
 
 		if (qstats) {
-			qstats->q_ipackets[i] = ipackets;
-			qstats->q_ibytes[i] = ibytes;
-			qstats->q_errors[i] = ierrors;
+			qstats[i].q_ipackets = ipackets;
+			qstats[i].q_ibytes = ibytes;
 		}
 	} else {
 		uint64_t opackets = ring_stats->tx_ucast_pkts +
@@ -646,8 +638,8 @@ static void bnxt_fill_rte_eth_stats(struct rte_eth_stats *stats,
 		stats->oerrors += ring_stats->tx_discard_pkts;
 
 		if (qstats) {
-			qstats->q_opackets[i] = opackets;
-			qstats->q_obytes[i] = obytes;
+			qstats[i].q_opackets = opackets;
+			qstats[i].q_obytes = obytes;
 		}
 	}
 }
@@ -661,9 +653,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 	struct bnxt *bp = eth_dev->data->dev_private;
 	unsigned int num_q_stats;
 
-	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings,
-			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
-
+	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings, eth_dev->data->nb_rx_queues);
 	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		struct bnxt_rx_queue *rxq = bp->rx_queues[i];
 		struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
@@ -687,9 +677,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 							 rte_memory_order_relaxed);
 	}
 
-	num_q_stats = RTE_MIN(bp->tx_cp_nr_rings,
-			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
-
+	num_q_stats = RTE_MIN(bp->tx_cp_nr_rings, eth_dev->data->nb_tx_queues);
 	for (i = 0; i < bp->tx_cp_nr_rings; i++) {
 		struct bnxt_tx_queue *txq = bp->tx_queues[i];
 		struct bnxt_cp_ring_info *cpr = txq->cp_ring;
@@ -728,9 +716,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 	if (BNXT_TPA_V2_P7(bp))
 		return bnxt_stats_get_ext(eth_dev, bnxt_stats, qstats);
 
-	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings,
-			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
-
+	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings, eth_dev->data->nb_rx_queues);
 	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		struct bnxt_rx_queue *rxq = bp->rx_queues[i];
 		struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
@@ -753,9 +739,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 							 rte_memory_order_relaxed);
 	}
 
-	num_q_stats = RTE_MIN(bp->tx_cp_nr_rings,
-			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
-
+	num_q_stats = RTE_MIN(bp->tx_cp_nr_rings, eth_dev->data->nb_tx_queues);
 	for (i = 0; i < bp->tx_cp_nr_rings; i++) {
 		struct bnxt_tx_queue *txq = bp->tx_queues[i];
 		struct bnxt_cp_ring_info *cpr = txq->cp_ring;
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_ops.c
index c481015592..4a9c027bf5 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -614,10 +614,10 @@ cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats,
 	}
 
 	if (qstats != NULL) {
-		qstats->q_ipackets[0] = vf_stats.ipackets;
-		qstats->q_ibytes[0] = vf_stats.ibytes;
-		qstats->q_opackets[0] = vf_stats.opackets;
-		qstats->q_obytes[0] = vf_stats.obytes;
+		qstats[0].q_ipackets = vf_stats.ipackets;
+		qstats[0].q_ibytes = vf_stats.ibytes;
+		qstats[0].q_opackets = vf_stats.opackets;
+		qstats[0].q_obytes = vf_stats.obytes;
 	}
 
 	stats->ipackets = vf_stats.ipackets;
diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c
index 469a18f93e..c15c8761c1 100644
--- a/drivers/net/cnxk/cnxk_stats.c
+++ b/drivers/net/cnxk/cnxk_stats.c
@@ -39,28 +39,21 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
 		struct roc_nix_stats_queue qstats_data;
 
-		if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			break;
-
 		rc = roc_nix_stats_queue_get(nix, i, 0, &qstats_data);
 		if (rc)
 			goto exit;
-		qstats->q_opackets[i] = qstats_data.tx_pkts;
-		qstats->q_obytes[i] = qstats_data.tx_octs;
+		qstats[i].q_opackets = qstats_data.tx_pkts;
+		qstats[i].q_obytes = qstats_data.tx_octs;
 	}
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
 		struct roc_nix_stats_queue qstats_data;
 
-		if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			break;
-
 		rc = roc_nix_stats_queue_get(nix, i, 1, &qstats_data);
 		if (rc)
 			goto exit;
-		qstats->q_ipackets[i] = qstats_data.rx_pkts;
-		qstats->q_ibytes[i] = qstats_data.rx_octs;
-		qstats->q_errors[i] = qstats_data.rx_drop_pkts;
+		qstats[i].q_ipackets = qstats_data.rx_pkts;
+		qstats[i].q_ibytes = qstats_data.rx_octs;
 	}
 exit:
 	return rc;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index f211357919..8ae4fd89c5 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2002,20 +2002,17 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
 	stats->oerrors = value.page_2.egress_discarded_frames;
 	stats->imissed = value.page_2.ingress_nobuffer_discards;
 
-	/* Fill in per queue stats */
+	/* Fill in per queue stats. Byte counting is not implemented. */
 	if (qstats != NULL) {
-		for (i = 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
-			(i < priv->nb_rx_queues || i < priv->nb_tx_queues); ++i) {
+		for (i = 0; i < dev->data->nb_rx_queues; ++i) {
 			dpaa2_rxq = priv->rx_vq[i];
-			dpaa2_txq = priv->tx_vq[i];
 			if (dpaa2_rxq)
-				qstats->q_ipackets[i] = dpaa2_rxq->rx_pkts;
+				qstats[i].q_ipackets = dpaa2_rxq->rx_pkts;
+		}
+		for (i = 0; i < dev->data->nb_tx_queues; ++i) {
+			dpaa2_txq = priv->tx_vq[i];
 			if (dpaa2_txq)
-				qstats->q_opackets[i] = dpaa2_txq->tx_pkts;
-
-			/* Byte counting is not implemented */
-			qstats->q_ibytes[i]   = 0;
-			qstats->q_obytes[i]   = 0;
+				qstats[i].q_opackets = dpaa2_txq->tx_pkts;
 		}
 	}
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index ad2ac6dbbf..ae48afcfdc 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -1264,7 +1264,6 @@ static int ena_stats_get(struct rte_eth_dev *dev,
 	struct ena_com_dev *ena_dev = &adapter->ena_dev;
 	int rc;
 	int i;
-	int max_rings_stats;
 
 	memset(&ena_stats, 0, sizeof(ena_stats));
 
@@ -1295,26 +1294,18 @@ static int ena_stats_get(struct rte_eth_dev *dev,
 
 	/* Queue statistics */
 	if (qstats) {
-		max_rings_stats = RTE_MIN(dev->data->nb_rx_queues,
-			RTE_ETHDEV_QUEUE_STAT_CNTRS);
-		for (i = 0; i < max_rings_stats; ++i) {
+		for (i = 0; i < dev->data->nb_rx_queues; ++i) {
 			struct ena_stats_rx *rx_stats = &adapter->rx_ring[i].rx_stats;
 
-			qstats->q_ibytes[i] = rx_stats->bytes;
-			qstats->q_ipackets[i] = rx_stats->cnt;
-			qstats->q_errors[i] = rx_stats->bad_desc_num +
-				rx_stats->bad_req_id +
-				rx_stats->bad_desc +
-				rx_stats->unknown_error;
+			qstats[i].q_ibytes = rx_stats->bytes;
+			qstats[i].q_ipackets = rx_stats->cnt;
 		}
 
-		max_rings_stats = RTE_MIN(dev->data->nb_tx_queues,
-			RTE_ETHDEV_QUEUE_STAT_CNTRS);
-		for (i = 0; i < max_rings_stats; ++i) {
+		for (i = 0; i < dev->data->nb_tx_queues; ++i) {
 			struct ena_stats_tx *tx_stats = &adapter->tx_ring[i].tx_stats;
 
-			qstats->q_obytes[i] = tx_stats->bytes;
-			qstats->q_opackets[i] = tx_stats->cnt;
+			qstats[i].q_obytes = tx_stats->bytes;
+			qstats[i].q_opackets = tx_stats->cnt;
 		}
 	}
 
diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c b/drivers/net/hinic/hinic_pmd_ethdev.c
index 91a4348fb6..016d632e64 100644
--- a/drivers/net/hinic/hinic_pmd_ethdev.c
+++ b/drivers/net/hinic/hinic_pmd_ethdev.c
@@ -1329,14 +1329,13 @@ hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 
 	/* rx queue stats */
 	if (qstats) {
-		q_num = (nic_dev->num_rq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
-				nic_dev->num_rq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
+		q_num = (nic_dev->num_rq < dev->data->nb_rx_queues) ?
+				nic_dev->num_rq : dev->data->nb_rx_queues;
 		for (i = 0; i < q_num; i++) {
 			rxq = nic_dev->rxqs[i];
 			hinic_rxq_get_stats(rxq, &rxq_stats);
-			qstats->q_ipackets[i] = rxq_stats.packets;
-			qstats->q_ibytes[i] = rxq_stats.bytes;
-			qstats->q_errors[i] = rxq_stats.rx_discards;
+			qstats[i].q_ipackets = rxq_stats.packets;
+			qstats[i].q_ibytes = rxq_stats.bytes;
 
 			stats->ierrors += rxq_stats.errors;
 			rx_discards_pmd += rxq_stats.rx_discards;
@@ -1344,13 +1343,13 @@ hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		}
 
 		/* tx queue stats */
-		q_num = (nic_dev->num_sq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
-			nic_dev->num_sq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
+		q_num = (nic_dev->num_sq < dev->data->nb_tx_queues) ?
+			nic_dev->num_sq : dev->data->nb_tx_queues;
 		for (i = 0; i < q_num; i++) {
 			txq = nic_dev->txqs[i];
 			hinic_txq_get_stats(txq, &txq_stats);
-			qstats->q_opackets[i] = txq_stats.packets;
-			qstats->q_obytes[i] = txq_stats.bytes;
+			qstats[i].q_opackets = txq_stats.packets;
+			qstats[i].q_obytes = txq_stats.bytes;
 			stats->oerrors += (txq_stats.tx_busy + txq_stats.off_errs);
 		}
 	} else {
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 361e52f7b9..eb5ddd9de6 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2763,10 +2763,9 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		rxq->rxq_stats.errors = rxq->rxq_stats.csum_errors +
 					rxq->rxq_stats.other_errors;
 
-		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rxq->rxq_stats.packets;
-			qstats->q_ibytes[i] = rxq->rxq_stats.bytes;
-			qstats->q_errors[i] = rxq->rxq_stats.errors;
+		if (qstats && i < dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = rxq->rxq_stats.packets;
+			qstats[i].q_ibytes = rxq->rxq_stats.bytes;
 		}
 		stats->ierrors += rxq->rxq_stats.errors;
 		rx_discards_pmd += rxq->rxq_stats.dropped;
@@ -2777,9 +2776,9 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	for (uint32_t i = 0; i < nic_dev->num_sqs; i++) {
 		struct hinic3_txq *txq = nic_dev->txqs[i];
 		stats->oerrors += (txq->txq_stats.tx_busy + txq->txq_stats.offload_errors);
-		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = txq->txq_stats.packets;
-			qstats->q_obytes[i] = txq->txq_stats.bytes;
+		if (qstats && i < dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = txq->txq_stats.packets;
+			qstats[i].q_obytes = txq->txq_stats.bytes;
 		}
 	}
 
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 943a479f9a..73dd5dd1a3 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -2059,12 +2059,13 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
 
 	/* Get per-queue statuses */
 	if (qstats) {
-		for (i = 0; i < RTE_MIN(IGC_QUEUE_PAIRS_NUM, RTE_ETHDEV_QUEUE_STAT_CNTRS); i++) {
-			qstats->q_opackets[i] += queue_stats->pqgptc[i];
-			qstats->q_obytes[i] += queue_stats->pqgotc[i];
-			qstats->q_ipackets[i] += queue_stats->pqgprc[i];
-			qstats->q_ibytes[i] += queue_stats->pqgorc[i];
-			qstats->q_errors[i] += queue_stats->rqdpc[i];
+		for (i = 0; i < RTE_MIN(IGC_QUEUE_PAIRS_NUM, dev->data->nb_rx_queues); i++) {
+			qstats[i].q_ipackets += queue_stats->pqgprc[i];
+			qstats[i].q_ibytes += queue_stats->pqgorc[i];
+		}
+		for (i = 0; i < RTE_MIN(IGC_QUEUE_PAIRS_NUM, dev->data->nb_tx_queues); i++) {
+			qstats[i].q_opackets += queue_stats->pqgptc[i];
+			qstats[i].q_obytes += queue_stats->pqgotc[i];
 		}
 	}
 
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index ca438d2d02..3b2daba79e 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -1328,14 +1328,16 @@ fm10k_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	fm10k_update_hw_stats(hw, hw_stats);
 
 	ipackets = opackets = ibytes = obytes = imissed = 0;
-	for (i = 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
-			(i < hw->mac.max_queues); ++i) {
+	for (i = 0; i < hw->mac.max_queues; ++i) {
 		if (qstats != NULL) {
-			qstats->q_ipackets[i] = hw_stats->q[i].rx_packets.count;
-			qstats->q_opackets[i] = hw_stats->q[i].tx_packets.count;
-			qstats->q_ibytes[i]   = hw_stats->q[i].rx_bytes.count;
-			qstats->q_obytes[i]   = hw_stats->q[i].tx_bytes.count;
-			qstats->q_errors[i]   = hw_stats->q[i].rx_drops.count;
+			if (i < dev->data->nb_rx_queues) {
+				qstats[i].q_ipackets = hw_stats->q[i].rx_packets.count;
+				qstats[i].q_ibytes   = hw_stats->q[i].rx_bytes.count;
+			}
+			if (i < dev->data->nb_tx_queues) {
+				qstats[i].q_opackets = hw_stats->q[i].tx_packets.count;
+				qstats[i].q_obytes   = hw_stats->q[i].tx_bytes.count;
+			}
 		}
 		ipackets += hw_stats->q[i].rx_packets.count;
 		opackets += hw_stats->q[i].tx_packets.count;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index d35da73d69..3620331d6c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3355,12 +3355,14 @@ ixgbe_dev_stats_get(struct rte_eth_dev *dev,
 
 	if (qstats != NULL) {
 		for (i = 0; i < RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,
-				RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i++) {
-			qstats->q_ipackets[i] = hw_stats->qprc[i];
-			qstats->q_opackets[i] = hw_stats->qptc[i];
-			qstats->q_ibytes[i] = hw_stats->qbrc[i];
-			qstats->q_obytes[i] = hw_stats->qbtc[i];
-			qstats->q_errors[i] = hw_stats->qprdc[i];
+				dev->data->nb_rx_queues, typeof(i)); i++) {
+			qstats[i].q_ipackets = hw_stats->qprc[i];
+			qstats[i].q_ibytes = hw_stats->qbrc[i];
+		}
+		for (i = 0; i < RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,
+				dev->data->nb_tx_queues, typeof(i)); i++) {
+			qstats[i].q_opackets = hw_stats->qptc[i];
+			qstats[i].q_obytes = hw_stats->qbtc[i];
 		}
 	}
 
diff --git a/drivers/net/ionic/ionic_lif.c b/drivers/net/ionic/ionic_lif.c
index b52c8cad88..2443c98881 100644
--- a/drivers/net/ionic/ionic_lif.c
+++ b/drivers/net/ionic/ionic_lif.c
@@ -105,10 +105,15 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats *stats
 {
 	struct ionic_lif_stats *ls = &lif->info->stats;
 	uint32_t i;
-	uint32_t num_rx_q_counters = RTE_MIN(lif->nrxqcqs, (uint32_t)
-			RTE_ETHDEV_QUEUE_STAT_CNTRS);
-	uint32_t num_tx_q_counters = RTE_MIN(lif->ntxqcqs, (uint32_t)
-			RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	/*
+	 * The queue stats array is indexed by queue id and sized by the
+	 * queue counts passed to configure, which is not necessarily the
+	 * number of queues the LIF has allocated.
+	 */
+	uint32_t num_rx_q_counters = RTE_MIN(lif->nrxqcqs,
+			(uint32_t)lif->eth_dev->data->nb_rx_queues);
+	uint32_t num_tx_q_counters = RTE_MIN(lif->ntxqcqs,
+			(uint32_t)lif->eth_dev->data->nb_tx_queues);
 
 	memset(stats, 0, sizeof(*stats));
 
@@ -148,11 +153,8 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats *stats
 	if (qstats != NULL) {
 		for (i = 0; i < num_rx_q_counters; i++) {
 			struct ionic_rx_stats *rx_stats = &lif->rxqcqs[i]->stats;
-			qstats->q_ipackets[i] = rx_stats->packets;
-			qstats->q_ibytes[i] = rx_stats->bytes;
-			qstats->q_errors[i] =
-				rx_stats->bad_cq_status +
-				rx_stats->bad_len;
+			qstats[i].q_ipackets = rx_stats->packets;
+			qstats[i].q_ibytes = rx_stats->bytes;
 		}
 	}
 
@@ -185,8 +187,8 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats *stats
 	if (qstats != NULL) {
 		for (i = 0; i < num_tx_q_counters; i++) {
 			struct ionic_tx_stats *tx_stats = &lif->txqcqs[i]->stats;
-			qstats->q_opackets[i] = tx_stats->packets;
-			qstats->q_obytes[i] = tx_stats->bytes;
+			qstats[i].q_opackets = tx_stats->packets;
+			qstats[i].q_obytes = tx_stats->bytes;
 		}
 	}
 }
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 0b72f711a1..72c8501d3c 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -779,9 +779,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->obytes += txq->stats.bytes;
 		stats->oerrors += txq->stats.errors;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = txq->stats.packets;
-			qstats->q_obytes[i] = txq->stats.bytes;
+		if (qstats != NULL && i < dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = txq->stats.packets;
+			qstats[i].q_obytes = txq->stats.bytes;
 		}
 	}
 
@@ -798,9 +798,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 
 		/* There is no good way to get stats->imissed, not setting it */
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rxq->stats.packets;
-			qstats->q_ibytes[i] = rxq->stats.bytes;
+		if (qstats != NULL && i < dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = rxq->stats.packets;
+			qstats[i].q_ibytes = rxq->stats.bytes;
 		}
 
 		stats->rx_nombuf += rxq->stats.nombuf;
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 5d153c3a5a..1c8dc1d5ec 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1607,15 +1607,15 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 
 	tmp = (pmd->role == MEMIF_ROLE_CLIENT) ? pmd->run.num_s2c_rings :
 	    pmd->run.num_c2s_rings;
-	nq = (tmp < RTE_ETHDEV_QUEUE_STAT_CNTRS) ? tmp :
-	    RTE_ETHDEV_QUEUE_STAT_CNTRS;
+	nq = (tmp < dev->data->nb_rx_queues) ? tmp :
+	    dev->data->nb_rx_queues;
 
 	/* RX stats */
 	for (i = 0; i < nq; i++) {
 		mq = dev->data->rx_queues[i];
 		if (qstats != NULL) {
-			qstats->q_ipackets[i] = mq->n_pkts;
-			qstats->q_ibytes[i] = mq->n_bytes;
+			qstats[i].q_ipackets = mq->n_pkts;
+			qstats[i].q_ibytes = mq->n_bytes;
 		}
 		stats->ipackets += mq->n_pkts;
 		stats->ibytes += mq->n_bytes;
@@ -1624,15 +1624,15 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 
 	tmp = (pmd->role == MEMIF_ROLE_CLIENT) ? pmd->run.num_c2s_rings :
 	    pmd->run.num_s2c_rings;
-	nq = (tmp < RTE_ETHDEV_QUEUE_STAT_CNTRS) ? tmp :
-	    RTE_ETHDEV_QUEUE_STAT_CNTRS;
+	nq = (tmp < dev->data->nb_tx_queues) ? tmp :
+	    dev->data->nb_tx_queues;
 
 	/* TX stats */
 	for (i = 0; i < nq; i++) {
 		mq = dev->data->tx_queues[i];
 		if (qstats != NULL) {
-			qstats->q_opackets[i] = mq->n_pkts;
-			qstats->q_obytes[i] = mq->n_bytes;
+			qstats[i].q_opackets = mq->n_pkts;
+			qstats[i].q_obytes = mq->n_bytes;
 		}
 		stats->opackets += mq->n_pkts;
 		stats->obytes += mq->n_bytes;
diff --git a/drivers/net/mlx4/mlx4_ethdev.c b/drivers/net/mlx4/mlx4_ethdev.c
index efc6ee4577..4ea79bf1eb 100644
--- a/drivers/net/mlx4/mlx4_ethdev.c
+++ b/drivers/net/mlx4/mlx4_ethdev.c
@@ -717,11 +717,9 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		if (rxq == NULL)
 			continue;
 		idx = rxq->stats.idx;
-		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[idx] += rxq->stats.ipackets;
-			qstats->q_ibytes[idx] += rxq->stats.ibytes;
-			qstats->q_errors[idx] += (rxq->stats.idropped +
-					      rxq->stats.rx_nombuf);
+		if (qstats != NULL && idx < dev->data->nb_rx_queues) {
+			qstats[idx].q_ipackets += rxq->stats.ipackets;
+			qstats[idx].q_ibytes += rxq->stats.ibytes;
 		}
 		tmp.ipackets += rxq->stats.ipackets;
 		tmp.ibytes += rxq->stats.ibytes;
@@ -734,9 +732,9 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		if (txq == NULL)
 			continue;
 		idx = txq->stats.idx;
-		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[idx] += txq->stats.opackets;
-			qstats->q_obytes[idx] += txq->stats.obytes;
+		if (qstats != NULL && idx < dev->data->nb_tx_queues) {
+			qstats[idx].q_opackets += txq->stats.opackets;
+			qstats[idx].q_obytes += txq->stats.obytes;
 		}
 		tmp.opackets += txq->stats.opackets;
 		tmp.obytes += txq->stats.obytes;
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index cd48ee37ef..0d1eee61b2 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -53,9 +53,10 @@ struct mlx5_xstats_name_off {
 	unsigned int offset;
 };
 
+/* Only used with offsetof() for the xstats names table. */
 struct mlx5_rq_stats {
 	/** Total number of hairpin queue packets received that are dropped. */
-	uint64_t q_oobs[RTE_ETHDEV_QUEUE_STAT_CNTRS];
+	uint64_t q_oobs;
 };
 
 /* Compressed CQE context. */
diff --git a/drivers/net/mlx5/mlx5_stats.c b/drivers/net/mlx5/mlx5_stats.c
index 5cd3e303cc..1fbd298c77 100644
--- a/drivers/net/mlx5/mlx5_stats.c
+++ b/drivers/net/mlx5/mlx5_stats.c
@@ -44,7 +44,7 @@ static int
 mlx5_rq_xstats_get(struct rte_eth_dev *dev,
 					struct rte_eth_xstat *stats)
 {
-	uint16_t n_stats_rq = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	uint16_t n_stats_rq = dev->data->nb_rx_queues;
 	int cnt_used_entries = 0;
 
 	for (unsigned int idx = 0; idx < n_stats_rq; idx++) {
@@ -101,7 +101,7 @@ mlx5_rq_xstats_get_names(struct rte_eth_dev *dev __rte_unused,
 	unsigned int i;
 	int cnt_used_entries = 0;
 
-	uint16_t n_stats_rq = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	uint16_t n_stats_rq = dev->data->nb_rx_queues;
 
 	for (i = 0; (i != n_stats_rq); ++i) {
 		rxq = mlx5_rxq_get(dev, i);
@@ -227,17 +227,13 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		if (rxq == NULL)
 			continue;
 		idx = rxq->idx;
-		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+		if (qstats != NULL && idx < dev->data->nb_rx_queues) {
 #ifdef MLX5_PMD_SOFT_COUNTERS
-			qstats->q_ipackets[idx] += rxq->stats.ipackets -
+			qstats[idx].q_ipackets += rxq->stats.ipackets -
 				rxq->stats_reset.ipackets;
-			qstats->q_ibytes[idx] += rxq->stats.ibytes -
+			qstats[idx].q_ibytes += rxq->stats.ibytes -
 				rxq->stats_reset.ibytes;
 #endif
-			qstats->q_errors[idx] += (rxq->stats.idropped +
-					      rxq->stats.rx_nombuf) -
-					      (rxq->stats_reset.idropped +
-					      rxq->stats_reset.rx_nombuf);
 		}
 #ifdef MLX5_PMD_SOFT_COUNTERS
 		tmp.ipackets += rxq->stats.ipackets - rxq->stats_reset.ipackets;
@@ -253,11 +249,11 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		if (txq == NULL)
 			continue;
 		idx = txq->idx;
-		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+		if (qstats != NULL && idx < dev->data->nb_tx_queues) {
 #ifdef MLX5_PMD_SOFT_COUNTERS
-			qstats->q_opackets[idx] += txq->stats.opackets -
+			qstats[idx].q_opackets += txq->stats.opackets -
 						txq->stats_reset.opackets;
-			qstats->q_obytes[idx] += txq->stats.obytes -
+			qstats[idx].q_obytes += txq->stats.obytes -
 						txq->stats_reset.obytes;
 #endif
 		}
@@ -467,7 +463,7 @@ mlx5_xstats_get_names(struct rte_eth_dev *dev,
 static struct mlx5_stat_counter_ctrl*
 mlx5_rxq_get_counter_by_id(struct rte_eth_dev *dev, uint64_t id, uint64_t *rq_id)
 {
-	uint16_t n_stats_rq = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	uint16_t n_stats_rq = dev->data->nb_rx_queues;
 
 	for (int i = 0; (i != n_stats_rq); i++) {
 		struct mlx5_rxq_data *rxq_data = mlx5_rxq_data_get(dev, i);
diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index bc947ff52e..d7ed504bee 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -1505,10 +1505,10 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			continue;
 
 		idx = rxq->queue_id;
-		if (unlikely(idx >= RTE_ETHDEV_QUEUE_STAT_CNTRS)) {
+		if (unlikely(idx >= dev->data->nb_rx_queues)) {
 			MRVL_LOG(ERR,
 				"rx queue %d stats out of range (0 - %d)",
-				idx, RTE_ETHDEV_QUEUE_STAT_CNTRS - 1);
+				idx, dev->data->nb_rx_queues - 1);
 			continue;
 		}
 
@@ -1523,12 +1523,8 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		}
 
 		if (qstats != NULL) {
-			qstats->q_ibytes[idx] = rxq->bytes_recv;
-			qstats->q_ipackets[idx] = rx_stats.enq_desc - rxq->drop_mac;
-			qstats->q_errors[idx] = rx_stats.drop_early +
-					       rx_stats.drop_fullq +
-					       rx_stats.drop_bm +
-					       rxq->drop_mac;
+			qstats[idx].q_ibytes = rxq->bytes_recv;
+			qstats[idx].q_ipackets = rx_stats.enq_desc - rxq->drop_mac;
 		}
 		stats->ibytes += rxq->bytes_recv;
 		drop_mac += rxq->drop_mac;
@@ -1542,10 +1538,10 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			continue;
 
 		idx = txq->queue_id;
-		if (unlikely(idx >= RTE_ETHDEV_QUEUE_STAT_CNTRS)) {
+		if (unlikely(idx >= dev->data->nb_tx_queues)) {
 			MRVL_LOG(ERR,
 				"tx queue %d stats out of range (0 - %d)",
-				idx, RTE_ETHDEV_QUEUE_STAT_CNTRS - 1);
+				idx, dev->data->nb_tx_queues - 1);
 			continue;
 		}
 
@@ -1558,8 +1554,8 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		}
 
 		if (qstats != NULL) {
-			qstats->q_opackets[idx] = tx_stats.deq_desc;
-			qstats->q_obytes[idx] = txq->bytes_sent;
+			qstats[idx].q_opackets = tx_stats.deq_desc;
+			qstats[idx].q_obytes = txq->bytes_sent;
 		}
 		stats->obytes += txq->bytes_sent;
 	}
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 3c0e98d687..320f26619f 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -534,8 +534,6 @@ int nbl_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats,
 		goto update_hw_stats_fail;
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
-		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			qstats->q_errors[i] = net_dev->hw_stats.total_uvn_stat_pkt_drop[i];
 		rte_stats->imissed += net_dev->hw_stats.total_uvn_stat_pkt_drop[i];
 	}
 
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index f29f0a6d5b..7beae85177 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -795,10 +795,10 @@ static int nbl_res_txrx_get_stats(void *priv, struct rte_eth_stats *rte_stats,
 		rxq_stats_reset = &rxq->rxq_stats_reset;
 		idx = rxq->queue_id;
 
-		if (qstats && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[idx] += rxq_stats->rx_packets -
+		if (qstats && idx < eth_dev->data->nb_rx_queues) {
+			qstats[idx].q_ipackets += rxq_stats->rx_packets -
 							rxq_stats_reset->rx_packets;
-			qstats->q_ibytes[idx] += rxq_stats->rx_bytes - rxq_stats_reset->rx_bytes;
+			qstats[idx].q_ibytes += rxq_stats->rx_bytes - rxq_stats_reset->rx_bytes;
 		}
 		rte_stats->ipackets += rxq_stats->rx_packets - rxq_stats_reset->rx_packets;
 		rte_stats->ibytes += rxq_stats->rx_bytes - rxq_stats_reset->rx_bytes;
@@ -814,10 +814,10 @@ static int nbl_res_txrx_get_stats(void *priv, struct rte_eth_stats *rte_stats,
 		txq_stats_reset = &txq->txq_stats_reset;
 		idx = txq->queue_id;
 
-		if (qstats && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[idx] += txq_stats->tx_packets -
+		if (qstats && idx < eth_dev->data->nb_tx_queues) {
+			qstats[idx].q_opackets += txq_stats->tx_packets -
 							txq_stats_reset->tx_packets;
-			qstats->q_obytes[idx] += txq_stats->tx_bytes - txq_stats_reset->tx_bytes;
+			qstats[idx].q_obytes += txq_stats->tx_bytes - txq_stats_reset->tx_bytes;
 		}
 		rte_stats->opackets += txq_stats->tx_packets - txq_stats_reset->tx_packets;
 		rte_stats->obytes += txq_stats->tx_bytes - txq_stats_reset->tx_bytes;
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 9a193e4a7a..e4fdf89873 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1122,9 +1122,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
 		stats->obytes += txq->stats.bytes;
 		stats->oerrors += txq->stats.errors;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] += txq->stats.packets;
-			qstats->q_obytes[i] += txq->stats.bytes;
+		if (qstats != NULL) {
+			qstats[i].q_opackets += txq->stats.packets;
+			qstats[i].q_obytes += txq->stats.bytes;
 		}
 	}
 
@@ -1139,9 +1139,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
 		stats->ierrors += rxq->stats.errors;
 		stats->imissed += rxq->stats.ring_full;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] += rxq->stats.packets;
-			qstats->q_ibytes[i] += rxq->stats.bytes;
+		if (qstats != NULL) {
+			qstats[i].q_ipackets += rxq->stats.packets;
+			qstats[i].q_ibytes += rxq->stats.bytes;
 		}
 	}
 
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 27c46ce404..96e811278a 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -927,7 +927,8 @@ int hn_vf_stats_get(struct rte_eth_dev *dev,
 		 * rte_eth_stats_get API because we need to forward the
 		 * per-queue stats (qstats) which the public API does not
 		 * support.  The caller (eth_stats_qstats_get) has already
-		 * zeroed stats and qstats before invoking this callback.
+		 * zeroed stats, and qstats is zeroed by its allocation,
+		 * before invoking this callback.
 		 */
 		if (vf_dev->dev_ops->stats_get != NULL)
 			ret = vf_dev->dev_ops->stats_get(vf_dev, stats,
diff --git a/drivers/net/nfb/nfb_stats.c b/drivers/net/nfb/nfb_stats.c
index f7a0189ffe..0b4bdc7d18 100644
--- a/drivers/net/nfb/nfb_stats.c
+++ b/drivers/net/nfb/nfb_stats.c
@@ -25,9 +25,9 @@ nfb_eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		if (rx_queue == NULL)
 			continue;
 
-		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rx_queue->rx_pkts;
-			qstats->q_ibytes[i] = rx_queue->rx_bytes;
+		if (qstats && i < dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = rx_queue->rx_pkts;
+			qstats[i].q_ibytes = rx_queue->rx_bytes;
 		}
 	}
 
@@ -36,9 +36,9 @@ nfb_eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		if (tx_queue == NULL)
 			continue;
 
-		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = tx_queue->tx_pkts;
-			qstats->q_obytes[i] = tx_queue->tx_bytes;
+		if (qstats && i < dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = tx_queue->tx_pkts;
+			qstats[i].q_obytes = tx_queue->tx_bytes;
 		}
 	}
 
diff --git a/drivers/net/nfp/flower/nfp_flower.c b/drivers/net/nfp/flower/nfp_flower.c
index 4eeb9aee3b..14a8992376 100644
--- a/drivers/net/nfp/flower/nfp_flower.c
+++ b/drivers/net/nfp/flower/nfp_flower.c
@@ -238,8 +238,8 @@ nfp_flower_multiple_pf_recv_pkts(void *rx_queue,
 		for (i = 0; i < recv; i++)
 			data_len += rx_pkts[i]->data_len;
 
-		repr->repr_qstats.q_ipackets[rxq->qidx] += recv;
-		repr->repr_qstats.q_ibytes[rxq->qidx] += data_len;
+		repr->repr_qstats[rxq->qidx].q_ipackets += recv;
+		repr->repr_qstats[rxq->qidx].q_ibytes += data_len;
 	}
 
 	return recv;
@@ -276,8 +276,8 @@ nfp_flower_multiple_pf_xmit_pkts(void *tx_queue,
 		for (i = 0; i < sent; i++)
 			data_len += tx_pkts[i]->data_len;
 
-		repr->repr_qstats.q_opackets[txq->qidx] += sent;
-		repr->repr_qstats.q_obytes[txq->qidx] += data_len;
+		repr->repr_qstats[txq->qidx].q_opackets += sent;
+		repr->repr_qstats[txq->qidx].q_obytes += data_len;
 	}
 
 	return sent;
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c b/drivers/net/nfp/flower/nfp_flower_representor.c
index 9b984dbc8d..231a76980d 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.c
+++ b/drivers/net/nfp/flower/nfp_flower_representor.c
@@ -324,15 +324,15 @@ nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,
 	repr->repr_stats.ipackets = 0;
 	repr->repr_stats.ibytes = 0;
 	for (i = 0; i < ethdev->data->nb_rx_queues; i++) {
-		repr->repr_stats.ipackets += repr->repr_qstats.q_ipackets[i];
-		repr->repr_stats.ibytes += repr->repr_qstats.q_ibytes[i];
+		repr->repr_stats.ipackets += repr->repr_qstats[i].q_ipackets;
+		repr->repr_stats.ibytes += repr->repr_qstats[i].q_ibytes;
 	}
 
 	repr->repr_stats.opackets = 0;
 	repr->repr_stats.obytes = 0;
 	for (i = 0; i < ethdev->data->nb_tx_queues; i++) {
-		repr->repr_stats.opackets += repr->repr_qstats.q_opackets[i];
-		repr->repr_stats.obytes += repr->repr_qstats.q_obytes[i];
+		repr->repr_stats.opackets += repr->repr_qstats[i].q_opackets;
+		repr->repr_stats.obytes += repr->repr_qstats[i].q_obytes;
 	}
 
 	*stats = repr->repr_stats;
@@ -347,7 +347,8 @@ nfp_flower_repr_stats_reset(struct rte_eth_dev *ethdev)
 
 	repr = ethdev->data->dev_private;
 	memset(&repr->repr_stats, 0, sizeof(struct rte_eth_stats));
-	memset(&repr->repr_qstats, 0, sizeof(struct eth_queue_stats));
+	memset(repr->repr_qstats, 0,
+			sizeof(struct eth_queue_stats) * repr->repr_nb_qstats);
 
 	return 0;
 }
@@ -403,8 +404,8 @@ nfp_flower_repr_rx_burst(void *rx_queue,
 		for (i = 0; i < total_dequeue; i++)
 			data_len += rx_pkts[i]->data_len;
 
-		repr->repr_qstats.q_ipackets[rxq->qidx] += total_dequeue;
-		repr->repr_qstats.q_ibytes[rxq->qidx] += data_len;
+		repr->repr_qstats[rxq->qidx].q_ipackets += total_dequeue;
+		repr->repr_qstats[rxq->qidx].q_ibytes += data_len;
 	}
 
 	return total_dequeue;
@@ -451,8 +452,8 @@ nfp_flower_repr_tx_burst(void *tx_queue,
 		for (i = 0; i < sent; i++)
 			data_len += tx_pkts[i]->data_len;
 
-		repr->repr_qstats.q_opackets[txq->qidx] += sent;
-		repr->repr_qstats.q_obytes[txq->qidx] += data_len;
+		repr->repr_qstats[txq->qidx].q_opackets += sent;
+		repr->repr_qstats[txq->qidx].q_obytes += data_len;
 	}
 
 	return sent;
@@ -528,6 +529,7 @@ nfp_flower_repr_uninit(struct rte_eth_dev *eth_dev)
 
 	repr = eth_dev->data->dev_private;
 	nfp_flower_repr_base_uninit(repr);
+	rte_free(repr->repr_qstats);
 	rte_free(repr->ring);
 
 	if (nfp_flower_repr_is_phy(repr)) {
@@ -893,6 +895,17 @@ nfp_flower_repr_init(struct rte_eth_dev *eth_dev,
 		return -ENOMEM;
 	}
 
+	repr->repr_nb_qstats = RTE_MAX(app_fw_flower->pf_hw->max_rx_queues,
+			app_fw_flower->pf_hw->max_tx_queues);
+	repr->repr_qstats = rte_zmalloc_socket("nfp_repr_qstats",
+			sizeof(struct eth_queue_stats) * repr->repr_nb_qstats,
+			RTE_CACHE_LINE_SIZE, numa_node);
+	if (repr->repr_qstats == NULL) {
+		PMD_DRV_LOG(ERR, "Queue stats alloc failed for %s.", ring_name);
+		rte_free(repr->ring);
+		return -ENOMEM;
+	}
+
 	eth_dev->dev_ops = &nfp_flower_repr_dev_ops;
 	eth_dev->rx_pkt_burst = nfp_flower_repr_rx_burst;
 	eth_dev->tx_pkt_burst = nfp_flower_repr_tx_burst;
@@ -928,6 +941,7 @@ nfp_flower_repr_init(struct rte_eth_dev *eth_dev,
 	return 0;
 
 ring_cleanup:
+	rte_free(repr->repr_qstats);
 	rte_free(repr->ring);
 
 	return ret;
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.h b/drivers/net/nfp/flower/nfp_flower_representor.h
index 66714d9a51..74e09749f6 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.h
+++ b/drivers/net/nfp/flower/nfp_flower_representor.h
@@ -22,7 +22,9 @@ struct nfp_flower_representor {
 	struct rte_ring **ring;
 	struct rte_eth_link link;
 	struct rte_eth_stats repr_stats;
-	struct eth_queue_stats repr_qstats;
+	/** Per-queue counters, one entry per queue */
+	struct eth_queue_stats *repr_qstats;
+	uint16_t repr_nb_qstats;
 
 	struct rte_eth_xstat *repr_xstats_base;
 	uint8_t *mac_stats;
diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
index d2da18013c..2f7ce812e4 100644
--- a/drivers/net/nfp/nfp_ethdev.c
+++ b/drivers/net/nfp/nfp_ethdev.c
@@ -663,6 +663,7 @@ nfp_net_uninit(struct rte_eth_dev *eth_dev)
 	if ((net_hw->super.cap_ext & NFP_NET_CFG_CTRL_FLOW_STEER) != 0)
 		nfp_net_flow_priv_uninit(hw_priv->pf_dev, net_hw->idx);
 
+	rte_free(net_hw->eth_qstats_base);
 	rte_free(net_hw->eth_xstats_base);
 	if ((net_hw->super.cap & NFP_NET_CFG_CTRL_TXRWB) != 0)
 		nfp_net_txrwb_free(eth_dev);
@@ -1091,6 +1092,17 @@ nfp_net_init(struct rte_eth_dev *eth_dev,
 		goto ipsec_exit;
 	}
 
+	net_hw->eth_qstats_base = rte_calloc("eth_queue_stats",
+			RTE_MAX(net_hw->max_rx_queues, net_hw->max_tx_queues),
+			sizeof(struct eth_queue_stats), 0);
+	if (net_hw->eth_qstats_base == NULL) {
+		PMD_INIT_LOG(ERR, "No memory for queue stats base values on device %s!",
+				pci_dev->device.name);
+		rte_free(net_hw->eth_xstats_base);
+		err = -ENOMEM;
+		goto ipsec_exit;
+	}
+
 	/* Work out where in the BAR the queues start. */
 	tx_base = nn_cfg_readl(hw, NFP_NET_CFG_START_TXQ);
 	rx_base = nn_cfg_readl(hw, NFP_NET_CFG_START_RXQ);
@@ -1183,6 +1195,7 @@ nfp_net_init(struct rte_eth_dev *eth_dev,
 	if ((hw->cap & NFP_NET_CFG_CTRL_TXRWB) != 0)
 		nfp_net_txrwb_free(eth_dev);
 xstats_free:
+	rte_free(net_hw->eth_qstats_base);
 	rte_free(net_hw->eth_xstats_base);
 ipsec_exit:
 	nfp_ipsec_uninit(eth_dev);
diff --git a/drivers/net/nfp/nfp_ethdev_vf.c b/drivers/net/nfp/nfp_ethdev_vf.c
index a86cc36592..d81a5052b9 100644
--- a/drivers/net/nfp/nfp_ethdev_vf.c
+++ b/drivers/net/nfp/nfp_ethdev_vf.c
@@ -172,6 +172,7 @@ nfp_netvf_close(struct rte_eth_dev *dev)
 	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	hw_priv = dev->process_private;
 
+	rte_free(net_hw->eth_qstats_base);
 	rte_free(net_hw->eth_xstats_base);
 	rte_free(hw_priv);
 
@@ -339,6 +340,17 @@ nfp_netvf_init(struct rte_eth_dev *eth_dev)
 		goto hw_priv_free;
 	}
 
+	net_hw->eth_qstats_base = rte_calloc("eth_queue_stats",
+			RTE_MAX(net_hw->max_rx_queues, net_hw->max_tx_queues),
+			sizeof(struct eth_queue_stats), 0);
+	if (net_hw->eth_qstats_base == NULL) {
+		PMD_INIT_LOG(ERR, "No memory for queue stats base values on device %s!",
+				pci_dev->device.name);
+		rte_free(net_hw->eth_xstats_base);
+		err = -ENOMEM;
+		goto hw_priv_free;
+	}
+
 	/* Work out where in the BAR the queues start. */
 	start_q = nn_cfg_readl(hw, NFP_NET_CFG_START_TXQ);
 	tx_bar_off = nfp_qcp_queue_offset(dev_info, start_q);
@@ -406,6 +418,7 @@ nfp_netvf_init(struct rte_eth_dev *eth_dev)
 	return 0;
 
 free_xstats:
+	rte_free(net_hw->eth_qstats_base);
 	rte_free(net_hw->eth_xstats_base);
 hw_priv_free:
 	rte_free(hw_priv);
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index 2d36311cfe..afa0bc0faf 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -919,35 +919,29 @@ nfp_net_stats_get(struct rte_eth_dev *dev,
 
 	/* Reading per RX ring stats */
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		if (i == RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			break;
-
 		uint64_t q_ipackets = nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i));
-		q_ipackets -= hw->eth_qstats_base.q_ipackets[i];
+		q_ipackets -= hw->eth_qstats_base[i].q_ipackets;
 
 		uint64_t q_ibytes = nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i) + 0x8);
-		q_ibytes -= hw->eth_qstats_base.q_ibytes[i];
+		q_ibytes -= hw->eth_qstats_base[i].q_ibytes;
 
 		if (qstats != NULL) {
-			qstats->q_ipackets[i] = q_ipackets;
-			qstats->q_ibytes[i] = q_ibytes;
+			qstats[i].q_ipackets = q_ipackets;
+			qstats[i].q_ibytes = q_ibytes;
 		}
 	}
 
 	/* Reading per TX ring stats */
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
-		if (i == RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			break;
-
 		uint64_t q_opackets = nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i));
-		q_opackets -= hw->eth_qstats_base.q_opackets[i];
+		q_opackets -= hw->eth_qstats_base[i].q_opackets;
 
 		uint64_t q_obytes = nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i) + 0x8);
-		q_obytes -= hw->eth_qstats_base.q_obytes[i];
+		q_obytes -= hw->eth_qstats_base[i].q_obytes;
 
 		if (qstats != NULL) {
-			qstats->q_opackets[i] = q_opackets;
-			qstats->q_obytes[i] = q_obytes;
+			qstats[i].q_opackets = q_opackets;
+			qstats[i].q_obytes = q_obytes;
 		}
 	}
 
@@ -999,25 +993,19 @@ nfp_net_stats_reset(struct rte_eth_dev *dev)
 
 	/* Reading per RX ring stats */
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		if (i == RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			break;
-
-		hw->eth_qstats_base.q_ipackets[i] =
+		hw->eth_qstats_base[i].q_ipackets =
 				nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i));
 
-		hw->eth_qstats_base.q_ibytes[i] =
+		hw->eth_qstats_base[i].q_ibytes =
 				nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i) + 0x8);
 	}
 
 	/* Reading per TX ring stats */
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
-		if (i == RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			break;
-
-		hw->eth_qstats_base.q_opackets[i] =
+		hw->eth_qstats_base[i].q_opackets =
 				nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i));
 
-		hw->eth_qstats_base.q_obytes[i] =
+		hw->eth_qstats_base[i].q_obytes =
 				nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i) + 0x8);
 	}
 
diff --git a/drivers/net/nfp/nfp_net_common.h b/drivers/net/nfp/nfp_net_common.h
index 2bd2d54028..51082c6d29 100644
--- a/drivers/net/nfp/nfp_net_common.h
+++ b/drivers/net/nfp/nfp_net_common.h
@@ -250,7 +250,8 @@ struct nfp_net_hw {
 
 	/** Records starting point for counters */
 	struct rte_eth_stats eth_stats_base;
-	struct eth_queue_stats eth_qstats_base;
+	/** Per-queue counters, one entry per queue */
+	struct eth_queue_stats *eth_qstats_base;
 	struct rte_eth_xstat *eth_xstats_base;
 
 	struct nfp_cpp_area *ctrl_area;
diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index 09bcd791ed..dc8e65ecc2 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -1498,10 +1498,8 @@ ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	struct ngbe_hw_stats *hw_stats = NGBE_DEV_STATS(dev);
-	struct ngbe_stat_mappings *stat_mappings =
-			NGBE_DEV_STAT_MAPPINGS(dev);
 	struct ngbe_tx_queue *txq;
-	uint32_t i, j;
+	uint32_t i;
 
 	ngbe_read_stats_registers(hw, hw_stats);
 
@@ -1515,29 +1513,13 @@ ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	stats->obytes = hw_stats->tx_bytes;
 
 	if (qstats != NULL) {
-		memset(&qstats->q_ipackets, 0, sizeof(qstats->q_ipackets));
-		memset(&qstats->q_opackets, 0, sizeof(qstats->q_opackets));
-		memset(&qstats->q_ibytes, 0, sizeof(qstats->q_ibytes));
-		memset(&qstats->q_obytes, 0, sizeof(qstats->q_obytes));
-		memset(&qstats->q_errors, 0, sizeof(qstats->q_errors));
-		for (i = 0; i < NGBE_MAX_QP; i++) {
-			uint32_t n = i / NB_QMAP_FIELDS_PER_QSM_REG;
-			uint32_t offset = (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;
-			uint32_t q_map;
-
-			q_map = (stat_mappings->rqsm[n] >> offset)
-					& QMAP_FIELD_RESERVED_BITS_MASK;
-			j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-			     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-			qstats->q_ipackets[j] += hw_stats->qp[i].rx_qp_packets;
-			qstats->q_ibytes[j] += hw_stats->qp[i].rx_qp_bytes;
-
-			q_map = (stat_mappings->tqsm[n] >> offset)
-					& QMAP_FIELD_RESERVED_BITS_MASK;
-			j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-			     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-			qstats->q_opackets[j] += hw_stats->qp[i].tx_qp_packets;
-			qstats->q_obytes[j] += hw_stats->qp[i].tx_qp_bytes;
+		for (i = 0; i < NGBE_MAX_QP && i < dev->data->nb_rx_queues; i++) {
+			qstats[i].q_ipackets += hw_stats->qp[i].rx_qp_packets;
+			qstats[i].q_ibytes += hw_stats->qp[i].rx_qp_bytes;
+		}
+		for (i = 0; i < NGBE_MAX_QP && i < dev->data->nb_tx_queues; i++) {
+			qstats[i].q_opackets += hw_stats->qp[i].tx_qp_packets;
+			qstats[i].q_obytes += hw_stats->qp[i].tx_qp_bytes;
 		}
 	}
 
diff --git a/drivers/net/ngbe/ngbe_ethdev.h b/drivers/net/ngbe/ngbe_ethdev.h
index 4f8dcff00e..12ee884ce1 100644
--- a/drivers/net/ngbe/ngbe_ethdev.h
+++ b/drivers/net/ngbe/ngbe_ethdev.h
@@ -61,14 +61,6 @@ struct ngbe_interrupt {
 	uint64_t mask_orig; /* save mask during delayed handler */
 };
 
-#define NGBE_NB_STAT_MAPPING  32
-#define NB_QMAP_FIELDS_PER_QSM_REG 4
-#define QMAP_FIELD_RESERVED_BITS_MASK 0x0f
-struct ngbe_stat_mappings {
-	uint32_t tqsm[NGBE_NB_STAT_MAPPING];
-	uint32_t rqsm[NGBE_NB_STAT_MAPPING];
-};
-
 struct ngbe_vfta {
 	uint32_t vfta[NGBE_VFTA_SIZE];
 };
@@ -127,7 +119,6 @@ struct ngbe_adapter {
 	struct ngbe_hw             hw;
 	struct ngbe_hw_stats       stats;
 	struct ngbe_interrupt      intr;
-	struct ngbe_stat_mappings  stat_mappings;
 	struct ngbe_vfta           shadow_vfta;
 	struct ngbe_hwstrip        hwstrip;
 	struct ngbe_vf_info        *vfdata;
@@ -171,9 +162,6 @@ ngbe_dev_intr(struct rte_eth_dev *dev)
 	return intr;
 }
 
-#define NGBE_DEV_STAT_MAPPINGS(dev) \
-	(&((struct ngbe_adapter *)(dev)->data->dev_private)->stat_mappings)
-
 #define NGBE_DEV_VFTA(dev) \
 	(&((struct ngbe_adapter *)(dev)->data->dev_private)->shadow_vfta)
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index bee34d20d7..effaf7cade 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -197,18 +197,18 @@ static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_st
 	ntnic_filter_ops->poll_statistics(internals);
 
 	for (i = 0; i < internals->nb_rx_queues; i++) {
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = internals->rxq_scg[i].rx_pkts;
-			qstats->q_ibytes[i] = internals->rxq_scg[i].rx_bytes;
+		if (qstats != NULL) {
+			qstats[i].q_ipackets = internals->rxq_scg[i].rx_pkts;
+			qstats[i].q_ibytes = internals->rxq_scg[i].rx_bytes;
 		}
 		rx_total += internals->rxq_scg[i].rx_pkts;
 		rx_total_b += internals->rxq_scg[i].rx_bytes;
 	}
 
 	for (i = 0; i < internals->nb_tx_queues; i++) {
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = internals->txq_scg[i].tx_pkts;
-			qstats->q_obytes[i] = internals->txq_scg[i].tx_bytes;
+		if (qstats != NULL) {
+			qstats[i].q_opackets = internals->txq_scg[i].tx_pkts;
+			qstats[i].q_obytes = internals->txq_scg[i].tx_bytes;
 		}
 		tx_total += internals->txq_scg[i].tx_pkts;
 		tx_total_b += internals->txq_scg[i].tx_bytes;
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 7fba3a661b..a469825cb6 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -332,9 +332,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->ipackets += pkts;
 		stats->ibytes += bytes;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = pkts;
-			qstats->q_ibytes[i] = bytes;
+		if (qstats != NULL && i < dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = pkts;
+			qstats[i].q_ibytes = bytes;
 		}
 	}
 
@@ -348,9 +348,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->opackets += pkts;
 		stats->obytes += bytes;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = pkts;
-			qstats->q_obytes[i] = bytes;
+		if (qstats != NULL && i < dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = pkts;
+			qstats[i].q_obytes = bytes;
 		}
 	}
 
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index 876d2f9d7d..85b3c09155 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -626,9 +626,9 @@ otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,
 
 	for (i = 0; i < otx_epvf->nb_tx_queues; i++) {
 		ostats = &otx_epvf->instr_queue[i]->stats;
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = ostats->tx_pkts;
-			qstats->q_obytes[i] = ostats->tx_bytes;
+		if (qstats != NULL && i < eth_dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = ostats->tx_pkts;
+			qstats[i].q_obytes = ostats->tx_bytes;
 		}
 		stats->opackets += ostats->tx_pkts;
 		stats->obytes += ostats->tx_bytes;
@@ -636,10 +636,9 @@ otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,
 	}
 	for (i = 0; i < otx_epvf->nb_rx_queues; i++) {
 		istats = &otx_epvf->droq[i]->stats;
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = istats->pkts_received;
-			qstats->q_ibytes[i] = istats->bytes_received;
-			qstats->q_errors[i] = istats->rx_err;
+		if (qstats != NULL && i < eth_dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = istats->pkts_received;
+			qstats[i].q_ibytes = istats->bytes_received;
 		}
 		stats->ipackets += istats->pkts_received;
 		stats->ibytes += istats->bytes_received;
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 08d3ab9e91..b1f3718c8a 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1075,11 +1075,10 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	unsigned long tx_packets_err_total = 0;
 	const struct pmd_internals *internal = dev->data->dev_private;
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-			i < dev->data->nb_rx_queues; i++) {
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		if (qstats != NULL) {
-			qstats->q_ipackets[i] = internal->rx_queue[i].rx_stat.pkts;
-			qstats->q_ibytes[i] = internal->rx_queue[i].rx_stat.bytes;
+			qstats[i].q_ipackets = internal->rx_queue[i].rx_stat.pkts;
+			qstats[i].q_ibytes = internal->rx_queue[i].rx_stat.bytes;
 		}
 		rx_nombuf_total += internal->rx_queue[i].rx_stat.rx_nombuf;
 		rx_err_total += internal->rx_queue[i].rx_stat.err_pkts;
@@ -1088,11 +1087,10 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		rx_missed_total += queue_missed_stat_get(dev, i);
 	}
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-			i < dev->data->nb_tx_queues; i++) {
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		if (qstats != NULL) {
-			qstats->q_opackets[i] = internal->tx_queue[i].tx_stat.pkts;
-			qstats->q_obytes[i] = internal->tx_queue[i].tx_stat.bytes;
+			qstats[i].q_opackets = internal->tx_queue[i].tx_stat.pkts;
+			qstats[i].q_obytes = internal->tx_queue[i].tx_stat.bytes;
 		}
 		tx_packets_total += internal->tx_queue[i].tx_stat.pkts;
 		tx_bytes_total += internal->tx_queue[i].tx_stat.bytes;
diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index 4efc2dd349..b5bbcd6625 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -397,10 +397,8 @@ static void qede_reset_queue_stats(struct qede_dev *qdev, bool xstats)
 
 	DP_VERBOSE(edev, ECORE_MSG_DEBUG, "Clearing queue stats\n");
 
-	rxq_stat_cntrs = RTE_MIN(QEDE_RSS_COUNT(dev),
-			       RTE_ETHDEV_QUEUE_STAT_CNTRS);
-	txq_stat_cntrs = RTE_MIN(QEDE_TSS_COUNT(dev),
-			       RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	rxq_stat_cntrs = QEDE_RSS_COUNT(dev);
+	txq_stat_cntrs = QEDE_TSS_COUNT(dev);
 
 	for (qid = 0; qid < qdev->num_rx_queues; qid++) {
 		OSAL_MEMSET(((char *)(qdev->fp_array[qid].rxq)) +
@@ -1634,20 +1632,11 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stats,
 	eth_stats->oerrors = stats.common.tx_err_drop_pkts;
 
 	/* Queue stats */
-	rxq_stat_cntrs = RTE_MIN(QEDE_RSS_COUNT(eth_dev),
-			       RTE_ETHDEV_QUEUE_STAT_CNTRS);
-	txq_stat_cntrs = RTE_MIN(QEDE_TSS_COUNT(eth_dev),
-			       RTE_ETHDEV_QUEUE_STAT_CNTRS);
-	if (rxq_stat_cntrs != (unsigned int)QEDE_RSS_COUNT(eth_dev) ||
-	    txq_stat_cntrs != (unsigned int)QEDE_TSS_COUNT(eth_dev))
-		DP_VERBOSE(edev, ECORE_MSG_DEBUG,
-		       "Not all the queue stats will be displayed. Set"
-		       " RTE_ETHDEV_QUEUE_STAT_CNTRS config param"
-		       " appropriately and retry.\n");
+	rxq_stat_cntrs = QEDE_RSS_COUNT(eth_dev);
+	txq_stat_cntrs = QEDE_TSS_COUNT(eth_dev);
 
 	for (qid = 0; qid < eth_dev->data->nb_rx_queues; qid++) {
 		uint64_t q_ipackets = 0;
-		uint64_t q_errors = 0;
 
 		for_each_hwfn(edev, hw_fn) {
 			idx = qid * edev->num_hwfns + hw_fn;
@@ -1657,21 +1646,10 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stats,
 					(((char *)(qdev->fp_array[idx].rxq)) +
 					 offsetof(struct qede_rx_queue,
 					 rcv_pkts));
-			q_errors +=
-				*(uint64_t *)
-					(((char *)(qdev->fp_array[idx].rxq)) +
-					 offsetof(struct qede_rx_queue,
-					 rx_hw_errors)) +
-				*(uint64_t *)
-					(((char *)(qdev->fp_array[idx].rxq)) +
-					 offsetof(struct qede_rx_queue,
-					 rx_alloc_errors));
 		}
 
-		if (qstats != NULL) {
-			qstats->q_ipackets[i] = q_ipackets;
-			qstats->q_errors[i] = q_errors;
-		}
+		if (qstats != NULL)
+			qstats[i].q_ipackets = q_ipackets;
 
 		i++;
 		if (i == rxq_stat_cntrs)
@@ -1693,7 +1671,7 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stats,
 		}
 
 		if (qstats != NULL)
-			qstats->q_opackets[j] = q_opackets;
+			qstats[j].q_opackets = q_opackets;
 
 		j++;
 		if (j == txq_stat_cntrs)
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b639544eab..2ba9b66b41 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -203,17 +203,15 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	unsigned long rx_total = 0, tx_total = 0;
 	const struct pmd_internals *internal = dev->data->dev_private;
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-			i < dev->data->nb_rx_queues; i++) {
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		if (qstats != NULL)
-			qstats->q_ipackets[i] = internal->rx_ring_queues[i].rx_pkts;
+			qstats[i].q_ipackets = internal->rx_ring_queues[i].rx_pkts;
 		rx_total += internal->rx_ring_queues[i].rx_pkts;
 	}
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-			i < dev->data->nb_tx_queues; i++) {
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		if (qstats != NULL)
-			qstats->q_opackets[i] = internal->tx_ring_queues[i].tx_pkts;
+			qstats[i].q_opackets = internal->tx_ring_queues[i].tx_pkts;
 		tx_total += internal->tx_ring_queues[i].tx_pkts;
 	}
 
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index e48ad0e317..125134f8d4 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1252,9 +1252,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
 			continue;
 		stats->ipackets += rxq->stats.ipackets;
 		stats->ibytes += rxq->stats.ibytes;
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rxq->stats.ipackets;
-			qstats->q_ibytes[i] = rxq->stats.ibytes;
+		if (qstats != NULL && i < dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = rxq->stats.ipackets;
+			qstats[i].q_ibytes = rxq->stats.ibytes;
 		}
 	}
 
@@ -1266,9 +1266,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
 		stats->opackets += txq->stats.opackets;
 		stats->obytes += txq->stats.obytes;
 		stats->oerrors += txq->stats.errors;
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = txq->stats.opackets;
-			qstats->q_obytes[i] = txq->stats.obytes;
+		if (qstats != NULL && i < dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = txq->stats.opackets;
+			qstats[i].q_obytes = txq->stats.obytes;
 		}
 	}
 	stats->imissed = eth_stats->rx_trans_drop + eth_stats->rx_trunc_drop;
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 050488301c..130e0fa11b 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -1577,15 +1577,11 @@ int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter, struct eth_
 	struct sxe2_drv_cmd_params param = {0};
 	struct sxe2_queue_map_info resp = {0};
 	struct sxe2_common_device *cdev = adapter->cdev;
+	struct rte_eth_dev_data *dev_data = adapter->dev_info.dev_data;
 	uint8_t pool_idx;
 	uint8_t index;
 	int32_t ret;
 
-	if (!(adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_Q_MAP)) {
-		ret = 0;
-		goto l_end;
-	}
-
 	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_TX_RX_MAP_GET,
 				 NULL, 0,
 				 &resp, sizeof(resp));
@@ -1595,14 +1591,16 @@ int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter, struct eth_
 		goto l_end;
 	}
 
-	for (pool_idx = 0; pool_idx < SXE2_RXQ_STATS_MAP_MAX_NUM; pool_idx++) {
-		qstats->q_ipackets[pool_idx] = resp.rxq_stats_map_info[pool_idx].rxq_lan_in_pkt_cnt;
-		qstats->q_ibytes[pool_idx] = resp.rxq_stats_map_info[pool_idx].rxq_lan_in_byte_cnt;
+	for (pool_idx = 0; pool_idx < SXE2_RXQ_STATS_MAP_MAX_NUM &&
+			pool_idx < dev_data->nb_rx_queues; pool_idx++) {
+		qstats[pool_idx].q_ipackets = resp.rxq_stats_map_info[pool_idx].rxq_lan_in_pkt_cnt;
+		qstats[pool_idx].q_ibytes = resp.rxq_stats_map_info[pool_idx].rxq_lan_in_byte_cnt;
 	}
 
-	for (index = 0; index < SXE2_TXQ_STATS_MAP_MAX_NUM; index++) {
-		qstats->q_opackets[index] = resp.txq_stats_map_info[index].txq_lan_pkt_cnt;
-		qstats->q_obytes[index] = resp.txq_stats_map_info[index].txq_lan_byte_cnt;
+	for (index = 0; index < SXE2_TXQ_STATS_MAP_MAX_NUM &&
+			index < dev_data->nb_tx_queues; index++) {
+		qstats[index].q_opackets = resp.txq_stats_map_info[index].txq_lan_pkt_cnt;
+		qstats[index].q_obytes = resp.txq_stats_map_info[index].txq_lan_byte_cnt;
 	}
 
 l_end:
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index b93452f168..3d381a47a9 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1004,9 +1004,9 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 
 		if (rxq == NULL)
 			continue;
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rxq->stats.packets;
-			qstats->q_ibytes[i] = rxq->stats.bytes;
+		if (qstats != NULL && i < dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = rxq->stats.packets;
+			qstats[i].q_ibytes = rxq->stats.bytes;
 		}
 		rx_total += rxq->stats.packets;
 		rx_bytes_total += rxq->stats.bytes;
@@ -1019,9 +1019,9 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 
 		if (txq == NULL)
 			continue;
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = txq->stats.packets;
-			qstats->q_obytes[i] = txq->stats.bytes;
+		if (qstats != NULL && i < dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = txq->stats.packets;
+			qstats[i].q_obytes = txq->stats.bytes;
 		}
 		tx_total += txq->stats.packets;
 		tx_bytes_total += txq->stats.bytes;
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 6e34da7c3c..30d03f4db9 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -306,13 +306,13 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 
 	/* Reading per RX ring stats */
 	for (qidx = rx_start; qidx <= rx_end; qidx++) {
-		if (qidx >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
+		if (qidx >= dev->data->nb_rx_queues)
 			break;
 
 		nicvf_hw_get_rx_qstats(nic, &rx_qstats, qidx);
 		if (qstats != NULL) {
-			qstats->q_ibytes[qidx] = rx_qstats.q_rx_bytes;
-			qstats->q_ipackets[qidx] = rx_qstats.q_rx_packets;
+			qstats[qidx].q_ibytes = rx_qstats.q_rx_bytes;
+			qstats[qidx].q_ipackets = rx_qstats.q_rx_packets;
 		}
 	}
 
@@ -321,13 +321,13 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 
 	/* Reading per TX ring stats */
 	for (qidx = tx_start; qidx <= tx_end; qidx++) {
-		if (qidx >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
+		if (qidx >= dev->data->nb_tx_queues)
 			break;
 
 		nicvf_hw_get_tx_qstats(nic, &tx_qstats, qidx);
 		if (qstats != NULL) {
-			qstats->q_obytes[qidx] = tx_qstats.q_tx_bytes;
-			qstats->q_opackets[qidx] = tx_qstats.q_tx_packets;
+			qstats[qidx].q_obytes = tx_qstats.q_tx_bytes;
+			qstats[qidx].q_opackets = tx_qstats.q_tx_packets;
 		}
 	}
 
@@ -342,14 +342,14 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 
 		/* Reading per RX ring stats */
 		for (qidx = rx_start; qidx <= rx_end; qidx++) {
-			if (qidx >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
+			if (qidx >= dev->data->nb_rx_queues)
 				break;
 
 			nicvf_hw_get_rx_qstats(snic, &rx_qstats,
 					       qidx % MAX_RCV_QUEUES_PER_QS);
 			if (qstats != NULL) {
-				qstats->q_ibytes[qidx] = rx_qstats.q_rx_bytes;
-				qstats->q_ipackets[qidx] = rx_qstats.q_rx_packets;
+				qstats[qidx].q_ibytes = rx_qstats.q_rx_bytes;
+				qstats[qidx].q_ipackets = rx_qstats.q_rx_packets;
 			}
 		}
 
@@ -357,14 +357,14 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		nicvf_tx_range(dev, snic, &tx_start, &tx_end);
 		/* Reading per TX ring stats */
 		for (qidx = tx_start; qidx <= tx_end; qidx++) {
-			if (qidx >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
+			if (qidx >= dev->data->nb_tx_queues)
 				break;
 
 			nicvf_hw_get_tx_qstats(snic, &tx_qstats,
 					       qidx % MAX_SND_QUEUES_PER_QS);
 			if (qstats != NULL) {
-				qstats->q_obytes[qidx] = tx_qstats.q_tx_bytes;
-				qstats->q_opackets[qidx] = tx_qstats.q_tx_packets;
+				qstats[qidx].q_obytes = tx_qstats.q_tx_bytes;
+				qstats[qidx].q_opackets = tx_qstats.q_tx_packets;
 			}
 		}
 	}
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 6349aca90f..5eae613d32 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2452,13 +2452,13 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	stats->obytes = hw_stats->tx_bytes;
 
 	if (qstats != NULL) {
-		for (i = 0; i < TXGBE_MAX_QP; i++) {
-			if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
-				break;
-			qstats->q_ipackets[i] += hw_stats->qp[i].rx_qp_packets;
-			qstats->q_ibytes[i] += hw_stats->qp[i].rx_qp_bytes;
-			qstats->q_opackets[i] += hw_stats->qp[i].tx_qp_packets;
-			qstats->q_obytes[i] += hw_stats->qp[i].tx_qp_bytes;
+		for (i = 0; i < TXGBE_MAX_QP && i < dev->data->nb_rx_queues; i++) {
+			qstats[i].q_ipackets += hw_stats->qp[i].rx_qp_packets;
+			qstats[i].q_ibytes += hw_stats->qp[i].rx_qp_bytes;
+		}
+		for (i = 0; i < TXGBE_MAX_QP && i < dev->data->nb_tx_queues; i++) {
+			qstats[i].q_opackets += hw_stats->qp[i].tx_qp_packets;
+			qstats[i].q_obytes += hw_stats->qp[i].tx_qp_bytes;
 		}
 	}
 
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 05940f2461..f2dfae7175 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1319,27 +1319,25 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	unsigned long tx_total_errors = 0;
 	struct vhost_queue *vq;
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-			i < dev->data->nb_rx_queues; i++) {
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		if (dev->data->rx_queues[i] == NULL)
 			continue;
 		vq = dev->data->rx_queues[i];
 		if (qstats != NULL) {
-			qstats->q_ipackets[i] = vq->stats.pkts;
-			qstats->q_ibytes[i] = vq->stats.bytes;
+			qstats[i].q_ipackets = vq->stats.pkts;
+			qstats[i].q_ibytes = vq->stats.bytes;
 		}
 		rx_total += vq->stats.pkts;
 		rx_total_bytes += vq->stats.bytes;
 	}
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-			i < dev->data->nb_tx_queues; i++) {
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		if (dev->data->tx_queues[i] == NULL)
 			continue;
 		vq = dev->data->tx_queues[i];
 		if (qstats != NULL) {
-			qstats->q_opackets[i] = vq->stats.pkts;
-			qstats->q_obytes[i] = vq->stats.bytes;
+			qstats[i].q_opackets = vq->stats.pkts;
+			qstats[i].q_obytes = vq->stats.bytes;
 		}
 		tx_total += vq->stats.pkts;
 		tx_total_bytes += vq->stats.bytes;
diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index 0b2574bd02..a6fe4f3023 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -701,9 +701,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->opackets += txvq->stats.packets;
 		stats->obytes += txvq->stats.bytes;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = txvq->stats.packets;
-			qstats->q_obytes[i] = txvq->stats.bytes;
+		if (qstats != NULL && i < dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = txvq->stats.packets;
+			qstats[i].q_obytes = txvq->stats.bytes;
 		}
 	}
 
@@ -716,9 +716,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->ibytes += rxvq->stats.bytes;
 		stats->ierrors += rxvq->stats.errors;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rxvq->stats.packets;
-			qstats->q_ibytes[i] = rxvq->stats.bytes;
+		if (qstats != NULL && i < dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = rxvq->stats.packets;
+			qstats[i].q_ibytes = rxvq->stats.bytes;
 		}
 	}
 
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index b7cf217724..4a7c76cfef 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -1504,9 +1504,9 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->obytes += bytes;
 		stats->oerrors += txStats.pktsTxError + txStats.pktsTxDiscard;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = packets;
-			qstats->q_obytes[i] = bytes;
+		if (qstats != NULL && i < dev->data->nb_tx_queues) {
+			qstats[i].q_opackets = packets;
+			qstats[i].q_obytes = bytes;
 		}
 	}
 
@@ -1526,10 +1526,9 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		stats->ierrors += rxStats.pktsRxError;
 		stats->imissed += rxStats.pktsRxOutOfBuf;
 
-		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = packets;
-			qstats->q_ibytes[i] = bytes;
-			qstats->q_errors[i] = rxStats.pktsRxError;
+		if (qstats != NULL && i < dev->data->nb_rx_queues) {
+			qstats[i].q_ipackets = packets;
+			qstats[i].q_ibytes = bytes;
 		}
 	}
 
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 505f973d66..5fbe68782e 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -593,11 +593,9 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			continue;
 
 		idx = rxq->idx;
-		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[idx] += rxq->stats.rx_pkts;
-			qstats->q_ibytes[idx] += rxq->stats.rx_bytes;
-			qstats->q_errors[idx] += rxq->stats.rx_errors +
-						rxq->stats.rx_nombuf;
+		if (qstats != NULL && idx < dev->data->nb_rx_queues) {
+			qstats[idx].q_ipackets += rxq->stats.rx_pkts;
+			qstats[idx].q_ibytes += rxq->stats.rx_bytes;
 		}
 		stats->ipackets += rxq->stats.rx_pkts;
 		stats->ibytes += rxq->stats.rx_bytes;
@@ -611,9 +609,9 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			continue;
 
 		idx = txq->idx;
-		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[idx] += txq->stats.tx_pkts;
-			qstats->q_obytes[idx] += txq->stats.tx_bytes;
+		if (qstats != NULL && idx < dev->data->nb_tx_queues) {
+			qstats[idx].q_opackets += txq->stats.tx_pkts;
+			qstats[idx].q_obytes += txq->stats.tx_bytes;
 		}
 		stats->opackets += txq->stats.tx_pkts;
 		stats->obytes += txq->stats.tx_bytes;
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
index 50247116d9..489ef76269 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.c
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
@@ -1824,37 +1824,29 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	}
 
 	stats->rx_nombuf = dev->data->rx_mbuf_alloc_failed;
-	for (i = 0; (i < dev->data->nb_rx_queues) && (i < RTE_ETHDEV_QUEUE_STAT_CNTRS); i++) {
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		struct zxdh_virtnet_rx *rxvq = dev->data->rx_queues[i];
 
 		if (rxvq == NULL)
 			continue;
 		if (qstats != NULL) {
-			qstats->q_ipackets[i] = *(uint64_t *)(((char *)rxvq) +
+			qstats[i].q_ipackets = *(uint64_t *)(((char *)rxvq) +
 					zxdh_rxq_stat_strings[0].offset);
-			qstats->q_ibytes[i] = *(uint64_t *)(((char *)rxvq) +
+			qstats[i].q_ibytes = *(uint64_t *)(((char *)rxvq) +
 					zxdh_rxq_stat_strings[1].offset);
-			qstats->q_errors[i] = *(uint64_t *)(((char *)rxvq) +
-					zxdh_rxq_stat_strings[2].offset);
-			qstats->q_errors[i] += *(uint64_t *)(((char *)rxvq) +
-					zxdh_rxq_stat_strings[5].offset);
 		}
 	}
 
-	for (i = 0; (i < dev->data->nb_tx_queues) && (i < RTE_ETHDEV_QUEUE_STAT_CNTRS); i++) {
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		struct zxdh_virtnet_tx *txvq = dev->data->tx_queues[i];
 
 		if (txvq == NULL)
 			continue;
 		if (qstats != NULL) {
-			qstats->q_opackets[i] = *(uint64_t *)(((char *)txvq) +
+			qstats[i].q_opackets = *(uint64_t *)(((char *)txvq) +
 					zxdh_txq_stat_strings[0].offset);
-			qstats->q_obytes[i] = *(uint64_t *)(((char *)txvq) +
+			qstats[i].q_obytes = *(uint64_t *)(((char *)txvq) +
 					zxdh_txq_stat_strings[1].offset);
-			qstats->q_errors[i] += *(uint64_t *)(((char *)txvq) +
-					zxdh_txq_stat_strings[2].offset);
-			qstats->q_errors[i] += *(uint64_t *)(((char *)txvq) +
-					zxdh_txq_stat_strings[5].offset);
 		}
 	}
 	return 0;
@@ -2002,13 +1994,13 @@ int zxdh_dev_stats_reset(struct rte_eth_dev *dev)
 	if (hw->is_pf)
 		zxdh_hw_stats_reset(dev, ZXDH_MAC_STATS_RESET);
 	zxdh_np_stats_reset(dev);
-	for (i = 0; ((i < dev->data->nb_rx_queues) && (i < RTE_ETHDEV_QUEUE_STAT_CNTRS)); i++) {
+	for (i = 0; (i < dev->data->nb_rx_queues); i++) {
 		struct zxdh_virtnet_rx *rxvq = dev->data->rx_queues[i];
 		if (rxvq == NULL)
 			continue;
 		memset(&rxvq->stats, 0, sizeof(struct zxdh_virtnet_stats));
 	}
-	for (i = 0; ((i < dev->data->nb_tx_queues) && (i < RTE_ETHDEV_QUEUE_STAT_CNTRS)); i++) {
+	for (i = 0; (i < dev->data->nb_tx_queues); i++) {
 		struct zxdh_virtnet_tx *txvq = dev->data->tx_queues[i];
 		if (txvq == NULL)
 			continue;
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0477579cc3..041ba6851e 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -24,25 +24,16 @@
 extern "C" {
 #endif
 
-#define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
-
 /**
  * @internal
- * Structure used to pass queue stats back to ethdev
- * for drivers which rely on ethdev to add the queue stats automatically to xstats.
+ * Per-queue counters added to xstats by ethdev.
+ * The array is allocated and zeroed by ethdev, with one entry per queue.
  */
 struct eth_queue_stats {
-	/* Queue stats are limited to max 256 queues. */
-	/** Total number of queue Rx packets. */
-	uint64_t q_ipackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	/** Total number of queue Tx packets. */
-	uint64_t q_opackets[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	/** Total number of successfully received queue bytes. */
-	uint64_t q_ibytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	/** Total number of successfully transmitted queue bytes. */
-	uint64_t q_obytes[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	/** Total number of queue packets received that are dropped. */
-	uint64_t q_errors[RTE_ETHDEV_QUEUE_STAT_CNTRS];
+	uint64_t q_ipackets;	/**< Number of received packets. */
+	uint64_t q_opackets;	/**< Number of transmitted packets. */
+	uint64_t q_ibytes;	/**< Number of received bytes. */
+	uint64_t q_obytes;	/**< Number of transmitted bytes. */
 };
 
 /**
@@ -456,7 +447,11 @@ typedef int (*eth_speed_lanes_get_capability_t)(struct rte_eth_dev *dev,
  * @param stats
  *   The stats structure to be completed by the driver and returned to the user.
  * @param qstats
- *   Any queue statistics to be returned.
+ *   Any queue statistics to be returned, indexed by queue id.
+ *   The array has RTE_MAX(nb_rx_queues, nb_tx_queues) entries and is
+ *   zeroed by ethdev before the driver is called. The driver must not
+ *   write past nb_rx_queues for the Rx fields, or past nb_tx_queues
+ *   for the Tx fields.
  *   @note: This parameter can be NULL
  */
 typedef int (*eth_stats_get_t)(struct rte_eth_dev *dev,
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 75ea3eedff..70cc6ae63c 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -510,8 +510,6 @@ eth_stats_qstats_get(uint16_t port_id, struct rte_eth_stats *stats, struct eth_q
 	}
 
 	memset(stats, 0, sizeof(*stats));
-	if (qstats != NULL)
-		memset(qstats, 0, sizeof(*qstats));
 
 	if (dev->dev_ops->stats_get == NULL)
 		return -ENOTSUP;
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d6915a6b08..253f6c0efa 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -75,7 +75,6 @@ static const struct rte_eth_xstats_name_off eth_dev_stats_strings[] = {
 static const struct rte_eth_xstats_name_off eth_dev_rxq_stats_strings[] = {
 	{"packets", offsetof(struct eth_queue_stats, q_ipackets)},
 	{"bytes", offsetof(struct eth_queue_stats, q_ibytes)},
-	{"errors", offsetof(struct eth_queue_stats, q_errors)},
 };
 
 #define RTE_NB_RXQ_STATS RTE_DIM(eth_dev_rxq_stats_strings)
@@ -3387,8 +3386,8 @@ eth_dev_get_xstats_basic_count(struct rte_eth_dev *dev)
 	uint16_t nb_rxqs, nb_txqs;
 	int count;
 
-	nb_rxqs = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
-	nb_txqs = RTE_MIN(dev->data->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	nb_rxqs = dev->data->nb_rx_queues;
+	nb_txqs = dev->data->nb_tx_queues;
 
 	count = RTE_NB_STATS;
 	if (dev->data->dev_flags & RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS) {
@@ -3501,7 +3500,7 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	if ((dev->data->dev_flags & RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS) == 0)
 		return cnt_used_entries;
 
-	num_q = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	num_q = dev->data->nb_rx_queues;
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_RXQ_STATS; idx++) {
 			unsigned int cc;
@@ -3518,7 +3517,7 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 		}
 
 	}
-	num_q = RTE_MIN(dev->data->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	num_q = dev->data->nb_tx_queues;
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_TXQ_STATS; idx++) {
 			unsigned int cc;
@@ -3708,54 +3707,61 @@ eth_basic_stats_get(uint16_t port_id, struct rte_eth_xstat *xstats)
 {
 	struct rte_eth_dev *dev;
 	struct rte_eth_stats eth_stats;
-	struct eth_queue_stats queue_stats;
+	struct eth_queue_stats *queue_stats = NULL;
 	unsigned int count = 0, i, q;
-	uint64_t val, *stats_ptr;
-	uint16_t nb_rxqs, nb_txqs;
+	uint16_t nb_rxqs, nb_txqs, nb_q;
+	uint64_t *stats_ptr;
 	int ret;
 
-	ret = eth_stats_qstats_get(port_id, &eth_stats, &queue_stats);
-	if (ret < 0)
-		return ret;
-
 	dev = &rte_eth_devices[port_id];
 
-	nb_rxqs = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
-	nb_txqs = RTE_MIN(dev->data->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+	if (dev->data->dev_flags & RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS) {
+		nb_rxqs = dev->data->nb_rx_queues;
+		nb_txqs = dev->data->nb_tx_queues;
+	} else {
+		nb_rxqs = 0;
+		nb_txqs = 0;
+	}
+
+	nb_q = RTE_MAX(nb_rxqs, nb_txqs);
+	if (nb_q > 0) {
+		queue_stats = calloc(nb_q, sizeof(*queue_stats));
+		if (queue_stats == NULL)
+			return -ENOMEM;
+	}
+
+	ret = eth_stats_qstats_get(port_id, &eth_stats, queue_stats);
+	if (ret < 0)
+		goto out;
 
 	/* global stats */
 	for (i = 0; i < RTE_NB_STATS; i++) {
 		stats_ptr = RTE_PTR_ADD(&eth_stats,
 					eth_dev_stats_strings[i].offset);
-		val = *stats_ptr;
-		xstats[count++].value = val;
+		xstats[count++].value = *stats_ptr;
 	}
 
-	if ((dev->data->dev_flags & RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS) == 0)
-		return count;
-
 	/* per-rxq stats */
 	for (q = 0; q < nb_rxqs; q++) {
 		for (i = 0; i < RTE_NB_RXQ_STATS; i++) {
-			stats_ptr = RTE_PTR_ADD(&queue_stats,
-					eth_dev_rxq_stats_strings[i].offset +
-					q * sizeof(uint64_t));
-			val = *stats_ptr;
-			xstats[count++].value = val;
+			stats_ptr = RTE_PTR_ADD(&queue_stats[q],
+					eth_dev_rxq_stats_strings[i].offset);
+			xstats[count++].value = *stats_ptr;
 		}
 	}
 
 	/* per-txq stats */
 	for (q = 0; q < nb_txqs; q++) {
 		for (i = 0; i < RTE_NB_TXQ_STATS; i++) {
-			stats_ptr = RTE_PTR_ADD(&queue_stats,
-					eth_dev_txq_stats_strings[i].offset +
-					q * sizeof(uint64_t));
-			val = *stats_ptr;
-			xstats[count++].value = val;
+			stats_ptr = RTE_PTR_ADD(&queue_stats[q],
+					eth_dev_txq_stats_strings[i].offset);
+			xstats[count++].value = *stats_ptr;
 		}
 	}
-	return count;
+	ret = count;
+out:
+	free(queue_stats);
+	return ret;
 }
 
 static int
-- 
2.53.0

