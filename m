Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADC5CDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 904CF4065B;
	Tue, 23 Jun 2026 18:51:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 24B3B40150;
 Tue, 23 Jun 2026 18:51:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233519; x=1813769519;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6dr8WHt9nl6oD+5WQbZyFqPKyt5cKCccCqY7VgBfxq0=;
 b=ihzzBQhxKii5+FKUu8jhgCTceuMqKiY816oIsAe9apIf7tolZDP0WQ5G
 pDcffvgmhEI5dMBJJUNnZzKsN4DtGFnXfN4pJJat9hTEbaON0k1Ns68vr
 mMEzrUIIRAwTsNFHnWT7mYDo3Bf9pUP03xxfZlDd7n95VlMjXCGwVgqvW
 HSJ1qIc+0J0Dmj0jk4BjB7COKzqwWdPFu1ZQnMPupnB1sEnVAwqiAo3qS
 osgw/SSxgsK8xSEOMeFsoNMC3pRBTocEBgukPj/fGRwtViROTgylTbFiJ
 yk/sjPvGavFPn4EK/YQb/lvaYltWYzN4VNpmkAOFkD+J6a4NffIXDmcyB A==;
X-CSE-ConnectionGUID: pXIu6nJXROC9ScaQfWzCvw==
X-CSE-MsgGUID: BE7XdwQCStuq4SVfWL0QpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534614"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534614"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:51:58 -0700
X-CSE-ConnectionGUID: tAWDvS6BQRGyGwexlPSjYA==
X-CSE-MsgGUID: 1T/J0W2rQmKgvv+Fj3eg+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928279"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:51:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 01/17] common/cnxk: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:31 +0100
Message-ID: <20260623165150.765443-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 014a9e222bac ("common/cnxk: add model init and IO handling API")
Fixes: b315581c66dc ("common/cnxk: skip probing SoC environment for CN9K")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/common/cnxk/roc_model.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/common/cnxk/roc_model.c b/drivers/common/cnxk/roc_model.c
index f0312a5400..ddd7ee8634 100644
--- a/drivers/common/cnxk/roc_model.c
+++ b/drivers/common/cnxk/roc_model.c
@@ -211,15 +211,15 @@ populate_model(struct roc_model *model, uint32_t midr)
 		if (model_db[i].impl == impl && model_db[i].part == part &&
 		    model_db[i].major == major && model_db[i].minor == minor) {
 			model->flag = model_db[i].flag;
-			strncpy(model->name, model_db[i].name,
-				ROC_MODEL_STR_LEN_MAX - 1);
+			strlcpy(model->name, model_db[i].name,
+				ROC_MODEL_STR_LEN_MAX);
 			found = true;
 			break;
 		}
 not_found:
 	if (!found) {
 		model->flag = 0;
-		strncpy(model->name, "unknown", ROC_MODEL_STR_LEN_MAX - 1);
+		strlcpy(model->name, "unknown", ROC_MODEL_STR_LEN_MAX);
 		plt_err("Invalid RoC model (impl=0x%x, part=0x%x, major=0x%x, minor=0x%x)",
 			impl, part, major, minor);
 	}
@@ -297,7 +297,7 @@ of_env_get(struct roc_model *model)
 	FILE *fp;
 
 	if (access(path, F_OK) != 0) {
-		strncpy(model->env, "HW_PLATFORM", ROC_MODEL_STR_LEN_MAX - 1);
+		strlcpy(model->env, "HW_PLATFORM", ROC_MODEL_STR_LEN_MAX);
 		model->flag |= ROC_ENV_HW;
 		return;
 	}
-- 
2.53.0

