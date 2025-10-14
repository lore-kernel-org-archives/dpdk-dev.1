Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF6BCCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE573402D3;
	Tue, 14 Oct 2025 12:46:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2EDFB402AE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760438762; x=1791974762;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zlDGkZ3PvnSlFb6M891NDq5p8gmyliZcsFjmfcWRMHA=;
 b=MFAbpYYt3gVbZtV8c6hFAi5n0h9sh+DianOKUuy053V34D88Nc9oyzEy
 xnmb5oYmNEzoIL9bB1grnQdZycQykDuJLnIeBljkRa0lZ7zw1j6hroEua
 Nc0zByd5UpA+Bl9mrSwJ+B2hRoQQV0jQnxLjodQ37CqsSNIC7E9gJVUFw
 7W36qRRYQz6C8DL1vVnxZoORLUuYHv9kLlKgzgUQ5JOzwwJoeZbpYr5XB
 c65lu3HCJHVXTa63QnmqLh5bFWbhTvxVXn05rFrDneN+oeguT1GNiiOrl
 0sPnMbEAWt7c6KT6GCPHvpRyCrax7YhyHfNL9vw+4SH29nro6BQSawtey A==;
X-CSE-ConnectionGUID: Eqjeq+YPTAGjdf9BybZK5Q==
X-CSE-MsgGUID: eb12hds0RgqDsZ8iZclcpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62505251"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62505251"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 03:46:01 -0700
X-CSE-ConnectionGUID: hBBgpM2WTLiGd+/qf3Uc6w==
X-CSE-MsgGUID: HUR4ckwBRTCcHUzOByu9Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="186271265"
Received: from unknown (HELO sprmax19..) ([10.138.182.140])
 by fmviesa005.fm.intel.com with ESMTP; 14 Oct 2025 03:45:59 -0700
From: Venkatesh Vemula <venkatesh.vemula@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, shaiq.wani@intel.com,
 david.marchand@redhat.com, bruce.richardson@intel.com
Subject: [PATCH v7 0/2] net/intel: add IDPF PCI class ID support
Date: Tue, 14 Oct 2025 16:14:41 +0530
Message-Id: <20251014104443.459197-1-venkatesh.vemula@intel.com>
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

