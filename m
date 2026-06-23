Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE9CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:19:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66193402B5;
	Tue, 23 Jun 2026 16:19:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2130640150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 16:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782224379; x=1813760379;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dbFVL0n3/qpPrrnusytrdKN76BfB7Uxkj3tm8VweGgQ=;
 b=FEl7lkHJ+CZmIttwTIajOICwY5osUndWTzUOSbuFVjCDM1c8vZCqlroK
 FxCHZoeUABARUiuQ2rNF0WSRaeOA9w8wbq1evxnpDOhUpt0BjV2z6LHRu
 Aznl7F+bSECeL88SIjoqW8Bce54zuw7y3mKkOG45zOo4v97lo/oFli5/E
 L+SUrhIoiZZTFrT74bTNc34PdZeRSFhtVx9JYSm7mQs2ZqsS2+pGaTyi2
 5SgKbsA4ExU72cvRT7zSx8GHSvYPDu9Wl8rF7BmJVMalYa9zI0mvzWGcZ
 s2fDM+7NQCQlvCU7EVkeI29hhx6SPXKYehPFRJRjdDc0A0fbrjuw8iR+3 g==;
X-CSE-ConnectionGUID: zo7EAel/TdSz54JNZWBazA==
X-CSE-MsgGUID: NVtUYNYMTd6KkD7eFmF+0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82970448"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82970448"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:19:38 -0700
X-CSE-ConnectionGUID: uz03wL/xTtWyeFri1lQiMg==
X-CSE-MsgGUID: E2spd1tbRUCkkE795n1sUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="253888606"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 07:19:38 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 0/3] lib: remove use of strncpy
Date: Tue, 23 Jun 2026 15:19:26 +0100
Message-ID: <20260623141930.704771-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Taking a lead from the kernel, which has just finished a multi-year
effort to remove use of strncpy[1], rework DPDK to remove use of the
same function. This series removes all remaining uses of strncpy
in lib directory.

[1] https://www.phoronix.com/news/Linux-7.2-Drops-strncpy

Bruce Richardson (3):
  ethdev: remove use of strncpy
  eventdev: improve bounds checks for names in adapter create
  vhost: remove use of strncpy

 lib/ethdev/ethdev_driver.c              |  7 ++++++-
 lib/eventdev/rte_event_eth_tx_adapter.c |  4 ++--
 lib/vhost/socket.c                      |  4 +---
 lib/vhost/vduse.c                       |  2 +-
 lib/vhost/vhost.c                       | 12 +++---------
 lib/vhost/vhost.h                       |  2 +-
 6 files changed, 14 insertions(+), 17 deletions(-)

--
2.53.0

