Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB89C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 13:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF4D1402AB;
	Wed,  6 Aug 2025 15:38:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 26B7E400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 15:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754487523; x=1786023523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VUvHf9uBiZwI/jmZtLoE8QI4ZhRqN/z6o7t7INQfzic=;
 b=KqoryaxdGW3EAMURPCXUytxgz1jbIzq8uByzVO9gZcu2ubx6Py9xg1Tj
 buncYR8t867jsBYPPk1gt/RpajGUpB0bo/saH/O4pXRBpOszMskQ66INz
 Ei8auam1Su9QvnXSEje9RaC8CpmWvRiCJdIISVHpHze8UQdaLMuqZ8GzX
 06r6alxQM+jIrZUQJP7Wq28T59ZCb2LNW8rAQeEOcUXX+pcYuM3093mES
 yhTB9+p9qPTS9ZLQz716ZFbQapz/1amaorsxJj9ZbgekU6rKBWXcwOSah
 cSlZjbcxabKwRsZHulRx7vdcvn4Bi7hhsQV687khgGRKJaW+JruocUUxx w==;
X-CSE-ConnectionGUID: Lzzon8uORuOl3HuESo5Iag==
X-CSE-MsgGUID: /3W82zh/RIOEj3TP5d5MWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56769211"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="56769211"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 06:38:42 -0700
X-CSE-ConnectionGUID: VnYNSL8/TQKnNx6HWniZjg==
X-CSE-MsgGUID: OTLioVKkQ2mYvEJG3VSDgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="201942360"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by orviesa001.jf.intel.com with ESMTP; 06 Aug 2025 06:38:40 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/3] app: use cross-platform basename function
Date: Wed,  6 Aug 2025 13:38:31 +0000
Message-ID: <20250806133833.3236170-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806133833.3236170-1-bruce.richardson@intel.com>
References: <20250806133833.3236170-1-bruce.richardson@intel.com>
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

Replace use of the Linux/BSD-only basename function with "rte_basename".
Since the DPDK basename function is guaranteed to do a copy into the
destination buffer of known length, we can sometimes simplify the code,
or make it safer, as part of this change.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-dma-perf/main.c | 6 +++---
 app/test/process.h       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 0586b3e1d0..3ad66637e6 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -549,13 +549,13 @@ main(int argc, char *argv[])
 		return -1;
 	}
 	if (rst_path_ptr == NULL) {
-		strlcpy(rst_path, cfg_path_ptr, PATH_MAX);
-		char *token = strtok(basename(rst_path), ".");
+		rte_basename(cfg_path_ptr, rst_path, sizeof(rst_path));
+		char *token = strtok(rst_path, ".");
 		if (token == NULL) {
 			printf("Config file error.\n");
 			return -1;
 		}
-		strcat(token, "_result.csv");
+		strlcat(token, "_result.csv", sizeof(rst_path));
 		rst_path_ptr = rst_path;
 	}
 
diff --git a/app/test/process.h b/app/test/process.h
index 9fb2bf481c..0dba48aa18 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -217,7 +217,7 @@ get_current_prefix(char *prefix, int size)
 		return NULL;
 
 	/* get the prefix */
-	snprintf(prefix, size, "%s", basename(dirname(buf)));
+	rte_basename(dirname(buf), prefix, size);
 
 	return prefix;
 }
-- 
2.48.1

