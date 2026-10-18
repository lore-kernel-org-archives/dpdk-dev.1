Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E5CCA490
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7D1740613;
	Sun, 18 Oct 2026 11:45:58 +0200 (CEST)
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.246.68.102]) by mails.dpdk.org (Postfix) with ESMTP id 12A3940276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 11:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792316757; x=1823852757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=ihML5RBD2Fil7zBdFwsappfcSai0qR72cIjU0guDkiE=;
 b=TFWbKootT+ZYxsYxK6KbT4MWJVpu2xwleUC/93lZZ2uCTgP/hax1eyao
 MV1nLxLGYMxLiqouOdHhufgZzcL7MEvXvz8OYz5WHujF+/nFgTC7MdREM
 dWQWKEw3YwnSVqiIu5hIgzJEuY8kS4kMB2Z8VUdSEENUeetwepAXaUTwx
 J3gxmgqaD8CuG9iBVgyMtE5B78c1RzUiAyburk9ZN/IuQZO/NnZsZZiwo
 ygCVHK5cwVvPRBMBtRzeBowus4XBtk+ywsZeJLHpAgVfQE7sXu8VilG8y
 1JtAZt9mVyPR/kL41/rsJ9fnLMpiJz0OYt1Ytwj9P5BMIGTt71T3nyX8K w==;
X-CSE-ConnectionGUID: L7jmkZ3wTjOK98L51lsmKg==
X-CSE-MsgGUID: nSC83DBhRjOAxf6mmBl20Q==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31480017"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 09:45:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:17685]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.1:2525] with
 esmtp (Farcaster)
 id 834f8627-24f8-4e4c-8cbb-7ec6da44d8c1; Sun, 18 Oct 2026 09:45:52 +0000 (UTC)
X-Farcaster-Flow-ID: 834f8627-24f8-4e4c-8cbb-7ec6da44d8c1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 09:45:52 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 09:45:51 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 00/13] ENA release 2.15.0
Date: Sun, 18 Oct 2026 12:45:41 +0300
Message-ID: <cover.1792312029.git.shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261018063606.973-1-shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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

v3:
- Fixed a minor typo in a comment
- Rebased on next-net-for-main to fix the CI apply failure.
- Placed the ENA release-notes entry alphabetically before Broadcom bnxt.

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


base-commit: 3b99fca0dcd388585b24947e2a851001b159757b
-- 
2.17.1

