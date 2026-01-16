Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01074C98306
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 23:10:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C795402AC;
	Sat, 17 Jan 2026 00:10:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DCFCB402CC;
 Sat, 17 Jan 2026 00:10:01 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 995C91684;
 Fri, 16 Jan 2026 15:09:54 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 20DC93F632;
 Fri, 16 Jan 2026 15:10:01 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, techboard@dpdk.org, honnappa.nagarahalli@arm.com,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 2/2] MAINTAINERS: MCSlock: update maintainer
Date: Fri, 16 Jan 2026 23:09:45 +0000
Message-ID: <20260116230945.1536106-2-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116230945.1536106-1-wathsala.vithanage@arm.com>
References: <20260116230945.1536106-1-wathsala.vithanage@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Replace Honnapa Nagarahalli with Wathsala Vithanage as a maintainer
for the Ring Queue module.

I have contributed critical correctness fixes under the C11 memory
model and added detailed documentation explaining the rationale
behind the relaxed memory ordering and synchronization primitives
used in the code.

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45fbebd3c8..c157cc9a97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -277,7 +277,7 @@ F: lib/eal/include/rte_bitmap.h
 F: app/test/test_bitmap.c
 
 MCSlock
-M: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
+M: Wathsala Vithanage <wathsala.vithanage@arm.com>
 F: lib/eal/include/rte_mcslock.h
 F: app/test/test_mcslock.c
 
-- 
2.43.0

