Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F6DCD4F21
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 12:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA4E94064A;
	Sun, 17 May 2026 14:54:17 +0200 (CEST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44]) by mails.dpdk.org (Postfix) with ESMTP id 09CF5402C5
 for <dev@dpdk.org>; Sat, 16 May 2026 13:08:34 +0200 (CEST)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a8891f0c88so536731e87.1
 for <dev@dpdk.org>; Sat, 16 May 2026 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929713; x=1779534513; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdKfKHERSfCxgcf1ylpNBy8MLou22Sk0P/YAqLwe1Bo=;
 b=RUAK3wXTIS2d/pGtE3AEn85mydyiuF8joL78dxL7oDQ06Ag7P5/LRTqmroLVWSClYX
 AWtiaKXzytsRg2ZKN2idKxhgn4DkNo1wNqS9NhK/0nFICyzQ933arEDBn9HgUn7uCVI7
 XOYajGjkSmMkneYD5fqjVLj2Za8WsNX1wEO7TvBaKjlX3X9gMEgmq8akn3n7NjFe7T+c
 3ky+6As94wr0tsWLvzmA30NveokxpYae/P6B4aNJ4XqoMGd9LXRnY+R8JQSSbczSL7/s
 JbtAG68okUPm8H9opsoumFHbRk+Cv6qBET1Yg2KknEYab4cS4jnKo+s62daXwV5Eq61G
 a/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929713; x=1779534513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RdKfKHERSfCxgcf1ylpNBy8MLou22Sk0P/YAqLwe1Bo=;
 b=gLQbMUE3uIeHrOlm2c6qZdwXWrw70Nt0rN/Av1Qj7sKj1gm2vwJIx+Z/CVZ7t34UuM
 Mz4trrHU3qq2RxhvN0DjFyAYaIMgUgh5EitUtjAOmSHyP1HRApXD5XpohZtD1OHit59M
 Y9I2h43nc8O8vdc6xVgZeBWGiu3onV2mZK2z96DzQQ0gdzgQxtmiIEpS9y+J43lp7Hu0
 e9fo3tjudU/3Pa1iySvPhguw9mmsxKkJwN3hPAk0NMdtMlNFkQwjfwaf7N8DHQhIYVgb
 ey6q0yVrdyZ51gUWTvR6F8y/6GbgZE+fAdwgANTvHPwuLQHSqxwLxmi0QkG1LDXQoKrE
 fieQ==
X-Gm-Message-State: AOJu0Yzg7thII8p6TtCDJCjAQXt91eDO6qRr/L7Q4ymCUqJBU28Zf+MT
 +4tZm8kGRKBSvTpSVLOMRKA872/+5ChcAeiKU8nQPPQSU5G55XLZkoAoPXBfeQ==
X-Gm-Gg: Acq92OHYacmQr1mlW5mba+VnYhoZWJ5CEgMDXqa0BDkiJPKFgGRtx+TUNA6TFdOuWCd
 wBZzfN3ovdRjGRBBqU5L/DPWIJfyMNbMnC66p9XHhwHSswflpVWzrGw8E56ZUUwv2wwd31s8M38
 65mXbvOMB2QJAfUFY6a4EMyV+uS8kPKLg2/91pM5KgMAE4r1DasCR/eyI8WHvUcKWayFiOlwrk3
 aJq47eHPT+rpKuo9FhGooi1juQQ3hkYL03juwctrPYCbdXspHRLMJ4qNp04RvoIE5eODM8q/94Z
 MOArhj/5R3rmFkYVNumlmiRw8hQLzgAo6KGv5IT05Norf23r4yIAI7irxGughPdblhlU9dTFEBr
 3oX/ARhvpmG5nfK0erHrJUF9uwkMdWQq7WyRqg/hwDg9iULrC+3rsdQU40RZR/mIbJgYvK0SrJ2
 hnfXdSl0oUYYEq8GI8MTLAuHtLLbymYnT7UMI5mCVVzYFSRTSMx3Py3Jpk
X-Received: by 2002:a05:6512:124d:b0:5aa:b6a:9255 with SMTP id
 2adb3069b0e04-5aa0e740a7bmr2149601e87.42.1778929713160; 
 Sat, 16 May 2026 04:08:33 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc518sm1954416e87.39.2026.05.16.04.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:08:31 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	stable@dpdk.org
Subject: [PATCH v2 2/2] dma/dpaa2: fix dpaa2_qdma_remove always returning
 success
Date: Sat, 16 May 2026 14:08:28 +0300
Message-ID: <20260516110828.35701-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260516110828.35701-1-shofiqtest@gmail.com>
References: <20260516110828.35701-1-shofiqtest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 17 May 2026 14:54:15 +0200
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

dpaa2_qdma_remove() checked the return value of rte_dma_pmd_release()
and logged an error on failure, but then unconditionally returned 0,
hiding the failure from fslmc_bus_unplug() and any higher-level
caller.  A device-cleanup failure was silently swallowed.

Return the actual error code so that callers can detect and handle
removal failures correctly.

Fixes: 8caf8427f85a ("dma/dpaa2: introduce driver skeleton")
Bugzilla ID: 1914
Cc: hemant.agrawal@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/dma/dpaa2/dpaa2_qdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index beca464c72..f7d94bb799 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1739,7 +1739,7 @@ dpaa2_qdma_remove(struct rte_dpaa2_device *dpaa2_dev)
 	if (ret)
 		DPAA2_QDMA_ERR("Device cleanup failed");
 
-	return 0;
+	return ret;
 }
 
 static struct rte_dpaa2_driver rte_dpaa2_qdma_pmd;
-- 
2.51.1

