Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C413CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 11:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51ED742D0B;
	Fri, 17 Oct 2025 13:11:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1DB1C427A2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 13:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760699497; x=1792235497;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ew1G+BsCt2hWpgGovmvDnvpxzT2VbmdXCCEJ0JhAk2w=;
 b=dER1vjm69UyZ4zVElkg7YDBZplnYmCPUwbdz2qNbvu3tSvtF+jMAwUXF
 b3wZ1L0S/A/xymMWr4Q1hWBZ9oHC1iqJuWksKCH5meKihj9ft5MuCJF/Z
 WROwvG2pXn1YNXeguvgs/ZC+GFoMl3s4/Uedej4yrxZ9b2rWeambQVtic
 Y4IwDauYwX6nfKs6+bXu8QzKfP8OcMyBXUa59t/zNyshGeFtsUE0RtX1j
 zvWpklyu3ISCQczYkAB5A45Rw6pNLC2DTiv0r9dxbVxDut58CLa+SKgyv
 q7ujDFdjq46x7uQ/HvEB6qoGWjMJDVfboNR973IvZqBGygXX4umFoO96U A==;
X-CSE-ConnectionGUID: MLeI1AHqSYKP0SjZxZIlVQ==
X-CSE-MsgGUID: fMN5MFUJSn2Fzv6bKbnS1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="74023710"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="74023710"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 04:11:35 -0700
X-CSE-ConnectionGUID: /kDV13uET3eLJNo8dacsHQ==
X-CSE-MsgGUID: BiseBEwCQcWwtC4UmqWoEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="182654496"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2025 04:11:34 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC 0/3] ethdev: introduce device reinitialisation API
Date: Fri, 17 Oct 2025 11:11:06 +0000
Message-Id: <20251017111109.1734792-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

This RFC arose from a discussion [1] around whether a generic API that
performs device reset and reinitialisation would be useful. While the
net effect of a call to such an API can be achieved with a sequence of
calls to existing APIs (reset, configure, rx/tx queue_setup), the
benefit of encapsulating this all under one API is twofold:
1. the burden is taken off the user for supplying the device
configuration in the call, we use the existing device conf under the
hood and only need the port_id as input.
2. it can prevent potential unnecessary/repeat reconfiguration steps.
The PMD dev_reinit ops will only perform the necessary reconfiguration
steps after the device reset.

Patch 1 implements the API, Patch 2 implements one example of the reinit
op for the iavf driver and Patch 3 integrates the API into testpmd.

[1] https://mails.dpdk.org/archives/dev/2025-October/325386.html

Ciara Loftus (3):
  ethdev: introduce device reinitialisation API
  net/iavf: implement device reinitialisation callback
  app/testpmd: support port reinitialisation

 app/test-pmd/cmdline.c               | 15 +++++---
 app/test-pmd/testpmd.c               | 26 ++++++++++++++
 app/test-pmd/testpmd.h               |  1 +
 drivers/net/intel/iavf/iavf.h        |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c | 52 ++++++++++++++++++++++------
 drivers/net/intel/iavf/iavf_vchnl.c  |  2 +-
 lib/ethdev/ethdev_driver.h           |  4 +++
 lib/ethdev/ethdev_trace.h            |  7 ++++
 lib/ethdev/ethdev_trace_points.c     |  3 ++
 lib/ethdev/rte_ethdev.c              | 32 +++++++++++++++++
 lib/ethdev/rte_ethdev.h              | 25 +++++++++++++
 11 files changed, 151 insertions(+), 18 deletions(-)

-- 
2.34.1

