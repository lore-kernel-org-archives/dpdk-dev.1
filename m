Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CBCC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:52:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFD0840DDE;
	Thu, 27 Mar 2025 15:52:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4CB5B402E6
 for <dev@dpdk.org>; Thu, 27 Mar 2025 15:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743087134; x=1774623134;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lyqugRMDg4xQQvg3QIZhy6//cU5sSmn0FA/ep7rqXmQ=;
 b=ho1LbsVv6sEpitZbcJoOvqM78YQzghFSyYEVuR0WIy1ZF8RlzvwjoIzK
 oeGcE7rgQxEioHJApiHblGEqgtE5qRcsTWGlpvWIFM8FE10ZNI2zKqbND
 w+G5NCPSX6Ndibdl6lPKouzICenFkPiwqfTZ24vKvCqOiIBx8mONI0jeS
 f9/PoLwg+zOPDCLSZXP3AO0TL17OfQUt8XLzE+ttisBB6FdBAw2H6xebG
 7hqphsQXsiCVlbJSpsXP0psWMseTzfF3WjFNcd8DFZA23lrbsVhkL6NkF
 U3ri38aOFq0/oTwQ6kM1N+htnIUYMzS4OXRHvhlP5w/BP4AI6SWe9/Xoe w==;
X-CSE-ConnectionGUID: nbYZDhqjTUam9OiOk46UnA==
X-CSE-MsgGUID: Ej/rAlIST1CdMQ0OMKW56w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48207060"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="48207060"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:52:13 -0700
X-CSE-ConnectionGUID: 1XBfBZ6pRreidIKZ42CDww==
X-CSE-MsgGUID: bk8SmXzWQpW9uZpS0hK57A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="162399993"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 07:52:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 0/9] net/intel: clean up base code build
Date: Thu, 27 Mar 2025 14:51:52 +0000
Message-ID: <20250327145202.2220153-1-bruce.richardson@intel.com>
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

v3: add fix for lock checker issues on FreeBSD
v2: added missing patch for fm10k

Bruce Richardson (9):
  net/fm10k/base: fix compilation warnings
  net/iavf/base: remove unused meson.build file
  net/ixgbe/base: correct definition of macro
  net/ixgbe/base: fix compilation warnings
  net/ixgbe/base: fix lock checker errors
  net/i40e/base: fix unused value warnings
  net/i40e/base: fix compiler warnings
  net/ice/base: reduce warnings for unused variables
  net/intel: simplify base code builds

 drivers/net/intel/e1000/base/meson.build    |  9 ++-----
 drivers/net/intel/e1000/meson.build         |  4 +--
 drivers/net/intel/fm10k/base/fm10k_mbx.c    |  2 +-
 drivers/net/intel/fm10k/base/fm10k_osdep.h  |  2 +-
 drivers/net/intel/fm10k/base/fm10k_pf.c     |  8 +++---
 drivers/net/intel/fm10k/base/fm10k_type.h   |  6 ++---
 drivers/net/intel/fm10k/base/meson.build    | 21 ++-------------
 drivers/net/intel/fm10k/meson.build         |  4 +--
 drivers/net/intel/i40e/base/i40e_diag.c     |  2 +-
 drivers/net/intel/i40e/base/i40e_nvm.c      |  2 +-
 drivers/net/intel/i40e/base/i40e_osdep.h    |  4 +--
 drivers/net/intel/i40e/base/i40e_type.h     | 14 ++++++----
 drivers/net/intel/i40e/base/meson.build     | 23 ++--------------
 drivers/net/intel/i40e/i40e_ethdev.c        |  1 +
 drivers/net/intel/i40e/meson.build          |  4 +--
 drivers/net/intel/iavf/base/meson.build     | 10 -------
 drivers/net/intel/ice/base/ice_osdep.h      |  6 ++---
 drivers/net/intel/ice/base/ice_switch.c     |  2 --
 drivers/net/intel/ice/base/ice_type.h       |  2 +-
 drivers/net/intel/ice/base/meson.build      |  1 -
 drivers/net/intel/ice/ice_fdir_filter.c     |  2 +-
 drivers/net/intel/idpf/base/meson.build     |  2 +-
 drivers/net/intel/idpf/meson.build          |  7 ++---
 drivers/net/intel/ixgbe/base/ixgbe_common.c |  4 +--
 drivers/net/intel/ixgbe/base/ixgbe_e610.c   |  2 ++
 drivers/net/intel/ixgbe/base/ixgbe_osdep.c  | 20 --------------
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h  | 29 ++++++++++++---------
 drivers/net/intel/ixgbe/base/meson.build    | 20 ++------------
 drivers/net/intel/ixgbe/meson.build         |  4 +--
 29 files changed, 69 insertions(+), 148 deletions(-)
 delete mode 100644 drivers/net/intel/iavf/base/meson.build

--
2.45.2

