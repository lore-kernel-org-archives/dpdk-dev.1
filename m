Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820DDC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:55:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40BB040DDA;
	Fri, 14 Aug 2026 14:55:02 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id D213F40647;
 Fri, 14 Aug 2026 14:54:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 0A973E0F0C;
 Fri, 14 Aug 2026 16:54:54 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 0A973E0F0C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712095;
 bh=ewBljydTCpJB0+ImxJY4EmgCRXCf5sr23UKUpD4HIIY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aBup6ZuCn/LrmSv95I4UAvUFY4jIYTc0GPckOeylHaICvXAN1nWoRmvH/Y1x2WJsl
 fFg4ZznbNsoGlBm3rz8NwoqP8pyD9nMdPdI3P0K3ztfLdaM7VU3BuISXzA69O7Xliz
 9f76HSy806Du+lLbcml4rnQF+typWutM3CRuMG0BlDWvQVJVDkOo8pws/FVuldhiJK
 3ZgRoF8TbqUoKoH7rMB2LbgyF7BXwFJN3KxXugcTw6aUIqCX12c/YMeL+AV/a3uaxr
 yEPo8m8zxjPsn+TFxdldu/k5bL13Dzi13z1gBKPaPcVmNRfqwHs5e9da8aOak/zxvQ
 eukGoL1Y/PMNA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 10/14] common/sfc_efx/base: fix annotation in netport stat
 describe
Date: Fri, 14 Aug 2026 16:54:34 +0400
Message-ID: <20260814125438.13283-11-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125438.13283-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125438.13283-1-ivan.malov@arknetworks.am>
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
index fd4432a2a4..e7ca6d3302 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -733,7 +733,7 @@ static					void
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

