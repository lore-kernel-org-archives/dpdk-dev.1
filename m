Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D8CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 20:23:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D47440658;
	Wed, 24 Sep 2025 22:23:01 +0200 (CEST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id DC1074064A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:22:59 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b28e1b87aa7so35949166b.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758745379;
 x=1759350179; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IqCVh0M6uEtQgKsjoWZeRPALFDBOmaVqU4Ic7oYRmOY=;
 b=YmcLIHkwR/038oNLeHNHHo/QIFqEgyboyJlEtUpkZ4S/uGt7MzPMAU0f7hcuU3Bs58
 BbYrfYcOx8Vvi4X4z7v7FM43LeBCCIWseqylFeIYxNRoncVUkrLBCfi4+sDIsPgTNgyM
 771uA6do/9r91361qSCeOjXF6kCgOGxIz5N1ZTfDuqTbEqXIP6YpCVSE7X8+N4USDIsO
 rV5JUzb5n30S5k4cL3dW04WuPcxyMEOdkBFio/ZhsUx7fFELMCNBstxsMIwbamlDJm7D
 +4njBz9PTREPIYh7BIWicRslpBcQmJjI4wJVsgfrl3+54Bm8hui2MXVmVeJ2MJyhOlrI
 TgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758745379; x=1759350179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IqCVh0M6uEtQgKsjoWZeRPALFDBOmaVqU4Ic7oYRmOY=;
 b=LziM2ydzwIPcWRsn3xdw69V+wCwaBXjsY+xbUPsrjiF4IhL5ETefDNRlwWFWC5WJk9
 Zap4LZ7iFDflNKpcIRktnVW9+GgLW5thmo1C1aT1CSbATTcSuEc5wrqwuwf3LDBk4Ude
 aaU9tuH77KhaqK5+ZPJm/RgT/s0TUIMUl9jDDJ++M/OnyNbw/IS1oxB+VrSTsRlosKaL
 1glySZVHlOyVXaSVySiEbCz7Wezv7cHb0yuJVgUPL4hZLBVxcnN2YkPxkObbpEj7WFTW
 rjuTKJhp3NxjFh3QHd0HYvmNra/4vUhxGfQctSPWeEgDTuciiN6oRnJaBtmfcj/lgJHb
 kTLA==
X-Gm-Message-State: AOJu0YyR0CdiZaLW+lzwZKQneCrSTG6+B9wOs/c9c+sH/dpZLmDcUi2g
 v/YHx7UgfF8omC1B2SWNGKeW6VQrtoISDLoAjEr3TdoT6HTXsPc4OIAbOit7dL+IXX1J+9DiZIY
 5fNOz
X-Gm-Gg: ASbGncvy/jQ+yAI+b1Jin120b5BZBOQZYFXy1o6WTLb/9YvO0VbossSgN1MDeHJNqBU
 SInocrpK0WPzNTZR0siNrQL2GPBOiPc54VR/oU6N2wkVDvhywG7GT8y90YGQ4pt8imliZT2Q6NW
 w3XJzR11I05Ns3GqUWEkStW2dnQS9DedYHNvr9BgyCfebYSKrksfgAbrmf7FEHUSryaN5LzfdFT
 QMY3qCBv+WFkPj2FG6WWU7DbU2syE7G8TprdoY+25dKOIFQjuy4bYwrYjmLLCeji2bNAeLagsAy
 Hy2YvJRB7cpDu64whrZeBQQBN3Vrz2clSQPhY9L1ZRUp0D+s7LKxlN/ewjsfv2/rOZDH3FXMhBl
 UBhwrGKsoiLTExdDNUwSANQH74j9kSL7MKgFPAaU6/hR1U1D2VLP8PPVJhjE5b/NqHPla00hT
X-Google-Smtp-Source: AGHT+IG78HQh4eskcE2KWbUvzXUwRtjuFM/OVnPS2o5isdpB+jK4TGlDM1rNvuCBLUvEmlARfYff7A==
X-Received: by 2002:a17:907:9486:b0:b2b:f498:e2f4 with SMTP id
 a640c23a62f3a-b34b9f5b496mr92011266b.6.1758745379123; 
 Wed, 24 Sep 2025 13:22:59 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3544fd0a64sm9142366b.85.2025.09.24.13.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 13:22:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH] net/zxdh: remove unnecessary null free check
Date: Wed, 24 Sep 2025 13:22:52 -0700
Message-ID: <20250924202252.472101-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
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

Found with coccinell null free script.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_np.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
index 21c749c67a..98b95532cd 100644
--- a/drivers/net/zxdh/zxdh_np.c
+++ b/drivers/net/zxdh/zxdh_np.c
@@ -12330,8 +12330,7 @@ zxdh_np_dtb_acl_data_clear(uint32_t dev_id, uint32_t queue_id,
 				&element_id);
 	free(data_buff);
 	free(mask_buff);
-	if (eram_buff)
-		free(eram_buff);
+	free(eram_buff);
 
 	free(p_entry_arr);
 	ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_dtb_acl_dma_insert");
-- 
2.47.3

