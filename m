Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4D9C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2D4B40E15;
	Fri, 21 Aug 2026 21:30:03 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id E62B440E01
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:02 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso1004344b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340602;
 x=1787945402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pC7Z06xbj/Dr2NM3fkfjMVJYUfEdUAZLa6+CEAt9+yw=;
 b=HcZPuLiRXhVO2xEHKrLXlmXyXu0zrf4sYzuEMn3hMPQJWdY0/jlfQWkeSCg14Pa1B3
 XGiD0MsKu9SO+zR3mHOcUrcVK/OlYHJfan34GoHlL/eC0E53INxyRflkejz0d+qfiAle
 OBmSmNIfomg+msOQNMd4WnfD549oitishN+iqQcVJBx8CNDMT8tTyfHKeKY4qsgZwzID
 3sk6R8YywMhEoqvm4jq4MommL72xICcykCUkgQebdDff2apSQc8v3s4L3Dk1GW9tk6eH
 Nzn2Ylt1ApXNtPfMRsNKY7iKJ1I68LqFcLSwdLGCxNg3+szgNGCLXFkZwYEOtz8JiIGN
 7Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340602; x=1787945402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pC7Z06xbj/Dr2NM3fkfjMVJYUfEdUAZLa6+CEAt9+yw=;
 b=rNTbzlwGrj0M0Hj2jE2Msk9DSijUZjBjBoeIPeQzA3zJ1SfrqxR1k4x19ohhW5Lqni
 lpgO7eJAXvfJ//VnNGTWj3UyxExOZJE4F8S1ZiT9E0QmjpWISlnePkM1kOsMDlf/DjCr
 efoOMcl0R2W+8Faa/rz3AJ3EDFC0YS8gyKQzXtPVI53B8vIH1oLwsp9uQaJGfwDRUgys
 LzKXroTGgnlJZi15ukKed7Kdh+oFgDswAFuLWzsCuuYSkmBU0KyPCJfbIVPJgZ+MKq2B
 vlh72wCNJ3SdYud86Cd96TK2sr+LJGwcmQz7yBO6XVKeWW9eSoE2EILZY2dj2a4kH5zn
 SRUA==
X-Gm-Message-State: AFuF++n7H6C55uTy0yxmYS+0T1v7Vuy1TsrLgieTVwBzodk3CZNec7Qe
 QK8lHmWShkh3cOzsNDa/d4ygDfeLbswtwxVSThsAN6XxcWLT5BkImyQqWoz9UpJh2Utodb1v9f/
 h+AX+euQ=
X-Gm-Gg: AR+sD10crmtHca8fHTClofzQRSj0CuoQyxCg/njprBg6+jIZ39qtAVo5FaLCiWuQvEg
 xUu++zGs3C3VI3ktuztOwA6uZEfoZF7JJPnRToA2iyuF9COCYsWXaqfhB0Qth8Q6HEMkXZHABZv
 9s++ZW+X6+WtNv3i0qC7Bm6JnHCQRAEiqaCobFTyXrTBRO0uGS9m8F+E1fhH1k9c/WIryydmPGK
 O6tjudAdXEUikGQ5b76PVomRwnyGqOIxLbbyYTTqx+HMzIqXKyAguHZG/E0hTlidDCXsVzklY/g
 sV7y8o8v5IJkTFWKkOWAPG7+i2xJWZqYS4/nkRdZefvVbWM0i2DlsPgFIXGcsmBfNUqq9B4lYxq
 2kYzvDARJ5gew80to/KtB3GwKNDn6l/2/5K21PXaFFM5s0+oN5yKLwufLNwcuvpoEzXo25Ds9KL
 bxyANgn3tIhTPRZiDx38PF94/wxoWoMx922pm1bFQVnpzQtz3DYdpMrAJ9MLKQ2CrS0kpT57lmE
 16PmXjRl5RslaR9EhWPGrvMth3cUeUr0+ME+A==
X-Received: by 2002:a05:6a21:2d8a:b0:398:c0ba:9ceb with SMTP id
 adf61e73a8af0-3cd3009ca79mr17295707637.12.1787340602170; 
 Fri, 21 Aug 2026 12:30:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Subject: [PATCH v2 35/68] net/gve: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:30 -0700
Message-ID: <20260821192646.146382-36-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

