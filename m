Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB66C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:25:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F63A40A89;
	Mon,  7 Apr 2025 17:25:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 4659A40A7F
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039516; x=1775575516;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sm6njZvVR6ZCF5sp+CH0YPzP48+Ht5/InsPlbXF1d4k=;
 b=LdiPh+OLqNuov11b3Hd6TNBpopGidaLKVRVYrsqcpiFxhSeBA5nsUJLd
 km0ZCZ4LEZ71uITwg1ltSvNULaPScgCG9v1/jwIdZDxK1n2Zsms1kfgbU
 L7ked/xpArVpn2L6gP/hu/UHfP2wJz7dDjYATKLDAvY5wVR1Dt2Gd0GwG
 di68G4KiYTXnr5DaXifTa/LfosiWT7w01Gf7piv6d1DLS7NwhBgBAdttv
 C+aQG/8aPpmzH06YDnvsJ8ScNgZwHq9pkb25jt+wBtQz/UKbw7DCOLT+5
 dplXc9vIlSviHIQwMhMtTtPDu+b+1BbdJxnHFub3PDo5C3jDmP58eQKdy w==;
X-CSE-ConnectionGUID: VulaE6bLQ5mRZ8a1qNB6yQ==
X-CSE-MsgGUID: 24WmsYmfSAa4a4l5qqM+bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809359"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809359"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:15 -0700
X-CSE-ConnectionGUID: So9vPNmYRmywXIHzhsaeoQ==
X-CSE-MsgGUID: H2S1iNkgR7qB86E6YeO0gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125563"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 00/10] centralize base code handling for drivers
Date: Mon,  7 Apr 2025 16:24:59 +0100
Message-ID: <20250407152509.2203243-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250331161000.9886-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
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

Many DPDK drivers use the same pattern for base code handling, having
a meson.build file in the base code directory which optionally defines
some custom cflags for the base code build, then builds the code as a
static library and extracts the objects from it. (The reason behind this
is that, in meson, cflags apply per-object, so we need to have a
separate build object for the base code to use custom flags)

This patchset deduplicates this logic by putting it into the
drivers/meson.build file, and allowing individual drivers to then just
specify values for "base_sources" and "base_cflags".

v2:
* rebase on latest main
* fix inclusion of accident diff in v1

Bruce Richardson (10):
  build: add generic support for base code in drivers
  common/sfc_efx: use common base code build handling
  net/hinic: use common base code build handling
  net/intel: use common base code build handling
  net/ngbe: use common base code build handling
  net/octeontx: use common base code build handling
  net/qede: use common base code build handling
  net/thunderx: use common base code build handling
  net/txgbe: use common base code build handling
  raw/ifpga: use common base code build handling

 drivers/common/sfc_efx/base/meson.build | 18 +++---------------
 drivers/common/sfc_efx/meson.build      |  3 ---
 drivers/meson.build                     | 20 ++++++++++++++++++++
 drivers/net/hinic/base/meson.build      | 16 +++++-----------
 drivers/net/hinic/meson.build           |  1 -
 drivers/net/intel/e1000/meson.build     |  3 ---
 drivers/net/intel/fm10k/meson.build     |  3 ---
 drivers/net/intel/i40e/meson.build      |  2 --
 drivers/net/intel/iavf/meson.build      |  1 -
 drivers/net/intel/ice/base/meson.build  | 13 +++----------
 drivers/net/intel/ice/meson.build       |  2 --
 drivers/net/intel/idpf/meson.build      |  1 -
 drivers/net/intel/ixgbe/meson.build     |  3 ---
 drivers/net/ngbe/base/meson.build       | 12 ++----------
 drivers/net/ngbe/meson.build            |  3 ---
 drivers/net/octeontx/base/meson.build   | 19 +------------------
 drivers/net/octeontx/meson.build        |  3 ---
 drivers/net/qede/base/meson.build       | 17 +++++------------
 drivers/net/qede/meson.build            |  1 -
 drivers/net/thunderx/base/meson.build   | 10 +---------
 drivers/net/thunderx/meson.build        |  3 ---
 drivers/net/txgbe/base/meson.build      | 18 ++----------------
 drivers/net/txgbe/meson.build           |  3 ---
 drivers/raw/ifpga/base/meson.build      | 21 ++-------------------
 drivers/raw/ifpga/meson.build           | 15 ++++++++++++---
 25 files changed, 56 insertions(+), 155 deletions(-)

--
2.45.2

