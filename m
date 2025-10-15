Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA692CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:07:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C63324064F;
	Wed, 15 Oct 2025 09:07:25 +0200 (CEST)
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
 by mails.dpdk.org (Postfix) with ESMTP id 230B940615
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512044; x=1792048044;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=BHIW8Ypx6vSF+uvGchQTG2ViUIQPhn9sOlS5hLO/2E0=;
 b=np7B6HK0/ZuzNKnjlARta0z5Xip/5DFtH7XcvS94igvaKyrzq2gshB9b
 TjC4Tt4UF99bmiX+36+Nc1zjAorB+XIzbBYKihFSoXHJFBkPFxa4eO70X
 AAz/vyHy8RvvfM+O7tQOhQIT0A7RDGEuDh5bw6rNGZCrRuENlafITEIdK
 nr1t6KAiTain95gitcXA+rj88j7X6XA/J0x7Z3L2UZEOwe+banE3rBRFC
 AKOkshKpqIdeho+6R/DFXFRFIjkNzxX3SaNqgcHWfvirwBYAXACIA3vCS
 6m5+3fL23tDjcyS2TajUfcYlntLLN1A/NVWBNmRMjLKu5Vy5SdctcLwoj w==;
X-CSE-ConnectionGUID: TVrca6YDQ52wj9JkTijkmQ==
X-CSE-MsgGUID: oq2LSylUR4Wil1IeGpbjVA==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4915020"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:07:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:4866]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.171:2525]
 with esmtp (Farcaster)
 id 81e4907c-2fcc-47fe-ae1e-3cd623e935e9; Wed, 15 Oct 2025 07:07:21 +0000 (UTC)
X-Farcaster-Flow-ID: 81e4907c-2fcc-47fe-ae1e-3cd623e935e9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:07:21 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:07:19 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 00/21] net/ena: Release 2.14.0
Date: Wed, 15 Oct 2025 10:06:46 +0300
Message-ID: <20251015070707.340-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
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

This patchset includes an upgrade of the ENA HAL,
introduces a new feature, and addresses three bug fixes.
Based on repository: dpdk-next-net; branch: origin/main; hash: 1d627ea13a

Thank you in advance to the net maintainers and community members
for your time and effort reviewing the code.

Best regards,
Shai Brandes
AWS Elastic Network Adapter team

Shai Brandes (21):
  net/ena/base: optimize Tx desc fields setting
  net/ena/base: rework admin timeout handling
  net/ena/base: add extended Tx cdesc support
  net/ena/base: add IO ring helper functions
  net/ena/base: add lost interrupt indication
  net/ena/base: add Rx cdesc dump on bad request ID
  net/ena: add Rx HW timestamping support
  net/ena: rework sanity checks
  net/ena: add verification of DMA address width
  net/ena: fix PCI BAR mapping on 64K page size
  net/ena: style and comment changes
  net/ena/base: rework log format
  net/ena/base: add phc error statistics
  net/ena/base: remove redundant zeroing of Tx desc
  net/ena/base: style changes in hal
  net/ena/base: improve admin logging
  net/ena/base: remove redundant if sentence
  net/ena/base: fix unsafe memcpy on invalid memory
  net/ena/base: optimize branch prediction
  net/ena/base: change return type and improve logging
  net/ena: upgrade driver version to 2.14.0

 doc/guides/nics/ena.rst                       |   4 +
 doc/guides/rel_notes/release_25_11.rst        |   5 +
 drivers/net/ena/base/ena_com.c                | 346 ++++++++++++------
 drivers/net/ena/base/ena_com.h                |  63 +++-
 .../net/ena/base/ena_defs/ena_admin_defs.h    |  44 +++
 .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  12 +-
 drivers/net/ena/base/ena_eth_com.c            | 218 +++++++----
 drivers/net/ena/base/ena_eth_com.h            |  59 +--
 drivers/net/ena/base/ena_plat_dpdk.h          |  24 +-
 drivers/net/ena/ena_ethdev.c                  | 140 ++++++-
 drivers/net/ena/ena_ethdev.h                  |  19 +-
 drivers/net/ena/ena_rss.c                     |   2 +
 12 files changed, 693 insertions(+), 243 deletions(-)

-- 
2.17.1

