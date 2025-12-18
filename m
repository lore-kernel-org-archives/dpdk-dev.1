Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC0D6E2AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 15:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D40C40275;
	Thu, 18 Dec 2025 16:42:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id ACBD54026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 16:42:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766072570; x=1797608570;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Dn26EtauMaQYUcZCIqCvW282rlUhJ98t3CCUNN6mGAw=;
 b=fhrzwd4p8HmKUbxx37omx2iYABPHywQHC11UQm4BATOXqu2AW32bFnu5
 D0SxyN4Yp4EpTt4sGOIcd61GcwsuRrBmi2PdUOW7d8EsUzZlq8bTzZmNW
 jCZStgpzsENZttmhP+YCyaSC1lovAMFLTLe1KTiZoI6wCsUfdS5GMjv/U
 FtcPf651N/DVbj4gVCH39KRxQmppxX1ukuHZrXFiVNH1LcTr7EkKDBkvT
 kj5paeN55EAkJYB3L0W4w1/t2RNGdr0wptgvEEu30UhT9dnPYXvRPxJeQ
 EPWM0GH/qm1i5jixqFAQwp30TG/oZgWOElLzg4vGbiOkgTUG0/RPzufz+ Q==;
X-CSE-ConnectionGUID: sUmciyYwR3WjWesEBDfvew==
X-CSE-MsgGUID: eV7+f3a7SVWHPotO3EE73g==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="78742491"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="78742491"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 07:42:49 -0800
X-CSE-ConnectionGUID: zURhfV8QRFqw4CI8BLYpVA==
X-CSE-MsgGUID: o4RKtmsPTfC+BJCjhMbajA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="197861545"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 18 Dec 2025 07:42:48 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/2] net/i40e: Fix aarch32 build and vector flag setting
Date: Thu, 18 Dec 2025 15:42:41 +0000
Message-ID: <20251218154244.4001917-1-ciara.loftus@intel.com>
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

Fix two issues present on the i40e driver that were introduced by the tx path selection series:
1. Fix a build failure on 32-bit arm caused by an unused function.
2. Ensure that the vector flag is unset when the scalar path is chosen.

If possible both can be squashed into the commit they fix on next-net-intel.

Ciara Loftus (2):
  net/i40e: fix 32-bit Arm build
  net/i40e: unset vector flag when scalar path is chosen

 drivers/net/intel/i40e/i40e_rxtx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0

