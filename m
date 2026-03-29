Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1700CFF4923
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 23:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC8AC40663;
	Mon, 30 Mar 2026 01:24:34 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id ADFF940664
 for <dev@dpdk.org>; Mon, 30 Mar 2026 01:24:32 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so2562007a91.0
 for <dev@dpdk.org>; Sun, 29 Mar 2026 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774826672;
 x=1775431472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBrVX4V9Yngp+5zU0yFG84WdIaAcVAthcGk9e4y/GX8=;
 b=xTnB2Dpo3Na6RKPnCUjEAo3gq7pvaa/QkKGt2WYnh+QXHIIUSbEL/JfS7CfhrXXcul
 tuiS8KpHv95N+x/FTF7PTMsbfln7seP0U/IsW9LrcVde8bwOH0xjvoS3rV5ynF6cVc/u
 rVv57Nqb5WgDAQgLq3EttPSTJNXoI6ZQ21RZW7nC1avMCS4XW23vnYP8I+s7ryUU2f8M
 Lo8zJY8KZaIS3GhBTFCu7b92815wmDngBlgKRbKNfh9+fYaOd9wZpdI1fItrBg8a6ES8
 1i6zIOYG2cGCbCH8un4Mq2OyQ7ELz+krV5BhJJkIuLFdygXeGdwDsbZVyTXRj2ZgMhJ/
 VbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774826672; x=1775431472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OBrVX4V9Yngp+5zU0yFG84WdIaAcVAthcGk9e4y/GX8=;
 b=sXdXdx6RhbNSih2HJRMz/r60pZ6vwbLrt4WQWHAEksATucEoDKG07Mg32mHiEJDNCU
 tCZS2SpzG0M1Es+gbHpGaU3h3StP5nIZk/sePgAiKZaEL2NqZMu/7jh0Xu+BmAXLwahl
 cUQ+4OU27PiACQfaSJeUzC2QTn+1xZP2b8aIO9V8UJYR1F8aEd+WDtcaC6CNATTa/iIB
 svuayiWk+ylzhS/ts5d0RfjrRxkEibJeUsqfriAI0elsiE53nDFnxSQXVEJmtZLxArxJ
 Rz02dLzEA4ANbAa910pWSQiMktw9AynKN05dpSIH7eQSh84XNJRUCpY/2Ohsx2O4EUJd
 CDew==
X-Gm-Message-State: AOJu0YywhCFW1107sYP8SJMcovdAYBm+YWkYpLOQT1k6BJnyjBpwOhRS
 aG68r15EQ+SjYPpzp0M7dwEf/lS/Rudd06wxWk39xoJJyPaVdG9jhOoSY0G4yolVnz5zlRr6Kkm
 Ubq8c
X-Gm-Gg: ATEYQzycuhORv/R9uqZHy+8OzKn69YBLDQ8nm9hLulIlWWSnr2PHKDhrBYkL9DFT0LM
 /r2Xun+GWs90lcDtZUMLydUEISGRTCjss8kqw/2O43Wo78m/GRUF2vovROv0yV9ohEQXSlzskqL
 detB5b5XaHZlyTE2tDK1RvoxjC4ZRRodvDIffrhqhHypS6KtSbDp4/4lqhza7z1Qrr7gcG65UEw
 8J1PxPSyO9WvYMwBcOBaVYNyMSjIJ+nOrB9ddpi9+Y4cvpoLwox1X6TR0Fr2tYNkKZdRFb/74Am
 c7FbYBtgUAKqhLfVchxZjNrjBl96MWtJk4Gto4ielMdS6vyxUoQ/PsK2rHU/v7dKib2xM/8rdp/
 ZMbHiG8anUCMjRm7J8pTDVWS42ogmasK+ArmRjfwDNyaq1QpHqiJrbefWNnSX1D9s2g3Fm2PdTo
 JvyjfDExUZDHf3J6wNnt4KiEM02pUx5LtW
X-Received: by 2002:a17:90b:2c88:b0:35b:9777:8bb1 with SMTP id
 98e67ed59e1d1-35c300ba6cfmr9525072a91.19.1774826671789; 
 Sun, 29 Mar 2026 16:24:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22b9fc96sm10295401a91.7.2026.03.29.16.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 16:24:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 3/7] hash: remove spurious warnings in CRC32 init
Date: Sun, 29 Mar 2026 16:22:37 -0700
Message-ID: <20260329232409.205940-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329232409.205940-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20260329232409.205940-1-stephen@networkplumber.org>
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
index 523be0bf92..8b70982c4b 100644
--- a/lib/hash/rte_hash_crc.c
+++ b/lib/hash/rte_hash_crc.c
@@ -37,9 +37,6 @@ rte_hash_crc_set_alg(uint8_t alg)
 		return;
 
 #if defined RTE_ARCH_X86
-	if (!(alg & CRC32_SSE42_x64))
-		HASH_CRC_LOG(WARNING,
-			"Unsupported CRC32 algorithm requested using CRC32_x64/CRC32_SSE42");
 	if (!rte_cpu_get_flag_enabled(RTE_CPUFLAG_EM64T) || alg == CRC32_SSE42)
 		rte_hash_crc32_alg = CRC32_SSE42;
 	else
@@ -47,16 +44,13 @@ rte_hash_crc_set_alg(uint8_t alg)
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
2.53.0

