Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868FECCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB0BA402D3;
	Tue, 14 Oct 2025 12:47:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9CF91402AE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760438834; x=1791974834;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zlDGkZ3PvnSlFb6M891NDq5p8gmyliZcsFjmfcWRMHA=;
 b=mmsQel5H8IskQnc5lQkTDb1nxXXOAppOD6+WZ4uQ/UAPo5O+fGP4+a++
 LriAjCVFwgULQBKvR0K0ERCKnwcQYAlqmXqLSeRZUvtUxYvcZqpGLPRR8
 gjUgJjLVHrv5yCKGmMxBhwKTOomiworXsBOOG1cNtL/xx+wWHMZV+VSv8
 j+iqF/saWM2oMaJlmLiIQhmYlzhqBPuVb4AcVzTvwL13spGX5yuJU/RBU
 mVIg2Fp6wB3lzLutsyDBlFgWIGoO8J7wPcGU6K2+XWMJtP8vuZu7++hqK
 HeeFC023AVwwZUHvyXlD9VffWJhk0VZAlNF2KqIxlYdwhkwQnRun7qz8I w==;
X-CSE-ConnectionGUID: U4vigUP5Tki+zjwhqj3f3A==
X-CSE-MsgGUID: rJ4Z0jiNTZqHVxE9oTUK2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66450553"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="66450553"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 03:47:13 -0700
X-CSE-ConnectionGUID: R3GAsyweSyqaNKW7z7CPuQ==
X-CSE-MsgGUID: AjJCVlsST1SY+v6fFat5IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181660401"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 03:47:10 -0700
From: Venkatesh Vemula <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 david.marchand@redhat.com, bruce.richardson@intel.com
Subject: [PATCH v7 0/2] net/intel: add IDPF PCI class ID support
Date: Tue, 14 Oct 2025 16:15:09 +0530
Message-Id: <20251014104511.459215-1-venkatesh.vemula@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919145125.113028-1-venkatesh.vemula@intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
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

 Current IDPF supports only the MEV device IDs. MMG has new set of
 device IDs and same might be the case for the future devices. Instead
 of adding new device IDs every time, make use of the IDPF PCI class
 ID(0x20001) to differentiate between PF and VF.

 Write and read the VF_ARQBAL register to find if the current device is
 a PF or a VF.
 ---
 v2:
 *Renamed macro RTE_PCI_CLASS name to IDPF_PCI_CLASS.
 *Renamed macro IDPF_DEV_ID_CPF to CPFL_DEV_ID_MMG and
  CPFL_DEV_ID_MEV

 v3:
 *Moved cls_id variable in idpf_hw struct to avoid more struct padding.
 *Simplified and moved this check "(hw->device_id == IDPF_DEV_ID_SRIOV)"
  to idpf_is_vf_device function also switch case is removed. returns
  true for VF device and false for PF.
 *Simplified the IDPF_CLASS_NETWORK_ETHERNET_PROGIF macro
  logic with detailed fields "PCI_SUB_BASE_CLASS_NETWORK_ETHERNET"
  and PCI_BASE_CLASS_NETWORK_ETHERNET.

 v4:
  *Fixed code styling errors.
  *Removed cls_id variable in the idpf_hw structure no longer needed.

 v5:
  *Fixed merge conflicts.

 v6:
  *Added name in .mailmap file.
  *changed the sign off name format in commit message.
    
 v7:
  *Split into two patches one of idpf and one of cpfl, as both are
   independent
  *Rebased next-net-intel-for-next-net branch and fixed merge conflict
   and compilation error.
  *Changed macro name IDPF_DEV_ID_CPF to CPFL_DEV_ID_MEV in cpfl code.

Venkatesh Vemula (2):
  net/idpf: add IDPF PCI class ID support
  net/cpfl: added CPFL devID for MMG

 .mailmap                                    |  1 +
 drivers/net/intel/cpfl/cpfl_ethdev.c        | 13 +++++++------
 drivers/net/intel/cpfl/cpfl_ethdev.h        |  5 +++--
 drivers/net/intel/idpf/idpf_common_device.c | 20 ++++++++++++++++++--
 drivers/net/intel/idpf/idpf_common_device.h | 18 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ethdev.c        |  1 +
 6 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.34.1

