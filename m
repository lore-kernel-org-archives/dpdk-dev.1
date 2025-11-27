Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D9D11183
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 09:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5150340DCF;
	Thu, 27 Nov 2025 10:44:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id ECC724013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 10:44:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764236688; x=1795772688;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V2Es8ngIv80lmOLYkgGyXukbZ6jFO5ycgXT3ck9ZKz8=;
 b=AVXDq+3xblzYqQc33Ork5iEaskBjG6X6hoPcWxVw16CKMHgj6WXMob6J
 3mUqo8nNr3aidw7U7iTc/c93Zfussp0icH65RmBWDVG/boEZldAez8NUE
 AaCr9dDuNDrHOcqLcq6D6HEumHROVbcm/tPqkHaigTW2Vj3L6be+wI+Hv
 PE2fUNhnxHjvdCtwwWjSP1lbI0j+1lvqcCWsVTbt3Sthzvc1CfLqFMf0p
 HPpwiip8++3m9DE3OqYbG5hcW94y/uH2xWDAzweroS1fBaZGROZXTK5GU
 OtZpYPNVl0tI3hIYNERTtfuUmXqKiHG39LgLrYmxk/75M8f3VqJKOR7gA A==;
X-CSE-ConnectionGUID: Q0bWZ+1ySIyx2e3AFc7RjQ==
X-CSE-MsgGUID: +I6b1mYVRFSXiz+OLMus+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66227417"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; d="scan'208";a="66227417"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 01:44:46 -0800
X-CSE-ConnectionGUID: QsckEI1nSd+Zhr9oL1HwNg==
X-CSE-MsgGUID: pA6bLU3tQJS/Ssfq9Ruy1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; d="scan'208";a="193289439"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa008.jf.intel.com with ESMTP; 27 Nov 2025 01:44:46 -0800
From: John McNamara <john.mcnamara@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	John McNamara <john.mcnamara@intel.com>
Subject: [PATCH v1] doc: update release notes for 25.11
Date: Thu, 27 Nov 2025 09:44:34 +0000
Message-ID: <20251127094443.109547-1-john.mcnamara@intel.com>
X-Mailer: git-send-email 2.48.1
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

Fix grammar, spelling and formatting of DPDK 25.11 release notes.

Signed-off-by: John McNamara <john.mcnamara@intel.com>
---
 doc/guides/rel_notes/release_25_11.rst | 31 +++++++++++++-------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c82af81c3f..eaaf99d18f 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -72,17 +72,18 @@ New Features
     that span across different processes or operating system domains.
   * Added functions to exchange handlers between DMA devices.
 
-* **Added speed 800G.**
+* **Added 800G speed.**
 
   Added Ethernet link speed for 800 Gb/s as it is well standardized in IEEE,
   and some devices already support this speed.
 
 * **Added mbuf tracking for debug.**
 
-  Added history dynamic field in mbuf (disabled by default)
+  Added history dynamic field in mbuf
   to store successive states of the mbuf lifecycle.
   Some functions were added to dump statistics.
   A script was added to parse mbuf tracking stored in a file.
+  This feature is disabled by default.
 
 * **Added ethdev API to get link connector.**
 
@@ -104,7 +105,7 @@ New Features
   * OTHER
 
   By default, it reports ``RTE_ETH_LINK_CONNECTOR_NONE``
-  unless driver specifies it.
+  unless the driver specifies it.
 
 * **Updated Amazon ENA (Elastic Network Adapter) ethernet driver.**
 
@@ -122,7 +123,7 @@ New Features
 
 * **Updated Marvell cnxk ethernet driver.**
 
-  Added support to set/get link configuration as mentioned below:
+  Added support to set/get link configuration as outlined below:
 
   * Get speed capability from firmware.
   * Report link type, mode and status.
@@ -229,25 +230,25 @@ Removed Items
 
 * build: as previously announced in the deprecation notices,
   the ``enable_kmods`` build option has been removed.
-  Kernel modules will now automatically be built for OS's where out-of-tree kernel modules
+  Kernel modules will now be built automatically for OSes where out-of-tree kernel modules
   are required for DPDK operation.
   Currently, this means that modules will only be built for FreeBSD.
   No modules are shipped with DPDK for either Linux or Windows.
 
 * ethdev: As previously announced in deprecation notes,
   queue specific stats fields are now removed from ``struct rte_eth_stats``.
-  Mentioned fields are: ``q_ipackets``, ``q_opackets``, ``q_ibytes``, ``q_obytes``, ``q_errors``.
-  Instead queue stats will be received via xstats API.
-  Also compile time flag ``RTE_ETHDEV_QUEUE_STAT_CNTRS`` is removed from public headers.
+  Affected fields are: ``q_ipackets``, ``q_opackets``, ``q_ibytes``, ``q_obytes``, ``q_errors``.
+  Queue stats will be received via the xstats API instead.
+  Also, the compile time flag ``RTE_ETHDEV_QUEUE_STAT_CNTRS`` is removed from public headers.
 
 * telemetry: As previously announced in the deprecation notices,
   the functions ``rte_tel_data_add_array_u64`` and ``rte_tel_data_add_dict_u64`` are removed.
   They are replaced by ``rte_tel_data_add_array_uint`` and ``rte_tel_data_add_dict_uint`` respectively.
 
-* net/mlx5: ``repr_matching_en`` device argument has been removed.
+* net/mlx5: The ``repr_matching_en`` device argument has been removed.
   Applications which disabled this option were able to receive traffic
   from any physical port/VF/SF on any representor port.
-  Specifically, in most cases, this was used to process all traffic on representor port
+  Specifically, in most cases, this was used to process all traffic on a representor port
   which is a transfer proxy port.
   Similar behavior in mlx5 PMD can be achieved without this device argument,
   by using ``RTE_FLOW_ACTION_TYPE_RSS`` in transfer flow rules.
@@ -269,7 +270,7 @@ API Changes
    =======================================================
 
 * rawdev: Changed the return type of ``rte_rawdev_get_dev_id()``
-  for negative error values.
+  to allow negative error values.
 
 * pcapng: Changed the API for adding interfaces to include a link type argument.
   The link type was previously hardcoded to the Ethernet link type in the API.
@@ -301,10 +302,10 @@ ABI Changes
   to avoid unaligned accesses.
 
 * ethdev: Added ``link_connector`` field to ``rte_eth_link`` structure
-  to report type of link connector for a port.
+  to report the type of link connector for a port.
 
 * cryptodev: The ``rte_crypto_sm2_op_param`` struct member ``cipher`` to hold ciphertext
-  is changed to union data type. This change is required to support partial SM2 calculation
+  is changed to a union data type. This change is required to support partial SM2 calculation
   which is driven by ``RTE_CRYPTO_SM2_PARTIAL`` capability flag.
 
 * cryptodev: The enum ``rte_crypto_asym_xform_type``, struct ``rte_crypto_asym_xform``
@@ -595,6 +596,6 @@ Tested Platforms
       * Device ID: 15b3:1021
       * Firmware version: 28.47.1026 and above
 
-   * DOCA:
+  * DOCA:
 
-      * DOCA 3.2.0-125000 and above
+    * DOCA 3.2.0-125000 and above
-- 
2.48.1

