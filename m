Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31BCC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00DD44013F;
	Fri, 14 Aug 2026 17:38:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1BB9D400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786721885; x=1818257885;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=68PQKHqRD55E8tpV5M6HS/UcnduDTtkXoZM+tQ6dTS8=;
 b=mML+LGwD7AeTDJo2Agw3A+pnzdyNyd9nwqDG1P8XoQQGUW1eDd1mvn+C
 6dPU2o2EsFC6smLX1BNRklKlIl3LOvPPNLPbwNK6T0jBN/wyPEi3AthM3
 7z8Wq58fJV+TkvOOVaMrEQgj2qRh1hqE9/j7Kk+k7GhKPlAcK81v32YPR
 2QzTL+aOJ86pD3xJicC5s3KTHQEIZZUdJaZFDOAvM8LjtdkN8Og5cCsr+
 3G8rmkCcblhqhyNlDGdwPxWRQeZu6n2fH3FHU4smQBZ7UfgV8A1/O8vRn
 V9s14300ZFrVDU+fY+GKH4nMDRsPypZ+wMhPVCkuZyOUBY8jLce7QBNZq A==;
X-CSE-ConnectionGUID: 6TLqsKgfQdGLmghOgBibBw==
X-CSE-MsgGUID: bFlEAYcXTQeOzfuUA1D8VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87430604"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87430604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:38:03 -0700
X-CSE-ConnectionGUID: SQ3F9s+7T1GHdzVYFH9ulQ==
X-CSE-MsgGUID: 1JvE6y7/R22V7jwSKoxuaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264297071"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 14 Aug 2026 08:38:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/8] remove non-base files from base folders
Date: Fri, 14 Aug 2026 16:37:43 +0100
Message-ID: <20260814153755.940302-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

The base code folders for intel drivers contained the compatibility
*_osdep.h files as well as meson.build files, both of which are
editable via regular DPDK patches. Although the DPDK documentation
allows this arrangement, I (for one) have always found it a little
awkward and confusing to have editable and non-editable files mixed.

For Intel drivers only, this patchset moves osdep file out of base,
and merges the (in most cases trivial) meson.build files from base
into the main driver meson.build file.

After this patch we have a clean separation - any files in base,
with no exceptions, should be updated only via snapshot update
patchsets from Intel. All files outside base are normal DPDK files
that can be modified by any patch.

Bruce Richardson (8):
  net/e1000: move editable files out of base folder
  net/fm10k: move editable files out of base folder
  net/i40e: move editable files out of base folder
  net/iavf: move editable files out of base folder
  net/ice: move editable files out of base folder
  net/idpf: move editable files out of base folder
  net/ixgbe: move editable files out of base folder
  net/ice: consolidate the sources list

 drivers/net/intel/cpfl/cpfl_actions.h         |  2 +-
 drivers/net/intel/cpfl/cpfl_controlq.h        |  2 +-
 drivers/net/intel/e1000/base/README           |  9 ---
 drivers/net/intel/e1000/base/meson.build      | 24 -------
 .../net/intel/e1000/{base => }/e1000_osdep.c  |  0
 .../net/intel/e1000/{base => }/e1000_osdep.h  |  4 +-
 drivers/net/intel/e1000/em_rxtx.c             |  2 +-
 drivers/net/intel/e1000/igc_ethdev.h          |  2 +-
 drivers/net/intel/e1000/meson.build           | 22 ++++++-
 drivers/net/intel/fm10k/base/meson.build      | 11 ----
 .../net/intel/fm10k/{base => }/fm10k_osdep.h  |  4 +-
 drivers/net/intel/fm10k/meson.build           |  9 ++-
 drivers/net/intel/i40e/base/README            |  8 ---
 drivers/net/intel/i40e/base/meson.build       | 12 ----
 .../net/intel/i40e/{base => }/i40e_osdep.h    |  4 +-
 drivers/net/intel/i40e/meson.build            | 10 ++-
 drivers/net/intel/iavf/base/README            |  8 ---
 .../iavf/{base/iavf_impl.c => iavf_osdep.c}   |  0
 .../net/intel/iavf/{base => }/iavf_osdep.h    |  2 +
 drivers/net/intel/iavf/meson.build            |  2 +-
 drivers/net/intel/ice/base/README             |  8 ---
 drivers/net/intel/ice/base/meson.build        | 51 ---------------
 drivers/net/intel/ice/{base => }/ice_osdep.h  |  4 +-
 drivers/net/intel/ice/meson.build             | 62 ++++++++++++++++---
 drivers/net/intel/idpf/base/README            |  8 ---
 drivers/net/intel/idpf/base/meson.build       |  7 ---
 .../net/intel/idpf/{base => }/idpf_osdep.h    |  4 +-
 drivers/net/intel/idpf/idpf_ptp.h             |  2 +-
 drivers/net/intel/idpf/meson.build            |  5 +-
 drivers/net/intel/ixgbe/base/README           |  9 ---
 drivers/net/intel/ixgbe/base/meson.build      | 19 ------
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 12 ++--
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 12 ++--
 .../net/intel/ixgbe/{base => }/ixgbe_osdep.h  |  2 +
 drivers/net/intel/ixgbe/meson.build           | 17 ++++-
 35 files changed, 148 insertions(+), 211 deletions(-)
 delete mode 100644 drivers/net/intel/e1000/base/meson.build
 rename drivers/net/intel/e1000/{base => }/e1000_osdep.c (100%)
 rename drivers/net/intel/e1000/{base => }/e1000_osdep.h (98%)
 delete mode 100644 drivers/net/intel/fm10k/base/meson.build
 rename drivers/net/intel/fm10k/{base => }/fm10k_osdep.h (98%)
 delete mode 100644 drivers/net/intel/i40e/base/meson.build
 rename drivers/net/intel/i40e/{base => }/i40e_osdep.h (98%)
 rename drivers/net/intel/iavf/{base/iavf_impl.c => iavf_osdep.c} (100%)
 rename drivers/net/intel/iavf/{base => }/iavf_osdep.h (98%)
 delete mode 100644 drivers/net/intel/ice/base/meson.build
 rename drivers/net/intel/ice/{base => }/ice_osdep.h (99%)
 delete mode 100644 drivers/net/intel/idpf/base/meson.build
 rename drivers/net/intel/idpf/{base => }/idpf_osdep.h (99%)
 delete mode 100644 drivers/net/intel/ixgbe/base/meson.build
 rename drivers/net/intel/ixgbe/{base => }/ixgbe_osdep.h (99%)

--
2.53.0

