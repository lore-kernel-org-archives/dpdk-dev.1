Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A4FE92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 21:36:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7D5D40656;
	Mon, 29 Dec 2025 22:35:41 +0100 (CET)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B1E22402E9
 for <dev@dpdk.org>; Mon, 29 Dec 2025 22:35:38 +0100 (CET)
Received: from localhost.localdomain (unknown [78.109.70.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 101E1E15B1;
 Tue, 30 Dec 2025 01:35:37 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 101E1E15B1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1767044138;
 bh=Q3JXPxrdXhsKYBc6NuAMi27Aq93yzSS7PIzJAAVMfeo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=8HeXLiJvfckTkslfePZiEEh+NG1+wKQ8dsrj8XS8K7TMcUUXHb/3g+Q1C9m547EkO
 kGb7VNXDnrERC6KmKskvwLs1poh3TlJ5xAuXaBW4g1T357VKzUp+0gaQ1Nk6J14eq9
 uJh7wcS618qqu1YJQgU65VZI8TkAeKyvrlu5z5RFToQSxM9bm/HXr0yHWGAHLFxvOO
 Dzqwtr8JisITyn+RhXB2iFKjdcP72EF7COysXOj0sr3856t+b8fuzYJyc6Lvt+0ncI
 sFrGGufRxh2Y3J3UT0xw1vZ964/Zy19YVQIfzJmseZC8K4GuilT3dBTLC9fUcX+VDd
 /X+rnuXhw24Hg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 4/9] common/sfc_efx/base: define mask for pause mode
 capabilities
Date: Tue, 30 Dec 2025 01:35:22 +0400
Message-ID: <20251229213527.37907-5-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229213527.37907-1-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
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

Client drivers (DPDK) will leverage it to manipulate flow control settings.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 8958f1b170..2aa52b401d 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -1242,6 +1242,7 @@ typedef enum efx_phy_cap_type_e {
 	EFX_PHY_CAP_NTYPES
 } efx_phy_cap_type_t;
 
+#define EFX_PHY_CAP_PAUSE_MASK (EFX_PHY_CAP_PAUSE | EFX_PHY_CAP_ASYM)
 
 #define	EFX_PHY_CAP_CURRENT	0x00000000
 #define	EFX_PHY_CAP_DEFAULT	0x00000001
-- 
2.47.3

