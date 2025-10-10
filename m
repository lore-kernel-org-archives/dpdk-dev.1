Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00685CCD185
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 12:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCD4B4027A;
	Fri, 10 Oct 2025 14:59:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3D4F54026F;
 Fri, 10 Oct 2025 14:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760101154; x=1791637154;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=d7chTzzdoNxLQ9YpB2SSQsxF6SH5RknjlOaIY+fhVbA=;
 b=YdS8yPaCFdAviHXIrwFvQ+lq75ovSF6wHx+l5vUIUIt3pObpmUmFNdkl
 Foy3c2rKnaAniha4WCueZbJYoOLDnq1ZFR22eQ29PZ1Ek1HrsEgNLko++
 yqRRIaSt8SBy4WZBQU2pkMNxCdJ7jPGS8uiYLSNP5B6uGIAuOhG2k0rFC
 n5Rn+/5NdJhTnvt9c576ElhWxLjeXMjQ6c90Ik4feIyk8r7Csr/X016Xl
 abLZrk+G3CTwMY1FFy7I16C+xXDFD5UZp+Es5wy2V3YGJUoYiSrZODVC2
 1gVFWJ6DMEwn2DNNR471hayYnyVVF+eWKxK1qwXughwraDphGL8ZbEDQ2 w==;
X-CSE-ConnectionGUID: nAKI+5reQ7+oOx3RYBkDIw==
X-CSE-MsgGUID: Hzkg/dUCQ4uTqGUM1P0tzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62418712"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="62418712"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 05:59:12 -0700
X-CSE-ConnectionGUID: nabOXUVtRtGRUNa+GZ6whw==
X-CSE-MsgGUID: NtE3qooVTWiVxQgdt1Xg0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="211625522"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa002.jf.intel.com with ESMTP; 10 Oct 2025 05:59:10 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: thierry.herbelot@6wind.com, bruce.richardson@intel.com,
 Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org
Subject: [PATCH] net/e1000: fix crash when built with GCC 13
Date: Fri, 10 Oct 2025 12:58:48 +0000
Message-Id: <20251010125848.965340-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

The e1000 PMD crashes during initialisation in a Ubuntu 24.04 VM when
compiled with gcc-13 with -O3 optimisations. This patch introduces a
compiler barrier after the register read that was causing the issue.

Bugzilla ID: 1691
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 2fa97d12a9..41aae86ffe 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -1842,6 +1842,7 @@ s32 e1000_id_led_init_generic(struct e1000_hw *hw)
 		return ret_val;
 
 	mac->ledctl_default = E1000_READ_REG(hw, E1000_LEDCTL);
+	rte_compiler_barrier();
 	mac->ledctl_mode1 = mac->ledctl_default;
 	mac->ledctl_mode2 = mac->ledctl_default;
 
-- 
2.34.1

