Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C251C606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foss.arm.com header.i=@foss.arm.com header.a=rsa-sha256 header.s=main header.b=mCXc/A+r
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 214D140294;
	Mon, 16 Nov 2026 15:29:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DCD5A40150;
 Mon, 16 Nov 2026 15:29:08 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32EB61713;
 Mon, 16 Nov 2026 06:29:05 -0800 (PST)
Received: from KDFJ2LQKPJ.cambridge.arm.com (KDFJ2LQKPJ.cambridge.arm.com
 [10.2.197.124])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CEFF3F763;
 Mon, 16 Nov 2026 06:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1794839348; bh=2mMKdumNAqK83U80xJ0wIcsqOsJ78O4YeY28jmFQLNY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mCXc/A+rHAEZvwmGVyNplIOZrHWeNx4IaP7CMYbaNfGrCm2KXxBPha/SFRBfjJC7Y
 XFlcZJBTnz9VkfOzwo8VOCJM03Cqr3dMJKffZ/Zohjs3qHXjdCqZGpmYxwcFa0hzOW
 s8wfMOQCnTws5cw1RUwuEoUAUYv+I49e6V0d0Bb4=
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org, Jack Bond-Preston <jack.bond-preston@arm.com>,
 stable@dpdk.org, Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH v2] bitops: document max input value for rte_align[32,64]pow2
Date: Mon, 16 Nov 2026 14:27:58 +0000
Message-ID: <20261116142759.48440-1-jack.bond-preston@foss.arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113141307.4727-1-ms.bulatov7@gmail.com>
References: <20261113141307.4727-1-ms.bulatov7@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jack Bond-Preston <jack.bond-preston@arm.com>

rte_align32pow2 and rte_align62pow2 will overflow and return incorrect
values for input values exceeding 1<<31 and 1<<63, respectively. There
is no way to return a valid result here: the next power of two above
these values is unrepresentable with 32/64 bit unsigned integers.

Adjust the documentation for these functions to clarify that input
values above these limits will return invalid results, and thus should
not be provided to these functions. Additionally, document an existing
edge case of the implementation: when the input is 0, it returns 0 (not
a power of 2).

Fixes: 7253e3d2a5 ("bitops: move bit count functions")
Cc: stable@dpdk.org

Reported-by: Mark Bulatov <ms.bulatov7@gmail.com>
Signed-off-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/include/rte_bitops.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
index 45255b68aa..eb404a3dd4 100644
--- a/lib/eal/include/rte_bitops.h
+++ b/lib/eal/include/rte_bitops.h
@@ -1261,10 +1261,17 @@ rte_is_power_of_2(uint32_t n)
  * Aligns input parameter to the next power of 2
  *
  * @param x
- *   The integer value to align
+ *   The integer value to align. Must be less than or equal to 1 << 31
+ *   (0x80000000).
  *
  * @return
- *   The smallest power of 2 which is greater than or equal to @c x.
+ *   The smallest power of 2 which is greater than or equal to @c x, or 0 if
+ *   @c x is 0.
+ *
+ * @note If the input parameter exceeds 1 << 31 (0x80000000), then the expected
+ *       result is unrepresentable and the return value is invalid.
+ * @note For the input value 0, this function returns 0, which is not a power of
+ *       2.
  */
 static inline uint32_t
 rte_align32pow2(uint32_t x)
@@ -1296,10 +1303,17 @@ rte_align32prevpow2(uint32_t x)
  * Aligns 64b input parameter to the next power of 2
  *
  * @param v
- *   The 64b value to align
+ *   The 64b value to align. Must be less than or equal to 1 << 63
+ *   (0x8000000000000000).
  *
  * @return
- *   The smallest power of 2 which is greater than or equal to @c v.
+ *   The smallest power of 2 which is greater than or equal to @c v, or 0 if
+ *   @c v is 0.
+ *
+ * @note If the input parameter exceeds 1 << 63 (0x8000000000000000), then the
+ *       expected result is unrepresentable and the return value is invalid.
+ * @note For the input value 0, this function returns 0, which is not a power of
+ *       2.
  */
 static inline uint64_t
 rte_align64pow2(uint64_t v)
-- 
2.54.0 (Apple Git-157)

