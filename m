Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C8AFC5901
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 06:56:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FD7A4021F;
	Thu, 26 Feb 2026 07:56:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 58C4D400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 07:55:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772088959; x=1803624959;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UlIC9kpg9FNc8YDgDD/MTlmlcwRAL2P3WUiMAQRFBJQ=;
 b=n1MIRTeCe8JpzpxPhTvt4gGyfBbORPWifQLHobSb2svP2aqFqnQ2rLdE
 5rjHYa5cR1g1Q42oESD1yfTJ3yrfVjU0cZLCSGnmnKJAGvKXBNRFxgfhi
 +S+H30GrA7SKwO8x/QL2O85Omax87r/2KxFs6cYFHOVvrLwbqVszNnWr+
 aEgpPw9JYFTJRUjCTdYjvVSoI0p5j/r+6mcoNhGWh963PVHvIWLjupwZ3
 SBMvbceSoSqgVs+KZHb3HfdV29N0m/qZksrUuRwRyNy4JA01lufv8WKFM
 6ea1Aix0uuUKAVMGzjf/2RRbKg04NFeDgHZ4y0nn4MDfvwxFKA7HclVSl g==;
X-CSE-ConnectionGUID: xrXf7GoES4Smi/AoMTnPhg==
X-CSE-MsgGUID: pQEkLmRbRTyU6mUBUFFFBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73322758"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="73322758"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 22:55:57 -0800
X-CSE-ConnectionGUID: cRaFPNj6TL+TMNHGvH/10A==
X-CSE-MsgGUID: iIrpBFKHQ32I+qYdg5Xxaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="214723464"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa007.fm.intel.com with ESMTP; 25 Feb 2026 22:55:57 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v13 0/3] net/idpf: enable AVX2 for split queue Rx/Tx
Date: Thu, 26 Feb 2026 12:22:30 +0530
Message-Id: <20260226065233.917107-1-shaiq.wani@intel.com>
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

v13:
*reworked the recv_pkts() function.
- the driver datapath can now receive any number
- of packets available not just multiples of 4.

v12:
*Addressed AI generated comments.
*Rebased on latest next-net-intel tree.
*Included a release note entry.


v11:
*Fixed indentation issues.

v10:
*Changed desc reading style in Rx path.

v9:
*Some minor fixes.

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
  doc: add note on unsupported completion queue sharing

 doc/guides/nics/idpf.rst                      |   5 +
 doc/guides/rel_notes/release_26_03.rst        |   4 +
 drivers/net/intel/idpf/idpf_common_device.h   |   2 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  67 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 324 ++++++++++++++++++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ---
 7 files changed, 410 insertions(+), 56 deletions(-)

-- 
2.34.1

