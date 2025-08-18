Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2FFCA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EB0140DCD;
	Tue, 19 Aug 2025 01:33:52 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 1D422406FF
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:50 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3b9e411c820so2516685f8f.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560030;
 x=1756164830; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8H9YOMc8qE+VCq90gvwYUbsisiN6hBhywzqiVcqRPs=;
 b=Rr9svVjMWkJlgU7OarfskGjTdzCq1iJVMW0ZwGK7NXC+7WlJojW6ahGthRDFfQGGQp
 KNlgYl1WbA6lnlUvyQ3tu7xdFrgRICVgqjfF7qF6wQL+Ep37k1IEhWOwoBIV6lrW8P6O
 rW8n2mzGPIHakD8vnLjIlQke+DIErXhwqL49KstJ0+55lGIPP4K2bSgdJJ0bN6lJTYCA
 OqXJaaQRi+t3h+jZN93tcvNxvWnz6B4hv/TdBSzvmHJz+1Fb4bWB5tuq0Z1JmL2NhJ3C
 YncAGPJCVaAZxoCNssG+vphGSXKyYdJyyBWL8UE2Sh0hQEfQwkmH0Xa8OKnIP0r84vGO
 FoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560030; x=1756164830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8H9YOMc8qE+VCq90gvwYUbsisiN6hBhywzqiVcqRPs=;
 b=az0ESdmpKIcFPlLe/0M1B5f03IAL+OStqnELSxE2leRoIc8gbaeCPvYk5ypUQ87BoV
 /J8P0TqpwStj/uCl8XvpdGHwyTPcmQlfc5wo8wUNJy0ksNboKa0WcTBqX/b4f8nIab7O
 cEbyEevZb0yDdVp9rtNXeVI2RSbXm8n+ZIPuA4H8Fb4+zwxgUT3w/RFqaiKXbBPt1X1Z
 1W1AFD3zTV8igXN+CNrAxLXN/cXvhLS+rtDLVOTxElEbSIUIHIFfZQOx4RdGiDb8SmIB
 JB8e9Li7ntpf7FSgmbRo3qh2tbMOiCkK3p32/1BLfTrTsgsmDWBmdjTMRNoyxjXuGrbl
 MkXw==
X-Gm-Message-State: AOJu0Yx1axSfHjklDPVR97nysZt6WOVIVVC7nntQ8ZX9Z1TI2Tw3KmjO
 foRtjPYHf6Ung2tcXRJak9KQrDEkxJa7u3SOTRSXDAot1LM9VznSOIO70zUjPk/Vj2W2Jpu9dk0
 29mS3
X-Gm-Gg: ASbGncvQhf6YshdcIsURmp07forSUV1Q5GkREToxSK8QqIMM9rpHcwfmNMF7vvaJBvh
 E7fxh/DWiekhOYsa3shtw1JscxD4PU8prGgmS4xEOk1BiTF6/JvHumhV+dXZrfYDThDL8yn0C8x
 lsmPCgOcP5YQtpPdp5zBXquCNUukfvD9TF2k3MhrllKHEY85v2pfYSQjHqurBzMo++JD2wEwr2O
 L1lM5aZK/HBkoSjWFg6eyNx+vwXp2yNpsOykU2OoKGtWylNvyzYpQiB3v/OWIAPNrNbn+iCpTy3
 GVZzUNLhZYmxfkp6qblRwLa01+A28YLvKGaSF65cMCcbbzrFxBUlSyWTrB7QrGsT9MIfhVRRWd1
 ZRgcLYB2QndM5KfmE/z04FIX7yyW7wPiYBgUcXo6ZN9sf/yybzr62w63KCaXqPMvJb9ftAnC/tn
 qv+vW8MBQ=
X-Google-Smtp-Source: AGHT+IGEc8fNIWkUp70PLEfHxx/PCr4UTZJR6WmN3fCN1S4mXUPiZ7uPT91pJQ4VqiKQmm+EgRpeag==
X-Received: by 2002:a05:6000:248a:b0:3b7:905e:2a32 with SMTP id
 ffacd0b85a97d-3c0ea5ba101mr289523f8f.12.1755560029684; 
 Mon, 18 Aug 2025 16:33:49 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [RFC 28/47] net/bnx2x: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:39 -0700
Message-ID: <20250818233102.180207-29-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnx2x/bnx2x_ethdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bnx2x/bnx2x_ethdev.h b/drivers/net/bnx2x/bnx2x_ethdev.h
index fa1c3ba955..3434aa0c9f 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.h
+++ b/drivers/net/bnx2x/bnx2x_ethdev.h
@@ -8,7 +8,6 @@
 #ifndef PMD_BNX2X_ETHDEV_H
 #define PMD_BNX2X_ETHDEV_H
 
-#include <sys/queue.h>
 #include <sys/param.h>
 #include <sys/user.h>
 #include <sys/stat.h>
-- 
2.47.2

