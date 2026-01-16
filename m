Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64853C98306
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 23:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B7A4281D;
	Sat, 17 Jan 2026 00:10:03 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id A76CD402AC;
 Sat, 17 Jan 2026 00:10:01 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45ACD1682;
 Fri, 16 Jan 2026 15:09:54 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9A253F632;
 Fri, 16 Jan 2026 15:10:00 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, techboard@dpdk.org, honnappa.nagarahalli@arm.com,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 1/2] MAINTAINERS: ring queue: update maintainer
Date: Fri, 16 Jan 2026 23:09:44 +0000
Message-ID: <20260116230945.1536106-1-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
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

I have contributed multiple bug fixes critical for correctness
under the C11 memory model and have been actively reviewing code
for this module over the past year.

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7d8dbdb25..45fbebd3c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -412,8 +412,8 @@ F: app/test/test_mempool*
 F: app/test/test_func_reentrancy.c
 
 Ring queue
-M: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
 M: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
+M: Wathsala Vithanage <wathsala.vithanage@arm.com>
 F: lib/ring/
 F: doc/guides/prog_guide/ring_lib.rst
 F: app/test/test_ring*
-- 
2.43.0

