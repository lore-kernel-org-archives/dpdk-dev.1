Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A32BC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 16:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3997940649;
	Wed, 26 Mar 2025 17:05:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B2455402A9
 for <dev@dpdk.org>; Wed, 26 Mar 2025 17:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743005146; x=1774541146;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W637T5Ww+orXGoh69nPSeuf2rb3A78NJYKk2rZtlqzU=;
 b=N2gzHC2jf1vILYdFPdWpA0xE9wuc3RcEAXoFuhuYb5NiNd66ym5OemPI
 fnv//q0VytnS0ehhc8Zpr4A6B6XFCXc3A9kouBbq9BX6dVBs03ag8IohU
 RBzb8pQbg9HoajXtl52SEkb2EinPtuIeseozz7AMvGYiItvs65nFLyEe2
 nlsdji9C7A6kmu5xNspyu2oqhRDXZfzilpJhMMN+uwMTCf0TkIJQKvd2v
 pr6kS/e4j2ClBwBapMehZfLBHn2ZcjFQP3g+pC4eIpDf9lhBs/hSGmMgl
 +eLg5scwe6seEpZWWbizIFpGoCBHmzzeBQK1D1CpELXHicY36A7ok++xR g==;
X-CSE-ConnectionGUID: OlIZivBgTfqFzlpMwraUMg==
X-CSE-MsgGUID: usLe+rzqRqKpbc1QxSGIiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54954963"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="54954963"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 09:05:45 -0700
X-CSE-ConnectionGUID: zGRuFOi1R8W1Fx7777LlSQ==
X-CSE-MsgGUID: 9Qsk8rZ4RfajE7nqzRPBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="125280712"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa010.fm.intel.com with ESMTP; 26 Mar 2025 09:05:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/8] net/intel: clean up base code build
Date: Wed, 26 Mar 2025 16:05:30 +0000
Message-ID: <20250326160539.1316499-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326155230.1315056-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
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

Simplify the build of the various intel base code directories, by
clearing compiler warnings so the files can be compiled directly along
with the regular driver files.

v2: added missing patch for fm10k

Bruce Richardson (8):
  net/fm10k/base: fix compilation warnings
  net/iavf/base: remove unused meson.build file
  net/ixgbe/base: correct definition of macro
  net/ixgbe/base: fix compilation warnings
  net/i40e/base: fix unused value warnings
  net/i40e/base: fix compiler warnings
  net/ice/base: reduce warnings for unused variables
  net/intel: simplify base code builds

 drivers/net/intel/e1000/base/meson.build    |  9 ++------
 drivers/net/intel/e1000/meson.build         |  4 ++--
 drivers/net/intel/fm10k/base/fm10k_mbx.c    |  2 +-
 drivers/net/intel/fm10k/base/fm10k_osdep.h  |  2 +-
 drivers/net/intel/fm10k/base/fm10k_pf.c     |  8 +++----
 drivers/net/intel/fm10k/base/fm10k_type.h   |  6 +++---
 drivers/net/intel/fm10k/base/meson.build    | 21 ++-----------------
 drivers/net/intel/fm10k/meson.build         |  4 ++--
 drivers/net/intel/i40e/base/i40e_diag.c     |  2 +-
 drivers/net/intel/i40e/base/i40e_nvm.c      |  2 +-
 drivers/net/intel/i40e/base/i40e_osdep.h    |  4 ++--
 drivers/net/intel/i40e/base/i40e_type.h     | 14 ++++++++-----
 drivers/net/intel/i40e/base/meson.build     | 23 ++-------------------
 drivers/net/intel/i40e/i40e_ethdev.c        |  1 +
 drivers/net/intel/i40e/meson.build          |  4 ++--
 drivers/net/intel/iavf/base/meson.build     | 10 ---------
 drivers/net/intel/ice/base/ice_osdep.h      |  6 +++---
 drivers/net/intel/ice/base/ice_switch.c     |  2 --
 drivers/net/intel/ice/base/ice_type.h       |  2 +-
 drivers/net/intel/ice/base/meson.build      |  1 -
 drivers/net/intel/ice/ice_fdir_filter.c     |  2 +-
 drivers/net/intel/idpf/base/meson.build     |  2 +-
 drivers/net/intel/idpf/meson.build          |  7 ++++---
 drivers/net/intel/ixgbe/base/ixgbe_common.c |  4 ++--
 drivers/net/intel/ixgbe/base/ixgbe_e610.c   |  2 ++
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h  | 21 +++++++++++--------
 drivers/net/intel/ixgbe/base/meson.build    | 20 ++----------------
 drivers/net/intel/ixgbe/meson.build         |  4 ++--
 28 files changed, 65 insertions(+), 124 deletions(-)
 delete mode 100644 drivers/net/intel/iavf/base/meson.build

--
2.45.2

