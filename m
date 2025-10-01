Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9C4CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:56:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDBE540B99;
	Wed,  1 Oct 2025 09:56:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 6EF13400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759305388; x=1790841388;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zxYk94OWz8HxsfTBJ/tHYXwQIbxoTl2FLxLvMUOY/I0=;
 b=kuln7FnKig0ynMlBlC1WWwDDPDxzHugVYsm0XCWzfWSf0/Ry9mfnJC9D
 drgkaB5RshsxltSl4+V2QZMNRDL7nQJpNqP+uy2JdncdsFluCWySCPrB5
 GC+aVBk+9ngDzj6gItFIN5jvNil75IwQX4+KKP7J/vre4itLADp/BPhOb
 Odiv9x+S/CewPvdWw8kit1W5G8/LkddUWg9jGMWX5ixsbH915dL91f8z9
 kurwE14rAwouh5d7NHhWpnVvgIVs2c1e1c8grgHqA5731cfHlJhyCkABL
 tt8G5M364CC7jagQ1sTwrLsazCTBSYeAt1nRjzyY7uKCcxRXvmCiqhM9j A==;
X-CSE-ConnectionGUID: O91v7nJBRJKld2WoHh4oQw==
X-CSE-MsgGUID: 3St33QTLSIyfVE3qiUVTag==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79222922"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="79222922"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 00:56:27 -0700
X-CSE-ConnectionGUID: SGvCLwUDS0S7v1riFwuiDg==
X-CSE-MsgGUID: dQvoxjliTvC5OlEBCyFKcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="183912600"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa005.jf.intel.com with ESMTP; 01 Oct 2025 00:56:26 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 0/2]  net/idpf: enable AVX2 for split queue Rx/Tx
Date: Wed,  1 Oct 2025 13:26:07 +0530
Message-Id: <20251001075609.2608021-1-shaiq.wani@intel.com>
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


Shaiq Wani (2):
  net/idpf: enable AVX2 for split queue Rx
  net/idpf: enable AVX2 for split queue Tx

 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  65 ++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 359 ++++++++++++++++++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ---
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 6 files changed, 442 insertions(+), 56 deletions(-)

-- 
2.34.1

