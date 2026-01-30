Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF1FE6BF39
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 20:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A1F44064C;
	Fri, 30 Jan 2026 21:23:37 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id DCAC340431
 for <dev@dpdk.org>; Fri, 30 Jan 2026 21:23:35 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so20517965e9.3
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769804615;
 x=1770409415; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGpoWJrGV1cT1De5lavmDVAKnYp5lIkjjP88f4CDSf4=;
 b=3NzRkquqCzzXf6WNbscYf49IXXr9hnkqdY55WSP2ZsrbkU8gWel6VsT2rLlTXNGwdF
 L7bzLWO4Cvt2wRF+f1ELCZSMMs+gRUSoSAH8gBrQc6rryFrFEPE+/mzMrM9+0QZ1z3tk
 p7ChlOb+TxeNRoPo19ki7RkUsW7h8FUCj/rKn7Rk7qZW7sdW+dhIoN1ZMfv188M2KOwK
 4fMrFJhcKpfLJdzmbFfhaKYW2SxumTRzXUuxvZrAcReepFQZSAb7/ZUaT7VARPHCSDzz
 6mf+lp4zmAjwbVUY+YXjotG1+npRWlZagBwPhVABemXPAJx8XhXQYIs142wP17UUxU4u
 SCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769804615; x=1770409415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HGpoWJrGV1cT1De5lavmDVAKnYp5lIkjjP88f4CDSf4=;
 b=Ftj3kNnjSIPXiv0KIi51d4Qj9dUwMErYEoPCKn2dRKgHEXTiYPI98bjgFao/DnJrH8
 syGjtNefBryEaD9P5KWaGlyBPaS+ZOLtW9S/K62Wspfq3BpLfQDECfYTmFoFDxifovue
 9Eh/iSTlcF1viYZL1m0OBNOO3k2jbOvw8mN2OwWVpCygykJA9P3M25KQCjdwEgJxMKK2
 bLa/PIKm4PskRhBmgVL3Whke3coawYY+6ErSZ8sTONpOuL09BDxWgmkN46h0FCwQDeaD
 61A6IiufeHoXqxfeLMaaIbcor1FVOmzkpGy29dxYYOQKTKQkXLideYSzgHZNJsx/OtWh
 bTuA==
X-Gm-Message-State: AOJu0YwRZ87EPg0Dalj8A3BZxQ8Ek4sS6Ti/poCubagZ1RnXtlejrAt0
 7vkUduonXA8JwdsM90PjQ0R1oR4MuYqSIFSWNhP3W8JmTT/gk7foFcQ++hvXrXIY1EjL+jgEvJX
 wtz3O
X-Gm-Gg: AZuq6aIs4vdhofmwXzJyrJLIvOhSGoUYSYatgPNYEZ82/HFf6IseYX/e7OtDnPSMPlz
 corxhjFK+hxYeqmmejJ5Wu/dNbx5FYzN5ckkOTspiAtmocaO3CS2sEPp5RK1o7XjxXLWZ+ILecr
 e1OLZPzBZQUUmC4JYQxkjWc4o1oA6nyOA/PFb/XUyKK0JeBRqejXhCx0jlM7MjhPttorcbBRzqp
 yAAd80mFO0Odjjs1d33qdPXwZaXoCr2MucftPSveNMMbAxMqu/jXWtpPkTj149DsPHL/9z2f8il
 eH4apcp2JKeRISyvPltxJWeOPoXxs93+pADuVG/3sUayHSPnkk0UM3vYOmgtA44ZFfYCKJ3JIai
 PD3XOIkE6n7lFnBfsW+741qCM2IOoNPkN4pwR0Acpltg6wSFH8xvfpQ4KSo3nySKvKJNiAb4SUB
 t97hS5AL8t0nEKu+MkouBqlZQES+juCYM/A+IDheG+lhe/2dN2Jg==
X-Received: by 2002:a05:600c:1f14:b0:47e:e807:a05a with SMTP id
 5b1f17b1804b1-482db4a6193mr55545155e9.33.1769804615517; 
 Fri, 30 Jan 2026 12:23:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04c13a2sm23799065e9.5.2026.01.30.12.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 12:23:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 3/7] hash: remove spurious warnings in CRC32 init
Date: Fri, 30 Jan 2026 12:21:53 -0800
Message-ID: <20260130202324.37485-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130202324.37485-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260130202324.37485-1-stephen@networkplumber.org>
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

The warnings in rte_hash_crc_set_alg() were misleading - they fired
when requesting a valid algorithm that would actually be used.
For example, requesting CRC32_SSE42 would trigger a warning even
though SSE4.2 instructions would be used successfully.

Remove the spurious warnings and only warn when the requested
algorithm is truly unavailable and falling back to software CRC.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_hash_crc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/hash/rte_hash_crc.c b/lib/hash/rte_hash_crc.c
index 9fe90d6425..2e552331f5 100644
--- a/lib/hash/rte_hash_crc.c
+++ b/lib/hash/rte_hash_crc.c
@@ -38,9 +38,6 @@ rte_hash_crc_set_alg(uint8_t alg)
 		return;
 
 #if defined RTE_ARCH_X86
-	if (!(alg & CRC32_SSE42_x64))
-		HASH_CRC_LOG(WARNING,
-			"Unsupported CRC32 algorithm requested using CRC32_x64/CRC32_SSE42");
 	if (!rte_cpu_get_flag_enabled(RTE_CPUFLAG_EM64T) || alg == CRC32_SSE42)
 		rte_hash_crc32_alg = CRC32_SSE42;
 	else
@@ -48,16 +45,13 @@ rte_hash_crc_set_alg(uint8_t alg)
 #endif
 
 #if defined RTE_ARCH_ARM64
-	if (!(alg & CRC32_ARM64))
-		HASH_CRC_LOG(WARNING,
-			"Unsupported CRC32 algorithm requested using CRC32_ARM64");
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_CRC32))
 		rte_hash_crc32_alg = CRC32_ARM64;
 #endif
 
 	if (rte_hash_crc32_alg == CRC32_SW)
 		HASH_CRC_LOG(WARNING,
-			"Unsupported CRC32 algorithm requested using CRC32_SW");
+			"Unsupported CRC32 algorithm requested, using CRC32_SW");
 }
 
 /* Setting the best available algorithm */
-- 
2.51.0

