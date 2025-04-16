Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66DEC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:03:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5CF541140;
	Wed, 16 Apr 2025 16:00:48 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 372F540EF1
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 217D5E11BE;
 Wed, 16 Apr 2025 18:00:40 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 217D5E11BE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812040;
 bh=8O5GHdfZozatgKsC+aqC+IPhkg4VTg1dmpB1enemjIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=btpViXdKSMVT7MNflauBdSeAhZv97KYLiTj5zS3iSJFiAdg+qznt7IJJ1G2dJZd6g
 TfQuL95xqanN8Ej8jLbJagVPD8F0X8gaJwgeNHIceGxesoD8AOzxNt2fyuAioijQD/
 oGz2xkovkyCnp7pDqTq2OsUwtFCJl+rROc/VbXcOkANIZey3eVc2FgglOpIzmvCCqj
 L5L8hcT2KAGsW3Vm2+PltSchaxm7FZ6rXIZxyHKMdL7ggrm7sdjvl95Ud/yNrYhyLo
 A5LFFGDbkEQmboHzO5oG5LOJuerq4k7ChYK85ekQG/+eHTeyCrvoMvuQ5MoxiD7d65
 YHNCsD9Af3Gew==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Richard Houldsworth <richard.houldsworth@amd.com>
Subject: [PATCH 18/46] common/sfc_efx/base: extend list of supported X4 port
 modes
Date: Wed, 16 Apr 2025 17:59:48 +0400
Message-Id: <20250416140016.36127-19-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

From: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>

Add X4 port mode that allocates two 10G/25G/50G ports
to separate cages.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Richard Houldsworth <richard.houldsworth@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 drivers/common/sfc_efx/base/ef10_nic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
index e28978e4cc..e1e8de5396 100644
--- a/drivers/common/sfc_efx/base/ef10_nic.c
+++ b/drivers/common/sfc_efx/base/ef10_nic.c
@@ -1979,6 +1979,7 @@ static struct ef10_external_port_map_s {
 	 */
 	{
 		EFX_FAMILY_MEDFORD4,
+		(1U << TLV_PORT_MODE_1x1_1x1) |			/* mode 2 */
 		(1U << TLV_PORT_MODE_1x4_1x4),			/* mode 3 */
 		{ 0, 1, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
 	},
-- 
2.39.5

