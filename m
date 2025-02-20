Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E8C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 09:01:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C9F54014F;
	Thu, 20 Feb 2025 10:00:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4968440041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 10:00:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740042059; x=1771578059;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TeP8/yfRMsQC7g8jbcprgeci9hpNDfwYRkocL/QHVvo=;
 b=kD6rAr8TI6Nmc+lYvKx8zvgL6KmL6jWNyZpcBzs5c0Qzaq1KlI14rLA6
 /LlbehG3mtnQUAa2F9N8rC7y+MWSSUYUk/r0CVy5HiYbzH+LIvmOJuVMs
 BsKTzHoQbeSpaehpS/WDcNVQv8dVfUN3KetA2wmxs1eWtvJNDBUXJn9w3
 toO607Rq2dKtC3azNtm0999MOQtDccEXveMnwkbpRbaHItyUjktbaLFN/
 l9tbnrBWqnTJHt7VSK25vvp3uCLweSuLZHB2AMUsI0Go+3h5p+F/N7yx+
 OEQjtzRaB+LgRrpecQNYZhk18vN2iroph5VQ7uRcsOgdROE8NwYquyXTH w==;
X-CSE-ConnectionGUID: TeHnGoC1TdCX5vePkkPMDw==
X-CSE-MsgGUID: NDOew8qKS3unlvlHPc+EqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51429389"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="51429389"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 01:00:58 -0800
X-CSE-ConnectionGUID: KOq1kUlCRiCO9a8fqkF5ZA==
X-CSE-MsgGUID: H5EKXGPwT2uyPtGfnhbkSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="138178369"
Received: from dpdk-rosen-vc01.sh.altera.com (HELO rdma1..) ([10.220.4.210])
 by fmviesa002.fm.intel.com with ESMTP; 20 Feb 2025 01:00:55 -0800
From: Rosen Xu <rosen.xu@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com, ferruh.yigit@amd.com,
 rosen.xu@intel.com, rosen.xu@altera.com
Subject: [PATCH] maintainers: update for Intel FPGA rawdev drivers
Date: Thu, 20 Feb 2025 08:35:09 +0000
Message-ID: <20250220083509.3988-1-rosen.xu@intel.com>
X-Mailer: git-send-email 2.43.0
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

Change of maintainers' email for Intel FPGA rawdev drivers

Signed-off-by: Rosen Xu <rosen.xu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 312e6fcee5..f6d22caa94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1540,7 +1540,7 @@ Rawdev Drivers
 --------------
 
 Intel FPGA
-M: Rosen Xu <rosen.xu@intel.com>
+M: Rosen Xu <rosen.xu@altera.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
 F: drivers/raw/ifpga/
 F: doc/guides/rawdevs/ifpga.rst
-- 
2.43.0

