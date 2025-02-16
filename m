Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE4C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E398D40ECF;
	Sun, 16 Feb 2025 18:01:38 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8CD8C40E32
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:31 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-220ca204d04so47161775ad.0
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725291;
 x=1740330091; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=x5S56DOcnMK3sdKRW9k1eFzHsrkbqsWoLTzlYCQg1y3yfLtCjSAOGcKqbVvd3DfR/t
 FP3SMGGEm5PcvZcdMzqI9zvsyiXpdpPZGJ2Kw/iebd9QpYdpNzJRsq8KVzrcyBQSzzyl
 +eGGWH7Yvz8/rK7/ICt7p6Hq6KaLmLL2JvOsnWeM+aYqrHVra4hXUKehBauGEmHLyAS2
 cAi7dTFpvEND66fsRIV5Z8JIcyF/sMAIcjSr5EFe37rigFKouBQNsfhzxWFAz4mtnV2H
 B9tpjDIaV1PO68iYyZfM2WXgQEPhd/2D8ML1xAVWA1bs80F+sSZG/PZ7GpM8hBKf60Tn
 W7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725291; x=1740330091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=tqCDrxGm0GrxPwi4IN2i2ghVgeM2taziSUafDPL4r6GbV5eePplZCzLk1R5RljbhEc
 Da6a2CdJyynBCkBRAM9LLYFN+x1yRLUCfjR6rMx8y/rOvoxMbEbqZQQlRFqUnk1PereM
 Chcu6XSaD9HvF5PBxSDIyLOWmkHVEo5DixYQhrjYaA0Qf9hC0BXfm1fsEi8YiL8JinXo
 RfzDtLwAXE04vhSC5BLKOaEU53oNmijUIH1KpOCjN8Xf75/qnu9m/NDzULZPubQTtmCj
 GhZDr43U/PvEPPEcCQ/qYkZ31tL0gp4VmNxefbs1Pr/XrfjYQ3qn6q7s7Auj+akfdnlV
 8p7g==
X-Gm-Message-State: AOJu0Yye5bBW9CHb1u9Yyg7/c2IBjoAZovzBuRYpwBbPVhz/ZXJEOHmg
 xJ0ytrsCOp1ZXQcMHqkRZXyHAKvbPy2y2LlerDUbn3/3Y6d9eX0ONmGDPUr791Cu9mz52ntCQLM
 K
X-Gm-Gg: ASbGncvJTIoAvQITL0wXBTqvNRpO0vcBBOE9MkWDcH91A5FTayhF856qVVzEqhscqI7
 abh0tABfBZsF0bmfDgHYW5buAZsXz7XCWzQ4ucfH2ii3kmixR62pLctKjcbhNTPcKE+1H23gfz3
 j3hF91smqwcMRftIZ+dX0VsIlRsAlzcx0TgEoiTP/sulxAkXAzTz0904DLdNpxu01kQRbC6iEJv
 3jVglRPHMAsv/8hY6sdDO0FpSLR7gJJH1Jth/V0OU+BHaMYnJBN+fk5vJpSjY0s/6xm8pbSklPl
 2Hr0BR+Pck1L2u8ujawnuUvwrxV9AEKBDSRNS5zw8lF0fwPq0ToOSxXZlJ4bxZEjuH1z
X-Google-Smtp-Source: AGHT+IGpQpweQFwMyKIwt0jGSGYUysc5MitUailh1TgV9z0g3P+R3YfCTqWl+eSnPmUv6MQV3O+VRQ==
X-Received: by 2002:a17:903:22c3:b0:220:ef79:aca9 with SMTP id
 d9443c01a7336-221040ac0cbmr97979795ad.53.1739725290798; 
 Sun, 16 Feb 2025 09:01:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v8 12/17] bus/uacce: remove memset before free
Date: Sun, 16 Feb 2025 08:53:11 -0800
Message-ID: <20250216170110.7230-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

Doing memset before free maybe removed by compiler, and
is flagged by security scanning tools as potential problem.
In this case the memset is unnecessary.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/bus/uacce/uacce.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 9ca048122d..cc1e42d56a 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -454,7 +454,6 @@ uacce_cleanup(void)
 		dev->device.driver = NULL;
 
 free:
-		memset(dev, 0, sizeof(*dev));
 		free(dev);
 	}
 
-- 
2.47.2

