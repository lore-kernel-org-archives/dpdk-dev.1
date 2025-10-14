Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA85CCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:45:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E117440613;
	Tue, 14 Oct 2025 10:45:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id B987D4060B
 for <dev@dpdk.org>; Tue, 14 Oct 2025 10:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760431537; x=1791967537;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=El+J4QUB/dta7v92w7FNtBk7gIKhqlzTXZl1vtUy0XI=;
 b=A/fr9/C3YBY/ZXhVOjPyCQMyn2e2ZVe+YKoqz3kSGYKco5poC2+CBaeP
 yU5XAfZKCT4H/GzlOlxAcbHdnfr3CMxDnSicG9aAnRfMPnW9otrvrHi6a
 Gnh4UZCw/qYBzghkZeDO8iygrR7zy34yiwXV/sOvX+eqLj9kvAu3kkAVR
 W4xyOQmK9LCZYMH+sRoar4ZsnDvQt66jPmWS4XSDmrKTDcz0pJgGfr/Qz
 pq1iCVLDjUe0U+BptPpPVE8VuALyprmSXDwkP6sgbTcoS6DknTQ0n6sdt
 NpN9spuJEpLSC1OCWOkoGmFBb29JH9OoixnlscuXxPRwDLDvRGdLnetsk Q==;
X-CSE-ConnectionGUID: yKkk3YCqRNC9SXBXkagpCw==
X-CSE-MsgGUID: 70xOL8ZIQ7eEvgfQgZ5jKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61796248"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61796248"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:45:36 -0700
X-CSE-ConnectionGUID: OFuO2K3UT3Wmt/1xJjk40w==
X-CSE-MsgGUID: IC6cT+a1S1Kwx2wzSPnQPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181630640"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 01:45:35 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/6] net/intel: fixes and improvements to rx path selection
Date: Tue, 14 Oct 2025 08:45:11 +0000
Message-Id: <20251014084517.1407407-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

This series contains a number of fixes and improvements to
the logic concerned with selecting an rx path in the intel
drivers. The first three patches are fixes that affect the
iavf driver. The final three patches reformat the arrays in
the i40e iavf and ice drivers that hold information for each
Rx path that are used in the common selection process, in an
attempt to improve readability.

Ciara Loftus (6):
  net/intel: fix Rx vector capability detection
  net/iavf: fix Rx paths feature definitions
  net/iavf: fix Rx path selection for scalar flex bulk alloc
  net/iavf: reformat the Rx path infos array
  net/i40e: reformat the Rx path infos array
  net/ice: reformat the Rx path infos array

 drivers/net/intel/common/rx.h      |   5 +-
 drivers/net/intel/i40e/i40e_rxtx.c | 126 +++++++++----
 drivers/net/intel/iavf/iavf.h      |   1 +
 drivers/net/intel/iavf/iavf_rxtx.c | 285 +++++++++++++++++++++--------
 drivers/net/intel/iavf/iavf_rxtx.h |   1 -
 drivers/net/intel/ice/ice_rxtx.c   | 124 +++++++++----
 6 files changed, 401 insertions(+), 141 deletions(-)

-- 
2.34.1

