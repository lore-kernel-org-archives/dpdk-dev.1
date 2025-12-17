Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9ED65C56
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 14:32:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91590402C9;
	Wed, 17 Dec 2025 15:32:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0788B4026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 15:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765981957; x=1797517957;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r89KZ4RoY8AhoFQiE8pCl8cxJ00R1C4FxnqA0uCjrTY=;
 b=TzM3k7XecrA+hjXkx/ymhj3l9QAxqz29eSOjnhm9dj8LH1UXaCqstKki
 6kmd49lPSVI5lOx56BKAKjeNqCovrrGzy2ptJxRoPwzjvqNhRa7AJloFf
 qIrO8BEL4g091tEEpYZlIypVOLURVMtzPsPRBuUijPumcOOZrrbGB0Ci0
 qTiI+HSAngzQHjIDuTnpkLSVPlqIsZU8lzTnVPe2W+znyuLBBTx+nNQF+
 YsITq0TyxG8/5Tn1N09KrK3Jrk3es5VxLWKJdjvp9pgujUUMqpv7tEi4e
 yqHplURRqCvYtiFevY0p1SgwJ1TJQE2ymyNFUVF4+73i7h0pJfME2/Zj8 g==;
X-CSE-ConnectionGUID: mEEuAtT9S4Cqn01B2USk2g==
X-CSE-MsgGUID: V3nQMJd8TmyLTkUYyozQ0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="70495929"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="70495929"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 06:32:36 -0800
X-CSE-ConnectionGUID: PVprUAV7QLCzB8NQohtWlA==
X-CSE-MsgGUID: /u9jCVh7Se+gcA8U6URJ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="202690322"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 17 Dec 2025 06:32:35 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/5] Remove SSE Rx/Tx paths from some Intel drivers
Date: Wed, 17 Dec 2025 14:32:18 +0000
Message-ID: <20251217143223.3208830-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825123548.1177090-1-ciara.loftus@intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
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

This patch removes the SSE Rx and Tx paths from the i40e, iavf and ice
drivers. Each of these drivers have faster vector paths (AVX2 and
AVX-512) which have feature parity with the SSE paths. In
environments where AVX2 or AVX-512 are not supported, the scalar path
will still be used, which also has feature parity.

This series is intended for the next-net-intel tree.

v2:
* Remove deprecation notice
* Provide more detailed explanation in the release notes.
* Usage of function type enum instead of pkt burst pointer in the
supported_ptypes_get functions (simplify the logic by removing #ifdefs)
* More renaming in iavf to remove all mentions of SSE
* Removal of IAVF_REL_MBUFS_AVX512_VEC enum value as it's not used

Ciara Loftus (5):
  net/i40e: remove SSE vector path
  net/iavf: remove SSE vector path
  net/ice: remove SSE vector path
  doc: add release note entry for SSE removal
  doc: remove deprecation notice of SSE in some Intel drivers

 doc/guides/rel_notes/deprecation.rst        |    8 -
 doc/guides/rel_notes/release_26_03.rst      |    7 +
 drivers/net/intel/i40e/i40e_ethdev.h        |    3 -
 drivers/net/intel/i40e/i40e_rxtx.c          |   72 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c |   20 +
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c  |  717 ----------
 drivers/net/intel/i40e/meson.build          |    1 -
 drivers/net/intel/iavf/iavf.h               |    6 +-
 drivers/net/intel/iavf/iavf_rxtx.c          |   65 +-
 drivers/net/intel/iavf/iavf_rxtx.h          |    9 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c |   33 +
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c  | 1395 -------------------
 drivers/net/intel/iavf/meson.build          |    1 -
 drivers/net/intel/ice/ice_ethdev.h          |    3 -
 drivers/net/intel/ice/ice_rxtx.c            |   74 +-
 drivers/net/intel/ice/ice_rxtx.h            |    6 -
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |   23 +
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  737 ----------
 drivers/net/intel/ice/meson.build           |    1 -
 19 files changed, 153 insertions(+), 3028 deletions(-)
 delete mode 100644 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
 delete mode 100644 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
 delete mode 100644 drivers/net/intel/ice/ice_rxtx_vec_sse.c

-- 
2.43.0

