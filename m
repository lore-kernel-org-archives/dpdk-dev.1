Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761AECD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 04:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E647402BD;
	Wed,  3 Jun 2026 06:43:20 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id CD345402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 06:43:18 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso32671165e9.3
 for <dev@dpdk.org>; Tue, 02 Jun 2026 21:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780461798; x=1781066598; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LK62DYnm6rUmSPIptAoHXDVg3vFaW4R2clYxeaM/HJA=;
 b=gbwNB66RYPEnXJ1ffQ9JaCkKI4XMmoK3ZuBedbHGdE2dFsolrB//znz0brpYt3+gvK
 P5N8Kc3+6MM1RZv/MgzErlFJrSDHly1P16+AMZsKrPhdOCArOeTrd00ff8YFhu3Nbrbx
 Om3JI759BYdfq/QxI7leiHuYPyFUPB+eqbZgwYXIpl7CS7r4ktGXnQtevyLymjHUJDFl
 BpGpiRsHL4zuvPAXw0O/bGMd4zUG/qKH3Y1wBUUOXWenThCACV2XfcKVYN0c/3H/RA7s
 o7U1zbVYwo6HJG9MiSxFBjWpvG6EEt/WKEALsctiIKtyGgPOrZXjlqxCzpfXdA2sgM/e
 CxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780461798; x=1781066598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LK62DYnm6rUmSPIptAoHXDVg3vFaW4R2clYxeaM/HJA=;
 b=eET+f98Wb28CQ6+rzSbs1HJCpzT3l0oMP4BG3qDPaGOllISVclKiJregH/TF6ZZf7h
 g9LQIdDnPsUBV3Vc0GRxnivVBs7pev17qUCqqLftopLZNTVD8Pm2mcUp2Ues/aZAsnYB
 S3abC53k0+ff+AyM4UKid66/+Ot8HO/BgqNZT5bP4VlyyAnso37i2Sk/2acbKos9ywab
 RJ2F42AAIdwnlatKdkGLFIUNua+47QgnAeokAW6B7i9vT4E8L452L289Sw1/PObsyPeq
 m7ODE3uQDBgqFSX4xvA25IbyojllDzLte4Dr/67Eb+kT681+gMx6O99IGXUYLo3UqkMo
 ZEig==
X-Gm-Message-State: AOJu0YwHMp27u9LFZC3PlCiRGKJPtaNP4I3UKKkwEN84FM/UD+mPfX5n
 kFUG9MJ0TtlMM59DOouwseGvaMzWRoRLtygJyAzGyaxR1RSRt0aMMyKgQWVdFExr
X-Gm-Gg: Acq92OGkflJuDSYfmHPIp/tRkFAWFG35uIJDnhei3JGNSkLMwHufv7R+PLhVvqNpkZz
 vV9SuO5Fj8azAhS56tifm/2KtiZ21bLoe1HmEf65nCvSaAQWlDIRwSYRouA5z8apTPydlxh9grV
 2q4mGbcHf15V0qVyGWwbQribf3cOl675kUp0kbdVjnYMLNM8sFvDK6OKRQLUaGzQsGe105YTjNC
 5BfF4Kl31pDFgx+TWPaiXqy7JrrBB5qFr2MRuJlQPzb/sSwA7O8MCPlKTayoG14tqEGNLoeVkQk
 9Mf+gFmDL2sPlEuqJk0cfhpMePN/eZM/W62tM3W2e6AdnD6c52X+6j+r+tSxeo4HwdYIjhwkTus
 GM9F0XOoA7BNgrS6+dV3fOABKQ5huPUUBcUmSUsN+7KiEql9Tu1QgqSz2fZ+zikhVUrYAB8pHzP
 lpl4hLHFn1tSEnrboxeajE5zOKaJegAf4Nt5TWR/OaPFaECdmT04DxxR2j
X-Received: by 2002:a05:600c:4f07:b0:490:3c15:7146 with SMTP id
 5b1f17b1804b1-490b5ec411bmr27302445e9.19.1780461798385; 
 Tue, 02 Jun 2026 21:43:18 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3529e0sm4522408f8f.28.2026.06.02.21.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 21:43:18 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, sdl.dpdk@linuxtesting.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] net/af_packet: fix qpairs argument upper bound check
Date: Wed,  3 Jun 2026 07:42:18 +0300
Message-ID: <20260603044228.117357-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The qpairs vdev argument parsed via atoi() is stored in an
unsigned int. A negative input such as "-1" wraps to UINT_MAX,
passes the existing "< 1" check, and reaches
rte_pmd_init_internals() as nb_queues. This causes excessive
socket and memory allocation in the per-queue loop.

Add an upper bound check against RTE_MAX_QUEUES_PER_PORT.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ccd37d341e8d ("net/af_packet: remove queue number limitation")

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 0ee94e71ea..ebf015dd9a 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -1169,7 +1169,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 		pair = &kvlist->pairs[k_idx];
 		if (strstr(pair->key, ETH_AF_PACKET_NUM_Q_ARG) != NULL) {
 			qpairs = atoi(pair->value);
-			if (qpairs < 1) {
+			if (qpairs < 1 || qpairs > RTE_MAX_QUEUES_PER_PORT) {
 				PMD_LOG(ERR,
 					"%s: invalid qpairs value",
 				        name);
-- 
2.50.1

