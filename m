Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3385BC021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 02:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92E7A402EE;
	Sun, 23 Feb 2025 03:43:57 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 56FC1402D8
 for <dev@dpdk.org>; Sun, 23 Feb 2025 03:43:50 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so75989145ad.2
 for <dev@dpdk.org>; Sat, 22 Feb 2025 18:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740278629;
 x=1740883429; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmFywI16YpT6GAI7YgeTy4biPnFq9HdZecFkJsYeTFY=;
 b=lD+H/2drUdzdOLmWboVp/rnCKvlFbyBaem1vDvE6h/HE+1hNC1QKcha05tVBZRx6Ot
 sPirrL623TReRt+4ZWpR5BlBL5AXSpv7hlImm9rJuf5BJYbjvyTqyitCrTBvGjMcMm6P
 j09XghUOm7kdJMUTwTNpfdr0/A6rJz6m22zTSGabjVuSvXS2ThdelomSHzRK9h74wxp+
 5+EJRXSsMKrCoT4GpVOMR0/9LsLhjGqZxb5sFPfnxyCJybskabJ7wsmI1W8zoUBZ7sbe
 7XECbwsL/IhD1r2yP+eYzfwzrjQox55Du1cr2gT5+M0vzi3Cv5MBOvixNFio2Z4ysQhp
 CpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740278629; x=1740883429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmFywI16YpT6GAI7YgeTy4biPnFq9HdZecFkJsYeTFY=;
 b=qyTdrzSpmTq4OtqjwOg7gZF+baVtQPs/sL8z79fhODeZFyEMphshCi5q50d7vbU54h
 XFIH05grksoJdUeGuK1FWFi1fAjW+9/7Jk3LlGeLh8m6V+I7j6S0uLqu2+k7MGRCGGBE
 snlCA06D93uOq4vP3HxIYGfb5JZnF1zdl83Y4SFmFlvyPlGRYeBJ4sEQ05CqYLXaz1os
 uIJdmShlfkNiDxGxNGck6aPul8asU56HAMuklD0DrvzxThd/5wMkCjsAe9eytHoPuXYm
 ThRnLfKMR5rUyiD2af5Jw19LRiGW/6ARfW+4of7y7u2VmnblPRJNKOQKQqyBvD/sphpj
 2EYA==
X-Gm-Message-State: AOJu0YwJw1yTajhnhTdfjWmAoKzh1lkH9rxsXoWFpDj1EDyBQUrod7zv
 WH2gkVnXzYwckG3fM0RxYPhRvD2lRCh1slIWlK60Q1b99Vft/mAOi++F9xZI6qoCd8A6nQwf813
 w
X-Gm-Gg: ASbGncuH0QOTZ3u3Aq2YN///ALFbk+TpxGKDVyqRM5rN0txCPa4Sb0n8eFugWM6judM
 3PGbEIE6RGK7SQM3P5Abn7SCRrLWMO+mPNulkXpJn7SU+Vz8Nswv9bDGZp6bJ250bzj/RsyBkVR
 PxD3nRySnSgWBy6haXUv1DjRWZyCPZ5N4EW8x3lxSef9h5Es8xwvSh76wU28fMMSd4GqFDA2sBb
 xnh+4axBknFBT/KCJ7Er9OS+uObjxmNLvusyQQSzmQqLuuNZ8B5sf+qsojngbTkBxFq0Jcb5iCg
 nipAl8xbJKOnxAE9oXzlfTXY/gDnwzz/3rweot4CTdBjtF0vwInYcj9Zttyplka2fnt5cscWiVx
 RCbY=
X-Google-Smtp-Source: AGHT+IEU9DSPRxud5M4xS6L4LOR3H2u/Jjxmhx5Kdd5RzP47+Uo6PCmI1or1+V4B3mhsOW5DGbDkqg==
X-Received: by 2002:a17:902:d4d0:b0:21f:6a22:b294 with SMTP id
 d9443c01a7336-2219ff5f93bmr172032935ad.28.1740278629521; 
 Sat, 22 Feb 2025 18:43:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536443fsm156112955ad.66.2025.02.22.18.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 18:43:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [RFC 5/5] net/zxdh: fix indentation in mtr get and use assign
Date: Sat, 22 Feb 2025 18:42:24 -0800
Message-ID: <20250223024334.1216477-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250223024334.1216477-1-stephen@networkplumber.org>
References: <20250223024334.1216477-1-stephen@networkplumber.org>
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

Fix the indentation of the initialized structure and
use assignment instead of memcpy

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_mtr.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_mtr.c b/drivers/net/zxdh/zxdh_mtr.c
index 2df5f1cd88..3797a5b29b 100644
--- a/drivers/net/zxdh/zxdh_mtr.c
+++ b/drivers/net/zxdh/zxdh_mtr.c
@@ -151,22 +151,22 @@ zxdh_meter_cap_get(struct rte_eth_dev *dev __rte_unused,
 	struct rte_mtr_error *error __rte_unused)
 {
 	struct rte_mtr_capabilities capa = {
-	.n_max = ZXDH_MAX_MTR_NUM,
-	.n_shared_max = ZXDH_SHARE_FLOW_MAX,
-	.meter_srtcm_rfc2697_n_max = ZXDH_MAX_MTR_PROFILE_NUM,
-	.meter_trtcm_rfc2698_n_max = ZXDH_MAX_MTR_PROFILE_NUM,
-	.color_aware_srtcm_rfc2697_supported = 1,
-	.color_aware_trtcm_rfc2698_supported = 1,
-	.meter_rate_max = ZXDH_SRTCM_CIR_MAX_BPS,
-	.meter_policy_n_max = ZXDH_MAX_POLICY_NUM,
-	.srtcm_rfc2697_byte_mode_supported   = 1,
-	.srtcm_rfc2697_packet_mode_supported = 1,
-	.trtcm_rfc2698_byte_mode_supported   = 1,
-	.trtcm_rfc2698_packet_mode_supported = 1,
-	.stats_mask = RTE_MTR_STATS_N_PKTS_DROPPED | RTE_MTR_STATS_N_BYTES_DROPPED,
+		.n_max = ZXDH_MAX_MTR_NUM,
+		.n_shared_max = ZXDH_SHARE_FLOW_MAX,
+		.meter_srtcm_rfc2697_n_max = ZXDH_MAX_MTR_PROFILE_NUM,
+		.meter_trtcm_rfc2698_n_max = ZXDH_MAX_MTR_PROFILE_NUM,
+		.color_aware_srtcm_rfc2697_supported = 1,
+		.color_aware_trtcm_rfc2698_supported = 1,
+		.meter_rate_max = ZXDH_SRTCM_CIR_MAX_BPS,
+		.meter_policy_n_max = ZXDH_MAX_POLICY_NUM,
+		.srtcm_rfc2697_byte_mode_supported   = 1,
+		.srtcm_rfc2697_packet_mode_supported = 1,
+		.trtcm_rfc2698_byte_mode_supported   = 1,
+		.trtcm_rfc2698_packet_mode_supported = 1,
+		.stats_mask = RTE_MTR_STATS_N_PKTS_DROPPED | RTE_MTR_STATS_N_BYTES_DROPPED,
 	};
 
-	memcpy(cap, &capa, sizeof(capa));
+	*cap = capa;
 	return 0;
 }
 
-- 
2.47.2

