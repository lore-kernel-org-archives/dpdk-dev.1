Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DDCC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:38:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E638D40613;
	Fri, 14 Aug 2026 17:38:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 79CEF402B8
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786721888; x=1818257888;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sUv4ubKgWXZtbrjvpLl7OCc6gZfawQuMHtbCH6z9B54=;
 b=An07B3nLcgXha+TYyFGTB2+q5V+9QCDkZB/vp0mZN5zGboU5JOCpsAEh
 yVghuAqMz7qEnwLxJGqxPKE4keQsIfqBFP2OJ5z7knfqvdYt7BIufrO5M
 QJVOQPWf4vszZmzL20bFWQ236iEUfT3O4Pg0HK2KLUfN1YaoQJZSZRPMe
 dg4IgXeYnOF3YAATXIwN/N9dSK36CqXnGTte0gnacs6LmvwXjuqe3badu
 BzpSyFsYh/DB/G1iZrg5W6mi2Ch4qylXEBI+p3oP1yNHC5ipLL6QYlQ1I
 N0hcWv6JArqrEYiAdVakkig6M0o7qYDtjBwbo4b751GuqNt+5i4DJgEtt Q==;
X-CSE-ConnectionGUID: ucTc5FV2RFyZ7pfMt9qUdQ==
X-CSE-MsgGUID: 0HQrvweOSsGfQ9crpB2vDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87430612"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87430612"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:38:08 -0700
X-CSE-ConnectionGUID: m84qJXmXQsWnwDITyeoXgA==
X-CSE-MsgGUID: v9Qe4LxoQZmrMoKu0WtmWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264297092"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 14 Aug 2026 08:38:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 4/8] net/iavf: move editable files out of base folder
Date: Fri, 14 Aug 2026 16:37:47 +0100
Message-ID: <20260814153755.940302-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814153755.940302-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
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

The osdep header and iavf_impl.c file contain the macros and other
definitions needed to allow the base code to compile as part of DPDK.
Although they are stored in the base code folder, but are an exception
in that they can be modified by regular DPDK patches, and not just as
part of a base code snapshot update.

Therefore, we can simplify the rules around base code by moving these
files into the main driver folder, leaving the base code C files all as
uneditable except via snapshot update.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/base/README                        | 8 --------
 drivers/net/intel/iavf/{base/iavf_impl.c => iavf_osdep.c} | 0
 drivers/net/intel/iavf/{base => }/iavf_osdep.h            | 2 ++
 drivers/net/intel/iavf/meson.build                        | 2 +-
 4 files changed, 3 insertions(+), 9 deletions(-)
 rename drivers/net/intel/iavf/{base/iavf_impl.c => iavf_osdep.c} (100%)
 rename drivers/net/intel/iavf/{base => }/iavf_osdep.h (98%)

diff --git a/drivers/net/intel/iavf/base/README b/drivers/net/intel/iavf/base/README
index 61bcf0ef0e..d6a1dfbc96 100644
--- a/drivers/net/intel/iavf/base/README
+++ b/drivers/net/intel/iavf/base/README
@@ -7,11 +7,3 @@ Intel® IAVF driver
 
 This directory contains a snapshot of the iavf shared, or base, driver code.
 The snapshot was generated on 2024.09.17.
-
-Updating the driver
-===================
-
-NOTE: The source code in this directory should not be modified apart from the following files:
-
-    iavf_osdep.h
-    iavf_impl.c
diff --git a/drivers/net/intel/iavf/base/iavf_impl.c b/drivers/net/intel/iavf/iavf_osdep.c
similarity index 100%
rename from drivers/net/intel/iavf/base/iavf_impl.c
rename to drivers/net/intel/iavf/iavf_osdep.c
diff --git a/drivers/net/intel/iavf/base/iavf_osdep.h b/drivers/net/intel/iavf/iavf_osdep.h
similarity index 98%
rename from drivers/net/intel/iavf/base/iavf_osdep.h
rename to drivers/net/intel/iavf/iavf_osdep.h
index cb95b848b6..dc2145b8c2 100644
--- a/drivers/net/intel/iavf/base/iavf_osdep.h
+++ b/drivers/net/intel/iavf/iavf_osdep.h
@@ -5,6 +5,8 @@
 #ifndef _IAVF_OSDEP_H_
 #define _IAVF_OSDEP_H_
 
+/* File containing OS dependencies for base code */
+
 #include <string.h>
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 50630a88c8..9b071a3a4b 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -12,7 +12,6 @@ deps += ['security', 'cryptodev']
 sources = files(
         'base/iavf_adminq.c',
         'base/iavf_common.c',
-        'base/iavf_impl.c',
 
         'iavf_base_symbols.c',
         'iavf_ethdev.c',
@@ -21,6 +20,7 @@ sources = files(
         'iavf_generic_flow.c',
         'iavf_fdir.c',
         'iavf_hash.c',
+        'iavf_osdep.c',
         'iavf_tm.c',
         'iavf_ipsec_crypto.c',
         'iavf_fsub.c',
-- 
2.53.0

