Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B3EC02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CC6D4065C;
	Sat,  8 Feb 2025 21:32:10 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id D296440655
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:06 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-21f40deb941so60975405ad.2
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046726;
 x=1739651526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ic1SPNNb1AgPRNP3Om3M4+kD0f1b1EuoCgAXb69+MYE=;
 b=E0GZ5AzNN/4mKdkYhj2X09Vjcm0JlANcn2UsIAqpDaVpKa+0LZ4qQEs2/hkoXcwwX6
 vhu9FMLrTGBw0QfHfF6FAB+AT1sca1FzsnWL7Q3C3uciHpiTq80gNmyrSL4D9vSRpULn
 afOAFBormSX+boHwKJrTCxzq2S5NfIdlGeDO2334HsgCEoaXH+4ZKOMejj5fuNUiW/vA
 aCJA00HgjxRbMdEoVoaHWeBD8RZS9sSYWh+XdUlICvsLIdPq2gfswE3VMh2vrBCe01m5
 0tPYyuD/tUFakODHi1hjQTvIUyZHi7YFGG9hQc4FXl/Yt82hhLFsqsJz7yMOh0DEHRg4
 1X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046726; x=1739651526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ic1SPNNb1AgPRNP3Om3M4+kD0f1b1EuoCgAXb69+MYE=;
 b=gqXgRYkfxVAsjbWB6kuVEBFXENbZDwSD3O4853vMWOwLB4Tk3jG7+56fZCGO4nUjKU
 JzbtUx98WgFB0wOpffQytNyAfNQrNu7RFdSa+zK9YOSfMXAnIi3sMDws8MYjQZK57+2W
 dVOSkJdxoY2bySpePdhhr96wd9W2NV6mmmnfELjbW0iry0KLuAvDIHWGJxmdb1Y2AVYO
 qBaRc8hDiUWRv4miOTfHXinphgfD6gCbzLfR4XvzU5eu0qYgHJrKamYKlmyCclS93+ef
 pmMnvJ+AU/UvipwVjI+opqPbOVJDFgtLWIsiOItqAYsY1JaIVXOis6gimdRqaD0KYMuO
 a1Tg==
X-Gm-Message-State: AOJu0Yx55C+cZGcv/Zh5y+YpPFR2BCtWO03XfCJJg/AFvhaiF1eWC6F1
 69PLASWseCOy6IE31a6y6oVXxgoc6yVk2hRm5uHE2pPeIkxyDIe2pMX4xgxFdv73huoX8EiwWv8
 /AVk=
X-Gm-Gg: ASbGnctrBJnxFoibtcc5f86JEosuZM6hFCPVPVe/FeUGi/qEAzX3NjwpYhA2YWYirJD
 Cwj3Qc6HRyPAQBqritFg4vYRWdiXQNDyFTuS7jONrQeEb0Ri40v0rS5zHgMCbOpQXBAUw3qqlc0
 UeNBy+F6LafBYuHoqbe+53ov8WrnS2K1mC3LnSmMzb5HMjkUia99tdOi9hv/NJbN/q3+ciOlXZj
 3YdE0OFPPPCHE3q6O4f6YKL69V6n2dIo9LSJzP7RNqI9uN5zAsJcg/o1Fdy1ls15lh43gsEJX7z
 RVE9Bdb03Q7uDA9ea84IbGyh4qQx/SzyjbrtHEepW3dY79X5XSZN+2k7upI5v7qxXVKY
X-Google-Smtp-Source: AGHT+IHHz6J5jCvXuR5CqcMBzfDsgIVCNoHaI8azXqqJFbJsVzEoWZSt9GO/XwBRlUmUYVofElVYFQ==
X-Received: by 2002:a05:6a20:c909:b0:1e1:9ba5:80d8 with SMTP id
 adf61e73a8af0-1ee03b20a10mr13958929637.33.1739046726017; 
 Sat, 08 Feb 2025 12:32:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH 09/32] ml/cnxk: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:01 -0800
Message-ID: <20250208203142.242284-10-stephen@networkplumber.org>
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
 drivers/ml/cnxk/cnxk_ml_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ml/cnxk/cnxk_ml_ops.c b/drivers/ml/cnxk/cnxk_ml_ops.c
index d93c31535d..9958945670 100644
--- a/drivers/ml/cnxk/cnxk_ml_ops.c
+++ b/drivers/ml/cnxk/cnxk_ml_ops.c
@@ -1398,7 +1398,7 @@ cnxk_ml_model_info_get(struct rte_ml_dev *dev, uint16_t model_id,
 	}
 
 	info = (struct rte_ml_model_info *)model->info;
-	rte_memcpy(model_info, info, sizeof(struct rte_ml_model_info));
+	*model_info = *info;
 	model_info->input_info = info->input_info;
 	model_info->output_info = info->output_info;
 
-- 
2.47.2

