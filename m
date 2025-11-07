Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA8CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:54:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34B9940ED0;
	Fri,  7 Nov 2025 16:51:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 04FA940650
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530699; x=1794066699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zwR/7dulEHQoVkpra+n0Ev0Q5CWiaR25o8HW4WRCW94=;
 b=YcYQC/ONwzsID4bjyXOnC2bE02HelYqGqpRHB1odoFw6ps/D8OfalVBE
 8dycgpRdHv2365igJO6usYeQfsAmko8rBv+Zv0aPO3x+nqc4sr+CnZVvk
 0XtSpfgxX4ZwIdMF/nuWaBr3E6AUkuzxZwFMAEy5OHJGHt4YBC2RVDNz8
 9QFcxmIPKV2+KQS+Nb5E/8oDqkuDyjW4zAlTuvzw/TKX6vPs+3wonoHAS
 gV0I/jJRMayNQSfb90C0rLRqrN/CQmAz0ZJz4hkwEhRxdNcP4ymCd8GFI
 lUy6PVvPEaJPTHNQKeYfkfkZl/a3KcAp8559/6OJj0UXUsx9cy6ztV0kY g==;
X-CSE-ConnectionGUID: jl0X2eZ8TYS5HJSla+JCfA==
X-CSE-MsgGUID: XZOUq21MSVOJS2kGchM8tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151883"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151883"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:38 -0800
X-CSE-ConnectionGUID: 1izyd2lVQrCZ0A3h1SZoAA==
X-CSE-MsgGUID: 5Oi5RHb9QuuspDpbuSsy7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321782"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:38 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Wisam Jaddo <wisamm@nvidia.com>
Subject: [RFC PATCH v2 27/33] app/test-flow-perf: remove unneeded variable
Date: Fri,  7 Nov 2025 15:50:23 +0000
Message-ID: <20251107155034.436809-28-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

Remove an unnecessary second definition of a char * variable called
"token" when processing commandline args.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-flow-perf/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index b2084b93dd..53c92c4bec 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -916,7 +916,6 @@ args_parse(int argc, char **argv)
 			if (strcmp(lgopts[opt_idx].name,
 					"port-id") == 0) {
 				uint16_t port_idx = 0;
-				char *token;
 
 				token = strtok(optarg, ",");
 				while (token != NULL) {
-- 
2.48.1

