Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92302EB365B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 02:54:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01E5340B9B;
	Tue,  3 Mar 2026 03:54:13 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 64B9D40289;
 Tue,  3 Mar 2026 03:54:11 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id AFDD420B6F02; Mon,  2 Mar 2026 18:54:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFDD420B6F02
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, longli@microsoft.com, weh@microsoft.com,
 stable@dpdk.org
Subject: [PATCH v3 0/6] net/netvsc: bug fixes and runtime queue reconfiguration
Date: Mon,  2 Mar 2026 18:53:55 -0800
Message-ID: <20260303025403.269182-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
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

This series fixes several resource management bugs in the netvsc PMD and
adds support for runtime queue count reconfiguration.

Patches 1-5 are bug fixes:
  1. Subchannel leak on device removal — subchannels allocated during
     configure are never closed in uninit.
  2. Double-free of primary Rx queue — hn_dev_free_queues() already
     frees hv->primary, then uninit frees it again.
  3. Init error path leaks — hv->primary and hv->channels[0] not freed
     on failure after allocation.
  4. Event callback leak — device event callback not unregistered when
     rxfilter or vf_start fails in hn_dev_start().
  5. MTU change path leaks — missing chimney bitmap teardown/rebuild,
     rxbuf_info leak, and VMBus channel close before free.

Patch 6 adds runtime queue count reconfiguration via port
stop/configure/start, with full NVS/RNDIS session teardown and reinit
when the queue count changes.

v3:
- Split into 6 patches: 5 bug fixes (patches 1-5) + 1 feature (patch 6)
- New patch 2: fix double-free of primary Rx queue on uninit
- New patch 3: fix resource leak in init error path
- New patch 4: fix event callback leak on rxfilter/vf_start failure
- New patch 5: fix resource leaks in MTU change path (chimney bitmap,
  rxbuf_info leak, missing VMBus chan close before free)
- Patch 6 (reconfig): fix subchan_cleanup to call hn_rndis_conf_offload
  so device retains offload config on partial failure
- Patch 6 (reconfig): fix recovery path to set hv->primary->chan after
  re-opening channel, preventing use-after-free of stale pointer
- Patch 6 (reconfig): add hn_chim_init in recovery path to rebuild
  chimney bitmap after successful recovery
- Fix Fixes tag on patch 5 to point to correct MTU support commit

v2:
- Split subchannel leak fix into separate patch with Fixes tag (patch 1)
- Fix reinit_failed recovery: re-map device before chan_open when device
  is unmapped to prevent undefined behavior on unmapped ring buffers
- Move hn_rndis_conf_offload() to after reinit block so offload config
  targets the final RNDIS session instead of being lost on teardown
- Use write lock in hn_vf_tx/rx_queue_release() to prevent race with
  concurrent fast-path readers holding read lock
- Reset RSS indirection table to queue 0 in subchan_cleanup error path
- Fix multi-line comment style to follow DPDK convention

Long Li (6):
  net/netvsc: fix subchannel leak on device removal
  net/netvsc: fix double-free of primary Rx queue on uninit
  net/netvsc: fix resource leak in init error path
  net/netvsc: fix event callback leak on rxfilter failure
  net/netvsc: fix resource leaks in MTU change path
  net/netvsc: support runtime queue count reconfiguration

 drivers/net/netvsc/hn_ethdev.c | 243 ++++++++++++++++++++++++++++++---
 drivers/net/netvsc/hn_vf.c     |  16 ++-
 2 files changed, 234 insertions(+), 25 deletions(-)

-- 
2.43.0

