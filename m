Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D400C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:20:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5847A40B90;
	Sun,  2 Aug 2026 20:19:07 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8AD4A40687
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:58 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so1332947a12.0
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694738;
 x=1786299538; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s5a9NoyX7HIxiwzn2ZuoCFOHeF4KaOaLjkbTi52FQh0=;
 b=Bt01G1P4szAhOiHe0UVLMvhJi1dtbos2E8fra5XMrn8Puo7j/uwc4fZuHeNb/wLQbe
 eB44JYEPTYWRqsAA50HfnT2zY0AazyoWdM+K0VtsQkcAiI4uRCQ+7kQ2hraCX+TPSms9
 vgIUOuhs9jWzzyC2pC23354oaSWCR3PDyEU7nHaK1luAHO2bcFaECtH+ElV3CK/wukd+
 7cTvoCljGgMp8prbPrx4Gm+9FUS4A8BXOU3C33482aRGVS36hGAZd5KDmgOGtTOf1ekk
 PKvyeHTcIaaa6u9+6mJgUVSv6kImMfBUAO8+y5GbNlCD273ws5ji3AsPPMue23y9lAdG
 Xg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694738; x=1786299538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s5a9NoyX7HIxiwzn2ZuoCFOHeF4KaOaLjkbTi52FQh0=;
 b=Mt0HoHZrjSzXkX8Klc1yy2GbIG+5om3nOFBGbbLg8tV/XgemQNXXESHRl4sKWqVJnH
 CaO8cnh8r0/+XG0Odk+bPklJzfc7C6lROC7F77QkFub6HnXXwdk/M/CBLTDZds4VZsoQ
 PH0s9R3RcCwXGYVUQOHhit3Go71gYIMEZyQpFO1NNrE65JVapcvGKjKoYeb/QELazs7k
 IcsYVRzluTqcBbv8Ln9cNk1Yt3u+sq2iAQx+42AYfUahDZVfsJUPUTz3LIXMtPRIdLOV
 nvVOV4aYJ6iwjS3DeXd+BBpR8E6IRu+Olo/T7x/yb+r5uwt1RrXlXXebhyxUB2F/m0Uc
 XA5Q==
X-Gm-Message-State: AOJu0Yy1aCK93ZTtKz7Y9zjyeiXwgCnxdnLyyl0NSlVqXjxSJQeYvnns
 uP4JkCyvo8U07HZ0EAJ4EW+UEXle/tyGUNO/KA9ZfKAG2tgSgK62MAQumkaThYgjo1PIUduQYUc
 xkR8P
X-Gm-Gg: AR+sD10H0SL9yUiUxoIIjBhTf/g4LpfFcL8myOzzQ2aVytg9y+6wwL4N4MSOC0FP4iR
 +wyX7NllkpCEfLtAcBpxa23hDnIAx4WrYF3uh/6r3K6w4A/EhJ8fUtCyvjQU5qJzDVqWpdx0koW
 gFH9X8g02hFmCK5mPPgs6HTovJG5e7ap3f/RgS4pv4VzoH3Jqyku7pFGM9M4fsEMZ5hA4Mfekor
 WtauB+6u7abUlEtC7oHf+sTGN4+7NfyoVaJr92nkvfJtCVTMtiScU5rjXeL1ftVn/kGI/Ecv5xo
 3n7sAhJPq7BzkarTmK0z6HW7qBz4enmdVw9WwkNuUpvsOVqS4TjPdt0phlZahYmkNNNTSnqhRPS
 4pvl7/vMljG7UJTEQt3uUzG2MSmzbKitClcAM+9FdKUja09fkqxQ5eXWrdPN5tyAQPciCcJvh+1
 QEVyZKp0ajWXPyR29Hog90slr49LJnPCbCmOrw6X1ThpYVWtnh3+DAXhVOWw3eXELNh2qJO5mHP
 rBse2N2csT1KAMpgqm/y7JyUj4=
X-Received: by 2002:a05:6a21:a38c:b0:3bf:a489:1483 with SMTP id
 adf61e73a8af0-3c92a7b05b2mr7665905637.33.1785694737687; 
 Sun, 02 Aug 2026 11:18:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 18/21] net/sfc: include rte_flow
Date: Sun,  2 Aug 2026 11:15:23 -0700
Message-ID: <20260802181835.476887-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

This driver was depending on rte_ethdev.h doing inclusion
of rte_flow.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sfc/sfc_dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/sfc/sfc_dp.c b/drivers/net/sfc/sfc_dp.c
index 7e2a20e4dc..c867c2c2ff 100644
--- a/drivers/net/sfc/sfc_dp.c
+++ b/drivers/net/sfc/sfc_dp.c
@@ -15,6 +15,7 @@
 #include <rte_ethdev.h>
 #include <rte_log.h>
 #include <rte_mbuf_dyn.h>
+#include <rte_flow.h>
 
 #include "efx.h"
 
-- 
2.53.0

