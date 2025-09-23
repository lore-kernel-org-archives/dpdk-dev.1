Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FF0CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 09:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96B174060F;
	Tue, 23 Sep 2025 11:33:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9FEC04021F
 for <dev@dpdk.org>; Tue, 23 Sep 2025 11:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758619985; x=1790155985;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9ds5jaU90enQx5AoVNT6iJYZ4dZR3zH6bq8QjtPK1gk=;
 b=BoO24ns9MGZdwXoEF6ZlKrPs1SeOmjvDuG+yz3jGN+nDdXJ1pqV1CDaP
 9/URTVmPt9q+iW8q4ihc13RPtzystvaAiT0UVHgK+lgI7FxY05w1ycPmz
 SGRUiLUH5Hy/HEBOkaMbDYj3zZQv6CQkfiFDu4XqcDmR0VQ5G0qNrecV0
 TqDga8OJYQxCSeZ+TujLkxuqK8v55nWvYIK8CdroJWABDCMIHbVyyiSz8
 U/z4mHBaN7wmATUeneDScFI8slTkMssKGvsqGfRRiuxPW1Ewn56L0mIZ/
 i+nTVx5X4LrUDEq0MWQ1CFtlItvtyV78rJQgoMlxrxosDTJ7E0Rb5xKlF w==;
X-CSE-ConnectionGUID: wEB4Ytt1RyWO66hDK6VFnw==
X-CSE-MsgGUID: 7HDdHhvLSHiyWzv2UjSBWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86330405"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="86330405"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 02:33:04 -0700
X-CSE-ConnectionGUID: PyBjT3klT8iQjjNyzNZdhw==
X-CSE-MsgGUID: 91yt9CL/QnOofc6JafM+qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="176307812"
Received: from gk6031-gr4-41638.igk.intel.com (HELO
 GK6031-GR4-41638-c04.igk.intel.com) ([10.91.173.62])
 by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2025 02:33:03 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org
Subject: [PATCH v3 0/4] add vcpf pmd support
Date: Tue, 23 Sep 2025 14:54:51 +0200
Message-Id: <20250923125455.1484992-1-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250922141058.1390212-2-praveen.shetty@intel.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
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
---
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
 11 files changed, 635 insertions(+), 83 deletions(-)

-- 
2.37.3

