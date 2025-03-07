Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F760C282D1
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 02:13:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4BBF40A75;
	Fri,  7 Mar 2025 03:13:10 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 103AD4029E
 for <dev@dpdk.org>; Fri,  7 Mar 2025 03:13:09 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4EAE82038F21; Thu,  6 Mar 2025 18:13:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EAE82038F21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741313588;
 bh=WzOG/65X5vDNlkGmKsPfo4DKIkJSTThT1WES4pk3ZzI=;
 h=From:To:Cc:Subject:Date:From;
 b=s2RjhMuFSdqBvE0Fr215hD3wHmexLE2cIsKW8PXepeaNRukqXJmOPBUTR7oIgwqc0
 rgtS+iDuBBj5cf1BHpCH02CivUDOSn6qLAKXd/892NmYbjH6EDnpXW63EZYhBFzoel
 c9JtHniyEXH3AkKOGPmRnfp1hgAO8wVtTX7ke/ig=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] test_ipfrag: remove array of size zero
Date: Thu,  6 Mar 2025 18:13:01 -0800
Message-Id: <1741313581-14300-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling with MSVC the error below pops up:

../app/test/test_ipfrag.c(39): error C2466:
    cannot allocate an array of constant size 0
../app/test/test_ipfrag.c(157): warning C4034: sizeof returns 0
../app/test/test_ipfrag.c(160): warning C4034: sizeof returns 0

The fix is to simplify the code and remove the zero-size array.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_ipfrag.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/app/test/test_ipfrag.c b/app/test/test_ipfrag.c
index 18d6727157..95d7952b4d 100644
--- a/app/test/test_ipfrag.c
+++ b/app/test/test_ipfrag.c
@@ -36,8 +36,6 @@ uint8_t expected_first_frag_ipv4_opts_nocopied[] = {
 	0x00, 0x00, 0x00, 0x00,
 };
 
-uint8_t expected_sub_frag_ipv4_opts_nocopied[0];
-
 struct test_opt_data {
 	bool is_first_frag;		 /**< offset is 0 */
 	bool opt_copied;		 /**< ip option copied flag */
@@ -153,11 +151,8 @@ test_get_ipv4_opt(bool is_first_frag, bool opt_copied,
 				expected_sub_frag_ipv4_opts_copied,
 				sizeof(expected_sub_frag_ipv4_opts_copied));
 		} else {
-			expected_opt->len =
-				sizeof(expected_sub_frag_ipv4_opts_nocopied);
-			memcpy(expected_opt->data,
-				expected_sub_frag_ipv4_opts_nocopied,
-				sizeof(expected_sub_frag_ipv4_opts_nocopied));
+			expected_opt->len = 0;
+			/* No data to be copied */
 		}
 	}
 }
-- 
2.48.1.vfs.0.0

