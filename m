Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C0CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9BB94069F;
	Wed, 24 Jun 2026 12:37:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4CFFB4066F;
 Wed, 24 Jun 2026 12:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297438; x=1813833438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=18rWuEqVrwewCqZk42347WMp8ZQrw63Ljxm4aresZJE=;
 b=OYlCrf7eNplN0oI41hSKtErJxpJZpptakYzoww5+SbG174bAn03uG94O
 cZJZeWID8/Rl2/e9QwPoOIfgtRc4hI21PSaxrNvmZViScugmm4M1wm00B
 8S+y3A+X4+dyoSBexo5Z0Iah6tyIj2RSZumvrLR9Bg8HpJ1ULD1fkrdOr
 ffWk0l+fpEVFn7PbQfk0AuFVRatzYReYCjs+Mf6NjAcazqPo3WOoN4i2G
 f39ApOiEZxlb09xJse5rYDw7+tiamNFdeMsr65OsofHeKtgS3+wDKfQMh
 wW/TNFMkJ9/+36ExRLFEWpA72qPeyono65wRTq0BgUY/2qAejnEVJkfhx A==;
X-CSE-ConnectionGUID: 3bZo8IDGQnqEzqmuQCbAXw==
X-CSE-MsgGUID: kn/siHGsQdmDYAat4t+VGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652358"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652358"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:17 -0700
X-CSE-ConnectionGUID: 7gquUnOyQ0qw+njFs5h0xg==
X-CSE-MsgGUID: D+i7Eq55TEW2V9hM/mYhQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460054"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 08/17] net/cnxk: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:47 +0100
Message-ID: <20260624103658.792750-9-bruce.richardson@intel.com>
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

Fixes: 804c585658ea ("net/cnxk: add representor control plane")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/cnxk/cnxk_eswitch.c | 4 ++--
 drivers/net/cnxk/cnxk_rep_msg.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_eswitch.c b/drivers/net/cnxk/cnxk_eswitch.c
index e45c7dfd07..50c3e54109 100644
--- a/drivers/net/cnxk/cnxk_eswitch.c
+++ b/drivers/net/cnxk/cnxk_eswitch.c
@@ -124,8 +124,8 @@ cnxk_eswitch_dev_remove(struct rte_pci_device *pci_dev)
 				}
 				sun.sun_family = AF_UNIX;
 				sunlen = sizeof(struct sockaddr_un);
-				strncpy(sun.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH,
-					sizeof(sun.sun_path) - 1);
+				strlcpy(sun.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH,
+					sizeof(sun.sun_path));
 
 				if (connect(sock_fd, (struct sockaddr *)&sun, sunlen) < 0) {
 					plt_err("Failed to connect socket: %s, err %d",
diff --git a/drivers/net/cnxk/cnxk_rep_msg.c b/drivers/net/cnxk/cnxk_rep_msg.c
index a222e2b5cd..7b92e7a5f7 100644
--- a/drivers/net/cnxk/cnxk_rep_msg.c
+++ b/drivers/net/cnxk/cnxk_rep_msg.c
@@ -138,7 +138,7 @@ open_socket_ctrl_channel(void)
 
 	memset(&un, 0, sizeof(struct sockaddr_un));
 	un.sun_family = AF_UNIX;
-	strncpy(un.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH, sizeof(un.sun_path) - 1);
+	strlcpy(un.sun_path, CNXK_ESWITCH_CTRL_MSG_SOCK_PATH, sizeof(un.sun_path));
 
 	if (bind(sock_fd, (struct sockaddr *)&un, sizeof(un)) < 0) {
 		plt_err("Failed to bind %s: %s", un.sun_path, strerror(errno));
-- 
2.53.0

