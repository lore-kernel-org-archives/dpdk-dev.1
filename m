Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2298C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07CC740A7A;
	Sat,  8 Feb 2025 21:32:30 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id B2B9C40A7A
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:25 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2fa5af6d743so478688a91.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046745;
 x=1739651545; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRdpvpxDVZKFBK6eqg+ttncqs5Ud8HtjXdCbUeGdT+Y=;
 b=fGKXX0vCGopxekgQr3kkcX4cCi7TIpRHy1EXoMekkl+IqvBX78p8Du83PAnLYsvYe1
 LbA0WOeJl87LYkyyvEfd2ieS4tqpfH+Q7ZTbdTpuy+ZSvEU09m8Je74gUmSMze9WS/t3
 +luOD/DC7mMo0gkQjF7aihyLBsGF4trw+bzuC/EvKPpjwit29A5dbH0c9M7Bs6to6hnY
 6R05x+Kcer7N2SwKx8Qyq0zo5uWZIp//LtE7cwRIUhjN0hDwh9guQ+K26rgHskKcQdqg
 lG6HDBLqs2eGb6BVjuZ6WRXJ65ZXRU54jupNZoGjF7qut3vJvOAXqO7daC6mMK+eAUWW
 6bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046745; x=1739651545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xRdpvpxDVZKFBK6eqg+ttncqs5Ud8HtjXdCbUeGdT+Y=;
 b=og7Mzg7ZsE6XyVQ1dtwMiit+aw69/mVHcEn5zbDhnsjfMyW6vbE9CbjbGI01MkQXAO
 f3g0WCwKWSWQlRwd+JpGXVUzhNoEozGkIiFL4dfbEU7oGkOUp+garVa/IEg52ucHaYA/
 JznuX4VKtppacxAP5mcC/oaeQJzbw7pgXCZLH36t3T7Yp303jGydXVUSbccd+WISoZEH
 9A1BlQ5F+yDLhbrfVihqGx5lP0QAp0E4mJvG3lsJjXtk09N62yEU7c/X181Cw8u0tmQl
 2nlM46o6b8/N6Vhn/iUqbRX3kCOddf/KH+37w+spl8apk3geSciM9CPyYgH/EKlere22
 X2zg==
X-Gm-Message-State: AOJu0YySU7AkbHwXMfrFGW75P+M67TW1Q59hJDw5pfck13hhnBuTZjCo
 7WKeGF2h9d0r5rkFudro0V5Vz8DtiQdY2ioNg3GqcMQmwFSOG816BZX0Li2b8U9ovAmn0pfhbeR
 afAU=
X-Gm-Gg: ASbGncsY6zne2rXqcunj/50SQ2Ls2jYl2qoHkp6BujkdCY+EqK7LlY76Auw+E0K4acQ
 fZWx7t0ADajpRrIcpcoGIywh+7EOMAymXT+sq53v4UyzVERlYyF40SfT73rXiXrOgaxpWAl1+Nd
 vygv9C1vWtT3w/I8xJZX8TWeUkyW02jlZS4a/iXopxXHPWHZgxTp3nYRTNzOm7UJcd6ctOQRKxc
 cLDRawtdFmzV08Fx6E/fOOvNmyfFk08IGLFoGj7jwqY0jGChGyf41EIU+IwssXKF/ZNDj/viyb+
 HtkpxljJuVDv/dKCO7ERYwXcCsxHz0fd27dc8wQ6/6z2LeFgebPsdywUvw1qtW7+RhmU
X-Google-Smtp-Source: AGHT+IHlZfHsGj2AHmv9ze7nzWVUWOaumLUnV8klbrXc9CHfWc9wqayOLldTRUkj7/Yt/TbjKPG3YQ==
X-Received: by 2002:a05:6a00:2289:b0:725:460e:6bc0 with SMTP id
 d2e1a72fcca58-7305d2ac0admr14302757b3a.0.1739046744956; 
 Sat, 08 Feb 2025 12:32:24 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH 26/32] net/bonding: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:18 -0800
Message-ID: <20250208203142.242284-27-stephen@networkplumber.org>
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
 drivers/net/bonding/rte_eth_bond_pmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 467f7fe7ea..c8fcd4a172 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -3222,7 +3222,7 @@ bond_ethdev_rss_hash_update(struct rte_eth_dev *dev,
 	struct bond_dev_private *internals = dev->data->dev_private;
 	struct rte_eth_rss_conf bond_rss_conf;
 
-	memcpy(&bond_rss_conf, rss_conf, sizeof(struct rte_eth_rss_conf));
+	bond_rss_conf = *rss_conf;
 
 	bond_rss_conf.rss_hf &= internals->flow_type_rss_offloads;
 
-- 
2.47.2

