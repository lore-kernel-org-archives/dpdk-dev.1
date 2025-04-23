Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B82C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38E4340A7F;
	Wed, 23 Apr 2025 18:00:32 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id DBB1D40693
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 136F0E0142;
 Wed, 23 Apr 2025 20:00:25 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 136F0E0142
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424025;
 bh=4dDYdAizgEfDa6Bvqm4Uu7uqvN7/XHpMQwyoCuvPBTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mx+cizxr4JU1QVD9EjjSwsBiyKbgr8ktwg/Fmk24fvf5l/nwT4mR+6JCZWjrb3EhV
 YiZ1rw22+ByNeIfD9ibitEdfXQPZ+dgv5n9myRROApZfVUWyvRqjpLO7yJ5kQgdSgT
 R6unG81Pz0lBxe5K0/D1GAF3kBxSUy5xkw+j6hjFZL4cx+TY2kLXiXGA/9AYCM459K
 ASS8ubqXASjDZQwWuwbzvhC6YOX90O9N2W7HrIOJOroOMz/xiBP7hbvqTkn/955aLw
 us7UdPko2yvDqUCsD+J8WYRtibtl67Ho7oDAvW0nxuvzu70ild5F06+TruGtFk87BC
 NPUY/xxEyQnuw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Richard Houldsworth <richard.houldsworth@amd.com>
Subject: [PATCH v2 17/45] common/sfc_efx/base: extend list of supported X4
 port modes
Date: Wed, 23 Apr 2025 19:59:34 +0400
Message-Id: <20250423160002.35706-18-ivan.malov@arknetworks.am>
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
index 199e605d88..bce9df0aa6 100644
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

