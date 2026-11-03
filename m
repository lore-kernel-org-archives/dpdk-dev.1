Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3A606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IQR70Gyz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48487427D4;
	Tue,  3 Nov 2026 18:30:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 3FC3A41149;
 Tue,  3 Nov 2026 18:30:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793727049; x=1825263049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PLv5IBTtPmab9Z3IjZQS4LPzjvN5sHgkzagvGwRX3Tc=;
 b=IQR70Gyz5c8dHhPMocu4n2YPvFt5dB9fcDmkbIBqWAXLI7Mm4QwQGFXL
 YtV3qXAkPki908QVi+4sA6+Pf3pY3wA05UthyCOG7yryC7aAH4Z2wPphO
 WUoshth3lBfhutriK6wyE3J7YHI9YSPozjyahJZoHsrUWjgbiRIqQc/+9
 IlZtMVi47tEJqZ8FFoc2v+qrV7hdkzofqOspfl76nosSNAZ/36oBbpykK
 SmPllE0BqQVQwvelMIb3HaP/8GYVx/ciLgoizvLVZoX81ViKBZNe6ooLU
 4HXa7OWhLL13gvzrZnzFI+QyiyGW2bmmDV8anev8NJXIppnQKR2BKhPkB A==;
X-CSE-ConnectionGUID: j3KsuA1jQB2+sRSzQ3aSxA==
X-CSE-MsgGUID: BXAOxJD5TiuoX+m6QbJQhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553279"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2553279"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:28:59 -0800
X-CSE-ConnectionGUID: TB67QB0VTLSoP4wvjwBWGQ==
X-CSE-MsgGUID: whtGyZIRQfChkxMlz/55Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6495707"
Received: from unknown (HELO an4-swa15-spr.example.org) ([10.241.130.94])
 by fmviesa004.fm.intel.com with ESMTP; 03 Nov 2026 09:28:58 -0800
From: Hernan Vargas <hernan.vargas@intel.com>
To: dev@dpdk.org, gakhil@marvell.com, trix@redhat.com,
 maxime.coquelin@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com,
 Hernan Vargas <hernan.vargas@intel.com>, stable@dpdk.org
Subject: [PATCH v1 3/5] baseband/acc: fix PF2VF Bug for FFT window probing
Date: Tue,  3 Nov 2026 09:29:00 -0800
Message-Id: <20261103172902.4152956-4-hernan.vargas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103172902.4152956-1-hernan.vargas@intel.com>
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
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

Update of the PF2VF comms between bbdev and pf_bb_config to make sure
all FFT windows can be read.
So far only the first window was actually used and functional.
No system impact. Affects VRB1 and VRB2.

Fixes: 0d39ed91c161 ("baseband/acc: add FFT window width in VRB")
Cc: stable@dpdk.org

Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
---
 drivers/baseband/acc/rte_vrb_pmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index 1f85e33462..b9ff027ce8 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -219,7 +219,7 @@ vrb_device_fft_win(struct rte_bbdev *dev)
 	/* Check from the device the first time. */
 	if (d->fft_window_width[0] == 0) {
 		for (win = 0; win < ACC_MAX_FFT_WIN; win++) {
-			vrb_vf2pf(d, ACC_VF2PF_FFT_WIN_REQUEST | win);
+			vrb_vf2pf(d, ACC_VF2PF_FFT_WIN_REQUEST | (win << 8));
 			reg = acc_reg_read(d, d->reg_addr->pf2vf_doorbell);
 			while ((time_out < ACC_STATUS_TO) && (reg == RTE_BBDEV_DEV_NOSTATUS)) {
 				usleep(ACC_STATUS_WAIT); /* Wait or VF->PF->VF Comms. */
-- 
2.34.1

