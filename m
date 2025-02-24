Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE8EC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 11:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEF54410F1;
	Mon, 24 Feb 2025 12:40:33 +0100 (CET)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com
 [52.119.213.154])
 by mails.dpdk.org (Postfix) with ESMTP id AFC7140E4A
 for <dev@dpdk.org>; Mon, 24 Feb 2025 12:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1740397229; x=1771933229;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=u2S/bDHBKlUfpav+q8tP2Crmyc7zZXDTyEuBwYsy0VQ=;
 b=bIrBh2fvrAhIX+TG6ZRY30jkZ+ksm4CmZ0Lom9Y2ph12CSnVU8sOAGMW
 BPONnKQarYRF9Vj9AMB/ViOHmqXYvvmIAxU9N2pXOKOj1qVHlgNkPCVWZ
 D7pFroRLBnDn8kCkGDTXJDeD+MByp2PIU7Y1SC3zZmLiLhPP/OKEthto2 0=;
X-IronPort-AV: E=Sophos;i="6.13,311,1732579200"; d="scan'208";a="273809680"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:40:25 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:18302]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.43:2525]
 with esmtp (Farcaster)
 id 577aba13-f910-489a-b769-586faeee1256; Mon, 24 Feb 2025 11:40:16 +0000 (UTC)
X-Farcaster-Flow-ID: 577aba13-f910-489a-b769-586faeee1256
Received: from EX19D007EUA001.ant.amazon.com (10.252.50.133) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D007EUA001.ant.amazon.com (10.252.50.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 11:40:16 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 11:40:15 +0000
Received: from HFA15-CG15235BS.amazon.com (unknown [10.1.213.12])
 by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix)
 with ESMTP id 9699B800CD; Mon, 24 Feb 2025 11:40:14 +0000 (UTC)
From: <shaibran@amazon.com>
To: <ferruh.yigit@amd.com>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 0/4] net/ena: release 2.12.0
Date: Mon, 24 Feb 2025 13:40:07 +0200
Message-ID: <20250224114011.1789-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
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

From: Shai Brandes <shaibran@amazon.com>

Dear DPDK maintainers and contributors,
We would appreciate your review of the ENA driver 2.12.0 patchset,
which includes readiness for the upcoming hardware generations.
Your feedback and insights on the patchset would be highly appreciated.

Thank you in advance for your time and effort,
AWS ENA driver team

Shai Brandes (4):
  net/ena/base: upgrade ena-com to the latest version
  net/ena: add support for mutable RSS table size
  net/ena: remove deprecated notifications
  net/ena: upgrade driver version to 2.12.0

 doc/guides/rel_notes/release_25_03.rst        |  4 +
 drivers/net/ena/base/ena_com.c                | 84 +++++++++----------
 drivers/net/ena/base/ena_com.h                |  5 +-
 .../net/ena/base/ena_defs/ena_admin_defs.h    |  3 +
 .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  7 +-
 drivers/net/ena/ena_ethdev.c                  | 84 +++++++------------
 drivers/net/ena/ena_ethdev.h                  |  8 +-
 drivers/net/ena/ena_rss.c                     | 48 +++++++++--
 8 files changed, 123 insertions(+), 120 deletions(-)

-- 
2.17.1

