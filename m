Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB1C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 11:20:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D9B8410D0;
	Tue,  8 Apr 2025 13:20:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 987D1410E3
 for <dev@dpdk.org>; Tue,  8 Apr 2025 13:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744111206; x=1775647206;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iXQSlLIXNIwwmfygIdUvf+q7Vn6CdPw5MORMNvrTG6c=;
 b=FmddHUpvNFeITjrHWqOmii+Plp1mQNlQJyenV+QIfNd5wjTjoyR52Jb8
 fMwSnUxjki5s4QVnpbdQVK0ptcpvBVRbhA0rk3bN0RWtcyV8DCU987bt4
 BVcQ+RzJQka/INdKErh+EIC3bMMXpfu2Qm4IOSBJAcwzfHFqoFMq9nWt7
 M926acqSmbnw9/EgmUtEUfxkN3PeIfJXJTqFk41Zj1CtYEZX2QG+BYI6a
 +f5ZnB66ulQifNBVX9s3kz++ed+NKPoK2WHJTi7ISuunoYSgpPyjdCIdj
 Cdd3O5B4pbjpRis93Rs63seXG1lEDMrUf3Lh6RdTqeGttJdz6cQPsi7V0 A==;
X-CSE-ConnectionGUID: vvisTgkxSNKPTC+qIa2gYA==
X-CSE-MsgGUID: CGW2SHCxSh6vp6h4EpptRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="62939042"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="62939042"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 04:20:05 -0700
X-CSE-ConnectionGUID: N/3xMQlaQ/epDViu5oDphQ==
X-CSE-MsgGUID: z6AEtGLtRTew9OchzCx9Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128219482"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa006.jf.intel.com with ESMTP; 08 Apr 2025 04:20:03 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Jerin Jacob <jerinj@marvell.com>
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH 5/5] app/eventdev: update eventdev app for SNOW-V
Date: Tue,  8 Apr 2025 12:19:50 +0100
Message-ID: <20250408111952.2953492-5-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408111952.2953492-1-radu.nicolau@intel.com>
References: <20250408111952.2953492-1-radu.nicolau@intel.com>
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

Update eventdev app to handle SNOW-V correctly.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test-eventdev/evt_options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test-eventdev/evt_options.c b/app/test-eventdev/evt_options.c
index 323d1e724d..7903b5959c 100644
--- a/app/test-eventdev/evt_options.c
+++ b/app/test-eventdev/evt_options.c
@@ -224,7 +224,8 @@ cipher_alg_is_bit_mode(enum rte_crypto_cipher_algorithm alg)
 {
 	return (alg == RTE_CRYPTO_CIPHER_SNOW3G_UEA2 ||
 		alg == RTE_CRYPTO_CIPHER_ZUC_EEA3 ||
-		alg == RTE_CRYPTO_CIPHER_KASUMI_F8);
+		alg == RTE_CRYPTO_CIPHER_KASUMI_F8 ||
+		alg == RTE_CRYPTO_CIPHER_SNOW_V);
 }
 
 static int
-- 
2.43.0

