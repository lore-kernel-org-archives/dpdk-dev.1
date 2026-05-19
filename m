Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2964CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5F2D40296;
	Tue, 19 May 2026 18:08:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1D3CF40276
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206917; x=1810742917;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I3l1d53NGEt53cEHPOmm/PtzxUB6GdrrBwf7X/e3suI=;
 b=VTEITD0Xqxrg9jpZrxAEPQO7bn383wOEuyjEm8/hg4tOP6Mf3PxopbV7
 iGw4UQlKo5VVhlZYlD31AEUZed6GMu2PRHCV9dUiHhwty3NJizRJWmU/t
 cvAWDoXBRCUxiK8PVibFvmIA7MTFJmlje3Jb3N0LJ6xYecgeVDXNygTs3
 gR/c04uxxlX4otIeoA0U0prHmKkSHHC1PCspcCN/AKtmppB58hLAyZWEw
 FpXxA2tEdk0IEW9j41+HofKa7xiBKoaFmBvQY7EOQwUgdQluuIJKq0Da8
 fLQOl046PfjPYjiPX9EVMExOA232xTbXoQU8Fn9qO4tG0QPbv+wSlw82m w==;
X-CSE-ConnectionGUID: oVuVX2GESfiuy6TB62DFHQ==
X-CSE-MsgGUID: Rg1Ux1sCTQ+PP9PH0vXwbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070039"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070039"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:36 -0700
X-CSE-ConnectionGUID: k+0xd0GyTry029TN+raGxQ==
X-CSE-MsgGUID: Rvm2jMXwR6q4zlXjs/MmFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784760"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Date: Tue, 19 May 2026 16:05:57 +0000
Message-ID: <20260519160823.1004973-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

This RFC proposed to replace all instances of rte_memcpy in Intel
(and former-Intel) net drivers with just regular memcpy. This is
done on the basis that the memcpy use is not datapath, but is used
for flow configuration, virt-channel (to firmware or PF) messaging
and other control path functions.

Bruce Richardson (8):
  net/ice: replace use of DPDK-specific memcpy function
  net/iavf: replace use of DPDK-specific memcpy function
  net/i40e: replace use of DPDK-specific memcpy function
  net/ixgbe: replace use of DPDK-specific memcpy function
  net/e1000: replace use of DPDK-specific memcpy function
  net/idpf: replace use of DPDK-specific memcpy function
  net/cpfl: replace use of DPDK-specific memcpy function
  net/ipn3ke: replace use of DPDK-specific memcpy function

 drivers/net/intel/cpfl/cpfl_ethdev.c          |  4 +-
 drivers/net/intel/cpfl/cpfl_vchnl.c           |  6 +-
 drivers/net/intel/e1000/em_rxtx.c             |  1 -
 drivers/net/intel/e1000/igb_flow.c            |  8 +--
 drivers/net/intel/e1000/igb_pf.c              |  5 +-
 drivers/net/intel/e1000/igb_rxtx.c            |  1 -
 drivers/net/intel/i40e/base/i40e_osdep.h      |  3 +-
 drivers/net/intel/i40e/i40e_ethdev.c          | 57 +++++++++----------
 drivers/net/intel/i40e/i40e_fdir.c            | 18 +++---
 drivers/net/intel/i40e/i40e_flow.c            | 26 ++++-----
 drivers/net/intel/i40e/i40e_pf.c              |  3 +-
 drivers/net/intel/i40e/i40e_tm.c              |  6 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c         | 20 +++----
 drivers/net/intel/iavf/base/iavf_osdep.h      |  3 +-
 drivers/net/intel/iavf/iavf_ethdev.c          | 12 ++--
 drivers/net/intel/iavf/iavf_fdir.c            | 46 +++++++--------
 drivers/net/intel/iavf/iavf_fsub.c            | 26 ++++-----
 drivers/net/intel/iavf/iavf_generic_flow.c    |  4 +-
 drivers/net/intel/iavf/iavf_hash.c            |  4 +-
 drivers/net/intel/iavf/iavf_tm.c              |  6 +-
 drivers/net/intel/iavf/iavf_vchnl.c           | 14 ++---
 drivers/net/intel/ice/base/ice_osdep.h        |  5 +-
 drivers/net/intel/ice/ice_dcf.c               | 14 ++---
 drivers/net/intel/ice/ice_dcf_ethdev.c        | 10 ++--
 drivers/net/intel/ice/ice_dcf_parent.c        |  2 +-
 drivers/net/intel/ice/ice_dcf_sched.c         |  6 +-
 drivers/net/intel/ice/ice_diagnose.c          |  4 +-
 drivers/net/intel/ice/ice_ethdev.c            | 12 ++--
 drivers/net/intel/ice/ice_fdir_filter.c       | 36 ++++++------
 drivers/net/intel/ice/ice_generic_flow.c      |  4 +-
 drivers/net/intel/ice/ice_hash.c              |  2 +-
 drivers/net/intel/ice/ice_tm.c                |  2 +-
 drivers/net/intel/idpf/base/idpf_osdep.h      |  5 +-
 drivers/net/intel/idpf/idpf_common_device.c   |  2 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.c | 20 +++----
 drivers/net/intel/idpf/idpf_ethdev.c          | 10 ++--
 drivers/net/intel/idpf/idpf_rxtx.c            |  8 +--
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      |  1 -
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        | 26 ++++-----
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |  8 +--
 drivers/net/intel/ipn3ke/ipn3ke_tm.c          |  6 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  4 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |  6 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 32 +++++------
 drivers/net/intel/ixgbe/ixgbe_ipsec.c         |  4 +-
 drivers/net/intel/ixgbe/ixgbe_pf.c            |  5 +-
 drivers/net/intel/ixgbe/ixgbe_tm.c            |  6 +-
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |  2 +-
 48 files changed, 252 insertions(+), 263 deletions(-)

-- 
2.51.0

