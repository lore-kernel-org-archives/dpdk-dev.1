Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E92C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:02:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C8E1410F9;
	Wed, 16 Apr 2025 16:00:47 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 12DCD40EE2
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 486ABE1149;
 Wed, 16 Apr 2025 18:00:39 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 486ABE1149
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812039;
 bh=Iy3vr89K93BNGoCZaVniJyypeNo5b3mKc+iBxJUMuvg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0SesymWM8lPATJ4ErCt5emJzPVd5HAwVjiLtdiy+u6SBDdnXfQvVM4d3dFwl+M82J
 LVMHNAjx1Nuqtax922UwEILgWNNx9eXEfqQo+1XiJNXRihmGuTKG7cbUGwFw3UxXMv
 lD5Jl+Xj9XxrH/f8QT2H/7g07srwrfUBO9PHRCd/DK7+c0RbvIQirQmxp8pCh9BGHX
 E8eOHn26otxEpD99OoYXIwFkYhGQ9sh9GhAJWNM3ZgD+4Vn8H/YfIi7U5ti48xq34+
 Yr+brXgIvXStvjry7dWOiPqKIk4AUXic3o6hPJWGAQqNO+Pzat42P2xG7snlfx2Q7h
 VwMzLg2Mfo1OQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Richard Houldsworth <richard.houldsworth@amd.com>
Subject: [PATCH 17/46] common/sfc_efx/base: add new X4 port mode
Date: Wed, 16 Apr 2025 17:59:47 +0400
Message-Id: <20250416140016.36127-18-ivan.malov@arknetworks.am>
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

Add handling for the port mode in the Medford4 driver logic,
enabling support for two single network ports.

Signed-off-by: Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Richard Houldsworth <richard.houldsworth@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 .mailmap                               |  2 +-
 drivers/common/sfc_efx/base/ef10_nic.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index afebbb32e6..1fbad1e1ae 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1295,7 +1295,7 @@ Ricardo Salveti <ricardo.salveti@linaro.org>
 Richael Zhuang <richael.zhuang@arm.com>
 Richard Donkin <richard.donkin@corigine.com>
 Richard Eklycke <richard.eklycke@ericsson.com>
-Richard Houldsworth <rhouldsw@xilinx.com> <rhouldsworth@solarflare.com>
+Richard Houldsworth <richard.houldsworth@amd.com> <rhouldsw@xilinx.com> <rhouldsworth@solarflare.com>
 Richard Walsh <richard.walsh@intel.com>
 Rich Lane <rich.lane@bigswitch.com>
 Ricky Li <ricky.li@intel.com>
diff --git a/drivers/common/sfc_efx/base/ef10_nic.c b/drivers/common/sfc_efx/base/ef10_nic.c
index 0e00ff64d4..e28978e4cc 100644
--- a/drivers/common/sfc_efx/base/ef10_nic.c
+++ b/drivers/common/sfc_efx/base/ef10_nic.c
@@ -1972,6 +1972,16 @@ static struct ef10_external_port_map_s {
 		(1U << TLV_PORT_MODE_4x1_4x1),			/* mode 26 */
 		{ 0, 4, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
 	},
+	/*
+	 * Modes that on Medford4 allocate each port number to a separate cage.
+	 *	port 0 -> cage 1
+	 *	port 1 -> cage 2
+	 */
+	{
+		EFX_FAMILY_MEDFORD4,
+		(1U << TLV_PORT_MODE_1x4_1x4),			/* mode 3 */
+		{ 0, 1, EFX_EXT_PORT_NA, EFX_EXT_PORT_NA }
+	},
 	/* FIXME: review Medford4 port modes */
 };
 
-- 
2.39.5

