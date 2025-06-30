Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2BC7EE30
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 02:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9737640264;
	Mon, 30 Jun 2025 04:30:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 37F294025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 04:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751250604; x=1782786604;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6Hfz2SD3G0IJbsouFNjd/m268vQLJBqZf0BvAfILFMs=;
 b=TzidL0ANe8gGNoy18bCQd3Avk/lR4dPjv8/YEyNoWrwjvx1ZLCLJgcpE
 cGYVCYpfQLlPLIn02xzTxMrR92yRaG4S71P+aGqDRwxkTTB90SbHFcb30
 +jOyn06o3JTx98PV9PWLfY3QXGXmhqe3geFlWNOtf/R0GZ7Xr3jdwP3ZN
 hHPaFKWlFVVJSpAlhynyT/Nc1Yb0Nn+k6LSmWoSDABY31bA6neRhQraf0
 kMq5D7f87dh+0z0ghYoC9TLTilyOV2xZcmRBJtCrXPODS5Ki0YUhB4iUK
 xN3y+5ORzyvCeleZZZKORTZ3isjxsddyukvQqyR0RmnCTwHBLqbdmRht4 A==;
X-CSE-ConnectionGUID: ViqO5aTERDmu6+35zOZqQA==
X-CSE-MsgGUID: STZKX77nSweDQE8FSfvzCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64160860"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; d="scan'208";a="64160860"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2025 19:30:03 -0700
X-CSE-ConnectionGUID: 1KWbQRYNTgikkMYZom1UoA==
X-CSE-MsgGUID: Nl4EDuXNR7KaPnkQ603Edw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; d="scan'208";a="153425627"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa006.fm.intel.com with ESMTP; 29 Jun 2025 19:30:03 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1] event/dlb2: update DLB documentation for history list
 config
Date: Sun, 29 Jun 2025 21:30:00 -0500
Message-Id: <20250630023000.719037-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
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

Update DPDK documentation for configuring DLB hardware history
list resource using devargs arguments.

Fixes: 33ab065d0c40 ("event/dlb2: support managing history list resource")

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 doc/guides/eventdevs/dlb2.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2.rst
index 8ec7168f20..2f836db010 100644
--- a/doc/guides/eventdevs/dlb2.rst
+++ b/doc/guides/eventdevs/dlb2.rst
@@ -7,6 +7,12 @@ Driver for the Intel® Dynamic Load Balancer (DLB)
 The DPDK DLB poll mode driver supports the Intel® Dynamic Load Balancer,
 hardware versions 2.0 and 2.5.
 
+Please follow the links below to download the Programmer Guides.
+
+`Intel Dynamic Load Balancer 2.0 Programmer Guide <https://cdrdv2.intel.com/v1/dl/getContent/613545>`_. (Device: 0x2710)
+
+`Intel Dynamic Load Balancer 2.5 Programmer Guide <https://cdrdv2.intel.com/v1/dl/getContent/639481>`_. (Device: 0x2714)
+
 Prerequisites
 -------------
 
@@ -477,6 +483,23 @@ Example command to use as meson option for credit handling:
 
        meson configure -Dc_args='-DDLB_SW_CREDITS_CHECKS=0 -DDLB_HW_CREDITS_CHECKS=1'
 
+DLB History List Configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Every DLB Load Balancing port (i.e., eventdev port not using RTE_EVENT_PORT_CFG_SINGLE_LINK flag)
+has a hardware resource call history list entries (HL) associated with it. This count decides the number
+of events that can be inflight to the port from the DLB hardware. DLB has 2048 total HL entries.
+As DLB supports 64 load-balanced ports, by default DLB PMD assigns 32 HL entries to each port.
+Following devargs arguments allow application to control HL entries overriding default mode.
+DLB API rte_pmd_dlb2_set_port_param() allows setting HL entries for the DLB eventdev ports.
+Please refer to section "Fine Tuning History List Entries" in DLB Programmer Guide for details.
+
+    .. code-block:: console
+
+       --allow ea:00.0,use_default_hl=0,alloc_hl_entries=1024
+
+        use_default_hl = 1=Enable (default), 0=Disable
+        alloc_hl_entries = 0-2048 Total HL entries
+
 Running Eventdev Applications with DLB Device
 ---------------------------------------------
 
-- 
2.39.1

