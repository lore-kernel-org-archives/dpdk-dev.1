Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92FBC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:29:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 084D440270;
	Wed,  5 Feb 2025 19:29:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id BBED140261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:29:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738780169; x=1770316169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sivPI9D+WCOFSrLUmu1Ruw4UPv83ImnpV+Z9fDhd+uE=;
 b=LDTM1Q5XADTD3ixY0UKh3iCBrUIvceZadJXLqJkqP+YbBFHGaSaThEKP
 U/ob5GITiQa2zvLtcW4XLsFBIVG/Ke3XXKOCC7l+CylNdt+xqykyKtG60
 aYpCEnQKQzrwDtGee16GHoBBNWBWj0h/yyxCaiCZ9ngdoIKx85Ki2elVj
 PUMTFOpRH0Qb5ujQFLtbrKJPr48XoFxv5uRuhFlVnS87h4qsC6V/GDGS+
 elwJvx3d5IzwVsspgVU4tkjSN9w3+sGEqrGdeCFMoUclP31Rg1jyU0HEL
 ReF98zjWgzNhbcGkYABVdTUB704vNX0r8pyr7DTPuRAyKaCsZ/tBN51+X A==;
X-CSE-ConnectionGUID: OENWjNXiTrO1/+6NhnJWxQ==
X-CSE-MsgGUID: lU6v+2QaRSGE2Yt3cuuiJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39497013"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="39497013"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 10:29:28 -0800
X-CSE-ConnectionGUID: 0AKmzKCOTKmfsTAB6KFGXA==
X-CSE-MsgGUID: P+Md3G5VSUyW8Xuf0dKK2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="116024265"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 10:29:28 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: john.mcnamara@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 0/2] replace icc support with icx
Date: Wed,  5 Feb 2025 18:29:13 +0000
Message-ID: <20250205182918.4041268-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205161823.2849595-1-bruce.richardson@intel.com>
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
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

The "icc" compiler has been replaced by the newer icx one, so remove
references and workarounds for icc in our codebase. Building with
icx already works, all-be-it with warnings, so we can just fix the
few warnings and report it as supported in our docs in place of icc.

v2:
* include a patch to fix the warnings with icx.

Bruce Richardson (2):
  drivers: fix build warnings when using icx
  build: replace support for icc with icx

 app/test-pmd/testpmd.h                        |  4 ----
 app/test/test_pie.c                           |  5 -----
 app/test/test_red.c                           |  5 -----
 buildtools/check-symbols.sh                   |  6 ++----
 .../contributing/img/patch_cheatsheet.svg     |  2 +-
 doc/guides/linux_gsg/sys_reqs.rst             |  3 +--
 doc/guides/nics/enic.rst                      |  2 +-
 doc/guides/nics/hinic.rst                     |  1 -
 doc/guides/nics/hns3.rst                      |  1 -
 doc/guides/nics/ngbe.rst                      |  1 -
 doc/guides/nics/txgbe.rst                     |  1 -
 doc/guides/prog_guide/lto.rst                 |  2 +-
 .../prog_guide/writing_efficient_code.rst     |  2 +-
 doc/guides/rel_notes/known_issues.rst         | 19 -------------------
 doc/guides/rel_notes/release_25_03.rst        |  5 +++++
 drivers/common/idpf/meson.build               |  3 +++
 drivers/net/ena/ena_ethdev.c                  |  1 -
 drivers/net/intel/i40e/meson.build            |  3 +++
 drivers/net/intel/iavf/meson.build            |  3 +++
 drivers/net/intel/ice/meson.build             |  3 +++
 drivers/net/mlx5/mlx5_rxtx_vec_altivec.h      |  2 +-
 drivers/net/virtio/meson.build                |  2 --
 drivers/net/virtio/virtio_rxtx_packed.h       |  5 -----
 dts/framework/config/__init__.py              |  2 --
 dts/framework/testbed_model/posix_session.py  |  2 --
 lib/eal/common/eal_common_dynmem.c            |  1 -
 lib/eal/include/rte_common.h                  |  6 ++----
 lib/eal/x86/include/rte_rtm.h                 |  2 +-
 lib/eal/x86/include/rte_vect.h                | 15 +--------------
 lib/sched/rte_pie.c                           |  4 ----
 lib/sched/rte_red.c                           |  4 ----
 lib/sched/rte_sched.c                         |  5 -----
 lib/vhost/meson.build                         |  2 --
 lib/vhost/vhost.h                             |  5 -----
 34 files changed, 29 insertions(+), 100 deletions(-)

--
2.43.0

