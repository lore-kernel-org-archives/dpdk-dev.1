Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA9DE7FDCD
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 20:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F3FE4027D;
	Mon,  2 Feb 2026 21:12:13 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 6D0EB4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 21:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770063131;
 bh=QFUV9aYJ/AujKo2/AMQQszZwYA/zR/DsA9NU4VoCYnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hV37+kl4Kab+Hu3eGjaM6KKxHywZ1X3RLylzAfufPprYIiO27ed0W8G7TqNGGdrnM
 AsLxBlpcngH2yIXkvunjuXH2xNW7+xFj3wzHQMgTyRZhJ0NBemuW9jJ4vrl+8le6wF
 UrI68UCsnvhmJsrLqrEzUSo8iTfeYd5/pX/QF4Vkln7cQOH8CacHqqdyBnjHZhsA+l
 /RYogf5zDB42MKnuXrlZjjBAm4vtcMjCrpzpByxtCtZaKBv7hti2tN/0f+8IwWp6zr
 iyjQI5SuQSDiwzJcA/l/8wBInlmnWd5/Q6loTLQnTTH2cPxy0S44VPRlDW6TYgpiDf
 xCBOBObnaSqlA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 06FFF1180078;
 Mon,  2 Feb 2026 21:12:10 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2] doc/nfb: update release notes for nfb driver
Date: Mon,  2 Feb 2026 21:12:07 +0100
Message-ID: <20260202201207.3326331-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202151521.3245438-1-spinler@cesnet.cz>
References: <20260202151521.3245438-1-spinler@cesnet.cz>
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
Depends-on: series-37244 ("net/nfb: code cleanup")

v2:
* Rebased on next-net-main and updated Depends-on

 doc/guides/rel_notes/release_26_03.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index a837bdb600..ff02c294d0 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -59,6 +59,9 @@ New Features
 
   * Added support for V4000 Krackan2e.
 
+* **Updated CESNET NFB ethernet driver.**
+
+  * The timestamp value has been updated to make it usable.
 
 Removed Items
 -------------
-- 
2.52.0

