Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0372CC282DE
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:38:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB4B740659;
	Wed,  5 Mar 2025 17:38:22 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9518740430
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:38:18 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9E410210EAE5; Wed,  5 Mar 2025 08:38:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E410210EAE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741192697;
 bh=MTFHioTSeP3aST9LAaCgnvGX2uJWw2ESWimpgAyoJfM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WGeXUnTW0F3XpgzXwaKEKmAtj30i9MJEHvx1vF7/rJEmnbJTvq/3wVrGPdP7cbn54
 ul4PhsbTl/CMrzEZxE22p3hbUWuK0DYKYAZNIHzFS+01rw9X+sPG95v8vqEiYyrmys
 xkJgvkiZrzemfuBblKoJ3SrMNllnHZAKIDXVnWWA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v3 1/5] maintainers: add portable version of
 __builtin_add_overflow
Date: Wed,  5 Mar 2025 08:38:06 -0800
Message-Id: <1741192690-26243-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
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
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 312e6fcee5..31c25a6fff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -179,6 +179,7 @@ F: app/test/test_devargs.c
 F: app/test/test_eal*
 F: app/test/test_errno.c
 F: app/test/test_lcores.c
+F: app/test/test_math.c
 F: app/test/test_memcpy*
 F: app/test/test_per_lcore.c
 F: app/test/test_pflock.c
-- 
2.48.1.vfs.0.0

