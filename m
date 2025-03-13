Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C06EC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 20:01:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24C09402E6;
	Thu, 13 Mar 2025 21:00:55 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6919540267
 for <dev@dpdk.org>; Thu, 13 Mar 2025 21:00:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9858B2033437; Thu, 13 Mar 2025 13:00:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9858B2033437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741896048;
 bh=nQUGH7scO318dJBCHiudGkIiElL0uxV2NqbIT0hWVSE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h1cR9MCGDZQ4AeWefwPMYmimEw/wnl29IuGQ8r++ryZJnpfgDTsW0XvI83hcyGl3M
 l185Hlaef61ePoTbzAU90dnWYGJsNn0xf/6DORIZASiA0oyksLZ4D98n2aWCd32XRa
 fx+k3ij2GbczGEJyyDg+kdABVhVJo6Cs+OlCEwCA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v4 3/5] doc/api: add portable version of __builtin_add_overflow
Date: Thu, 13 Mar 2025 13:00:41 -0700
Message-Id: <1741896043-10115-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741896043-10115-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741896043-10115-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. There's a need for a portable
version that can also be used with other compilers.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 doc/api/doxy-api-index.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index b2fc24b3e4..48922054ed 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -227,6 +227,7 @@ The public API headers are grouped by topics:
   [checksum](@ref rte_cksum.h),
   [config file](@ref rte_cfgfile.h),
   [key/value args](@ref rte_kvargs.h),
+  [math](@ref rte_math.h),
   [argument parsing](@ref rte_argparse.h),
   [ptr_compress](@ref rte_ptr_compress.h),
   [string](@ref rte_string_fns.h),
-- 
2.48.1.vfs.0.1

