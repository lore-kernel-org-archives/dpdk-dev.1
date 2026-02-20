Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504EFC5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 879AA40615;
	Fri, 20 Feb 2026 11:09:35 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7DF0B40276
 for <dev@dpdk.org>; Fri, 20 Feb 2026 02:09:13 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id A6ABC20B6F00; Thu, 19 Feb 2026 17:09:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6ABC20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771549752;
 bh=C1IIIxpHEAE2pNcea0XaKVEApCdmNfdtymfPCByNXx0=;
 h=From:To:Cc:Subject:Date:From;
 b=ewDKt70LXVPAPrnGFe6wp1zz0V6R1EXFIjMdwXMVl+CgvIa+YknmXzgrkkxpv/eB1
 sA7SXw+3CchneX7XF1or1os7iUqTGUSaHwy7sw4QZBYBOAHTIJmdZM6FW2RNxER7Xt
 9iUUU37X+ONIX/PC8okeOJrk5eJNThaU2DhYQzuM=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 0/8] fix multi-process VF hotplug
Date: Thu, 19 Feb 2026 17:08:51 -0800
Message-ID: <20260220010859.595260-1-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 11:09:31 +0100
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

This series fixes multi-process support for DPDK drivers used on
Azure VMs with Accelerated Networking (AN). When AN is toggled, the
VF device is hot-removed and hot-added, which can crash secondary
processes due to stale fast-path pointers and race conditions.

Patches 1-3 fix the netvsc PMD:
- Prevent secondary from calling unsupported promiscuous ops
- Fix rwlock misuse and race conditions on VF add/remove events
- Add multi-process VF device removal support via IPC

Patches 4-5 fix resource leaks:
- MANA PD resource leak on device close
- netvsc devargs memory leak on hotplug

Patches 6-8 fix a common bug across MANA, MLX5, and MLX4 drivers
where the secondary process START_RXTX/STOP_RXTX IPC handlers
update dev->rx_pkt_burst/tx_pkt_burst but do not update the
process-local rte_eth_fp_ops[] array. Since rte_eth_rx_burst()
uses rte_eth_fp_ops (not dev->rx_pkt_burst), the secondary retains
stale queue data pointers after VF hot-add, causing a segfault.

Long Li (8):
  net/netvsc: secondary ignore promiscuous enable/disable
  net/netvsc: fix race conditions on VF add/remove events
  net/netvsc: add multi-process VF device removal support
  net/mana: fix PD resource leak on device close
  net/netvsc: fix devargs memory leak on hotplug
  net/mana: fix fast-path ops setup in secondary process
  net/mlx5: fix fast-path ops setup in secondary process
  net/mlx4: fix fast-path ops setup in secondary process

 drivers/net/mana/mana.c             |  14 ++
 drivers/net/mana/mp.c               |   6 +
 drivers/net/mlx4/mlx4_mp.c          |   4 +
 drivers/net/mlx5/linux/mlx5_mp_os.c |   4 +
 drivers/net/netvsc/hn_ethdev.c      | 288 +++++++++++++++++++++++++++-
 drivers/net/netvsc/hn_nvs.h         |   5 +
 drivers/net/netvsc/hn_rxtx.c        |  40 ++--
 drivers/net/netvsc/hn_var.h         |   1 +
 drivers/net/netvsc/hn_vf.c          | 122 ++++++------
 9 files changed, 397 insertions(+), 87 deletions(-)

-- 
2.43.0

