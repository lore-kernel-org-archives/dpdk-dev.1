Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB1C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 10:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E21B840E39;
	Wed, 19 Feb 2025 11:58:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8254440E12
 for <dev@dpdk.org>; Wed, 19 Feb 2025 11:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739962689; x=1771498689;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=w6tiUo302GZW3EOHmFhC2zyAGfQ7seZh3s9w9tRAi74=;
 b=jHYJBAaC7keDe6e7Hws5CRD/2G7DFdHXrBwLN9y4AUH0uEtohBI8VoGf
 bkQ4sqmVmpb9UXVu6XGrZKRkrm4P/8xpxOtHh8HRIQ83K/FwuiPTFUfrp
 LfgtCfA8y/gsc80/2d1k1oEsj7z35EWNJf4WnPoxcUnIFH3L2HEzE4wJ0
 /fkJN/gqsQ6CpdzM8KIiP+mSXFLMJ/FzhH268fbNJ3Es3MrGcPFU8RaQr
 lsGeam18f9F7V0MnOZ83on0BqAxRg7zDxDJuJMgYB13ksUQaI1LNT+vwe
 3LVYoBoeYnq0pthnx86M/l2JRr6lAq+uUztePb3lh5w6eeRWmjZQ9hVdz A==;
X-CSE-ConnectionGUID: Cv+nuWCxRjW5k2pDH1WXJA==
X-CSE-MsgGUID: xe/IqR6MSHymImIz4J9c9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44609956"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="44609956"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 02:58:08 -0800
X-CSE-ConnectionGUID: Avs8uU8tQeGy+FuGnlpTfA==
X-CSE-MsgGUID: 2K233yNqQaWfKAOyCSPgog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="145533485"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 19 Feb 2025 02:58:08 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 4/8] drivers: remove kvargs from class dependencies
Date: Wed, 19 Feb 2025 10:57:50 +0000
Message-ID: <9d5a161f2b5a9ddfa4d463c3c3da9bd5a1954f88.1739962646.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739962645.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739962645.git.anatoly.burakov@intel.com>
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

