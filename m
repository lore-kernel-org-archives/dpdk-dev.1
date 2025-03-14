Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1846BC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E302640263;
	Fri, 14 Mar 2025 18:23:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 55299400D6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:23:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741973031; x=1773509031;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1z+4sD2WaXw0sT0jlqWtTEiX5/o8H8TtQwpWS3Y1jvo=;
 b=e1Zd9vNvXZHnqJnnWqnu7btUd1zW2RshWv+AOM5Ho/W0d/H66a3YOk/Y
 Y4oTRU3eBkOuKBsMaPF06v6diANkdO+T3z3DikHEgYcTK/rQfXoqsEeaR
 mJnAOc/FDBkPEMAp4wiQ2f9X7Tum4N2yL1gxh35P4O2hEBSZpi6QvCBhW
 nE4zNsHpO0pGfO7/GoRM+1y7u0SFAXgQHhE7TUy5obD7LddI+6BBcMtCo
 0Qp6Lj3D1nD2KJ2GYeG5tgxMUoMfFhNFD0FQZ/tdXVmzVdiONe2+TA+7P
 L6OwSgfsjMzDco+00i0EksZIPUq9qPVqVXyp9hR8/iVkui4VPoICIL3If Q==;
X-CSE-ConnectionGUID: rbq3P4C+SxS1OtPH/nBLmw==
X-CSE-MsgGUID: +T6ZdgTQSp2SDbK0NdIjhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54131610"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="54131610"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 10:23:50 -0700
X-CSE-ConnectionGUID: aYlGSP58RRCm9PQj1QiO+g==
X-CSE-MsgGUID: 3KIsiGNiQWGBjv0woc0FPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="144520934"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa002.fm.intel.com with ESMTP; 14 Mar 2025 10:23:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] remove driver-specific logic for AVX builds
Date: Fri, 14 Mar 2025 17:23:35 +0000
Message-ID: <20250314172339.12777-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

A number of drivers had special optimized AVX2 and AVX512 code paths
for performance reasons, and these tended to have copy-pasted logic
to build those files. Centralise that logic in the main
drivers/meson.build file to avoid duplication.

Bruce Richardson (3):
  build: add generalized AVX handling for drivers
  net/intel: use common AVX build code
  drivers/net: build use common AVX handling

 drivers/meson.build                | 30 ++++++++++++++++++++++++++++++
 drivers/net/bnxt/meson.build       | 10 +---------
 drivers/net/enic/meson.build       | 10 +---------
 drivers/net/intel/i40e/meson.build | 26 ++------------------------
 drivers/net/intel/iavf/meson.build | 25 ++-----------------------
 drivers/net/intel/ice/meson.build  | 25 ++-----------------------
 drivers/net/intel/idpf/meson.build | 25 ++-----------------------
 drivers/net/nfp/meson.build        | 10 +---------
 drivers/net/octeon_ep/meson.build  | 14 ++------------
 drivers/net/virtio/meson.build     |  9 +--------
 10 files changed, 44 insertions(+), 140 deletions(-)

--
2.43.0

