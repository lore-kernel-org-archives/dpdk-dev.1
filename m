Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E97DCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 18:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E62F4025F;
	Tue, 30 Sep 2025 20:27:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8340140151
 for <dev@dpdk.org>; Tue, 30 Sep 2025 20:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759256844; x=1790792844;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gFOs8+Hihs7SFRmWDdAIfkI2bhuMIj4NnWBY0D5CWmA=;
 b=OywUY2sylATd+nXDCvgMR7ghqf1ym7WD6RTgeXDj+VQpAES7BRLck2oD
 7Cvm95+JjIoOAK+Iz+SrbeA69BSe+FOhOAKjfbFUsuUtVku9lN1chCIWO
 qO4iyRqFGUYucwOx4+t7YEQt4wBFt0YDd6Yq8ub+N0IWeOlh3Q5yb/yE2
 z/wz8mR1gMvDcEaS4D8B5S8tMyjHe+UdBViv3DUmODNbJFR1AdU7NGuX9
 NtVgYG6jBbqGElpg4Lq/tglE3mfn7XtEjZ8/hnXI/MD3qOvlX2NsiepZh
 lIJNoTSKGZY0N1calxNHjPNqn6MMMjC0ulIA2Eqa+aSys+LLaFsaq84Hn Q==;
X-CSE-ConnectionGUID: 2Mxy2F2WSAqWXfh3xv+byg==
X-CSE-MsgGUID: y5TpIt4vS+qRGVU38dESEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61414232"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="61414232"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 11:27:21 -0700
X-CSE-ConnectionGUID: wLXDahBERZmcq0P/zOLv7A==
X-CSE-MsgGUID: v2mF+mhSSRmUaVHxNCm2sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="178980540"
Received: from gk3153-pr3-41011.igk.intel.com (HELO
 GK3153-PR3-41011-c0b.igk.intel.com) ([10.123.200.84])
 by fmviesa008.fm.intel.com with ESMTP; 30 Sep 2025 11:27:21 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org
Subject: [PATCH v5 0/4] add vcpf pmd support
Date: Tue, 30 Sep 2025 20:27:14 +0200
Message-Id: <20250930182718.2997819-1-praveen.shetty@intel.com>
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
v5:
- fixed merge conflicts 
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

