Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862BC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF10A40A73;
	Thu, 20 Aug 2026 07:24:17 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id A76C4402D1
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:16 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so2096123b3a.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203456;
 x=1787808256; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W6ydOYIKLRPPhXmRJxYXbDfp18Mna0EX1gbJAC1l4+E=;
 b=L5oz6t9j+nkmfXlp0aQttgdSlJqzX4vaNWjV4NFIli1hRxgh52ZnhEYFZeOWYlAjot
 JejrcPRbPQX5X2wxruXoY029HIjgCk22dyifT03hc13fAw7o/UhyiPdBXdcIfbfuDN3E
 QEMd6a3pekA9PzqxirciwIS70GpxMYjHG/9qPhyZQACoyH3XHuwckjIaEOHxqrDba9yS
 YSPXehJ9BhgqZiBdfkxqPMOy2j7Xb4vQGY/b6p5Yb8xQWC24j2Ukd9oLn/y4qmkLoj++
 4b/klDf9WXMqcUM9omYZGpWy3S0pqAr7xg5rkhxKPHq0Ma06Xm5yiJdm+rEDhM4kvOnS
 JXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203456; x=1787808256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W6ydOYIKLRPPhXmRJxYXbDfp18Mna0EX1gbJAC1l4+E=;
 b=hGIgihXHzd52lpbwtqAHuNnabN6mgfgH3VpNNT1dNjxexfGhyCCTmYJA9TEyG4BioS
 c1CY96+PT1Nj1djykC5t/7Pkuy6VMJ11rkq4ALDiRIfFp3yThS7gWkvb2gZTJ/V8sgGB
 xm9LNZmgk49ARy9uBV2rbfqm+SbyQiv2CRQswlIxSJDiaCpj1w3i6YrAHQLmPXXEv9/x
 DKLDNs4Aj8iIoGDqnVtqcqWN3sClwmB4nCyCT/ckPhAquUibBmjfrSlWX+Pzx4GnsnCz
 bkdW/GPXcXBiqDd5TmGGSgv+vrvaDaypB11knYHFHXF9T4t8YUw3mjZ+nmo2EN++OBfv
 m+Mw==
X-Gm-Message-State: AOJu0YyQAsa/XpyrZbYN0i4bB0ou7Wq2zriV/sC4TMFGwfm3hwj8Crnb
 8TKpI94EyluxtbdBVONz1FlC0CSPI+4G3lyrPgx5nP2kffvfp0mlOfw6NUEw/n8LJeO+EyIpI33
 PJVkJ
X-Gm-Gg: AR+sD126akggavEBkXGo3QJuM/rr9jTb9zFGOUMJ9M9u2fJXOTGb+TUOGlCIIheNQoS
 DO/pv8/NXgSac1hMays7SjA9oF1+i+ltOXEQp7cKFi6Ek2iGAuX4sVNk1vHbQk5Rbyqlc9ERHp8
 uxed2Bt5hc7CMghiyt5y3Ldo2cf6ZbMXzrphmBKehnoQQmThVYNLc1fEGSDmCwHxppDe1yyGdA/
 grYdvC6TvZGCPxu9s0eyMukPZAUtpU9nE82sAH5FRdxRdxOZP41lC/WlUfr/ODcWbMSylDC2cD8
 zYZYWTBgcKxHFa13vvHyHgSI1ad9U9dxqMFMub9JttNL0ooADL81+7hRaGkZZZpgsSXA4MfbAzQ
 20evzMW1b6/PSgRnUqQPMj7XunZJEuoi06EIP/VaWHv2wEAl3HgeYKWlem2T4dxXShh8kUI+eka
 VAE04Qle9jZiDZo3CiSGN9A+2agRLXt1rWF40yLbK9auVr/aUmYEtzZ4sptnRgfVeqJiQ9DPCxe
 DxldbIO7QAsoW7cW06gRm41R7c=
X-Received: by 2002:a05:6a20:5483:b0:3c3:64cb:9b99 with SMTP id
 adf61e73a8af0-3cd00e58e33mr18662310637.6.1787203455827; 
 Wed, 19 Aug 2026 22:24:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [PATCH 19/61] net/axgbe: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:09 -0700
Message-ID: <20260820052251.1453273-20-stephen@networkplumber.org>
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
 drivers/net/axgbe/axgbe_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 61725d55ca..edd16dbaab 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -599,7 +599,7 @@ axgbe_dev_rss_hash_update(struct rte_eth_dev *dev,
 
 	if (rss_conf->rss_key != NULL &&
 	    rss_conf->rss_key_len == AXGBE_RSS_HASH_KEY_SIZE) {
-		rte_memcpy(pdata->rss_key, rss_conf->rss_key,
+		memcpy(pdata->rss_key, rss_conf->rss_key,
 		       AXGBE_RSS_HASH_KEY_SIZE);
 		/* Program the hash key */
 		ret = axgbe_write_rss_hash_key(pdata);
@@ -642,7 +642,7 @@ axgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 
 	if (rss_conf->rss_key != NULL &&
 	    rss_conf->rss_key_len >= AXGBE_RSS_HASH_KEY_SIZE) {
-		rte_memcpy(rss_conf->rss_key, pdata->rss_key,
+		memcpy(rss_conf->rss_key, pdata->rss_key,
 		       AXGBE_RSS_HASH_KEY_SIZE);
 	}
 	rss_conf->rss_key_len = AXGBE_RSS_HASH_KEY_SIZE;
-- 
2.53.0

