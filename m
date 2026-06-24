Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97D1CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 996D440665;
	Wed, 24 Jun 2026 12:37:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0284B40669;
 Wed, 24 Jun 2026 12:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297430; x=1813833430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mDYeNcC1YsLWgNVlck/wrwh1+znbkaBg4IhxPHriRDU=;
 b=k6mCLdy9cX3PsXZuEibCnSGDEfa8f6kotLZkHxYkhdDY4KKnLGhSBvn2
 UBgsnryr7K0WJuqPbT3KMgor5g1ihnpP4K65clJh2K8gDO3gnbUEsCx+1
 m5rGZIhX9CHYJKIoCUt6PJ44UZiwc510QiyS6UhugUTbtQw3KIy7CqCVB
 /cTziigF/HRGr5StFTOjL/GX+8InNTPJWAMl8lxD8fharWY8ma1NCbB0m
 ZML2zyWsDqr7MKskCxW02uJe2qAMFrkDR2k6gMnktN9ViZydULECjgyfA
 fDT2S1Gx/MkNLWGJG5QnNvVyI7foXCkVl9IYL7SYtQJ8BrhJDeewI8+gU Q==;
X-CSE-ConnectionGUID: YjH6iCmDQZyEdfF5ALWhOA==
X-CSE-MsgGUID: vSv6kjfYQPGE28u5N2s5aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652339"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652339"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:10 -0700
X-CSE-ConnectionGUID: YPUQpULOQZKy8YUY16N15w==
X-CSE-MsgGUID: zbDWov/ZSAWigxFzjPg7UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460006"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Michael Shamis <michaelsh@marvell.com>, Liron Himi <lironh@marvell.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v2 03/17] crypto/mvsam: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:42 +0100
Message-ID: <20260624103658.792750-4-bruce.richardson@intel.com>
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

Fixes: 25b05a1c806b ("crypto/mvsam: parse max number of sessions")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/mvsam/rte_mrvl_pmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/mvsam/rte_mrvl_pmd.c b/drivers/crypto/mvsam/rte_mrvl_pmd.c
index a824719fb0..65a63c9d62 100644
--- a/drivers/crypto/mvsam/rte_mrvl_pmd.c
+++ b/drivers/crypto/mvsam/rte_mrvl_pmd.c
@@ -1146,7 +1146,7 @@ parse_name_arg(const char *key __rte_unused,
 		return -EINVAL;
 	}
 
-	strncpy(params->name, value, RTE_CRYPTODEV_NAME_MAX_LEN);
+	strlcpy(params->name, value, RTE_CRYPTODEV_NAME_MAX_LEN);
 
 	return 0;
 }
-- 
2.53.0

