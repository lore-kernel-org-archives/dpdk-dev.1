Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF71C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7DAC427D0;
	Wed, 12 Aug 2026 19:08:56 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E0B4741140;
 Wed, 12 Aug 2026 19:08:51 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 27535E0C9E;
 Wed, 12 Aug 2026 21:08:51 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 27535E0C9E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554531;
 bh=BfI/OyPq6t34weq+h4XAIadS+r5B1d38calcKBnl1jo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QX3evKhNkkej/Ok7nrKRhTFFXeahKp/TGuSH8Wc4IuqYfhpjU1WlLJ7EtKwSY1XzI
 52MmThv58Pq/3k9P/tecmPljjxhDCneyNrznqR+YtBxw+giuMX9rdRGxiBq2YfWDYP
 8eYgbHtTOTuaVhhF4nDZOw+YtrZ2KqNeJDAtHvMMDFbQxKJdlEow9oZngjSSh2mGuf
 1tVp2nFIoil3jyA9Buzfku8inD5vXlDs9RVAjkSCn5b4kUourk+M6bGZDsaoCotqe0
 QLnSrysS2bm6D0U7VrlifdyuiA26XHdN1/24iYBgIcBxpvnR5XArpSt32RNGclws7Q
 V2/nyGMoJ+7ZQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v2 10/14] common/sfc_efx/base: fix annotation in netport stat
 describe
Date: Wed, 12 Aug 2026 21:08:30 +0400
Message-ID: <20260812170834.8443-11-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812170834.8443-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260812170834.8443-1-ivan.malov@arknetworks.am>
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

From: Andy Moreton <andy.moreton@amd.com>

Code analysis reported a NULL dereference of the lut parameter.
Fix the annotation to show it is not optional (must be non-NULL).

Fixes: f2f77453cb9f ("common/sfc_efx/base: fill in software LUT for MAC statistics")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 6cf5aeac11..86e5d11506 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -734,7 +734,7 @@ static					void
 efx_np_stat_describe(
 	__in				uint8_t *hw_entry_buf,
 	__in				unsigned int lut_nentries,
-	__out_ecount_opt(lut_nentries)	efx_np_stat_t *lut)
+	__out_ecount(lut_nentries)	efx_np_stat_t *lut)
 {
 	const efx_np_stat_t *map;
 	efx_mac_stat_t sw_id;
-- 
2.47.3

