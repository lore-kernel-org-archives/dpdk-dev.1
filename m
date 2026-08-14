Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9669AC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3F7E40E01;
	Fri, 14 Aug 2026 14:56:35 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 7908C40BA0
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:56:31 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id BCF85E0F0C;
 Fri, 14 Aug 2026 16:56:30 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am BCF85E0F0C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712191;
 bh=B2Lux3JuRiA+GNnCnMh0Sy6kun/aC1335wlru8yuWv4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=7gibC+XviW0B6qCFHBt036bq7+JUv1lM9myg4cwVtp7zS4hybmtJAzuH48bq64erT
 8Z7U9Cmbx4ERQ+mLT830XjSe9cLvA/snTEOIawARehTHPEHv27UXpPPCNQUmknz9jW
 dTzX0aX/0ouKSrzHC9SdSBJB39owgeHIhWkrLbJ8r9Q8m52rDPt2vi71rJObJDHL4H
 qp3MaaNqQsfzMW9RrQGbBfaLeOzAUvEi0jBCj+4gWWWYhujEMOhIfZUzg+Yy3GHaqU
 OaWY7bfg5vKBAhxYR3RhkipEYjE0iUnSBSwBu49BxwS1SoNvCFtKgk6spkqbQo8Pdg
 LpR7h+l4wbVew==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 6/6] doc: announce VF support of AMD Solarflare X45xx
 family NICs
Date: Fri, 14 Aug 2026 16:56:24 +0400
Message-ID: <20260814125624.13372-7-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125624.13372-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125624.13372-1-ivan.malov@arknetworks.am>
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
 doc/guides/nics/sfc_efx.rst            | 2 ++
 doc/guides/rel_notes/release_26_11.rst | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/doc/guides/nics/sfc_efx.rst b/doc/guides/nics/sfc_efx.rst
index ae5ef25715..bdb946a703 100644
--- a/doc/guides/nics/sfc_efx.rst
+++ b/doc/guides/nics/sfc_efx.rst
@@ -113,6 +113,8 @@ SFC EFX PMD has support for:
 
 - SR-IOV PF
 
+- SR-IOV VF
+
 - Port representors (see :ref: switch_representation)
 
 - VLAN stripping (if running firmware variant supports it)
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..a4a8a67d8c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Solarflare network driver.**
+
+  * Added VF support on AMD Solarflare X45xx adapters.
+
 
 Removed Items
 -------------
-- 
2.47.3

