Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD93CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74B1C40E12;
	Wed, 15 Oct 2025 14:05:27 +0200 (CEST)
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.83.148.184]) by mails.dpdk.org (Postfix) with ESMTP id 1E9024065E
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760529925; x=1792065925;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=EIaQvHmlIzbmeksatfspGv/xis6gdZe2dTPwweFkZio=;
 b=cWAlmVw5tJVMVuP7uKtbgCwQoCYDOpey4fhtPrJO5eGWNeJCkjxC5JQW
 nGSejaOUYrjxNxR4RNn5uOPTvbkihsBjdqtdojuftBmROB5qewIK0pgu2
 fBzUOREKbfkufygu7yn7RWUhVoNNpgSM9+jsywnk/xuKsYyQpOCQKHtCy
 3JUUhdjzYtl4+JDj2lIGO7vbOZ3xFfEDRmBSuZPXjP3Sg5l3n2o63ZlKz
 fgd0On6gpkfynoInyxhqxY56AiezWFPjLzDyGdnIN2hhFwkXUF/v6VBHc
 7PEARMBOxWLDWpPzs6nY1wKiU5MVMf/v4gUoGC5SKf+9SMs/NJKFuJ+Iv w==;
X-CSE-ConnectionGUID: u77RzU/cRyeVIHYT4/eilg==
X-CSE-MsgGUID: HSddvLcfRxmV/a9/tCZKcA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4728812"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:05:22 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:1882]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.237:2525]
 with esmtp (Farcaster)
 id 602595ec-52c0-429e-929f-3fd486b94228; Wed, 15 Oct 2025 12:05:20 +0000 (UTC)
X-Farcaster-Flow-ID: 602595ec-52c0-429e-929f-3fd486b94228
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:05:19 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:05:18 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 00/20] net/ena: Release 2.14.0
Date: Wed, 15 Oct 2025 15:03:55 +0300
Message-ID: <20251015120415.2204-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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
introduces a new feature, and addresses few bug fixes.
Based on repository: dpdk-next-net; branch: origin/main; hash: 1d627ea13a

Thank you in advance to the net maintainers and community members
for your time and effort reviewing the code.

Best regards,
Shai Brandes
AWS Elastic Network Adapter team

---
v2:
removed 0002-net-ena-base-rework-admin-timeout-handling.patch which caused compilation failure in ubuntu-22.04-clang-stdatomic test


Shai Brandes (20):
  net/ena/base: optimize Tx desc fields setting
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
 drivers/net/ena/base/ena_com.c                | 273 +++++++++++++-----
 drivers/net/ena/base/ena_com.h                |  62 +++-
 .../net/ena/base/ena_defs/ena_admin_defs.h    |  44 +++
 .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  12 +-
 drivers/net/ena/base/ena_eth_com.c            | 218 ++++++++------
 drivers/net/ena/base/ena_eth_com.h            |  59 ++--
 drivers/net/ena/base/ena_plat_dpdk.h          |   2 +-
 drivers/net/ena/ena_ethdev.c                  | 140 ++++++++-
 drivers/net/ena/ena_ethdev.h                  |  19 +-
 drivers/net/ena/ena_rss.c                     |   2 +
 12 files changed, 626 insertions(+), 214 deletions(-)

-- 
2.17.1

