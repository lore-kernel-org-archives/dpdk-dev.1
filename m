Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52250F9B5F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 09:16:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6947340616;
	Wed, 22 Apr 2026 11:16:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7CA21402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 11:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776849384; x=1808385384;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8q7pNveeXvrCKw07yhYF/x7ftX2vmBmuQbBXx6v7GgM=;
 b=D1erhnjCjdM2FkL1nmH3IejOtpH9ZvaYF9jO1Yazqi1Kn4BZcyVYVud2
 mG2qF0pFFrMt/8VNj94lUE7ayXOWr8WUlcXdg6cpCK9ijWrXyUIddgSBe
 Zq9ghCmYhEnqQQGZSrjuNzanksTpgN1MNRjFf5+qIPQeH62Gs6LqVVdNr
 VWYP2sFQbP0349t0bbpMV/7hxyXGoLXl39HS8dzD16EM8+BSEBSFiKbB6
 JSYmOQ9lGhPwCy1hPRnOqB32j0vfZ6KsUl4EnaOSw/mZfVv8L8bFkBbIb
 HpKaCXtsCOxUSAH3rdXGJQ4Yld3wpwOQ6mf9dRDJ2SsBrn9XPX9FgMhKf A==;
X-CSE-ConnectionGUID: K+yp037AQYuSJq1Kqw0ZZQ==
X-CSE-MsgGUID: 4zQQYC++Tpmm+gR/5SWzzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89266805"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="89266805"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 02:16:23 -0700
X-CSE-ConnectionGUID: bpzBKQ8CQcmCdERaC+8dZQ==
X-CSE-MsgGUID: Cmm3Y1wbQeqIowEMdybEgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="229631838"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa008.fm.intel.com with ESMTP; 22 Apr 2026 02:16:23 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v5 0/3] iavf: LLDP ptype and AVX2 ctx paths
Date: Wed, 22 Apr 2026 09:16:06 +0000
Message-ID: <20260422091609.1797686-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417105610.1161242-4-ciara.loftus@intel.com>
References: <20260417105610.1161242-4-ciara.loftus@intel.com>
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

This series adds another way to detect LLDP packets in the Tx paths
of the iavf PMD, which is based on the mbuf packet type field. This is
in addition to the existing method of using a dynamic field. The series
also adds new AVX2 context descriptor Tx paths that support LLDP. Finally,
a deprecation notice is added to the documentation to flag that the
dynamic mbuf field method of LLDP packet detection will be removed in a
future release.

Patch 1 flags "CHECK:MACRO_ARG_REUSE" in checkpatch for the
IAVF_CHECK_TX_LLDP macro. This is a false positive because the inputs to
the macro are not reused in a way that would cause issues.

v5:
* Updated the documentation
* Made the "lldp mode" per-device rather than a global value. This is
necessary because the devarg is per-device unlike the global dynfield.
The mode is added to the iavf-specific flags in the ci_tx_queue struct
so that it can be read for each device on the datapath.

Ciara Loftus (3):
  net/iavf: support LLDP Tx via mbuf ptype or dynfield
  net/iavf: add AVX2 context descriptor Tx paths
  doc: announce change to LLDP packet detection in iavf PMD

 doc/guides/nics/intel_vf.rst                  |  33 +-
 doc/guides/rel_notes/deprecation.rst          |   4 +
 doc/guides/rel_notes/release_26_07.rst        |   6 +
 drivers/net/intel/common/tx.h                 |   1 +
 drivers/net/intel/iavf/iavf.h                 |   3 +
 drivers/net/intel/iavf/iavf_ethdev.c          |  27 ++
 drivers/net/intel/iavf/iavf_rxtx.c            |  33 +-
 drivers/net/intel/iavf/iavf_rxtx.h            |  21 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 387 ++++++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  21 +-
 10 files changed, 508 insertions(+), 28 deletions(-)

-- 
2.43.0

