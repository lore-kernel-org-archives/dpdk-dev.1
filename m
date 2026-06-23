Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D0BCD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:19:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B3BA40611;
	Tue, 23 Jun 2026 16:19:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B226140150;
 Tue, 23 Jun 2026 16:19:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782224386; x=1813760386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uBqXz2Uasg4eaK7XHr+sUV2chxbSrqGB56PvI1qlAFY=;
 b=IAKrQakmMzrvyIfEk7xA1/Uf8jJoctzoFnVqqujgoD5vkHB41ldzf4Xm
 zeTa/lDPHcKG2ZV0WZ0YZIMgqe4vuJ2HH9RIAsDXWcm+Oz1itcujf6s12
 TB3VFWbons4qemynv7Bh2r0j6UwtDg+03sAiWEhuFd21xZYxt/U/0J6ng
 ATpnUVkO0xesTbe986XFoI2BgYcKwmXvQCE9y8l/wx5b1wNtJ+Fvi5fa2
 PPcfrQrhDEa/IhXC09HtlSTIs0Z6UpGEuGsu5FdlkhlA4gQyJWCQUgRl6
 M6qmgSviMy9jDCduP9hl3fnM6FZ2+jezHT1gvIB15luK5BVh+Dvfy2N9z w==;
X-CSE-ConnectionGUID: hqy6OB55SEC6+EYbdiUFgQ==
X-CSE-MsgGUID: h839zZ5VQ3OY8YtybtlOxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82970473"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82970473"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:19:45 -0700
X-CSE-ConnectionGUID: teJLZWiuRYqWIXJpqqgXzA==
X-CSE-MsgGUID: bhT2X6YsRn2XWbbv9a6wFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="253888647"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 07:19:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Harman Kalra <hkalra@marvell.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 1/3] ethdev: remove use of strncpy
Date: Tue, 23 Jun 2026 15:19:27 +0100
Message-ID: <20260623141930.704771-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623141930.704771-1-bruce.richardson@intel.com>
References: <20260623141930.704771-1-bruce.richardson@intel.com>
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

The use of strncpy is not generally recommended, so replace it in code
tokenizing the representor list. Since its use in the function is not
involving null-terminated strings (we know that copied block will
not involve a null value in it), we can replace strncpy with memcpy
rather than a string function. This keeps the original intent of the
code.

For extra safety, also add in an explicit bounds check on the length
value before doing the memcpy.

Fixes: 9a9eb104edf6 ("ethdev: parse multiple representor devargs")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/ethdev/ethdev_driver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index 70ddce5bfc..4043ce898f 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -583,10 +583,15 @@ eth_dev_tokenise_representor_list(char *p_val, struct rte_eth_devargs *eth_devar
 		return devargs;
 	}
 
+	/* len - 2 strips the outer '[' and ']'; guard against underflow and overflow */
+	if (len < 2 || (len - 2) >= BUFSIZ) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Representor list too long or malformed: %s", p_val);
+		return -EINVAL;
+	}
 	memset(str, 0, BUFSIZ);
 	memset(da_val, 0, BUFSIZ);
 	/* Remove the exterior [] of the consolidated list */
-	strncpy(str, &p_val[1], len - 2);
+	memcpy(str, &p_val[1], len - 2);
 	while (1) {
 		if (str[i] == '\0') {
 			if (da_val[0] != '\0') {
-- 
2.53.0

