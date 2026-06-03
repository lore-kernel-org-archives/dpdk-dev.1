Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D06CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 05:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0F5640615;
	Wed,  3 Jun 2026 07:47:56 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 6137E402BD
 for <dev@dpdk.org>; Wed,  3 Jun 2026 07:47:55 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so150271f8f.0
 for <dev@dpdk.org>; Tue, 02 Jun 2026 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780465675; x=1781070475; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NHA2vrsTlqD8FSwDM9z6JHZ0rB8DqDVP/YV9MolxzMU=;
 b=Y3InTvqUjhv5KEoTYwEnEme2Vw2Um6wc68IPYXk75NwGYdLE7a0PLAnjMXdh3AF0zh
 1qvPziZ8LegydZzDHxw/U8hCU3gCqGDYoHYW7gBbQHbaX5uCNFrTMQHPChaTLcKzJZS2
 k7v/xCBUpF3fZvlKZi55VounF/1vKm4gcanFxsO2VXC3RIC6GhcJ/ybJM32L6UZOK661
 31A6xsG9VnOr7bPGsVQYHhDt+WYKNqatTy7CsJgUOrcF5ys6oyZfYfgMsD+HgxZq2WYl
 LlrF0pPkC3IJuFn9LEmov3wlNbIkOoreyLO30nlxl6UCHcnHg82FvExSbMSo2PEjKfm7
 MZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780465675; x=1781070475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHA2vrsTlqD8FSwDM9z6JHZ0rB8DqDVP/YV9MolxzMU=;
 b=JhUF8QvLml5fELEdHpJf90ZLf/S5Blj82iTtKPV2W54ElMzeFjis8pn2eM5SK60Lop
 L9r1QFKzNSg3Jbl5dW+3l0yGMMJo66pe/PEx2pAsIcAfzmphZngepz4It27ZanZNYUm9
 1gjTHlumW3tJ9xQZWAAR+lKMy4UtggeUNVAJGdY97Chp53wUDJhHyWoCKBSUcW+VPTRP
 tNmrjoQgCYriwvaeZFBj+kpp1tm2ExLMbnuExlPcjHzw/NEpdt0KxMpgrObrgVZqIckA
 hbt+o8wGRZdDb0ntYTmX5+K649PC1RJ23NX2P6NBohLj65KgzbNEX3nJnV60LtGjIbiy
 VJng==
X-Gm-Message-State: AOJu0Yz4NYTrllZV6cy0sLIq38Mbc6vubuVlMsExZwlqZcuzCPybKnJ+
 RYbHJsHRQ7SPkEb47LcQEHRaaMJOKjvHZ1r/4806Jd2qX7lXIwh+3Q5aGoB81ROd
X-Gm-Gg: Acq92OFObBBlsHkBNl8sSjz/lGjXQ1nNweapL3hWUVW4l6SmMwBMPXqkI5nZXxg6uq8
 xokhAuRklVSmeioO1YhRvJQmBEnWu4WLnyUlNH/jykvxVT+hSyiEMz4tSF2a3ZBZjjEiWgR1eKl
 KrMrWrmJILdd886BkfRQVbNVckZD5T5f6PBlUT5W45KR//ApglMW7KZ1CR41C2/poWwmkW7OgjE
 P/12v39KL6GksjP2sm3Jyh9ZC/J7ixWpVkyeM292LMyp4q1dqpy3T4p0nqrQzxY0Lm1gbiSc7Ig
 55UK8WhCcpC8+7H4FLKX9KtHXa6w82MNcz06d65t4MroVeLfyFzCHgHbV2xXUKVJpvCVRdQZ7mY
 H/2BfcCLMD4TEF5mVN3KRwyh5x3bfokv8ZlS6S2kvT7cc/ycPFlurxtwHRL+SHjwMV0oUNCePbi
 zMVj81JBE8N9g2PrOJsWESJXQ+ZSRM4Dec+sXwFgZmJa0lfuScLBWWAUYx
X-Received: by 2002:a05:6000:46da:b0:45e:8edc:dacc with SMTP id
 ffacd0b85a97d-4602132d1f4mr1577184f8f.27.1780465675011; 
 Tue, 02 Jun 2026 22:47:55 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm7526034f8f.27.2026.06.02.22.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 22:47:54 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, sdl.dpdk@linuxtesting.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] net/ark: validate IPv4 octets in address parser
Date: Wed,  3 Jun 2026 08:47:38 +0300
Message-ID: <20260603054742.120101-1-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The IPv4 parsing helper used by pktgen and pktchkr reads each octet
with "%u". This allows values above 255 to be accepted from the
configuration file and encoded into unintended device register values.

Reject parsed octets outside the IPv4 byte range before assembling
the 32-bit address.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9c7188a68d7b ("net/ark: provide API for hardware modules pktchkr and pktgen")

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 drivers/net/ark/ark_pktchkr.c | 2 ++
 drivers/net/ark/ark_pktgen.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ark/ark_pktchkr.c b/drivers/net/ark/ark_pktchkr.c
index e1f336c73c..76e6f42659 100644
--- a/drivers/net/ark/ark_pktchkr.c
+++ b/drivers/net/ark/ark_pktchkr.c
@@ -379,6 +379,8 @@ parse_ipv4_string(char const *ip_address)
 	if (sscanf(ip_address, "%u.%u.%u.%u",
 		   &ip[0], &ip[1], &ip[2], &ip[3]) != 4)
 		return 0;
+	if (ip[0] > 255 || ip[1] > 255 || ip[2] > 255 || ip[3] > 255)
+		return 0;
 	return ip[3] + ip[2] * 0x100 + ip[1] * 0x10000ul + ip[0] * 0x1000000ul;
 }
 
diff --git a/drivers/net/ark/ark_pktgen.c b/drivers/net/ark/ark_pktgen.c
index 69ff7072b2..0b7246c374 100644
--- a/drivers/net/ark/ark_pktgen.c
+++ b/drivers/net/ark/ark_pktgen.c
@@ -360,6 +360,8 @@ parse_ipv4_string(char const *ip_address)
 	if (sscanf(ip_address, "%u.%u.%u.%u",
 		   &ip[0], &ip[1], &ip[2], &ip[3]) != 4)
 		return 0;
+	if (ip[0] > 255 || ip[1] > 255 || ip[2] > 255 || ip[3] > 255)
+		return 0;
 	return ip[3] + ip[2] * 0x100 + ip[1] * 0x10000ul + ip[0] * 0x1000000ul;
 }
 
-- 
2.50.1

