Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4BC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F16C942708;
	Thu,  6 Feb 2025 17:09:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id F237540E4F
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858167; x=1770394167;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4erTgB5p4VXsHcp7eMRINQ+iaHDxswtSmJxKL+Z6WP4=;
 b=awjfL896Dzg+IcI8FfGhoBrbOP9fMeLgqVbJjhvHwtZjk6EY8Aaq/vLK
 BKUOUrEtx+baMIhf+XRi/5IZhVsc1A6t/qBlj6E8YGBi60mZB+7AeEzy5
 ag9PWVQJqNb/9Ixxz5G+r4TqyopVQy6z98aWJv/7IZ3xn8kSzUQfAQRpw
 RIAV2Ssp6cNtahWkGLF0kunLXsCr2pjQ0ivJrlII1idKUAiO8vVxnbzGD
 5WFs4sEwh0LXG34PFokHPecCsUSqdua0y/YPAOKJW+b3gMclPau+PqJUl
 FqmgZ7TjlCbnqYy5g/N84VJAgk0zxjweanRdeqe4n5UqG0XTxMvix0rcw w==;
X-CSE-ConnectionGUID: qbvk/jerTGi3zQ2khIaNxg==
X-CSE-MsgGUID: 4tH+/oGSSBaZ7MtF18JsaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860763"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860763"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:26 -0800
X-CSE-ConnectionGUID: J0B0xbu1SX+cXwaxbY31eg==
X-CSE-MsgGUID: ftp+NbqlTZqFMaHf1BQNTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166816"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:25 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v1 19/24] net/e1000/base: fix uninitialized variable usage
Date: Thu,  6 Feb 2025 16:08:42 +0000
Message-ID: <70f58a17a0fbec2fcd22c4e94802c7f036a7effe.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

From: Jakub Buchocki <jakubx.buchocki@intel.com>

Static analysis has detected potential usage of uninitialized values
inside the array. Fix the warning by initializing array.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 .mailmap                                | 1 +
 drivers/net/intel/e1000/base/e1000_vf.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 23ec118ebc..8ffd20cba5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -619,6 +619,7 @@ Jacek Piasecki <jacekx.piasecki@intel.com>
 Jacek Siuda <jck@semihalf.com>
 Jack Bond-Preston <jack.bond-preston@foss.arm.com> <jack.bond-preston@arm.com>
 Jacob Keller <jacob.e.keller@intel.com>
+Jakub Buchocki <jakubx.buchocki@intel.com>
 Jakub Chylkowski <jakubx.chylkowski@intel.com>
 Jakub Grajciar <jgrajcia@cisco.com>
 Jakub Neruda <neruda@netcope.com>
diff --git a/drivers/net/intel/e1000/base/e1000_vf.c b/drivers/net/intel/e1000/base/e1000_vf.c
index fc30357c17..472b921b6f 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.c
+++ b/drivers/net/intel/e1000/base/e1000_vf.c
@@ -376,7 +376,7 @@ STATIC void e1000_write_msg_read_ack(struct e1000_hw *hw,
 void e1000_update_mc_addr_list_vf(struct e1000_hw *hw,
 				  u8 *mc_addr_list, u32 mc_addr_count)
 {
-	u32 msgbuf[E1000_VFMAILBOX_SIZE];
+	u32 msgbuf[E1000_VFMAILBOX_SIZE] = {0};
 	u16 *hash_list = (u16 *)&msgbuf[1];
 	u32 hash_value;
 	u32 i;
-- 
2.43.5

