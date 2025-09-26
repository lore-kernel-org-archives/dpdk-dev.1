Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F2CCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 15:58:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D29F40677;
	Fri, 26 Sep 2025 17:58:10 +0200 (CEST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 652C740261
 for <dev@dpdk.org>; Fri, 26 Sep 2025 17:58:08 +0200 (CEST)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-62f4a8dfadcso4133587a12.1
 for <dev@dpdk.org>; Fri, 26 Sep 2025 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758902288;
 x=1759507088; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P2B8mdsqQ29CyvVxU45YrA5Ksm3McUOd6UlO2VdJofY=;
 b=NbfKU5b/tSorZci8gy1sVwf4UfYiPap5cHBogeS1tbaV0t3w7XZorHe90vCD7qHLJO
 AMnpc2FYCQwcumkjEzyJMRHVDueYWaB/Z3Er9wslgfDktyGFVcZmuHQcv4AZSMHPwoaI
 wkSpaJsvEIeGZWf7yEnEvHIYNP/6gDyv7P7TBJ/3/IHYkAnYl7MERTdOWuRwD0icMl+N
 X3ph2p3Q2v5H3rp0o0dTvTr+08Zj/xHxvssTxW0ChHl4o1lee8Glgbg8WXFfEqKiDuX8
 9Kq06xR9h0JCCNvZBxBR9vB7+ucxbuUcL9hJCoEFI6rgQfdT78BtpLY83qNK7ORilCFk
 Rjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902288; x=1759507088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2B8mdsqQ29CyvVxU45YrA5Ksm3McUOd6UlO2VdJofY=;
 b=pLOUJFbK9T0Qn2yM3FPeZa9PuXR8vvDAsurmIbO8KFaxCRk1vc+yYEnkZgMji/cwcB
 ns10izJo2z0CCdSywkObIVHBgw70RRBIPgcMlNpI8+uGOiNBgn/s9Us8Teiuuh5k1Jap
 pnNzSHh1L636z/61vzBzwaFUau5rWKzifHZ39s708uQ8RWdkxDUuP8joqFpbHq+ntPfe
 4f27VWgCl4HZCB6YHkbLxtABzt3e+7HCB1WPiWaST4ZhFgbMkQM5oRzvmHy8Lfq8zbl0
 9fj/lhvuR4rG+Q55T1nCaI6SOj+1QVGbqJn+oQOr2rjd4ScgcNgtjgY7nPjMNeQO4bQ0
 BmSw==
X-Gm-Message-State: AOJu0YyUU2Bk7xXaNXPedrMkpGou7CODcwlMMh9XpOh1WgeasvCvECnI
 kXi5GSdnc53U03pkP9uqqYlOtK4WhZDLlG3sOQbThut9gSnyk28aJFg6iWj7wxNEuRyvkvRMX4P
 oJwHukZU=
X-Gm-Gg: ASbGncv3iGU27At2PWUZ4JYnyQK1E3ye7prQskKfwwq3agnCGC0X6t0IdfQG/8SQntA
 gYrydTZ0VJa+64QUf6yQd0N6GyYBPoiKKihU8jjg2VLrccoCilYHGy4Wk8+JegfAEVoP/lb0+5p
 hRLZk0So5GkHxyKpqZtlPi23EsVfEVml28zp1+pbTNkBRiGJ6CKfBoHtBRixKOXZ7ClJIH1X5hz
 xe/oXiPhq3aig3ZhfUi8dsEp6P9y3QfYqEqYLHdoakFXVfyHQrvuI6ay9IRCcT0tCWNX55TuadS
 2btulLmeDdQY8cSNSmbjzCt9PZRkitOPkk2o4PCNFMfKRZqjv6HMI9Ccjd56cz4VPYLLrGCi/GV
 NIpWWtWmfCGNVoyforhcxf8sKdN0e7hwOeuPgbZmF8A8TAc066z6cDbx8zpQo+z5RG0QciunCoa
 +91CbVj5c=
X-Google-Smtp-Source: AGHT+IHii2rOhG4xt236hibBUC3jW8uS68abO+2YnW8UY95GT81mSr7Q12aevpivuz0ogiPY6XVWKw==
X-Received: by 2002:a17:907:1c15:b0:b04:6fc2:ebb9 with SMTP id
 a640c23a62f3a-b34bef95cabmr890281066b.45.1758902287855; 
 Fri, 26 Sep 2025 08:58:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353f86f98bsm389099166b.41.2025.09.26.08.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:58:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, longli@microsoft.com,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH 1/2] net/netvsc: make da_cache_list local
Date: Fri, 26 Sep 2025 08:58:00 -0700
Message-ID: <20250926155802.398869-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

The list of devices is only used in one file and does not follow
naming prefix convention. Make it local.

Fixes: 9a9d038c782e ("net/netvsc: cache device parameters for hotplug events")
Cc: longli@microsoft.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 1d788f3fb7..5b9b54c068 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -102,7 +102,7 @@ struct da_cache {
 	char drv_str[];
 };
 
-LIST_HEAD(da_cache_list, da_cache) da_cache_list;
+static LIST_HEAD(da_cache_list, da_cache) da_cache_list;
 static unsigned int da_cache_usage;
 
 static struct rte_eth_dev *
-- 
2.47.3

