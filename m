Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A70C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:26:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2498A4064F;
	Thu, 22 May 2025 15:26:55 +0200 (CEST)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com
 [207.171.188.204])
 by mails.dpdk.org (Postfix) with ESMTP id 4E239402E5
 for <dev@dpdk.org>; Thu, 22 May 2025 15:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747920414; x=1779456414;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=1lKPR6qwywGC8hZUFynmEBOdlUVm1u0OGyYzE9GbaPQ=;
 b=pvrAbZD8vIsOYBlXpUqCF/ma5EdZ6PvNKk1Gylzncy80fzeGBOA4f9CN
 pQnqIfGvuLG83xc0ral0ZiFpVuKaxRlKL+8hisW4SGIoFog9WWy40k/TZ
 0TJcb2YEcVaZbUORKOSrLLFGGbJiQ69BjPoR5rYJ0x0lTwpsPcnwA7JtZ
 iZaYvEtHqxyaqfzpH3oJhPi/zhDuANkGTKb5khvgtcvdn+wMe8KSYVYLR
 htAcGKPiNp1Hz3KO9NUfU+YFj5dB42y92xQXjRh1OS+TiEQL4ezXu0Gp0
 TGZ6ZTSarohkk/fDrDhCfpWIY1Ie9x0M8TKcAofw82WcLMdHAGPKyPFbD w==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="22706299"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-9105.sea19.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:26:43 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:15183]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.21.132:2525]
 with esmtp (Farcaster)
 id 45a979a5-1162-4f78-b5e0-72f9fb2930ca; Thu, 22 May 2025 13:26:41 +0000 (UTC)
X-Farcaster-Flow-ID: 45a979a5-1162-4f78-b5e0-72f9fb2930ca
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:26:41 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:26:39 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 0/7] net/ena: release 2.13.0
Date: Thu, 22 May 2025 16:26:07 +0300
Message-ID: <20250522132614.3379-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
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
 drivers/net/ena/base/ena_com.c                | 39 +++++++-
 drivers/net/ena/base/ena_com.h                |  8 ++
 .../net/ena/base/ena_defs/ena_admin_defs.h    | 15 +++
 drivers/net/ena/base/ena_eth_com.c            |  6 +-
 drivers/net/ena/base/ena_eth_com.h            | 15 ++-
 drivers/net/ena/ena_ethdev.c                  | 98 +++++++++++++++----
 drivers/net/ena/ena_ethdev.h                  |  5 +-
 9 files changed, 177 insertions(+), 31 deletions(-)

-- 
2.17.1

