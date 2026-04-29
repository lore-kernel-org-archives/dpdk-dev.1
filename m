Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C85FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 08:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B43A74027A;
	Wed, 29 Apr 2026 10:51:01 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EE51240272;
 Wed, 29 Apr 2026 10:51:00 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [131.107.1.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id 70A4220B716C;
 Wed, 29 Apr 2026 01:51:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70A4220B716C
From: Wei Hu <weh@microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	stable@dpdk.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH 0/2] net/mana: add device reset support for service events
Date: Wed, 29 Apr 2026 01:49:53 -0700
Message-Id: <20260429084955.39164-1-weh@microsoft.com>
X-Mailer: git-send-email 2.34.1
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

This series adds support for handling hardware service reset events
in the MANA and netvsc drivers.

When the MANA kernel driver receives a hardware service event, it
initiates a device reset and notifies userspace via
IBV_EVENT_DEVICE_FATAL. The MANA PMD handles this by performing an
automatic teardown and recovery sequence, using ethdev recovery
events (ERR_RECOVERING, RECOVERY_SUCCESS, RECOVERY_FAILED) to
notify upper layers.

Patch 1 implements the reset logic in the MANA driver, including
RCU-based data path quiescence, multi-process doorbell remap via
IPC, and a control thread for the recovery sequence.

Patch 2 adds recovery event handlers in the netvsc driver so it
can switch the data path to synthetic during reset and back to VF
after successful recovery.

Long Li (1):
  net/netvsc: handle VF recovery events for service reset

Wei Hu (1):
  net/mana: add device reset support

 drivers/net/mana/mana.c      | 924 ++++++++++++++++++++++++++++++++---
 drivers/net/mana/mana.h      |  33 +-
 drivers/net/mana/meson.build |   2 +-
 drivers/net/mana/mp.c        |  89 +++-
 drivers/net/mana/mr.c        |   6 +-
 drivers/net/mana/rx.c        |  24 +-
 drivers/net/mana/tx.c        |  40 +-
 drivers/net/netvsc/hn_vf.c   | 106 ++++
 8 files changed, 1121 insertions(+), 103 deletions(-)

-- 
2.34.1

