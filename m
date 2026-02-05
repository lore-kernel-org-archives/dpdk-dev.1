Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73433ECD994
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:58:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14ACF427B9;
	Thu,  5 Feb 2026 18:58:09 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 3FE07427B8
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:58:08 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so1030289f8f.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770314288;
 x=1770919088; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P10UBE6TiySq6w1D3mn3ktSvSrQYZUecnVj8iuzHJZE=;
 b=blCUsYu1Ic/UJSsqZsBOUC8T5icKxDKvHLy92icNPRGh06aAr+4W0jaURV1XE7C2KR
 XNUG5+QSxmq7fOYgmkBA0L4IKFa+IGIcOF5G2/E+zgSXRzo4Sjr/TzQfW+d9V+nyRFXs
 1up2RF0HxDh+98fUgv1sa91rzJFL77llP434sq3+cvS134rBfq4hCV/fytugY+kIoIZk
 1eXlWuUHDT5tGWyobicw/9dJQbDME+SNlZYq8b/TL6XhT/C1JVVKCZgMaQkxHq8vR0WR
 CjhaLvma3wPH9Elho08mIOohBMyDJ0IeTx9xC1G1SevrRMNNQQLCKZoauPpz1l19nLo0
 +PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314288; x=1770919088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P10UBE6TiySq6w1D3mn3ktSvSrQYZUecnVj8iuzHJZE=;
 b=eQAOjRwrDpKErN23xIe1yzSrtcg88+qMOS7RcSu29tzWOsAi1bMY1XKKI0qI3ZJ5OP
 KLP9AGAIJuJJw7NJMhXODLAg17u+pc/+/eQA3kWLduD7nU6y6G7xPW2WMG2r/olAF9/4
 +hB/gTH1YsYddZnPnpzai1tpjOhtzR6lBNCrW0fHy+wZuNMTnRIx/FZu0+Qqy36Othvc
 9kvST+MGgg1oB26ImgnhirTwXNDqT7EAIteQA0SrVNT9BWjD3LqsCQwWUZjvsAkKZIZ7
 bMEiHKA4tsBjl4AE6/gPUkCrGuU90lv8SFGhbqCeiGAeqVcvEWBVdHfxzeP/niAw73+1
 K33A==
X-Gm-Message-State: AOJu0YzBMCqJN4NvkNvOXnU5ETx9mJy4jIuAaMtS3UwoqDabYFtzvwFg
 LOvbk6MAVPs+eVCrwbqzpC0KZPSIVoeEXsanMVxnwODrtxm/eWb2b38yZ8L45QHbMolXEHEyqy8
 ZYtBu
X-Gm-Gg: AZuq6aII39B9jbyG2WS9Mu78qTJluXvyimzKHGZ9B8wRHwIS/1ZSNhChMetPZQR2lCX
 GKY+ibt5VuP0OhKex5fKDJnFmjfbWInf4FWaGzeWwah3tQZf8w9Yi2EzSIDNTt/dVZd2CeVLR6y
 G4SIEru1U6y3LZcB0qNo0VcVXSqj0fz8IuROnedGlW8PoghcuInQjHye4+KVPDh3RUt1MClrFGI
 LKuASxfObu56Z02rHIERE5RIGldqrabETs2IBLe0g2MY4pDlk2jYdmsuDnulMw+DMRSj1TiLuC1
 niBuktpgnWLXhm5ACON1eUIzhPJd45xQZsPFW3M+JOcLHrqivHUhK/Y2+fumkC6DlDK0LkVPhNH
 jwlo6SDzwEPZOKw+mLTKy93veHZMMKdIgI6PFAotkjcZqJnxKQe1h4e7uJhWXnThjXqRLvmx2VG
 VdMFif/6xQaNDkog+VOld7wL/Wr5j86vGcIklCP5L6Fhh5NEtyEQ==
X-Received: by 2002:a05:6000:2207:b0:430:fc63:8c8 with SMTP id
 ffacd0b85a97d-436293b39dbmr125552f8f.35.1770314287768; 
 Thu, 05 Feb 2026 09:58:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f7csm15465594f8f.23.2026.02.05.09.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:58:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v6 5/6] ring: use inline instead of always inline in soring
Date: Thu,  5 Feb 2026 09:55:57 -0800
Message-ID: <20260205175750.653353-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205175750.653353-1-stephen@networkplumber.org>
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With LTO enabled, always_inline forces GCC to inline the full
soring call chain, triggering a false -Wstringop-overflow
warning. GCC cannot prove the 128-bit element copy path is
unreachable when the ring uses 4-byte elements.

Use plain inline instead, giving the compiler discretion over
inlining. At -O2/-O3 these small hot functions are still
inlined by the compiler's own heuristics.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ring/soring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 797484d6bf..3b90521bdb 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -249,7 +249,7 @@ __rte_soring_stage_move_head(struct soring_stage_headtail *d,
 	return n;
 }
 
-static __rte_always_inline uint32_t
+static inline uint32_t
 soring_enqueue(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, enum rte_ring_queue_behavior behavior,
 	uint32_t *free_space)
@@ -278,7 +278,7 @@ soring_enqueue(struct rte_soring *r, const void *objs,
 	return n;
 }
 
-static __rte_always_inline uint32_t
+static inline uint32_t
 soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, enum rte_ring_queue_behavior behavior,
 	uint32_t *available)
-- 
2.51.0

