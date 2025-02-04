Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3555C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 18:54:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCA1140299;
	Tue,  4 Feb 2025 19:54:37 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id AAC654025F
 for <dev@dpdk.org>; Tue,  4 Feb 2025 19:54:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CCC272054921; Tue,  4 Feb 2025 10:54:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCC272054921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738695274;
 bh=jObmWukmhWjWwHbnCI8j8lhSOECtu3Bmn/UVcLZKsO8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JJeTlGmCkjcKCbmhSbgTzGZu03aTyq2RBgU9+Txse5H9CE6TcW0roEqlL/Y8OA3Np
 FsExQifx3Mlhp+yvMZorrIJam6s5bwbvmk8LAZAa3zi7yrKA7bOq7d+LRbLGw+3Zzj
 gfXDXHHSTKIcEEqJWI+7U5AK5Jb2vlJvtiNQcoVU=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v4 2/7] drivers/bus: eliminate dependency on non-portable
 __SIZEOF_LONG__
Date: Tue,  4 Feb 2025 10:54:26 -0800
Message-Id: <1738695271-29948-3-git-send-email-andremue@linux.microsoft.com>
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
 drivers/bus/fslmc/mc/fsl_mc_cmd.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/mc/fsl_mc_cmd.h b/drivers/bus/fslmc/mc/fsl_mc_cmd.h
index a768774c89..f27a18905d 100644
--- a/drivers/bus/fslmc/mc/fsl_mc_cmd.h
+++ b/drivers/bus/fslmc/mc/fsl_mc_cmd.h
@@ -29,9 +29,8 @@
 #define le32_to_cpu	rte_le_to_cpu_32
 #define le16_to_cpu	rte_le_to_cpu_16
 
-#define BITS_PER_LONG	(__SIZEOF_LONG__ * 8)
 #define GENMASK(h, l) \
-		(((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+		(((~0UL) << (l)) & (~0UL >> (RTE_BITS_PER_LONG - 1 - (h))))
 
 struct mc_cmd_header {
 	union {
-- 
2.47.2.vfs.0.1

