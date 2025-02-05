Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC81C02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:26:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B13540A72;
	Wed,  5 Feb 2025 17:25:16 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id AA0E040667
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:10 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-21f01fe1ce8so31206875ad.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772710;
 x=1739377510; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyzifiWA3+VxTUYxCZpCy2nFQoPfapOrdzV288THeqw=;
 b=Zt6fOe0dE70I9+3xWErzzGgv4STRYdSOo4bKF1zDotU7k6vF2yy6Z7IE5K1UTZQef0
 b4j27OSV86uW9dQrSNlRKpxtvfjTOwZt3K9pikFxYxQAVK9w6PiU9aCoEzd1xVe/5Oxx
 x3faoKvVv++GTDUQEuvImO1BB1bIb3O30AVgYNUCZYZogMxhLUMBeoKLkRixsa/UTSrY
 TN/vPBK09jYMmHFadVnsX5wvBPrADcX5b0JsH2rqNdY+90BVbxBAiZf9jAiZdC9kYWTG
 M/eyWQ2vZCpfN2y51spn3smls/l/Uj9IgL4gkU6TEcLmGr8NQQXfmFfohKeAWCKIqa9V
 imxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772710; x=1739377510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xyzifiWA3+VxTUYxCZpCy2nFQoPfapOrdzV288THeqw=;
 b=P6xRvOVwsNpNdQ2i6tF6rx2vi6QgMioeaQsKO2oHCculGgzf8uRtQptVYGtg6HZJA2
 Hb5RW1d4mjcTH+u2rZrSxsaTzejX4bFlcN4lm/jyKAMpaoDkhEuXfjudGo5GXFY3FAwi
 7QECAMEZDEHoMh1zYHnaw7/C9oFHqSzRbqLX8WaLY9woCSgcAJcRnWBcCL/CyRl+SKfz
 uViUcQt/UEmdAiblg7NwCwyzB4SDUX9xrVx5w/uV1GIyuMMku5TjKji48OyP1KMskC3P
 IZAUVCg0c5LpHXrhC4pP9BwRrmr67bHjE92hqBrNEPOvtVu+mmObLqT1JieGcr6d/wes
 069A==
X-Gm-Message-State: AOJu0YxyYYpZSjXZnfYlO9H3kkrGPMRJtwtJYVdVWamGqy/aIyljGiXA
 BOnLmREXRY0UCa+WenCFbj2fkIf3WMEjBoN7RssCUjFGQ1ERNGqh/HCnih4MPrLkM4K4+VPKfwO
 8
X-Gm-Gg: ASbGncv79jskZ9f9jvRjvyYsFqnaeK/RETvgG7cr9x8FDq399s4lyDcZKVwrFW3XJ+u
 PGNIvftI2iY/1EVHjVFW5hJfOPrUCmLsSLoGZy0TKuLHgBrPEjAolTrzJnghGsjVVTFwb90hkx3
 snouOT5QHDiFBVGJhlaxlWFRIn7hox60Rj6ovxcQsqnK36qRgj13uArdB8UD7CnhiOxlcveuSHp
 PRLfSn4F/ump6TyWnh7lOKV2WRAyan75FGfldcN0Cg62kJwlP16bzmYtEagpFlCE+JvA9LRl9DY
 xQ03/1MdoAbNib10aN0u590VkZwsfKjNwz9rAXAtnYjtM10X9tnW3nR6M9f3UrJCcMWu
X-Google-Smtp-Source: AGHT+IG44BrI+C01uRov8A7dmQEsfqkDF2YQ3w0rqW9HwiNgrlvWOSzDeX2Vela2qQF5gBy1JDdtBA==
X-Received: by 2002:a17:903:2291:b0:21f:13a6:d424 with SMTP id
 d9443c01a7336-21f17e6d3b7mr55843155ad.30.1738772708856; 
 Wed, 05 Feb 2025 08:25:08 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 10/19] net/octeon_ep: remove duplicate code
Date: Wed,  5 Feb 2025 08:23:11 -0800
Message-ID: <20250205162448.161161-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

Both sides of the if in uninit are using same code.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/octeon_ep/otx_ep_ethdev.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index b4f8baf3b3..8b14734b0c 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -721,14 +721,9 @@ static const struct eth_dev_ops otx_ep_eth_dev_ops = {
 static int
 otx_ep_eth_dev_uninit(struct rte_eth_dev *eth_dev)
 {
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
-		eth_dev->dev_ops = NULL;
-		eth_dev->rx_pkt_burst = NULL;
-		eth_dev->tx_pkt_burst = NULL;
-		return 0;
-	}
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		otx_ep_mbox_uninit(eth_dev);
 
-	otx_ep_mbox_uninit(eth_dev);
 	eth_dev->dev_ops = NULL;
 	eth_dev->rx_pkt_burst = NULL;
 	eth_dev->tx_pkt_burst = NULL;
-- 
2.47.2

