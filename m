Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA0CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 17:26:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E50E402B7;
	Mon,  3 Nov 2025 18:26:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 07FD640270
 for <dev@dpdk.org>; Mon,  3 Nov 2025 18:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762190787; x=1793726787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qaIVA9mWc9IhO7KY8pM6kY1BRmAyOQknsci/rZ4Egac=;
 b=MEkAK3X3CG2YZYjrpgTvKWD2k8aFNkIotcjlcSZCCrBwEhfNSmoySdkH
 bCjYDxuyniZESr3qmMVYUMTQmgEUSaeJUdaPMvWl/CiyTk1cKpeQDfMff
 3ASCPfq+67AclTg1qjYgf/PcDdJ0t4ukA82WxpHBcRnkp7Ayj5OWNbZm7
 wJHDQ9z2HvrkNVWAUI9E/c4k1hbEipUhQNBvaciY1GeLNBebenr4jbsCw
 PqHyE5Ljdy/TI9MixoNBNUIYjElGdz0qNYYbRUfgcoesAmoQoQlPUWhoX
 aXIpmEh6yKZbzJPhk9FS5kaauZphQcjU3heauYD67RkRQ7Ljucx4lxqMR g==;
X-CSE-ConnectionGUID: N1igIBO/QiSzUS9n/9wBng==
X-CSE-MsgGUID: WLuqtTPvQX6TR04RNt5fcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="81681546"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="81681546"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 09:26:25 -0800
X-CSE-ConnectionGUID: n5we26EyRxi7oHFqJJApBA==
X-CSE-MsgGUID: TJEdTRJOSX2IJrm/e5ARQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="187238676"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa008.fm.intel.com with ESMTP; 03 Nov 2025 09:26:24 -0800
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v3] doc: update documentation for ICE DCB and PFC features
Date: Mon,  3 Nov 2025 17:26:21 +0000
Message-ID: <20251103172621.970792-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103155150.965108-1-vladimir.medvedkin@intel.com>
References: <20251103155150.965108-1-vladimir.medvedkin@intel.com>
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

Add DCB and PFC documentation. Update feature matrix
and release notes.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 doc/guides/nics/features/ice.ini       |   1 +
 doc/guides/nics/ice.rst                | 102 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_25_11.rst |   4 +
 3 files changed, 107 insertions(+)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 2703493514..e9796c1eab 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -24,6 +24,7 @@ Scattered Rx         = Y
 TSO                  = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
+DCB                  = Y
 Unicast MAC filter   = Y
 RSS hash             = Y
 RSS key update       = Y
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7e9ba23102..cf43866737 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -426,6 +426,108 @@ The DCF PMD needs to advertise and acquire DCF capability which allows DCF to
 send AdminQ commands that it would like to execute over to the PF and receive
 responses for the same from PF.
 
+Data Center Bridging (DCB) and Priority Flow Control (PFC)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ice PMD supports Data Center Bridging (DCB) and Priority Flow Control (PFC).
+These features enable Quality of Service (QoS) in data center environments by allowing
+traffic classification and prioritization across multiple traffic classes.
+
+DCB Configuration
++++++++++++++++++
+
+DCB can be enabled by configuring the device with ``RTE_ETH_MQ_RX_DCB_FLAG`` in the Rx mode
+during device configuration.
+
+The ice PMD supports:
+
+* 4 or 8 traffic classes (TCs)
+* VLAN Priority to Traffic Class mapping
+
+Limitations:
+
+* All TCs are configured with Enhanced Transmission Selection (ETS) with even bandwidth allocation
+* Queues are evenly distributed across configured TCs
+* The number of queues must be evenly divisible by the number of traffic classes
+* The number of queues per TC must be a power of 2
+* Traffic classes must be configured contiguously starting from TC 0
+
+Example DCB configuration in testpmd:
+
+.. code-block:: console
+
+   dpdk-testpmd -a 0000:18:00.0 -- -i --nb-cores=8 --rxq=8 --txq=8
+   port stop 0
+   port config 0 dcb vt off 4 pfc off
+   port start 0
+
+This configures 4 traffic classes with 2 queues per TC.
+
+Example DCB configuration in application code:
+
+.. code-block:: c
+
+   struct rte_eth_conf port_conf = {
+       .rxmode = {
+           .mq_mode = RTE_ETH_MQ_RX_DCB,
+       },
+       .rx_adv_conf = {
+           .dcb_rx_conf = {
+               .nb_tcs = RTE_ETH_4_TCS,
+               .dcb_tc = {0, 1, 2, 3, 0, 1, 2, 3},  /* Map priorities to TCs */
+           },
+       },
+   };
+
+   ret = rte_eth_dev_configure(port_id, nb_rx_queues, nb_tx_queues, &port_conf);
+
+PFC Configuration
++++++++++++++++++
+
+Priority Flow Control (PFC) provides a mechanism to pause and resume traffic
+on individual traffic classes, enabling lossless Ethernet for specific priorities.
+
+PFC can be configured per priority using the ``rte_eth_dev_priority_flow_ctrl_set()`` API.
+Each traffic class can be independently configured with:
+
+* RX pause only
+* TX pause only
+* Full duplex pause
+* No pause (disabled)
+
+PFC operates in VLAN-based mode and requires DCB to be configured first.
+
+Features:
+
+* Per-TC pause control (XON/XOFF)
+* Configurable high/low watermarks for buffer management
+* Configurable pause quanta
+* PFC statistics exposed via xstats
+
+Example PFC configuration in testpmd:
+
+.. code-block:: console
+
+   set pfc_ctrl rx on tx on 100000 50000 65535 0 0
+
+This enables PFC on port 0 priority 0 with high watermark of 100000 bytes,
+low watermark of 50000 bytes, and pause time of 65535.
+
+Example PFC configuration using DPDK API:
+
+.. code-block:: c
+
+   struct rte_eth_pfc_conf pfc_conf;
+
+   pfc_conf.fc.mode = RTE_ETH_FC_FULL;          /* Enable full duplex pause */
+   pfc_conf.fc.high_water = 100000;              /* High watermark in bytes */
+   pfc_conf.fc.low_water = 50000;                /* Low watermark in bytes */
+   pfc_conf.fc.pause_time = 0xFFFF;              /* Pause quanta (in 512 bit-time units) */
+   pfc_conf.priority = 0;                        /* Configure PFC for priority 0 */
+
+   ret = rte_eth_dev_priority_flow_ctrl_set(port_id, &pfc_conf);
+
+
 Forward Error Correction (FEC)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335cfc..6a35f9f15d 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -115,6 +115,10 @@ New Features
 
   Added network driver for the Huawei SPx series Network Adapters.
 
+* **Added DCB and PFC support to Intel ice net driver.**
+
+  Added support for Data Center Bridging (DCB) and Priority Flow Control (PFC) to the Intel ice PMD.
+
 * **Added Nebulamatrix nbl ethernet driver.**
 
   Added the PMD for Nebulamatrix NICs.
-- 
2.43.0

