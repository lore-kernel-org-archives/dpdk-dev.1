Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B818CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA4640666;
	Wed, 24 Jun 2026 12:37:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7A95E400EF;
 Wed, 24 Jun 2026 12:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297427; x=1813833427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6dr8WHt9nl6oD+5WQbZyFqPKyt5cKCccCqY7VgBfxq0=;
 b=KECN7ilr6cpYzBk41K4WFuuuc408+kSWJNcrZ0G6FzuMedWMadJ/xkrO
 6o+TTVWGcsKJObiS0o1P6aJs/b4CoaHCglJ4rX4/eQ/33UkOl5Iz2ykiK
 A+75T6vEbAK6TXKrZf8N6pE+Ud0m7GR4QZMsEZJIBpkZO4Yd4oFO+2oLz
 a4el+HHn+RQHdSE+oz7Z9ypk7JAtUe4YzXv+BlCOGj+xCIpkVOGdpszUG
 JAHa+btUFzdRVSxkdt8c7Y5ahkdIQknGzqbYkmppLiETB7EFfTJw84GC4
 BgPpTJBgtJtbrUWcqAuXzGwoVCh9eanANQnzdvWYvaDOjVPoWG64ULCLi A==;
X-CSE-ConnectionGUID: KZf3z9UGSSe3FQyp6Ivlbw==
X-CSE-MsgGUID: 7UAAZ2VeR/qBgLW9uHjZ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652330"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652330"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:06 -0700
X-CSE-ConnectionGUID: Za3JxDQKTO+m+EbGAVA6Qw==
X-CSE-MsgGUID: 11vYIWvtTdKJJ8GR6m+fow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245459978"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 01/17] common/cnxk: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:40 +0100
Message-ID: <20260624103658.792750-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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

