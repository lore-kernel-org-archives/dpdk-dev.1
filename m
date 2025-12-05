Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E43D374A8
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 21:36:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA7DD40268;
	Fri,  5 Dec 2025 22:36:54 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 938094025F
 for <dev@dpdk.org>; Fri,  5 Dec 2025 22:36:53 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42e2e2eccd2so1703760f8f.1
 for <dev@dpdk.org>; Fri, 05 Dec 2025 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764970613;
 x=1765575413; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFCg8wxlEEfzkYjcYPgS+q/sSGWMsmSypDDu1Dl8swY=;
 b=mxFLkcI/Zub3ZRtr4XfcaFRmuhZ5n8e71NzQatAv8HoOW3BXouB1hVyIVg5VGR5IU4
 gJccCSgwE9a8dNMBUIilKpRoVKmc77Oxm3SktR6LR8Z8Y+djA35UuL7lYHc2JrIWvZ6v
 1dkZI9A60ZEhMWjnBULmbBO73oq2R7v/Umn4Zk5sbC7l+6QXBhchNL0uM7s/2BT2zSdj
 8si4Thu8pBUkVA/9mZGsb4D8EBWskDbljIeVQbjUsbmHPdhu2h4l0JdcK/BS8Jhagwch
 2CcW/qk/dWNyULvfuJnCTOzgPu5961vEe6ey1OUhgWUzkHx3UEJnBovMdHPpoOVMQlc4
 h07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764970613; x=1765575413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mFCg8wxlEEfzkYjcYPgS+q/sSGWMsmSypDDu1Dl8swY=;
 b=Cu78SWyjUZKd0WEKh79LpXM7VPLdEiCj77fJnaIJRnFL4aLGWWC0RfZlzzxZIFcxg/
 Ck4QbrtSYmN7yU8WtCw6Gq2BRpAtaL4UMTI53Zj7G++/lfseTOHbWSDZCjMhcvgipdRY
 me3gTXVSxa6NOiRZ1r6WHedqJMjmUPR6tmigZgHwZOzxtAZfM9cNOAX3NWD4TRzdXbQn
 gCt6XkBM/BNOqgzm+vvQTQDE2/evUoVQoUj2SOkPNqVpMvl4zsBtbZgL4DYXHoh13xle
 o7PjTqiTTF21k5yvhjEl2DlQ0Vm6rp8kvraaF9J8YVjRBw2sz7pvSWkCL+LWthewzW88
 ipuA==
X-Gm-Message-State: AOJu0YxYmBbLk0oUy3N5df63VlaIYWOAb48oCSjv3a0TsxnX2sSqJdqs
 mb+/w68ePCttfbbiHghe7VuWnoOvj4+oGntFtcjpGiJjixsg/6M46FQh4vzux8jxFtqFndy2GP0
 Ked3p
X-Gm-Gg: ASbGnct3HfieQAZp3ShRsfRf4ednwG1CFbJU69dx2h46IDpJ2Jkt+nRlMn3Geuy8Cpx
 USgKO1UYM2XP9xJeZULbiRgmFXbMr0GKfWFoyeipPvLslvqyo+eWQ5v0ntAw7+PIpn41/ym6UAq
 lzQXnqioq8UAx5tQ6i7T3xwZsLhR/FJIG6pytaPTMrOxzYtccKhl5rntOWcHJNoyGhg41VE01SS
 JhRMW3Io+ZjvLtMfPdI9b8oCVlQ9wKnSL9yBzma3aX30tTq5Eebw9MiXwLNluYld7TRB6PU0YYr
 CCDaTWmNS9uFo9FkY3QKiaabujewSO3oF3iy2fd7FSMAASstW317X188Vr9xK2aAyNA0wxGpEAt
 d665GkjRiRnhqxHXeLXtmncshsO14Bld4FqXmx7gn891vSJBwsEN0MQbgChs06V5GaLkm7YTqQH
 NxcoB2MobujAWPidO3R9G5/Kua2Mz6cfrWeanQ6YFGAqZl+ITEuszsY8F/zr9y
X-Google-Smtp-Source: AGHT+IEelreqHLEnWlrSw8IQl1cwWg6hCtEmVDWtgmZQrvj7ZZeD/817Pl0NggHhj8YNDXg3yfQCag==
X-Received: by 2002:a05:6000:290f:b0:42b:5406:f289 with SMTP id
 ffacd0b85a97d-42f89f1704dmr545955f8f.3.1764970613025; 
 Fri, 05 Dec 2025 13:36:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d330b20sm10585011f8f.29.2025.12.05.13.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 13:36:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2] test: skip hash tests from other CPU
Date: Fri,  5 Dec 2025 13:36:46 -0800
Message-ID: <20251205213646.293166-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205002536.192437-1-stephen@networkplumber.org>
References: <20251205002536.192437-1-stephen@networkplumber.org>
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

When running hash tests there are lots of warnings about
unsupported CRC32 algorithm requested. This because on x86
it is requesting ARM algorithm and vice/versa. The fallback
is already tested elsewhere, so can be skipped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_hash.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..35684b3849 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -191,6 +191,7 @@ static struct rte_hash_parameters ut_params = {
 static int
 test_crc32_hash_alg_equiv(void)
 {
+#if defined(RTE_ARCH_ARM64) || defined(RTE_ARCH_X86)
 	uint32_t hash_val;
 	uint32_t init_val;
 	uint64_t data64[CRC32_DWORDS];
@@ -211,6 +212,7 @@ test_crc32_hash_alg_equiv(void)
 		rte_hash_crc_set_alg(CRC32_SW);
 		hash_val = rte_hash_crc(data64, data_len, init_val);
 
+#ifdef RTE_ARCH_X86
 		/* Check against 4-byte-operand sse4.2 CRC32 if available */
 		rte_hash_crc_set_alg(CRC32_SSE42);
 		if (hash_val != rte_hash_crc(data64, data_len, init_val)) {
@@ -224,13 +226,14 @@ test_crc32_hash_alg_equiv(void)
 			printf("Failed checking CRC32_SW against CRC32_SSE42_x64\n");
 			break;
 		}
-
+#elif defined(RTE_ARCH_ARM64)
 		/* Check against 8-byte-operand ARM64 CRC32 if available */
 		rte_hash_crc_set_alg(CRC32_ARM64);
 		if (hash_val != rte_hash_crc(data64, data_len, init_val)) {
 			printf("Failed checking CRC32_SW against CRC32_ARM64\n");
 			break;
 		}
+#endif
 	}
 
 	/* Resetting to best available algorithm */
@@ -245,6 +248,10 @@ test_crc32_hash_alg_equiv(void)
 				((j+1) % 16 == 0 || j == data_len - 1) ? '\n' : ' ');
 
 	return -1;
+#else
+	/* No alternate algorithms on this platform */
+	return 0;
+#endif
 }
 
 /*
-- 
2.51.0

