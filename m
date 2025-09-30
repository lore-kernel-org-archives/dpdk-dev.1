Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3610DCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 13:56:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 204144025F;
	Tue, 30 Sep 2025 15:56:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4F13240151
 for <dev@dpdk.org>; Tue, 30 Sep 2025 15:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759240560; x=1790776560;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VooR7bBryhkwyKQRd2pOhAohVkFqFkZlSkKrrlNiCTs=;
 b=CfiSbx+u3gVvfqNm4RHGV+32+Yc2TPx3SgzgF5TFYHp5kCZe1mBxqsR7
 AQdegACtnl1BIU0gyPBGxN7pe9dD3zvdxTxcBVE/kRsmJe2IVg60LQlcu
 YKjQl27NR7UKPaaJlQ5vARUTp0bqrivEG1WReZOd7Nx9TxwW4IcSAo5ua
 Jwp4voo5Zq9I5eVBytLYPKBOVKgHCcNSYfQTEq7gM9MO04UQAvmO4rIYe
 7U2LYsvyoui2w8RIp83lnjFzkxPoJER3yD10BoSzbq0aNiZLyLXG8V3J5
 ogRASQ4t0UPNZ+s2ENwtXPSONjWM8JyU8yvLhf4TxJQI3WopfYdXtq6q4 g==;
X-CSE-ConnectionGUID: JiveUNf8R/OMAJMfROUw/g==
X-CSE-MsgGUID: vM/b1G4MSN2RwuR8pfOy/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="49058311"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="49058311"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 06:55:59 -0700
X-CSE-ConnectionGUID: MZ8P29nhQYGyu/Yz0wdJ1w==
X-CSE-MsgGUID: XdwTKw2FREihkhgjKXEn+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="178933652"
Received: from gk3153-pr3-41011.igk.intel.com (HELO
 GK3153-PR3-41011-c0b.igk.intel.com) ([10.123.200.84])
 by fmviesa009.fm.intel.com with ESMTP; 30 Sep 2025 06:55:58 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org
Subject: [PATCH v4 0/4] add vcpf pmd support
Date: Tue, 30 Sep 2025 15:55:52 +0200
Message-Id: <20250930135556.2861075-1-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250922094819.1350709-2-praveen.shetty@intel.com>
References: <20250922094819.1350709-2-praveen.shetty@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
---
v4:
- addressed review comments
v3:
- fixed cpchnl2_func_type enum for PF device
v2:
- fixed test case failure
---
Praveen Shetty (4):
  net/intel: add vCPF PMD support
  net/idpf: add splitq jumbo packet handling
  net/intel: add config queue support to vCPF
  net/cpfl: add cpchnl get vport info support

 drivers/net/intel/cpfl/cpfl_cpchnl.h          |   8 +
 drivers/net/intel/cpfl/cpfl_ethdev.c          | 356 ++++++++++++++++--
 drivers/net/intel/cpfl/cpfl_ethdev.h          | 108 +++++-
 drivers/net/intel/cpfl/cpfl_vchnl.c           | 143 ++++++-
 drivers/net/intel/idpf/base/idpf_osdep.h      |   3 +
 drivers/net/intel/idpf/base/virtchnl2.h       |   3 +-
 drivers/net/intel/idpf/idpf_common_device.c   |   4 +-
 drivers/net/intel/idpf/idpf_common_device.h   |   3 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  48 ++-
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  38 ++
 drivers/net/intel/idpf/idpf_common_virtchnl.h |   3 +
 11 files changed, 634 insertions(+), 83 deletions(-)

-- 
2.37.3

