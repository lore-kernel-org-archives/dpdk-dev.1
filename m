Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544CACAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 09:50:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20DC7402AF;
	Fri,  3 Oct 2025 11:50:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id CDBD040262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 11:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759485019; x=1791021019;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4yqxU8R/KL5JtPfjwihnjYreWYvKeDijP508EgODHro=;
 b=nV28PC8nIeUquRIyt7/OizrHfeWg5MJvA4J+BtXaNdVSXbchDeHEUj7K
 vaMZF4y1iEJw9ryfg0T2+EJWb7KY/PhI8u8AB2q1lACndvhl7dWsh1mbg
 POMUOpeUe7fUwLta8I2gthtbuVG3n1X0h0FswCJKHhGQ6UtFLrlfH70Kj
 Mra5QeKVegY1eJ38Mnx8Mk9/i+0bES/PT0chyR4IUKVbhzOhIaLmdiLjR
 clt/SWIyujX+UTkFY4fWWLN65MYVUiGj5EvyBJ+K3Wf6RyUX5r1oXI+4E
 phiNASpqzqDx6PvANvlDQUGYhrqbrVxw0N9lIndGA4UpNQq4VO+n4wMCk g==;
X-CSE-ConnectionGUID: o2GI0BoESyaX92pGhG6NkA==
X-CSE-MsgGUID: 4BaSZ8MBT4iKZIX7bdCuIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="87223205"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="87223205"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 02:50:17 -0700
X-CSE-ConnectionGUID: lVDll5rmTzyRS+glUuKBhQ==
X-CSE-MsgGUID: ewJKy4t2TCeGh/AGqZlRHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179064874"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 03 Oct 2025 02:50:16 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v6 0/2] net/idpf: enable AVX2 for split queue Rx/Tx
Date: Fri,  3 Oct 2025 15:19:48 +0530
Message-Id: <20251003094950.2818019-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917052658.582872-1-shaiq.wani@intel.com/>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

In the single queue model, the same descriptor queue is used by SW
to post descriptors to the device and used by device to report completed
descriptors to SW. While as the split queue model separates them into
different queues for parallel processing and improved performance.

v6:
*used single load/store in splitq_recv_pkts function.
*removed x86-specific intrinsics from common code.

v5:
*Fixed CI errors.
*Used defined constants instead of numbers.

v4:
*moved splitq_rearm_common to a common location.
*reduced duplication of code.
*fixed splitq_recv_pkts function.

v3:
*Fixed some indentation issues.
*Collapsed wrapper and core function into one.
*Fixed some pointer casting and naming inconsistency issues.

v2:
*Fixed CI build related issues.
*Rebased on top of idpf/cpfl rx path selection simplication patch.


*** BLURB HERE ***

Shaiq Wani (2):
  net/idpf: enable AVX2 for split queue Rx
  net/idpf: enable AVX2 for split queue Tx

 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 +++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 357 ++++++++++++++++++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ---
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 6 files changed, 434 insertions(+), 56 deletions(-)

-- 
2.34.1

