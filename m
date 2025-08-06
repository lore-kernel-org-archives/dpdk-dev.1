Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868C4C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 16:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80E3D40291;
	Wed,  6 Aug 2025 18:41:59 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 57929400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 18:41:58 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3b7823559a5so11050f8f.0
 for <dev@dpdk.org>; Wed, 06 Aug 2025 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754498518;
 x=1755103318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vUFAS+Msn7NdpHXzqeEJCL0PS9p7fBlddYUBVauGr0c=;
 b=bYviRgThk9csk627zuEvOVq8CL4AaUrTWBYcOaQ+DSkdRvHmDUnlAzk5t8oks3WZan
 alnjYdvd/wL4ksMgxeM2WP28iNvYtx2Y6GGF+hpkKYk+3f1oU5rwHzRMrcuUnOXglvwH
 G1I6zoqjivgFTLR0C2VmPSxh9nCFWTBoOVeLp0G5QfB7Dn1Xq+4sZFsJekiBjqwO+WLB
 wEcHXcAD4tH8VGdCpylmZ9zYaSVsMPalshvVpS58oHUUypNbMAeed+ZH8Ja3zxUw//4S
 caaWLvlDybzhF8gNzGo4dtmKAZe9TYBbbpXmk0sE2dViQhiP5LfPV74b6TpLbXEoEpKx
 zClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754498518; x=1755103318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vUFAS+Msn7NdpHXzqeEJCL0PS9p7fBlddYUBVauGr0c=;
 b=tos/8ZBhy8YkzkiFBEK4m0rBgVQF688caS1HhfSV79LFxea8mpPKFU5nSomZY8uAG0
 KjVqlrlI6MUazzjrD8jizvyA2lnttF+WZRSCC7PyVKbFdNm95vxXmW81WGSGiFmOVw5S
 HgnUrYPniYAtY05ZcmPRrdOqhzuZYPIVyy1xz6+orRu6Wzk0saFm2ksbTz7PrzSnbnxu
 XIfBbkEYrHLfDmBToL8bvZY48yHohshAmB3ejn3j7r+uSOCjVANhwFEqJRCHF/cCcbdY
 ReAgtRHDrvrWqYrvrOwa2BHWcjuJlD2yRmJgpPHqgYIBSsBjDzvYC9RaAKpkjxEnI8+L
 vHsg==
X-Gm-Message-State: AOJu0YzuWTW1KpDImyBJgIt3Iwffw9nx1e4BAQeDbMfUizRq2Tv86N7/
 bI8JczU09aHH89uSycAbqGvqc87Lwpm9gtEoMw/LSpgusHh95jMF3Wu8dNyEk7lCKxGmtYNUWOb
 n5DrS
X-Gm-Gg: ASbGnctnORIKAa4pYrfrIZuQt+pTPwczK2qh22Ay7DiAlT4cTnSzjMKKAMJkibU7ANK
 ZJdNj7ycuSIPLYgH14qAdblF2DOD17cGeOyiFGaE2fcCffbBH2dH9X/yXU47xKciQbXYPyeu41T
 WoiMdC2vTAw+K4h9+WTRqG9/9BKuSRWVWgfJRJJ4Tzn9wbGTvojT7csUOYPSbyB619iRl1n8y+f
 lwmUN751cKQJt8gzfczX+lnnUav5OcBus8Qb9b38Omv9wi0IrXk9JP+9dwJ/MlvNk08qnZvqbwt
 oY2NaSzLkWUr53YS+5IZA3QiJCP6AF4RzBU8/Jxiz8XlHQR21wgmIqEy36LmqcT6TiTq7qCpDkB
 M4Tku0PABQOeSbg3nmIGuavWsfAa6pGWIrGLoS+W987+dnkuLE53idcssO9p1ynIzDPrN3tXcGS
 0peDO7Ol8=
X-Google-Smtp-Source: AGHT+IHnySyK0e+4P0vw5x1EfaYRxFVI+3i6IQO5SYB9pQmL/ZlEQjc7vOD5FOhSstQ+2IGixYz2IA==
X-Received: by 2002:a05:6000:2388:b0:3b7:9c79:32ac with SMTP id
 ffacd0b85a97d-3b8f42208admr2854212f8f.52.1754498517744; 
 Wed, 06 Aug 2025 09:41:57 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458bd5a1148sm105480635e9.0.2025.08.06.09.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 09:41:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH] test: allow latencystat of zero
Date: Wed,  6 Aug 2025 09:41:35 -0700
Message-ID: <20250806164152.187460-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

When test is running on emulated hardware, the performance counters
(TSC) maybe emulated and return the same value. So allow a
latency of zero, even though it should not happen IRL.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_latencystats.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/app/test/test_latencystats.c b/app/test/test_latencystats.c
index 676a99d385..ad0237ce78 100644
--- a/app/test/test_latencystats.c
+++ b/app/test/test_latencystats.c
@@ -192,9 +192,7 @@ static int test_latency_packet_forward(void)
 	}
 
 	TEST_ASSERT(values[4].value > 0, "No samples taken");
-	TEST_ASSERT(values[0].value > 0, "Min latency should not be zero");
-	TEST_ASSERT(values[1].value > 0, "Avg latency should not be zero");
-	TEST_ASSERT(values[2].value > 0, "Max latency should not be zero");
+
 	TEST_ASSERT(values[0].value < values[1].value, "Min latency > Avg latency");
 	TEST_ASSERT(values[0].value < values[2].value, "Min latency > Max latency");
 	TEST_ASSERT(values[1].value < values[2].value, "Avg latency > Max latency");
-- 
2.47.2

