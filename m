Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3054C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 23:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90D65402B5;
	Wed,  2 Apr 2025 01:48:40 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 53A0A4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 01:48:39 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso8226781a91.3
 for <dev@dpdk.org>; Tue, 01 Apr 2025 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743551318;
 x=1744156118; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVEIx2xoSZ/8QTJDJHVxeyeZI3P7/IRQduuf2ZR19jg=;
 b=AZqPD0cYuFydDgftT/QDE6VQ5xxGRoSWvRS9jcIFfzqklcgwc3niaItr42scgQZSKX
 AviOAU+XXjZ0eSO+VtzNfzbs3CIkGV97v2yoYhzHNoK2q1lyiysPNl8AW4B5UXbRWV/y
 73flvmTndNhxXYTWcNn1JScWiUXfJsczaAfXpkMQHgcfc9W9IORwWvYIGjiwQp74tQCs
 UWBS0FozPbcgIVMtXrPAw9MwFb0k+enoPne9jcavSFKtWPf9Asg5SIM4pL6UcZPeLj+J
 kBcdQDrOqxIK4Y47xCgRRPtci5KQCyPm9mlmctDu15MiP50dR41GBImrx0ijDB/Q8mlu
 SXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743551318; x=1744156118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVEIx2xoSZ/8QTJDJHVxeyeZI3P7/IRQduuf2ZR19jg=;
 b=oPkVEc01/Fv+faelBLOYhcM1PiqJnl/MJRNpePeMps1/NACuquwSx2YZ1YhACwjS3z
 p8syVYGMDAm6rKbgpNhGla8wRo3tNx6wFde7ehCECvHiM8jJcG7cirLF2DBkxWebCYjM
 mRG3zgLT+jGOKHl73tkYAorGKz6ldbk50g+R/7lXg003488DrwjxlU8YhhA5CUHM8Bkk
 CvPEe3ggSAB0QgRqLm2bKNXG9wntCguO4rs03sQ7fglM81OYsxKWygmEK5zUQroKA+Om
 8lX8kUli21+AbIiS2L5bsR9sLr3l0raWf77SjmxmhC2sfE5MmOPL54IpB63Olw6IFg1d
 n7HQ==
X-Gm-Message-State: AOJu0YxWI+HUheiRJZs2qsviYc3nSD4+HdZU1w1f12FVcDcKcKwlfmSA
 BT7Co7XuG6pmK4LIVPOmisHzq7YIXpxeWV5+rqUUiD33rhINmssX0fhzU480UIBzNKCzbfMRXpW
 c
X-Gm-Gg: ASbGncu8f2/JKD+wWXJXkDOzJQrLq7yp2FPCDlrq0VoPFqSt/9AmQgi8/GPxHc4lYMy
 ieqeoKHzIqZLEdw2OBVIK0BVbOl6LN6H0Qu+qXXf7WaaJVKmpM3VBcytI9Vb7/3BtRzoCMRQT5f
 pPD3S/fmUHB+D2208o1DQJ5pk807U9T8NyFFRxhKgmbW8L/I6ZnP4Cjrad6YoiDRlWhGAIz98ig
 1r75f5HfkGnvmkRflZy/SJmUwVuZOwgJEpi98p/qWN4V+VJBB077LjL8Rt93tFujGsu7cudN/SI
 5J7mGurYFefjv//eM5eIpa7dqT7bVePoetiWkRl7ihuqiJKbd6O4ckH0+O2VG8DhezYVc1MnNW9
 yTwXamI1u1HSqPPmoVWVu
X-Google-Smtp-Source: AGHT+IE8DEoEyFti8Fu0ooTuu/3SVKf0Abjpb9S1PX6EDUdMDw9Pb99Yv+/f3v9Wvv2EAuNe+GvBSQ==
X-Received: by 2002:a17:90b:4c12:b0:305:2d27:7cb0 with SMTP id
 98e67ed59e1d1-305320b95e3mr19773669a91.21.1743551318381; 
 Tue, 01 Apr 2025 16:48:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f8bc5sm95135175ad.250.2025.04.01.16.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 16:48:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/4] null PMD optimizations and fixes
Date: Tue,  1 Apr 2025 16:47:25 -0700
Message-ID: <20250401234828.10888-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250326213608.581345-1-stephen@networkplumber.org>
References: <20250326213608.581345-1-stephen@networkplumber.org>
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

While reviewing use of null device for testing, noticed several things
this driver is doing which are unnecessary.

v2 - fix spelling and patch gliches
     add byte count

Stephen Hemminger (4):
  net/null: fix packet copy
  net/null: Tx optimizations
  net/null: optimize Rx
  net/null: count all queues

 drivers/net/null/rte_eth_null.c | 149 ++++++++++++++++----------------
 1 file changed, 74 insertions(+), 75 deletions(-)

-- 
2.47.2

