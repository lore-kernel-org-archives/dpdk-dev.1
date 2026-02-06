Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823C8EE20B6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:05:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABEF440669;
	Fri,  6 Feb 2026 18:04:47 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id D2DFA402BE
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770397479;
 bh=O1jV0JljMx9DG7uBMKbzh4455JzL/uWMdZQOAJwurms=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=F5YFzPYbNGKQWKkBSnxVNHkbJabTSvchXGATBHQlOheYRwA7h+GXkSTPR8PCkzT2W
 NHuqM9GUyDa+qyNkE139kxNc4OQTRCz0dLsGtvAd4UInrhzN/cMcL4g2/xjdm6iVuw
 MwQv+eVXLyipGODMT8sfYDGh3L7BTvmUX8wXXMk3C2QzVj16pZwkvGP3CMJVklJEfh
 M6+Rukid6Vct3ShiqaAioWk3vc0+pvlPiWAP7mU24vSDox9djnfs+amDUCXHXFJD39
 TcyR8fXA4qJsmbeuiqSboDovFg/ZMi1aRmHY3vMv5dTcREYPl//9S2EruGRIEXZXaV
 gE7R2yRgAvuiw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id AAA311180078;
 Fri,  6 Feb 2026 18:04:39 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 7/7] doc/nfb: update release notes for nfb driver
Date: Fri,  6 Feb 2026 18:04:35 +0100
Message-ID: <20260206170435.302184-8-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206170435.302184-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

Update the release notes for the NFB driver with Link Up / Link Down,
RS-FEC, Rx MTU configuration and link speed status features.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 doc/guides/rel_notes/release_26_03.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 7678cf1a49..de14238b1e 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -64,9 +64,10 @@ New Features
   * The timestamp value has been updated to make it usable.
   * The DPDK port now represents just one Ethernet port instead of all Ethernet ports on the NIC.
   * All ports are used by default, but a subset can be selected using the ``port`` argument.
-  * Report firmware version.
+  * Report firmware version and correct Ethernet link speed.
   * Common CESNET-NDK-based adapters have been added,
     including the FB2CGHH (Silicom Denmark) and XpressSX AGI-FH400G (Reflex CES).
+  * Added support for configuration of the RS-FEC mode, Link Up / Link Down state, and the Rx MTU.
 
 
 Removed Items
-- 
2.53.0

