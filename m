Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2B5C021BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 01:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3B2D40650;
	Wed, 26 Feb 2025 02:07:14 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id DD45C4027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 02:07:05 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5BF562069416; Tue, 25 Feb 2025 17:07:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BF562069416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740532024;
 bh=UhFra2Xm7/V2aXBXsYBbHGRpQaRrmQDRObAYC8eC6SE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SAcO7orETNMDWVtlV9QAwFWO/lENGDHqeMz27cDBQuC/HAfiSPzPs1W+LQEGoi/Gi
 I6QzjBFcdMU4SKuIaa9z2PUOqnbsYB/ed2fBU75yvfoqqr1Vab8zzfYwFpBV5Vg3pZ
 /8szzM+fwB5/LopqlA+DpZ4guzTvbCHG8Azfl30k=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 5/5] acl: make compatible with instruction set updates for
 MSVC
Date: Tue, 25 Feb 2025 17:06:56 -0800
Message-Id: <1740532016-6789-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
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

Top level 'cc_avx2_flags' was created and holds the correct flags
depending on the compiler used.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/acl/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/acl/meson.build b/lib/acl/meson.build
index fefe131a48..a28d70c23f 100644
--- a/lib/acl/meson.build
+++ b/lib/acl/meson.build
@@ -19,7 +19,7 @@ if dpdk_conf.has('RTE_ARCH_X86')
     avx2_tmplib = static_library('avx2_tmp',
             'acl_run_avx2.c',
             dependencies: static_rte_eal,
-            c_args: cflags + ['-mavx2'])
+            c_args: [cflags, cc_avx2_flags])
     objs += avx2_tmplib.extract_objects('acl_run_avx2.c')
 
     # compile AVX512 version if:
-- 
2.48.1.vfs.0.0

