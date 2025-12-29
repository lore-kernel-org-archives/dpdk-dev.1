Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86484E92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05E0740648;
	Mon, 29 Dec 2025 21:48:38 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 6697140615
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:35 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso49873875e9.1
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041315;
 x=1767646115; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=Gf0RNpyCszuAbJNVyGqtHh6Bvg8W2zaPxacIHSSN7btNJ3a+yvFn+3Q0UktLWvsWNx
 8F9aF4ul/YBgtm0Q5NTs1ahckg3zY5rT3RQ2Anb7Xdnex/Rr9yCkMPHFeIRnPyM4UVcY
 lN+TCs0AFdO+6v3TXRif33bEklhiVXglXhF+YqsXEkliUM82A+XdtSKCvZ4Z3/y/yL/j
 q0MiWsLS5HuXgCmJyYSlKQgqCQSBT6wjX7SMallL4Skvmr5zI/vZaXuoIqtcoskaUHyx
 KMgpzSwyZgiOje81pCSCTUFs1wLq8CuerZpffYyuhz87xpQTHYd3VCf+PUeKQ3pCsoee
 icYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041315; x=1767646115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=WQH0qS0k3tUV9+3EJQQB7mcnUsPIMeZdolM8SXzFbG35rWAf2pnF3H4eXpTaYQhNRL
 KwKUBj4sJp1we9EbK8kWje9Gf5eieoZvPeQan40AhYAUifmPH4CDMWhf9mAUci/bQ/2l
 0n5FRR2FPdE8clH1v9yiFERsBO2zWDU6pu22vuuKenyIW7ZWX6HSgETYoHFLnFyMiCU0
 xVyc5un9QGG90V+13xlcrM4m1GUd3bD7yTbeRevkm6RLWa+HTJWhO7stGs8nQR0XNpDL
 DnvlUUTpg0i/u6B6kWdQ5vsEMZD/wVTK7y5ou8AAMJ6w4fh8Zu542489PIy0ig9Fxupk
 jKSQ==
X-Gm-Message-State: AOJu0YxE6t5s6FWsyWqHiTMCKyRcQjxPs7ePgMYWribwEbU20TnykqFK
 ywxbubzZYjT7q80acdHMWztPRGmMgRkN+jUXpCzxdaPSdZWaKaFgmbjWVGWaUxrejTJ2qK9VlL4
 j8bMoppc=
X-Gm-Gg: AY/fxX5yBDjulMz18DSiol7BdNWVgTfvB4IVPCD3SJsPFQln1Oe6NDCIruDQyQLQx72
 Nj2CJriiRsDEOGYvxX/Uqwf4RiA2fk5rTdYmMyRUYmHeY6t1KoRIJx9J6CwfaN6TX81rk9N4lcS
 RnCNsZJnh6u/2gSXiWivmTop6/PWotiwTX1NUZYaQT/Tzdep0zUnFnX+QnFiXDPxQXat0XFkXa5
 8vDPdS281EbvBrneYeBlZQhQm0KjRiS305D024pFTTE2u4hUP6zj1AfphpEeBOaSoGxBKwVG3OJ
 t4Nnujd9nfpJQCU9QGbQ8Fs6H1mKAtfW/qurQSG+ng3We7JBXadA/zYbtBfDYo8nx5c8LtDi3Oj
 KqwExG0hfCxps0E170KZq3djXtN10gEfgAXyy8WICIzQMkMmfyivtL2j1CaUZCh9Ncv8hjG+5g5
 K2pvX6DXygoGsgQ6buacUTxonAyS0AzTZuLIGLyu2AkEhh6DLpPQ==
X-Google-Smtp-Source: AGHT+IFoJhxwz4iQt8X9H6HTbgIkdnFcIEes2OhLdXcASCfNGX75sPmnjM5tgnECJ/Zlg4ZNn9es4g==
X-Received: by 2002:a05:6000:2389:b0:430:fe6c:b1aa with SMTP id
 ffacd0b85a97d-432448c9ddemr45422190f8f.26.1767041315018; 
 Mon, 29 Dec 2025 12:48:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 05/18] telemetry: check for path overflow
Date: Mon, 29 Dec 2025 11:38:03 -0800
Message-ID: <20251229204818.61231-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

The unix domain socket path is limited, check for overflow.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/telemetry_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..1d73282ba8 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -102,14 +102,17 @@ register_client(const char *cmd __rte_unused, const char *params,
 		return -1;
 	}
 	*strchr(data, '\"') = 0;
+	addrs.sun_family = AF_UNIX;
+	if (strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path)) >= sizeof(addrs.sun_path)) {
+		fprintf(stderr, "Client path too long\n");
+		return -1;
+	}
 
 	fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (fd < 0) {
 		perror("Failed to open socket");
 		return -1;
 	}
-	addrs.sun_family = AF_UNIX;
-	strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&addrs, sizeof(addrs)) == -1) {
 		perror("\nClient connection error\n");
-- 
2.51.0

