Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15672D38FF2
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 461E3402E2;
	Wed, 14 Jan 2026 18:13:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id C3C324027D;
 Wed, 14 Jan 2026 18:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768410826; x=1799946826;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zGSRN+ho3EmpAx2KIsDFh46f8+VLJsRohtBRL6nc7bw=;
 b=KT6TPeLq/JOXYUQdIC5IAVhA1L/sjFBuaQw8DKnaNEymC4ugsKdFc+pt
 tj9fAt/birOKi/LTqlVulK/n5CEATHT9vzUiC8sz5gIx8Pua1PcFTmxeW
 3UHxNWIt3o0SLKgHhcNrHmBvORgE1IJEy9fJejBDJt9qXu29s4Oqo5xCB
 yXn+MOp3fwLs9yTkhLDpbjAFTN6UETnuRZpMeqvc0Q2iWi6b5FbiI1tE/
 h2AZM2c4cUSZqwZU/Y6g5r/5e+rqURHOi3dhuh3hzf8wkElVSzS3+6xi4
 YUBYwaNamkFV1GrtS+PajEqbQtdf8QxYkAtVbKQNLg5viPdCyC963mlM+ w==;
X-CSE-ConnectionGUID: +YTekvpLSL+dOBaEe2IlIA==
X-CSE-MsgGUID: Hci8LkrPSjWuB/qLFF/dJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68923979"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="68923979"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 09:13:43 -0800
X-CSE-ConnectionGUID: oBzalYQPSyCQQvCOXTDUVg==
X-CSE-MsgGUID: czPf8RATSQKC29y7IkPr5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="209777025"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 14 Jan 2026 09:13:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: wathsala.vithanage@arm.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH] config/arm: fix 32-bit cross compile with latest GCC
Date: Wed, 14 Jan 2026 17:13:35 +0000
Message-ID: <20260114171335.3051704-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

When building for 32-bit arm with GCC versions >=11 and using the
DPDK-provided cross-file, the initial configuration step fails  The
error given is:

  config/meson.build:189:8: ERROR: Problem encountered: \
		Compiler does not support "armv8-a" arch flag.

but the real problem is actually an fpu-related error which is explained
in the meson log file:

  cc1: error: '-mfloat-abi=hard': selected architecture lacks an FPU

This error can be fixed by specifying an fpu explicitly, and a number of
options will work, e.g. -mfpu=neon, -mfpu=fp-armv8. Choosing the latter
here to avoid mandating neon by default.

Fixes: e754875c296c ("config/arm: add aarch32 cross-compilation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

---
This patch should fix errors seen in the CI when building for 32-bit arm
on Ubuntu 24.04 and later. CI systems running older Ubuntu using GCC 9
do not show this error, which is why it hasn't been an issue till
recently.
---
 config/arm/arm32_armv8_linux_gcc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config/arm/arm32_armv8_linux_gcc b/config/arm/arm32_armv8_linux_gcc
index abcb182b16..231c9ac7a7 100644
--- a/config/arm/arm32_armv8_linux_gcc
+++ b/config/arm/arm32_armv8_linux_gcc
@@ -13,5 +13,8 @@ cpu_family = 'aarch32'
 cpu = 'armv8-a'
 endian = 'little'
 
+[built-in options]
+c_args = '-mfpu=fp-armv8'
+
 [properties]
 platform = 'generic_aarch32'
-- 
2.51.0

