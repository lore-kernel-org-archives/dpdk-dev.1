Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3812ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 16:44:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF6EE4065B;
	Fri, 31 Oct 2025 17:44:24 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 21FE140611
 for <dev@dpdk.org>; Fri, 31 Oct 2025 17:44:23 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-294fd2ca6acso17868115ad.0
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761929062;
 x=1762533862; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA8EiWVnhpMp6cbDfPELHixzWAeKYEMozJfdgptVuIU=;
 b=pzJZD9XjjUyAHfb1bBCgX9Ba5aDQCGDT9RWeUcuX/n4QdjR0IdJDSQTm3LJpfCGocz
 VOnWAAWkFo9SLDHPbbyzoJDCuud6/z2rb2B3r5rdzAyz61EdpB6z7B3Mpw9rB8sVfKsR
 4Ipv6x+DzCNuSaEY3M6ObxsB/IkNw7fnAYvpnLkNPQ3yOVJQAogkakWWBbW4nc7Z9hMV
 FEkmefKce/+jrQqrwaAncPVjAjYZfSTvHYxisXKqIurHkzlflk7Cke6rcEYott8zuV1o
 dYmGNSBjur3V7WMop6x7cZQpeyQKRHlJjRAJaNYvXb7C8D0irkSvglpyYyKtxQI+tRY6
 e9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761929062; x=1762533862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rA8EiWVnhpMp6cbDfPELHixzWAeKYEMozJfdgptVuIU=;
 b=Z2eRsehDQc230QqeMrXGbZcxkpsKJHtA9lku0UEaMtxsZJSSh3RZte06ZpxmNu5WTq
 LpoP6ORXMCnd+Edw19q/TmY5VsiAtJNCGalVZPdpdWsA/NDiHi3OVp7elAQGGu1FKfz6
 fz7JS/exvWde7DPAswo4CNNMAv7ROrb0BTeS1Q1CjEdOlCHCpCCkbgSQxqTGLlmGmtYM
 1/AY/5PBam7CJw1Ad6BAOxPbBtis034i2oSxn2//gdXT9FBWoL89TnRaoHJVpNJTXigs
 8DQ8nDMcaeVSD528a3fa7dEDJL/XgTBxS8KyBRK/sG7ts7RgoZYW7cDKQ0700c02mb7Z
 keaA==
X-Gm-Message-State: AOJu0Yx1OyOytpJBH2D1j39XTIRJ5MgNlFerd1X/feeJuZvHtkGjYsx6
 a+MBgDnqqZ6VDmBhRZGLZbIUqyqG19otsgremPBmKq1twWXbSYL71DVk+71GHjy1aa4DdBfzZIl
 Igu9q
X-Gm-Gg: ASbGnctPrKgN1+zCFxa9j4SWotfSpXt7hvpXsOldJGTulOaR8AnFnLeyEOLzalfYRNd
 qVjkKyUsikOzH9INu6YI0AJmURsB6mbArk/I6y2pFg61txB5JS2nTA+f50FELffHdw+tkbsUE0Q
 SzY5W9fmGFNeWWbeI10ifjwL0KwFmcsljHk7DvEs62UjGR1lO+i2HcV0UfGM7SJ9kLh9pMPC7ZO
 8V6zj7e0U+ebqyQR2wGZ+ZyNGu0gprQn9Qixm8A2gCV2BzEflOTASDHVfKU2zq/yRa4g8vGdmng
 Ql/H1h7VupUG3Mwnnx8MXIe/ISSypJo6XFzV8ydGKj5qcr8uiGBlcz5W3GHNYJ4l6ywFgezAub5
 XN3fDsJNJqqtr97PTUB4WTw3pgxZrCD1T+noBpZEHxL0b0lMit7cuMgRCHlBkoLG/nUyv9S20XK
 6a/SQHeCsbx++eQMQP1myVY2OODcT8yEXU0XEae4g=
X-Google-Smtp-Source: AGHT+IF0s05VN8Qy2fBzs3tt8yDgE8inqfuFlyQa0SwZ9b2ArYHy9uZru5sndBNxoOCQZ7IFdVXzvg==
X-Received: by 2002:a17:902:ce84:b0:295:1e60:a9e6 with SMTP id
 d9443c01a7336-2951e60aaa4mr44874765ad.3.1761929062085; 
 Fri, 31 Oct 2025 09:44:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295269a8ddcsm28391845ad.91.2025.10.31.09.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:44:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 2/5] bpf: use bulk free on filtered packets
Date: Fri, 31 Oct 2025 09:41:46 -0700
Message-ID: <20251031164417.14166-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031164417.14166-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251031164417.14166-1-stephen@networkplumber.org>
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

When rte_pktmbuf_free_bulk is faster because it does single
mempool operation rather than per-packet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..087ac0f244 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -177,8 +177,7 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 
 	if (drop != 0) {
 		/* free filtered out mbufs */
-		for (i = 0; i != k; i++)
-			rte_pktmbuf_free(dr[i]);
+		rte_pktmbuf_free_bulk(dr, k);
 	} else {
 		/* copy filtered out mbufs beyond good ones */
 		for (i = 0; i != k; i++)
-- 
2.51.0

