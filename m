Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E06C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 111A540DC9;
	Wed, 23 Apr 2025 18:00:38 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id EBC9640A72
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 49555E02EB;
 Wed, 23 Apr 2025 20:00:30 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 49555E02EB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424030;
 bh=7JvqhwecfCOkohmt/avlmpc4hsz6HDpZdtdvniHESDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=9cGnZ03/HeeyiSW8dTGtgsgQPzmLUvHVJ+ZPQbS14pCcltPKsUVJnPIHPeRBCGOKY
 mLpXrXw8qstqHcnnG0wgpc4CL3tC2ZKMvwTKyd4I6SjJmWgZKgPFHuCUpmyeidCSJj
 7k7+1HuPCvqutZvjFD3ZwPAFfE19K5uqwlB/ltzRF6hacdcT+cYBY1jKcfDKEDuSdc
 9mbSzRAuscfOZDvcMJNnlbvVUz7Yjkg6yetusGidK/B+FWDbCwkfwtrOUQ/gFW6LXE
 xIjdEOb1vlSGwvL+VL6oS57naQgHfGXwWtO4JS3eVHpOdcf9C90yRrqR88mhZnnaYz
 WxG5Hn6QoTp/w==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 22/45] common/sfc_efx/base: allow for const in MCDI struct
 accessor
Date: Wed, 23 Apr 2025 19:59:39 +0400
Message-Id: <20250423160002.35706-23-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

The existing code is fine, however, future patches will need
to use this macro on buffers that are passed by callers with
const qualifier. With 'cast-qual' enabled, this macro causes
compile warnings in such cases. Rework it to allow for const.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_mcdi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/sfc_efx/base/efx_mcdi.h b/drivers/common/sfc_efx/base/efx_mcdi.h
index f13bf43da6..4e82717015 100644
--- a/drivers/common/sfc_efx/base/efx_mcdi.h
+++ b/drivers/common/sfc_efx/base/efx_mcdi.h
@@ -536,7 +536,7 @@ efx_mcdi_set_nic_addr_regions(
 		EFX_DWORD_1) << 32)
 
 #define MCDI_STRUCT_MEMBER(_buf, _type, _ofst)				\
-	((_type *)((char *)_buf + _ofst ## _OFST))	\
+	((_type *)((char *)(uintptr_t)(_buf) + _ofst ## _OFST))
 
 #define MCDI_STRUCT_BYTE(_buf, _ofst)					\
 	EFX_BYTE_FIELD(*MCDI_STRUCT_MEMBER(_buf, efx_byte_t, _ofst),	\
-- 
2.39.5

