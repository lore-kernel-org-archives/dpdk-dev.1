Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3717606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QKvzJLVf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CDA40613;
	Tue, 27 Oct 2026 11:56:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 8C2DA4064E
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793098592; x=1824634592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w7SPY44WAIGOajwKMVwb1Medfe9QRKYUgOUxa2J8EvQ=;
 b=QKvzJLVfjenLNnJh81aNdPJMvDkdKrOgSHZuX4cW6zUHpWCmQNLG8XVk
 QD6zeavO0AqutzcCuTdEE5MPUa/Syk24g9U7GP3TkSUStufcOnI/NWv3K
 3HQsZCuD7moLR93YKTLfG7eEqpls1JeovWKdmnlRd1I5ueLe+p4RsZdTv
 rKrd/7J6UzyZcC+VQAujrgfVvxR/CsBaaYJAJP0Dn7VCQH8/2H5fmBnkB
 vOpqlOrHjk94vvqplvIJumaHKIigXVmuX9Uvz2d1L9W+IJcaIZUHpbWJO
 IvPSuCB7weo7jJM7TiYwjYfYAjodPPRacx+vfjGucwj6o6m33rsff8l/I Q==;
X-CSE-ConnectionGUID: +Dp4jyNtThSlKMySmfh1Cw==
X-CSE-MsgGUID: sYQu+RY/QEqxpjfJxEJjCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679297"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1679297"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:56:32 -0700
X-CSE-ConnectionGUID: +MS8NAKrT/ewc2q1ePh9gQ==
X-CSE-MsgGUID: MkIJw4IZQKiDEnl+ZsG1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4901465"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 03:56:31 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 3/7] net/ice: fix DDP filename leak
Date: Tue, 27 Oct 2026 10:51:33 +0000
Message-Id: <85b3df3751d1e6b319c1af2cb21e01cf7db4e229.1793097896.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793097896.git.anurag.mandal@intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 27f992aefa..ec4d021ec6 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -805,6 +805,7 @@ handle_ddp_filename_arg(__rte_unused const char *key, const char *value, void *n
 		PMD_DRV_LOG(ERR, "The DDP package filename is too long : '%s'", value);
 		return -1;
 	}
+	free((void *)(uintptr_t)*filename);
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
+	free((void *)(uintptr_t)ad->devargs.ddp_filename);
+	ad->devargs.ddp_filename = NULL;
 
 	return ret;
 }
-- 
2.25.1

