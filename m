Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1024BC3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:10:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EE554068A;
	Mon, 31 Mar 2025 18:10:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id E697640689
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437413; x=1774973413;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GC+ze0KW3jDQnvKpoBEOIy++DfqnDRM6UwUG5ThupOo=;
 b=eBw+B9dsvYMHf0FFWrkaMFgQB29Ks1xa643O3qrV1r5IHvHKLkIHpFH6
 d+enKczQBuyfPsX85g7qnhmg1WJ5otJkxQIPVGogq0EYzdluQrKDUp+PR
 QkcfbZOpWo+1Hb81lkM8K1QeJE6+7g3dCXKt1s/qg0EnebgvVaVuTJd26
 IQ7DzLwlGUlXAvfVlIoUeJ6CFQti/jtbodL7xLFXiT+U6WhFoW/GcawMC
 UoF7sftLwDS7PS8xqiUf7qjRPHFUz3K7D3nsbeRCGjM72KzNDZ6G7yxGZ
 1SxtotuApQb3AXggIxAWRYO1y96TkcZD/03inVzVhyoZ+0kjOi2HeIs39 A==;
X-CSE-ConnectionGUID: zzWL9Eb2RbeSxnyEfIiAzA==
X-CSE-MsgGUID: T/zKeWXuQ3eaZuk808mg7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125615"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125615"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:12 -0700
X-CSE-ConnectionGUID: xKrPPp0uStygtuCN9ilNig==
X-CSE-MsgGUID: 6K29AUo6Q4KJuMweqfCJNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132496"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 00/10] centralise base code handling for drivers
Date: Mon, 31 Mar 2025 17:09:49 +0100
Message-ID: <20250331161000.9886-1-bruce.richardson@intel.com>
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

Many DPDK drivers use the same pattern for base code handling, having
a meson.build file in the base code directory which optionally defines
some custom cflags for the base code build, then builds the code as a
static library and extracts the objects from it. (The reason behind this
is that, in meson, cflags apply per-object, so we need to have a
separate build object for the base code to use custom flags)

This patchset deduplicates this logic by putting it into the
drivers/meson.build file, and allowing individual drivers to then just
specify values for "base_sources" and "base_cflags".

Depends-on: Series-34946 ("net/intel: clean up base code build")

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
 drivers/net/intel/ice/base/meson.build  | 22 +++++++---------------
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
 25 files changed, 60 insertions(+), 160 deletions(-)

--
2.45.2

