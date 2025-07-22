Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C39C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 16:07:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3DF940269;
	Tue, 22 Jul 2025 18:07:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 855FC4003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 18:07:00 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 467961516;
 Tue, 22 Jul 2025 09:06:54 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC-2.cambridge.arm.com
 [10.1.37.76])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6255C3F5A1;
 Tue, 22 Jul 2025 09:06:59 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH] maintainers: update for DTS
Date: Tue, 22 Jul 2025 17:05:14 +0100
Message-ID: <20250722160529.2659392-1-luca.vizzarro@arm.com>
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

Paul is giving up his role of co-maintainer of DTS, electing Luca
Vizzarro in his place.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9357f3a3..2098a68b1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -65,7 +65,7 @@ M: Maxime Coquelin <maxime.coquelin@redhat.com>
 T: git://dpdk.org/next/dpdk-next-baseband
 
 Next-dts Tree
-M: Paul Szczepanek <paul.szczepanek@arm.com>
+M: Luca Vizzarro <luca.vizzarro@arm.com>
 M: Patrick Robb <probb@iol.unh.edu>
 T: git://dpdk.org/next/dpdk-next-dts
 
-- 
2.43.0

