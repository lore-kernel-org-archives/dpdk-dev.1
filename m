Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D26C3600B
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2589140268;
	Tue, 25 Mar 2025 17:03:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1CB0740150
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918588; x=1774454588;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9uNjbUmPxoTqcZSfIfkmplfDyxbjaqEq3YfB6SXoT2c=;
 b=W3Z9hNPZWj8F/JuoppGi/s3OCgwIRTMkFNI2IfP9nt8uk7uvYosrKBdK
 K2Ja2O8FJYWiuArOZZ3i4wUjO8PTFPbeWm2KNs2QxkG69uK3Jfr8D+2ya
 8gF2EpYEQjIs+4G24LqZlm7WhrJd+EekQ6GUjpeV081qiRdMZxx1WnLY4
 9UFVHIsdtegzIhb9otRb9LwCLcmwR1xixKNVPGsktACTftDtw4NU1FRKV
 Sd2qV6ApAuju5kt5vPPlGK6TSQSoFjg5PXlIv77oG3hMi9XA+97VQwUwo
 DOY6VOXiYjt2C5wj0Xsw5Ols2znGb6cHMfNlhQL4XJidV94ysUBYybTEo w==;
X-CSE-ConnectionGUID: cd8S/tDGShmYKSHQCdhMNg==
X-CSE-MsgGUID: 5FrAmw/IT7+jQrMRz/tGxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565686"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565686"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:01 -0700
X-CSE-ConnectionGUID: uukt1jv7RYqvlkVqrvV3NA==
X-CSE-MsgGUID: bFEJ07fQQzyYxJq+7Dv4uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086519"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:02:59 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 00/11] remove component-specific logic for AVX builds
Date: Tue, 25 Mar 2025 16:02:42 +0000
Message-ID: <20250325160254.1724560-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250314172339.12777-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
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

A number of libs and drivers had special optimized AVX2 and AVX512 code
paths for performance reasons, and these tended to have copy-pasted
logic to build those files. Centralise that logic in the main
drivers/ and lib/ meson.build files to avoid duplication.

v5: fix RTE_ARCH_X86 macro, which broke crc library
v4: rebase on latest main branch
    minor fixes following feedback
    limit use of -march=skylake-avx512 to when we don't already have a
      -march flag supporting AVX512.
v3: add patch for event/dlb2 AVX512 handling.
    add common code for libraries as well as drivers.
v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag


Bruce Richardson (11):
  drivers: add generalized AVX build handling
  net/intel: use common AVX build code
  drivers/net: build use common AVX handling
  drivers/net: remove AVX2 build-time define
  event/dlb2: build using common AVX handling
  lib: add generalized AVX build handling
  acl: use common AVX build handling
  fib: use common AVX build handling
  net: simplify build-time logic for x86
  net: use common AVX512 build code
  member: use common AVX512 build support

 drivers/event/dlb2/dlb2_sse.c         |  4 ++
 drivers/event/dlb2/meson.build        | 16 +-------
 drivers/meson.build                   | 30 ++++++++++++++
 drivers/net/bnxt/bnxt_ethdev.c        |  2 -
 drivers/net/bnxt/meson.build          | 10 +----
 drivers/net/enic/meson.build          | 10 +----
 drivers/net/intel/i40e/meson.build    | 26 +-----------
 drivers/net/intel/iavf/meson.build    | 25 +-----------
 drivers/net/intel/ice/meson.build     | 25 +-----------
 drivers/net/intel/idpf/meson.build    | 25 +-----------
 drivers/net/nfp/meson.build           | 10 +----
 drivers/net/octeon_ep/meson.build     | 13 +-----
 drivers/net/octeon_ep/otx_ep_ethdev.c |  4 --
 drivers/net/virtio/meson.build        |  9 +----
 lib/acl/meson.build                   | 54 ++-----------------------
 lib/fib/dir24_8.c                     |  6 +--
 lib/fib/meson.build                   | 18 +--------
 lib/fib/trie.c                        |  6 +--
 lib/member/meson.build                | 46 ++++-----------------
 lib/meson.build                       | 34 +++++++++++++++-
 lib/net/meson.build                   | 58 +++------------------------
 lib/net/rte_net_crc.c                 | 16 ++++----
 22 files changed, 114 insertions(+), 333 deletions(-)

--
2.45.2

