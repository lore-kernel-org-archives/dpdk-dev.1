Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEBFCAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 06:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30C8C402ED;
	Mon, 22 Sep 2025 08:19:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6C910402EB
 for <dev@dpdk.org>; Mon, 22 Sep 2025 08:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758521955; x=1790057955;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=18987qbbnwbCA4XlT0OMWuhr018Ff6q09udEDn93SwA=;
 b=AEQgxCwjsx12CVrbl+iLyuapDXk2HTdAp1JHeJoWumj716naxbs/kJDG
 M1p17UMXbXDVUkudWT3KX4qS5YhNtYOeZzr0/XLfbO2tHEUx1ox3cpOB2
 Webor/KNd7RNfZZBj75NcVgYj1eKtA2QR7Evr7AssFiTSthj4e+jU+iKH
 8N+BKtFndvcIRlJcXE9rp2jFKlX1m2C23rwa9VoaoTpRztS+WrOeOBK4g
 4vjpDhixnCaU25BrD0H5mcqElj71E9KTaYcv5SV30VyGPYqA+vHaGnx9m
 EGin10CGzuvUWD4NTPMiXMv6LmkN0eoqjXImKJIcfq0C16ziJi6k0v8gN Q==;
X-CSE-ConnectionGUID: d4tvB8yDQM2qqqN0Ztmdrw==
X-CSE-MsgGUID: 3O6WC+4eQf2oD/ehLRiuSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60939088"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="60939088"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2025 23:19:13 -0700
X-CSE-ConnectionGUID: M53DLon5SQeUkNCc/xmLYg==
X-CSE-MsgGUID: f+q/V5beTum6lRj6WG7h8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="207136415"
Received: from gk6031-gr4-41638.igk.intel.com (HELO
 GK6031-GR4-41638-c04.igk.intel.com) ([10.91.173.62])
 by orviesa002.jf.intel.com with ESMTP; 21 Sep 2025 23:19:12 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org
Subject: [PATCH 0/4] add vcpf pmd support
Date: Mon, 22 Sep 2025 11:48:15 +0200
Message-Id: <20250922094819.1350709-1-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
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

Virtual Control Plane Function (vCPF) is a SR-IOV Virtual Function of
the CPF(PF) device.vCPF is used to support  multiple control plane functions.
This patchset is for extending the CPFL PMD to support the new vCPF device.
In this implementaion, both CPFL and the vCPF devices share most of the
initialization routine and share the common data path implementation, which
eliminates code duplication and improving the maintainability of the driver code.

Praveen Shetty (4):
  net/intel: add vCPF PMD support
  net/idpf: add splitq jumbo packet handling
  net/intel: add config queue support to vCPF
  net/cpfl: add cpchnl get vport info support

 drivers/net/intel/cpfl/cpfl_cpchnl.h          |   7 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          | 354 ++++++++++++++++--
 drivers/net/intel/cpfl/cpfl_ethdev.h          | 109 +++++-
 drivers/net/intel/cpfl/cpfl_vchnl.c           | 143 ++++++-
 drivers/net/intel/idpf/base/idpf_osdep.h      |   3 +
 drivers/net/intel/idpf/base/virtchnl2.h       |   3 +-
 drivers/net/intel/idpf/idpf_common_device.c   |   4 +-
 drivers/net/intel/idpf/idpf_common_device.h   |   3 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  50 ++-
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  38 ++
 drivers/net/intel/idpf/idpf_common_virtchnl.h |   3 +
 11 files changed, 629 insertions(+), 88 deletions(-)

-- 
2.37.3

