Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D00C43602
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DCFE40264;
	Tue,  7 Jul 2026 10:58:36 +0200 (CEST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48]) by mails.dpdk.org (Postfix) with ESMTP id 65D294025F
 for <dev@dpdk.org>; Tue,  7 Jul 2026 10:58:35 +0200 (CEST)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5aec139da7eso502855e87.1
 for <dev@dpdk.org>; Tue, 07 Jul 2026 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783414715; x=1784019515; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BK4syHKed15lVbIPZ9si11xfff3VOMu7DIyGrDrxeBY=;
 b=YEbH5KkB5BD092d8QgALptVm2Oi9LyeLv3zQOr6hY+unQEqHTGRx0wSCiqL6KoXces
 lPiG7nnxpn8wmwknQZONEX4anLFRL3eZbU6AxxPq/fpTWcwVKwXCWZbAVjBMROmMxOMs
 SCMu9dlNHegg97uPdRPcocTVtjEzjBW1LDQR1O/uo7IW/OZaALg/HMmVdqjin4LlTImw
 lFCp8kGXJHk/t96Oppo0gPv1f7yEi66RuO3ip+Nkgd4a7eH/A7NzAgEWyzBqL1jauJMr
 TaoIGU00ajFLGU7/0jaF0nUurfJwd/kqPvTWMmI3AG78LQPgmjmk7llSc3Qf78Bz5nUQ
 hCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783414715; x=1784019515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BK4syHKed15lVbIPZ9si11xfff3VOMu7DIyGrDrxeBY=;
 b=LBa2ljeZw3OkVX1dK4TzeWMd5LIJQ1NqZ2H+n2XXsmLHqm92hzk0+b8wLyjnhi5O0S
 4pfh0MKFeugnfdypgYQLB6aCNcv/PiN0NRy1doNkne3UCFEtvwuh9hU/yZwwZcbu2s+A
 bejt6Jn8dlQn99uePcNPzGHi1OHRcXXLl2DT0OMONT4LvG/dX8eX4f/z5Gj7gbimNdqh
 x1pMKX+SyylyEFcKqzvnMkHfHS68hlpSWcsKEWxmB904AAR7r6YRxeBMtSWs8wxNcZ1q
 Y3Z0oxQIf59MIAJXx+dVXfE7NSVsPbfhJ0+9WA8zSi1ysZ47asENIzsS3eW9VZInRXIU
 IuyA==
X-Gm-Message-State: AOJu0YzI1/R6rZ6t9Zeb7Wi2Gj0Wsv7rt2Fj1AiqI+OXO3ZceFUcN08U
 M6mrbeXZa9jCSDXdQJ0yPXYVjTzOXIiloE+RcVf/sexGqnMLeKWhrKYD
X-Gm-Gg: AfdE7cn1e5CKFdjhM4i8z4VYBe/IcFPreznCzQIb8KtWD1UqhIj01zS9jIUZ/vpreph
 rJNTomm7TJ+9EFKho/2scDknC2a8HpIVu/8YAwApicCfVAMGCl6Lurn6L4N6MYpssnar+B4pjjr
 dJ+2U3Ls2GSZORQZudytsYlyjbaN7a5aE+uH/d6kCsfRVmkOWE9WaBIKAIiC32XFNAVvWg6v+9E
 XiGoWp/wSGLSfRK3BuNJnM4ewGdg4eBemlwof5DrLtkem9yY1sLM03CHwLUpu+RaqidzxPaBhC+
 cnaJW9oqSGbKBx3l2cy1XxupJpiONy+zDlW+4sLg0dooRZigAcJFri1rm7HuzZG8F/Opk8YPUaQ
 KncwYazBblg3+hgUHVSkVEmJIm3zGuRDVE0Xv8ei4fUo68gxVZeNQp15Ueb4TemVhq+pnnllxWv
 nGC2STc/3kpYREywi1JyoIi+ANFsKAURgsdETn38U7mZZXYojN
X-Received: by 2002:a05:6512:15a8:b0:5ae:b9b4:227d with SMTP id
 2adb3069b0e04-5b00ac68008mr401076e87.1.1783414714445; 
 Tue, 07 Jul 2026 01:58:34 -0700 (PDT)
Received: from home-server.lan ([31.204.104.167])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c3a38sm3515615e87.74.2026.07.07.01.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:58:34 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>, John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>, Nelson Escobar <neescoba@cisco.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH] net/enic: fix potential null dereference in flow mask check
Date: Tue,  7 Jul 2026 11:58:31 +0300
Message-Id: <20260707085831.40355-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The functions enic_copy_item_ipv4_v1(), enic_copy_item_udp_v1(), and
enic_copy_item_tcp_v1() each initialize a local 'mask' variable from
item->mask and substitute it with a hardcoded mask if NULL. However,
the subsequent mask_exact_match() call uses item->mask directly
instead of the local 'mask' variable, which will dereference NULL
when item->mask is NULL.

Use the local 'mask' variable (which has been validated and possibly
substituted) instead of item->mask.

Fixes: aa3d2ff82198 ("net/enic: flow API for Legacy NICs")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 .mailmap                     | 1 +
 drivers/net/enic/enic_flow.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4b5eb0c841..b154cd25a9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -71,6 +71,7 @@ Alexander Skorichenko <askorichenko@netgate.com>
 Alexander Solganik <solganik@gmail.com>
 Alexander V Gutkin <alexander.v.gutkin@intel.com>
 Alexandre Ferrieux <alexandre.ferrieux@orange.com>
+Alexey Simakov <bigalex934@gmail.com>
 Alexey Kardashevskiy <aik@ozlabs.ru>
 Alfredo Cardigliano <cardigliano@ntop.org>
 Ali Alnubani <alialnu@nvidia.com> <alialnu@mellanox.com>
diff --git a/drivers/net/enic/enic_flow.c b/drivers/net/enic/enic_flow.c
index 758000ea21..539b0eb725 100644
--- a/drivers/net/enic/enic_flow.c
+++ b/drivers/net/enic/enic_flow.c
@@ -407,7 +407,7 @@ enic_copy_item_ipv4_v1(struct copy_item_args *arg)
 
 	/* check that the supplied mask exactly matches capability */
 	if (!mask_exact_match((const uint8_t *)&supported_mask,
-			      (const uint8_t *)item->mask, sizeof(*mask))) {
+			      (const uint8_t *)mask, sizeof(*mask))) {
 		ENICPMD_LOG(ERR, "IPv4 exact match mask");
 		return ENOTSUP;
 	}
@@ -445,7 +445,7 @@ enic_copy_item_udp_v1(struct copy_item_args *arg)
 
 	/* check that the supplied mask exactly matches capability */
 	if (!mask_exact_match((const uint8_t *)&supported_mask,
-			      (const uint8_t *)item->mask, sizeof(*mask))) {
+			      (const uint8_t *)mask, sizeof(*mask))) {
 		ENICPMD_LOG(ERR, "UDP exact match mask");
 		return ENOTSUP;
 	}
@@ -484,7 +484,7 @@ enic_copy_item_tcp_v1(struct copy_item_args *arg)
 
 	/* check that the supplied mask exactly matches capability */
 	if (!mask_exact_match((const uint8_t *)&supported_mask,
-			     (const uint8_t *)item->mask, sizeof(*mask))) {
+			     (const uint8_t *)mask, sizeof(*mask))) {
 		ENICPMD_LOG(ERR, "TCP exact match mask");
 		return ENOTSUP;
 	}
-- 
2.34.1

