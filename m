Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19C2C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:28:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF79240E1F;
	Thu, 13 Mar 2025 00:27:56 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 417A040E1B
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:27:53 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-219f8263ae0so7346215ad.0
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822072;
 x=1742426872; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WHAcwkeq4de46iS5gsr+OvVZUELVppf+gQ63Riz7SY=;
 b=S9s1wjSVHjvrkyRh8/zIUgn2Dn1xHlrjaE2todXLRJXwq6g8MgmPfN2/qMKqibfXYA
 g9SojE1g1lGP+o/Y2e+iyiLxorkgG7ZISjRFrLE5AbtE7/+RlTdxEFe0Diat7H/YUjsI
 SibLE1D5VVI9niQcubVvcjz0wsct3LVLHWZ5p9+5CriCAnkcZAs/JX4vhOsBqC0NWP7t
 f9yfFQKbr7aGavVDjZ40LftGNO5w1B3p4U+0pkWGLQGKMtXEX4E7w8+ho6MIu0l/R/D4
 Kj8oegBtwLoMVkOi7HwtKKwvQszkwADcVbbt0NEQWgcAlibI7/tk32Nfl67z7bu8UHkX
 /S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822072; x=1742426872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WHAcwkeq4de46iS5gsr+OvVZUELVppf+gQ63Riz7SY=;
 b=wLPoiQeqyBaOVcAPWxS4kGl9ZmaChdLmdYBfmigChu5mL6l18X5J9rjaViF76X4iut
 vSJCRaerEA4p8URpuLPuIHfjHbfi8FX3Ar98rR5HKhBUygw0B+7QfyeDf6YegRzKE5YG
 +3oa8sDTkn+nAR8r+KYTsiSkNOYK4ObCOTi0ZnEVE2tnrgNqxqATJ3CllA1Iw+VE0OS4
 hbw7xhpUstYBjfWCtqMrIYWDBupHcwJBYWRGK5Qj8JwRnh7VNioCyyJzHSRNemvenMF6
 I/cNbzDQ094bVDV9Wjs7su39dfHkUZu2MAAnLOoU0vMsqVYGPlGLJiQUUQbchWiqCpqj
 54xQ==
X-Gm-Message-State: AOJu0YxU0FTHieQm4r+ojaaEHzgLlig36xbi+MKxEvmu7y4BtRvf59EM
 sPhydeyVoOrooA/R/jasbxTby6tYgRvYWb88FzaApKqFiynRqT3Bv6p5tVY9iMJ0urDj+27/bQ2
 E
X-Gm-Gg: ASbGncvkBanrrLpfBVzFc5WHwKsbDl73+/66HDpmMK/HJJGFE7AD1j6AuUXeTXZT5k6
 bM68V4z4jBCx1AOj6UTxZWpKSSzdOJuylT7g+KClxzOxy10pRG0P+tPbSmDy6+SUpSIvtZXaqEM
 y8Pyq3agGldDd7UATYgf2wajHyb933H/vVgm6EfYSQwhGN9TXJb+mMPNZnyBABnFb2C68k6dS/O
 QzEsqoDC+EaFjGYLUsrfbKmNEwmNqihm9XS5cnZpJ38iqv0OT5o9ma/cgqYjVBFMhsal8/LvLJR
 YbW2eUfWBc+e4WGjQOgfbePHWyVlFMpUVUnz8YmgfwFUwtsCO+Tip5SLhtMsuYTb10VyxJC+4qZ
 mdKFBQcVprOOVVsvja+A/4Q==
X-Google-Smtp-Source: AGHT+IG5Q+SSEX7I7nroDmJMTZoNt97R4jHfxTKevI9vAVE+EdfiLjZGp4liVE6BzmatETmlHVHR0w==
X-Received: by 2002:a05:6a21:2d85:b0:1f5:80a3:afe8 with SMTP id
 adf61e73a8af0-1f58cbdd61dmr12870243637.39.1741822072509; 
 Wed, 12 Mar 2025 16:27:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm111917a12.73.2025.03.12.16.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:27:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [RFC 4/7] net/mlx4: replace unnecessary comma operators
Date: Wed, 12 Mar 2025 16:27:01 -0700
Message-ID: <20250312232739.228295-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx4/mlx4_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx4/mlx4_rxtx.c b/drivers/net/mlx4/mlx4_rxtx.c
index 947cae491c..a4df6f7bcb 100644
--- a/drivers/net/mlx4/mlx4_rxtx.c
+++ b/drivers/net/mlx4/mlx4_rxtx.c
@@ -638,7 +638,7 @@ mlx4_tx_burst_fill_tso_hdr(struct rte_mbuf *buf,
 			thdr.vto = sq->buf;
 		/* New TXBB, stash the first 32bits for later use. */
 		pv[*pv_counter].dst = (volatile uint32_t *)thdr.to;
-		pv[(*pv_counter)++].val = *(uint32_t *)from,
+		pv[(*pv_counter)++].val = *(uint32_t *)from;
 		from += sizeof(uint32_t);
 		thdr.to += sizeof(uint32_t);
 		remain_size -= txbb_avail_space + sizeof(uint32_t);
-- 
2.47.2

