Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88739C61DBC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 16:27:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D11FC406B4;
	Tue, 25 Aug 2026 18:27:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id EB81D40655
 for <dev@dpdk.org>; Tue, 25 Aug 2026 18:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787675250; x=1819211250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sq9hdTsdBnts3roWOU4FZicGMvt5mrLmNZIMhxNh6FA=;
 b=GikVPO6GRW9/GfgHgNOniSemV/1nJFk17eA8a8Zr3KxdewO3LY4CaPrp
 a2+uSdKt/SWOgTcp5aUT+EL7atrhQ6Xo1cX6kxi3yy6L/vVaBix//3rxi
 aYIxN1TPNf8YhmvgdL+IN7kwZXaDPG5MQWmvFz6VlENJonru2rzmr8yz2
 MQ0LoXoLgn5wG2LXYn64rd52hL5mRHcp4tgXp4LLhVDCQkTDQXE0yEu4T
 Ikljn9a0CXldT97IxzodXgo7Kq316uSVEcg1vdZiMaF5T4ncXxDv4WMbQ
 wK2ITY+CPQqRQa23sArKLVO3t5HPgvH+86GKEcRqk3jXDDSfetGN1vcJJ A==;
X-CSE-ConnectionGUID: E1LaP/2BTnqBCfkj43arGQ==
X-CSE-MsgGUID: cGOsgW+CRWqPupm2K9e9Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88277661"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="88277661"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 09:27:29 -0700
X-CSE-ConnectionGUID: S890LyxlToOCk/Bx9TNokA==
X-CSE-MsgGUID: MZ3FywgNRL+pyRq7RBfVZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="269286178"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 25 Aug 2026 09:27:28 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v3 4/8] net/iavf: move editable files out of base folder
Date: Tue, 25 Aug 2026 17:27:08 +0100
Message-ID: <20260825162714.1049272-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825162714.1049272-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260825162714.1049272-1-bruce.richardson@intel.com>
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
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/intel/iavf/base/README                        | 8 --------
 drivers/net/intel/iavf/{base/iavf_impl.c => iavf_osdep.c} | 0
 drivers/net/intel/iavf/{base => }/iavf_osdep.h            | 2 ++
 drivers/net/intel/iavf/meson.build                        | 2 +-
 drivers/net/intel/ice/meson.build                         | 7 +++++--
 5 files changed, 8 insertions(+), 11 deletions(-)
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
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index a205304c89..d0ef71154d 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -22,11 +22,14 @@ deps += ['hash', 'net']
 if dpdk_conf.has('RTE_NET_IAVF')
     deps += 'net_iavf'
 else
-    includes += include_directories('../iavf/base')
+    includes += include_directories(
+            '../iavf',
+            '../iavf/base'
+    )
     sources += files(
             '../iavf/base/iavf_adminq.c',
             '../iavf/base/iavf_common.c',
-            '../iavf/base/iavf_impl.c',
+            '../iavf/iavf_osdep.c',
     )
 endif
 
-- 
2.53.0

