Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E69C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D95C040B9F;
	Thu, 20 Aug 2026 07:25:06 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id E2E4A40E18
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:01 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso2213042a91.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203501;
 x=1787808301; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SrneBVNvtGWnMc4B2t8jukY1Zmfrp5JyVcjD9lSeh0E=;
 b=rTieaaFcFYbk7/5828WyYnsTN+eRFg1WTCDX1NfRc+AWyRUJV83aFTvbc/WxODTC6q
 DkMI0QIj+uYfxXA20FZhJgsawkK6WjTRGo3hVK9yjlNhWpcs3sEGtkUMw8/7WXPrjCP0
 rXrtWWg114OAbpn1M72XcIKI9cTtFPga62I5yGVo+WEF/kGWk9J5o3mReZFCgXIXzF2i
 Ye9x/VHOfT2gLQ24oxgPTO9VE0BIY2AAItstzZi9AF7s1t9xCiQ/G0762Exfqmvz4HZn
 RrQUBKC1BzwX7q44+LHLY8YNn1HWBiYdQOICRbNPXuiA4rNf06KGmOOKX5yt9k0JDlhs
 lt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203501; x=1787808301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SrneBVNvtGWnMc4B2t8jukY1Zmfrp5JyVcjD9lSeh0E=;
 b=d6/zKIaPpzc4FO88LkMYcqdmGru5/5bporqqvSLdg3oSkzQiEJwGQgPFwYtR8UeReO
 ckR0Gi+GZ4S7lJ55BH2Am3LyuhZj4fkD2/GSwn+WC7Kulx4lKPBAedAnsfnzUFxkYgzh
 d7Hc0REYYRNTg7gNyX1iM6jzC1Wb2hKQ9lwjpjWAXggs6MBVE4km0ZWhj7ZzohcohLEK
 t0d5P7LPa3gyOGGqF8aZiIOyt1BkZhPQoL/Wa9ae9V9+sQdXZnSeWnsXFf+6IaxkB7dk
 N5GbQWwuBB4LvDopUuQN+8oh2EkNib3kQ0T9/M6gVeMqohcC8IpUdfhpyCU3711T03ES
 GsoQ==
X-Gm-Message-State: AFuF++mKkrOv2BftqUpIYp/tjh4zTuUIErr79jZ/GpPxpzz9F6qnrpqO
 cMta0+h83suWX/SzljZ+NNnSm8f+/MIfdbbr6uV6lDSlLT9SzJYpanI+KPTqqoGfMGMAQ1uNLXN
 KZ/4Y
X-Gm-Gg: AR+sD13AvtN3kfddLBWOVF5fekEbOoGfRDikTwgAAe8dkGvOrUnqnpQxckSiCZmr8zy
 3iXa6nfN8YFeRCEzL7YHBlfU4cUNpWMYG8d+dszJQuU2+kzJxo997aHK/VaVH4oz6GJ1IK753fy
 SDB2B3FBbXCUUsHQd9LKCIOui+TWX/k8s+TIAa7/LhAPFzJa/fazwba7BeW5saDCzqFBO4JdJr7
 SgTP9wb0YaE2QZvz0dYb+VopPtCW/HGt3DNvE1Z0p+omUGluGrdyBOhLVzUf51m6iCWfytAy3m8
 QVswPI759SEcHza29aUcuuh87RsTFXmLn47ogdqtdgsR8B1/N27E/Fh30OsZleKv76DzqkRANni
 uYE2V5aXT+VJwbUyGv18az+DgtL3NJdNY6NImAHqcxzsvBqB91IMClyujKkzwB++qU7bgs8iRdw
 dl1YU/vWKHoFyXylRP7vweIdJ1s4RQITYXAK6NHrNhNbWoBPGvBmhtyqVgtU0ri3Z7DK8HlHUf5
 nU0jy7AgQXXUrtTXQNeUTt1gjQ=
X-Received: by 2002:a17:90b:5250:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-395810b57d1mr18810778a91.11.1787203500978; 
 Wed, 19 Aug 2026 22:25:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liron Himi <lironh@marvell.com>
Subject: [PATCH 32/61] net/mvpp2: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:22 -0700
Message-ID: <20260820052251.1453273-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mvpp2/mrvl_tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mvpp2/mrvl_tm.c b/drivers/net/mvpp2/mrvl_tm.c
index c5046490ae..3fb343506c 100644
--- a/drivers/net/mvpp2/mrvl_tm.c
+++ b/drivers/net/mvpp2/mrvl_tm.c
@@ -437,7 +437,7 @@ mrvl_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
 					 NULL, NULL);
 
 	profile->id = shaper_profile_id;
-	rte_memcpy(&profile->params, params, sizeof(profile->params));
+	memcpy(&profile->params, params, sizeof(profile->params));
 
 	LIST_INSERT_HEAD(&priv->shaper_profiles, profile, next);
 
-- 
2.53.0

