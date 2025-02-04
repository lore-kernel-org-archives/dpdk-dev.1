Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2AC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F2C42788;
	Tue,  4 Feb 2025 17:23:08 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E9DB840648
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 371C5210D0C1; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 371C5210D0C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686168;
 bh=5K8NnvBuKfNdoeRH2uHEHHTvXAo3jG0xU1HKYV9xnjU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gqV9RNDm5JNz81TyIxTfY52NwTMWehdK2sgP+Tql1hxUZ67cUNrpkshyf5hbO/3js
 Xs+IhHo+dUnxUp2I37kCujpQwQYC4M8KZvh59B9IW+4pv4o/RYVZssh83F3K+AHQpf
 zPpQ1WffoqMD1RtlhMngcuVzTDNtRptjk/J2DUVE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v20 20/27] hash: remove use of VLAs by using standard arrays
Date: Tue,  4 Feb 2025 08:21:57 -0800
Message-Id: <1738686124-16173-21-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

MSVC does not support VLAs, replace VLAs with standard C arrays.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/hash/rte_thash_gf2_poly_math.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/hash/rte_thash_gf2_poly_math.c b/lib/hash/rte_thash_gf2_poly_math.c
index 1c62974e71..825da4382f 100644
--- a/lib/hash/rte_thash_gf2_poly_math.c
+++ b/lib/hash/rte_thash_gf2_poly_math.c
@@ -8,6 +8,7 @@
 #include <rte_thash.h>
 #include <rte_log.h>
 
+#define MAX_POLY_DEGREE 32
 #define MAX_TOEPLITZ_KEY_LENGTH 64
 RTE_LOG_REGISTER_SUFFIX(thash_poly_logtype, thash_poly, INFO);
 #define RTE_LOGTYPE_HASH thash_poly_logtype
@@ -149,7 +150,7 @@ gf2_pow(uint32_t a, uint32_t pow, uint32_t r, int degree)
 static uint32_t
 __thash_get_rand_poly(int poly_degree)
 {
-	uint32_t roots[poly_degree];
+	uint32_t roots[MAX_POLY_DEGREE];
 	uint32_t rnd;
 	uint32_t ret_poly = 0;
 	int i, j;
@@ -194,9 +195,7 @@ __thash_get_rand_poly(int poly_degree)
 	 * Get coefficients of the polynomial for
 	 * (x - roots[0])(x - roots[1])...(x - roots[n])
 	 */
-	uint32_t poly_coefficients[poly_degree + 1];
-	for (i = 0; i <= poly_degree; i++)
-		poly_coefficients[i] = 0;
+	uint32_t poly_coefficients[MAX_POLY_DEGREE + 1] = {0};
 
 	poly_coefficients[0] = 1; /* highest degree term coefficient in the end */
 	for (i = 0; i < (int)poly_degree; i++) {
@@ -247,7 +246,7 @@ thash_get_rand_poly(uint32_t poly_degree)
 {
 	uint32_t ret_poly;
 
-	if (poly_degree > 32) {
+	if (poly_degree > MAX_POLY_DEGREE) {
 		HASH_LOG(ERR, "Wrong polynomial degree %d, must be in range [1, 32]", poly_degree);
 		return 0;
 	}
-- 
2.47.2.vfs.0.1

