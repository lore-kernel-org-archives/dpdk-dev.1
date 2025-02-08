Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE54C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2368140B9A;
	Sat,  8 Feb 2025 21:32:31 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id C3ACB40A8A
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:26 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso78178945ad.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046746;
 x=1739651546; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlSMeuHPqlc7SgSwIiAjm4w0H9XCZs6cABq03Q3YF9E=;
 b=tk6TGFVLQYEwKlsvtSmCmWRLK56zhW7Q4F7zxZQXGmwYHIMVM4jADhpGvpr/xhrIEW
 Dv8YL7L//1JsN90NGnDyd59o3r5IjBog1hVoC2acNA92x08dCcT7+R5XqzLIv1pMGhBb
 gOTFiqWEsFRzI9PMyb48Vbirj4CL0GLv2YdZqiOb7+FzdvJuyF32FaJXWYLRm7zLItUM
 Nu0F9uvegDX3rCHyGDv9WXdoDTcl/skjpCVsxiG92B9W+eCO2N2hJAM8S0UNuJFOnsar
 xOrgkfjJntbdsAKNpgXKLojijPXhHGXTETTqVb+X4ykMYwLBUhquVaeV03QHaJd+VQd8
 l0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046746; x=1739651546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlSMeuHPqlc7SgSwIiAjm4w0H9XCZs6cABq03Q3YF9E=;
 b=gJ+PCwHzV8CahxF6TuHsGfgbHMz2J7SMLsCH21LOAw0QslpMBCy4WOKSY5eUZ4m/ZE
 ZXubI+FWDOwFqv95IJEq/4HmS8Q8yBZJ+hJqc5yd92fkezXntfyl/VjPwoI9ERMFUVse
 rZj4OiAldFmX5G1f/l2uiaGsSzY0Rwp37BOw4DRM+tD0DsHZZFIW7QvJX9zIkxSatE4r
 HFlDevmKNNvxCYp6XgB7XJjrmzmd+f/N4IF6z7HAVsLW6ccN8ZNT4AErsj9vYYgq4D8t
 kQ0QpAkEhpvwFq5jn91VxJ8jRpTL6DkRPIKDBh3lti402VnHFEefV/GjTcmFEpfoBcW4
 EXZA==
X-Gm-Message-State: AOJu0YwbOn8I1+D43XR1qxJ+9I4U0ayjFlW86BzqX3jBLMzc79UASWtc
 WSD51XE1FCxgSziYOrII9SnMtofz4eC3wfrX78PEXwrT26cnpKKrZOZttr3Bd+1vTVfjXMpJIym
 Nwb0=
X-Gm-Gg: ASbGncuxHy05aR2CfkewH9Fb5xOM9DvlT2Gap4jD5ivEL6MPUdpjT/EMEPqHw9jLziE
 BxaJrzvAvD5473/WZJFxVRpDFBDGC6G6b0Bv9JAxKTZr7g+uKTZOWb7mkS0RfpwUi6+J2fvj/qd
 z2Yg/osc5yA/qxrM/fgVs/F26ZJgWxmcIHYCVeK4W/0fvxwOyQ7y7+XnI+bFzB1bugd+j2EXizv
 YHsL0mHr9S2anYDrIgjYBZwmZTuKPt70csx3mbTrjrwRO5nIHnDpWCqXhkAaMs3YFMVg4JpJy3/
 AvWyPb57ePYtTm3vNyzm7ZcmZa4JCs/lPgDbTzLVfesPrIwyyGUomlGXzvzP2m3ievjO
X-Google-Smtp-Source: AGHT+IH8Q5INUPz67DgAYHpFk3dAtKy1HLyuvMjB+TJNrjsc8FTO7Z5TDI8Ik9hFNcvsBGSeG9JKVw==
X-Received: by 2002:a05:6a21:99a6:b0:1ed:a4c2:a639 with SMTP id
 adf61e73a8af0-1ee03a3b9ebmr13176554637.10.1739046746050; 
 Sat, 08 Feb 2025 12:32:26 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH 27/32] net/cnxk: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:19 -0800
Message-ID: <20250208203142.242284-28-stephen@networkplumber.org>
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
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev_cman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev_cman.c b/drivers/net/cnxk/cnxk_ethdev_cman.c
index a7ccdfb756..75cbad02c4 100644
--- a/drivers/net/cnxk/cnxk_ethdev_cman.c
+++ b/drivers/net/cnxk/cnxk_ethdev_cman.c
@@ -140,6 +140,6 @@ cnxk_nix_cman_config_get(struct rte_eth_dev *eth_dev, struct rte_eth_cman_config
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 
-	memcpy(config, &dev->cman_cfg, sizeof(struct rte_eth_cman_config));
+	*config = dev->cman_cfg;
 	return 0;
 }
-- 
2.47.2

