Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB0C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 11:55:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E361340261;
	Wed,  5 Feb 2025 12:55:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id EA6CE4025F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 12:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738756544; x=1770292544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1UaN2E10ojOwPRhsAUaKUYcWKYxOBLm/DLMZGNLSg9g=;
 b=AI2aB2+B/l7DLhoqwvvggstoUOI50pmW1+1CRtqbZjRtjWUFxLVvQlmW
 114o1SIhHTyb5ZcHWiIKApOzC/+mFhDl+63vxF9/bdTtnjYrWYzy1RYnw
 sc7KfhpbxXka+COd0hLE/2AGVMVlz6vD5V68UzO7jeASqKjpO58XSgMsX
 HRRnY3w+kiLK9N/1RKNRgysrPxL0ODlH995zYmP9RUYoxu3Ih59f5Yw5s
 hwUjgxERo9mVZYhTVy5N+cYq1Tx5Xnxpzg7aP8Bzl6ZDXUD8kKbHOgFd6
 KujpoanMBqokgTuPzAKRV4QFzhemw0ErpDXWqsMBe1dP4qD6TfEeV3Arm A==;
X-CSE-ConnectionGUID: kdborEJMQXiVSezMoxxQXw==
X-CSE-MsgGUID: geiqqmTyQ+uo5Y9UUoYwaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49568717"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49568717"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 03:55:43 -0800
X-CSE-ConnectionGUID: CNKVGfm7TUOTmszN4vRGpQ==
X-CSE-MsgGUID: NBDMsC5OQgCdaB3tleKsBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141781658"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2025 03:55:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 0/4] remove common iavf and idpf drivers
Date: Wed,  5 Feb 2025 11:55:27 +0000
Message-ID: <20250205115533.2746196-1-bruce.richardson@intel.com>
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

v4: fix meson indentation issue flagged by check-meson.py
v3: add libabigail exclusions for removed libs
v2: include Release note updates

Bruce Richardson (4):
  drivers: merge common and net idpf drivers
  net/idpf: re-enable unused variable warnings
  drivers: move iavf common folder to iavf net
  net/intel: allow building ice driver without iavf

 devtools/libabigail.abignore                  |  2 ++
 doc/guides/rel_notes/release_25_03.rst        |  9 +++++
 drivers/common/iavf/version.map               | 13 -------
 drivers/common/idpf/meson.build               | 34 -------------------
 drivers/common/meson.build                    |  2 --
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
 .../intel/iavf/base}/iavf_prototype.h         |  8 +++++
 .../intel/iavf/base}/iavf_register.h          |  0
 .../intel/iavf/base}/iavf_status.h            |  0
 .../iavf => net/intel/iavf/base}/iavf_type.h  |  0
 .../iavf => net/intel/iavf/base}/meson.build  |  0
 .../iavf => net/intel/iavf/base}/virtchnl.h   |  0
 .../intel/iavf/base}/virtchnl_inline_ipsec.h  |  0
 drivers/net/intel/iavf/meson.build            | 13 ++++---
 drivers/net/intel/iavf/version.map            | 14 ++++++++
 drivers/net/intel/ice/meson.build             | 18 +++++++---
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
 .../intel}/idpf/base/meson.build              |  9 -----
 .../intel}/idpf/base/siov_regs.h              |  0
 .../intel}/idpf/base/virtchnl2.h              |  0
 .../intel}/idpf/base/virtchnl2_lan_desc.h     |  0
 .../intel}/idpf/idpf_common_device.c          |  0
 .../intel}/idpf/idpf_common_device.h          |  0
 .../intel}/idpf/idpf_common_logs.h            |  0
 .../intel}/idpf/idpf_common_rxtx.c            |  2 --
 .../intel}/idpf/idpf_common_rxtx.h            |  0
 .../intel}/idpf/idpf_common_rxtx_avx512.c     |  0
 .../intel}/idpf/idpf_common_virtchnl.c        |  4 +--
 .../intel}/idpf/idpf_common_virtchnl.h        |  0
 drivers/net/intel/idpf/meson.build            | 20 +++++++++--
 .../{common => net/intel}/idpf/version.map    |  0
 drivers/net/meson.build                       |  2 +-
 53 files changed, 78 insertions(+), 74 deletions(-)
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
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx_avx512.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_virtchnl.c (99%)
 rename drivers/{common => net/intel}/idpf/idpf_common_virtchnl.h (100%)
 rename drivers/{common => net/intel}/idpf/version.map (100%)

--
2.43.0

