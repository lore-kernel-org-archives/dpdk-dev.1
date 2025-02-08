Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B93C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB14A40A73;
	Sat,  8 Feb 2025 21:32:24 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id E74D6409FA
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:20 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fa4493a695so1021988a91.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046740;
 x=1739651540; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaGGt1IzpilubFPyUaH3i0IX2QOhYcvHwgwphkkbYaU=;
 b=OPMWZUOrTMSJSWbL4rOBGG71YA4pqbsIl5T+Vm3RuNfdWkzXpIT9kq6hdeNB35EuPx
 xhAGHd+SzvEIxzBj/KaX32FCnQfRRJbIYSRiyI8JSTtCcYkU9rXaPgrDVefvxHFikgQA
 DX5i0281X6v2W/wwZJAbC0lSJdJLkHJZaDeWpxscRUjaSlJ7wBE0Kvitfa75zUPs6vOc
 XBbUopJBrnLG0ckthVhW7Kql6/qvluzpvFWMVeWnTasN+mnODObwmLe3tGYQTWSo8CFr
 jPFWAUqgXdPzFNSxvC3xF3X0n2Czv8fR0TW2s5u5EzbcSUg/ctLIaIxUYKG55P4gER7i
 VVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046740; x=1739651540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OaGGt1IzpilubFPyUaH3i0IX2QOhYcvHwgwphkkbYaU=;
 b=S7EfCisE8LmrhSIRS9EuI87BOhXni6Us4VR8cz4afJOTit+oq2EbuJBoSJqBxKFCDh
 U4ztqXSeSmdAO8ad8hYcuNN0BHsqa5nQvac3+CS0EkQCbPUpl9+h8Jw4CARO/S0VrLO8
 5307rBXXTdf13LJrc0MGnnjeKm7MEu3OxgEc4UUBpTITx2xRriZ6EU1JDN875WE/cAzw
 jtFtJSOhEg7R9QQi4rrPywWa0kW/lqYocc4Rl1giX9/JQSl/0S47hHzzMII8Z35AxdZ5
 oPbWJTmoTe8vgEEY5ZL/qWwHge0W77tFjdczA5OVpkwYNVHD9dBn2zKmkaUcYoomg6x3
 3vrw==
X-Gm-Message-State: AOJu0YwytPFJpPsNtd6MYiW1y2Jr1zucYH/2/9EHWUC6UhkcnjLK39jh
 Ur1x0zPJBLE3p3Mg/sxEOAOcOMzhnMOQqIV07JHFDrY688ey/mh+LCYgDqT97LML1pUQ1Q02kXw
 2nvY=
X-Gm-Gg: ASbGnctYBxHJrpz9eqfp/8xgbsYEaAsxyvCRIXWtjrOO/F/xJW07d3xCACUQUpwoO/Z
 hU7P5H5eVXgVf/9pZck740JNhslM+5lTqt6Y3FnA5G4j6cTfipG6Nh1Ov3NtDO6cHA6j04siOZs
 AqTEi6ND20d0sn1A2AUGob0Sp1oCsWq1OkEf0ETyG2Ngrbt1ZkSH/LhR9F2K4vL39lmLFGJePIk
 R+lUC10uUeXWd/5OB4Jr1c4Rl7459qZDstTJ6G2PApO4UHQXvf9wQXiL42uTHrU/hHdlDk6QeJk
 JoP4OGkRCDPaCO00Jr9VxjJDDvFoq6azKLN0F2Kf49ZwqpQ9D82QktGGfjBxJtduu/sv
X-Google-Smtp-Source: AGHT+IF/CTIKax2wJ0mxAsMno2NnBFN2g90mcqRiIbzum+h/NcDhLLhuh00hEzUAJH8lhaHhAq6D3Q==
X-Received: by 2002:a05:6a00:2385:b0:725:b201:2362 with SMTP id
 d2e1a72fcca58-7305d46849fmr11999388b3a.11.1739046740230; 
 Sat, 08 Feb 2025 12:32:20 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 22/32] net/nfp: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:14 -0800
Message-ID: <20250208203142.242284-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/flower/nfp_flower_representor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c b/drivers/net/nfp/flower/nfp_flower_representor.c
index 9601aa5f96..ae0f082eb9 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.c
+++ b/drivers/net/nfp/flower/nfp_flower_representor.c
@@ -318,7 +318,7 @@ nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,
 	struct nfp_flower_representor *repr;
 
 	repr = ethdev->data->dev_private;
-	rte_memcpy(stats, &repr->repr_stats, sizeof(struct rte_eth_stats));
+	*stats = repr->repr_stats;
 
 	return 0;
 }
-- 
2.47.2

