Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA73C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2E3B42D89;
	Wed, 16 Apr 2025 16:01:21 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE9F427CC
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:01:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id E80BFE11BF;
 Wed, 16 Apr 2025 18:01:07 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am E80BFE11BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812068;
 bh=JlTGkZ//OsGfDaZ/pwDfDMZEFhuuMiYhpi3rFK4/L4g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d0U0614JOas7zkwb8f7tP8smGgnoi0XTjT5SL0ldx9oGMMY1oOGxHjM9OE+vcpoc9
 yWcu9BNfUcvcCVO+bt88ZItyjjNYnu1Qo0AlhAZsn7gzQ6jpUjpjilGmyCVzqRgDgE
 10h5Fn7sA5Q6+tblGv9kydd+9j0ZWEBnCELBK8v127etw3jcfEyww/T65VGzzqA5eF
 vD6WSXGRWDBqmaNxTxRNEAKtLX0paCA73apbhFNrLnWrKAae0cg6wc8meCW+rOuB61
 bp0r08u5cIoCPOpjQVfZS2oxumFEV+pJZC20oFUbb6mcEi9B5EHAPAvW0yooJ1AMtx
 Ur8ZJ+ymxys9g==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 46/46] doc: advertise support for AMD Solarflare X45xx adapters
Date: Wed, 16 Apr 2025 18:00:16 +0400
Message-Id: <20250416140016.36127-47-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

The two NICs, X4522 and X4542, are based on EF10 architecture.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 doc/guides/nics/sfc_efx.rst            | 9 ++++++++-
 doc/guides/rel_notes/release_25_07.rst | 4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/sfc_efx.rst b/doc/guides/nics/sfc_efx.rst
index eafb88191a..4bd9f8c441 100644
--- a/doc/guides/nics/sfc_efx.rst
+++ b/doc/guides/nics/sfc_efx.rst
@@ -10,7 +10,8 @@ Solarflare libefx-based Poll Mode Driver
 
 The SFC EFX PMD (**librte_net_sfc_efx**) provides poll mode driver support
 for **Solarflare SFN7xxx and SFN8xxx** family of 10/40 Gbps adapters,
-**Solarflare XtremeScale X2xxx** family of 10/25/40/50/100 Gbps adapters and
+**Solarflare XtremeScale X2xxx** family of 10/25/40/50/100 Gbps adapters,
+**Solarflare X45xx** family of 10/25/40/50/100 Gbps adapters and
 **Alveo SN1000 SmartNICs** family of 10/25/40/50/100 Gbps adapters.
 SFC EFX PMD has support for the latest Linux and FreeBSD operating systems.
 
@@ -21,6 +22,12 @@ More information can be found at `Solarflare Communications website
 Supported NICs
 --------------
 
+- AMD Solarflare Adapters:
+
+   - AMD Solarflare X4522 Dual Port SFP56 Adapter
+
+   - AMD Solarflare X4542 Dual Port QSFP56 Adapter
+
 - Xilinx Adapters:
 
    - Alveo SN1022 SmartNIC
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index b8b56510f8..467536fe05 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -60,6 +60,10 @@ New Features
   Added a new network PMD which supports Mucse 10 Gigabit Ethernet NICs.
   See the :doc:`../nics/rnp` for more details.
 
+* **Updated Solarflare network PMD.**
+
+  Added support for AMD Solarflare X45xx adapters.
+
 
 Removed Items
 -------------
-- 
2.39.5

