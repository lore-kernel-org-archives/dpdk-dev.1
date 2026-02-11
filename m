Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB856EB5969
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 06:10:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C52C4026A;
	Wed, 11 Feb 2026 07:10:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C0CE6400D7
 for <dev@dpdk.org>; Wed, 11 Feb 2026 07:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770790227; x=1802326227;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2FBpkwq8WDZccq4PiOT4nSvo7Z3xWECmYRLguA7dHpw=;
 b=e92qLBn5dBdKelpLshu+u+n9dKqCHjhueq0VB0GB1jWQLfftpD/GNWVZ
 WSc7i+W+YXOFwBihuU5rD479DN0wuePM/2lZ/uLzqYuYIQ00Fk4I7iyX+
 jDTZH1Nwt6HEsIr48Xxc7taoBXDlYkF125PN4DwJwbYKsll7oCyn8OAOE
 +e/qicSqjQ+BiPdEJOrIyKb8fEBz9D7WvVcvi1B9t3le3ehZk+HH/7Ock
 B2twfyqGv7tECu7PfjEKUOeEw+mw9hHwJc0yKDtpFnmEQdgp4XCkMxSPl
 5Cm4C/1o9QaHY4Rz4XFzj0YAokeBQNjnBulzeJ7k6q2mOC6hNpCsFc+Zf w==;
X-CSE-ConnectionGUID: srK8LnoaSPa/YJsyXD+bRQ==
X-CSE-MsgGUID: KoN3eRgeRUCbjLwiRU1Fcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71829047"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71829047"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:10:26 -0800
X-CSE-ConnectionGUID: vrVX4gz0SxmvdKBNxYT4gQ==
X-CSE-MsgGUID: NOnwco3nQmCtpsz5x+k1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216655452"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa005.fm.intel.com with ESMTP; 10 Feb 2026 22:10:24 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v3 0/7] Add support for L2TPV2 over UDP to ICE PMD
Date: Wed, 11 Feb 2026 11:39:03 +0530
Message-Id: <20260211060910.219419-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202094244.447966-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
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

This patchset adds L2TPv2 protocol support to the ICE PMD
enabling RSS and Flow Director capabilities for L2TPv2 over UDP traffic.

v3: Fixed compilation issues.

v2: Addressed AI generated review comments.

Shaiq Wani (7):
  net/ice: add L2TPv2 PPP and PPoE data structures
  net/ice: add L2TPv2 tunnel type definition
  net/ice: add L2TPv2 protocol and field definitions
  net/ice: add L2TPv2 flow patterns and FDIR support
  net/ice: add L2TPv2 hardware packet generation
  net/ice: add L2TPv2 RSS hash support
  doc: update release notes

 doc/guides/rel_notes/release_26_03.rst   |   4 +
 drivers/net/intel/ice/base/ice_fdir.c    |   6 +
 drivers/net/intel/ice/base/ice_fdir.h    |  17 +
 drivers/net/intel/ice/ice_ethdev.h       |   4 +
 drivers/net/intel/ice/ice_fdir_filter.c  | 451 ++++++++++++++++++++---
 drivers/net/intel/ice/ice_generic_flow.c | 177 +++++++++
 drivers/net/intel/ice/ice_generic_flow.h | 129 ++++---
 drivers/net/intel/ice/ice_hash.c         |  25 ++
 8 files changed, 717 insertions(+), 96 deletions(-)

-- 
2.34.1

