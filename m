Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23308D2CDF2
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 00:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB6404025F;
	Fri,  5 Dec 2025 01:25:47 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 3528240156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 01:25:46 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-42e2e445dbbso785884f8f.2
 for <dev@dpdk.org>; Thu, 04 Dec 2025 16:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764894345;
 x=1765499145; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c2zhGgkye6vHYK4H7fXfpjc794u8V+cot8kO1K7cF5M=;
 b=QKSIVeJYZPVTJH/JYZPl76SxDKQwle23J3tZIjD/DGX7yrwp8Ttyp8d9ucQHcCA84b
 jgfpq7tMiyeShpcGeLCLIzJ+MHy9EaAhwabxFcJ8d0im9P/sFgVa/RA3PgxUqfT3i9w8
 jdKqiPGI8zyyrj8ahgDiUbCn7H8YKircsjsB5PIXz6yYlBFWOXTzPcCCqknUzgdjlm8v
 dvV3ah0wVwaK7bDilR0tZsIypdN7de65xor6H2rUoUkQMF1sBK60Fha5KVEb1PoJpy/C
 pr8YPt1+xD1us1D0Sk+4+R2PNBo+0BOdbvCJK1zPeNYoLmdBhT4nqkyntHwDOeH6PoLi
 UY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764894345; x=1765499145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2zhGgkye6vHYK4H7fXfpjc794u8V+cot8kO1K7cF5M=;
 b=vNr940aSkWI0vFwOjB+m89r93mMUHzq+h7fHzv6WtG8JsCXgNiwlM7UxqN+v6EFgUe
 TEu0XPCDmR8Dl5ipJB0NBKiifmjCCfsA8/5prtQoOSDiiee+++dBgaC7bSm27uY2nB0D
 /7mSOgffS7+Zoi/Lb+9O7MDDbhIOYP554Ny2DVQ5GRZHhfr8f6Ldg2vppIlZ2nb6Y+NQ
 zySsB96KUWZw6bpICuwVJUZZGVGdAgslt8dl7wmdWqYCJ5MysoBu+adIa4Q2IRhCZxEc
 M1xS/VQui7Z2bVD3U0ZXBsWGBRsNo3CaW3QSOj5e/tyXX0FRfc7p4fwWwt2pX54uY5xy
 2q6A==
X-Gm-Message-State: AOJu0YwIJ0iC6MIuGt1kcidbJEffuzJILEjbveiNYnlUvpCeAhziDt5+
 ljYvKv4KeUNVia+kr9VwZCqjBA/fi6jkQt2D+H55vMgt8l5v1iyNC7uYqeb2WhqhpMLLS0Y6zJa
 elB72
X-Gm-Gg: ASbGncuLiEYOl98/r/DqoU/2+A/SVhe7XlPyIut5CwaDh61AtuF4huQuasawcB3T5X0
 jRCu7LwowXOYOI3fPlEVO3SCXSCGwOpahwwT9HUpxiizuBjcMj6oq8qpV8tiVXU/cTxsP0lpgYT
 XnA6XIA7zeLF0Sed+wuMdjSJBmNufj1Cvgqw3ukSp0DBPNvrLsE+Iz2pLNlW2p/eUdZZ/WLvz1F
 h8nxIzGw82Myt+NQKDxCSp3mCoKGLBo/hR/805EAx7lJWwNZu6RV9Gu5yjE/E99ZTkL3Rvk5Cju
 I9nocecIcSHJeMzzxOdv+3wr37IoVBuFX11NvlOVP3SHxBplPKuzokwmdhdOtmWDhgP2dhz1Ymk
 U4tDbYVCOZsKVnNV4ASgQVUQQ6gnB7Kygx9qr0wOdSflMkAq26r0usNUhSetWDwcVgfg/yFzm3o
 uiQ20HTUWekqd264lcvYan6TlZS/JhX5gC/OKRYNmZ+6X59DYL6Q==
X-Google-Smtp-Source: AGHT+IGMMF4B2Ku6qs6oveONjTuplNxXayYRiTlZUhf4t40zq6aJwtj/Rq+y2ggOVULYHv+JQClg5Q==
X-Received: by 2002:a05:6000:230c:b0:429:c774:dc08 with SMTP id
 ffacd0b85a97d-42f731cab4bmr8343507f8f.53.1764894345358; 
 Thu, 04 Dec 2025 16:25:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d353f75sm5948759f8f.42.2025.12.04.16.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 16:25:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] test: skip hash tests from other CPU
Date: Thu,  4 Dec 2025 16:25:36 -0800
Message-ID: <20251205002536.192437-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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
 app/test/test_hash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 5791fd7f4c..a73f69a136 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -211,6 +211,7 @@ test_crc32_hash_alg_equiv(void)
 		rte_hash_crc_set_alg(CRC32_SW);
 		hash_val = rte_hash_crc(data64, data_len, init_val);
 
+#ifdef RTE_ARCH_X86
 		/* Check against 4-byte-operand sse4.2 CRC32 if available */
 		rte_hash_crc_set_alg(CRC32_SSE42);
 		if (hash_val != rte_hash_crc(data64, data_len, init_val)) {
@@ -224,13 +225,16 @@ test_crc32_hash_alg_equiv(void)
 			printf("Failed checking CRC32_SW against CRC32_SSE42_x64\n");
 			break;
 		}
+#endif
 
+#if defined(RTE_ARCH_ARM64) && defined(__ARM_FEATURE_CRC32)
 		/* Check against 8-byte-operand ARM64 CRC32 if available */
 		rte_hash_crc_set_alg(CRC32_ARM64);
 		if (hash_val != rte_hash_crc(data64, data_len, init_val)) {
 			printf("Failed checking CRC32_SW against CRC32_ARM64\n");
 			break;
 		}
+#endif
 	}
 
 	/* Resetting to best available algorithm */
-- 
2.51.0

