Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369D2CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 09:07:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C94C740689;
	Tue, 30 Sep 2025 11:07:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2379D40674
 for <dev@dpdk.org>; Tue, 30 Sep 2025 11:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759223251; x=1790759251;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mPh/GUfmByfLpe4dZLyWGCddvmx3qEKXqUGVx3LNTWU=;
 b=hzlOwmq5bj2Tj7jsw69s1aIyc1ySeHWIfZwUOMNaYnrmhJPkOpZ43M21
 3DiI5JJFoAKOt+aOWw5BIdfoP+k5jIHMsWJ2ev6cJvDa7yXt7Ya+JPJvc
 cb4S5Qp8Vxytez2VdlpqPSqdcjrt7vbuyBxX+6VXsOviFVkjRTMMGLyr2
 ntSY5VWno3jtn6qlOZOiJDaaj/c7rrUW/lLFzbnHuIFLSLtETJDQu6zGj
 XbFT5pymac1k+xx6o01chu+d8RNaIim940/K0BN1+Ov5ifFYN1Y7//QmQ
 zAnnMQLaxsUi/EplmwL1JWlq5irKytsg0OkyknryWYsgjmIRjne5xY139 g==;
X-CSE-ConnectionGUID: pSxvv2l7RIaFQOixMHY7Zw==
X-CSE-MsgGUID: k0ZWGz0NThO2kQ0pU7VaZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61363305"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="61363305"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 02:07:30 -0700
X-CSE-ConnectionGUID: KIBU4amhT0WXVp/0f75HbA==
X-CSE-MsgGUID: wXIslDJ1TKi81s8W0J6RHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="182757349"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa004.jf.intel.com with ESMTP; 30 Sep 2025 02:07:29 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v4 0/2] net/idpf: enable AVX2 for split queue Rx/Tx
Date: Tue, 30 Sep 2025 14:37:07 +0530
Message-Id: <20250930090709.2521114-1-shaiq.wani@intel.com>
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


Shaiq Wani (2):
  net/idpf: enable AVX2 for split queue Rx
  net/idpf: enable AVX2 for split queue Tx

 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  64 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 354 ++++++++++++++++++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ---
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 6 files changed, 436 insertions(+), 56 deletions(-)

-- 
2.34.1

