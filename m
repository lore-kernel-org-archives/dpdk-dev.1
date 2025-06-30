Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB3C7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B5F740264;
	Mon, 30 Jun 2025 13:14:36 +0200 (CEST)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com
 [99.78.197.217]) by mails.dpdk.org (Postfix) with ESMTP id B88904025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:14:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751282075; x=1782818075;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=jt5oQqoQsmJH9cqk7XtTzPnp87i34dGDESHPEeSKeHU=;
 b=W8dyc1XdIZBPSobgzfYmg3UGaEfzdKY0B42Y9A1H/gB5HvJZi5aCR/KW
 xeq4o5PNG5JbGcREng7jL6327BboQnxdanXg8d0FlQb3Lnm7Zhzqz+van
 3tsotgpChHQWsso1OK8HdcywIWG3/zd7xM3lFQxkxtFIOJLtbiSzIGCPK
 W+dZpHpVcU2ah0b7+sZdmZgNhseXxc2mdWsFCVGk6+QE0cTpYwCLKZotu
 w6uefsC4imXJK0iO/zguN3RsHS2+LoTAILxxuWakPEx6IFlMGEGG50agz
 ywkbEA4tpRr4cz5WjE6eLiwk9vKh0BuXRbOHGNvyn3ZA+btkElEvOkdj/ w==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="65540586"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:14:32 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:33507]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.132:2525]
 with esmtp (Farcaster)
 id 407776e0-2bc6-467a-b89f-0e22187a5ba6; Mon, 30 Jun 2025 11:14:30 +0000 (UTC)
X-Farcaster-Flow-ID: 407776e0-2bc6-467a-b89f-0e22187a5ba6
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:28 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:26 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 0/7] net/ena: release 2.13.0
Date: Mon, 30 Jun 2025 14:13:51 +0300
Message-ID: <20250630111358.3476-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

This patchset includes an upgrade of the ENA HAL,
introduces a new feature, and addresses three bug fixes.

Thank you in advance to the net maintainers and community members
for your time and effort reviewing the code.

Best regards,
Shai Brandes
AWS Elastic Network Adapter team

---
v2:
Removed patch "net/ena: fix virtual address calc for unaligned BARs"
which contained a problematic casting when compiling with 32-bit system

v3:
no change, there was some technical issue when sending the emails
where part of the patches apeared on different series.

v4:
Each patch in the series should compile independently.  
Patch 4/7 causes a compile error that was missed,  
as the full series passed our directed tests when applied together

v5:
Reworked the patchset so it applies cleanly on origin/main
due to release notes mismatch.

Shai Brandes (7):
  net/ena/base: avoid recalculating desc per entry
  net/ena/base: coding style changes
  net/ena: separate doorbell logic for Rx and Tx
  net/ena: support fragment bypass mode
  net/ena: fix unhandled interrupt config failure
  net/ena: fix aenq timeout with low poll interval
  net/ena: upgrade driver version to 2.13.0

 doc/guides/nics/ena.rst                       | 13 ++-
 doc/guides/rel_notes/release_25_07.rst        |  9 ++
 drivers/net/ena/base/ena_com.c                | 40 +++++++-
 drivers/net/ena/base/ena_com.h                |  7 ++
 .../net/ena/base/ena_defs/ena_admin_defs.h    | 14 +++
 drivers/net/ena/base/ena_eth_com.c            |  6 +-
 drivers/net/ena/base/ena_eth_com.h            | 15 ++-
 drivers/net/ena/ena_ethdev.c                  | 98 +++++++++++++++----
 drivers/net/ena/ena_ethdev.h                  |  4 +-
 9 files changed, 175 insertions(+), 31 deletions(-)

-- 
2.17.1

