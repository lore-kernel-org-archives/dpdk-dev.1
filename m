Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C48C5DF87
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A88406B8;
	Thu, 20 Aug 2026 07:24:12 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 18DE34067C
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:10 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so15611665ad.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203449;
 x=1787808249; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uuVXLitst++j+kJXp56vmGdTkbyRI1yjA/TrCU9dlPY=;
 b=v5p4F+NI6141NNCoFJbbX5svcIP5j9yG/2N7Rdruy1p9mZgqM0rxo1Wzt1nVDhhhNV
 iwnVTQrPyQFmg54Z6YFqflb0/LT6AE/ZRAnJWlQKNDPFS7H3COPNiV+rBKlr8Tre9l27
 m8SoDTqJ9qG3HrO3F5p0alPxW/a2ZvQKHk4vJxltuvzbLNRsOD20kiXT8c80JCNrCkUm
 yo9AjrWoc/9hiDjkLFcOlBO1txB5QMVPSzinTuR56E/MLX7RTMS6hCxEwKN6TL59VPPm
 55wl4Uy/YmdlQto4OoiPIsEB61JDR7Nm6Ty7oXtYjv76+BjePnnYetXtKRpOhLuNiHur
 RH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203449; x=1787808249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uuVXLitst++j+kJXp56vmGdTkbyRI1yjA/TrCU9dlPY=;
 b=cKuMXN6AQcTSEjjzFYgy40RfdVD6PxRhkDkiNW4Gjr2la/NEzgiMTBwTJAUCIiLcSc
 c7ajmPO/E66UYCknZiTuKM5mH5p8acbYfNmoeObawV8Xyyn+ovYBMl9hHh6rs9Ogaiw9
 Nn1n6Hp5wnnqojFwQKRPISrTGCdr6J8ku4YpRZkncM75978xGHzovZlkSi9T/+cLsmP3
 d4AkNReACGQs+8rlMep7xj/aYzdOX5HNomQZpnK4Bt9Oopyraaaz1f3FbLNEDERm4McS
 WsmKqIqyNZGFcNLM0wKxHBKo9iYZud6VEJhL0HCgqHvZ8i2cu+scgHROsgOH97MujDys
 Rj3w==
X-Gm-Message-State: AFuF++njiVbT6QfmAS+Mg75cOlOhaSdxmGZ8lph1x6w3Y6TyCgcjt9E3
 RZPaJRH/qo8iGbnpjS9xPROdy4fd3feJOMBvHSvDzbflpYuYS5KjwSYfoJGEV0qIzIWhf5+vKg1
 GUmqg
X-Gm-Gg: AR+sD122GyCFkrfraZJLSAFZZplKYeOnJoJFE8AUr6kUs1SmzcwvI8RfMs9rnd4OO/o
 gARwIFLmp+uSFCpn8XgKMlvj+aJpozWBCqvdIkZshUJvscJVxbMU9n7waiQmU1R9nbqWxn/rBgf
 Qa0RYQW3NqhmdMrkC92uIZOd1/jEBKYguqFs4z7iAFGLgvo+dJRD7FfK1ng5h2oERMyG3sz3xDW
 4WfGeYh7t+3nEM2/i0GuZT9j1xE4Ic6fnwBz0dNGpyvlFQmm84NcFNaCYcwIafAQvtxOjklc4Nx
 JOZqW+gaZZJChxV97wTVPyAQOQd/5QZDyc2iW0ZmB0Q29pUbbKIrdBEgK1ATM2xYz+AK2GAnbHK
 FTMoCoNjxEfAegH5vXNHNlcSGW54OG9vxyIAotvZp5G4TvMNd8kddk0w8oiqZcFGQl0h4+6sHSG
 uNH1jrCBM72IdMozIn33NJwPBy+b5OTE1ljq1IY2azacHoPd1x607a0PvstPzBBdPruiu0Cfdtn
 y57X9+vNd4dK0F136LyscPFUW0=
X-Received: by 2002:a17:90b:55c6:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-395813f758amr19459366a91.11.1787203448937; 
 Wed, 19 Aug 2026 22:24:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH 17/61] net/af_xdp: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:07 -0700
Message-ID: <20260820052251.1453273-18-stephen@networkplumber.org>
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
 drivers/net/af_xdp/rte_eth_af_xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..95838416b0 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -2234,7 +2234,7 @@ get_iface_info(const char *if_name,
 	if (ioctl(sock, SIOCGIFHWADDR, &ifr))
 		goto error;
 
-	rte_memcpy(eth_addr, ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
+	memcpy(eth_addr, ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
 
 	close(sock);
 	return 0;
-- 
2.53.0

