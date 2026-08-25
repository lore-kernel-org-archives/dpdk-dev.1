Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45FDC61DBC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 16:28:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A992A40A72;
	Tue, 25 Aug 2026 18:27:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 70FC94013F
 for <dev@dpdk.org>; Tue, 25 Aug 2026 18:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787675254; x=1819211254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TDbVWhIo7mJ1NiLznSjMuweL0ckxANJ156gQJ7VSSPE=;
 b=gyWwpw2Sq1Ca+cK4nXpqdwNWCiEqk53Rzyo9Runjvch1EtFZHnhDBxCX
 9b1nzdjkd9sPzdukOQXohGQamPkO3TtHTVi3ZFNYHpMjdD3uClmjyMCmy
 9GhQb2r5Kwl76TvRdjNMB9imJt0L7RIgseKqFKC3DrrhhEMXsD/YQogXg
 7Yg+nIPYkOug28HYbNQUSnkK9QuAEaLNPYQTjlHjaJhS1sKur7zJzUFmA
 PwQU7C2+w0Jb7IpOf/yENWVfzIaabNQXsYwtyyJH9SEnypVAlb65EUgbb
 S3kBD6iDcnwYdfUIhvyXsyv6JpBFeliXJ8jvj12j2cDNNlMSNRLFG2zYW A==;
X-CSE-ConnectionGUID: oOmrznrIRh6YKwJJREarIg==
X-CSE-MsgGUID: lpTfEQfPSL+JGqjYsVedyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88277675"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="88277675"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 09:27:34 -0700
X-CSE-ConnectionGUID: iO5lsmoFRvCPCKay1yoqDQ==
X-CSE-MsgGUID: 9aD+ZZE6TdWoB/vbbPDj2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="269286215"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 25 Aug 2026 09:27:33 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v3 8/8] net/ice: consolidate the sources list
Date: Tue, 25 Aug 2026 17:27:12 +0100
Message-ID: <20260825162714.1049272-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825162714.1049272-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260825162714.1049272-1-bruce.richardson@intel.com>
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

The sources list for DCF part of ice driver was separated out for no
functional reason. Merge these into the main sources list for ice
driver.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/intel/ice/meson.build | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 5dff99f4a9..322d9597d2 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -3,6 +3,11 @@
 
 sources = files(
         'ice_acl_filter.c',
+        'ice_dcf.c',
+        'ice_dcf_vf_representor.c',
+        'ice_dcf_ethdev.c',
+        'ice_dcf_parent.c',
+        'ice_dcf_sched.c',
         'ice_diagnose.c',
         'ice_ethdev.c',
         'ice_fdir_filter.c',
@@ -38,14 +43,6 @@ elif arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
     sources += files('ice_rxtx_vec_neon.c')
 endif
 
-sources += files(
-        'ice_dcf.c',
-        'ice_dcf_vf_representor.c',
-        'ice_dcf_ethdev.c',
-        'ice_dcf_parent.c',
-        'ice_dcf_sched.c',
-)
-
 require_iova_in_mbuf = false
 
 base_sources = files(
-- 
2.53.0

