Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566E6C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C36E040BA3;
	Thu,  6 Aug 2026 07:10:28 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id B9506406BA
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:26 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so1891927a91.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993026;
 x=1786597826; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vGZuzpHGs8RyNX+31WgJS0/OotDbBBCqPFvLu/Tm2Fw=;
 b=urjaib6BvYSRSqYOf+z1Qpe4KqYL40dndtDMnAMINHD2haHR4FCYYK4Le1E4UdcK9m
 31E70PJsZQqd/iXvlkvS52pn389C24xdPrB9dwT/wFTtMetP8++u1MZMe3pW9k6paNYB
 gYrfj5WBhJf5hpNqCxpgYxPq2er4a/QlkAZezbfMNRyHK9sGKspcbD1Zr3lNW0tejiKz
 W7jCVDC91dMTMFNBK6RsDwhJdZHIzD87iKmxbrxcsmM6oOG9PrugkXMpBb2il5Gg1FdH
 I7hRdsVOduOm/rEaRAEc5IgorJWJFE5JSRtNBPK+psd6gx7NatmiTxZlmAjq8CxQeE5b
 I3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993026; x=1786597826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vGZuzpHGs8RyNX+31WgJS0/OotDbBBCqPFvLu/Tm2Fw=;
 b=tPhnUNeFjUhiOmCT2iOL7SzlnYOoaj67Z1ll8pokHLK7oI9k/ILy7ELH4PnL4hWFsH
 VY5YJTSOMkrcYmsjU6tVqwEb6z1+YlFmFYOtxsHu7dQk/CpQacl7bjLwdmBpMoNs5LEI
 BnIZ1I+Ic1BJS4I8Zb22PvO+XSPs+nb1C6V//oLhFrZ1HkcerBD3ZKMUmDFusTxNmq+Z
 mMdjE0+ftVKqAbF1IIzrgeqoVkswGXyhzhhH8VSGM0qEVUvaqmbAiDTdT5UrLgCxc9DR
 OYHNqZBQluD1GW+X7n6Y6xY7nEG2H7W8TyF3/eE2cbZrsdBml2RUyV40hjK6pdyEWkpz
 EglQ==
X-Gm-Message-State: AOJu0YyPBcF9wPqerN8RKEIioK+tVkhmVM7USSfGBCqthswuxUEzEUPZ
 PpOgcFbmZSBiJ3UEUb0KnxKkHQ/ZybxIYkQbZFdFdz6ek1wHATh3KSYy2/n8uGkhy+6SShcgbqk
 Cbm3p8ig=
X-Gm-Gg: AR+sD13UKwPXNPjeA2t/TrUtptzlnEqE5HPgxuffqYCLNe1854QTHdKogta2R2j4sTj
 3Tk40O12vTWJwMvXjIAwsuRnzYoxDNCqFACzpR5q6jdDcrYUfKEZUbTkeTU/HiE+rWoN0Yla8Xb
 EvEJ4ueON9fVjJFTicphJ9/zQm/UOhdhagvW5XHO8cGzashM/n6CrD5ISurqRUTUwC4vc+HRU0J
 GcyE1MWVKO/nJSgD+FtzeBOoXStZFloB0P3+283VPsG80yM8NjFMXfP11LHjVGjnrfk5x1xqzB/
 kOFMaCBIRAG7yO3xvwPN1wdL/FHeyA4VMuEShA3mHL7Bsi/n0syGyXmXAbYqPOX9I3qyRw8bwmR
 z5/ZgMjJdPaVW+J+S1d+QPum0u4mFCMS+iKEppJa+nxYx7Qob0IHRJl08Ul5hDHo+nHcD4+V1Aj
 iG4a/80ui+ai5SVeSTRBj3FZRzXkX5x5o9QsGYb5XE6h2e5iqA1Q38jILTNtnFtefaECkzETXwr
 WVHCFvNn7jvdIhSFkG2V82vgiA=
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id
 98e67ed59e1d1-3903c58bdd2mr12052005a91.11.1785993025881; 
 Wed, 05 Aug 2026 22:10:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v4 11/23] net/nfp: break implicit dependency on rte_eth_ctrl.h
Date: Wed,  5 Aug 2026 22:09:05 -0700
Message-ID: <20260806051004.166778-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

