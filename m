Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB0C87FCA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 00:09:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75D4B40668;
	Wed, 30 Jul 2025 02:09:48 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 01C8F4025E
 for <dev@dpdk.org>; Wed, 30 Jul 2025 02:09:46 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 3084C211766F; Tue, 29 Jul 2025 17:09:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3084C211766F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1753834186;
 bh=qzuT2vwXwbFmBhri/z9FwlC963AqC+/rYiQHwIwaCrU=;
 h=From:To:Cc:Subject:Date:Reply-To:From;
 b=PEFyLirtfPk3+QFLJW5jtFD2gQKpxZ6Sn3fEFnk/VE3kfTgyL/nU9WQp97fd4fk7o
 w3HW6LySvXPq9RCRi7mBJ0TJAQojk8ako+T4KpPrEKTvT4uXtigfZWuyGUZwSixwKX
 GOhm2P9QqJ7yKlg7K5DLdusC86mKw+6dznxSQc9Y=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v7 0/4] Support VMBUS channels without monitoring enabled
Date: Tue, 29 Jul 2025 17:09:39 -0700
Message-Id: <1753834183-22244-1-git-send-email-longli@linuxonhyperv.com>
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
Reply-To: longli@microsoft.com
Errors-To: dev-bounces@dpdk.org

From: Long Li <longli@microsoft.com>

Hyperv may expose VMBUS channels without monitoring enabled. In this case,
it programs almost all the data traffic to VF.

This patchset enabled vmbus/netvsc to use channels without monitoring
enabled.

This needs to change the APIs exposed by drivers/bus/vmbus. Because those
APIs are used only by NetVSC PMD and not feasible for use by a DPDK
application, all VMBUS APIs are set to deprecate in upcoming 25.11 release.

The notice for deprecation is accepted in the following patch:
https://patchwork.dpdk.org/project/dpdk/patch/1742242184-19600-1-git-send-email-longli@linuxonhyperv.com/

Change log:
v3: Add in the comment on the VMBUS API deprecation notice
v7: Dropped the first two patches in the seires as they have already been applied to net-next

Long Li (4):
  bus/vmbus: store UIO fd for secondary process
  bus/vmbus: support channels without monitoring enabled
  bus/vmbus: add rte_vmbus_device to all functions accessing vmbus
  bus/vmbus: set event for channel without monitoring support

 drivers/bus/vmbus/linux/vmbus_bus.c  |  9 +++--
 drivers/bus/vmbus/linux/vmbus_uio.c  |  6 ++--
 drivers/bus/vmbus/private.h          |  2 +-
 drivers/bus/vmbus/rte_bus_vmbus.h    | 16 ++++++---
 drivers/bus/vmbus/vmbus_channel.c    | 53 ++++++++++++++++++++--------
 drivers/bus/vmbus/vmbus_common_uio.c |  9 +++--
 drivers/net/netvsc/hn_nvs.c          | 18 +++++-----
 drivers/net/netvsc/hn_nvs.h          | 15 ++++----
 drivers/net/netvsc/hn_rndis.c        | 11 +++---
 drivers/net/netvsc/hn_rxtx.c         | 16 ++++-----
 10 files changed, 97 insertions(+), 58 deletions(-)

-- 
2.25.1

