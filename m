Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BDFEA3C4E
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 14:00:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FBEF4028D;
	Thu,  9 Apr 2026 16:00:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E349F40276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 16:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775743236; x=1807279236;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VSgilOy0sgr4BjxN3FA8GjfXsYSb91RIAbxSdNGPxSk=;
 b=k0RIbk4y3nJ+TADinVjLiP5TlhLiBH0k78gPMfPJko/Jj175NCqEL6rS
 ualD9uvOZxvZj1iu09ni2diq62GmEv62m/asTGip1YCuxS2JeNW9mBrRV
 kU1BmjDSPXEvEPBuLol9fzoE8z7fFEXAtdjLE3BXNTVjIDOGD17Tv4Hre
 tr7m/txcdKv0LtdrOtCE92E+9jnvupsAjMv/DcYrMFiLhg9Hdsynl7+v6
 voFrhD+dkhbrEeez1bftJPElWxQdWP/wBaB8Acr0nrLKd/QGcgvO4+88I
 ZQPzog7CZyoQ9h//SDoOYfFI28xc9Lv3TsaJy64HXIISnNycLCSjSPpyn w==;
X-CSE-ConnectionGUID: eN3al7CzRCm4NhMygjsy8Q==
X-CSE-MsgGUID: 8PDf6y5EQbSTTmb/Rvj8tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76932741"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76932741"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 07:00:34 -0700
X-CSE-ConnectionGUID: DMXoVjZaTemLIrGprQxhVA==
X-CSE-MsgGUID: x59bNOT2TnaYHiAIqU3b6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="233671056"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa005.fm.intel.com with ESMTP; 09 Apr 2026 07:00:33 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: rosen.xu@altera.com, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] raw/ifpga: target main tree not next-net-intel
Date: Thu,  9 Apr 2026 15:00:23 +0100
Message-ID: <20260409140023.462128-1-bruce.richardson@intel.com>
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

The raw/ifpga driver does not belong in the next-net-intel tree because:
a) it's not a "net" driver
b) it's now maintained by Altera

So remove the line in MAINTAINERS targeting patches for that driver at
next-net-intel tree.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..59694f6e82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1575,7 +1575,6 @@ Rawdev Drivers
 
 Intel FPGA
 M: Rosen Xu <rosen.xu@altera.com>
-T: git://dpdk.org/next/dpdk-next-net-intel
 F: drivers/raw/ifpga/
 F: doc/guides/rawdevs/ifpga.rst
 
-- 
2.51.0

