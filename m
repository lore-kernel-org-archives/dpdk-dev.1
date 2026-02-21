Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008E5E98DFB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 07:58:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64B1B402EE;
	Mon, 23 Feb 2026 08:57:54 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 26D3240150;
 Sat, 21 Feb 2026 03:44:45 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 5D47620B6F02; Fri, 20 Feb 2026 18:44:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D47620B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771641884;
 bh=T+UC8DbIQAeeSMFl24MCHIErMzqVAYI3watjSW8b08U=;
 h=From:To:Cc:Subject:Date:From;
 b=CwBwOXawCZoqczyKN+UKXZDzVbcDYNQL4P78gV/WqKeF83xWguH1YWqxHknE+cMQi
 xWeR2RP6LpvQc4URQL79SVItdN39+YQp/Tq/F0Cq3wFyhhmTXeBvNXrV+Fn45tSXay
 fFg/HTCRNVaqbcRFXNFEv712a2UA7RZZgQRx6g8s=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v2 0/8] fix multi-process VF hotplug
Date: Fri, 20 Feb 2026 18:44:40 -0800
Message-ID: <20260221024440.659006-1-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:57:51 +0100
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

v2:
- Patch 2: rename __hn_vf_add/__hn_vf_remove to
  hn_vf_add_unlocked/hn_vf_remove_unlocked to avoid C-reserved
  double-underscore prefix (C99 7.1.3)
- Patch 2: add hn_vf_detach() cleanup path when VF configure/start
  fails after hn_vf_attach() succeeds, preventing half-attached
  VF state
- Patch 2: unconditionally clear vf_vsc_switched on VF remove
  regardless of hn_nvs_set_datapath() result, since VF is being
  removed anyway
- Patch 3: add rte_eth_dev_is_valid_port() check before accessing
  rte_eth_devices[] in secondary VF removal handler
- Patch 3: rename netvsc_mp_req_VF to netvsc_mp_req_vf per DPDK
  lowercase naming convention
- Patch 3: use rte_memory_order_acquire/release instead of relaxed
  for secondary_cnt to ensure visibility on ARM
- Patch 3: initialize ret = 0 in netvsc_init_once()
- Patch 4: use local 'err' variable for ibv_dealloc_pd() return
  value to avoid shadowing outer 'ret'

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
 drivers/net/netvsc/hn_ethdev.c      | 293 +++++++++++++++++++++++++++-
 drivers/net/netvsc/hn_nvs.h         |   5 +
 drivers/net/netvsc/hn_rxtx.c        |  40 ++--
 drivers/net/netvsc/hn_var.h         |   1 +
 drivers/net/netvsc/hn_vf.c          | 144 ++++++++------
 9 files changed, 423 insertions(+), 88 deletions(-)

-- 
2.43.0

