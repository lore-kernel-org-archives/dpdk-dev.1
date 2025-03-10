Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150E1C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 21:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 418BA40268;
	Mon, 10 Mar 2025 22:43:04 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1F01F400D7
 for <dev@dpdk.org>; Mon, 10 Mar 2025 22:43:03 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 2065C2038F53; Mon, 10 Mar 2025 14:43:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2065C2038F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1741642982;
 bh=nsc4bjh/xZGHZBaANmWzlWXL+ZNsvcCZdwqXs7Zd2Eg=;
 h=From:To:Cc:Subject:Date:From;
 b=i/GZRjlGRtOXSy/n8kZYdge8e9l0s+35kThqlgBSfEhFqQc6Vm8CBTA8yGmaxzBwT
 TDt+kqCO+jGJh3IhEwQavKkx0wCqpNmyILaJalkxWwy6vDNziQUha8KiG1lAFxfuZ6
 xV+mOg3UVABv6p5x6OG8OHv4KQuIzNTwcBTDsooA=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [patch v2 0/6] Support VMBUS channels without monitoring enabled
Date: Mon, 10 Mar 2025 14:42:51 -0700
Message-Id: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
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

Long Li (6):
  net/netvsc: introduce private data for storing vmbus device for
    secondary process
  net/netvsc: introduce get_vmbus_device to get the vmbus device
  bus/vmbus: store UIO fd for secondary process
  bus/vmbus: support channels without monitoring enabled
  bus/vmbus: add rte_vmbus_device to all functions accessing vmbus
  bus/vmbus: set event for channel without monitoring support

 drivers/bus/vmbus/linux/vmbus_bus.c  |  9 +++--
 drivers/bus/vmbus/linux/vmbus_uio.c  |  6 ++--
 drivers/bus/vmbus/private.h          |  2 +-
 drivers/bus/vmbus/rte_bus_vmbus.h    | 16 ++++++---
 drivers/bus/vmbus/vmbus_channel.c    | 52 ++++++++++++++++++++--------
 drivers/bus/vmbus/vmbus_common_uio.c |  9 +++--
 drivers/net/netvsc/hn_ethdev.c       | 44 ++++++++++++++++++-----
 drivers/net/netvsc/hn_nvs.c          | 33 +++++++++++++-----
 drivers/net/netvsc/hn_nvs.h          | 21 +++++++----
 drivers/net/netvsc/hn_rndis.c        | 11 +++---
 drivers/net/netvsc/hn_rxtx.c         | 16 ++++-----
 11 files changed, 152 insertions(+), 67 deletions(-)

-- 
2.34.1

