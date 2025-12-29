Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10724E92FE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD463402B3;
	Mon, 29 Dec 2025 23:01:17 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 4801E4068E
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:01:16 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b79af62d36bso1609508366b.3
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045676;
 x=1767650476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=RS6kIMNw9q8M2BtBbQd6gNsWVDBRIfaDDa1KCFBd+GJQTmNeHWuFJy3XhSUHmhbgNX
 gtBkdP3EbiE2kEu0vIX862I5SId9ubeAIxwWySwJbfQ0X9aHBn4iKxCZVKYpjcQVV3zT
 1GwcdZ5IEfa7wMVWKY8BusA1lIAQMFgYdTbEnFwH2X6hRA7EjE4las5OiHEn1Sd5WNV1
 KgqLMN356/l8nPiUQDuyFyJaZKUtFlpXhifkbnwmI5SKpXEU1/XtfpoTla5NDI/T9qBi
 LjkohuCYKD4YvptuzaoD4QpjqGTV2ceTDxK5jRf60AXSH/1q9yD/kZNQfSLDwzuqxnq6
 3Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045676; x=1767650476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=RLqfQj9WV4Edfmpf2/Oz+SOYzC98wO7AP4x1eAvUWgZuuvETwdnO8/LPTDn14P94BE
 n3qWo79PWL0gP76pBNXfTQLiZOVC/XyJnW97toF0EI+NGlml9B5rwY2FYxndRNlebMn3
 G/zWEJp7NTQhhQ7e1VeSCDvFdGfoM28tbQ1UIdcga0DSYw85QQBq/gM/FPtUt4zXGIXs
 SC46j6v8KDMK1QOJjUBJM07utaV+9BiLMVejZY+OoGoOm6y8ct30jbW2/kkCF+FaPLBb
 U8Ql13dBhXo/g+wNoaZWu0IE8bT4mwxQ0vUv79vLzHXgYeMdrqSwGRL0gXBMHiGcZfD4
 76jg==
X-Gm-Message-State: AOJu0Yza1ZoIysRgwHR1b9dF22UND9+u60CljjOa+qg+bBx7eZVXTJtQ
 AjmbsX8Kwo2uJ8o8WnHJYwS2VmZsHeQthsztk68nluCO00m2xyTOS+y9t0/ArxTs+atvuwniZcD
 Q7AKo9oI=
X-Gm-Gg: AY/fxX4i3IZ8y7LfH9Fq/U77VLJ6SHe9NJkkafDE5TQahQ41pG2reU1cbOKvJHj2Qjo
 e074mC3Hye41WRRnHfq5XL1H91aofhn3HumLYxxqy6/OB7ehZ4RgQ2uH/OKB52KRXJZkMZUp3Rf
 i+HTAv1B/oes4WRlwi4zZnmrOcLER1LhS+UvulA/+jg/O+Qa41LOrefC/6/fcPnpIiMK5ag6+tN
 qPJOqODcksVmrNJ6qng+rcGNPsYCwOfA0Ta6q0bahEnDBgWrOdmAV8WS+pfhnnfSsfG1EWbNDWb
 YTnaUGT1tKTNST1s8eGr8KHMow9q54bZgfE2TMZcWecVhpw1aqxanNYv0xpHslny8M9Evr/dCYD
 8udOlyjmuDPuFRNuvMWcKCKZygz6rY58QK6bZadVZP1qdGzV5Tt4TeiHqZ8smw0CLn6gxDqL0i1
 E5wB08JuKFu3MrCsVDeiuIxbM1ijt4OjPvGb8I8sfaonbHY3957Q==
X-Google-Smtp-Source: AGHT+IFgVxTvh53cLikeF29DDg3FxfGPgaPMnDcQNramG+dymRHUUKED5j7F6VvIpZAeatljqs396A==
X-Received: by 2002:a17:907:6d22:b0:b73:5936:77fc with SMTP id
 a640c23a62f3a-b8036ecbad1mr3634458066b.13.1767045675773; 
 Mon, 29 Dec 2025 14:01:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:01:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 9/9] test: re-enable format-truncation warnings
Date: Mon, 29 Dec 2025 13:59:09 -0800
Message-ID: <20251229220053.21981-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229220053.21981-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
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

Tests should be built with warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..b00260c0e9 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -260,7 +260,6 @@ cflags += no_wvla_cflag
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
-        '-Wno-format-truncation',
 ]
 
 foreach arg: extra_flags
-- 
2.51.0

