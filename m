Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C51CC44532
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:13:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77D9C4067C;
	Tue, 21 Jul 2026 17:13:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id E4A9240691
 for <dev@dpdk.org>; Tue, 21 Jul 2026 17:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784646813; x=1816182813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4I+Ox/vQ9msyPKIL20cn7UMQRiRuWFsr+/UFV/AdPJ0=;
 b=Zyis3wJkRJDjYwOh2meSs6cU/q588INzAJXYfIz/eKkI+Aud+f0u7Q5e
 4ctECvZ4WtB+Jbo3kxmbXIjLKs5kNDZFRHPBwvGcT/Dp1pIjo1wwtfC/b
 M8e4rK6IOlrA1LvOynavgj66yJmiV4CKVh9wLHMkSGcJYJYZUF5CXbnLu
 LD/He6JskS7EKcLv6Vb6wQ2icDmqXYTUn/KljruM9qKTf4r0/0YWEyDKR
 Ee9cmZgBCJJCeKKFg+UI0CBAzKXO32GJPQ6Jii7Q6qlQKWyox8M7SxrnH
 jGiaH2l8PA6bf86ppIlaltpWb16fsvryuhTCuD14S2P15pTwnuOdZhOjl Q==;
X-CSE-ConnectionGUID: wUFWb//dTX6Xt/hc3WMuMg==
X-CSE-MsgGUID: Dfzf19GJThKPi/p7ihsE5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85107720"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="85107720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 08:13:32 -0700
X-CSE-ConnectionGUID: 7BzS6R7oRkqUl8O3xsWczw==
X-CSE-MsgGUID: UjCIo+rkREWgbHK5OOJ9Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="281070952"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 21 Jul 2026 08:13:31 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 4/6] doc/rel_notes: fix driver ordering
Date: Tue, 21 Jul 2026 16:13:23 +0100
Message-ID: <20260721151325.2698283-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721151325.2698283-1-bruce.richardson@intel.com>
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
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

The drivers should be in alphabetical order by category in the release
notes, so move two drivers to give correct ordering.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_07.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 63693159fd..b3c23b73a1 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -163,10 +163,6 @@ New Features
   to support adding and removing memory regions without resetting
   the whole guest memory map.
 
-* **Added LinkData sxe2 ethernet driver.**
-
-  Added network driver for the LinkData network adapters.
-
 * **Updated Google gve driver.**
 
   Added hardware timestamping support on DQO queues.
@@ -182,6 +178,10 @@ New Features
   Added ``rl_burst_size`` devarg to configure the scheduler rate-limiter
   burst size, reducing Tx latency jitter for time-sensitive traffic.
 
+* **Added LinkData sxe2 ethernet driver.**
+
+  Added network driver for the LinkData network adapters.
+
 * **Updated Microsoft mana driver.**
 
   Added device reset support to the MANA PMD,
@@ -222,10 +222,6 @@ New Features
   * Added ``eof`` devarg to use link state to signal end of receive file input.
   * Added unit test suite.
 
-* **Updated Marvell cnxk crypto driver.**
-
-  Added support for ML-KEM and ML-DSA on CN20K platform.
-
 * **Updated Wangxun ngbe driver.**
 
   Implemented UDP Segmentation Offload (USO) in the transmit path.
@@ -256,6 +252,10 @@ New Features
 
   On ARM, both IPsec MB and OpenSSL are required for full functionality.
 
+* **Updated Marvell cnxk crypto driver.**
+
+  Added support for ML-KEM and ML-DSA on CN20K platform.
+
 * **Updated testpmd application.**
 
   Added support for setting VLAN priority and CFI/DEI bits
-- 
2.53.0

