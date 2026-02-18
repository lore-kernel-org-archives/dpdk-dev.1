Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F4FE9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:41:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A34C4042E;
	Wed, 18 Feb 2026 17:41:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 32B634042E
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:41:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771432901; x=1802968901;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MF9HvT9pi9PRqO5XBCvanDpc91JOEL7gKgs14iN9Eew=;
 b=hRVAmxa655+6FBsJ4237ZzpWS60Dn4j3vy9IS1GJO9FQ3ReMJ0v5bLaS
 +Abd/mhDPBZm+0c+U1GldwlYArKA06vg7XlenocGzYVQWN5LIX30Jyblu
 +rVBZVGI7Glg0o53co0EqslJlxK/+M+Zyhr+4sxV3UwPYeL0aPeGKPXJn
 XpEzdsHSmqAJoWLNzHgTHBISdLogvuk/bQ2SapHR5xhRo8noStKyv2DIw
 fbnZI012HOumwe+RDFTYa49+kGkqcXIYTUpd1pqKT38syFwuK69LmdhNh
 8b8V3vtYDebgyeoD2HnlhjK/CKAjCllzrcgVHiepCWkqfdTpqQE44JE/0 w==;
X-CSE-ConnectionGUID: D9hqaq2PTjuF4VnJ6p6YGw==
X-CSE-MsgGUID: tk1UAT6BS3WjcyickU2PvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72601845"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="72601845"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:41:40 -0800
X-CSE-ConnectionGUID: BOqtRI9bTA6vsOKpIxFxeQ==
X-CSE-MsgGUID: 9aQX0mhTRQaAIzp3Z8qrFQ==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 18 Feb 2026 08:41:38 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v6 0/8] Add support for L2TPV2 over UDP to ICE PMD
Date: Wed, 18 Feb 2026 22:07:42 +0530
Message-Id: <20260218163750.1408973-1-shaiq.wani@intel.com>
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

This patchset adds L2TPv2 protocol support to the ICE PMD
enabling RSS and Flow Director capabilities for L2TPv2 over UDP traffic.


v6: split patch 3 into 2 seperate patches.
 
v5: Resending v4 patches with correct cover letter and threading.
 
v4: *Version 3 patchset was incomplete due to a server reboot.
    *V4 includes all patches for review.

v3: Fixed compilation issues.

v2: Addressed AI generated comments.


Shaiq Wani (8):
  net/ice: add L2TPv2 PPP and PPoE data structures
  net/ice: add L2TPv2 tunnel type definition
  net/ice: rename protocol identifiers
  net/ice: add L2TPv2 protocol support
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

