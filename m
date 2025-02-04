Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118C4C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 18:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6C1A40288;
	Tue,  4 Feb 2025 19:54:36 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A4A4D400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 19:54:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C09F0205491F; Tue,  4 Feb 2025 10:54:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C09F0205491F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738695274;
 bh=oI5igbiKJ4u3yJHRsAkY4wJBz4x93bqxajNvJndiuec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aQUAKv71ltn6BAFD30qNZm2oY+M34atRyuJ46ZrZ+4b3C77xwglMhVMOmVYeRo9Qu
 O570H7geMSDPoVcX/F+IRK/xXqj2xBCPU7EDv5khomJ6qMR4e5w9G214gm8f2w3638
 XWVjhR5Z2DIhu3J/R+R4m2ezhCPW3syCM4RzvJYU=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v4 1/7] eal: eliminate dependency on non-portable
 __SIZEOF_LONG__
Date: Tue,  4 Feb 2025 10:54:25 -0800
Message-Id: <1738695271-29948-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
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

Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
Therefore the errors below are seen with MSVC:

../lib/mldev/mldev_utils_scalar.c(465): error C2065:
    '__SIZEOF_LONG__': undeclared identifier
../lib/mldev/mldev_utils_scalar.c(478): error C2051:
    case expression not constant

../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
    '__SIZEOF_LONG__': undeclared identifier
../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
    case expression not constant

Turns out that the places where __SIZEOF_LONG__ is currently
being used can equally well use sizeof(long) instead.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/include/rte_common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 7a252c1997..47e3201006 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -679,6 +679,11 @@ rte_is_aligned(const void * const __rte_restrict ptr, const unsigned int align)
  */
 #define RTE_BUILD_BUG_ON(condition) do { static_assert(!(condition), #condition); } while (0)
 
+/*********** Data type size related macros ********/
+
+#define RTE_BITS_PER_LONG (sizeof(long) * 8)
+#define RTE_BITS_PER_LONG_LONG (sizeof(long long) * 8)
+
 /*********** Cache line related macros ********/
 
 /** Cache line mask. */
-- 
2.47.2.vfs.0.1

