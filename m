Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F518E9E302
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:04:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22763402B5;
	Wed, 11 Feb 2026 14:04:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3195B4026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:04:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770815045; x=1802351045;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hWnfq8OzY5vRAB7F+vArGO/gsqqDJMzIL8uZQBseUjk=;
 b=h1+2/j2eBdqkIwM0KOmdsRj9uA5D324LgVWLzf7HXa5qwu9XPeXfkPxl
 y9cFoVkTlAjAzT7SdnzYR9Lmm9P82Wm3riz4I80dBQmtOphCjkMoafhtK
 jpRjBXNNg3ZbKn3mzj+xFFLsNcqHyqKnTjH2368DJdBFYraaAzHegvB0P
 iSYb7GwcCL5Ohpfpts4zOI6ayc9Sk7me7xfo7dZyy4IZT6OiaOgpH60T3
 oBL0M31wnsei5fDFrtDXPNIzOAKQ5mV2OJLG9uuhl2eGN+zkNseUXWLUq
 9ax78roCqi//AW5VQgziGhTl0pRf8h4LDZVloChWajNX/hkRIUVM4g0ZW Q==;
X-CSE-ConnectionGUID: 7zrmvCL2T7GqiTGYdWppNQ==
X-CSE-MsgGUID: PfQRm3wETtmHRLZWY21f2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59529065"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59529065"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:04:04 -0800
X-CSE-ConnectionGUID: nXqz1h/hQqGrm7IQ25LCvQ==
X-CSE-MsgGUID: J8KxPmriQH2WVyBP3TKbeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="217206327"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 11 Feb 2026 05:04:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 0/8] Assortment of bug fixes for Intel PMD's
Date: Wed, 11 Feb 2026 13:03:45 +0000
Message-ID: <cover.1770814868.git.anatoly.burakov@intel.com>
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

[1] https://patches.dpdk.org/project/dpdk/patch/fbd32a8a688fd0ed90fcf497703edcc30f69d54d.1770643356.git.anatoly.burakov@intel.com/
[2] https://patches.dpdk.org/project/dpdk/patch/ab4f8d8cf24dcd18f0dd6da3359266083f31d789.1770642901.git.anatoly.burakov@intel.com/

Anatoly Burakov (8):
  net/ixgbe: add missing E610 MAC type checks
  net/i40e: move FDIR config to flow create
  net/iavf: fix memory leak on egress IPsec flows
  net/iavf: fix memory leak on uninit
  net/i40e: fix IPv6 GTPU handling
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
 drivers/net/intel/ixgbe/ixgbe_fdir.c       |  8 ++-
 drivers/net/intel/ixgbe/ixgbe_flow.c       |  3 +-
 drivers/net/intel/ixgbe/ixgbe_pf.c         |  5 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c       | 14 +++--
 12 files changed, 123 insertions(+), 69 deletions(-)

-- 
2.47.3

