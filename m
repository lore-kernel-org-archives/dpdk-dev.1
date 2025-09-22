Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A2CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 14:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FFDD402A9;
	Mon, 22 Sep 2025 16:11:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7513C4021F
 for <dev@dpdk.org>; Mon, 22 Sep 2025 16:11:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758550265; x=1790086265;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RWtTA9IDaVlFZO2PpJ/YBXtonw1ch8MmWLkfQOKeRl8=;
 b=javYiIT/L4Tcxiy7QtjLxM5Bc//+OTQMmFyvfk1mQhedU/ivqQDZghwk
 kkKiRljf1fpjKNCsQgD5BBbt7NY4TvJnMwrztwiItLNDmyNs9vsOxWlih
 EPJVuW+u5xwodaerXxLTEdeG70gjzrCoAh+1wzWfdyWssrp2XMwzHyyz8
 4URDJH87IzUfgVqVI7zni1cITMNHzYGmf7fRVW9Ni7VlISBOhLibSwpDn
 wWLuXbSqxM4EFD2oNzyZIMSWbSurH14C41cW9seddx96Iw3TOSgzaH11e
 LTmLJnJEjvoCVkkWby/AP6LPRdx0pSbOn5WGUQ+5JumjJnKQe1v2YzM+6 g==;
X-CSE-ConnectionGUID: BNwPaVi8Te+NgHp76U0uhg==
X-CSE-MsgGUID: Y2TZ5+meSr+M7ewBHSnU/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60869733"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; d="scan'208";a="60869733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 07:11:03 -0700
X-CSE-ConnectionGUID: fpjRhIEiSjac05TFzTRSug==
X-CSE-MsgGUID: 7GjjWl1/RxeuyQgjWc6CIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; d="scan'208";a="176560229"
Received: from gk6031-gr4-41638.igk.intel.com (HELO
 GK6031-GR4-41638-c04.igk.intel.com) ([10.91.173.62])
 by orviesa008.jf.intel.com with ESMTP; 22 Sep 2025 07:11:02 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org
Subject: [PATCH v2 0/4] add vcpf pmd support
Date: Mon, 22 Sep 2025 16:10:54 +0200
Message-Id: <20250922141058.1390212-1-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250922094819.1350709-2-praveen.shetty@intel.com>
References: <20250922094819.1350709-2-praveen.shetty@intel.com>
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
v2:
- fixed test case failure
---
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

