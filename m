Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86966C5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 13:44:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C3CC402EB;
	Mon, 17 Aug 2026 15:44:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1BFA54021F;
 Mon, 17 Aug 2026 15:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786974281; x=1818510281;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PrfBuV39e4tcRKGVE6PNOXr+9KkNb9jQc8tkbjAate8=;
 b=S2BmIasmcJ8I15Nj3sKBaELTysW2/koXNBXqvGeDj883ANWP73Bz35HC
 Yg4RFfmrHkDSfzxAEIkY26i0KJn/iFAdg8wuZeQR8vuso8JHW5qfqNNh2
 xcf2DyLD5/Q9QUxvwNOL3jPEssLVq/54sm4IYR1ZN5jT5S/o8A4FiBqvw
 PYLGY7g9+w7aJwfAIe6iYkNaX53n+psdC3y+iKJYBM3z1bNkN8QV0O2zl
 7VURmmzgxN4ryUye2VlVuvMzXYJAr7qFgbowbvUEom66FhVVvCM0U4CJ8
 mCJG4Obn2lwrI5wyFIJDD5+sy76qiw406S3OOG1SAvSAKlLjW/CEeX11c g==;
X-CSE-ConnectionGUID: KiQviqIzRnW57zW9fMAWpQ==
X-CSE-MsgGUID: bE2Pjh1UQlG0sXMdUxaXGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104831492"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="104831492"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 06:44:39 -0700
X-CSE-ConnectionGUID: DtLD4UNgQNOzF56r2+I0JA==
X-CSE-MsgGUID: 1kqea90BSSaNu5VWJBdemA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="263165823"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 17 Aug 2026 06:44:38 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 1/3] ethdev: remove use of strncpy
Date: Mon, 17 Aug 2026 14:42:40 +0100
Message-ID: <20260817134432.1206297-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817134432.1206297-1-bruce.richardson@intel.com>
References: <20260623141930.704771-1-bruce.richardson@intel.com>
 <20260817134432.1206297-1-bruce.richardson@intel.com>
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
Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ethdev/ethdev_driver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index eab5c15d12..e6f8d6fe85 100644
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

