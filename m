Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82479C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:55:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E7F940A4B;
	Fri, 14 Aug 2026 14:54:57 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 5486140609;
 Fri, 14 Aug 2026 14:54:52 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 85C66E0ADB;
 Fri, 14 Aug 2026 16:54:51 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 85C66E0ADB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712092;
 bh=wpbLFLRHuMnvXDASUzZzartUO/RVO0MgouLO5gk/CwM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=enUQgVwL73y5kY3SHnq2ImwLKoJjxbRqwGDmRUnQGAnWTTtm0PYVDXu+NBu0Mo9GC
 h1UdJr/VDdPLia3sq8bKLxDZOAQJHguH400al4cxc954sOk7e4MSnc7K3CDMU6K72h
 l8yJMlPszRWggTBqzbs2lfpp0urxiUze19yOsKnXoRsjOx9YbhA3xShAjrqFqw7e4/
 P0iXJkVbjqulq31ZooN9WEI2HAJvGrZzqw5sbbj70D/GtUo/nCLlUqBkO7QfjA5qhk
 9wZgrRNqXUGaohIMSRkI9Hd/MnZIX/dWWE3hqGrDsQ8lK1cbOrs6W2u7jTgMoz9Y+L
 OfALZfA4p2L3w==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 06/14] common/sfc_efx/base: fix annotations in client MAC
 addr get
Date: Fri, 14 Aug 2026 16:54:30 +0400
Message-ID: <20260814125438.13283-7-ivan.malov@arknetworks.am>
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

Fix annotations to show the size written to addr_bytes.

Fixes: 78b82063df10 ("common/sfc_efx/base: manage VNIC MAC address by MCDI handle")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx.h      | 3 ++-
 drivers/common/sfc_efx/base/efx_mcdi.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 2aa52b401d..b8d1ccd7bd 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -439,7 +439,8 @@ extern	__checkReturn	efx_rc_t
 efx_mcdi_client_mac_addr_get(
 	__in		efx_nic_t *enp,
 	__in		uint32_t client_handle,
-	__out		uint8_t addr_bytes[EFX_MAC_ADDR_LEN]);
+	__out_bcount(EFX_MAC_ADDR_LEN)
+			uint8_t addr_bytes[EFX_MAC_ADDR_LEN]);
 
 LIBEFX_API
 extern	__checkReturn	efx_rc_t
diff --git a/drivers/common/sfc_efx/base/efx_mcdi.c b/drivers/common/sfc_efx/base/efx_mcdi.c
index 04f2c99c0b..7e809ce5f3 100644
--- a/drivers/common/sfc_efx/base/efx_mcdi.c
+++ b/drivers/common/sfc_efx/base/efx_mcdi.c
@@ -737,7 +737,8 @@ efx_mcdi_get_own_client_handle(
 efx_mcdi_client_mac_addr_get(
 	__in		efx_nic_t *enp,
 	__in		uint32_t client_handle,
-	__out		uint8_t addr_bytes[EFX_MAC_ADDR_LEN])
+	__out_bcount(EFX_MAC_ADDR_LEN)
+			uint8_t addr_bytes[EFX_MAC_ADDR_LEN])
 {
 	efx_mcdi_req_t req;
 	EFX_MCDI_DECLARE_BUF(payload,
-- 
2.47.3

