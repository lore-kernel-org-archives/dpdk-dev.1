Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F1CCAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 08:54:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 716204042F;
	Fri, 26 Sep 2025 10:54:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id C38834025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 10:54:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758876857; x=1790412857;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XNNPH9UMPA+CSEZjeVL7sPeW5xMtj3fCJbKhZ/GY11U=;
 b=ipTecVP7/euToUHkz7YRkvVUcX8tQPkTYzBUCiZmOmminCRYU6kFmr/0
 1zaC4O3AHXZ22FLdloqm4KvWwVJsBaSPY3UYIIFAo5jaMYeSVlS6bfHSY
 ldPOHD9hBnfugUBQAGIfEn0cymf34gGqreP5/YKEewZQ5jURi1GJsojnc
 sx02jeHFpZW7IxScA8VoUF0Edd8gJe0QxWTQq1GnkhRfBW+1G/cWBgQWt
 FN2Ricl2kPBPOCSvZpLXSuJtLddF29l0Org5pBTUYIuxnVyeNwL+hN317
 gEFKoW3aH/Dc4aBhYwdI6C4FNHaG1MiG6QQP0t8B1sBUwtfLFxSy+8f9V g==;
X-CSE-ConnectionGUID: N24UQ6bOR5O6AwR/TD6dJA==
X-CSE-MsgGUID: yuxFz07FSaqhlbGCiohDdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="83815207"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="83815207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 01:54:16 -0700
X-CSE-ConnectionGUID: Dwg2V0WhTNGIrRKDBmPKRw==
X-CSE-MsgGUID: g/IDj3acT5GI5xnFugXkFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; d="scan'208";a="177170919"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa007.fm.intel.com with ESMTP; 26 Sep 2025 01:54:13 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v3 0/2] enable AVX2 for split queue Rx/Tx
Date: Fri, 26 Sep 2025 14:24:02 +0530
Message-Id: <20250926085404.2074382-1-shaiq.wani@intel.com>
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

 drivers/net/intel/idpf/idpf_common_device.h   |   3 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |   9 +-
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   6 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 438 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 5 files changed, 463 insertions(+), 2 deletions(-)

-- 
2.34.1

