Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70303E63F3F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 09:37:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3BE440289;
	Mon, 16 Feb 2026 10:37:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id ADF4B40269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:37:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771234645; x=1802770645;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s1+40E3kFwjOqHxNgV+7GtSXLAzHIefStQfxLkGjChw=;
 b=e7ALhIQIpWZyxxs+0/cMEQANttLs99Lh3CqWpUJ9JG84CqsJCBa5fsJw
 kAQeRTb0OY5Mt6JPF2OiyLpSRDNPmydP6SpC5HQ0p4SPwnBQN05NiNroB
 PqA+rLeD8U//NTEmnwvBt2pTOjmwLTPh0zO/T7BUcaMAfSnN9qTUMjNW1
 t1akBWwqMUD/j3qEzzJo8Jtp3qwxnnqKKeGHS3NGNQ606/Og9itNms+ks
 thdjqtgAvkP8dpsXxRg5dxC5AeVO8dNGzaOicv5oar2JvOjwMFLJBJE1b
 MHOJ50sWfnl9j3VJ70r2jDBeANLEElvMrwkKJRsItekdLqNsdLmpXtC9R w==;
X-CSE-ConnectionGUID: ENHVTHeCRH64v5lsvuh/Bg==
X-CSE-MsgGUID: q1mVjQUxSGOXS737DldRHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="97772505"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; d="scan'208";a="97772505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 01:37:24 -0800
X-CSE-ConnectionGUID: b18oVfBjS7Or0/wZjg64hg==
X-CSE-MsgGUID: JcdOmSkRTZCEPzNfFI65Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; d="scan'208";a="217566329"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by fmviesa004.fm.intel.com with ESMTP; 16 Feb 2026 01:37:22 -0800
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: [PATCH] doc: improve e1000 driver documentation
Date: Mon, 16 Feb 2026 19:55:04 +0000
Message-ID: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
X-Mailer: git-send-email 2.43.0
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

Update e1000 driver docs to cover all Intel 1G devices,
including emulated e1000 and real hardware,
and group related drivers (igb, igc) for clarity."

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
---
 doc/guides/nics/e1000em.rst | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
index ed4f57e9c6..b2e09cd673 100644
--- a/doc/guides/nics/e1000em.rst
+++ b/doc/guides/nics/e1000em.rst
@@ -1,6 +1,53 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
+Intel 1G Network Drivers (e1000, igb, igc)
+==========================================
+
+Overview
+--------
+
+DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit
+Ethernet controller families. These include:
+
+*   e1000 – Intel 8254x family devices, including QEMU e1000 emulation.
+*   e1000e – Intel PRO/1000 PCI‑Express family (82563/6/7, 82571/2/3/4/7/8/9,
+             82583 and I217/I218/I219-based adapters).
+
+These drivers follow similar design principles and capabilities and are grouped
+here for clarity.
+
+Supported Hardware
+------------------
+
+E1000 Devices
+~~~~~~~~~~~~~
+
+The e1000 Linux base driver supports the Intel® PRO/1000 PCI and PCI‑X
+family of Gigabit Ethernet controllers. Supported devices include:
+
+*   Intel 82540, 82541, 82545, 82546
+*   QEMU ``e1000`` emulated NIC
+
+E1000e Devices
+~~~~~~~~~~~~~~
+
+The e1000e Linux base driver supports the Intel PRO/1000 PCI‑Express family
+including:
+
+*   82563/82566/82567 series
+*   82571/82572/82573/82574/82577/82578/82579 series
+*   82583-based adapters
+*   I217, I218 and I219 Gigabit Network Connections
+
+Driver Notes
+~~~~~~~~~~~~
+
+*   e1000 – supports PCI/PCI‑X Gigabit adapters.
+*   e1000e – supports PCI‑Express Gigabit adapters.
+
+Both drivers are widely used across physical and virtualized environments.
+
 Driver for VM Emulated Devices
 ==============================
 
-- 
2.43.0

