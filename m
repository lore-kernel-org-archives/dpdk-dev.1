Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBBCC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:43:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E62074065F;
	Thu, 20 Feb 2025 17:42:15 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id CBB9740652
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:11 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso21477195ad.1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069731;
 x=1740674531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=22NdSIKgWqunl7WrtO3jRWetJ7rR1mRGvJAT9wvn6NQ/F2jtq5mNS61gOETPw4wPNH
 hssoCbi1EZcSaO+o1mrZ/8nI3RtEl58g48dMGu3CLG6CY9BdtL96esIRYOKSbgwfaGmQ
 +6d2+1a3stkgcK0G8kOqwYPikBl0L2J9ja5jcD4Bnku2yzj16lXEd4KRiR3eVHP7gdDD
 XP2uKF+uuoPaVtg6EZPvknLQbEROUvgWaT4M/Fq0dORoV3O80H9nMyC1BmxkryneDVnZ
 4k3/5qP1xCkcyG1gAXZQ1g3uuAcaAB3tBCjc4EVLY+EWOiQ83j60MReL5W/gq4QUd7Ef
 OU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069731; x=1740674531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=EP7abcvWfQd5hAJF6B/0LeosfEExm+S+b5XJVL7t3bW8b3t7fKimTUDPTo0HUovFsN
 T/uzSgZGhf4fp5LJlHkmZ7clQ8JwxNkX5S4cgMlhrYCzAJ4K4mgsj1A0BfJ9eC2fzjah
 cEgCT7dpl6L76k5/ionVOZJjOdK+VUy9mkwAj89hR6qmYKSUIyvRBRdi2B14MR3eiAmL
 leuqfyFqiqckUS80c48bltBx9FQpJXJ2NXQ7ui5+G+89a5hIgDAvX8wrVyzVzHNvrYzR
 1ENNZhu2VBuvkODokkJUJXxlHmyabkpHZHlxJKnMB4/4PUbfmJoY83b/MVfF7ZMu/zdw
 lUZA==
X-Gm-Message-State: AOJu0Yy7gSTwYe3SiN4+FM8BfMBEW4Gyq1I41cb3ttCDz/nyQpZC2Agu
 NYFFMGCn7yqIJQAzKsPeuUwGBNosLOH53H18/qOBMls07kmHjmNE9+DYlewMZocoGl3B1C8Ys0J
 B
X-Gm-Gg: ASbGncvLet5jZU4Yzl91xIM5f895SLnT/FYkA/UHX+xqjmY/FJTKOQRKV509HU3ahF6
 /BjB+OCe4yVR4+PhHlUP90a1Yl5AjuSt+QNBZnrCEQ/FS1fjHD3kkdAVGayvH4K77xTQHD8RBx3
 8o0IS30oWiN7/trWpBa/X7pNONDQVV9u7Y45IgxrIirGTzREzAMn/JB9DouJra5tCrlWbwuQ8sj
 yXCdQc5aYRJn0Boc3D3N0Pm8O5XqNgrUtxv9IUnyflic+y2NGY/KV5Gmzswr0YI2yYnJ5QiPezA
 01XZoSM2XiHMFRLlqtmSFWt5mdXY3pDO8L+EzyF3MHZ6DOhToavPjf7HYHU1ZW6F2uKq
X-Google-Smtp-Source: AGHT+IEbE7QRMdNqH3IJk8vMm7X7sizeSxdjx2mP4Ixw80GTJg1Moj7eXFtlLz+VhYqAtQo00JHFWg==
X-Received: by 2002:a17:902:f54d:b0:216:271d:e06c with SMTP id
 d9443c01a7336-2218c3db4d8mr63385935ad.4.1740069731034; 
 Thu, 20 Feb 2025 08:42:11 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v9 10/15] bus/uacce: remove memset before free
Date: Thu, 20 Feb 2025 08:27:16 -0800
Message-ID: <20250220164151.9606-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

