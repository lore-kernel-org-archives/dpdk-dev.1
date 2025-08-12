Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4DBCA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C12540270;
	Tue, 12 Aug 2025 19:33:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 07896400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 19:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755019978; x=1786555978;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fO1b7+oRt+WahohWrxGTinDlNWTEzl39S1mhlS71ETQ=;
 b=X4rQtdQpUG9pEiSS+zMsqm8NBvgklDeQJie+FhW7B1rmMc34G8W31HDR
 GvlJWg0rwRfEU4gq4GLDlX4pngbNawaCcUxK+78vuJpkhFiOVAJN+F2zm
 S8JymOObW5UtnKqnPQlpFiJgJdUDbxi9GyEfxfc6Ke0q6TwOXvmZCNmBh
 Tw5Ve0gm7APKnhzJzGkKXrlHJRuBFGO6kOKi998+G0OlaLVfuIAOwKRba
 LeL1JLh4+Slp+beA2DKwdIxF5TywnJth/heuMjrsTqkZcFvgOzNgCctYp
 +Es1wDKkC+DgOtzU8Gm++ZeQhZ30rd8ACu+lZuZ/f+KVsvqpTGE50TR3G w==;
X-CSE-ConnectionGUID: v2ZGQnexSziYIMR4vt1EaA==
X-CSE-MsgGUID: pKu30uUAR3uVOG+DsJl3aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74751864"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="74751864"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 10:32:57 -0700
X-CSE-ConnectionGUID: KANMMKPyRnm+GzCm8jHPsw==
X-CSE-MsgGUID: YxDQrS74QySKm9qbTnAXdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="170472888"
Received: from unknown (HELO silpixa00401176.ger.corp.intel.com)
 ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 10:32:55 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v3 0/6] Enable DCB/PFC support for ICE PMD
Date: Tue, 12 Aug 2025 17:32:46 +0000
Message-ID: <20250812173252.507954-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811134301.459523-1-vladimir.medvedkin@intel.com>
References: <20250811134301.459523-1-vladimir.medvedkin@intel.com>
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

This series introduces an initial implementation of DCB and PFC to the ICE PMD.
This includes adding support for TCs in ice_aq_set_mac_cfg() and asymmetric DCB/PFC configuration in base code.

Current implementation relies on current API and has a number of limitation and assumptions such as:

- Symmetric DCB configuration with respect to RX/TX, only dcb_rx_conf is used
- All TCs are configured equally with respect to BW they share
- No support for Low Latency TCs
- All existing queues are split evenly across TCs. Number of queues must be power of 2 and be no less than configured nb_tcs
- TX queues assigned to TCs the same way as RX queues

v3:
 - ice_get_tc_by_up() is renamed to ice_get_tc_by_priority() for better clarity
 - added ice_aq_set_mac_pfc_cfg(). Old ice_aq_set_mac_cfg() is a wrapper around a new function to keep better backward compatibility with an old code
 - removed rte_memcpy() and memcry() with direct assignment
 - addressed various style-related comments

v2:
 - fix spelling
 - replace rte_memcpy with memcpy()
 - fix endianness in several places


Vladimir Medvedkin (6):
  net/ice/base: add utility functions
  net/ice/base: make set MAC config TC aware
  net/ice/base: add support for asymmetric PFC
  net/ice: enable DCB support
  net/ice: enable PFC support
  net/ice: add PFC statistics

 drivers/net/intel/ice/base/ice_common.c | 197 ++++++++++---
 drivers/net/intel/ice/base/ice_common.h |  11 +
 drivers/net/intel/ice/base/ice_dcb.c    |  96 +++++-
 drivers/net/intel/ice/base/ice_dcb.h    |  16 +-
 drivers/net/intel/ice/base/ice_type.h   |   2 +
 drivers/net/intel/ice/ice_ethdev.c      | 370 ++++++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.c        |  21 ++
 7 files changed, 655 insertions(+), 58 deletions(-)

-- 
2.43.0

