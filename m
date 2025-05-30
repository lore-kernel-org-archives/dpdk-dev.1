Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BBEC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:57:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6EED40150;
	Fri, 30 May 2025 15:57:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 62EEF400D7
 for <dev@dpdk.org>; Fri, 30 May 2025 15:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613455; x=1780149455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m01/PUA1p2tJhy6rRUuwo0+Gahoyd1vXK5fBo2F9nqo=;
 b=KXc0V42wp0E7MuB1yKuBNc/n+PXwM9S1wr9+ZFZPJxDN+Nj+O8Eeothg
 MZFm3TOogM3Ez8P7oaz/Q1mdWWiJ2OBIbxDIh848mRIHJO7gKvqpyWwHM
 O3rBMvodzDHHGXZbziObtLYLTWg05K0zaj1+gJ2z5Y6dfjDACTK2oHQZ7
 JkF60lUeZZux9YkU/81HuU4xiJocXzrQYLm1SQablgVvCkkMHmy0ZWBti
 ixp1+r0Ag9akKai+iS/cUQwoQYqwPVHt1VtrUJ32E1lMsBVW1IAZVzwUy
 UqNbDmUXamjaF5BUso4gBWahWCD+xga2j+ETlgsijmzf/TWrOHqfll5DE g==;
X-CSE-ConnectionGUID: DrBLewEXQOalzF+TC0t0EA==
X-CSE-MsgGUID: IWu4f/2qRp+fXnWQg+PP/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809363"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:57:34 -0700
X-CSE-ConnectionGUID: +TcmF7VXSb+IwM9RSSLFaQ==
X-CSE-MsgGUID: 3rg5j+wcQuuSCankexCzqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887333"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:57:33 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 00/25] Intel PMD drivers Rx cleanp
Date: Fri, 30 May 2025 14:56:56 +0100
Message-ID: <cover.1748612803.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
References: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
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

There is certain amount of duplication between different ixgbe, i40e, ice, and
iavf. This patchset specifically focuses on laying groundwork for deduplicating
the Rx side of things - providing common queue definitions, using common Rx
descriptor formats, and some low hanging fruit in terms of Rx code
deduplication, including vectorized implementations.

The first bunch of patches focus on small cleanups:

- variable renames
- definition renames
- using  one definition for 16-byte descriptors instead per-driver
- fixing some cruft in IXGBE headers

Starting with patch 15 comes the meat of the patchset:

- creating common Rx queue structure
- unifying Rx rearm code to make use of new unified structures and definitions
- expanding Rx rearm code to have SSE, AVX2, and AVX512 implementations

At the end, there are a couple of patches that unify Rx and Tx mbuf recycle
for some drivers, but more work is needed on that front because we only touch
two drivers in each case - the others do have them, but they're implemented
differently from the ones that were deduplicated.

v3 -> v4:
- Added a lot of cleanups to the patchset
- Moved to using unified Rx descriptor definitions
- Using a single compilation flag to support 16-byte descriptors
- Fixes for whitespace, syntax, etc.

Anatoly Burakov (25):
  net/ixgbe: remove unused field in Rx queue struct
  net/iavf: make IPsec stats dynamically allocated
  net/ixgbe: match variable names to other drivers
  net/i40e: match variable name to other drivers
  net/ice: match variable name to other drivers
  net/i40e: rename 16-byte descriptor define
  net/ice: rename 16-byte descriptor define
  net/iavf: rename 16-byte descriptor define
  net/ixgbe: simplify vector PMD compilation
  net/ixgbe: replace always-true check
  net/ixgbe: clean up definitions
  net/i40e: clean up definitions
  net/ice: clean up definitions
  net/iavf: clean up definitions
  net/ixgbe: create common Rx queue structure
  net/i40e: use the common Rx queue structure
  net/ice: use the common Rx queue structure
  net/iavf: use the common Rx queue structure
  net/intel: generalize vectorized Rx rearm
  net/i40e: use common Rx rearm code
  net/iavf: use common Rx rearm code
  net/ixgbe: use common Rx rearm code
  net/intel: support wider x86 vectors for Rx rearm
  net/intel: add common Rx mbuf recycle
  net/intel: add common Tx mbuf recycle

 app/test-pmd/config.c                         |   4 +-
 config/rte_config.h                           |   2 +-
 doc/guides/nics/i40e.rst                      |   4 +-
 drivers/net/intel/common/desc.h               | 157 +++++++++
 .../recycle_mbufs.h}                          |  78 +++--
 drivers/net/intel/common/rx.h                 | 119 ++++++-
 drivers/net/intel/common/rx_vec_arm.h         | 105 ++++++
 drivers/net/intel/common/rx_vec_ppc.h         | 121 +++++++
 drivers/net/intel/common/rx_vec_x86.h         | 330 ++++++++++++++++++
 drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   4 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  18 +-
 drivers/net/intel/i40e/i40e_pf.c              |   2 +-
 .../i40e/i40e_recycle_mbufs_vec_common.c      | 127 +------
 drivers/net/intel/i40e/i40e_rxtx.c            | 194 +++++-----
 drivers/net/intel/i40e/i40e_rxtx.h            |  87 +----
 drivers/net/intel/i40e/i40e_rxtx_common_avx.h | 215 ------------
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    | 135 ++-----
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  59 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  59 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   | 124 ++-----
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    | 130 ++-----
 drivers/net/intel/iavf/iavf.h                 |   4 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |  13 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 265 +++++++-------
 drivers/net/intel/iavf/iavf_rxtx.h            | 169 +--------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  91 +++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  85 +++--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 218 +-----------
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |  80 +----
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    | 148 +++-----
 drivers/net/intel/iavf/iavf_vchnl.c           |   8 +-
 drivers/net/intel/ice/ice_dcf.c               |   7 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |  27 +-
 drivers/net/intel/ice/ice_ethdev.c            |   2 +-
 drivers/net/intel/ice/ice_ethdev.h            |   4 +-
 drivers/net/intel/ice/ice_rxtx.c              | 222 ++++++------
 drivers/net/intel/ice/ice_rxtx.h              |  92 +----
 drivers/net/intel/ice/ice_rxtx_common_avx.h   | 233 -------------
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  45 ++-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  53 ++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |   6 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c      | 125 ++-----
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   8 +-
 drivers/net/intel/ixgbe/ixgbe_ipsec.c         |  10 +-
 .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    | 127 +------
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 251 +++++++------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          | 103 ++----
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |  15 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c | 123 ++-----
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  | 136 ++------
 drivers/net/intel/ixgbe/meson.build           |   2 +
 53 files changed, 1960 insertions(+), 2794 deletions(-)
 create mode 100644 drivers/net/intel/common/desc.h
 copy drivers/net/intel/{i40e/i40e_recycle_mbufs_vec_common.c => common/recycle_mbufs.h} (69%)
 create mode 100644 drivers/net/intel/common/rx_vec_arm.h
 create mode 100644 drivers/net/intel/common/rx_vec_ppc.h
 create mode 100644 drivers/net/intel/common/rx_vec_x86.h
 delete mode 100644 drivers/net/intel/i40e/i40e_rxtx_common_avx.h
 delete mode 100644 drivers/net/intel/ice/ice_rxtx_common_avx.h

-- 
2.47.1

