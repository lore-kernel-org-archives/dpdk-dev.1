Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C4C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 19:33:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F67A402E6;
	Fri, 18 Apr 2025 21:33:03 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5F54E402D3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 21:33:01 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 1C69720BCAD3; Fri, 18 Apr 2025 12:33:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C69720BCAD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1745004780;
 bh=zyej0HHV8fVZ/k5WpaRe2YG89Zij4Vpjh7KGVQj+RBo=;
 h=From:To:Cc:Subject:Date:From;
 b=aKllOk5qeUWCUmNxpslc41tbWJKnqVjI7AaT0xLiGiCJqisyeRY6OsT1SW2fcK1b9
 kZL1LMrIVXkjdQ6AALXBaP05G/jP1hzM7XRaRDTuq5F0G48sEs+3aCZ/svNy8eLiYo
 L4ooCqqb0i7RxejkFgxLLwlY16kbk2rmXi3x8VdA=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH 0/4] Fix incorrect page size and address caclulations on
 systems with 64k (or other) page sizes
Date: Fri, 18 Apr 2025 12:32:46 -0700
Message-Id: <1745004770-9795-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
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

From: Long Li <longli@microsoft.com>

The Hyper-V uses 4k page size regardless of system page size.

This patchset fixes issues while running on systems with page sizes other than 4k.

Long Li (4):
  bus/vmbus: Align ring buffer data region to system page boundary
  bus/vmbus: Define Hyper-V page size
  bus/vmbus: Use Hyper-V page size for mapping to UIO pages
  net/netvsc: Use Hyper-V page size for the driver

 drivers/bus/vmbus/bus_vmbus_driver.h |  4 ++++
 drivers/bus/vmbus/linux/vmbus_uio.c  |  2 +-
 drivers/bus/vmbus/rte_vmbus_reg.h    |  9 +++------
 drivers/bus/vmbus/vmbus_bufring.c    |  9 ++++++---
 drivers/bus/vmbus/vmbus_common_uio.c |  2 +-
 drivers/net/netvsc/hn_rndis.c        | 14 +++++++-------
 drivers/net/netvsc/hn_rxtx.c         | 16 ++++++++--------
 drivers/net/netvsc/hn_var.h          |  4 ----
 8 files changed, 30 insertions(+), 30 deletions(-)

-- 
2.34.1

