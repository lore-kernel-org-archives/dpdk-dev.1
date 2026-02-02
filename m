Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C52E7DEF3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 15:15:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64CF6409FA;
	Mon,  2 Feb 2026 16:15:29 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 5EEEA402D8
 for <dev@dpdk.org>; Mon,  2 Feb 2026 16:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770045328;
 bh=6pOjtzYEDIxJUFcTWnM1JZaxsGbJDN0BiCO/3GE0qoM=;
 h=From:To:Cc:Subject:Date;
 b=AJFJQfZiGy+/astElVwknQq8mnnGITATcabTjOs87wK+P+LQ/ibP/zZONlz/AcrUY
 qzEHAbSqmphHesX0Quiz4Td0iTjLPwwKAGIdLAjckz/wox5gY6fG2off0rNhCe7JQn
 Vv4grE9gLHz25sXJJX7arQxTU2lTAzdAfrUO/DL1HpZr15CV78URc2b2vSjutNztlE
 ayUmE0HjR6TLHl78owy0/DLzxRGMG6ef7e03EZxqlvWYkUdHgJuXkTMtREyRssnj+c
 8ZnjMOpJ0O2CCmSEsJ4QlEayVFY2h+LH393ZXsr7qs8RiIXnhgfhufeCK4JgAAzwRc
 t9+4Tz0Ke30jA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 085AF1180078;
 Mon,  2 Feb 2026 16:15:27 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH] doc/nfb: update release notes for nfb driver
Date: Mon,  2 Feb 2026 16:15:21 +0100
Message-ID: <20260202151521.3245438-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
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

Update the release notes for the NFB driver
with the timestamp value changes.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
Depends-on: series-37064 ("net/nfb: code cleanup")

 doc/guides/rel_notes/release_26_03.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 52663580e3..29d8c6bb37 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated CESNET NFB ethernet driver.**
+
+  * The timestamp value has been updated to make it usable.
 
 Removed Items
 -------------
-- 
2.52.0

