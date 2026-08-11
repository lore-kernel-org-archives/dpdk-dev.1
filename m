Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F0DC5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:51:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 555DE42C24;
	Tue, 11 Aug 2026 19:50:36 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1782E427B2
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:50:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 6196CE0EC6;
 Tue, 11 Aug 2026 21:50:31 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 6196CE0EC6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470631;
 bh=D8tJ3Ix/aWjFMepSkBtLtZTXJeHr2TIx6KQSvqXEg8M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zDXusQGo7wfUHqR6xgaLpduKAT4cBEZ/PTxSjZJrHA4DlJy8HoLEfOZ/opZfk+IX8
 zgBaUyEHCCAwmIfGQMZy3EV4NngSBKu9GRVwjIzPWMo1ayplpditD0Yf7FIOFYZafw
 L9ydnGAxT0foLqHfENZIEiJuRA/oB6fQcAo/9KH2rBZAPnkV/83o575cBCAkXl6atD
 eCoWLNWf/AsTqUUoQiwRuPSicUj1WxIxrQlbX4FF3XF9+O16HUxF1Zi+O0VntS0wh1
 Gr9lbZnFMwuYspID2DySgmdQrXp4YrSpGBylLEoVZvXBv6k99sRqSuc+f2NveQ+O/G
 NyJCeN1QgsBZQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 6/6] doc: announce VF support of AMD Solarflare X45xx family
 NICs
Date: Tue, 11 Aug 2026 21:50:25 +0400
Message-ID: <20260811175025.9019-7-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811175025.9019-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
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

The Solarflare PMD has been updated to support VADAPTER statistics and to
let the user attach to the X4 VFs (created by the PF that is attached
either to the DPDK application or to the Solarflare Linux net driver).

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 doc/guides/rel_notes/release_26_11.rst | 4 ++++
 1 file changed, 4 insertions(+)

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

