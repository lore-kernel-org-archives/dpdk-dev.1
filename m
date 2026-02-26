Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B135EFC5910
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 172784021F;
	Thu, 26 Feb 2026 11:16:39 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D6CB8400D6;
 Thu, 26 Feb 2026 03:39:45 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 462B520B6F02; Wed, 25 Feb 2026 18:39:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 462B520B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1772073585;
 bh=sq7B4cVYrNlQfsDH+Whd7yxekJ9UuAYPnRZKL8lcdVs=;
 h=From:To:Cc:Subject:Date:From;
 b=A6eJK7hyeK4DsAR13JV/4QHKM+MTLqPZQHLKkhK7QN4bagRGAz8yKM/9MKG/2E4ab
 Mth17MljCOo6YjKuP2CMA2ymFYFCg4sSCqBIjz9PVit7aZVUiAwOhlhWmxKgB4BfoX
 xN3GsN+KYthxqa8GtCTiBNm3p3/qomATVLr0Gc+I=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v4 0/7] fix multi-process VF hotplug
Date: Wed, 25 Feb 2026 18:39:31 -0800
Message-ID: <20260226023940.961844-1-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 11:16:38 +0100
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

Fix several issues with VF hotplug and multi-process support in
netvsc, mana, mlx5, and mlx4 drivers:

- Fix race conditions between VSP notifications and DPDK device events
  during VF add/remove, with proper locking of VF-related fields
- Add multi-process communication infrastructure for coordinating VF
  removal across primary and secondary processes
- Fix Protection Domain resource leak on device close in mana
- Fix devargs memory leak during VF hotplug in netvsc
- Fix fast-path ops (rte_eth_fp_ops) setup in secondary processes for
  mana, mlx5, and mlx4, preventing segfaults on VF hot-add

v4:
- Patch 1: Check hn_vf_add() return value in netvsc_hotplug_retry
- Patch 1: Track fresh_attach to avoid tearing down original VF
  attachment when configure/start fails on an -EEXIST path
- Patch 2: Move counter decrement and netvsc_uninit_once() after device
  cleanup in eth_hn_remove() to prevent use-after-free of shared data
- Patch 2: Clear netvsc_shared_data on init failure paths to prevent
  dangling pointer

v3:
- Fix review comments from v2

v2:
- Initial rework of VF add/remove locking

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
 drivers/net/netvsc/hn_ethdev.c      | 300 +++++++++++++++++++++++++++-
 drivers/net/netvsc/hn_nvs.h         |   6 +
 drivers/net/netvsc/hn_rxtx.c        |  40 ++--
 drivers/net/netvsc/hn_var.h         |   1 +
 drivers/net/netvsc/hn_vf.c          | 148 ++++++++------
 9 files changed, 431 insertions(+), 92 deletions(-)

-- 
2.43.0

