Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB07DC5B572
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 06:21:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1A74406B4;
	Sun, 16 Aug 2026 08:21:01 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B1D3240611
 for <dev@dpdk.org>; Sun, 16 Aug 2026 08:20:57 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.77.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id B0207E0883;
 Sun, 16 Aug 2026 10:20:56 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am B0207E0883
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786861257;
 bh=Cxz7w7bHgeUljVfV9IvqY2QMajUGZl97Qi+PkAxjCYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WEWs4LbZ2Z/9whYEhWM++Z4onWuA7otVF/no9v8fJ47oLX2/Rx7PC6zc2kOjYbOYK
 f7BhoozyoaGQpUYTnJaKnv43E7WFwuxwUjKygkO1ylFzKIXSbjK8Gc7ml9x3U84wLv
 APkbsln9t5HjVxXXGmnVrwpCq/OqeZdeYuxsurAm2jM/KwZdxtjjO1zSZjpNChcfpf
 3ewTL64HJ36iR4q/Wr3nQYTKvcy9dDvu6vTgNOwvmWV5zDWrTBDOdKgGW/ryaKT6Xn
 TfL1a5aSbnoB9qALy+xDvKTNr7IgTvIpOeu3EM+nEf+IZruYFqJSMlxXO5LQf02JmB
 wl/TlBkruw6zg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 6/6] doc: announce VF support of AMD Solarflare X45xx
 family NICs
Date: Sun, 16 Aug 2026 10:20:40 +0400
Message-ID: <20260816062040.15562-7-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816062040.15562-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
 <20260816062040.15562-1-ivan.malov@arknetworks.am>
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

The Solarflare PMD has been updated to let the user attach to the
X4 VFs (created by the PF that is attached either to the DPDK
application or to the Solarflare Linux net driver).

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 doc/guides/nics/sfc_efx.rst            | 23 +++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/doc/guides/nics/sfc_efx.rst b/doc/guides/nics/sfc_efx.rst
index ae5ef25715..c29719ed7f 100644
--- a/doc/guides/nics/sfc_efx.rst
+++ b/doc/guides/nics/sfc_efx.rst
@@ -113,6 +113,8 @@ SFC EFX PMD has support for:
 
 - SR-IOV PF
 
+- SR-IOV VF
+
 - Port representors (see :ref: switch_representation)
 
 - VLAN stripping (if running firmware variant supports it)
@@ -157,6 +159,27 @@ Another limitation of a equal stride super-buffer mode, imposed by the
 firmware, is that it allows for a single RSS context.
 
 
+SR-IOV VF
+~~~~~~~~~
+
+X4 VF support requires management controller firmware version 1.4.0.8 or later.
+
+When the PMD operates as a VF, the following restrictions apply:
+
+- Link speed, FEC mode and lane count are accepted without
+  error but have no physical effect on the link, which is
+  exclusively under PF control.
+
+- Disabling flow control auto-negotiation is not supported.
+
+- FCS stripping cannot be disabled.
+
+- Link status change events are not delivered.
+
+- Periodic MAC statistics DMA is not available; statistics are
+  collected via one-shot uploads instead.
+
+
 Tunnels support
 ---------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 474479babc..a59d2fc8dc 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -61,6 +61,10 @@ New Features
     ``use_cni`` or ``use_pinned_map`` is set without ``dp_path``.
     See :doc:`../nics/af_xdp` for more details.
 
+* **Updated Solarflare network driver.**
+
+  * Added VF support on AMD Solarflare X45xx adapters.
+
 
 Removed Items
 -------------
-- 
2.47.3

