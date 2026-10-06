Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA34CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2732A4060F;
	Tue,  6 Oct 2026 12:53:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 300D8402A2;
 Tue,  6 Oct 2026 12:53:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791284014; x=1822820014;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QMRTPt4jY+rpAGZQciLjYs/gFR4eUwpU9P8tC8E9LZI=;
 b=E/r6I324A7B25D2mX8vGRqJCPEaSE7dkC9MVgMrr0qq9wyJZv/MedWB/
 TxG0FeyOTgvsc/klr+6gZNkPLMYpWGNgO/QMM4izBbmylKmSUU3olphnz
 VuzH7eXSWeLGygQQHGO4wxrV9nBeeTi5ZvqTgsAS0cs1H+auKiBp8s+gX
 pPuLe0wKAh5XsQetgjWOnkNkY3Cuhmxa7I5KHvE/ysdFWTMkQDMyNEvtj
 CF7Pnw3H35kM+BAyIA242pkUkJaObtlHPIjkXB5R6bjep5YOXIfzh7yss
 9Ar+ePpKhDaFxi7jBocXpinBEMC3wcHzGbBV8LBMxfdXYkgv8ZDNzJTL0 A==;
X-CSE-ConnectionGUID: 2YI5SQCYSi2OzypWkyB6Bw==
X-CSE-MsgGUID: U073b8e7R1ufehdJZoWmIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="7935"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="7935"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:53:33 -0700
X-CSE-ConnectionGUID: AvDdRbxCQg2t/ZMZnKZ16w==
X-CSE-MsgGUID: BrvwTzsyRoiF4b0hrxHV0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="274914487"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa006.jf.intel.com with ESMTP; 06 Oct 2026 03:53:32 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Alexander.Konyukhov@kaspersky.com, Radu Nicolau <radu.nicolau@intel.com>,
 stable@dpdk.org, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH] crypto: ipsec_mb fix OOP SGL for NULL cipher
Date: Tue,  6 Oct 2026 10:53:28 +0000
Message-ID: <20261006105329.1630257-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

For the NULL cipher OOP SGL case should be handled
by the linear buffer SGL path

Fixes: 03944ff5e3df ("crypto/ipsec_mb: support null auth/cipher for aesni_mb")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index ab65316978..90989c9a69 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -2142,7 +2142,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->msg_len_to_cipher_in_bytes = op->sym->cipher.data.length;
 	}
 
-	if (cipher_mode == IMB_CIPHER_NULL && oop) {
+	/* NULL cipher OOP SGL case handled by the linear buffer SGL code */
+	if (cipher_mode == IMB_CIPHER_NULL && oop && !sgl) {
 		memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
 			job->src + job->cipher_start_src_offset_in_bytes,
 			job->msg_len_to_cipher_in_bytes);
-- 
2.52.0

