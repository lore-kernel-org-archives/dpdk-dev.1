Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16B8C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 11:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E79E7402E3;
	Fri, 28 Mar 2025 12:16:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 53E3A4021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 12:16:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743160590; x=1774696590;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LlnFR8padGMAxmaJ32u4ByyPCImyAqgJHYMO5KqyEmU=;
 b=R5wdAEZOhPkm39HDHoM4b97u9bYPJQll7dCujG8DVk+5+KGjRpxQpXlh
 2k/KGLURUmPXK8XEYUbc2AZXULxIkjhbmaG1ziwl3rq5RWYagl0FgaMbw
 RtPajxNx4N/tsrG/srgwh5Vimsdwl/S+CMB3qAEDsjMsaKCcZglFt6RRF
 7fN76/c0gS+WbOxjY5Np+BrHAOc0k3w9q7HdokbSi2gccEvrsRvQQTTP7
 0+BR1KKSB7jLLNBqk/K5vQwa+3UX54RDYP3n1euFKYacN28mnAn+Hm5fL
 3C74/nUfeTX4DtZpBSEsKmhXJCtAy81MoF0dwFrrezSguLzEtTLZ1AXo0 g==;
X-CSE-ConnectionGUID: 4IHV2a14R0KZRQPHoQQ4Bg==
X-CSE-MsgGUID: cAZsP4lBTa+hGYQ6SG7VhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44435454"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44435454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 04:16:29 -0700
X-CSE-ConnectionGUID: PaQjaTMkReupMT0EmEMh0w==
X-CSE-MsgGUID: eLkhUl1RRe+shfCObm44Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125423272"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa006.jf.intel.com with ESMTP; 28 Mar 2025 04:16:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/9] net/intel: clean up base code build
Date: Fri, 28 Mar 2025 11:16:12 +0000
Message-ID: <20250328111621.2665257-1-bruce.richardson@intel.com>
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

v4: replace all functions in ixgbe_osdep.c with macros, removing file.
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

 drivers/net/intel/e1000/base/meson.build    |  9 +---
 drivers/net/intel/e1000/meson.build         |  4 +-
 drivers/net/intel/fm10k/base/fm10k_mbx.c    |  2 +-
 drivers/net/intel/fm10k/base/fm10k_osdep.h  |  2 +-
 drivers/net/intel/fm10k/base/fm10k_pf.c     |  8 ++--
 drivers/net/intel/fm10k/base/fm10k_type.h   |  6 +--
 drivers/net/intel/fm10k/base/meson.build    | 21 +--------
 drivers/net/intel/fm10k/meson.build         |  4 +-
 drivers/net/intel/i40e/base/i40e_diag.c     |  2 +-
 drivers/net/intel/i40e/base/i40e_nvm.c      |  2 +-
 drivers/net/intel/i40e/base/i40e_osdep.h    |  4 +-
 drivers/net/intel/i40e/base/i40e_type.h     | 14 +++---
 drivers/net/intel/i40e/base/meson.build     | 23 +---------
 drivers/net/intel/i40e/i40e_ethdev.c        |  1 +
 drivers/net/intel/i40e/meson.build          |  4 +-
 drivers/net/intel/iavf/base/meson.build     | 10 -----
 drivers/net/intel/ice/base/ice_osdep.h      |  6 +--
 drivers/net/intel/ice/base/ice_switch.c     |  2 -
 drivers/net/intel/ice/base/ice_type.h       |  2 +-
 drivers/net/intel/ice/base/meson.build      |  1 -
 drivers/net/intel/ice/ice_fdir_filter.c     |  2 +-
 drivers/net/intel/idpf/base/meson.build     |  2 +-
 drivers/net/intel/idpf/meson.build          |  7 +--
 drivers/net/intel/ixgbe/base/ixgbe_common.c |  4 +-
 drivers/net/intel/ixgbe/base/ixgbe_e610.c   |  2 +
 drivers/net/intel/ixgbe/base/ixgbe_osdep.c  | 47 ---------------------
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h  | 39 +++++++++--------
 drivers/net/intel/ixgbe/base/meson.build    | 21 +--------
 drivers/net/intel/ixgbe/meson.build         |  4 +-
 29 files changed, 75 insertions(+), 180 deletions(-)
 delete mode 100644 drivers/net/intel/iavf/base/meson.build
 delete mode 100644 drivers/net/intel/ixgbe/base/ixgbe_osdep.c

--
2.45.2

