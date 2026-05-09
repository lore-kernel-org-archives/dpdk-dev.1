Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5130CCD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 06:01:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D821402AB;
	Sat,  9 May 2026 08:01:37 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 54F664026D
 for <dev@dpdk.org>; Sat,  9 May 2026 08:01:36 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [131.107.1.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id F0B1720B7166;
 Fri,  8 May 2026 23:01:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0B1720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778306491;
 bh=xo9FF/f+fg9D6Ke/D1Y/VNoEaECa+UysXPPN7VG/CNM=;
 h=From:To:Cc:Subject:Date:From;
 b=JPkxx0XYS5LDbZo5bKob88BFICu8ZtmltwkiAlvA2iq7uIqPWcHptWzIZq8znN+mg
 iOZsjwCBmzVbLZYTA2uKQPf+y9QMTI4OMoAzbC0f4KxFbTWjjYcm7/E8F4St5zvvPr
 hiy8oaAVR3LNPIo+jEXchvRQE2/RsHXn/ZNnOmjU=
From: Wei Hu <weh@linux.microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH v2 0/1] net/mana: add device reset support
Date: Fri,  8 May 2026 23:01:12 -0700
Message-Id: <20260509060113.61686-1-weh@linux.microsoft.com>
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

From: Wei Hu <weh@microsoft.com>

Add support for handling hardware service reset events in the
MANA driver. When the MANA kernel driver receives a hardware
service event, it initiates a device reset and notifies userspace
via IBV_EVENT_DEVICE_FATAL. The MANA PMD handles this by
performing an automatic teardown and recovery sequence.

The driver uses ethdev recovery events (ERR_RECOVERING,
RECOVERY_SUCCESS, RECOVERY_FAILED) to notify upper layers of
the reset lifecycle, and a PCI device removal event callback
to distinguish hot-remove from service reset.

Changes since v1:
- Removed net/netvsc patch from this series (will be submitted
  separately)
- Simplified reset exit: mana_reset_exit now calls
  mana_reset_exit_delay directly instead of spawning a separate
  thread, since it already runs on mana_reset_thread
- Added __rte_no_thread_safety_analysis annotations to fix clang
  -Wthread-safety build errors
- Switched from rte_thread_create_control to
  rte_thread_create_internal_control per DPDK preference
- Fixed declaration-after-statement style issues
- Fixed stale comments and removed unnecessary blank lines
- Added comments explaining intentionally ignored return values

Wei Hu (1):
  net/mana: add device reset support

 drivers/net/mana/mana.c      | 928 +++++++++++++++++++++++++++++++----
 drivers/net/mana/mana.h      |  33 +-
 drivers/net/mana/meson.build |   2 +-
 drivers/net/mana/mp.c        |  89 +++-
 drivers/net/mana/mr.c        |   6 +-
 drivers/net/mana/rx.c        |  24 +-
 drivers/net/mana/tx.c        |  40 +-
 7 files changed, 1016 insertions(+), 106 deletions(-)

-- 
2.34.1

