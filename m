Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DDEC88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21D52427BF;
	Wed, 16 Sep 2026 12:36:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C56AE40DD0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789554990; x=1821090990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RJhP1dlncMsh6yeNWxpwUQLwquaQvgQo3Ilk+U6MFgQ=;
 b=kO1AERbdtz54+DMs0A1Y3rBNEf38jjbeqCrAjddGjXQ5yU2i6yX6Wdb3
 O5t+y8IanjcFtD3wtn6cslUWRFHjlxkUEOGjahrZZqWr+/y0CymjOBRxI
 iizZUA7bfNyaGa/rPkxhO30aSMYsiqtmhN6p90m0e7c9s1byy9Bpasp8M
 ZyUlbA5ytLUL1T8W89ucT4zfTOsBeUx0U+8lZ9BEVIcu5SWfkELVDQg9A
 9DAZDP9DRhSg9PRUgTVBiR//O6mvUwmJVbWWODwhGs912gAUvGkhB8fHe
 p2tUkVuyTuDyzMVPC/liDCwdiKBdnRfVTZneKYJZ7xnOMwoI+/NA/Sum4 w==;
X-CSE-ConnectionGUID: 3VJ05E8ESDybrBDWZRJChw==
X-CSE-MsgGUID: FpQzHretQu2S6CyPXwr0fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867620"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867620"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:29 -0700
X-CSE-ConnectionGUID: o1KS73HLQeiTZp81F0YtMw==
X-CSE-MsgGUID: MAXqSC8PTZKQuTtLMZix3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528116"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 00/15] consolidate ice and iavf Tx vector paths
Date: Wed, 16 Sep 2026 11:36:07 +0100
Message-ID: <20260916103622.319874-1-bruce.richardson@intel.com>
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

V3:
* fix variable shadowing issue in patch 15 (ci_txq_vec_capable param)
* update ice.ini with new features

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

 doc/guides/nics/features/ice.ini              |   8 +-
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
 19 files changed, 1068 insertions(+), 1502 deletions(-)
 create mode 100644 drivers/net/intel/common/tx_vec_x86.h

--
2.53.0

