Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1780BC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 16:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB3A34066E;
	Mon, 16 Jun 2025 18:07:32 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8BDE140689
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:07:31 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-74800b81f1bso3890707b3a.1
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750090051;
 x=1750694851; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZ8uncjoUpysChQKemgDy35PhDD54EgHFGRPcAU3U1g=;
 b=PgqdwFA8gCxQtC7oR6TK2g/y5oXmCXArsOMNf9986ih7W9qdIm2lI5mR/xfL1h2Kbo
 5b5GFBZ/fpBxvmftxNkRbzq1LhJkrL+2vsTDvA3BMHe93d+mM2ATVdFHxyiw4wTZ8hSR
 I8LoWoJCx26U4ATW7fokdfXX89+hCkSHh9DSvliJAxUdLyxJJF/hVt5qeWH3PGlCqSbY
 5GCmIFBnLLFNQWUSF+nPrPlLHh9lRF+g/Dxjkv3sdkLEl53vOJLuoS32MSgZD7xeJm8c
 Fk8O2FwLohgayAdjqscKYYW8Auxxk3p6jUYTCh1Hrj4ag9NyEILvtY++issSw0UPsrSl
 t2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090051; x=1750694851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZ8uncjoUpysChQKemgDy35PhDD54EgHFGRPcAU3U1g=;
 b=eRoKkoJRZdv3TbVIY4pFhFF/uxibvGN6tiOvKux2ZmqL7O6H6MqeyntMB68VCW+zGX
 X+S1g3y8QWWTCfBXeBbeKPhxe9/e+dGVhNn9k7n8VCmOel8guuajw81BrO/Nu5hNhZzH
 WIqh9d+f9MGJ5e0T5D4STYfArwNWLS2sKs/tk8e470w9NTSjkNdv+UUitOrIL96kVlFW
 oaKKARjfYoGOFBfUys2QP7I8l28WU6V9cw1oydSTQtFli1QtIN1UHft/z9roFvT3hjeC
 wF5x26idjkd1wTt193yNOXmglgepSTcWxln9OPnzJNp9nMaZ3eOPZ8iR21gg1kAJ4hzb
 unxA==
X-Gm-Message-State: AOJu0YyDYthLL7jqqZJgi6qcSNCUx5Rujw5b8OHlxTaabVZ9mkaoS24H
 vNRLSAMVWt5t9hkY5rznurmfmfMsgbkohk921jv7IQFgA5Sn+5DzxoMMk4Z1d13xeUvIu84Mro2
 ++RqK
X-Gm-Gg: ASbGncs6Cm4AWQPJ5L+EfxasseMNDJy4Jcu9ouFqM2WyilS1tlbH+sJ/q2Wk52OiX+5
 FjbUi4HmZHwfAzffxw5btg2K1OjEfj3Iia7oSrN8UleZuwzK6tHuYLcmWi+BezQDtcscESyS+6k
 paN54ynhftHN/WBUcqByJSuWQrwDZ562GbWENfz+nr6DvuRGOvVnZa9H5vImuPoUMT3G1pYAVyD
 uWiSy7jsWepppOkHALd3pAqofDU2PufvUpkfJjfsRRRU4TfpGUSg28HUpi3hmjVNANcffOlvG3U
 cZppJI484fh9kO13byZZtC8/Hxy+l7F8TAMtA8+dAGL8fI3h1yaUgpTD9inKlQv/DcPaCJGC3m4
 vowIq5PPMbZof+jAdoW3XXeaUHf95+CBGj2TG
X-Google-Smtp-Source: AGHT+IGpVfEMaBKqx2GH2ZZqM+/4IkOrYuVyVoGS55TO4wbfEFeJAdTEUjAAOK8IT2TF7bMCBL2MYA==
X-Received: by 2002:a05:6a00:2d20:b0:748:3485:b99d with SMTP id
 d2e1a72fcca58-7489cfd3197mr14079742b3a.18.1750090050638; 
 Mon, 16 Jun 2025 09:07:30 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748900d252esm6992623b3a.163.2025.06.16.09.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:07:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 2/2] latencystats: optimize locking on transmit
Date: Mon, 16 Jun 2025 09:04:33 -0700
Message-ID: <20250616160718.49938-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250616160718.49938-1-stephen@networkplumber.org>
References: <20250613003547.39239-1-stephen@networkplumber.org>
 <20250616160718.49938-1-stephen@networkplumber.org>
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

If transmit callback is called, and there are no packets
in the burst with timestamp set, then the expensive operations
of locking and accessing TSC can be skipped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/latencystats/rte_latencystats.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/latencystats/rte_latencystats.c b/lib/latencystats/rte_latencystats.c
index 2b994656fb..cd790fd49f 100644
--- a/lib/latencystats/rte_latencystats.c
+++ b/lib/latencystats/rte_latencystats.c
@@ -191,17 +191,26 @@ calc_latency(uint16_t pid __rte_unused,
 		void *_ __rte_unused)
 {
 	unsigned int i;
-	uint64_t now, latency;
+	uint64_t ts_flags = 0;
 	static uint64_t prev_latency;
 
-	now = rte_rdtsc();
+	for (i = 0; i < nb_pkts; i++)
+		ts_flags |= (pkts[i]->ol_flags & timestamp_dynflag);
 
+	/* no samples in this burst, skip locking */
+	if (likely(ts_flags == 0))
+		return nb_pkts;
+
+	uint64_t now = rte_rdtsc();
 	rte_spinlock_lock(&glob_stats->lock);
 	for (i = 0; i < nb_pkts; i++) {
-		if (!(pkts[i]->ol_flags & timestamp_dynflag))
+		struct rte_mbuf *m = pkts[i];
+		uint64_t latency;
+
+		if (!(m->ol_flags & timestamp_dynflag))
 			continue;
 
-		latency = now - *timestamp_dynfield(pkts[i]);
+		latency = now - *timestamp_dynfield(m);
 
 		if (glob_stats->samples++ == 0) {
 			glob_stats->min_latency = latency;
-- 
2.47.2

