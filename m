Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21BC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 15:52:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18047402CD;
	Wed, 26 Mar 2025 16:52:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 66042402A9
 for <dev@dpdk.org>; Wed, 26 Mar 2025 16:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743004358; x=1774540358;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+4TbYZLpu76dKwY5oUhi5+WrIFrktRTvvNDsN9/renw=;
 b=b9X37qY2vXAc1lWh0aNRGdsHP5hixT/VLS+ajdjsFTVMUTJCGqvMo4Nb
 iaz3o10ev0/ZwFHuVCueGwd+r/QKZjlkgAm5Ag12imZNkJiRBIAbv4NDm
 hP/PA2fVdyVXEKR5pXyUjrhynORqNMqKwWSDy7gTHaZuhux/tqjVxu5vZ
 fjp2ISIN+Sdm7IIHL7RrUXGNOijtWGQ4IOW4GCMLERRCGg+OUjJ44W+yW
 8qDLVJxabnu8CsZI889p4kfup1R6maR3QHJsM/RmuAoqTBFmE6q2mWmiJ
 lbeDyWGHbMbXwMaDUhbD1wzNg50F8+9H3VyG6xbziuiPYefmFxby7ZOcG g==;
X-CSE-ConnectionGUID: UmxEmtUuTp6f3GdK83xNSw==
X-CSE-MsgGUID: gtpFNZbXSYizXXrFrwgM5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44188318"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="44188318"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 08:52:37 -0700
X-CSE-ConnectionGUID: vz0ppsr0Rl+WUiWn8aubHg==
X-CSE-MsgGUID: TJLrdMBAQIiPOjjqDwgeVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="124550885"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa009.jf.intel.com with ESMTP; 26 Mar 2025 08:52:36 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/7] net/intel: clean up base code build
Date: Wed, 26 Mar 2025 15:52:22 +0000
Message-ID: <20250326155230.1315056-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

Bruce Richardson (7):
  net/iavf/base: remove unused meson.build file
  net/ixgbe/base: correct definition of macro
  net/ixgbe/base: fix compilation warnings
  net/i40e/base: fix unused value warnings
  net/i40e/base: fix compiler warnings
  net/ice/base: reduce warnings for unused variables
  net/intel: simplify base code builds

 drivers/net/intel/e1000/base/meson.build    |  9 ++------
 drivers/net/intel/e1000/meson.build         |  4 ++--
 drivers/net/intel/fm10k/base/meson.build    |  9 ++------
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
 24 files changed, 56 insertions(+), 103 deletions(-)
 delete mode 100644 drivers/net/intel/iavf/base/meson.build

--
2.45.2

