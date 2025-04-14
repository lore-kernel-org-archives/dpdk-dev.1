Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A8C369B2
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 20:28:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2529402D2;
	Mon, 14 Apr 2025 22:28:52 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8224A402CC
 for <dev@dpdk.org>; Mon, 14 Apr 2025 22:28:51 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 68591210C423; Mon, 14 Apr 2025 13:28:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68591210C423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744662530;
 bh=Ue+2AexvjmxdHhWlI3/GWDw6DuJ8mWF/bcXvXKyodaw=;
 h=From:To:Cc:Subject:Date:From;
 b=GnnrX4dlcYBdCGL9Jr88EnUWKUHRoT6VHrbUXwt1lhtS4DgLjS8a+MHmw86tGvaFn
 se36f6IVoGZe9MKSuR01p4M9008j+v24x40qdG3VK7CWE5QUzBuJ7+eAUNAP9tAi+Q
 LNchKisvkK9+qFFLiLKvfe9TL7Jlm2TRMedGuce8=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] eal: simplify code to avoid Coverity false positive
Date: Mon, 14 Apr 2025 13:28:38 -0700
Message-Id: <1744662518-5433-1-git-send-email-andremue@linux.microsoft.com>
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

Coverity complained about an overflow in a recently added function:

https://scan4.scan.coverity.com/#/project-view/66295/10075?selectedIssue=461876

CID 461876: (#1 of 1): Overflowed constant (INTEGER_OVERFLOW)
21. overflow_const: Expression powi, which is equal to 0, where base is
known to be equal to 1024, overflows the type that receives it, an
unsigned integer 64 bits wide.

This complaint was a false positive, but it revealed that the function
could be written in a simpler way, making the code more readable and
likely allowing Coverity to make the right determination.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/common/eal_common_string_fns.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
index 3bbd325515..fa87831c3a 100644
--- a/lib/eal/common/eal_common_string_fns.c
+++ b/lib/eal/common/eal_common_string_fns.c
@@ -115,7 +115,8 @@ char *
 rte_size_to_str(char *buf, int buf_size, uint64_t count, bool use_iec, const char *unit)
 {
 	/* https://en.wikipedia.org/wiki/International_System_of_Units */
-	const char *prefix = "kMGTPE";
+	static const char prefix[] = "kMGTPE";
+	size_t prefix_index = 0;
 	const unsigned int base = use_iec ? 1024 : 1000;
 	uint64_t powi = 1;
 	uint16_t powj = 1;
@@ -134,14 +135,10 @@ rte_size_to_str(char *buf, int buf_size, uint64_t count, bool use_iec, const cha
 	/* increase value by a factor of 1000/1024 and store
 	 * if result is something a human can read
 	 */
-	for (;;) {
+	for (; prefix_index < sizeof(prefix) - 1; ++prefix_index) {
 		powi *= base;
 		if (count / powi < base)
 			break;
-
-		if (prefix[1] == '\0')
-			break;
-		++prefix;
 	}
 
 	/* try to guess a good number of digits for precision */
@@ -152,7 +149,7 @@ rte_size_to_str(char *buf, int buf_size, uint64_t count, bool use_iec, const cha
 	}
 
 	result = snprintf(buf, buf_size, "%.*f %c%s%s", precision,
-			  (double)count / powi, *prefix, use_iec ? "i" : "",
+			  (double)count / powi, prefix[prefix_index], use_iec ? "i" : "",
 			  (unit != NULL) ? unit : "");
 	return result < buf_size ? buf : NULL;
 }
-- 
2.49.0.vfs.0.0

