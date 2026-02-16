Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B0DE83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67C1B40695;
	Tue, 17 Feb 2026 00:05:03 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 2A1874067E
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:05:00 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso2374075f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283100;
 x=1771887900; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=pa0yGpJJyljAsyOaJ271YlNe08RMKGWXaDLsrCya/nRk6r+yuznj8rD2Nx9817cVk8
 1T3P5Ee5ipgXpSMmIpP20klJo4bCnmN2Q+mAx/8zW2kbRtGed4nLKsfub4V79SPOqRfW
 Ba8VDlHc3q1KY/hyvmfhZ7dN7bFQg1DiPM/hnkzH1tbiXfGaTNENYe5j1Hyj9lu2RGh3
 yk/axY10rjEcBhAiIHNtQD98K0fr7pjDjZU1Qajsm8+MYLHuDpEzmeUzNBCoW1OHXTIG
 qigvoKXae+ZLOYL35vcm48hQUBQHNJRvfcKTlE2xzN9s14K5tRRK+vCnxUjmfHFNyxOW
 0eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283100; x=1771887900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/omJoVtSBuPtIyWBO+npMl3uPvGP9xe48jZLhu4cU/8=;
 b=orUOlrXBXLrW+fyR2WgoLCbkQpm5rOHuAO6v1rlTW0DmpbJNRYYPAYDregEhsbzHC8
 otHxVzbsvEhOqhhmYWZFkRYb5/WQuDxTHxCktWyCzFd2d2K+1QQoYU5TxXkjZrLfv8z8
 EfbW5NE5fvxP6f9dBTa2MDk2IgTURhxQoYky14io59foPy2E1IDOddLxlXu5GTPAEvDF
 QkFwLcQ09r9fXy64740sX8xnBEly8ucn6H64VQGWnv/RjneN2UpVzEHg+ad7CJTZOF03
 g/9UFemTVl86wcUYdHOi1K+Wvl2RxRG2ufFWJEfba5ZoI7xfaOmIypK+CiC49NRXZ1cs
 /3sA==
X-Gm-Message-State: AOJu0Yx3ITYmKCkmOGqAd6Z5uYFtz9znXXOePfvlsILqt2KT7MeuegaI
 8tmfeF1oWIxb6AKHUxGLBG9tPYdwtmy/OG4dS87gQnaWPngsbq4bewJBRjR8GNrKVJfge2I33cC
 /vZBEIE0=
X-Gm-Gg: AZuq6aJPrTFyyT0uS7DyoSQDScZ6LW59teJESuJDauCqtjriUISTEWCetxMWaQ7Vlh9
 OIThRWyK1Wb2QbDJyJ6obuJkSEp1jl+9DJ3YAxrbBVArSPzl24uPWhho/RlqpVkcOUeMrySI6uO
 J8sR//uwXCSy9ARDwC65Nu/IjN5vjorjm6mjnTXv0w7cW+hGETRw8sPUoAwjbsdujG/rbgH+HW9
 B31NXhHEgXyHl+8nQmCBfRmkTTueTri74Il32XO3ivGcbrFpp0awDG60YCaR/7G7z6S3o+O6grL
 gk6h2iTC9WLXakFBd9Ak3jpjzyHnJy0SpK81fHn5rKIXjPJ+y9gLFD3i9YM5ASii/mrrREISW+Q
 Wa4VS0Sw1EwslSymXFq5igX+4WrQ7OV5UhmHx1TBFJizrSEfKvBVRktDK9tpExzzNYCFWXMsdjX
 c2ZWP8+BgsshYtzRI1iJ9Ltg1VEZMhwvy9TzFwv377aua4IgeVdcEr0lP7H54+nY8gEArRAFQ7
X-Received: by 2002:a5d:5f48:0:b0:432:5c43:53 with SMTP id
 ffacd0b85a97d-43796aeff1emr22366131f8f.36.1771283099785; 
 Mon, 16 Feb 2026 15:04:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 10/11] net/tap: free remote flow when implicit rule already
 exists
Date: Mon, 16 Feb 2026 15:02:34 -0800
Message-ID: <20260216230437.847578-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

When tap_flow_implicit_create() gets EEXIST from the kernel, the
allocated remote_flow is never freed. Add rte_free() on that path.

Bugzilla ID: 1880
Fixes: 2ef1c0da894a ("net/tap: fix isolation mode toggling")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/tap_flow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 427faf75d5..da1e70019a 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -1625,8 +1625,10 @@ int tap_flow_implicit_create(struct pmd_internals *pmd,
 	err = tap_nl_recv_ack(pmd->nlsk_fd);
 	if (err < 0) {
 		/* Silently ignore re-entering existing rule */
-		if (errno == EEXIST)
+		if (errno == EEXIST) {
+			rte_free(remote_flow);
 			goto success;
+		}
 		TAP_LOG(ERR,
 			"Kernel refused TC filter rule creation (%d): %s",
 			errno, strerror(errno));
-- 
2.51.0

