Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59875CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 08:08:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6923C4021E;
	Mon, 27 Oct 2025 09:08:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 374384003C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761552483; x=1793088483;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FZuKnCQnGGxgFdgrw1I0EHw88DSgtObm0ANs1aYc8as=;
 b=h6tFIKYIi6HkIJQg4vzh6KZest1t6xtNBdoX272A1+QJhm4Mn+/m57tn
 sEz/dwXwZCwQdh0/0Ep6TwUcsuXqti/b5Br6UCFJO8PuxXfkWLvdV/mhD
 3P2tlba2ZKURsGSmizKiStrwE8zEVln8xiEate3dCR/wDfh8q0B4c+SCv
 TU+l8c0qqgohPCKemXSh3x+CjKLBrL4G5qSpgXXm5ECpZduzasD8rpKcE
 L4nPdUsExzix5y6uID+F1RCLs106H33V4PU8+4cwdHlepZ1RszoVYiJmS
 x3QmO9ippJtXoa0AJ9IkVJ92Dnvk5efs1NCOV0JvOVeRYEaU/EFvbh3Aa A==;
X-CSE-ConnectionGUID: a6LssUnaSoeBjQbSUsNKqg==
X-CSE-MsgGUID: /jBNMm/kRbqpKjsU98p83g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81258180"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="81258180"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 01:08:01 -0700
X-CSE-ConnectionGUID: 9/sFvs79RG+peDO9hS+cbg==
X-CSE-MsgGUID: m9zgAah/TjKrNKbWVHx4wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="215878840"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa001.fm.intel.com with ESMTP; 27 Oct 2025 01:08:00 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v7 0/3] net/idpf: enable AVX2 for split queue Rx/Tx 
Date: Mon, 27 Oct 2025 13:37:55 +0530
Message-Id: <20251027080758.48410-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917052658.582872-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
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

v8:
*Reworked the receive func to avoid race conditions in Rx path.
*Removed unnecessary compiler barriers.

v7:
*Removed (char) casts, ifdef block as suggested.
*Fixed indentation, line wrapping.
*Did blind write of data to avoid branching.
*changed desc building and writing  order for Tx.

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


Shaiq Wani (3):
  net/idpf: enable AVX2 for split queue Rx
  net/idpf: enable AVX2 for split queue Tx
  doc: note on unsupported completion queue sharing

 doc/guides/nics/idpf.rst                      |   5 +
 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 303 +++++++++++++++++-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ----
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 7 files changed, 383 insertions(+), 58 deletions(-)

-- 
2.34.1

