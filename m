Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E3CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:37:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D66B40E40;
	Tue, 19 Aug 2025 01:34:29 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 3A3F940B9D
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:28 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a1b00a65fso23971315e9.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560068;
 x=1756164868; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktZjdMskytau1nlXtSANM1bBHwDHBOtVDH2jpdJhIwY=;
 b=W5xC+PhCIXIw7lJBfQ50mLsYeSXVnABddSnCTLfPdnDi3RxdoqZB+GuPMz6EcA8dfH
 Fe2cM3xzdiAKk9+Td2wvCCGEln2i3nw0eKJQGFpvGb/gB6eZrNdoS07anzv23ixAov2t
 s8z9EZ4wmLcHvcladeqMfG9rIu1YGyZwAmM4EiVMibhviWGb3SOEDClrE3qUfnQ4EZU8
 yK8sYfbmlC8YWVEXKNgTsYyBonpu2Q0YZq3Ua92mhpjmuRaeBtha59RdiP5iJ9HAaxFK
 fRZ0Q4SmiJK5bygEtJRoHUH9t4PFPVrtcO2OfXRw735tLhMWgA7PkiIo7wDiz86n3z4I
 0XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560068; x=1756164868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ktZjdMskytau1nlXtSANM1bBHwDHBOtVDH2jpdJhIwY=;
 b=o4csvNsnNF6OaM2bIrqjaoCLPw0u3OhtRASCmz/xvfaFSNkD9oxubBiIr2AaUZOBx3
 gQcXxgl3JIAR92Aj0eQDV/E+jH8t8Ih0HEHlDxOPL/5aGec7A3VRzg0GsXYBT7BjCmKu
 WL+VkoqliKb3meXQSx1ZvcakS6tEnRR+HMddqHvyqWmkPhOpfCWDY2EKPCa9m4lPN8Di
 ReDz79teTWNU/adFcjybY1CxeftBERse9lnhZ2q5egtSQVjEO+kws/CHk3/pjBafILEp
 Rz01dSby5QTCMMtdUsSBQ6Db0jWtZ2L6BbvKSv1NjGHYZj/KV3KL71N+72u8v/m7zRis
 ET6A==
X-Gm-Message-State: AOJu0YypCk2AS5EeXN/bJyHZ0vKWYyVq8g/m07R7683sXjBPaTT3V7oI
 7fYhB/atxmhCPh0Hglgk/freWtD4jlMEQsEYEgktEW+li3GEtkSpiNtq4TqQVW+MMsB/cTcTwwj
 aChJI
X-Gm-Gg: ASbGncuu54o/fOPfUvBHIFtk5uTY3rUr/XaGcDR53yZ5cryOB9opgrYlvQguYptB8qU
 bTHyiyp1+hFRaakyBFPJ8j+QCQshdL7YH8pIBm48c9i05nAnlkQh2sy6o5sf89eVkcxwkGeWLBx
 bcjKkCOTfcEO+pNCbxYcHYJfl2GAZSAZSoUTmxRQMCvZzV+p0ouxP1JQz0o6rJbbJ1ru5Jx9Ysr
 QK3TRHBL6BI5FoluF+AVO95++4vNVCJ0fHbfPOhH3bicCYeb9BNtelZxT/AO0pV2YQd5RUcO+8j
 KphTXP98N8V9uB3S2gqY5KIktgK8lMpZWKxQI3vxd5JFwgdeVqDH1xNXh3/SZ89ZHX3PRXWEZVn
 AeeWk2yfhWPNBIYwmRIybkmCkBP37h7CWVf8rMlgHk9nbLX3b5hSl+n88jkk2YTKKkyWPkFu/
X-Google-Smtp-Source: AGHT+IEGXOh8hKiPJ5QhqvjzqHfKNXEcuuFzdatvVurUPWapvh5A+WNvS5E5Fx2aZCIQIoO8Xw7cZg==
X-Received: by 2002:a05:600c:5250:b0:459:94a7:220f with SMTP id
 5b1f17b1804b1-45b43e0b06fmr2100175e9.26.1755560067884; 
 Mon, 18 Aug 2025 16:34:27 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liron Himi <lironh@marvell.com>
Subject: [RFC 46/47] net/mvpp2: replace local definition of FOREACH_SAFE
Date: Mon, 18 Aug 2025 16:27:57 -0700
Message-ID: <20250818233102.180207-47-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

There is now a standard macro for this.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mvpp2/mrvl_mtr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mvpp2/mrvl_mtr.c b/drivers/net/mvpp2/mrvl_mtr.c
index c07ac95ddc..27596b8c99 100644
--- a/drivers/net/mvpp2/mrvl_mtr.c
+++ b/drivers/net/mvpp2/mrvl_mtr.c
@@ -505,13 +505,9 @@ mrvl_mtr_deinit(struct rte_eth_dev *dev)
 	struct mrvl_mtr_profile *profile, *tmp_profile;
 	struct mrvl_mtr *mtr, *tmp_mtr;
 
-	for (mtr = LIST_FIRST(&priv->mtrs);
-	     mtr && (tmp_mtr = LIST_NEXT(mtr, next), 1);
-	     mtr = tmp_mtr)
+	LIST_FOREACH_SAFE(mtr, &priv->mtrs, next, tmp_mtr)
 		mrvl_destroy(dev, mtr->mtr_id, NULL);
 
-	for (profile = LIST_FIRST(&priv->profiles);
-	     profile && (tmp_profile = LIST_NEXT(profile, next), 1);
-	     profile = tmp_profile)
+	LIST_FOREACH_SAFE(profile, &priv_profiles, next, tmp_profile)
 		mrvl_meter_profile_delete(dev, profile->profile_id, NULL);
 }
-- 
2.47.2

