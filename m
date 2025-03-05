Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B1C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 19:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4590D4025F;
	Wed,  5 Mar 2025 20:46:09 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1C18640156
 for <dev@dpdk.org>; Wed,  5 Mar 2025 20:46:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 6D8E6210EAE7; Wed,  5 Mar 2025 11:46:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D8E6210EAE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741203967;
 bh=Ga/NPf9CvUgGzi9i/AeX0HIemXuDUZykYZpZ+pCYmtI=;
 h=From:To:Cc:Subject:Date:From;
 b=WaPX4GUp4Num/mkhep32oQRfGZUmUtvCGEkf9BkLe8jRYfNSR+Brc21spK/QKH8Xd
 d+RMdDm1FOyKIxwqFt+N2HHqjECMu7TJsR1GQh1OYRVBgbqzDV/gtOIJxiTkcjxgQF
 Wx9erk5hmi2I+CwLcsLiAU09r+W9ysPPFyqgdZTI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] hash_multiwriter_autotest: fix printf parameters
Date: Wed,  5 Mar 2025 11:45:55 -0800
Message-Id: <1741203955-15203-1-git-send-email-andremue@linux.microsoft.com>
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

../app/test/test_hash_multiwriter.c(71): warning C4476: 'printf' :
    unknown type field character ''' in format specifier
../app/test/test_hash_multiwriter.c(73): warning C4474: 'printf' :
    too many arguments passed for format string
../app/test/test_hash_multiwriter.c(73): note: placeholders and their
    parameters expect 2 variadic arguments, but 4 were provided

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_hash_multiwriter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_hash_multiwriter.c b/app/test/test_hash_multiwriter.c
index 33d3147bd8..c24b09013f 100644
--- a/app/test/test_hash_multiwriter.c
+++ b/app/test/test_hash_multiwriter.c
@@ -68,7 +68,7 @@ test_hash_multiwriter_worker(void *arg)
 	 */
 	offset = pos_core * tbl_multiwriter_test_params.nb_tsx_insertion;
 
-	printf("Core #%d inserting %d: %'"PRId64" - %'"PRId64"\n",
+	printf("Core #%d inserting %d: %" PRId64 " - %" PRId64 "\n",
 	       lcore_id, tbl_multiwriter_test_params.nb_tsx_insertion,
 	       offset,
 	       offset + tbl_multiwriter_test_params.nb_tsx_insertion - 1);
-- 
2.48.1.vfs.0.0

