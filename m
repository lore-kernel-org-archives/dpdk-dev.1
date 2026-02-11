Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96237E9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:49:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA2F3402AB;
	Wed, 11 Feb 2026 14:49:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 40F8C40268
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770817778; x=1802353778;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6xlTyHxNEYroeKQyf9q1NKphw6Uu2RJo4PvlrTioYzY=;
 b=HVzRhL9MuyTNYHXLLev75ufF7hj9de1gl7KtqUdJeZu56ux2nTG8vOUB
 bZh/BaL/ssAs7ijNioQwWYSZiMxvLqL4M1MyEehOgT2v7rIcy0gDTaNVZ
 C4Zj2r66zYrq59004V3TYOwYjxSBOk2i300/G+Q50F53qy3+I59GZs6cl
 TwweVCEZyWwMjwbU50DfRpbE4dj5xbTcCdLyytTv0+m0IG9k+8mE7nCCB
 4arEMpifzUK+ocWiZfqrFrwuokX7UHv8DzWbANph3G/h17msDoFhP9sMM
 ymjQV1kE6UNkBGbwfuRUvjv98e1L1A/vN3L45X0UkC0aMq1Ncbjnhpo5S w==;
X-CSE-ConnectionGUID: d1wOIW7aQuSo58YXFJ4bzA==
X-CSE-MsgGUID: AHF9iwxvSeC0RAT5gijlpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83332501"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83332501"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:49:28 -0800
X-CSE-ConnectionGUID: ZPQiSvcDQ2ukRsjo/0GAAw==
X-CSE-MsgGUID: ScuqAsi8RiGmOk0IAQqUPQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 11 Feb 2026 05:49:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v4 0/9] Assortment of bug fixes for Intel PMD's
Date: Wed, 11 Feb 2026 13:49:07 +0000
Message-ID: <cover.1770817694.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4084ed8c4f7c01852ca22c7975d0639fc4c8a066.1770641909.git.anatoly.burakov@intel.com>
References: <4084ed8c4f7c01852ca22c7975d0639fc4c8a066.1770641909.git.anatoly.burakov@intel.com>
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

Various bug fixes for Intel IXGBE, I40E, ICE, and IAVF drivers

v1 -> v2:
- Added patches [1] [2] that were previously sent separately
- Added patch fixing leak in DCF config

v2 -> v3:
- Added patch fixing leak in FDIR parser

v3 -> v4:
- Reordered patchsets by driver
- Added patch to fix ixgbe security flow memory leak

[1] https://patches.dpdk.org/project/dpdk/patch/fbd32a8a688fd0ed90fcf497703edcc30f69d54d.1770643356.git.anatoly.burakov@intel.com/
[2] https://patches.dpdk.org/project/dpdk/patch/ab4f8d8cf24dcd18f0dd6da3359266083f31d789.1770642901.git.anatoly.burakov@intel.com/

Anatoly Burakov (9):
  net/ixgbe: add missing E610 MAC type checks
  net/ixgbe: fix memory leak in security flows
  net/i40e: move FDIR config to flow create
  net/i40e: fix IPv6 GTPU handling
  net/iavf: fix memory leak on egress IPsec flows
  net/iavf: fix memory leak on uninit
  net/iavf: fix IPv4 flow subscription
  net/ice: fix memory leak in DCF QoS bandwidth config
  net/ice: fix memory leak in FDIR flow parsing

 drivers/net/intel/i40e/i40e_flow.c         | 64 ++++++++++++----------
 drivers/net/intel/iavf/iavf_fsub.c         |  4 +-
 drivers/net/intel/iavf/iavf_generic_flow.c | 37 +++++++++++--
 drivers/net/intel/iavf/iavf_generic_flow.h |  1 +
 drivers/net/intel/ice/ice_dcf_sched.c      | 13 +++--
 drivers/net/intel/ice/ice_fdir_filter.c    |  6 +-
 drivers/net/intel/ixgbe/ixgbe_bypass_api.h |  8 +--
 drivers/net/intel/ixgbe/ixgbe_ethdev.c     | 29 ++++++----
 drivers/net/intel/ixgbe/ixgbe_ethdev.h     |  2 +
 drivers/net/intel/ixgbe/ixgbe_fdir.c       |  8 ++-
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 14 ++++-
 drivers/net/intel/ixgbe/ixgbe_pf.c         |  5 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c       | 14 +++--
 13 files changed, 135 insertions(+), 70 deletions(-)

-- 
2.47.3

