Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A85F01834
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 12:51:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EA3F402D3;
	Fri,  6 Mar 2026 13:51:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0CF5840262;
 Fri,  6 Mar 2026 13:51:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772801465; x=1804337465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qs16EPQQHEERzmos+Jf55tAqMSyrwaEHg1WxiKIr0BQ=;
 b=ZRlnkwcdwgj6rp+l375dfdH6musCjJMnnu9AKf07YBGcwpWaGxljwmLS
 NCsd17dlVhOU5dSnH5AB2zLrA1j5pl5uWjjQF4u6417DKwHR+BEfRTrw8
 VBaqUgb8A7DAU+zkS4LvODgO5EbJxg5FduKNh2Nk4vdkH8pfm+jMD57rs
 UskJzwyedX7EI+yYadizUgkO2rN+X0jLOqLO6JXgR6OtlrgB6muWR6K4O
 UzC8c0f9pl34Xda0xxwmOVZHYW3mOaGM4XGFiEu54tf4YaYC0wzwpA50j
 SATzLVUNTWy5oSMuPpnO8CgMjcDx3C3blipYSD15r9GiIC7wdTvAW0loq g==;
X-CSE-ConnectionGUID: VJAzXESISPC4dhUtxyvCKQ==
X-CSE-MsgGUID: cely4wloS/W8h/bnektw2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84544057"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="84544057"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 04:51:03 -0800
X-CSE-ConnectionGUID: xE/AtVyRQj6gU4JGlcFxkw==
X-CSE-MsgGUID: VBdO75cCStCGXshrmhNNfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="219137633"
Received: from silpixa00400465.ir.intel.com ([10.20.224.190])
 by orviesa007.jf.intel.com with ESMTP; 06 Mar 2026 04:51:02 -0800
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com,
	stable@dpdk.org,
	Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v2] doc: update Multi-buffer library version for DPDK
Date: Fri,  6 Mar 2026 12:50:59 +0000
Message-ID: <20260306125059.2451999-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302164742.2230427-1-kai.ji@intel.com>
References: <20260302164742.2230427-1-kai.ji@intel.com>
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

Update the supported Intel Multi-buffer library version for
DPDK 24.11+ in the cryptodev guides for aesni_mb, aesni_gcm,
chacha20_poly1305, snow3g and zuc.

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 doc/guides/cryptodevs/aesni_gcm.rst         | 2 +-
 doc/guides/cryptodevs/aesni_mb.rst          | 2 +-
 doc/guides/cryptodevs/chacha20_poly1305.rst | 2 +-
 doc/guides/cryptodevs/snow3g.rst            | 2 +-
 doc/guides/cryptodevs/zuc.rst               | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_gcm.rst b/doc/guides/cryptodevs/aesni_gcm.rst
index 16bdaf3cb4..0b1f2262fb 100644
--- a/doc/guides/cryptodevs/aesni_gcm.rst
+++ b/doc/guides/cryptodevs/aesni_gcm.rst
@@ -75,7 +75,7 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.11 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
+   24.11+         Multi-buffer library 1.4+
    =============  ================================
 
 Initialization
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index d58ce20ff4..7ce92305d1 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -139,7 +139,7 @@ and the Multi-Buffer library version supported by them:
    ==============  ============================
    20.11 - 21.08   0.53 - 1.3
    21.11 - 24.07   1.0  - 1.5
-   24.11+          1.4  - 1.5
+   24.11+          1.4+
    ==============  ============================
 
 Initialization
diff --git a/doc/guides/cryptodevs/chacha20_poly1305.rst b/doc/guides/cryptodevs/chacha20_poly1305.rst
index b5a980b247..37d9d2e8af 100644
--- a/doc/guides/cryptodevs/chacha20_poly1305.rst
+++ b/doc/guides/cryptodevs/chacha20_poly1305.rst
@@ -67,7 +67,7 @@ and the external crypto libraries supported by them:
    DPDK version   Crypto library version
    =============  ================================
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
+   24.11+         Multi-buffer library 1.4+
    =============  ================================
 
 Initialization
diff --git a/doc/guides/cryptodevs/snow3g.rst b/doc/guides/cryptodevs/snow3g.rst
index bde30de1b5..0fe914ffd3 100644
--- a/doc/guides/cryptodevs/snow3g.rst
+++ b/doc/guides/cryptodevs/snow3g.rst
@@ -90,7 +90,7 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.02 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
+   24.11+         Multi-buffer library 1.4+
    =============  ================================
 
 Initialization
diff --git a/doc/guides/cryptodevs/zuc.rst b/doc/guides/cryptodevs/zuc.rst
index 1bede0498b..7c6b83e7eb 100644
--- a/doc/guides/cryptodevs/zuc.rst
+++ b/doc/guides/cryptodevs/zuc.rst
@@ -89,7 +89,7 @@ and the external crypto libraries supported by them:
    =============  ================================
    20.02 - 21.08  Multi-buffer library 0.53 - 1.3
    21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
+   24.11+         Multi-buffer library 1.4+
    =============  ================================
 
 Initialization
-- 
2.43.0

