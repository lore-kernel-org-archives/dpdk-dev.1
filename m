Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3B810F6FDC
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:41:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC2040B94;
	Wed,  1 Apr 2026 18:41:16 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 2F94540DCB
 for <dev@dpdk.org>; Wed,  1 Apr 2026 18:41:15 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2ca4ff720ccso219263eec.0
 for <dev@dpdk.org>; Wed, 01 Apr 2026 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775061674;
 x=1775666474; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0P6JToFLKCo2hL5Jy9fsmbPw9TkqQCZgY2kmKioOCc=;
 b=PDbiy0YPXRl99bDYWL9dszIf61r3hVkXCWb1UazcZrXA5bTxNYajFQL5uZ7iXlTQOS
 q7yhTfiozbnmxq7d+u98bXrfpNDZ+X5MQdu61dsvqktHsRwN0b/E98kO9hN+CDpHXmZo
 UtyHBEYBG9/le1uzh8WfrABjaguyMnFYnqn2SWMfBBaFLeHeR+GKP7As4N8qKF5+nT1C
 3PZUPsuQrRGFJGZpZwAzBIArVSlwNTDQBZfdgZrWuOe3pPcSg07AlpGp564BIG2LFFKg
 j0ffHrgSFirwuE7FqQTzxFQT4MUT7Snsk+kSbNaxFwOGkkHPvjso+I7o7uTx93cYeLAm
 FkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775061674; x=1775666474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l0P6JToFLKCo2hL5Jy9fsmbPw9TkqQCZgY2kmKioOCc=;
 b=NtLo7nPEa6ePZEXDAviGNp1dL4iuNacZc564NcRNdebHzjEWNbYfZC29A3qi7Gtq70
 BB6WnxGc0iijaKTUVN1MeGm1aqP+DF4m9TYuoQpUsk2HmZuz9Cu3MxT3pvxQKVZIgr3w
 /iVEuXvY23UGtidazx4wuehS5vP13yPBDbMU2bVY0Biw8hpo2HzgQv7yDxdYQVZkcYlm
 mT43qtJ7rhEbP3uooY1Npt4IGmFXqfY3eiWe53LiYOlnc5BzABfyXQPzPrUdDZ4thICM
 NorE+NqY+haECrQC7F6m/xuj9mdMe5HF+QVvZVlMLh9Br9QZbX+DkmM5ukquP5KWKHLq
 Vf8w==
X-Gm-Message-State: AOJu0Yw36ksOnNhsH/grqs+QKgby3vHz5cbCn7SF7xVnL5z2InkGSF/+
 clCJAciFpKba5IA2/QjG6kdtO2/Nt9P4pGhRKlZJP4WASRsMGccO0KGgaedVme04eHNX/JwAQC0
 yfKRz
X-Gm-Gg: ATEYQzzegtqnhbGB3tu5sDVbXts+SrDnwd/miUriZPxl1Et7SlXuJL0p09PF4iaF6vN
 ZklpCgJ8s/rpAngiN3WgmXB4KEFyDFmn8hhTKzhdAsvFQGzHTJP974w+Nsxz+/PCxHPLTsXw7eY
 Fp8Yrof+JFc8/rYuZpbwsvsm7b442Hjwj+7LqYHk8Z+W3xBrSAwoQSwGJ8iTaerD70hstjeBQnd
 HY4vlACwh0TBmUrwVmYrbhoPljgCwRmA9uv4kTJpOKGUrTfLPWA+v0tTGLBUoUFziEiyVGYMhLJ
 vbmSnaAsQnba5T6RuV1RQHOODjHosfJHZ8cYCP+K4ZwpYhqi/+J2dlyRPSHgjcUZfA/VVoAgHrm
 2eke5UBKU4rweI1cOmoxb5RJ6CbUBXoS8RynfdJU2cv/C/ssJfupaFBRi8I3rAGKkCWQGBWHeBg
 LfMuHIBaaebabW25sOb5AgFGKUhkihOF3A
X-Received: by 2002:a05:7300:a484:b0:2c0:beb1:8507 with SMTP id
 5a478bee46e88-2c7b82820a6mr3989729eec.0.1775061674218; 
 Wed, 01 Apr 2026 09:41:14 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7c20c0c2sm202583eec.17.2026.04.01.09.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 09:41:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH 3/4] net/zxdh: remove unnecessary null check
Date: Wed,  1 Apr 2026 09:40:24 -0700
Message-ID: <20260401164108.201404-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401164108.201404-1-stephen@networkplumber.org>
References: <20260401164108.201404-1-stephen@networkplumber.org>
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

No need to check for null before calling free.
Found by coccinelle script null_free.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_np.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
index efb57e34f2..b078ec5b6c 100644
--- a/drivers/net/zxdh/zxdh_np.c
+++ b/drivers/net/zxdh/zxdh_np.c
@@ -12383,8 +12383,7 @@ zxdh_np_dtb_acl_data_clear(uint32_t dev_id, uint32_t queue_id,
 				&element_id);
 	free(data_buff);
 	free(mask_buff);
-	if (eram_buff)
-		free(eram_buff);
+	free(eram_buff);
 
 	free(p_entry_arr);
 	ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_dtb_acl_dma_insert");
-- 
2.53.0

