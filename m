Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16729CCF2C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 06:36:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AA8D40611;
	Sun, 18 Oct 2026 08:36:25 +0200 (CEST)
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
 by mails.dpdk.org (Postfix) with ESMTP id 5465840276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 08:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792305383; x=1823841383;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=oGifBzW0tBDnt5BvKETMzwfIjlCPyhNKLeES2uQfiso=;
 b=GJ4NhkDNrWpsPnFLL+uWerFqJz2DZMueBTiks+J5AD4NYHQfPyERzGeU
 OT+Gkr30eGGIo9wQJhs3OfSH0a6Y8WyXM9YE9xpG8jvHX2UoimJtFoFu0
 ONall/dolvPsPMgABiW4ZA5ohTM2491+Twl64ZIBFR57DMzYQ5GiUqXGB
 tZjVYeytHZP9f87JtVjr12xX73nzG1UEHvKyq7kwH3YJ+NF/Ze2fHV+DR
 B0+EbdFFS4YIQpiev1Ix3NHB8e3/RWurTvmfILHzaNJ+uxfHS/8fai1Y+
 r/qneCRRXarmC0NtSkGuyiPJ/JGLQ4V7LS3+lRyZTS4QNGF8TBRiNwnNT w==;
X-CSE-ConnectionGUID: 5fM0fKK1QAWUebxJ0pC89w==
X-CSE-MsgGUID: llzA9yGfQI+gVtwMwXC14Q==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31598022"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 06:36:19 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:30027]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.120:2525]
 with esmtp (Farcaster)
 id 14d07318-c071-4403-887b-c3637e077b63; Sun, 18 Oct 2026 06:36:19 +0000 (UTC)
X-Farcaster-Flow-ID: 14d07318-c071-4403-887b-c3637e077b63
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 06:36:19 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 06:36:18 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 00/13] ENA release 2.15.0
Date: Sun, 18 Oct 2026 09:36:06 +0300
Message-ID: <20261018063606.973-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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

---
v2:
* Fixed Fedora compilation issue

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
 drivers/net/ena/base/ena_com.h                | 115 ++-
 .../net/ena/base/ena_defs/ena_admin_defs.h    |  83 +-
 drivers/net/ena/base/ena_eth_com.c            | 131 +--
 drivers/net/ena/base/ena_eth_com.h            |  18 +-
 drivers/net/ena/base/ena_plat_dpdk.h          |   8 +
 drivers/net/ena/ena_ethdev.c                  |  73 +-
 drivers/net/ena/ena_ethdev.h                  |   3 +-
 drivers/net/ena/ena_flow.c                    | 542 ++++++++++++
 drivers/net/ena/ena_flow.h                    |  12 +
 drivers/net/ena/meson.build                   |   1 +
 14 files changed, 1512 insertions(+), 309 deletions(-)
 create mode 100644 drivers/net/ena/ena_flow.c
 create mode 100644 drivers/net/ena/ena_flow.h

-- 
2.17.1

