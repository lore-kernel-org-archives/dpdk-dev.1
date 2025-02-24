Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D406FC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 15:26:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F77242707;
	Mon, 24 Feb 2025 16:26:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4885B41144
 for <dev@dpdk.org>; Mon, 24 Feb 2025 16:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740410784; x=1771946784;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mfZYPJaQG53auBvZxVCRr8CwB1FLUFaTjnFIzm2ewZA=;
 b=MXnYLRXiob4lKKbEjF373C3LiXK2WG+gWwDiKn2PpywwY2fAm2EdWRSS
 0zDB88BYClXnsgk8XUuQ5AiDZNU0kV9gvzFOy1dJde7m+97IHk7yGNSMp
 7zCUYEK+ldHSAc+Tn2kvz2D5PhSGh/21aCwKLCbZLPI/eYcjjomm6uX4l
 l4llJf+UWLOrHsSlf28b+1aJSPYYMwCfX9W37owIvnT7C23RxCqWytefH
 vzYFXfyrMjx0XylfemJtQaN2+zeqHeH6900MA0YEgkx5TlXfpXGh8vliY
 RqJ/Uf5K4+4evmfXW1O7oWS65zqQNiWhZgMUOZZaYE2iIcROXrLvmnkrt g==;
X-CSE-ConnectionGUID: Zjb0yq8gSASkNS/G2BiQ3g==
X-CSE-MsgGUID: bnIJOkujSbO23hW8KN8Plg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44823609"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="44823609"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 07:26:22 -0800
X-CSE-ConnectionGUID: NLhD7rfcQx2gol4Np03Ogw==
X-CSE-MsgGUID: jp862uvbT0amjiBcgDqIWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="116107649"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.22])
 by fmviesa007.fm.intel.com with ESMTP; 24 Feb 2025 07:26:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>, John McNamara <john.mcnamara@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/3] doc/nics: rework notes for iavf use
Date: Mon, 24 Feb 2025 15:26:06 +0000
Message-ID: <20250224152611.1012935-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224152611.1012935-1-bruce.richardson@intel.com>
References: <20250224152611.1012935-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When describing the iavf driver, there was a lot of text in a single
note block which could be clarified by splitting it up into separate
sections and appropriate bulletted lists.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/intel_vf.rst | 60 +++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 2b0eebcafe..708cb85417 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -88,36 +88,26 @@ For more detail on SR-IOV, please refer to the following documents:
 
 *   `Intel® IAVF HAS <https://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/ethernet-adaptive-virtual-function-hardware-spec.pdf>`_
 
-.. note::
-
-    To use DPDK IAVF PMD on Intel® 700 Series Ethernet Controller, the device id (0x1889) need to specified during device
-    assignment in hypervisor. Take qemu for example, the device assignment should carry the IAVF device id (0x1889) like
-    ``-device vfio-pci,x-pci-device-id=0x1889,host=03:0a.0``.
-
-    When IAVF is backed by an Intel® E810 device, the "Protocol Extraction" feature which is supported by ice PMD is also
-    available for IAVF PMD. The same devargs with the same parameters can be applied to IAVF PMD, for detail please reference
-    the section ``Protocol extraction for per queue`` of ice.rst.
-
-    Quanta size configuration is also supported when IAVF is backed by an Intel® E810 device by setting ``devargs``
-    parameter ``quanta_size`` like ``-a 18:00.0,quanta_size=2048``. The default value is 1024, and quanta size should be
-    set as the product of 64 in legacy host interface mode.
-
-    When IAVF is backed by an Intel® E810 device or an Intel® 700 Series Ethernet device, the reset watchdog is enabled
-    when link state changes to down. The default period is 2000us, defined by ``IAVF_DEV_WATCHDOG_PERIOD``.
-    Set ``devargs`` parameter ``watchdog_period`` to adjust the watchdog period in microseconds, or set it to 0 to disable the watchdog,
+IAVF PMD parameters
+^^^^^^^^^^^^^^^^^^^
+
+``watchdog_period``
+    The reset watchdog is enabled when link state changes to down.
+    The default period is 2000us, defined by ``IAVF_DEV_WATCHDOG_PERIOD``.
+    Set ``devargs`` parameter ``watchdog_period`` to adjust the watchdog period in microseconds,
+    or set it to 0 to disable the watchdog,
     for example, ``-a 18:01.0,watchdog_period=5000`` or ``-a 18:01.0,watchdog_period=0``.
 
-    Enable VF auto-reset by setting the devargs parameter like ``-a 18:01.0,auto_reset=1``
-    when IAVF is backed by an Intel\ |reg| E810 device
-    or an Intel\ |reg| 700 Series Ethernet device.
+``auto_reset``
+    Enable VF auto-reset by setting the devargs parameter,
+    for example ``-a 18:01.0,auto_reset=1``,
 
+``no-poll-on-link-down``
     Stop polling Rx/Tx hardware queue when link is down
-    by setting the ``devargs`` parameter like ``-a 18:01.0,no-poll-on-link-down=1``
-    when IAVF is backed by an Intel\ |reg| E810 device or an Intel\ |reg| 700 Series Ethernet device.
+    by setting the ``devargs`` parameter like ``-a 18:01.0,no-poll-on-link-down=1``.
 
-    Similarly, when IAVF is backed by an Intel\ |reg| E810 device
-    or an Intel\ |reg| 700 Series Ethernet device,
-    set the ``devargs`` parameter ``mbuf_check`` to enable Tx diagnostics.
+``mbuf_check``
+    Set the ``devargs`` parameter ``mbuf_check`` to enable Tx diagnostics.
     For example, ``-a 18:01.0,mbuf_check=<case>`` or ``-a 18:01.0,mbuf_check=[<case1>,<case2>...]``.
     Thereafter, ``rte_eth_xstats_get()`` can be used to get the error counts,
     which are collected in ``tx_mbuf_error_packets`` xstats.
@@ -129,6 +119,26 @@ For more detail on SR-IOV, please refer to the following documents:
     * ``segment``: Check number of mbuf segments does not exceed HW limits.
     * ``offload``: Check for use of an unsupported offload flag.
 
+
+HW-Specific Notes For IAVF
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Intel\ |reg| 700 Series Ethernet devices:
+
+* To use DPDK IAVF PMD the device id (0x1889) need to specified during device assignment in hypervisor.
+  For example, on qemu, the device assignment should carry the IAVF device id (0x1889) like
+  ``-device vfio-pci,x-pci-device-id=0x1889,host=03:0a.0``.
+
+Intel\ |reg| E800 Series Ethernet devices:
+
+* the "Protocol Extraction" feature which is supported by ice PMD is also available for IAVF PMD. The same devargs with the same parameters can be applied to IAVF PMD.
+  for Detail please reference the section ``Protocol extraction for per queue`` of ice.rst.
+
+* Quanta size configuration is supported by setting ``devargs`` parameter ``quanta_size``,
+  for example: ``-a 18:00.0,quanta_size=2048``.
+  The default value is 1024, and quanta size should be set as the product of 64 in legacy host interface mode.
+
+
 The PCIE host-interface of Intel Ethernet Switch FM10000 Series VF infrastructure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.43.0

