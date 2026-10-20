Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC073606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hyx2laPs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA22C4067C;
	Tue, 20 Oct 2026 16:55:52 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 29BB340283
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:55:51 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3a4b9732d5aso3051569a91.3
 for <dev@dpdk.org>; Tue, 20 Oct 2026 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792508150;
 x=1793112950; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GJxCLAn8Kye542CaLqD0rFTTnoPuTC/3j+FDiZFZWKw=;
 b=hyx2laPs+Ke4h8odTD71F9yvnByTwmYFJENHsUDgoVuBqPqHOWolIiRiphEnsO9oIz
 ScxlVfjd69lXJXMsaM4rbturkPQ+iaIJ8uXZOfE4c4xpBVLY7DN3dm+PinCx0XYwOBAn
 rRgY64R+WCgBfpDaicltT7DrMcSXZWLC1wxi0nSUI+9//iWacidFbfSXWXbDjSyfZb++
 W/J8Loqzba5+EtvwPaMQih8FhcOIPsrcx5sSI/Fv9Chqx7xNgYaBz4N7qg1zrvWqRW11
 p+l79H9AGJP630/zkiW/Ba8wjijW4k6lR0fenjNauaD/Gr3GtVIQwLxt3QLMpq8mRJDq
 7E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508150; x=1793112950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GJxCLAn8Kye542CaLqD0rFTTnoPuTC/3j+FDiZFZWKw=;
 b=tpbcwPKC8EAWCvra6vPnsIpClPQwEUz2NWU/sNAIq4hEXXk4Xh/EefY9WQVumBT4mx
 KakVm0jg5zlo5Zb/9YdiHb7mxFOm1eObxiGg9PBGfV7mXM/NeiKCsXENopxUQYnDtPEH
 C62YuLcfDeFNepB7WLYCRmSKr4yzXsgKzlkmwbjUKfpO7LAeWhklRo/0E8rQH2bsG5BD
 pKyxwtUkoyPOkyi1VWkvvxBgTIRZtMUZxPmsqZbt08z9W1mvkCYetGFzoqGLskcWG2oK
 Z+Yqv174/6IYSKnxW7He2lTaIk++l0mANIou+KAgF25ODThFVDP6wyq2WVDkXo6Hrtkv
 NnNQ==
X-Gm-Message-State: AFq9FYIbAFWpp8Hi0MfO3ybJ5AlphlDouaPqnrP2DFItfCov8wiAMnLD
 siVjqHPPURPPFWk2uXs0pRh8HyNWQ9ercFGqZf4mCYhtWhv2BHnF/BWqPCLUGNeO32z+Mk7ohBq
 k6nWNrio=
X-Gm-Gg: AYBFou39feYnZADb6uXiE1P9/1bp3MJtkyIyRGhpCRTfbWfmBo6LJxeFbNYobieoZ3S
 zqGUETVEVCVLE1cQnLU3xgOQ6A5aTPkFMB0WqeS0cm1zF0nmCcIIbvzyTUtgZwSZ9GLp1rg5luC
 I3g5grjpt9pUqa3xUB0nS0YncnxWq1IAg0Xey0duAJXjDBKlo7VNjXNhYgV0T2DcEVesGhbf5sd
 ZT7FQNKOUCVtk2ohWH3HfJ6KktTZcUyuqQveKC+VyuoBTo4qWYm7nKtQtYJ4WweNte1v0Ojgq00
 aVCt/QvjWLpTtMHS+AZxpcuBpIbJU6Hy1nkfP7IaCO1V4Oi/JU6jJoZ3x6w9uRb2JijjuaNsxFs
 iODkUeRvFU0TizSBrCyCQutiiGba0B2GQHnZ37Wi4djqIlSx3cxm2QwDN2S9poURsh4+J/9dSB1
 QJaGJiLty6Um9HLmqWuH4hrnyuOQW4cOqjDR+5EtmZzQ4gye9lwuCrzfN9a2LLBr2PsdLPNwc6h
 80UJLr3tLXRUkiQQkrlmdkSVZQWZVqW5wvS+A==
X-Received: by 2002:a17:90b:4fc2:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3acef5700abmr11120234a91.49.1792508150217; 
 Tue, 20 Oct 2026 07:55:50 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd093380dsm10467306a91.3.2026.10.20.07.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:55:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 2/2] ring: remove GCC pragma
Date: Tue, 20 Oct 2026 07:55:41 -0700
Message-ID: <20261020145541.388371-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020145541.388371-1-stephen@networkplumber.org>
References: <20261020145541.388371-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The original issue that required using pragma here to disable
stringop warnings is now handled at in config/meson.build
across all files.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/rte_ring_elem_pvt.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index 29758d0bb8..3d680749ad 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -10,12 +10,6 @@
 #ifndef _RTE_RING_ELEM_PVT_H_
 #define _RTE_RING_ELEM_PVT_H_
 
-#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 120000)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wstringop-overflow"
-#pragma GCC diagnostic ignored "-Wstringop-overread"
-#endif
-
 static __rte_always_inline void
 __rte_ring_enqueue_elems_32(void *ring_table, const void *obj_table,
 	uint32_t size, uint32_t idx, uint32_t n)
@@ -500,8 +494,4 @@ __rte_ring_do_dequeue_elem(struct rte_ring *r, void *obj_table,
 	return n;
 }
 
-#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 120000)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* _RTE_RING_ELEM_PVT_H_ */
-- 
2.53.0

