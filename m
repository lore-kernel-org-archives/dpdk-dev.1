Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C72C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:30:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8F63402C4;
	Wed, 19 Mar 2025 18:30:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1F7314026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742405409; x=1773941409;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dMdAIwSGcKLpfQ5lnEBthHyJeLaB1rMRF7LLZ3F8+Cg=;
 b=by6+fJdBiWTZiDjfOW3vRR1XGhtstCXIalfu9rx9mk48dkLHLy7WgUBF
 iDBd0hWTj45ecbhizKP0P+JaWMXCnIkjMnS4k9dmc/tZYUQZtntHUe4C2
 LE9m0450DqtSgSW9XjpH2ZcqWIpyKirERyAC8GbLV9XGOmytQCeZUVpF0
 KoN8EQlkZwAo8wYhkwPMPlL6sI8KytsndL3NMSfEbnz33Y0pqpX9rkv5y
 nAxZvkyaUP3qIxe1W6EsQvlkNVZ2bNWN4M7th/4z+Ax1CnXOMuiqa9c2b
 r235lys03EaAwb/9MQR6gdQm7KbX+Amy0O50G72qyOjDtp9N/PgF0c0Li w==;
X-CSE-ConnectionGUID: I6TE98NjTZqgtyyDQFHhwg==
X-CSE-MsgGUID: W+bXxF2NS1+S+0jlNMQdaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43741953"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43741953"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 10:30:06 -0700
X-CSE-ConnectionGUID: QRGEiEndTtKDo3NAR3/y+Q==
X-CSE-MsgGUID: WY93PkxmQuOUABVOufoC9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="153722422"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 10:30:05 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 00/11] remove component-specific logic for AVX builds
Date: Wed, 19 Mar 2025 17:29:30 +0000
Message-ID: <20250319172942.2992053-1-bruce.richardson@intel.com>
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
2.43.0

