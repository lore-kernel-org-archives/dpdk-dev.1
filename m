Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BCBE9A057
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 17:40:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A762B40654;
	Thu, 19 Feb 2026 18:40:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D8A0340616;
 Thu, 19 Feb 2026 18:40:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771522807; x=1803058807;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uzBnf20NLIhDHEVzRNli56oAbWZFMxgXnMJiUckbTqw=;
 b=PG7q2Y6f8daTewfJK3WpJhgwbaFW3fA6HqIaTl0Rg8LjuFb9UkuIILtf
 Cs+gudS4fWYnNhmctvTCLs9HIBS8gX7a8IOcRnq9IlwdPZdL6vggmo+TZ
 NfKz3x6o1tRXi4m4RylBtmNGLLZe9UdA4bCufASJZyUBkrjDziaipM0SO
 TLFsR5CGSDvTHYhVi7YInBvidPjzfQIOr+FIeVF6De/EORJ1+W/QlWuXz
 BBI/XZ1/vw5MlKaz55DtNhnn2xwEHg988Y6Qel7Qkx8gGRXgl88+cquQ8
 y/Qf6n8TgyT808ndRYyve9Cdl4q6a2OpRGXoeS8dMr/tAnth1JuINQNpd A==;
X-CSE-ConnectionGUID: 3dasMFjSRe6Lig7Zt6s1GQ==
X-CSE-MsgGUID: am4EqQe8QFiK1SyZjKZ4jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72518124"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="72518124"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 09:40:06 -0800
X-CSE-ConnectionGUID: OoWuNkNQSkGY3ASn+8G/dw==
X-CSE-MsgGUID: +RqtoQwRRi2mOPt46VaY+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="212803343"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2026 09:40:05 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2 3/4] test: fix missing dependency on null networking driver
Date: Thu, 19 Feb 2026 17:39:52 +0000
Message-ID: <20260219173953.2182757-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219173953.2182757-1-bruce.richardson@intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260219173953.2182757-1-bruce.richardson@intel.com>
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

A number of tests depend upon the null networking driver in order to
run, so record that dependency in the meson file, so they are skipped if
it's not present.

Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 4fd8670e05..31c966d97e 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -112,7 +112,7 @@ source_file_deps = {
         'net'] + packet_burst_generator_deps + virtual_pmd_deps,
     'test_link_bonding_mode4.c': ['ethdev', 'net_ring', 'net_bond',
         'net'] + packet_burst_generator_deps,
-    'test_link_bonding_rssconf.c': ['ethdev', 'bus_vdev', 'net_bond'],
+    'test_link_bonding_rssconf.c': ['ethdev', 'bus_vdev', 'net_bond', 'net_null'],
     'test_logs.c': [],
     'test_lpm.c': ['net', 'lpm'],
     'test_lpm6.c': ['lpm'],
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

