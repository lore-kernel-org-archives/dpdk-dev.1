Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D876AC55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A13F40BA3;
	Tue,  4 Aug 2026 17:46:12 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 807E240A84
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:09 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d004f135b1so49321955ad.3
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858368;
 x=1786463168; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vGZuzpHGs8RyNX+31WgJS0/OotDbBBCqPFvLu/Tm2Fw=;
 b=a11wWG2YePdrWEfR1S/W9V/y4H0I2ssm8VOsI1lvtXR5QubishQC7VYNyXW5z7805P
 SYo6D1NHIl8ss5XDdG0SDolQCgHK+1eoojL4Y1dNp95+GuI+QZxGWy8TNGZVyk59jm+t
 5nz7CGcDdTJaEaWuQOXWojDHDsGX4SXC2UghRCIayncV9kQzTdQidqe+m4mU3+omJ0oD
 3yxbUY1xFe9hmGqjshTQpGciouCXeVGC2el1uWZT+zESqPQQ0NLixGkKN+eA/rZuS8Ax
 Q3Ws1dQ9q4YKn8CfyD0d8W/np+f1DKIwq1sw8k9Ss6tSNSsUoNAEDNtibswiyzaWlGC0
 /y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858368; x=1786463168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vGZuzpHGs8RyNX+31WgJS0/OotDbBBCqPFvLu/Tm2Fw=;
 b=bSRQ1iAaZlQMu4NMjjksifB0iCs+SzR2QVyDoykxDOo5pYwEdnjqiqBFX9p3iXRyb1
 qE7qWT4yhXLVMej9DJ3cmpsgSwcnXf1hYcUrpTvc8/25MJ9SvkOB7V32iG/GoWx8lhdN
 ZhP3hwHhYXLTa1ORKwp/LNktMO2NBoegy+38B45cpTHLZ7T20qT++vrGN12SO/avAEP8
 QGMfIzJznFpyqyJoGCeAX5CHkRUufsmq1roX1Rws/4eAnGDi1TD1/VhPf/pzCnYCS9tO
 2+LHcGuxt3Fj33JPPBvRYqiMtXpqkTRmH67GhKMz60imE8hICtBgcwus7sE7z/Lto1IB
 LARQ==
X-Gm-Message-State: AOJu0YxoU9XX27G8xCl2FQD5ufrAfwPmu8SoFeYiWdCIwKWuLtdpDln/
 evr5poLy5OO69HRw4lrpjJBhSFb0s1rMh0j/ifhLHFI8sdplLSavunGYLkEnHhUzCCCKonKfRvh
 QXXQN
X-Gm-Gg: AR+sD10UlsAUzwy0dvs3zjpKOEtItVFfcitJzKKiqErUh8RWf2przD2mmZfqCR1/UmT
 LeU4E4hAqqSNu7isfjBKWayivpRCbvCRZUQ0roGuHINXM4Hm4PfTHzEVx81M7ks1lyZy3rUTIb5
 YauJKoufsOQjY87sNGV6OKIryQmpBXF3eipA8r7XZXP0Ddy9w/LnqMbWXLRaojz+xKIUbdyB1R+
 agTS2aopuUEvD4zbElbEIiHO8X1oCzjoaue2cFwUb2/bs3Tz7IXyVJQkDn6iceTTzkmPTKrpLt9
 L9UyqKv8FbYTOZzcr8TWAm7LYpiSC8jmOYZ9LNT/v+Q5/vpYkGKnMLNP4JRYVR8yVNK2tBrH3wb
 t2ofricxfnGo5ZRJBLVbCusAIZfde/CHqe5yavtyO2XAuKK2Ij2hujfhjZYA9x9adnnMt4ooONy
 IVM+VwpCGIjSis5oTcV64UT5piLptCK8DWgfyQTic+rO8imUFAUAvw5kYYBHH2Y3EuW1lFggjpZ
 /5IPEBQXXEsSIvSZVA0xu1JXj0=
X-Received: by 2002:a17:903:19c3:b0:2ce:8e70:3210 with SMTP id
 d9443c01a7336-2d05225ae15mr160566955ad.16.1785858368594; 
 Tue, 04 Aug 2026 08:46:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v3 11/23] net/nfp: break implicit dependency on rte_eth_ctrl.h
Date: Tue,  4 Aug 2026 08:44:59 -0700
Message-ID: <20260804154549.148691-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

This driver was using UINT64_BIT which was getting defined
via deprecated rte_eth_ctrl.h. Replace with local definition.

Also include rte_flow.h instead of depending on indirect
inclusion from rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_ethdev.c     | 6 ++++--
 drivers/net/nfp/nfp_net_common.h | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
index d2da18013c..25be1de080 100644
--- a/drivers/net/nfp/nfp_ethdev.c
+++ b/drivers/net/nfp/nfp_ethdev.c
@@ -6,6 +6,7 @@
  */
 
 #include <unistd.h>
+#include <limits.h>
 
 #include <eal_firmware.h>
 #include <rte_alarm.h>
@@ -32,6 +33,7 @@
 
 /* 64-bit per app capabilities */
 #define NFP_NET_APP_CAP_SP_INDIFF       RTE_BIT64(0) /* Indifferent to port speed */
+#define NFP_UINT64_BIT (CHAR_BIT * sizeof(uint64_t))
 
 #define NFP_PF_DRIVER_NAME net_nfp_pf
 #define NFP_PF_FORCE_RELOAD_FW   "force_reload_fw"
@@ -2060,8 +2062,8 @@ nfp_net_speed_capa_get_real(struct nfp_eth_media_buf *media_buf,
 
 	for (i = 0; i < RTE_DIM(media_buf->supported_modes); i++) {
 		supported_modes = media_buf->supported_modes[i];
-		offset = i * UINT64_BIT;
-		for (j = 0; j < UINT64_BIT; j++) {
+		offset = i * NFP_UINT64_BIT;
+		for (j = 0; j < NFP_UINT64_BIT; j++) {
 			if (supported_modes == 0)
 				break;
 
diff --git a/drivers/net/nfp/nfp_net_common.h b/drivers/net/nfp/nfp_net_common.h
index 2bd2d54028..62c6448cc3 100644
--- a/drivers/net/nfp/nfp_net_common.h
+++ b/drivers/net/nfp/nfp_net_common.h
@@ -8,9 +8,11 @@
 
 #include <bus_pci_driver.h>
 #include <ethdev_driver.h>
+#include <rte_flow.h>
+#include <rte_spinlock.h>
+
 #include <nfp_common.h>
 #include <nfp_dev.h>
-#include <rte_spinlock.h>
 
 #include "nfpcore/nfp_sync.h"
 #include "nfp_net_ctrl.h"
-- 
2.53.0

