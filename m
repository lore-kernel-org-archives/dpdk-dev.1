Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BD6C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:37:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46DC740DDC;
	Tue, 15 Sep 2026 15:37:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 66E22406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479430; x=1821015430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+2gCDGpQK+kW0BTD0RP14EsMlIrdbRlgfaW4pZriypY=;
 b=Dpmsn1EpL9XVIeqrSDGLFyiG+zJvog8WcLosrPFtuKg84t6GJM4HYIBN
 f34xjk4yY5cGbX1sN/XyfuB6uE8mxtxMjbkXO0M4GyjAXtSkNyZCm9s3m
 kUfcxrvUiFgVG+qFg1Esaue/AXu6qZKNVE+Fe6XEchNBRDKzQFbkoxp3H
 ku+9v3hDPYc+16rEAj47dMeuwcvKbn9yh8gnaAlszGtxQhY3+EO97HNeB
 WzlEgVjSgL0Vf217zJexQIMsJSsE7QmcshG/6C8STiaEmCC+T2t68YR0d
 2AvaxokKE9AXAFNEpupmjiektU5k9H5miX8aHr5k1mibIRumO0gtYR6kc g==;
X-CSE-ConnectionGUID: iyPLyRAXTFyb3Gif9MI4yA==
X-CSE-MsgGUID: ijN/PwuMQFSiM4wa0A/TRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972499"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972499"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:09 -0700
X-CSE-ConnectionGUID: lVIQ37y0Qh+BsemMHJF7sw==
X-CSE-MsgGUID: FeSzhONiTp6UTCB2NsMKLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800700"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 00/15] consolidate ice and iavf Tx vector paths
Date: Tue, 15 Sep 2026 14:36:37 +0100
Message-ID: <20260915133654.278780-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903170140.360477-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
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

This patchset consolidates the ice and iavf vector Tx paths, moving the
code to net/intel/common. The iavf code is used as the basis for the
move, because it has a superset of the features. When the common code is
adopted by the ice driver, it then gains features such as QinQ support
and tunneling support.

V2:
* fix build when iova not in mbuf
* add extra patch to consolidate the offload flags

Bruce Richardson (15):
  net/iavf: remove unnecessary alignment calls
  net/intel: make Tx context flag common
  net/iavf: use separate params for VLAN and QinQ position
  net/iavf: deduplicate tunnel field fill functions
  net/intel: define common macros for tunneling bit-shifts
  net/intel: move iavf descriptor writing functions to common
  net/intel: use function callback for lldp
  net/intel: allow building without IOVA in mbuf
  net/ice: use common descriptor creation functions
  net/intel: move vector Tx paths to common
  net/ice: use common AVX Tx functions
  net/intel: add common vector Tx fns with context handling
  net/intel: improve Tx path selection logic
  net/ice: enable context desc offloads for vector Tx
  net/intel: consolidate Tx vector offload path checks

 doc/guides/rel_notes/release_26_11.rst        |   6 +
 drivers/net/intel/common/tx.h                 | 107 ++-
 drivers/net/intel/common/tx_vec_x86.h         | 781 ++++++++++++++++++
 drivers/net/intel/cpfl/cpfl_rxtx.c            |   3 +-
 drivers/net/intel/i40e/i40e_rxtx.c            |   2 +-
 drivers/net/intel/iavf/iavf_rxtx.c            |  94 +--
 drivers/net/intel/iavf/iavf_rxtx.h            |  53 --
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 496 +----------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 495 +----------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  79 +-
 drivers/net/intel/iavf/meson.build            |   4 +-
 drivers/net/intel/ice/ice_ethdev.h            |   3 +
 drivers/net/intel/ice/ice_rxtx.c              |  44 +-
 drivers/net/intel/ice/ice_rxtx.h              |  17 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     | 159 +---
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   | 154 +---
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  62 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |   3 +-
 18 files changed, 1064 insertions(+), 1498 deletions(-)
 create mode 100644 drivers/net/intel/common/tx_vec_x86.h

--
2.53.0

