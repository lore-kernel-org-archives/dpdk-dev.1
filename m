Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB5C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:44:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06785427A0;
	Mon, 10 Feb 2025 17:44:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3859E42794
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739205876; x=1770741876;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RNGmMBLgSI4YiG5DWqw/nLbckWTg6Pfoo1X+tTS7P2E=;
 b=fh1iPGrg4EzOrDyfoR1mHPmYKJ4Rdxk+lbnwxk5MhbZeCByf9By/g665
 GAXWkTEPxj4Oh+SnWF4tRnDgH1xxqealB1PN/86+kQOVn6Ug6EXG2lsSB
 6BuzQ8gy6Ox9M0MlGbFHl46BYQY/PYcO/jvizc813i9X1A5Hjakj4pTU6
 qZ6N85QOgE37SwSQ+2Fezo4+NbXN92JiUGbM1gOR3ISRdZW9KrYu4OxCw
 PGpv4xVpIeU0Ts4xTxJ2uji0VK/elzPxs8FBlQZ6+vQL80vPnsAMkOGmy
 kSDl1Tj9KuyDD5SIARdVI+IqVX6vqb0E3xpuiFVjkbKHGq7Gn4nu+aaQP g==;
X-CSE-ConnectionGUID: /GGLXIgNRVWwYZSri8soxQ==
X-CSE-MsgGUID: h/TRFNc1T5WUJcbOmJnpGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43453703"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="43453703"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 08:44:34 -0800
X-CSE-ConnectionGUID: yI4+oRflTdCr2R8wOO5KVA==
X-CSE-MsgGUID: eES5lw3oQcCg+dxK2RJeVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="112753331"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa010.fm.intel.com with ESMTP; 10 Feb 2025 08:44:32 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 0/4] remove common iavf and idpf drivers
Date: Mon, 10 Feb 2025 16:44:22 +0000
Message-ID: <20250210164427.1118265-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128163649.343336-1-bruce.richardson@intel.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
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

The iavf and idpf common directories were used only to share code
between multiple net drivers and did not need to be drivers in their own
right, since it is just as easy to have a dependency from one net driver
on another as a net driver on a common one.

This patchset therefore aims to eliminate the two unnecessary common
drivers. It does so as follows:

* merging common/idpf into net/idpf and updating the cpfl dependency to
  point to the net driver.
* merging common/iavf into net/iavf and similarly updating the
  dependencies, including the paths from idpf (which does not directly
  depend on iavf, but does make use of the definitions in the iavf
  header files).

Separately, two other cleanups are done - one to remove an unnecessary
warning disable flag. The second is a little more complex - it makes the
dependency between ice and iavf an optional one, by having ice compile
in the necessary iavf shared code files in case iavf is disabled in the
build.

v5: rebase on top of next-net-intel tree
v4: fix meson indentation issue flagged by check-meson.py
v3: add libabigail exclusions for removed libs
v2: include Release note updates

Bruce Richardson (4):
  drivers: merge common and net idpf drivers
  net/idpf: re-enable unused variable warnings
  drivers: move iavf common folder to iavf net
  net/intel: allow building ice driver without iavf

 devtools/libabigail.abignore                  |  2 +
 doc/guides/rel_notes/release_25_03.rst        |  9 ++++
 drivers/common/iavf/version.map               | 13 ------
 drivers/common/idpf/meson.build               | 41 -------------------
 drivers/common/meson.build                    |  2 -
 drivers/net/intel/cpfl/meson.build            |  2 +-
 .../iavf => net/intel/iavf/base}/README       |  0
 .../intel/iavf/base}/iavf_adminq.c            |  0
 .../intel/iavf/base}/iavf_adminq.h            |  0
 .../intel/iavf/base}/iavf_adminq_cmd.h        |  0
 .../iavf => net/intel/iavf/base}/iavf_alloc.h |  0
 .../intel/iavf/base}/iavf_common.c            |  0
 .../intel/iavf/base}/iavf_devids.h            |  0
 .../iavf => net/intel/iavf/base}/iavf_impl.c  |  0
 .../iavf => net/intel/iavf/base}/iavf_osdep.h |  0
 .../intel/iavf/base}/iavf_prototype.h         |  8 ++++
 .../intel/iavf/base}/iavf_register.h          |  0
 .../intel/iavf/base}/iavf_status.h            |  0
 .../iavf => net/intel/iavf/base}/iavf_type.h  |  0
 .../iavf => net/intel/iavf/base}/meson.build  |  0
 .../iavf => net/intel/iavf/base}/virtchnl.h   |  0
 .../intel/iavf/base}/virtchnl_inline_ipsec.h  |  0
 drivers/net/intel/iavf/meson.build            | 13 ++++--
 drivers/net/intel/iavf/version.map            | 14 +++++++
 drivers/net/intel/ice/meson.build             | 18 ++++++--
 .../{common => net/intel}/idpf/base/README    |  0
 .../intel}/idpf/base/idpf_alloc.h             |  0
 .../intel}/idpf/base/idpf_controlq.c          |  0
 .../intel}/idpf/base/idpf_controlq.h          |  0
 .../intel}/idpf/base/idpf_controlq_api.h      |  0
 .../intel}/idpf/base/idpf_controlq_setup.c    |  0
 .../intel}/idpf/base/idpf_devids.h            |  0
 .../intel}/idpf/base/idpf_lan_pf_regs.h       |  0
 .../intel}/idpf/base/idpf_lan_txrx.h          |  0
 .../intel}/idpf/base/idpf_lan_vf_regs.h       |  0
 .../intel}/idpf/base/idpf_osdep.h             |  0
 .../intel}/idpf/base/idpf_prototype.h         |  0
 .../intel}/idpf/base/idpf_type.h              |  0
 .../intel}/idpf/base/meson.build              |  9 ----
 .../intel}/idpf/base/siov_regs.h              |  0
 .../intel}/idpf/base/virtchnl2.h              |  0
 .../intel}/idpf/base/virtchnl2_lan_desc.h     |  0
 .../intel}/idpf/idpf_common_device.c          |  0
 .../intel}/idpf/idpf_common_device.h          |  0
 .../intel}/idpf/idpf_common_logs.h            |  0
 .../intel}/idpf/idpf_common_rxtx.c            |  2 -
 .../intel}/idpf/idpf_common_rxtx.h            |  0
 .../intel}/idpf/idpf_common_rxtx_avx2.c       |  0
 .../intel}/idpf/idpf_common_rxtx_avx512.c     |  0
 .../intel}/idpf/idpf_common_virtchnl.c        |  4 +-
 .../intel}/idpf/idpf_common_virtchnl.h        |  0
 drivers/net/intel/idpf/meson.build            | 31 ++++++++++++--
 .../{common => net/intel}/idpf/version.map    |  0
 drivers/net/meson.build                       |  2 +-
 54 files changed, 88 insertions(+), 82 deletions(-)
 delete mode 100644 drivers/common/iavf/version.map
 delete mode 100644 drivers/common/idpf/meson.build
 rename drivers/{common/iavf => net/intel/iavf/base}/README (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_adminq.c (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_adminq.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_adminq_cmd.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_alloc.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_common.c (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_devids.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_impl.c (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_osdep.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_prototype.h (94%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_register.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_status.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_type.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/meson.build (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/virtchnl.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/virtchnl_inline_ipsec.h (100%)
 rename drivers/{common => net/intel}/idpf/base/README (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_alloc.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_controlq.c (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_controlq.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_controlq_api.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_controlq_setup.c (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_devids.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_lan_pf_regs.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_lan_txrx.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_lan_vf_regs.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_osdep.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_prototype.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_type.h (100%)
 rename drivers/{common => net/intel}/idpf/base/meson.build (51%)
 rename drivers/{common => net/intel}/idpf/base/siov_regs.h (100%)
 rename drivers/{common => net/intel}/idpf/base/virtchnl2.h (100%)
 rename drivers/{common => net/intel}/idpf/base/virtchnl2_lan_desc.h (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_device.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_device.h (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_logs.h (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx.c (99%)
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx.h (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx_avx2.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx_avx512.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_virtchnl.c (99%)
 rename drivers/{common => net/intel}/idpf/idpf_common_virtchnl.h (100%)
 rename drivers/{common => net/intel}/idpf/version.map (100%)

--
2.43.0

