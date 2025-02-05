Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF65C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:21:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8365840B95;
	Wed,  5 Feb 2025 18:20:24 +0100 (CET)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51]) by mails.dpdk.org (Postfix) with ESMTP id 296F440A75
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:21 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-726819aa651so23111a34.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776020; x=1739380820; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=te630U3+SNA15iWp7WLs+d0on1FeMuNQqsmrzCPaamM=;
 b=F5hvF+2wnQyvQ6YT9VAgAcMOhaM0tGNbtX12RFvQ26TamdYk3xuiXUlha8eVnb//0O
 QfYAJVHGsDNBdd3d1aRWsGQtZ/5AbxgOP5gLhz884zsow7ZrU4wAUnvq8jTRlfBRByEb
 6DKcHHtY+2lYvH5hAsp62C2jBeaS+G36WXKeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776020; x=1739380820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=te630U3+SNA15iWp7WLs+d0on1FeMuNQqsmrzCPaamM=;
 b=pGV8f6Dezt3tmGUHRbG2UzEZemcrRu6fRuQMib7OYYfb/G6UgBiDfJo/SnFE5IQneL
 fAztc7Ibe6pOV1JoRnJa9NHJ5wbz6+vvezSVIxRZxCms7kkaUoAWGFABsWQBMMPsw3fV
 4HGX6LoNCwycWc1ihPN9N4mvUH2E8LcCwKXxkyjsfdFL2U+Z45VyIOcFS6wGEPQv9QDr
 wJhtBNJ4hZqO0+rdtA6YTb392VZVCOWue1BXuxNcjZxhkP/yKoIOTKZls23QUi205hxy
 yhWdTJdr5mYOttJx/X4Z2c3Hd0wnuhuyL3RpOf1NbU5ryYv7+yEZRCEvo/YYpuCE+g6Q
 f05A==
X-Gm-Message-State: AOJu0Yxwo7Eww5aExZrjcrWqs96ME0BVXQ3wUXnihz9hcZkfxGtI9vMq
 kgLSKMak+8JjCtPI0Ibu5EixGch2PABqWGMxqMNTaTFpgtlxp7/VPv1VKgNUeDjp/Yg1tQX6mgC
 tRg1Fl1i1dBLTqUfz/w7qdbQ8N3CgkB2oI/Tz993cmQBes22kQRVZqPhlEt/to6Iv0wfgLoNHPx
 g8P6+e6KYZWKmdbi7aJl8AWrLbPgDG
X-Gm-Gg: ASbGncv5G8x0MsReCpBtlwO3N/rpxqR/PjE+liApBiZDnlR0vm8l88/Uch1l9Gp/tqG
 B+AJXobE4V6YUTOp11VGzTaUNN9IerZnae/N+uCVpDkwRzB2oFIEGLf2j8gS4/oeWpG/0Fn+ou6
 8MbiOziNEJxoJQiJ1oKqf+OXQ1X5Tb//t90Mrqd5QfGgHGlyWyl/4NLKsfdwe/oIecB+lDd8dkI
 JqKsn/wmEisQ34ytsSTxEiWkKLnME24cC4qKIyk8ors9bj3MuhAptuK+ScT5BW2c6uhzG5XxyMx
 Ez+T6pq7f+OAlOCrWG0sdOEXOLuablHTM/70+n7eyhds+VGh0rVBqQgRnF79Jr+28D/xRzjowVf
 QZ24y3P7B
X-Google-Smtp-Source: AGHT+IFaDpl0ssou1iODefLWrw2/R6cfWd7Xz+UtcjjmEV0mE7FYwz7TiDDoeqXBs795jgnMOfvj0w==
X-Received: by 2002:a05:6830:660b:b0:71d:f3be:438c with SMTP id
 46e09a7af769-726a41545afmr2790468a34.4.1738776020209; 
 Wed, 05 Feb 2025 09:20:20 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:19 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 09/11] net/bnxt: address coverity integer overflow issues
Date: Wed,  5 Feb 2025 09:20:02 -0800
Message-Id: <20250205172004.50395-10-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change addresses the CID 449059:  Integer handling issues
(INTEGER_OVERFLOW) reported by coverity.

Coverity issue: 449059
Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
index 61fafadb20..05528dd3e4 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
@@ -123,7 +123,11 @@ int cfa_mm_open(void *cmm, struct cfa_mm_open_parms *parms)
 	}
 
 	for (i = 0; i < num_blocks; i++) {
-		context->blk_tbl[i].prev_blk_idx = i - 1;
+		if (i == 0)
+			context->blk_tbl[i].prev_blk_idx = CFA_MM_INVALID32;
+		else
+			context->blk_tbl[i].prev_blk_idx = i - 1;
+
 		context->blk_tbl[i].next_blk_idx = i + 1;
 		context->blk_tbl[i].num_free_records = records_per_block;
 		context->blk_tbl[i].first_free_record = 0;
-- 
2.39.5 (Apple Git-154)

