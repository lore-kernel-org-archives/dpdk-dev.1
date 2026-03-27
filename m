Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A268310F2867
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 19:30:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A59340E49;
	Fri, 27 Mar 2026 20:30:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E00A8402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 20:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774639840; x=1806175840;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lvPXvRES/wNmHR0vJMl0E06IPZ/QmttZHOrwpctXXuA=;
 b=UroVxPNqDDjuPwKh7PuFEEQd0Zmiq+5I63wrgBytjq3xYTl10rlIdQoa
 QpJ1bkbQQurHwd4/Pbzdg7oQQO0+rnfCUhx6XW6VysyyOSIJWpIcSp8jP
 HZN+VLxvQWpULu3DFmj8752irsNvcjX3khDT2LOLUXK480NfuFhPboHaQ
 igh8uH8V6kL92GOgHmLnNUxVSIBjdG0DJUWXq4rmh7lQYGCyX+cEkPnqs
 2FuFgvaubIasTNdN9GsyZ7XVYCmMCE31nI0eNC25METfh45SR+K/NhWO8
 BgJ0Re9aWXXMw8OW9UGRQcRnS+C17dQoVSOMnl1vW4D2E3WlxoUYgF8GF w==;
X-CSE-ConnectionGUID: i1Nv/c6YQaCgEVfcpcGiFA==
X-CSE-MsgGUID: djCN2jt4TLmARkkcTXkUhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86340340"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="86340340"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 12:30:38 -0700
X-CSE-ConnectionGUID: cNr0wL3hQf2gO1lsQVqlLQ==
X-CSE-MsgGUID: AEoi97rTQ6WiHq8QN9sryQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="222085940"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by fmviesa007.fm.intel.com with ESMTP; 27 Mar 2026 12:30:37 -0700
From: John McNamara <john.mcnamara@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	John McNamara <john.mcnamara@intel.com>
Subject: [PATCH v1] doc: update release notes for 26.03
Date: Fri, 27 Mar 2026 19:30:23 +0000
Message-ID: <20260327193034.2700185-1-john.mcnamara@intel.com>
X-Mailer: git-send-email 2.51.0
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

Fix grammar, spelling and formatting of DPDK 26.03 release notes.

Signed-off-by: John McNamara <john.mcnamara@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 6bb18433f5..cbd02da337 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -88,11 +88,11 @@ New Features
 
 * **Updated Huawei hinic3 ethernet driver.**
 
-  * Added support for Huawei new SPx NICs, including SP230 and SP920 (DPU).
-  * Added support for GENEVE tunnel TSO, IP-in-IP tunnel TSO of SP230.
-  * Added support for VXLAN-GPE checksum of SP620.
+  * Added support for Huawei's new SPx NICs, including SP230 and SP920 (DPU).
+  * Added support for GENEVE tunnel TSO and IP-in-IP tunnel TSO on the SP230.
+  * Added support for VXLAN-GPE checksum on the SP620.
   * Added support for tunnel packet outer UDP checksum.
-  * Added support for QinQ of SP620.
+  * Added support for QinQ on the SP620.
 
 * **Updated Intel idpf ethernet driver.**
 
@@ -126,7 +126,7 @@ New Features
 
 * **Added 256-NEA/NCA/NIA algorithms in cryptodev library.**
 
-  Added support for following wireless algorithms:
+  Added support for the following wireless algorithms:
   * NEA4, NIA4, NCA4: Snow 5G confidentiality, integrity and AEAD modes.
   * NEA5, NIA5, NCA5: AES 256 confidentiality, integrity and AEAD modes.
   * NEA6, NIA6, NCA6: ZUC 256 confidentiality, integrity and AEAD modes.
@@ -150,7 +150,7 @@ New Features
 
 * **Added Ctrl+L support to cmdline library.**
 
-  Added handling of the key combination Control+L
+  Added handling of the key combination Ctrl+L
   to clear the screen before redisplaying the prompt.
 
 
@@ -174,7 +174,7 @@ Removed Items
 
   The SSE path was not widely used, so it was removed
   from the i40e, iavf and ice drivers.
-  Each of these drivers have faster vector paths (AVX2 and AVX-512)
+  Each of these drivers has faster vector paths (AVX2 and AVX-512)
   which have feature parity with the SSE paths,
   and a fallback scalar path which also has feature parity.
 
@@ -199,17 +199,17 @@ API Changes
   Several library functions now have additional name length checks
   instead of silently truncating.
 
-  * lpm: name must be less than RTE_LPM_NAMESIZE.
-  * hash: name parameter must be less than RTE_HASH_NAMESIZE.
-  * efd: name must be less than RTE_EFD_NAMESIZE.
-  * tailq: name must be less than RTE_TAILQ_NAMESIZE.
-  * cfgfile: name must be less than CFG_NAME_LEN
-    and value must be less than CFG_VALUE_LEN.
+  * lpm: name must be less than ``RTE_LPM_NAMESIZE``.
+  * hash: name parameter must be less than ``RTE_HASH_NAMESIZE``.
+  * efd: name must be less than ``RTE_EFD_NAMESIZE``.
+  * tailq: name must be less than ``RTE_TAILQ_NAMESIZE``.
+  * cfgfile: name must be less than ``CFG_NAME_LEN``
+    and value must be less than ``CFG_VALUE_LEN``.
 
 * **Updated the pcapng library.**
 
   * The length of comment strings is now validated.
-    Maximum allowable length is 2^16-1 because of pcapng file format.
+    Maximum allowable length is 2^16-1 because of the pcapng file format.
 
 
 ABI Changes
-- 
2.51.0

