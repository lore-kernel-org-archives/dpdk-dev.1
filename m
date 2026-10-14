Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D33CC6B1F
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 02:07:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6522402DA;
	Wed, 14 Oct 2026 04:07:57 +0200 (CEST)
Received: from esa.hc5801-97.iphmx.com (esa.hc5801-97.iphmx.com
 [139.138.58.96]) by mails.dpdk.org (Postfix) with ESMTP id BD79640279
 for <dev@dpdk.org>; Wed, 14 Oct 2026 04:07:56 +0200 (CEST)
X-CSE-ConnectionGUID: VeNLmMsUSe2UsRbmICBsug==
X-CSE-MsgGUID: fyUNbuhZTBWZxwdK4bzdGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO se3ccprlyapp01.olympus.f5net.com)
 ([104.219.104.72])
 by esa1.hc5801-97.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 19:08:01 -0700
Received: from K6FNKPXYVK.olympus.f5net.com ([172.18.4.35]) by
 se3ccprlyapp01.olympus.f5net.com over TLS secured channel with Microsoft
 SMTPSVC(10.0.17763.1697); Tue, 13 Oct 2026 19:07:55 -0700
From: Shrey Khandelwal <s.khandelwal@f5.com>
To: weh@microsoft.com
Cc: longli@microsoft.com,
	stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH 0/2] net/netvsc: fix stale link status and speed
Date: Tue, 13 Oct 2026 19:07:42 -0700
Message-ID: <20261014020744.13605-1-s.khandelwal@f5.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Oct 2026 02:07:55.0336 (UTC)
 FILETIME=[D380D480:01DD5B80]
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

With LSC enabled, the link status and speed seen by the application
are not updated after the host reports a link change.

Patch 1 makes sure the cached link always has the current speed.
Patch 2 updates the cached link from the host indication.

Tested on Azure with testpmd, by injecting media disconnect, media
connect and link speed change indications. Without the patches, the
link read in the LSC callback stays up at the old speed. With them,
it goes down, up, then shows the new speed.

Shrey Khandelwal (2):
  net/netvsc: fix link speed not updated
  net/netvsc: fix link status not updated on host indication

 .mailmap                       |  1 +
 drivers/net/netvsc/hn_ethdev.c |  8 ++-
 drivers/net/netvsc/hn_rndis.c  | 90 ++++++++++++++++++++++++++++++++--
 drivers/net/netvsc/hn_rndis.h  |  3 +-
 drivers/net/netvsc/hn_rxtx.c   |  2 +-
 drivers/net/netvsc/hn_var.h    |  4 ++
 6 files changed, 97 insertions(+), 11 deletions(-)

-- 
2.55.0

