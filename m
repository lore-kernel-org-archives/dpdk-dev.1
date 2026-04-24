Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6049FED3CC
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 14:28:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 959A0402A0;
	Fri, 24 Apr 2026 16:28:02 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 459A240274
 for <dev@dpdk.org>; Fri, 24 Apr 2026 16:28:01 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-50e5dbd8e0eso54176821cf.1
 for <dev@dpdk.org>; Fri, 24 Apr 2026 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777040880; x=1777645680; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OC0LGiOmRPCqien9UIsjNAZ8aI8axQU43nyYErO3huc=;
 b=boIxwSlmY5a+ZHhSX20wO4l4ExeWxTLTaVswodFSUDD/Thg/gK3UcUwYK2ZqNcyq1l
 1c9XH15vLFtY3B0H/Ds9DcZIwpPyDUsTav/gBeCwy9eFknrRL45Zb9AkJpvBYvwfSJgm
 NVqT/8VfUpVPR/ipJY6HtrdysUGwvTlW86u/WQQE19TY7wpbKH3qFrsGszk9q4uarZlx
 v4gV3jjs4WxOfm8t4dPs6oAF/hh1BAoe+C65N8BBMHCxeh7NZ1B9TbdfvsJ67QKdOXp4
 fasIG+pnZ29txDb+7MNXdi4XYGdul1l4jo+93kmsCP5R8qOvyU1BVYq6fBKAtmlTAFB5
 pb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777040880; x=1777645680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OC0LGiOmRPCqien9UIsjNAZ8aI8axQU43nyYErO3huc=;
 b=KEBzZN75aSuZmbfYUeWksAZYuUM5KBqpJma7G8QrzhfFGwkanXnEmTZDFHQksEV9o/
 YQ8q4gqJeIj7YB3+Src3xb6kozjfQEzj9uhBUQq2FODJltHvFCI1eKUm/XzxFDzS5/M5
 0HiHiJxZ+cw9fb29pb6AkKVlf8vdEVXTqtF7yLVYApVs4dXh7BStclpq3spYgRssp3R+
 RJt8nb1wItDRQhm57OXh5uvDbgZn0AKG1levx+t/yKQjR5MfwIZyTW5Dkzo632Jc3RAR
 Eem+bkXaujRaA6jypOv7Aq36Vz0qPsPTWeRBUf9MRMWkfv/QTIis6wHDXsLUJJyaPOAH
 xjhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+suxSHwh5HrZj36fElifP5p4Xi7gMvA+87Ng9F1E5YFGFqurcB7zKXJmLrpSaadcjDhew=@dpdk.org
X-Gm-Message-State: AOJu0Yy12nbL+YE9jv/4MkR6SuZbqJhe9u5yEsDw+KTLgeo19IbEqzEA
 quxTaCGUoZfRUyDgFtlQJ853ubp8E8IN9medz2PKz79NrYSp39xqdssw
X-Gm-Gg: AeBDievlhg5pOFVHU2UDVNf8fDjsnq5TvoyCzlBXCJicepZc6fGJAqH1QuJQ3NZVQa3
 lW11RMzLz60NSN2wELcmAlFHOR17RK2UaVI7Ks6w2RX0aHbBPlK0aXEQD/PzQlxJWGP7Qa2WsaU
 8PHKfJhzRMRPeiYsqDa0zLtlUMDY83wTg6KDsEmtz1xMYeKDkoWRSaJVz16XqxBHUEd3/ifnDg4
 dU7/prMWJKcfYtDpPjUKqEn5vK7hccSp8c/jYpN7V/YOuGdclYs37LYL/nnForme3OwoZIrQRMK
 YLDQO56ar77lsoM27pkCvbYBVZsRR1TgXckgXcQB0rRw3Dkx6TfcalXo9BMZBMsgxW8rMWCOeMZ
 h7OuJEdoy+CLr6FNkiu8+sdfap9bxV/aBFj796zbxWqs7m4O42O3ttccM1fjMsetGhVXsfeev6k
 cPaICUwKjAGsq6efRBVUaBtDxrCq81/78XxY5/PmqZkNtubhnw/mJzWOtdcRtPgiK46P2OJ3BNv
 73cG//a73YJwhNYxejZWFd9xh+UOBSyNg==
X-Received: by 2002:ac8:5788:0:b0:509:68c:634d with SMTP id
 d75a77b69052e-50e3682797bmr481375791cf.10.1777040880331; 
 Fri, 24 Apr 2026 07:28:00 -0700 (PDT)
Received: from LAPTOP-T809MHP1.home
 (bras-base-hullpq2034w-grc-10-74-14-173-40.dsl.bell.ca. [74.14.173.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e6123c3d7sm128824621cf.12.2026.04.24.07.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:27:59 -0700 (PDT)
From: Rayane Boussanni <rboussanni@gmail.com>
To: dsosnowski@nvidia.com
Cc: bingz@nvidia.com, dev@dpdk.org, matan@nvidia.com, orika@nvidia.com,
 rasland@nvidia.com, suanmingm@nvidia.com, viacheslavo@nvidia.com,
 Rayane Boussanni <rboussanni@gmail.com>
Subject: [PATCH v2] net/mlx5: query hardware capability for max lro size
Date: Fri, 24 Apr 2026 10:27:32 -0400
Message-Id: <20260424142732.1904-1-rboussanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7z76boxf6nf3hzvspmc76ldy6idbynhusjcvlik2trkccupfiw@5ldoyqampej3>
References: <7z76boxf6nf3hzvspmc76ldy6idbynhusjcvlik2trkccupfiw@5ldoyqampej3>
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

Resolve a FIXME in mlx5_dev_infos_get() by dynamically checking the
lro_allowed flag instead of unconditionally advertising
MLX5_MAX_LRO_SIZE.

Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
---

Thank you Dariusz for the review!

 drivers/net/mlx5/mlx5_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_ethdev.c b/drivers/net/mlx5/mlx5_ethdev.c
index a29cdeeb50..734ce0e60d 100644
--- a/drivers/net/mlx5/mlx5_ethdev.c
+++ b/drivers/net/mlx5/mlx5_ethdev.c
@@ -363,9 +363,9 @@ mlx5_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 	info->min_mtu = priv->min_mtu;
 	info->max_mtu = priv->max_mtu;
 	info->max_rx_pktlen = info->max_mtu + MLX5_ETH_OVERHEAD;
-	/* FIXME: we should ask the device for these values. */
 	info->min_rx_bufsize = 32;
-	info->max_lro_pkt_size = MLX5_MAX_LRO_SIZE;
+	info->max_lro_pkt_size = priv->sh->config.lro_allowed ?
+				 MLX5_MAX_LRO_SIZE : 0;
 	/*
 	 * Since we need one CQ per QP, the limit is the minimum number
 	 * between the two values.
-- 
2.43.0.windows.1

