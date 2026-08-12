Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2460DC5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:09:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9311C427A9;
	Wed, 12 Aug 2026 19:08:54 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4033F40E1E;
 Wed, 12 Aug 2026 19:08:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 7A7AAE0BE5;
 Wed, 12 Aug 2026 21:08:49 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 7A7AAE0BE5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554530;
 bh=+CwGz2yNcML4ZPDosJam300m0h9OCFlhTSsH06kpPzU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N8QJoYzciJ9QCoWYeLYE/h/jSSk92jKmkqb7UoYRKztfnfgW2yMIZnqBEP0zRMj8j
 lxR71F79mn98DXWxRAcPOPGAfhvRvN6Sg+ysPyNj3Vx5CQ0NCMA+J0DaNWWLSI3JS1
 Oqj9vUZgpVbl7c2gNLhJZavlJhH12e+h00HXDZkv30/vV57u1W42DybNnWHvGVN/jI
 IoCqm2ZjB6hORujPf0Toydt74gMVLzMJtuhAYGUh7sX4eGeTTEgFD4YtiTtfYuhQOO
 WOFt4C5IWJ4tn+s6623kxmTuY3OBuKw6uvUjVlaJNUDhW8WIvTUK31JmXID/Hg2rpO
 L2yyRSsIkR2+Q==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v2 08/14] common/sfc_efx/base: fix annotations in get fixed
 port props
Date: Wed, 12 Aug 2026 21:08:28 +0400
Message-ID: <20260812170834.8443-9-ivan.malov@arknetworks.am>
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

Code analysis reports a buffer overrun for the sup_cap_rawp argument.
Fix the annotation to show the writable buffer size.

Fixes: a90549f527eb ("common/sfc_efx/base: get netport fixed capabilities on probe")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index baee83e58e..8b8e37c0e1 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -235,7 +235,8 @@ static	__checkReturn		efx_rc_t
 efx_np_get_fixed_port_props(
 	__in			efx_nic_t *enp,
 	__in			efx_np_handle_t nph,
-	__out_opt		uint8_t *sup_cap_rawp,
+	__out_bcount_opt(MC_CMD_ETH_AN_FIELDS_LEN)
+				uint8_t *sup_cap_rawp,
 	__out_opt		uint32_t *sup_cap_maskp,
 	__out_opt		efx_qword_t *loopback_cap_maskp)
 {
-- 
2.47.3

