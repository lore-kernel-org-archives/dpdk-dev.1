Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C72BFD375F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 13:58:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43617402E4;
	Wed, 25 Feb 2026 14:58:31 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id CC703400D6;
 Wed, 25 Feb 2026 03:02:50 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 11A5C20B6F02; Tue, 24 Feb 2026 18:02:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11A5C20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771984970;
 bh=vUnfncKH5eWrY7iS+RlxdSzqcaZhm09O8jSi1ggdPXg=;
 h=From:To:Cc:Subject:Date:From;
 b=HK0Ql4d2dkQtXGZOglZgUTxxTQifKOGI6HCfIdAHeage2tv2Go+FYtcqS5+sxLbT2
 KB60VnJKsdFaSmzgmrn4+hg4Mfu1EeQJFoB3hbz4PhpvSZQIYPCU6PBTGz/gP+8EAX
 HUTevwYDocg/DrkXsBDA/Il2McQAdl8igniOgumY=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v3 0/7] fix multi-process VF hotplug
Date: Tue, 24 Feb 2026 18:02:32 -0800
Message-ID: <20260225020246.890306-1-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:58:29 +0100
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

Patches 1-2 fix the netvsc PMD:
- Fix rwlock misuse and race conditions on VF add/remove events
- Add multi-process VF device removal support via IPC

Patches 3-4 fix resource leaks:
- MANA PD resource leak on device close
- netvsc devargs memory leak on hotplug

Patches 5-7 fix a common bug across MANA, MLX5, and MLX4 drivers
where the secondary process START_RXTX/STOP_RXTX IPC handlers
update dev->rx_pkt_burst/tx_pkt_burst but do not update the
process-local rte_eth_fp_ops[] array. Since rte_eth_rx_burst()
uses rte_eth_fp_ops (not dev->rx_pkt_burst), the secondary retains
stale queue data pointers after VF hot-add, causing a segfault.

Tested on Azure D8s_v3 (mlx5) with symmetric_mp primary+secondary.
AN disable/re-enable correctly hot-removes and re-attaches VF in
both processes without crash.

v3:
- Drop patch 1 from v2 (secondary ignore promiscuous enable/disable)
  as it is no longer needed with the VF race condition fixes
- Patch 2: use #define for MZ_NETVSC_SHARED_DATA instead of const
  char pointer
- Patch 2: simplify netvsc_secondary_handle_device_remove() to take
  vf_port directly instead of struct hn_data pointer
- Patch 2: return 0 (not error) when VF port is not present in
  secondary, as this is a normal condition during startup
- Patch 2: pass vf_port as parameter to netvsc_mp_req_vf() instead
  of reading from hv->vf_ctx internally
- Patch 2: protect netvsc_init_once() and secondary_cnt increment
  under same spinlock to prevent race between MP handler registration
  and secondary count visibility
- Patch 2: add secondary_cnt decrement in error and cleanup paths
- Patch 2: fix misleading comment about cross-process locking

v2:
- Patch 1: rename __hn_vf_add/__hn_vf_remove to
  hn_vf_add_unlocked/hn_vf_remove_unlocked to avoid C-reserved
  double-underscore prefix (C99 7.1.3)
- Patch 1: add hn_vf_detach() cleanup path when VF configure/start
  fails after hn_vf_attach() succeeds, preventing half-attached
  VF state
- Patch 1: unconditionally clear vf_vsc_switched on VF remove
  regardless of hn_nvs_set_datapath() result, since VF is being
  removed anyway
- Patch 2: add rte_eth_dev_is_valid_port() check before accessing
  rte_eth_devices[] in secondary VF removal handler
- Patch 2: rename netvsc_mp_req_VF to netvsc_mp_req_vf per DPDK
  lowercase naming convention
- Patch 2: use rte_memory_order_acquire/release instead of relaxed
  for secondary_cnt to ensure visibility on ARM
- Patch 2: initialize ret = 0 in netvsc_init_once()
- Patch 3: use local 'err' variable for ibv_dealloc_pd() return
  value to avoid shadowing outer 'ret'

Long Li (7):
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
 drivers/net/netvsc/hn_ethdev.c      | 287 +++++++++++++++++++++++++++-
 drivers/net/netvsc/hn_nvs.h         |   5 +
 drivers/net/netvsc/hn_rxtx.c        |  40 ++--
 drivers/net/netvsc/hn_var.h         |   1 +
 drivers/net/netvsc/hn_vf.c          | 144 ++++++++------
 9 files changed, 417 insertions(+), 88 deletions(-)

-- 
2.43.0
