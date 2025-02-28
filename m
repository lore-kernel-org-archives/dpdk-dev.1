Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E4BC282D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 17:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7973940F1A;
	Fri, 28 Feb 2025 18:00:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7593940280
 for <dev@dpdk.org>; Fri, 28 Feb 2025 18:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740762024; x=1772298024;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dGyHeX6KsbcCMSVGxqmpuYwR4241YF4q9qNn9tRhos0=;
 b=g2KFzIvCkkgIVnlsjm6+rCbkNg3D0lvaYRoOFflDcZ5v1/8/oQZ9lkIH
 sUMX+4zpCDDNRd5dpH1DWqMOYXzG2ahcbgaHaw3QJvEJsCSThvGPqt/Hw
 IlmI6FK+Irlg7M/4Mlaw2/H7xPaA8uiAhqxUqZ1Mj6uugyXMSNqdM7jWu
 DBR6kIY3QdrNcGV0kBhsRErHa2PX/UhLnV3bG8jeavHpO2jR506El/tNh
 nPeiQK/8yHMuIhxI6rCyytoIrxbYNqxJ1mmh+HM9tXBrBdfLRqCr+hPsX
 QN7lO6GquCPLyKJu2o8cIwsKWUD7U+qALrMKRLI4TbJJZSiAvBE24UCMa w==;
X-CSE-ConnectionGUID: z5J2rmMjTjiq3yR4M40H/g==
X-CSE-MsgGUID: WvdU5WPtRFyGSFmXKcTCbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="53084408"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="53084408"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 09:00:23 -0800
X-CSE-ConnectionGUID: QRrsYwHyQamaybcPyVReBg==
X-CSE-MsgGUID: vdvnH1s3Qnmyf9rOREeU/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="122526317"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2025 09:00:22 -0800
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 1/2] doc: update bbdev documentation
Date: Fri, 28 Feb 2025 08:50:21 -0800
Message-Id: <20250228165022.480453-2-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228165022.480453-1-nicolas.chautru@intel.com>
References: <20250228165022.480453-1-nicolas.chautru@intel.com>
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

Correcting the scope of supported bbdev operations.

Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
---
 doc/guides/prog_guide/bbdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/bbdev.rst b/doc/guides/prog_guide/bbdev.rst
index e3f356450b..f0fbb0c1c0 100644
--- a/doc/guides/prog_guide/bbdev.rst
+++ b/doc/guides/prog_guide/bbdev.rst
@@ -13,7 +13,7 @@ optimized libraries to appear as virtual bbdev devices.
 The functional scope of the BBDEV library are those functions in relation to
 the 3GPP Layer 1 signal processing (channel coding, modulation, ...).
 
-The framework currently only supports FEC function.
+The framework currently supports FEC functions (5G/4G Encoder/Decoder), as well as FFT and MLD-TS.
 
 
 Design Principles
-- 
2.34.1

