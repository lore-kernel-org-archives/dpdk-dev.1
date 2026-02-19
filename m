Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C96E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 11:24:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 962B1402AC;
	Thu, 19 Feb 2026 12:24:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id F0761402A2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 12:24:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771500286; x=1803036286;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ohcm7NO/nqwpXYvOVzwZJFObFiwNeRZjoF/7lnRaTOg=;
 b=luXZ2Uv85JDvJDY+OE0wZGeapFLkLNpJZl0mwzbBmVFDKBaTj8sMiNxc
 pEG1RSVWimnO1GSUNEGc7BGcNsRcZmKL8TJ0Xea9GyKq6q+/XtByavgJ+
 8vHvOSpYqllsLBnfeKyYbvHCk8V4zVn29wWzf1Zm5pPhilSccLhdyR62g
 pfsOL/0VNHiSF95513/sAhSVCcduQ+U2Jp9tsDqZGZG7Lbk/7WnCmdi6n
 gom6UonfssHFv6VW3H7q2HwFmbJR5wGV9E6ga8nDQK8fwdBsmZ7tMVyUz
 4LNKmHkOZuNpTSOX7DQRi7RiH7iVIHvE4pRuyn59Rpnb+Za3Q9YKMbDaL g==;
X-CSE-ConnectionGUID: gD1l6WMnRcCKRiRyTiv+5A==
X-CSE-MsgGUID: hncfMQTBSvmQrefPkk6urw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76198673"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="76198673"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 03:24:45 -0800
X-CSE-ConnectionGUID: 4Ocd91YOTtOx1LjYKHRl9Q==
X-CSE-MsgGUID: 1iFspHDXRlW7A57IIlJLbA==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2026 03:24:43 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v7 0/7] Add support for L2TPV2 over UDP to ICE PMD
Date: Thu, 19 Feb 2026 16:50:56 +0530
Message-Id: <20260219112103.2370766-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202094244.447966-2-shaiq.wani@intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
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

This patchset enables L2TPv2 over UDP support in the ice PMD via rte_flow,
allowing flow classification and RSS hashing for L2TPv2 traffic.
  
v7: removed FDIR in doc and commit log titles.

v6: split patch 3 into 2 separate patches.

v5: Resending v4 patches with correct cover letter and threading.
  
v4: *Version 3 patchset was incomplete due to a server reboot.
    *V4 includes all patches for review.
 
v3: Fixed compilation issues.
v2: Addressed AI generated comments.




*** BLURB HERE ***

Shaiq Wani (7):
  net/ice: add L2TPv2 PPP and PPoE data structures
  net/ice: add L2TPv2 tunnel type definition
  net/ice: rename protocol identifiers
  net/ice: add L2TPv2 protocol support
  net/ice: add L2TPv2 flow pattern matching support
  net/ice: add L2TPv2 hardware packet generation
  net/ice: add L2TPv2 RSS hash support

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

