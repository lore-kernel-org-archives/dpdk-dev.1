Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49D4E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:35:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C239C402DA;
	Mon, 29 Dec 2025 22:35:37 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 871254025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 22:35:36 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id E2109E13B8;
 Tue, 30 Dec 2025 01:35:35 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am E2109E13B8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044136;
 bh=MWpiD/KNEjvH2lxUQKrdXcbXBsvdiZ3wUVhGKANuuzw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=64u6gN2LeozQ5kgxoo+yB954dkeIOCKmVrBffg8ZD0Tjk/iwe5m2DZ3D5drQJ0/DP
 rFJwv7JzUDp/M1gNgChgBZVbi4l4IlSzny1k7E65ja4VwipMyTVP/ipmOBCF11NtjL
 GuzEqsjZAIhA2oo8l/PzNiD9Db5C+pW6nJIPCRr3Vtr37CMfcluT7pUZXlzDhRfZKC
 biBf0Ce3jbx9svhgALa8lXlS8Op8Uj11wuBCoekK0/RyaH/uCZmGD9WJx8Zf1CIx5A
 s4qWz9uPcpuIjIQR3hUoK8zTLt50J/3EXyztJvBYOiI9w490vF7K/1IkI55jHt4HuD
 DGaFYwAKUni1w==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 1/9] doc: remove support for AMD Solarflare SFN7xxx family
 boards
Date: Tue, 30 Dec 2025 01:35:19 +0400
Message-ID: <20251229213527.37907-2-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229213527.37907-1-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
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

7000 series adaptors are out of support in terms of hardware.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 doc/guides/nics/sfc_efx.rst            | 14 --------------
 doc/guides/rel_notes/release_26_03.rst |  4 ++++
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/doc/guides/nics/sfc_efx.rst b/doc/guides/nics/sfc_efx.rst
index 4bd9f8c441..ae5ef25715 100644
--- a/doc/guides/nics/sfc_efx.rst
+++ b/doc/guides/nics/sfc_efx.rst
@@ -52,20 +52,6 @@ Supported NICs
 
    - Solarflare SFN8722 Dual Port SFP+ OCP Server Adapter
 
-   - Solarflare SFN7002F Dual Port SFP+ Server Adapter
-
-   - Solarflare SFN7004F Quad Port SFP+ Server Adapter
-
-   - Solarflare SFN7042Q Dual Port QSFP+ Server Adapter
-
-   - Solarflare SFN7122F Dual Port SFP+ Server Adapter
-
-   - Solarflare SFN7124F Quad Port SFP+ Server Adapter
-
-   - Solarflare SFN7142Q Dual Port QSFP+ Server Adapter
-
-   - Solarflare SFN7322F Precision Time Synchronization Server Adapter
-
 
 Features
 --------
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..52663580e3 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -68,6 +68,10 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Removed support for AMD Solarflare SFN7xxx family boards.**
+
+  7000 series adaptors are out of support in terms of hardware.
+
 
 API Changes
 -----------
-- 
2.47.3

