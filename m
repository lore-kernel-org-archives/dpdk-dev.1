Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7EDCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7ADD4278D;
	Wed, 15 Oct 2025 14:14:55 +0200 (CEST)
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [34.218.115.239])
 by mails.dpdk.org (Postfix) with ESMTP id E09DB40A6C
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530495; x=1792066495;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=+AhOl2ywWGXZg949s5bMUtpoL5GtsZEPDAeA2Kh4/Ds=;
 b=AFA3BcpkeBwYXrwilQHeyRwsL+pr3DcS47EOAHU4X3Ec60bFQkw9GV2u
 LkW/pGROAxh7EhajbNtRXeq3Eaqi86qw+aAh9wMRQNC3LDFeglEpyAVpZ
 RLHBQRO022Nz8A8pPWjgufK4+0tVA4M4XtJH1iM+ipTcml+9iRJg//Guh
 5OzVEsZ5BUO6t7aIgC7/JuIxWiXdHJ9+KxL+ugVlxyhn0+GEehuF2AA+e
 DqaHOtQKyxQ/a8gEQo4ThGMuMFEU2ooZnfkg3covH1pT39aWtr2ipnbDX
 le90YD/sXx0HgTngAu4vpRXjSh4kdpsm/rcxLGDCVrnSIsavtAG7YDhfv A==;
X-CSE-ConnectionGUID: pMeG0dVpRb2Jw7ShEZp4RQ==
X-CSE-MsgGUID: 9vYH2yryQm2WTZmEFxsj7w==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4738372"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:14:54 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:12911]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.122:2525]
 with esmtp (Farcaster)
 id e2aa6462-f9c6-4ffc-afdb-6c40ff242a63; Wed, 15 Oct 2025 12:14:53 +0000 (UTC)
X-Farcaster-Flow-ID: e2aa6462-f9c6-4ffc-afdb-6c40ff242a63
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:14:46 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:14:45 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 20/20] net/ena: upgrade driver version to 2.14.0
Date: Wed, 15 Oct 2025 15:14:36 +0300
Message-ID: <20251015121436.3219-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

driver version incremented to 2.14.0

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index 3274ecfb46..805990836d 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -23,7 +23,7 @@
 #include <ena_eth_io_defs.h>
 
 #define DRV_MODULE_VER_MAJOR	2
-#define DRV_MODULE_VER_MINOR	13
+#define DRV_MODULE_VER_MINOR	14
 #define DRV_MODULE_VER_SUBMINOR	0
 
 #define __MERGE_64B_H_L(h, l) (((uint64_t)h << 32) | l)
-- 
2.17.1

