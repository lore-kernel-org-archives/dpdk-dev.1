Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAABCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:18:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F2CC4064E;
	Mon, 18 Aug 2025 18:18:28 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 153CB40262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:27 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b9e4148134so2132737f8f.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533907;
 x=1756138707; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWMkOJMAzUYt+AKghd481/KPPvTxxs9NnpnHS7xN2F0=;
 b=NJHq9O8SlBImSIDP4qrnH6JyVBuGe/fR0itNmTFkIyDjMa2VW2rph6dNei0qZrteDA
 tLXwfIm32O2P2e7GbJHwW9AiLqlqJ0AB8DrMTPNTydXG99q9PCdPeKDE4ELESkWRsLhV
 HKNf/lD0XdNCNr2czQFGPqujnB3H5xRNHglRL58zNxUuMR2zovSkmt1fFxU3rKZ+36MX
 Ts3IUxAgA7R3Qzl7eAg2X9rGFJKmoO3sU3G6yP3Tv4Gb4tLmVXDTBPj29C71JMBY7sh8
 z++dRFcFSS0S8ByMWT3Hp6BtCqAAwxD6pYtsTZOAX3Sh+ydl9Y3Fy4x4oKJ2uTadDv+F
 qK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533907; x=1756138707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWMkOJMAzUYt+AKghd481/KPPvTxxs9NnpnHS7xN2F0=;
 b=wfE77lfaZjAp4+AKSrWGt0PJ4UYN4MtTkLbePP5fubQGSeaKbp8J6qoHSFD5BvXMvq
 e9dHUw+si2NcZ31jFrfSkza8XB2K/jPAmBpQOUHZqxRER3anDOEA+aI1kRtWyzHv7MIv
 Ja7nXqJGcRSzmkNncZVotR0LTqlSfbOqCQrmAIlNRTTL79CUW6hv8yTSQ8uM9V25OonW
 JH5KO3xJFPcDQe0avrwI4OqOG+gzC+/Ukk+9dxvcYmN7YtMjQTJeb700uSdrEZi2bBep
 jgch+wGv8TnraHr/vhujyEb6MJ4eAPwMd2aJp/6xndIJQxg/vO+ICdrm8ux/tLM/pSGQ
 dwVA==
X-Gm-Message-State: AOJu0YwVkiBWBAvAPHMbxJvAtsRAB8xoODaGgpqiGYNgOi8lBWWLl9ny
 Ilv2v1uoQ+TR6FTKrWbh+Yz+cud0wcyYI3su+sa1Z6QTDeGyOIFeH0oDNHQ+HRv65YbDQ446oOn
 kBmZp
X-Gm-Gg: ASbGnctsYkmQrvytlsK7j/bc+/p3Y82hYAk4Ryxt0oTkdKcWCLmi0vs/KjJ3JNhrm9P
 Qi+GcwEVpR+lwY+c/KMXLK7RIYK6iEo5tdBFUOt6ePz0zcijjgeCr0PLvMV/64YTzzmU8U/2L8Z
 3oHziMcqEfAVEd2hWKLGDAjiLpxLy6sqSJPI02wD9h5zSa49flpR8IH+l2tZdFg7Fb/N+01SZoG
 Xript7LYP2Lm8076i/3xhpavLbsqg41W3pxfZTXwPDc4A2+VrdgaL37zThkl1uTBOiRoMYuilTv
 HQLjorir/z/fI4Zf5TZNgnr1ucE7AEHIiWb/VOBMk6rIKah/LMFDrwzhj3bZfbUnOqZwlJoR5WA
 VQW/BjTYyKjYLA0q7c6M0Nuzzf6t4wWhlO2X3AtWzuYKC574hi9sAxaF2kylFaaaw8E8mGMuv
X-Google-Smtp-Source: AGHT+IEBLuFwMqa2H8gaQyXjznoau1itffSyaJmnwrKtkTOUzBjh1T7VPY5n859eP9eSFdodNyd30Q==
X-Received: by 2002:a05:6000:4022:b0:3b7:899c:e87c with SMTP id
 ffacd0b85a97d-3bb6636cd4dmr9306065f8f.2.1755533906607; 
 Mon, 18 Aug 2025 09:18:26 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 2/9] ipsec: replace unnecessary comma operator
Date: Mon, 18 Aug 2025 09:18:07 -0700
Message-ID: <20250818161815.23611-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ipsec/misc.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/ipsec/misc.h b/lib/ipsec/misc.h
index fd4d3f5256..eee3bb0c1f 100644
--- a/lib/ipsec/misc.h
+++ b/lib/ipsec/misc.h
@@ -19,12 +19,9 @@ static inline void
 move_bad_mbufs(struct rte_mbuf *mb[], const uint32_t bad_idx[], uint32_t nb_mb,
 	uint32_t nb_bad)
 {
-	uint32_t i, j, k;
+	uint32_t i, j = 0, k = 0;
 	struct rte_mbuf *drb[nb_bad];
 
-	j = 0;
-	k = 0;
-
 	/* copy bad ones into a temp place */
 	for (i = 0; i != nb_mb; i++) {
 		if (j != nb_bad && i == bad_idx[j])
@@ -126,7 +123,8 @@ cpu_crypto_bulk(const struct rte_ipsec_session *ss,
 
 	const uint32_t vnum = RTE_DIM(vec);
 
-	j = 0, n = 0;
+	j = 0;
+	n = 0;
 	vofs = 0;
 	for (i = 0; i != num; i++) {
 
-- 
2.47.2

