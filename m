Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF01E9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:06:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1564A40676;
	Wed, 18 Feb 2026 17:05:14 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 0438E4065E
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:10 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so30117075e9.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430709; x=1772035509; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MVTtLeohIMCELLOZJmg1TbIuGorxGN7ZhN5WtX3kd4=;
 b=jS2DxCSvSoCHfw7grqXciBUNbAPUiuBDrxRhaXeKgytoPLwli3jv8iTvI5zFnwPvr9
 USW/CgAvhr1FZPIE7v0ptkxShd0JNop7kGE+vcilZoUZNTW1crGhdrMOI35+EAiQ/cx5
 zR/AUbtagc5N4YXGexsznnuhENqir1DZCGaianjEmrfTNn1oBJ7zN6tMpwjvJpMpW8yn
 R0o+gQ30nBO9NU9FcSIOEs5kfNQEObeqm2PRwbz9RJGRH/SYgMqjXwtLoB1zit2/KIkV
 EvdQ9VIkJfrMRGWMxsexMpvgUyBzpNEjCtItDIJGKf3GUrw7+rQNwc8e28Md8YGHeczX
 4INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430709; x=1772035509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0MVTtLeohIMCELLOZJmg1TbIuGorxGN7ZhN5WtX3kd4=;
 b=P6G3+cmprqMlltfD2dsPNTSBWU/2/D+0fmg3NFLw7YS6LHv4JgU/Kq8nVo2tgnYPD0
 4CnpvhIKPzfY+Sqh/cf9cPAtup3Tp/ygSuALf6bA9BIVPjEY2NW7b//Pi3p2oZ+XqHRV
 sDqj4hdcRPsVDdhfsvIrZpK4hK1SvdyicPoFdRU4RXYBIm+/ATkV5B6zADwFxCfxzIOZ
 xumaZad0r6qctA9euhhjxmjcufrpeyrGxtdCVHvYGMJrebCshml9/5toHViB3xtGcY3g
 moEsgXyR8c16DbgShxYdRPZCMtRvEVF0fBeJ8/xB1uD7SSO/I+jSzhr74li8BMc95S2h
 44Qg==
X-Gm-Message-State: AOJu0YwuyUfHtqfqv5EQoQxeoIjEo+4Pum22Kyx2iewvrOJeRY7Yxktt
 FWQAnYPyALclE2COB5GD1s0ArV5EVWT6bkPTu8b02PzKC5CtAi598/SnrAl/Dg==
X-Gm-Gg: AZuq6aKtMlnZxc1yE79Srks+LvtD9ccyIHNmD0qgYTebluE3YxSlZRw474KgeOjr+Vc
 DNUDxcQ8/d5T2TX2Rpi1YUjqzXGrg59wxT1TYFRDX5fiBbreV5FKT79o4uwzT9a45bSTN6Bq8RR
 gQyyyJUAfgF25aDVvVs/bh75wreNfo2HaXr6ZMsRsTR596GpKqYGpAHiXRE4opY+Zt2F1hEwe1j
 o2mwvJHBoKFUPUC7IvWauIs+pL8JudMLFDs+NltrW+619v5eB0IuIBc1+d3wW5SccC84Oxj3YdS
 kpB0Yq9bcRzW7u/idBslv740oc7GZkD9RFid+P3Et/Flq6PPNsWeWEeZzOfnSrGsRw8QZ7yg28q
 Kg/UIgKLGiyLGoErtFBGPVCkATx/0JNFklMsIIl4LVYOgcCNrzXHYS73z4ZICcvPx8n/lSGuCNN
 AHP84l0KwLfg3r5igIBHZEoErcdg==
X-Received: by 2002:a05:600c:348a:b0:47d:92bb:2723 with SMTP id
 5b1f17b1804b1-48398a4b533mr44642095e9.3.1771430709224; 
 Wed, 18 Feb 2026 08:05:09 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:08 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 09/11] net/dpaa2: use CHECK_INTERVAL macro in set_link_down
Date: Wed, 18 Feb 2026 17:04:51 +0100
Message-ID: <20260218160453.142311-10-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

Replace hardcoded rte_delay_us(100 * 1000) with
rte_delay_ms(CHECK_INTERVAL) for consistency with the rest of the
driver.

No functional change.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 885f43de19..888be4e467 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2355,7 +2355,7 @@ dpaa2_dev_set_link_down(struct rte_eth_dev *dev)
 		}
 		if (dpni_enabled)
 			/* Allow the MC some slack */
-			rte_delay_us(100 * 1000);
+			rte_delay_ms(CHECK_INTERVAL);
 	} while (dpni_enabled && --retries);
 
 	if (!retries) {
-- 
2.43.0

