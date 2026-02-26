Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AFCFD4616
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 04:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A77240288;
	Thu, 26 Feb 2026 05:24:27 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8618F400D6;
 Thu, 26 Feb 2026 05:24:25 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 023E820B6F02; Wed, 25 Feb 2026 20:24:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 023E820B6F02
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, longli@microsoft.com, weh@microsoft.com,
 stable@dpdk.org
Subject: [PATCH v2 0/2] net/netvsc: runtime queue reconfiguration and fixes
Date: Wed, 25 Feb 2026 20:24:12 -0800
Message-ID: <20260226042414.965994-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
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

This series adds support for runtime queue count reconfiguration in the
netvsc PMD, along with a prerequisite bug fix.

Patch 1 fixes a pre-existing subchannel resource leak in
eth_hn_dev_uninit() where subchannels are never closed before the
primary channel.

Patch 2 adds runtime queue count reconfiguration via port
stop/configure/start, with full NVS/RNDIS session teardown and reinit
when the queue count changes.

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

Long Li (2):
  net/netvsc: fix subchannel leak on device removal
  net/netvsc: support runtime queue count reconfiguration

 drivers/net/netvsc/hn_ethdev.c | 181 +++++++++++++++++++++++++++++++--
 drivers/net/netvsc/hn_vf.c     |  16 +--
 2 files changed, 181 insertions(+), 16 deletions(-)

-- 
2.43.0

