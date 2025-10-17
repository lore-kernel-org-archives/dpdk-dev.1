Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE84DCCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CB2242E44;
	Fri, 17 Oct 2025 17:02:57 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 3147B42E1D
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:55 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso1681417a12.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713374;
 x=1761318174; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDA/FGsKKPcPdnr7eox6bUAQx4Y3JlVl6Tbs8UK4UT0=;
 b=POEeMe+/qHGEc07P1p0MIQusoxp4FS9OHe3n0FjmYEWGB80PcBAHPMub2fi0p9TLo+
 aq0DFnc1BrhvJCVkpLc7YXwKEKZR8wY7joXv/anBglLohnzesJT5rY9Yg3e8PeEBsSFU
 XGPOTgLmX2L8P4CIWKAN7CVpZ81zXWXqa6Jw1y0i5XXGKU+Lx/XxV2YYi0yTDmbhHfYs
 O6jWuf43WzAXdAQNp8gcx322skxZcuVe/m07YOVL7E+TuE257iXbaJZNWyjqFo/GSoeE
 pJraEcoDPnS3BYtcVD3EPpOE6hUwn1eyN0mEcwXTWN4b0Ch+vbv3PFNwRd2gTFZnVQvi
 lf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713374; x=1761318174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDA/FGsKKPcPdnr7eox6bUAQx4Y3JlVl6Tbs8UK4UT0=;
 b=nNvl76CDbqjor5rMgjlEBtKgJgylR9JwSy68o03N4M8Y6yRPy1Yrcwio3U3drhD3XL
 bV2TMYWwagVbxpuEvJ/6l3AkRMtDWroWen5XlBLSPPwtBylcE8Z3XWZfNFhsGNUSHvUc
 +H6e8X90y2uTwAjh3tUqwIeSDHlELrCQ9HyajWX8tUlf7ebBK85y4RAIaoC/sx7SwLNY
 hOJJ0dw2/yb8xD7OlnHalvrURbWryqMxcKbhk9Cqe6I15EfLv4NkginCKQwRBvrpMCWz
 lK8L1H/tT+SlgAScbRmGj9FKqWPGzlP9aHvypqEwLM/9jbPKRQCQMVlubU+3CDI8YUrg
 6lwg==
X-Gm-Message-State: AOJu0YzkQTM2DVTGqFJwQcGxck5TC64j6h30lJRUklssOuE+FUpYnUun
 eRosAyyKNW9MNpd5zS7sVDZJS8/pHGKppwdRF1YMbiIfH4CW0E8WaLorGNlZ64zNEo+rF1CS1W6
 nB9olcUQ=
X-Gm-Gg: ASbGncsj1eLqKa4GdnGddE4lV8xQG3jZlADnSIJAgN9w2/+i/KONI8KylJtd+vbVdYp
 fj2gjEZlAApg5tXcXiTgTtNrgI3f5AjdUSQ/jaSPJeqjpLaF9qiO1mz+R704KoDs4Q/7el8RDHX
 b4wg5aOXfI+Y4K/bjdk1S1NYZfa/+ZCwWAlvcXNyvWqTbrYcRIVX3Yto6d+mIpWaesgc8vxIAwl
 EytGa279cswAWAtaOqd9TIYiC7IIGpLI4TYv418rsx9rG6QqGFq06Lu1I4AZzw1dvUmfp++tv+c
 MxxtDDtr1MMz5RLuJt/W1TxcCm0afD+IJEM0O+AZlHLOS+bC75X9TFwY7+XbHUNOzB8kiezUd84
 oPV6Xa7Yf6S40xxmYTRcWuCLK1i6vbjfnjAVCWOOMCWxX6qiwRt3JnJIdnpWo6jfNE9JWTLqZ++
 mRXDNlXGQTPM4TGuQjzPmy80zQswNcmbhzaDnH1qEmsgXtppYrNel6Gs276g7G
X-Google-Smtp-Source: AGHT+IGQBD9DRQyi3aclB+Hggj0CyckGsaizZhjairNlOXRaHu/jyMARzTZNunyPFW88Rp9GKWeVVQ==
X-Received: by 2002:a17:902:d506:b0:290:9ee2:cfb0 with SMTP id
 d9443c01a7336-290c9ca7619mr47537475ad.15.1760713374288; 
 Fri, 17 Oct 2025 08:02:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v5 6/8] net/bnx2x: remove unnecessary comma operator
Date: Fri, 17 Oct 2025 08:02:07 -0700
Message-ID: <20251017150241.28511-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
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

Use semicolon to break lines.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnx2x/bnx2x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 51e5cabf7b..8790c858d5 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -1537,8 +1537,8 @@ bnx2x_set_q_rx_mode(struct bnx2x_softc *sc, uint8_t cl_id,
 
 	ramrod_param.rdata = BNX2X_SP(sc, rx_mode_rdata);
 	ramrod_param.rdata_mapping =
-	    (rte_iova_t)BNX2X_SP_MAPPING(sc, rx_mode_rdata),
-	    rte_bit_relaxed_set32(ECORE_FILTER_RX_MODE_PENDING, &sc->sp_state);
+		(rte_iova_t)BNX2X_SP_MAPPING(sc, rx_mode_rdata);
+	rte_bit_relaxed_set32(ECORE_FILTER_RX_MODE_PENDING, &sc->sp_state);
 
 	ramrod_param.ramrod_flags = ramrod_flags;
 	ramrod_param.rx_mode_flags = rx_mode_flags;
-- 
2.47.3

