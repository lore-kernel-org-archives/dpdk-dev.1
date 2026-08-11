Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB12AC5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:50:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E26042795;
	Tue, 11 Aug 2026 19:49:18 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 40D6442793;
 Tue, 11 Aug 2026 19:49:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 76F70E0D23;
 Tue, 11 Aug 2026 21:49:15 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 76F70E0D23
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470556;
 bh=h8nRH4Bk1B1xSPPymgnZLGzDopt/mAQwOjZkLxGWZiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=y7Tf7Fly0aTQfb2Ghcp0gZ17rdnOc5BvkAsg7cJcyNXob8m3l+U8N4G6/JZo+NptR
 dsdndii8OJKeOtg31Z4Oy8XHSOVFh/yCrZZ8L7YR4X557cBHx6hXEHHhIZAaNRQ8ib
 w+ZB2QDeRUW8Hs+GDcgSjScA0R5rJqYKjUYgQA+ymvK0mngGjQZ8o/O/NV6V9e9qNs
 T6lWQ8Tw8FwCp6n9hNPuHOtUi5sW8EyZIhtbIbiU+9haWmDHUizMQZ+1Jol0L3LzAG
 ZG2s5EStVvT69rLIvvte5rSP5DvwzgaSutsY8yefkqR6H79pYKNI1CLbjSvS7lOVFA
 bRIoeghwRuKIA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 1/3] net/sfc: set Rx queue type flags from scratch on queue
 setup
Date: Tue, 11 Aug 2026 21:49:11 +0400
Message-ID: <20260811174913.8961-2-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174913.8961-1-ivan.malov@arknetworks.am>
References: <20260811174913.8961-1-ivan.malov@arknetworks.am>
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

Derive queue type flags from scratch on every queue setup
so that flags left over from a previous configuration do
not persist when an offload is disabled.

Fixes: b8cf5ba549f2 ("net/sfc: support initialising different Rx queue types")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/net/sfc/sfc_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index d8b961ff7e..e049beced5 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -1183,7 +1183,7 @@ sfc_rx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 	else
 		rxq_info->type = EFX_RXQ_TYPE_DEFAULT;
 
-	rxq_info->type_flags |=
+	rxq_info->type_flags =
 		(offloads & RTE_ETH_RX_OFFLOAD_SCATTER) ?
 		EFX_RXQ_FLAG_SCATTER : EFX_RXQ_FLAG_NONE;
 
-- 
2.47.3

