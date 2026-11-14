Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B0606A32E
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b2P/nM2R
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ADD2427D5;
	Sat, 14 Nov 2026 01:55:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id 3998040269;
 Sat, 14 Nov 2026 01:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794617748; x=1826153748;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j2brrdoYfvKeAFsxxvTqj9g1KtD/nfZXp6MYLznEgZo=;
 b=b2P/nM2R9SMdvx+jwNnK20i25nmHXew5Tt4lJr3I6BpQ1i230EYaWYNs
 BafL54O/ax5cjGpvoaHBHnR7iIwpGKvKtZ4+EC3QjXa40qhleh88wt3G+
 sjd/XVKgNdT/BbcMuHX8w6isXl1ZS+JZPQ4Rwyd0/3eVskR0LEsiWgrc3
 situ5crYGrTFwHXyoS+I0oijbHk+/hvgx/uS9lXY9jzrRjU0E62htpmDS
 WSNwURMKVnbO6axLTGW/NskudyFo9CV/qNKEuXz6WYqOTh7We45X4xCWc
 BHJC+skos5OfrO7UBFu+fqt0FRuPKh/BXJlGDDFhsMWnrDhD4aKr4oCgX w==;
X-CSE-ConnectionGUID: 9M3V/SlWQpSPiF5VVSH84w==
X-CSE-MsgGUID: jwYIT07FRCil3HndM0HykA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3471596"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3471596"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 16:55:47 -0800
X-CSE-ConnectionGUID: HZi5ForrSruD0zGFR5xCIw==
X-CSE-MsgGUID: lgBaF9evRmSCsC7YMQ+2Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9315600"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2026 16:55:45 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, brian.johnson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>, stable@dpdk.org
Subject: [PATCH v2 3/4] doc: fix ixgbe guide
Date: Sat, 14 Nov 2026 07:57:31 +0000
Message-Id: <20261114075732.183996-4-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
References: <20261113205034.173313-1-sandeep.penigalapati@intel.com>
 <20261114075732.183996-1-sandeep.penigalapati@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Correct several errors in the ixgbe guide:

- use the current IXGBE_RX_MAX_BURST, IXGBE_TX_MAX_BURST and
  IXGBE_TX_MAX_FREE_BUF_SZ macro names.
- add the missing device BDF to the fiber_sdp3_no_tx_disable example.
- add the "none" option to the "set bypass event" command and its
  description, and clarify the bypass command examples.
- minor grammar and spacing fixes.

Fixes: 972e365bfe7a ("doc: nics guide")
Fixes: 125f6edbe8f3 ("doc: add statistics read frequency to ixgbe guide")
Fixes: e435197a5fc2 ("net/ixgbe: remove unnecessary macro")
Fixes: 0f9fb100f6c6 ("net/ixgbe: add option for link up check on pin SDP3")
Fixes: 0100a038fa49 ("net/ixgbe: move testpmd commands")
Fixes: 3ab51564e9a5 ("net/ixgbe: move bypass init in a testpmd command")
Fixes: 9fd2193e56a5 ("net/ixgbe: increase max Rx/Tx descriptors")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 doc/guides/nics/ixgbe.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index 1d14e292e2..2fbe5afeb2 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -45,7 +45,7 @@ Vector PMD for IXGBE
 --------------------
 
 Vector PMD uses Intel® SIMD instructions to optimize packet I/O.
-It improves load/store bandwidth efficiency of L1 data cache by using a wider SSE/AVX register 1 (1).
+It improves load/store bandwidth efficiency of L1 data cache by using a wider SSE/AVX register.
 The wider register gives space to hold multiple packet buffers so as to save instruction number when processing bulk of packets.
 
 There is no change to PMD API. The RX/TX handler are the only two entries for vPMD packet I/O.
@@ -86,7 +86,7 @@ The following prerequisites apply:
 
 Ensure that the following pre-conditions are satisfied:
 
-*   rxq->rx_free_thresh >= RTE_PMD_IXGBE_RX_MAX_BURST
+*   rxq->rx_free_thresh >= IXGBE_RX_MAX_BURST
 
 *   rxq->rx_free_thresh < rxq->nb_rx_desc
 
@@ -98,7 +98,7 @@ Ensure that the following pre-conditions are satisfied:
 
 These conditions are checked in the code.
 
-By default, IXGBE_MAX_RING_DESC is set to 8192 and RTE_PMD_IXGBE_RX_MAX_BURST is set to 32.
+By default, IXGBE_MAX_RING_DESC is set to 8192 and IXGBE_RX_MAX_BURST is set to 32.
 
 Windows Prerequisites and Pre-conditions
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -155,7 +155,7 @@ be passed as part of EAL arguments. For example,
 
 .. code-block:: console
 
-   dpdk-testpmd -a fiber_sdp3_no_tx_disable=1 -- -i
+   dpdk-testpmd -a 81:00.0,fiber_sdp3_no_tx_disable=1 -- -i
 
 - ``fiber_sdp3_no_tx_disable`` (default **0**)
 
@@ -229,14 +229,14 @@ Prerequisite
 ^^^^^^^^^^^^
 
 The only prerequisite is related to tx_rs_thresh.
-The tx_rs_thresh value must be greater than or equal to RTE_PMD_IXGBE_TX_MAX_BURST,
-but less or equal to RTE_IXGBE_TX_MAX_FREE_BUF_SZ.
+The tx_rs_thresh value must be greater than or equal to IXGBE_TX_MAX_BURST,
+but less or equal to IXGBE_TX_MAX_FREE_BUF_SZ.
 Consequently, by default the tx_rs_thresh value is in the range 32 to 64.
 
 Feature not Supported by TX Vector PMD
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-TX vPMD only works when offloads is set to 0
+TX vPMD only works when offloads is set to 0.
 
 This means that it does not support any TX offload.
 
@@ -298,7 +298,7 @@ remain consistent. Running a DPDK application without polling the statistics wil
 cause registers on hardware to count to the maximum value, and "stick" at
 that value.
 
-In order to avoid statistic registers every reaching the maximum value,
+In order to avoid statistic registers ever reaching the maximum value,
 read the statistics from the hardware using ``rte_eth_stats_get()`` or
 ``rte_eth_xstats_get()``.
 
@@ -465,7 +465,7 @@ port config bypass
 
 Enable/disable bypass feature::
 
-   port config bypass (port_id) (on|off)
+   testpmd> port config bypass (port_id) (on|off)
 
 set bypass mode
 ~~~~~~~~~~~~~~~
@@ -477,13 +477,15 @@ Set the bypass mode for the lowest port on bypass enabled NIC::
 set bypass event
 ~~~~~~~~~~~~~~~~
 
-Set the event required to initiate specified bypass mode for the lowest port on a bypass enabled::
+Set the event required to initiate specified bypass mode for the lowest port on a bypass enabled NIC::
 
-   testpmd> set bypass event (timeout|os_on|os_off|power_on|power_off) \
+   testpmd> set bypass event (none|timeout|os_on|os_off|power_on|power_off) \
             mode (normal|bypass|isolate) (port_id)
 
 Where:
 
+* ``none``: Unset the bypass event (main state, no triggering event).
+
 * ``timeout``: Enable bypass after watchdog timeout.
 
 * ``os_on``: Enable bypass when OS/board is powered on.
-- 
2.34.1

