Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD90C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AB32402E5;
	Thu, 22 May 2025 15:06:45 +0200 (CEST)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
 by mails.dpdk.org (Postfix) with ESMTP id BAB37402E0
 for <dev@dpdk.org>; Thu, 22 May 2025 15:06:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747919203; x=1779455203;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=FAfC2tOLkKGuY9v9rH5PShUl0YGZRaW2F6Rl1jpowvk=;
 b=X9ObKnvoMT9hXGOEt4Jas8W9MmoCONHo7rUsWYogCMHYS6whVZdaYQs6
 HoyTTYQK/3UkzfWDwQ3ms3yGLBNJIgAqXNbYPvwyvyaPEAAMf64tt3MMF
 xaezBgsXmHd7jT0l18aJ9OAaBfGw6pnJfOF9Hbt7MZbEdFrQjurtl/AG9
 dbMq6c62u2r0duUB1sjUJ5OMRlRC4FTM4JVtWO8dK0D4riohJbzSZmfbm
 UC6Hsd85WOVk7q/eQjNE30RBbZ8TnJPhCxgzrqvb7oLtrUkJnlxCFqiA5
 XV90z7ZUQovCEBur0MPWMn7hY5CbHo/hH5O3QvOHRGJT/FJGHE1enMisy A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="495156843"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-2101.iad2.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:06:41 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:31004]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.44:2525]
 with esmtp (Farcaster)
 id 4437e442-b7c1-47fb-b903-5678d16b2dfc; Thu, 22 May 2025 13:06:39 +0000 (UTC)
X-Farcaster-Flow-ID: 4437e442-b7c1-47fb-b903-5678d16b2dfc
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:06:39 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:06:37 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 0/7] net/ena: release 2.13.0
Date: Thu, 22 May 2025 16:06:15 +0300
Message-ID: <20250522130622.3192-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
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

