Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417BC282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 20:03:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A09640B94;
	Thu,  6 Mar 2025 21:03:38 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 92EAB40B92
 for <dev@dpdk.org>; Thu,  6 Mar 2025 21:03:36 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id A073F2110485; Thu,  6 Mar 2025 12:03:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A073F2110485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741291415;
 bh=354j3w/9uhRwcVEwCHv+Afcn920W/vFK0JAKx6jb6S4=;
 h=From:To:Cc:Subject:Date:From;
 b=Zl20m5/JCy/RN/0GiCBCNZUQVzpyhB8joWpRyzfi5FEfSdS7YCe3YiTqz8OBUO9Zq
 Ldzc6dB8gt5YAkB5l+E8YTzDgNGx9nIF5DyjtS2MFrgja1frsqqfFl9KzlOFYuUOFg
 V3ztUSAcv79GkHug+8+w9EyX59sM5g14M0RJkMfw=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] hash_readwrite_autotest: fix printf parameters
Date: Thu,  6 Mar 2025 12:03:28 -0800
Message-Id: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

Compiling with MSVC logs the warnings below, which result in
build error:

../app/test/test_hash_readwrite.c(73): warning C4476: 'printf' :
    unknown type field character ''' in format specifier
../app/test/test_hash_readwrite.c(75): warning C4474: 'printf' :
    too many arguments passed for format string
../app/test/test_hash_readwrite.c(75): note: placeholders and
    their parameters expect 2 variadic arguments, but 4 were provided

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_hash_readwrite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_hash_readwrite.c b/app/test/test_hash_readwrite.c
index 1867376ade..dc07df709a 100644
--- a/app/test/test_hash_readwrite.c
+++ b/app/test/test_hash_readwrite.c
@@ -70,7 +70,7 @@ test_hash_readwrite_worker(__rte_unused void *arg)
 	}
 	offset = tbl_rw_test_param.num_insert * i;
 
-	printf("Core #%d inserting and reading %d: %'"PRId64" - %'"PRId64"\n",
+	printf("Core #%d inserting and reading %d: %" PRId64 " - %" PRId64 "\n",
 	       lcore_id, tbl_rw_test_param.num_insert,
 	       offset, offset + tbl_rw_test_param.num_insert - 1);
 
-- 
2.48.1.vfs.0.0

