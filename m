Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E0CCFA07
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 16:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6BD24066A;
	Tue,  4 Nov 2025 17:08:52 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1D7754060B
 for <dev@dpdk.org>; Tue,  4 Nov 2025 17:08:51 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b6ceb3b68eeso4293441a12.2
 for <dev@dpdk.org>; Tue, 04 Nov 2025 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762272530;
 x=1762877330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA8EiWVnhpMp6cbDfPELHixzWAeKYEMozJfdgptVuIU=;
 b=ud3LeHLIyaeutIYH3+zaIk4TcP0EI9y+vitJW+lioStq6s6qGAktHQngf7ZkXlHcsE
 +Il13iQoUQPJM8uMUEq07RVX36KOoffx4dur9R1UuQ4E4apf6q/OhJ36pr2T6vhdrLyf
 FMwPP4ye8oa4YUeq6glO34yu0WvTq6rcUop2wG94h2WFb0IPQ0aSJf/mFIz8GCGMEj2G
 EWhKZwaH89Mgcpyz67MF5V1+BYftc0jo1KYeZ0eqd95St7f13kqzeJRJMasji3pcEYdl
 tLW38ccXc5robsTwbRn2VS52c4mbShyGFiIVVlULiUt6WDkADaxCmz2TgVNSxnT+K+U1
 YQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272530; x=1762877330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rA8EiWVnhpMp6cbDfPELHixzWAeKYEMozJfdgptVuIU=;
 b=iG2e1cmWpuN9+15QLYeY77zWe34FnM+fyTQoGNvKltpFpKE5GGSqeHd7jMBmz3zOC7
 Fp9u44VKVQvdAuOI1tVCVFQhr7D6ytEHTwG+6qQ92d0qujrX5Lql66Rq1BcKe1iyYKS9
 3IwnFBsM7U0tLz7bTKCdJcyyTEmQO2QMueEJaCW9I5F82J7Uq2B8bFFw6OrJwW5LyRsF
 lFBKYwEgefCWvA8aDeOuI5ayblVr1ha0aYg0Q9ga4cIQGExEV2UWMsmQABe6qGq1HEiR
 qbaev5X1vzNNjn+sHTXcjwqKTvOGC7ibtTni1BTNCNRTxf3bv+X0AtDc+DVj+CNsSAZT
 YzIQ==
X-Gm-Message-State: AOJu0YzeY3KVQX7nXY3557fkKh7S0rMhOAXETE/wHjvkyOWQA9bfHetp
 N/4w56y3BVdn2Skf9IboR3CtvX8J951U3NryKAIT9sES3EZqIkdMSKa5sj/DRtiKnnBuA457HT3
 u5Ao6
X-Gm-Gg: ASbGnctKneCAsGA13jH6hWDxjaREgjAw6zcXkRFvkX1UlJu0xx0pg03UKTgxunhssyh
 CdPX4GVQf2+GqObBQ8H9Vv56TpuSjUVNHAU7LDMvrP+ZhIoayAornNfqt/LHigLfEQ0T4vFsvqe
 YKXk/qmJqGzFDBx7PZPU4Dxye7zKoCpbEEEvJguG2bbwrjFQe/zwfykQzF6q4bZMkm4UaFCH0Fi
 YIXwKGN7rsi2+adB6ye0GMX9GMoMymGdggVH7NsJtp7FKrWevDiZfPcNwwI1FTUQD4BfU1XLiPV
 0444OUUzBdWqNqtcdEN5cdRzGSsKsBzFxZIOTpj7rNcqRcu6/VvB6Uc8pB4Kc4pc6YHRrtxH8SU
 fUfikQNXtwBBl3MrlG8DqE+RHVfpxV6EF2tA2UVS99tTSBcidXTEiVm2r5YX2NjkdFbITYSYy0T
 CA7pdXxFvuDzXI61a7Hkl/UJxoTtokckIC7nJ0+y0=
X-Google-Smtp-Source: AGHT+IHrHZHsev3gEIR43Nj3kYymi7gHrE/LUhVd5MPj5a+EevWZeVdWZ3BKfCD91h945WznuDPQRg==
X-Received: by 2002:a05:6a20:3428:b0:34e:c920:35ee with SMTP id
 adf61e73a8af0-34ec920656fmr2177481637.19.1762272530014; 
 Tue, 04 Nov 2025 08:08:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34159941803sm5084800a91.6.2025.11.04.08.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:08:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 2/5] bpf: use bulk free on filtered packets
Date: Tue,  4 Nov 2025 08:07:27 -0800
Message-ID: <20251104160843.304044-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104160843.304044-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
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

