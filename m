Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F548CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 19:28:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57EC940609;
	Fri, 15 May 2026 21:28:53 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 87C3A40269
 for <dev@dpdk.org>; Fri, 15 May 2026 21:28:51 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id E3AC120B7166; Fri, 15 May 2026 12:28:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3AC120B7166
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v3 0/7] net/netvsc: fix VF hotplug and service reset handling
Date: Fri, 15 May 2026 12:28:34 -0700
Message-ID: <20260515192843.552762-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260506020529.281654-1-longli@microsoft.com>
References: <20260506020529.281654-1-longli@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series fixes several issues in the netvsc PMD's VF hot-plug retry
logic and adds support for MANA service reset (suspend/resume) recovery.

Patches 1-5 fix the VF hot-add retry path to handle Azure-specific
timing issues: slow MANA driver probe (>100s), udev interface renames,
asynchronous mana_ib registration, and multi-NIC staggered VF
appearance.

Patch 6 fixes per-queue stats forwarding from VF to netvsc.

Patch 7 adds recovery event handling for MANA service resets, where
the kernel suspends/resumes the VF without PCI remove.

v3:
- Patch 1: wrapped rte_eal_alarm_set lines to fix checkpatch
  line-length warning
- Patch 4: changed "retry loop exiting" log from NOTICE to DEBUG
  to avoid noise on every successful VF re-attach
- Patch 6: removed dead -ENOTSUP fallback to rte_eth_stats_get,
  replaced with direct -ENOTSUP return; documented caller contract
  for zeroed buffers
- Patch 7: deferred all recovery callbacks via rte_eal_alarm_set
  consistent with INTR_RMV pattern; dropped unlocked vf_attached
  guard in recovery_failed; cancel new alarms in hn_vf_close

v2:
- Patch 1: added comment explaining why indefinite retry is safe
- Patch 2: changed SIOCGIFHWADDR retry log to DEBUG
- Patch 3: restored ERR log for non-ENODEV/EEXIST failures
- Patch 4: changed per-iteration logs from NOTICE to DEBUG;
  used RTE_ETHER_ADDR_PRT_FMT macros
- Patch 5: fixed commit message (limit 120 not 30); changed
  mac_retry log to DEBUG; explicit NULL comparisons
- Patch 6: added comment for direct dev_ops call; added -ENOTSUP
  fallback
- Patch 7: added dev_started check in recovery_success; added
  vf_attached guard in recovery_failed

Long Li (7):
  net/netvsc: retry VF hotplug indefinitely until PCI device disappears
  net/netvsc: retry on SIOCGIFHWADDR failure during VF hotplug
  net/netvsc: retry full probe when IB device not ready during hotplug
  net/netvsc: add debug logging for VF hotplug retry
  net/netvsc: retry when no matching MAC found in net directory
  net/netvsc: forward per-queue stats from VF device
  net/netvsc: handle VF recovery events for service reset

 drivers/net/netvsc/hn_ethdev.c | 142 +++++++++++++++++++++----
 drivers/net/netvsc/hn_var.h    |   1 +
 drivers/net/netvsc/hn_vf.c     | 182 ++++++++++++++++++++++++++++++++-
 3 files changed, 302 insertions(+), 23 deletions(-)

-- 
2.43.0

