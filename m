Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC9ECCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 12:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C6240277;
	Fri,  3 Oct 2025 14:40:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0DABD4025D
 for <dev@dpdk.org>; Fri,  3 Oct 2025 14:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759495242; x=1791031242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gzvE3fmYhlYtML/WqEtJWTbpe+53q7k4tIwe7qXIg3k=;
 b=J3Ukt/y0i7bANIs6Wf+br/p3yj4ELGYDDELF617OLj1KYlVXmbQ4DU7f
 4Q4h0zCo6RCR0cic78tHoqMF0z2Oln0U7H5CF4SU1vUOe+5DoluEgtDg1
 NHnHb0bYuT8AKas9nN0URrP+BULqSdI85VBAEdv9ktZT1BWN2ksPvJ8Ed
 sLoEZC9lEk2sOXX9vzaHNRPBGZc2xlqEQIVXkOcI4fqXSd0F6lZRgSDmr
 fsjzeBcQbV0oulbPrQrBmcdMj2k6lEzJ31dPu0PFxCtUZIajrYm3qtrnp
 3O4Oe/DEZGQr4sG0etS3qN7aDSMyh0L1kTjaFSfxCFI8j6PklkcakKsTv A==;
X-CSE-ConnectionGUID: jSlFpeENSKmYAnQNqanPfA==
X-CSE-MsgGUID: i6toGujoQHeeE+oGXaOK4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="72395403"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72395403"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 05:40:41 -0700
X-CSE-ConnectionGUID: wX9Ss5J5TjatXP7LzYOx2A==
X-CSE-MsgGUID: jNSJinzsR7m9GC6/9BoxrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="178572346"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa010.jf.intel.com with ESMTP; 03 Oct 2025 05:40:40 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v5 0/3] Enable DCB/PFC support for ICE PMD
Date: Fri,  3 Oct 2025 12:40:34 +0000
Message-ID: <20251003124037.342760-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
References: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
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

v5:
- drop base code patches
- rebase on top of the next-net

v4:
- fix more endianness

v3:
 - ice_get_tc_by_up() is renamed to ice_get_tc_by_priority() for better clarity
 - added ice_aq_set_mac_pfc_cfg(). Old ice_aq_set_mac_cfg() is a wrapper around a new function to keep better backward compatibility with an old code
 - removed rte_memcpy() and memcry() with direct assignment
 - addressed various style-related comments

v2:
 - fix spelling
 - replace rte_memcpy with memcpy()
 - fix endianness in several places

Vladimir Medvedkin (3):
  net/ice: enable DCB support
  net/ice: enable PFC support
  net/ice: add PFC statistics

 drivers/net/intel/ice/ice_ethdev.c | 370 +++++++++++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.c   |  21 ++
 2 files changed, 391 insertions(+)

-- 
2.43.0

