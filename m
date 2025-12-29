Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19809E92FDA
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13CB54065B;
	Mon, 29 Dec 2025 21:48:45 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 502494065A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:43 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so73722155e9.3
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041323;
 x=1767646123; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=2ebDYZTFjjTlSAdaYMswHBv6gjKqyI8CVkDM12DmBSf5hnOLvnsXl7RLfkbhSSjPYp
 2ZSYLkNZi5JBjO+UZLEFJw8KCa59De/756TaS3xWsJ85DjN4EI78zMndogIAsHELBfZD
 mOs0l9QAsMj8bExrIVCYcD+WgyCDNPLKJbzAy87320m19dh/ZaTkvZT4AKLwOugR6WSH
 U5csYkh0G86Ioayuehf1tYGmXdJ+d4/XnTyI0uZGVXnxf9nzkuOr+rfqTaq2NZKfdP5Z
 Ukdke1TxmFcK8dWZkY859SsmRBpUceBB9gsuiydUA92R1D7U6HQqTB0Iao7Ndi7i0Qbr
 CPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041323; x=1767646123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=fbtxYaNLIB0Hz5MVArtRY9/EyeslMF4fDmCocD5jL5JqHAARQiMVhHp0GKiPMG0FTQ
 2wf0BAO76OluoItbAL7Rclyhnc953uan3aFE6rZsq0r3hoiX2MWTecNSI+G0GokPsFEk
 lTXer/YiY+G6wWTFDF4r0wggGpqKjvl+HS2r5VPQ0kXEjznM804h7ewe69Q0uRmhruF3
 cWn/t940CuooObd2RryCh9Sp39oe/pirrwM22qb7CE1b0MuQToxwdBsOMjZ5emJntq1D
 +3ijEjrUWf441cK8cz9a9tf66wGnoouqHv3rlNdncOO7PJbSQ8MkpbXjZKodRoRXmnDp
 XLGQ==
X-Gm-Message-State: AOJu0YyyjBVEMOH7073udkvTWhNpn6LgfqozuJKi8vLeLFcqJZcwcXI/
 dNR289YR6YaQEZYDWJB4zUMdC3nI4hf/oVx/ZAzkGfKlNtd37QQKhP2Q/4NVQoec3IV3PWh12/U
 ZcVokvrM=
X-Gm-Gg: AY/fxX5uVWqN8WQNBll1ptQ5DEPlmTPf6yxxRYAAC3hAbSBMgdIInvt6pTzaJ7HQshT
 z9x7HP5hRnBERFKo75LzAcFURfE9FYlNz75tow7jIP64OJOWc250O0IBgTdZcySK5yJ3NO1rquT
 JAr0OvSt7/W6vYONJTbtt5soHwIxym3QFIPwVtefY4xVdg9pSxzrRRsqCodfy8ON/SCAsgzvFni
 KgUMEFudAkZRgxlmH90Xmg/hhrMDH7Oa1InZeD2r3E6pVCYGyHhAk4u9Bkm9mW/hrQ6ZT3r0KNp
 +KwJFMUZubofwY4TSObHJ7Fwk+j82aAKoUknEs/oAacYVDdS+kHXaUBHugVf84zKycaXioscmn9
 DBjeHi1qkw6WtuYdsfW8zNRuCKkGpYEJFh2r6WxWKTo+iARO50TvpXtxbIDCXNHInZtmwrRuBIA
 AUSPSnZ6dJqbfxvRjRUi5PnvBJYUAKOpZzcqgWRWrW7qV8b+fRSg==
X-Google-Smtp-Source: AGHT+IG6kj0GbZy29VOs7Nj8zgWSDVtttG3NdU6EHgVgZ6PwN4zl+X4/OtuYNmxa1CO1UIBRxixhlA==
X-Received: by 2002:a05:600c:314d:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-47d586e309dmr56526735e9.15.1767041322940; 
 Mon, 29 Dec 2025 12:48:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v9 09/18] eal: avoid format overflow when handling addresses
Date: Mon, 29 Dec 2025 11:38:07 -0800
Message-ID: <20251229204818.61231-10-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..2633857db5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,7 +1153,7 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
+#define ADDR_STR			20	/* 16 bytes 64 bit + 0x */
 
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
-- 
2.51.0

