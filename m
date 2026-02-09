Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6D9E81BA6
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:58:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 954A7402B0;
	Mon,  9 Feb 2026 12:58:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3E70D4027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770638301; x=1802174301;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6gSwuxAZeqfTM4l6Cs+frM+KXyU5sRVRWzcEY8UeFxI=;
 b=jGgDeWUYAE1fD3P9cN59SXw4I484BwQlAWd3XlLiayiNVrvmcJqdMvFR
 wqX4pgq2KUvjQwESeg1qbng6F7hsXy8bkfEBJ6MFeA23KRcatWq1rxa32
 sGpjPG5Fk+278VJKsYsYcejQ6In9ULMe5RzpzsNcNDLXlEnn117Fwe0w1
 79k5hLbLlrb8run4JLEYS7dvSjUtuxZbTKxomyDTBFAnJAc2e3jOFnsN/
 TkQ0rMJTHLcE4eq4/3J9IODxqfGuPqOdNdF4qUX4JZxjdng/TKiwr7fnh
 tC60K52nkX5bQsfOBqFvuh8jr/6wQgrI678rmmRgWSFgQkCKFcjb0wwXV w==;
X-CSE-ConnectionGUID: 0/PnrQUWSWKw8QXO0dshdw==
X-CSE-MsgGUID: lnkTx5zuR3ypsvfH9T3Daw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71640953"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71640953"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:58:20 -0800
X-CSE-ConnectionGUID: RNbzBUxTSKWN8c36SUWr6A==
X-CSE-MsgGUID: gRNACXhzRv2z/sGUBZuylA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211627072"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 03:58:19 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2 0/7] Add support for L2TPV2 over UDP to ICE PMD
Date: Mon,  9 Feb 2026 17:26:50 +0530
Message-Id: <20260209115657.636525-1-shaiq.wani@intel.com>
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

v2: Addressed AI generated comments.

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
 drivers/net/intel/ice/ice_fdir_filter.c  | 450 ++++++++++++++++++++---
 drivers/net/intel/ice/ice_generic_flow.c | 177 +++++++++
 drivers/net/intel/ice/ice_generic_flow.h | 129 ++++---
 drivers/net/intel/ice/ice_hash.c         |  25 ++
 8 files changed, 716 insertions(+), 96 deletions(-)

-- 
2.34.1

