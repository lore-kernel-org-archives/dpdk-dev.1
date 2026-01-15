Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A9D41167
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 10:38:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11FA6402F0;
	Thu, 15 Jan 2026 11:38:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id ECD254003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 11:38:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768473524; x=1800009524;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e8E500REQJ2sTVGT5c8IgHq6KrEJjg55IzN9c66jdQ0=;
 b=Q/m/VoT62FeDUCxf55wfrK9yeEgigzXexHa+1aHasF5DnXNXQVCYJI/9
 CWqcaozJBrURL0yvmgoc5kRNOp92FsYL+Zy1bhAu/IlZbWw9Qx4bt6Toh
 7Bg1i3Sk3m6tXNpH57wanbCFPZarCt+pHKsLlyA1AE6Hx9KM/3Xo7lLQW
 /easQzI33+lmPVoswBEfff0fW7wChjt+ZYK9eb09GTdhhUMMoTt6Yqz4N
 3aVufprkgXIo9DNSAaT6V1a7UOpzHrQfCiffDMMr4AygSUUNzcSxmZU/h
 bQTCbDHpGGrH14PWusgi/lwS1Xzc8v4M8/SYzHVYQF1F73/jU7a1hnlin A==;
X-CSE-ConnectionGUID: eJDTRPBdQTq2J/A0fdJknA==
X-CSE-MsgGUID: tEjAbt82SvKoMtf0JLy6Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87187955"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="87187955"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:38:43 -0800
X-CSE-ConnectionGUID: XWAjX32+Tx6qvf3szWympg==
X-CSE-MsgGUID: f7g0a+qiQAG+hcRcul9IMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="205204777"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 02:38:41 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 0/3] Ice Tx Scheduler Fixes
Date: Thu, 15 Jan 2026 10:38:20 +0000
Message-ID: <20260115103824.1982220-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

Three fixes for the ice Tx Scheduler: reenable strict priority, fix debug printing and prevent a
potential null dereference.

Ciara Loftus (3):
  net/ice: check for null before dereferencing
  net/ice: fix priority mode printing in Tx scheduler dump
  net/ice: re-enable strict priority on non-root levels

 drivers/net/intel/ice/ice_diagnose.c |  2 +-
 drivers/net/intel/ice/ice_tm.c       | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.43.0

