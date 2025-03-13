Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF64EC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 20:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE09040289;
	Thu, 13 Mar 2025 21:00:51 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 47DE84025A
 for <dev@dpdk.org>; Thu, 13 Mar 2025 21:00:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7BEC22033435; Thu, 13 Mar 2025 13:00:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BEC22033435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741896048;
 bh=GfZr+NROl+sw+APXAgcELy2MTeuQTchVViZhC44dWQI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fa2KovcSP5jKEGlkDA3xXavet1uc0o7hK5z8Tu+wcxuA3c69Nsjxii0bGqb80qMti
 IfQ5Ta6ALXnVDc6TmU/1C1jh1zCRlTdxLvcind+SgiiUdE0sHJmSHEYdPNVk6C2YoK
 evfjyQUA6RVKNhn/OlenQjWzemoQSKJ/Q0doJ22M=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v4 1/5] maintainers: add portable version of
 __builtin_add_overflow
Date: Thu, 13 Mar 2025 13:00:39 -0700
Message-Id: <1741896043-10115-2-git-send-email-andremue@linux.microsoft.com>
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
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82f6e2f917..a60fd0f976 100644
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
2.48.1.vfs.0.1

