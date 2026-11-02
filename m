Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06119606A32C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B+xgTTkC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94FCA40E4B;
	Mon,  2 Nov 2026 09:15:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 8819D40E49;
 Mon,  2 Nov 2026 09:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607341; x=1825143341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MqLDvH3PA+0eP1xXU7BNDTp5JspnAb602kIl1rzQmTE=;
 b=B+xgTTkCFY5Wiqs2gvk0kb/A9LlQ3FkqN0eXw/lTha6C6CgVOPqQevSV
 +meLWg49ljQJ5HIo923ID805FGiPljNG3bQ/w3unPFZWqHWpcUKMxocWd
 e7QF4dYMM6fCK/v87wbdAgXh/vWtwGzLMdf8+RRJ/Cz/lQhLahShVjP9F
 NZayrYy/ntKLm8AeMZbxq3lKK/4EOEmfOVKw5ttaYaZL11El9dsV7uc9i
 DxGE11JzbBnCuCkCB3B096ZZXyfjH9TeRXZa1yqvH0t+i7+MnfZ79rrOc
 y2U4Bcc/sfwJnBjCVAaL4ib9UjqU4icVYop++n0DMCQfpPAtO6Y3AGptK g==;
X-CSE-ConnectionGUID: sj2CIhQySDaCKjaZP4yaOQ==
X-CSE-MsgGUID: +DOaWTmxR12d9rxCZ+RH3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283634"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2283634"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:15:41 -0800
X-CSE-ConnectionGUID: KQ7UbwewT4KASe5QVQqapA==
X-CSE-MsgGUID: 4/BbmHH5Tl6kcFf/QohWBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7818645"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 00:15:40 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 3/7] net/ice: fix DDP filename leak
Date: Mon,  2 Nov 2026 08:10:33 +0000
Message-Id: <5f11c6fcf4e32450d9b020120018ced1bcec6164.1793605752.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793605751.git.anurag.mandal@intel.com>
References: <cover.1793605751.git.anurag.mandal@intel.com>
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

The DDP package filename given with the ddp_pkg_file devarg is
duplicated with strdup() during devargs parsing, but only freed on
close. It leaks when ice_dev_init() fails at or after devargs
parsing, and when the devarg is given more than once.

Free the previous string before storing a new one, and free it on all
init error paths.

Fixes: 9dd6dd1db834 ("net/ice: add option to choose DDP package file")
Fixes: 603beeb970b5 ("net/ice: add safe mode devarg")
Fixes: f9cf4f864150 ("net/ice: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4abc0c3544..d8d2b818d8 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -800,11 +800,12 @@ handle_field_name_arg(__rte_unused const char *key, const char *value,
 static int
 handle_ddp_filename_arg(__rte_unused const char *key, const char *value, void *name_args)
 {
-	const char **filename = name_args;
+	char **filename = name_args;
 	if (strlen(value) >= ICE_MAX_PKG_FILENAME_SIZE) {
 		PMD_DRV_LOG(ERR, "The DDP package filename is too long : '%s'", value);
 		return -1;
 	}
+	free(*filename);
 	*filename = strdup(value);
 	return 0;
 }
@@ -2738,7 +2739,8 @@ ice_dev_init(struct rte_eth_dev *dev)
 	ret = ice_parse_devargs(dev);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to parse devargs");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_devargs;
 	}
 
 	ice_init_controlq_parameter(hw);
@@ -2746,7 +2748,8 @@ ice_dev_init(struct rte_eth_dev *dev)
 	ret = ice_init_hw(hw);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to initialize HW");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_devargs;
 	}
 
 	/*
@@ -2761,7 +2764,8 @@ ice_dev_init(struct rte_eth_dev *dev)
 		PMD_INIT_LOG(ERR, "Invalid rl_burst_size %u bytes",
 			     ad->devargs.rl_burst_size);
 		ice_deinit_hw(hw);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_devargs;
 	}
 
 #ifndef RTE_EXEC_ENV_WINDOWS
@@ -2912,6 +2916,9 @@ ice_dev_init(struct rte_eth_dev *dev)
 err_init_fw:
 #endif
 	ice_deinit_hw(hw);
+err_free_devargs:
+	free(RTE_CAST_PTR(void *, ad->devargs.ddp_filename));
+	ad->devargs.ddp_filename = NULL;
 
 	return ret;
 }
-- 
2.25.1

