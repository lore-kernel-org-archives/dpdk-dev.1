Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B63C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 18:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40E9F4042E;
	Tue,  4 Feb 2025 19:54:43 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 95D4B40261
 for <dev@dpdk.org>; Tue,  4 Feb 2025 19:54:36 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1613E210C337; Tue,  4 Feb 2025 10:54:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1613E210C337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738695275;
 bh=Olc5e6j9rVjMVE5alMZK5akwjazmT3nqLC42LRlQWaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FgRje70wujrdP0FPKJ+cT5DNawubeau7d0KHyY3dDanI4XNB/w/eR+edV9IjgXW3/
 wSMe6YNe5pa1F1ISzODpKqrKTutjbPcmNU+kWmDyqFBIye+FCDwLHD2ch3rs+znENi
 o0LNlCQHGP89SjHoAzrWRnt3zWddSqFbuwrAEjug=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v4 7/7] mldev: eliminate dependency on non-portable
 __SIZEOF_LONG__
Date: Tue,  4 Feb 2025 10:54:31 -0800
Message-Id: <1738695271-29948-8-git-send-email-andremue@linux.microsoft.com>
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
 lib/mldev/mldev_utils_scalar.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/mldev/mldev_utils_scalar.h b/lib/mldev/mldev_utils_scalar.h
index 57e66ddb60..a9462089d7 100644
--- a/lib/mldev/mldev_utils_scalar.h
+++ b/lib/mldev/mldev_utils_scalar.h
@@ -12,12 +12,8 @@
 #define BIT(nr) (1UL << (nr))
 #endif
 
-#ifndef BITS_PER_LONG
-#define BITS_PER_LONG (__SIZEOF_LONG__ * 8)
-#endif
-
 #ifndef GENMASK_U32
-#define GENMASK_U32(h, l) (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK_U32(h, l) (((~0UL) << (l)) & (~0UL >> (RTE_BITS_PER_LONG - 1 - (h))))
 #endif
 
 /* float32: bit index of MSB & LSB of sign, exponent and mantissa */
-- 
2.47.2.vfs.0.1

