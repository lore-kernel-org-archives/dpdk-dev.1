Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C39CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 10:34:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E3B427B0;
	Fri, 17 Oct 2025 12:34:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9DE9B40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 12:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760697259; x=1792233259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q1cDrhvVrgvpy54uxNL8hRi0zzEq/DMiC5BsElhQsds=;
 b=I1SxjtwQXQryecFYCIvNcpQQFD6/CtK9b0a3asZZsOJa8RJOLKQVNyzM
 quotIZ8B+r+y1ZPN1AwWqUjHF4Gkcw1BzVIbWl00LCZ4Ocb40DCIkWVup
 iV20RAvYH6mGX9cQavSvp9mMpUMmZgm7i9SUL5Z2cI4H4AMQMGDkzIr7z
 Hgc05LhbQNcITev1LmCgP/VfFW1TdlL8QELbu3CrPVDKgGiAAMZEb4qro
 JJQSwVkkynTRBxBqQJtWvmN8iTY1sFTuTkCBeFyjUlz1EYcZU7Ow5g8hh
 tuhczqaki+f0y/kNd8Int/oRZq8la1Ru7NDuAMH94YRlqnNA1wRn2O5C7 Q==;
X-CSE-ConnectionGUID: UsNoO/vjRDmSNH+lLOVRvA==
X-CSE-MsgGUID: yhyj9sJFTO6OWy0cOlph4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62115564"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="62115564"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 03:34:18 -0700
X-CSE-ConnectionGUID: Zf7AqLFfRnyntRFSsj4utg==
X-CSE-MsgGUID: 4XXTlDhDS8O+qz1scxOoQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="213671859"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa001.fm.intel.com with ESMTP; 17 Oct 2025 03:34:16 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v7 0/3] net/idpf: enable AVX2 for split queue Rx/Tx 
Date: Fri, 17 Oct 2025 16:04:12 +0530
Message-Id: <20251017103415.114400-1-shaiq.wani@intel.com>
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

