Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A81C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 421D140B97;
	Thu, 20 Aug 2026 07:24:48 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id AC38940B94
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:47 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1871107a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203487;
 x=1787808287; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pC7Z06xbj/Dr2NM3fkfjMVJYUfEdUAZLa6+CEAt9+yw=;
 b=cAELmWcvjOO8wSZxFyj/UCaLg3hw+r50hn4e3LuDLpIvcrusiEes3NiGs4fkh5irt/
 RLZg5NVuF4s2dEx0qa57kj4MFktx3YpgoM7SveY4w3XShWMeKykkj1KuVjGGIrt1/h3Y
 +0Gd3xGnQJS9l/UuAvUU2vVDeUdMlJqhtCsTBX2HH/7T3I55Rzq6xpxIOOmDlwuXOsy7
 qXzdzIVZtwDge20Jq+sdaU0uaYNY90eKPtwSWBZ1/54qZr8VMD1emY2NE6Xoj+5l0wcr
 PSVRAxvo6ZAZB4bU1MzwFORy53+/MaiRZJgP+euELCOM2jpq0NXYD+2sUxwXyBkcScFJ
 wPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203487; x=1787808287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pC7Z06xbj/Dr2NM3fkfjMVJYUfEdUAZLa6+CEAt9+yw=;
 b=Wmzav+5k93yfI5yt5TX7kynkT3TKZXN2mutjdpM1YbILv4YEdFOm0Wx1GYpvys8Oc/
 sF4rEYy1LJYdHQln/cIng0YYs3DHF2WiZRte2aCRxCSmc0+y8Lws1B7alrBiOqXrvf5B
 TunnBw9yw8/cAo0hQi3VkZAt22LzVGTeOGDb169227dNGWbmXoFR8C9WAoLRaZVPESSR
 6FYaopmRMyPXdne4dhdYYcOSrPUbCmmq17kDSYTfHyh7rKPCTWXJi0NzidJ4y3v9GdE4
 V3CWSL9S0/yaeh/MxyLsbBvsSyTVfrtL2V85BsnVoS/WEuUYQKn+l9fjYYgcaLEopGAx
 lI4w==
X-Gm-Message-State: AFuF++m4EEYUg6i4/h6AX8oAWdkCgs2CsgRKlQkyKxGgJrWMRru9a2Y1
 qosZid0IRaWp7v9QIsnASTij5SSZMaK2mjZWY1sbqH3Cms7v7AcDBayQTHU9OAsv+wLLj/y+mDz
 2Sjgo
X-Gm-Gg: AR+sD10GEACzOZC7w0bSYkcRtIIIH9JpTzE3Xb1n1Go7PObsEtQKUqb5EfYYK4wtxs+
 okV1tle0yF8P1cadYeesO1otZ0hpSDTTZ59HiWGTANVtGy9Cszq3wSwFv8+P+tLKIkyetShHbW6
 iH0s/tBbkoqLCUxM3pROUd+MHe257wnEG8KUdlRUhSUsqvYkjO7L0Uqt+LUhSmYFj4L6yNrBdRM
 tpQ9kmbOo7dT1B+oai9EZEqSpA5U2xVG3hIvWCrch+Yqe2Pa5Ti0hh4IYVlueHE3aVjHFK8NpM7
 +3jsUVh5uOLwiHZRrQS+hf7iwmRWxZWotQQUcddrIJzf5g/tGRkBwmwhZFz3eqYnmkRDjuUyjF6
 HUcWB0IOoxx7Kk8znw/6Q19MiF6ciSfJlKQ+vLBguKRzU0mVLjJab99GX/hwvr+jY5aLIVVUTE7
 BzSj3dkAc19QJ7uxgvDIuXacQXnBQdFEVB4gCKj80mL+NeKP0ac97ysTdLnb9XHiSA6xLaEv8BX
 o+qrnVbJl9W75TVitUD0LR6TSg=
X-Received: by 2002:a17:90b:5102:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-395810caaf4mr6351768a91.14.1787203486850; 
 Wed, 19 Aug 2026 22:24:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Subject: [PATCH 28/61] net/gve: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:18 -0700
Message-ID: <20260820052251.1453273-29-stephen@networkplumber.org>
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
 drivers/net/gve/base/gve_adminq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 89bf669c24..b7621a1fd1 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -1083,7 +1083,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	}
 	priv->max_mtu = mtu;
 	priv->num_event_counters = be16_to_cpu(descriptor->counters);
-	rte_memcpy(priv->dev_addr.addr_bytes, descriptor->mac, ETH_ALEN);
+	memcpy(priv->dev_addr.addr_bytes, descriptor->mac, ETH_ALEN);
 	PMD_DRV_LOG(INFO, "MAC addr: " RTE_ETHER_ADDR_PRT_FMT,
 		    RTE_ETHER_ADDR_BYTES(&priv->dev_addr));
 	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-- 
2.53.0

