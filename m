Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A41C44536
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 12:24:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 925D34042F;
	Thu, 22 Jan 2026 13:24:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id F1819402EE;
 Thu, 22 Jan 2026 13:24:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769084661; x=1800620661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UONlzysmahNyfi9sE3ZQPiRVUceqGqHIysuejVsDkZU=;
 b=IFAzFjFYGvolCXV5tUoQ/LdnKYMFZ3rckuVptInvl6egKepw+mx/5CY9
 1uzqSL/5XRxXtLBiaYw4EA9nKvqZIlKY4RgT3BdKgrUzRWFmSRxGExpw0
 ANwBSY1x5pdsWfmgulI63ZL1uO50bns239WNfSItKwaTRUdBoVCRGqAmK
 By2Mi1fTfhLK7O4UK3haKgMWHoSKjJIsEZoGb/k0ngZKWUnyy3+bCzXM1
 Kf572Vv2LNL90iyDgoAKXk2qCq4YjySl7USr8H14AAc16nNyMqav+IXeK
 iuLPXTLxCBYVIyLEJIIYajkDxbh0UZHccZm/kmHZ3/fQUi+OF/v6LaCnN A==;
X-CSE-ConnectionGUID: PkqHYntzSUeZbdK0F7ol2Q==
X-CSE-MsgGUID: uDgAA7K2Soa94mIbARVhQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81436256"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="81436256"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 04:24:18 -0800
X-CSE-ConnectionGUID: 4Cku1DhESQeo9AH8XzwuZQ==
X-CSE-MsgGUID: lavVJjo7RHyJl6b7wTlwEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="205971744"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 22 Jan 2026 04:24:18 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 2/3] test: fix missing dependency on null networking driver
Date: Thu, 22 Jan 2026 12:23:52 +0000
Message-ID: <20260122122354.1820368-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122122354.1820368-1-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
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

The pcapng and vdev autotests depend upon the null networking driver in
order to run, so record that dependency in the meson file, so they are
skipped if it's not present.

Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index f4d04a6e42..0195a31c95 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -135,7 +135,7 @@ source_file_deps = {
     'test_mp_secondary.c': ['hash'],
     'test_net_ether.c': ['net'],
     'test_net_ip6.c': ['net'],
-    'test_pcapng.c': ['ethdev', 'net', 'pcapng', 'bus_vdev'],
+    'test_pcapng.c': ['ethdev', 'net', 'pcapng', 'bus_vdev', 'net_null'],
     'test_pdcp.c': ['eventdev', 'pdcp', 'net', 'timer', 'security'],
     'test_pdump.c': ['pdump'] + sample_packet_forward_deps,
     'test_per_lcore.c': [],
@@ -209,7 +209,7 @@ source_file_deps = {
     'test_trace.c': [],
     'test_trace_perf.c': [],
     'test_trace_register.c': [],
-    'test_vdev.c': ['kvargs', 'bus_vdev'],
+    'test_vdev.c': ['kvargs', 'bus_vdev', 'net_null'],
     'test_version.c': [],
 }
 
-- 
2.51.0

