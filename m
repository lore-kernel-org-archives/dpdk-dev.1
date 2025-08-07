Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676ECC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 14:31:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F1754028B;
	Thu,  7 Aug 2025 16:31:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B2A9F4027C
 for <dev@dpdk.org>; Thu,  7 Aug 2025 16:31:43 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16FDE1758;
 Thu,  7 Aug 2025 07:31:35 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC-2.cambridge.arm.com
 [10.1.37.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 439E23F738;
 Thu,  7 Aug 2025 07:31:42 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] maintainers: update for DTS
Date: Thu,  7 Aug 2025 15:30:19 +0100
Message-ID: <20250807143019.1986881-1-luca.vizzarro@arm.com>
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

The MAINTAINERS file was only updated to replace Paul with Luca for the
next-dts tree only. This commit adds Luca as a maintainer for the dts
folder on the main tree as well.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7aca98c537..1700ac74a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1981,7 +1981,7 @@ F: app/proc-info/
 F: doc/guides/tools/proc_info.rst
 
 DTS
-M: Paul Szczepanek <paul.szczepanek@arm.com>
+M: Luca Vizzarro <luca.vizzarro@arm.com>
 M: Patrick Robb <probb@iol.unh.edu>
 T: git://dpdk.org/next/dpdk-next-dts
 F: dts/
-- 
2.43.0

