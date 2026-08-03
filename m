Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD48FC55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F228140A4B;
	Mon,  3 Aug 2026 18:53:22 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id DAAD640691
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:15 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c9fe3c9bd5fso80364a12.0
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775995;
 x=1786380795; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n9hw+M6eRVed4boVcugzYoR9TdG+QylMmS7ERWW1X1k=;
 b=cw0H0YJkRcWELgslgyyrWfssE2d1GSqwYjjPv3d97xu0Ook/V8Pliii+YC6eCKPYzK
 FfBha28v0ImulJ/VOhGAc3V22q0Ji89QvEP+NlQz9R+w1galzGr8Cjknr0qIsR7GWGvL
 EzKluGfU6x0VNKxkPsM8VfE6p89tjpDTz8urQJVMHocFrNCSWrgw0VpWm8SKeCr6EyA7
 G8hMLFvt88RGcZ4W/HL2vFtrmTFXmSQEAlbJyxX904qXeTcTw6EAaUQgevi7tlQPm76o
 YRvY3tiFfxj/VvWVED3XhsJIqQCac72hai21JjlWk9y2dr4O+2A9S4uLCLi3S7L4GMq+
 GUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775995; x=1786380795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n9hw+M6eRVed4boVcugzYoR9TdG+QylMmS7ERWW1X1k=;
 b=sHtudpjTs+mCX4/iVOzh3dnPR0k5t82Wt2KMH/NXVUIAfgVjgWsgQXsi4za0pVBXVM
 7BuFDibvvhQbYie8zqdIgzgAmtqg13BpP3lHIuzVOZye3kPj7zzftQEJDBWi67CPU2ti
 N+TvSfLvyTsasQBgZa3xB+4OUgeGN/bRoKm0QAR3f9ZkSvg1nkIkaxteyWqqh465yKmj
 HFrzGxkDo/Ley9X1LJwDYSckYaD8riRWH0ZqoPn4P1R8FC5/3/i9D+H/KFROdB9jk/ck
 HclhZLCQysgnPTxP/troav7bw0l6Ib+H9xhrApxtySrcd5ShH2bcIEyh9vjKz6Ww2LXq
 TwkA==
X-Gm-Message-State: AOJu0YwhQ2Gltibaq0P0xCmMw7TRSbKiBk/n5iEun55sblLDLy7dw617
 FgAF6YAFBdwudTkFo6dVAZyB0jflokxpRz/cIcVE5kM3673Ooec+M7It8IqlcutRKx41Gk26h2n
 D2S9+
X-Gm-Gg: AR+sD12Rxo46ueDjPiD2uWNv+qQew4jDGy3k0s/kBlIvUpP8sQJJTk1aIWVq04+vznm
 DYMZcZvYx51APRbS92LJVqFU9ytEjNoqueFF+KRCfZaeoYxz1LR56gcmGmHMfh4AVU2OmlAbTFN
 SDPqKd+hplosSRblDAfqVft79oBZzEREmTsRM0wzjlL7aEj4GOt4xO9w9xevEjhhnM2smtmxGt8
 h6gHEhrUjvihOp3PFphM/w9g5avEP5SmYSRdaWHG0uU71e3LDCs5SxgeOGpjfCbGGC2zzLUOadK
 JRJpkv1TpBWrULRTzjpDsJx2dQ8fDSLmGqGS60pGfNw8hZ0FU2L9dpclbhjdYNbqfXF9Wqexici
 SL0PYgVp8lEmP00QDtR6uion/KmgWq4klW+ESRhZlB8bkrxcOgl0LBXdwBj6HFHmis2dkPIr8gm
 kSpZcSza3qD6FJdIrm8oKxzqE/XmQkENxxYIYF+ZF5BvOjs885HhHJCkhFj0KeaxnGlbtWPHHzK
 zqIYfMwClKz4uHDH8wZ/Kz40h8=
X-Received: by 2002:a05:6a20:2d14:b0:3a8:800:bdf4 with SMTP id
 adf61e73a8af0-3cb6ca4cc03mr297790637.33.1785775995069; 
 Mon, 03 Aug 2026 09:53:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH v2 08/22] net/nfp: break implicit dependency on rte_eth_ctrl.h
Date: Mon,  3 Aug 2026 09:51:54 -0700
Message-ID: <20260803165304.289869-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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
 drivers/net/nfp/nfp_net_common.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index 2bd2d54028..a479a7fbd4 100644
--- a/drivers/net/nfp/nfp_net_common.h
+++ b/drivers/net/nfp/nfp_net_common.h
@@ -8,6 +8,7 @@
 
 #include <bus_pci_driver.h>
 #include <ethdev_driver.h>
+#include <rte_flow.h>
 #include <nfp_common.h>
 #include <nfp_dev.h>
 #include <rte_spinlock.h>
-- 
2.53.0

