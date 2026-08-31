Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D796DC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2B704025A;
	Mon, 31 Aug 2026 12:36:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 060844025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:36:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788172604; x=1819708604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m8bB+W44KTfjeC7YgqT3EGiqEbse/WvBxVUnoJqaHPA=;
 b=mALif8xnyfCryGyy8YD7wo4+bKQGsE4OoO2tC+CB2C05aaxP3Tql/4Dp
 raVY4f27E3+LQZmwKg/42FU5nDOxevduA6p5JMnrJpLTWXApkgz7h3w16
 ly5eVXNPVTvJFh5cjvIFt/iZmCdBU5mGpJdC+YrT8D25+prFonsdQGjLq
 KsOmaRdrMe0ZMG9vXXXFQZyCa4l0vEkTUKlKfH9DvjkkI0HO3blVhGXVB
 rSxvW8S7/ClHBEttleU4i3wjAe2zRSN07gRVmn/UjkR7sa4UE12IB/pjp
 9d2llBdH8p4r9dseHAZbz8bu40Vpk5QnwvOi96UYBz8iIrZ/cvEkroC2K Q==;
X-CSE-ConnectionGUID: GXHgbHcYT2GDoKxCARkz6w==
X-CSE-MsgGUID: kmCTfxGqRki3nqEnzJaKIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88625945"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88625945"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:36:43 -0700
X-CSE-ConnectionGUID: fcFfB9D1SxaTTLHwBdi5mg==
X-CSE-MsgGUID: yr/m7RCfRFW3+KoM2KL1PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="268807423"
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.153])
 by orviesa007.jf.intel.com with ESMTP; 31 Aug 2026 03:36:41 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 0/4] net/ice: support outer checksum in vector Tx
Date: Mon, 31 Aug 2026 10:35:26 +0000
Message-Id: <cover.1788171502.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787566677.git.anurag.mandal@intel.com>
References: <cover.1787566677.git.anurag.mandal@intel.com>
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

V2-changes:
 - Addressed Bruce Richardson's comments
 - Put the MACLEN assignments on single lines.
 - Only encode EIPLEN when an outer IP type (EIPT) was selected, 
   matching how iavf sets eip_len per protocol case.
 - Returned success instead of a partially built context when
   the tunnel type is not supported, so a half-completed 
   context descriptor can never be written.
 - Recorded use_ctx and use_vec_entry in one place only. The 
   duplicate use_vec_entry assignment in ice_tx_queue_start() is
   removed; ice_set_tx_function() runs before any queue is started
   and now covers every queue, matching iavf. This also fixes DCF
   queues, which never passed through ice_tx_queue_start() and so
   never had use_vec_entry recorded.
 - Declared .ctx_desc = true for the scalar path, which does emit
   context descriptors, so it is not filtered out of path selection
   when a context descriptor is requested. Matches IAVF_TX_DEFAULT.
 - Folded the ctx_desc condition into the req_features initializer.
 - Marked the new AVX2 and AVX-512 context Tx helpers 
   with __rte_always_inline so the compile-time offload flag 
   is folded, as for the existing ice_vtx()/ice_vtx1() helpers.

Added AVX2 and AVX-512 context descriptor Tx paths 
for outer IPv4 and UDP checksum offloads, 
avoiding scalar Tx fallback.

Anurag Mandal (4):
  net/common: share Tx context descriptor flag
  net/ice: add vector tunnel context encoding
  net/ice: add AVX2 context descriptor Tx path
  net/ice: add AVX-512 context descriptor Tx path

 doc/guides/rel_notes/release_26_11.rst      |   6 +
 drivers/net/intel/common/tx.h               |   2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c      |   4 +-
 drivers/net/intel/ice/ice_ethdev.h          |   2 +
 drivers/net/intel/ice/ice_rxtx.c            |  49 +++++--
 drivers/net/intel/ice/ice_rxtx.h            |  11 ++
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 119 +++++++++++++++++
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 141 ++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  53 +++++++-
 9 files changed, 374 insertions(+), 13 deletions(-)

-- 
2.34.1

