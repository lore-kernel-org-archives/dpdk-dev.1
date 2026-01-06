Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735B0CE9D63
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:39:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32D8140C35;
	Tue,  6 Jan 2026 16:39:06 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 861E840B8D
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:39:01 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso14077815e9.1
 for <dev@dpdk.org>; Tue, 06 Jan 2026 07:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1767713941; x=1768318741; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze9ageluBUa5LL0gOdxGYjPxZevTRcErGk/hvG4DLbw=;
 b=jR9a1CrN0Pg/m4raqgTB1H6r/32OzWntXXmsuNdYnyWHjK0wV7WgcquS6yNC9e6bpU
 X4+8f2QaUjNLAHlNqnevS5EMT8KAo27wKiqmnYdnzzZU8GEXzIRDG8kFfgiFavBLkaR3
 TopNC/9+HPvHWveIefmxuigLujjgXWmkZ7ar4y8Sp36ycx0ITQ/6j9VdXpxnMIq470LT
 9L22HsXfiemds7N3rUVVyxoVlIrKSn5qhkSRTTkWO72DZdjHTvRLyc6fz0jKr7Z03Opr
 vxAz5X0zWUm8k14mhMsVHCGAkWnFQNjdoomfPI3By8qR6idU1Hcs0lF+SOklp8dn2gNg
 M3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767713941; x=1768318741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ze9ageluBUa5LL0gOdxGYjPxZevTRcErGk/hvG4DLbw=;
 b=aFN4jicL5siXGFUOb20h56MY02q84nh1TTzvHfqrTWK5g6Fvn/9p6CzDiT1SL4+diK
 K7w7ejpqt9+p6QeVAI9Ctqy9h7YwECtUnVViNB6UP5yuN1N50WFaAZEob2VXBu/snS2/
 9fi7QnoHpikZ2oOxdms2AB/Ku+vEXdFQpcNNIsRws0pMO93aifKBI8Vkisy1ApT9SW9x
 25qt1ZwlzeO5Uc0feM0EK/NbwVog02ILg4xldA/By+ZqGqVWTqMItHSQ5x/FVfVAz6rA
 +ahjY9IhoNjXONKZIy2Fhm/3RDlaEyje/CmSJcwv7Dj+LtVNVsidzuUP2kdKWGxmpp0S
 /G8g==
X-Gm-Message-State: AOJu0YwN0cU3ocxa1G78cZ+AoWzo5ig5xsKZM5LRZSXFq0kMQI38YgEM
 eee5o8WjYSjUeGU8754T9mjwt+wgo8enM3YXDXSEvAbFdODVUAhpoIbB5wtsf3PQoRAjATVBp1s
 NiCaT
X-Gm-Gg: AY/fxX5w9WR7k+dv4DR/akHZBaWmn+DcnJxpBtThgcYbc1dCwbpvF2wvq5GtU0plcfj
 1NSfy2hXIGbPhRt0Rit7MVnu5RY7J1d9awujEWgybPhLtVkCUKs6K3FL2bb115pJxmUNe7OrC8S
 rxPMeeI86OeMtZIlQgxtfyfkGFYH0jfSqIN3o1YI9EvUQeDu76sDj5gaqSJ3ALbtrXBfIKRk5Pq
 Hc2P+93ksqAtTCsNsEV1iPW9UxSHRCKa80dHCcsFLsoFThm1bwJvo47MWpVQMewlfI+hxAqoqyw
 mKAqrLeLHB4SfgvyCOoKCx5X6liHy3UZhz0dNxwWfaHZjoxbkTbaZsIpdp/keKq2vDw58DDSbrJ
 zNKy10bkctta43delHMS9SVs2U0TBxYa5O92hKD89y2A+UN4yPTE0/6ymv9J3b6ZplpB3xHNMlM
 c2xtorg9eiuwKkH2fCTYfsIh67X73OIUajvfDVxFdaH2ycnr8msl8fh7tl
X-Google-Smtp-Source: AGHT+IGoy8GaLyFyoRKvdIzSflsJOyacF5bNKcGJNikaw2Jx9esTdSx8SZNd2B9oDmHhjAMH7lOcnw==
X-Received: by 2002:a05:600c:8b55:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47d7f41bab6mr35886225e9.11.1767713940884; 
 Tue, 06 Jan 2026 07:39:00 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fad882asm20975265e9.1.2026.01.06.07.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:39:00 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v2 7/7] cmdline: include stddef.h before defining offsetof
Date: Tue,  6 Jan 2026 16:38:37 +0100
Message-ID: <20260106153838.398033-8-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260106153838.398033-1-sismis@dyna-nic.com>
References: <20260106153838.398033-1-sismis@dyna-nic.com>
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

Include <stddef.h> at the top of cmdline_parse.h before the
fallback offsetof macro definition. This prevents macro
redefinition warnings when building with MSVC which uses /WX
(warnings as errors).

The standard header provides offsetof on all platforms, and
including it first ensures the fallback is only used when truly
needed.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 lib/cmdline/cmdline_parse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cmdline/cmdline_parse.h b/lib/cmdline/cmdline_parse.h
index d9a7d86256..c4131e4af5 100644
--- a/lib/cmdline/cmdline_parse.h
+++ b/lib/cmdline/cmdline_parse.h
@@ -7,6 +7,8 @@
 #ifndef _CMDLINE_PARSE_H_
 #define _CMDLINE_PARSE_H_
 
+#include <stddef.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.43.7

