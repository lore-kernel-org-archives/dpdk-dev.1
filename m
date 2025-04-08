Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A303FC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 21:54:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D84E402EE;
	Tue,  8 Apr 2025 23:54:01 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id ADA7140265
 for <dev@dpdk.org>; Tue,  8 Apr 2025 23:53:59 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id B6DE42113E96; Tue,  8 Apr 2025 14:53:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6DE42113E96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1744149238;
 bh=G1YtFP2p/DPedtTU3qDq2D7TtVZ4D4TlENF5b/FQPuk=;
 h=From:To:Cc:Subject:Date:From;
 b=JncfAUuq1iaGZbKllITn5BPgsctZXu7d+LL7yTy9BQ8gx1QK5Qj9uH01BivMY4cEj
 EjWqHwCK789lRLwz+XzJugd/e5umfp0dzMEOALLu3fAMKm/uuZtqifj6xDCzij4QgJ
 TWvwfrwcDJl9YGKaNLZ1RhkWsuAQ6CM4tzo8USlU=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [patch v5 0/6] Support VMBUS channels without monitoring enabled
Date: Tue,  8 Apr 2025 14:53:50 -0700
Message-Id: <1744149236-30264-1-git-send-email-longli@linuxonhyperv.com>
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

Long Li (6):
  net/netvsc: introduce private data for storing vmbus device for
    secondary process
  net/netvsc: introduce get_vmbus_device to get the vmbus device
  bus/vmbus: store UIO fd for secondary process
  bus/vmbus: support channels without monitoring enabled
  bus/vmbus: add rte_vmbus_device to all functions accessing vmbus
  bus/vmbus: set event for channel without monitoring support

 drivers/bus/vmbus/linux/vmbus_bus.c  |  9 +++--
 drivers/bus/vmbus/linux/vmbus_uio.c  |  6 +--
 drivers/bus/vmbus/private.h          |  2 +-
 drivers/bus/vmbus/rte_bus_vmbus.h    | 16 +++++---
 drivers/bus/vmbus/vmbus_channel.c    | 57 ++++++++++++++++++++--------
 drivers/bus/vmbus/vmbus_common_uio.c |  9 +++--
 drivers/net/netvsc/hn_ethdev.c       | 44 ++++++++++++++++-----
 drivers/net/netvsc/hn_nvs.c          | 33 +++++++++++-----
 drivers/net/netvsc/hn_nvs.h          | 21 ++++++----
 drivers/net/netvsc/hn_rndis.c        | 11 +++---
 drivers/net/netvsc/hn_rxtx.c         | 16 ++++----
 11 files changed, 155 insertions(+), 69 deletions(-)

-- 
2.34.1

