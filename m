Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353E3C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6BE04065E;
	Tue, 18 Feb 2025 12:15:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 32358402E8
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:15:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739877349; x=1771413349;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=w6tiUo302GZW3EOHmFhC2zyAGfQ7seZh3s9w9tRAi74=;
 b=GGm1JpyWTXl/gm38HXg+SJ5qGUvMJSss7fvel8gM+GozpIzLT0nC3b8z
 hSoYARuYZDNItrJwhT+0r4ENGIdJ9XkrqZiZXGQw8AEeeL9gpO+BW2EL8
 g2L8Q+edTIi7t8K6fi2qoVdY28umOU6cocyG1WA65uEFNAwvrqSkXhbkH
 OaREwnVDsa75yCjsN3EkHMUjxJLaRDXQZAerbmNps+zdrSPMQCvoU5LyW
 fxmstJAv3auqLd/Pf89M5P3BM3t8DB/rFOon2fR0VjXZdz/aoXoXfmScC
 PRexOj4tMtKhBMUClUk3Y5RzeCD5PziVLODMGmyZQ1twk0yFa6vj3WZTy w==;
X-CSE-ConnectionGUID: Pg+3jlc7ThCPZjQ+H5GWng==
X-CSE-MsgGUID: eMkVHvUnT66fhwSZ7S6CnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50780814"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="50780814"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:15:48 -0800
X-CSE-ConnectionGUID: C7pH6L6tRP++7BXE3YAOyQ==
X-CSE-MsgGUID: E2mwsnzXRi+9/0/cWHGb/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="119466262"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 03:15:47 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 4/8] drivers: remove kvargs from class dependencies
Date: Tue, 18 Feb 2025 11:15:30 +0000
Message-ID: <1b7d95daf08481d65868229f68a61a545d5726fd.1739877266.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739877265.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
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

From: Bruce Richardson <bruce.richardson@intel.com>

The kvargs library is used by EAL, and therefore is implicitly a
dependency of every DPDK driver. Remove it from the minimum set of
dependencies for each driver class as it's unnecessary to call it out
there.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/event/meson.build | 2 +-
 drivers/net/meson.build   | 2 +-
 drivers/regex/meson.build | 2 +-
 drivers/vdpa/meson.build  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/event/meson.build b/drivers/event/meson.build
index d6706b57f7..2708833adf 100644
--- a/drivers/event/meson.build
+++ b/drivers/event/meson.build
@@ -19,4 +19,4 @@ if not (toolchain == 'gcc' and cc.version().version_compare('<4.8.6') and
         dpdk_conf.has('RTE_ARCH_ARM64'))
     drivers += 'octeontx'
 endif
-std_deps = ['eventdev', 'kvargs']
+std_deps = ['eventdev']
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 460eb69e5b..246f99ec17 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -65,6 +65,6 @@ drivers = [
         'xsc',
         'zxdh',
 ]
-std_deps = ['ethdev', 'kvargs'] # 'ethdev' also pulls in mbuf, net, eal etc
+std_deps = ['ethdev']           # 'ethdev' also pulls in mbuf, net, eal etc
 std_deps += ['bus_pci']         # very many PMDs depend on PCI, so make std
 std_deps += ['bus_vdev']        # same with vdev bus
diff --git a/drivers/regex/meson.build b/drivers/regex/meson.build
index ff2a8fea89..10192e7c77 100644
--- a/drivers/regex/meson.build
+++ b/drivers/regex/meson.build
@@ -5,4 +5,4 @@ drivers = [
         'mlx5',
         'cn9k',
 ]
-std_deps = ['ethdev', 'kvargs', 'regexdev'] # 'ethdev' also pulls in mbuf, net, eal etc
+std_deps = ['ethdev', 'regexdev'] # 'ethdev' also pulls in mbuf, net, eal etc
diff --git a/drivers/vdpa/meson.build b/drivers/vdpa/meson.build
index 896e8e0304..e01c277b9e 100644
--- a/drivers/vdpa/meson.build
+++ b/drivers/vdpa/meson.build
@@ -11,5 +11,5 @@ drivers = [
         'nfp',
         'sfc',
 ]
-std_deps = ['bus_pci', 'kvargs']
+std_deps = ['bus_pci']
 std_deps += ['vhost']
-- 
2.43.5

