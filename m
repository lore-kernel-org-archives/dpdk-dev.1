Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8677BC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:35:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E5EC402E7;
	Tue, 18 Mar 2025 18:35:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id B7E7B402DD
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319315; x=1773855315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FA3RJCyZZAfZrkfAbGI7k/pQ2aaJSpm/Dymq36uRJv0=;
 b=FHyfQy19vbDqCFwUzUCw8KkvKZKynCekFq2tGWF3MPIpahaxl2NhMOhV
 778BfONkrU7I1qaQhnq0i1N0oXTs60IxS3d5QA1CPCatI1I40LTTlCtLi
 GvEjaYSAzjZNwcsRfmOA4FqsK+2TXSomuzkvV0PWMfGaWIXN5XycmsHeZ
 yhmHEBDRVeOnFfSSoY/Mn6LqoiczItkJCZlh8hbBdjRBDHQ3B+10kw0FA
 Z0EhWItzfNsl9jBQfvD5y+vZsB3Ha5wKiiZ9+taJsy8lsbeViznWERg3X
 2rbiPyIdA6mXYjWj8gQSHa8+9nGLd/EBXku13IYFwr/ByFldjb9yLzfZi w==;
X-CSE-ConnectionGUID: 5CCLh+CASKmaEWLVZbMU2Q==
X-CSE-MsgGUID: 5STJwluRStmKwPlOc5XhMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42725168"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42725168"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:35:14 -0700
X-CSE-ConnectionGUID: L0YuCmNiTqi/lSjzI6RUeg==
X-CSE-MsgGUID: 0Fe2TnRdQK+spOsZ+cNiWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122312947"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 10:35:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 00/11] remove component-specific logic for AVX builds
Date: Tue, 18 Mar 2025 17:34:53 +0000
Message-ID: <20250318173505.314529-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

v3: add patch for event/dlb2 AVX512 handling.
    add common code for libraries as well as drivers.
v2: add patch 4 to remove use of unnecessary CC_AVX2_SUPPORT flag


Bruce Richardson (11):
  build: add generalized AVX handling for drivers
  net/intel: use common AVX build code
  drivers/net: build use common AVX handling
  drivers/net: remove AVX2 build-time define
  event/dlb2: build using common AVX handling
  build: add generalized AVX handling for libs
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
2.43.0

