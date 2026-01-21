Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ADC44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9F6842DD6;
	Wed, 21 Jan 2026 18:05:49 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 0E0FF42DD1
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:05:49 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so647795e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769015149;
 x=1769619949; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68RTSi9kZEILOB5zTnaZUFTYtN/rudtaD8eOdciQn64=;
 b=i1FiXuytlfXtdn1S5409sKSwUw5N7eLNterRxyryl6u9w7KxGn5xxACNPGkYd5UCdB
 DILVtPP9YNX828nr9x+9EO9NgBqwO3X0l5m7Hvvfcy9GL+13TSofIqWVIIQwndpt7GWN
 HShXlV//SSXGr2E7hEZV94m2PijTWs1Z257lY6XqOqxw+3oRF+dGxDLpkn5uNcmzwMLs
 tNTedTvJdyGxDnIwA4LjJgpgTz8gVXUFtPbPHkw8t1gi2K/n4rOwUGg8QsbaNi7zjvas
 w7uVZV3e3TrkeHPO5WqYmpBxDLKwyy4MaMzFTd4DmdLSGuP4P3T9FG+lhIM52xicz30R
 gG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769015149; x=1769619949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=68RTSi9kZEILOB5zTnaZUFTYtN/rudtaD8eOdciQn64=;
 b=wWUDxCFVND1hmKui1JLSwHSpZoHgV9ZJWq99f5/f1L/BccfcWw62YhcL8bTBGdeaU3
 cCG3LlfNRIuIA9TQc+2XRWmK5uPy+QtXVph26RV3x1L3fwAkGqTJyHCKhXdPcmy8gyj1
 kZkevTgMf2ozYULwWKGOhcYIeqoDcDcCUGLdC9E5UHo91PNOm+VFY8shiKfrb1BL38Qk
 bG882uI2/nICehSa9EsW9DBza142KG44KYW4gth7pvaHBWoc1afRuAfk++5A3OWYBmJB
 p4AilqXX06WHbhq00kAqgnJmH0dp9aSJ2ligfpzZQJwmXX0JtMnHpknGFOz69tAEVqIX
 nboQ==
X-Gm-Message-State: AOJu0YxdY93z88F1XChgrWMjmWRl3PXgbr9m+zgrdmyssa5TjRj2fqga
 oDiXpwDHYDyNNEuPObMhtgDnRfzYd1VEexsqlkCBvbVmOeWpOABAoN8JWVviMJ5AI1bZHidMn/o
 8i+WMzZI=
X-Gm-Gg: AZuq6aK5pg2yvjjOXPzARse9n7vP2OfiXKmY7KkqOvV+CR/DwvRcRVoJ8pLv8iQxnbY
 oFkB0ELfDcjlOVm+mS49OHRWFX/g9ZRrjEe8m97guUVXjjMEFZgpJWfLmA4gh2gYwaanv6JbUSP
 C7Bx2bcIC5p2M9pppeXvz6BPftSiZBu5CTKFsOEW3nAxw6VKJvMq8Ope573PtzGPUsWvaRKrUgp
 W9lkyrjpy7JNTq1QJBvxs3tfdrv3PhRE8nmPSMCAqKaulFPm0Rj0Ne5Iot7aJ8qgNV8LqPS2PGu
 jFm/nzU2vWRRp6rl1Mv9MoDkOFkYDpRDaIYEfEYq2ZtPKSJU+dF+ML4UUX8v0gOiKQGHzS0Xsw3
 K0OQye/h9OgyBx2EF/BE2PEHMW2UQs1ALY7JT1SEZiTieR3c++UTrisbFOwi+otKap/C3jhRg6A
 cDlkpY/ckZhYfCDE4lxKnF/BFcHsKvDUEe+7ziy4DQsug0M+8VLQ==
X-Received: by 2002:a05:600c:c4a4:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-4801e2fef34mr284752485e9.15.1769015148660; 
 Wed, 21 Jan 2026 09:05:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c1e381sm25653555e9.11.2026.01.21.09.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:05:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 1/4] examples/vhost: replace memcpy with assignment
Date: Wed, 21 Jan 2026 09:04:54 -0800
Message-ID: <20260121170540.785735-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121170540.785735-1-stephen@networkplumber.org>
References: <20260121170540.785735-1-stephen@networkplumber.org>
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

Better to use structure assignment to preserve type info.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vhost/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index 4391d88c3d..ac888348d2 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -405,9 +405,8 @@ get_eth_conf(struct rte_eth_conf *eth_conf, uint32_t num_devices)
 		conf.pool_map[i].pools = (1UL << i);
 	}
 
-	(void)(rte_memcpy(eth_conf, &vmdq_conf_default, sizeof(*eth_conf)));
-	(void)(rte_memcpy(&eth_conf->rx_adv_conf.vmdq_rx_conf, &conf,
-		   sizeof(eth_conf->rx_adv_conf.vmdq_rx_conf)));
+	*eth_conf = vmdq_conf_default;
+	eth_conf->rx_adv_conf.vmdq_rx_conf = conf;
 	return 0;
 }
 
-- 
2.51.0

