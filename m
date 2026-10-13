Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ADACC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:06:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C668A40274;
	Tue, 13 Oct 2026 17:06:35 +0200 (CEST)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92]) by mails.dpdk.org (Postfix) with ESMTP id 2242D40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791903994; x=1823439994;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Zl8ukgEF7WnbrGzBN6r6MNOGgkXa/W7/JAbgTkuxP4w=;
 b=Lk2RyLW2TmGZZs+T5xROXBWDqttEsG8f50PckiHc3lIKyVCafN+KhVn7
 90s97VnuC4VBSgaBUgXkIhuiezndU+cbYzQ6ahJfZSPej2Yk4AhjvWegP
 yaxVQx0WgtYxxEFEXyE34Uoa/1EaMhlhvr8GuvTQseCWVZQwYYx4GvNnK
 GhdQSGpxPXXuGj9uaEJc8S9mqcAC75j+/tAMuJVmxuOGo/QwhHDjRiJCB
 yzzAaSdn+0fetfr38NWN206Om5MnP3QQefVEghcStf58KJ5Zx4n/CJFRt
 iPapdA8MobOg9GyntuRi0DwhfKKtNqhE0K2+1mDGjJDxAE9UU3yH8WmT0 g==;
X-CSE-ConnectionGUID: a/TIgnVUQsGb/YT14i8f+Q==
X-CSE-MsgGUID: OOhYn8mFTX+35a17jyu2gw==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="30647926"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:06:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:8135]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.91:2525] with
 esmtp (Farcaster)
 id 9d193835-bd97-4db3-b8a7-333f25ebcc96; Tue, 13 Oct 2026 15:06:30 +0000 (UTC)
X-Farcaster-Flow-ID: 9d193835-bd97-4db3-b8a7-333f25ebcc96
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:06:30 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:06:28 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 00/13] ENA release 2.15.0
Date: Tue, 13 Oct 2026 18:06:11 +0300
Message-ID: <20261013150611.9237-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
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

Hello all,
This series upgrades HAL and fixes two PHC correctness issues,
an LLQ feature version not communicated to the device, and
a failed LLQ configuration zeroing the negotiated tx_max_header_size.
Additionally it adds n-tuple Rx flow steering support through the rte_flow API.
Review and comments are welcome

Best regards,
Shai Brandes

Shai Brandes (13):
  net/ena: avoid using un-needed admin response buffers
  net/ena/base: fix race in PHC destroy
  net/ena/base: fix missing barriers in PHC timestamp read
  net/ena/base: rename bounce buffer references
  net/ena/base: add LLQ policy inline helper
  net/ena/base: fix LLQ feature version sent to device
  net/ena/base: deduplicate LLQ entry write and advance
  net/ena/base: deduplicate meta caching config flag
  net/ena/base: split LLQ info into datapath and config
  net/ena/base: fix LLQ config failure flow
  net/ena: support flow API for n-tuple Rx steering
  net/ena/base: remove x86 Tx LLQ write barrier
  net/ena: upgrade driver version to 2.15.0

 doc/guides/nics/ena.rst                       |  26 +
 doc/guides/nics/features/ena.ini              |  10 +
 doc/guides/rel_notes/release_26_11.rst        |   6 +
 drivers/net/ena/base/ena_com.c                | 793 +++++++++++++-----
 drivers/net/ena/base/ena_com.h                | 134 ++-
 .../net/ena/base/ena_defs/ena_admin_defs.h    |  83 +-
 drivers/net/ena/base/ena_eth_com.c            | 131 +--
 drivers/net/ena/base/ena_eth_com.h            |  18 +-
 drivers/net/ena/base/ena_plat_dpdk.h          |   8 +
 drivers/net/ena/ena_ethdev.c                  |  73 +-
 drivers/net/ena/ena_ethdev.h                  |   3 +-
 drivers/net/ena/ena_flow.c                    | 542 ++++++++++++
 drivers/net/ena/ena_flow.h                    |  12 +
 drivers/net/ena/meson.build                   |   1 +
 14 files changed, 1512 insertions(+), 328 deletions(-)
 create mode 100644 drivers/net/ena/ena_flow.c
 create mode 100644 drivers/net/ena/ena_flow.h

-- 
2.17.1

