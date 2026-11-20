Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CA606A330
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k18yclEa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D660C402E3;
	Fri, 20 Nov 2026 04:23:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id EB0A540151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 04:22:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795144980; x=1826680980;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OeX/0vP/AVW7Wu2wQ391cKJ41Xm/WMBXS+OIFEmd2zI=;
 b=k18yclEa4uWligV/1Gn8PGsNaVatroG7o6UaN4CiRKr0ztTPURlS9HhX
 +AP3jHpS8Q/7F6YOPS8w3JHYuCPltTJMXEW49gvfgNDUFzdaGZK+w5zlb
 ylLUTgu4E/+l2AV+9ja8e5wfQbK3Mt+znYmii/N4JG3YzrbvwpBSVmnet
 SzBsFPrhe795Cm7MTLRy/URiPdS48V74m+6bFFDtaCYU0Rh43a40N2y3d
 nW5wVAj8k3OiI46i11nxv77mX2xxwPh/GD5xiDXDX9srkPd+onDzEmb2J
 pxFZ7MAoZp5qXh7gMDlsf1IxMnJsWSgPP+WsTbFPS1rQAR7875rNsUM8e g==;
X-CSE-ConnectionGUID: UZIRbOKFSPCrANVfcK/TUg==
X-CSE-MsgGUID: YN+MWKOsS8yOVAamUrMivA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3902111"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3902111"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 19:22:58 -0800
X-CSE-ConnectionGUID: n09+HdqOQHixqpQVenC6wQ==
X-CSE-MsgGUID: d1TeTFLSRX67ePl9pNiqrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10883244"
Received: from unknown (HELO tester12..) ([10.239.252.12])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 19:22:56 -0800
From: Hailin Xu <hailinx.xu@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: manjunathgouda.hosamani@intel.com,
	Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v1 1/3] nics/ice: update ice latest recommended matching list
Date: Fri, 20 Nov 2026 11:15:23 +0800
Message-ID: <20261120031525.300632-2-hailinx.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120031525.300632-1-hailinx.xu@intel.com>
References: <20261120031525.300632-1-hailinx.xu@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
---
 doc/guides/nics/ice.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index faebfdcb63..f42366bb59 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -62,8 +62,7 @@ are listed in the Tested Platforms section of the Release Notes for each release
 =====  =============  ===========  =========  ============  =======  ============
 DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830/E835 FW
 =====  =============  ===========  =========  ============  =======  ============
-26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0      2.10
-26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91     1.20
+26.11     2.7.6         1.3.59      1.3.63       1.3.28      5.10     2.20
 25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9      1.11
 24.11     1.15.4        1.3.36      1.3.46       1.3.14      4.6
 23.11     1.13.7        1.3.36      1.3.46       1.3.14      4.4
-- 
2.43.0

