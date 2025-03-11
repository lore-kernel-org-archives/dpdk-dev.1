Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC65C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C5CB4027F;
	Tue, 11 Mar 2025 16:53:13 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id E441040263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:53:11 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so8726895a91.0
 for <dev@dpdk.org>; Tue, 11 Mar 2025 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741708391;
 x=1742313191; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fOk/RL2Ml27vvh8p5hplGvM2p/+ZZVuCzEa53bpxgxM=;
 b=rq83np7quMgjNLdVZJcXvOl3uUDwCW29GmBbMZxVNQrd7VTYcchswDxjpmzR8ANe15
 t//dd1jabsWN/lGIdEPGVL8Z4zjFIrEAeaOSANeuPWaFOVAhh3ihEiNIjc1qNk1IIvt2
 yVp+863LdCXphoAdNx9oMVqClamFS7d+F8pqq/5DrVbxxAqnl3dKaXlp6ByJ+CvTEk3L
 nUcaJUcg2xraJwNZbOLYiJl353uWUjn6cGy6QHQYAG47EGBbTSXdqZLTRjnyPzR/8VK/
 oGWAj94I7q3fMDFR58SiKvXilOsvT3uLX5LnPsgVHZKeyeyIkJbq2ipnXBLfyjtnFeZ/
 9ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708391; x=1742313191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fOk/RL2Ml27vvh8p5hplGvM2p/+ZZVuCzEa53bpxgxM=;
 b=N1vuH1MW00PQlMDW4trv56nYp1Ht11ZhgNp9fqvloQ2clOT0C9cGVDnF1E6RFD6tLL
 zL+yAnMFoHJM/vV/xY80WXhydISYUYFFQI4EO5fNYcjS5lLbZnHpeRdu44V4esC/pLt8
 TmuQPSkAxQS4DbbsayX1lQ67Uv7DOo8ZC7elVcNVcW275wZ/Kuk45C0RYzAVlF0b9B6c
 a78EwRLasLcEs55/LN8ral4og9cN0fOJvn3bMCAixr/NCMvVsIYIwUU8iqpbWrF08ZbH
 GZZfDHiNJiQdkXl9sdYxUIunHZWoLvldl++hGbGuZUyUoTm6NCsYRARJoAPU5+EBO7C9
 a93A==
X-Gm-Message-State: AOJu0Yy2xgPQyP9t0RJfYMOFfW4g3BYLM8STN+znNzEiMdj/i458DvyQ
 uJ2dYlQMd5guucQf2o0cVO6h7onDJ1GaQ/SZpCecCFbpkxLhJY4TzTBnDgPZTcYUnDFJBVIqMzx
 f
X-Gm-Gg: ASbGnct0P6vVRU5HOcUfURaBDwu5ca+nkecmCeglX/EAWZDaP44ekiBNaTuunW9i+f8
 ztI5+xMCPRT76NnYRJyOnnsDqzfbTdsJesTbriDaKozLzQkNLRdrENJTGxxOu39n5cToJmSL8oe
 l5tYcF62s2cbNGyAhM6Iy3p2TIWIAJgtsYHrHXTsAK+MNkB+Ytwz6jpwPZQ1x8HzLMggA6K90Us
 aZA5W45tXsDTTD8sDKi0+eAELQEhgwePigi2n1StJUK4L+0pLXlKX1WYxdAPz3tReJIYW7r+sRM
 Me6AVgl4mezDvMiLyps8Jp7A/NVZiljsoi3y5raKqXWfUJo/rCl63CNDoD3VvHXRutzQ7OSAa/m
 l6K+PNJ2R1oJoPRQVtpa5Hg==
X-Google-Smtp-Source: AGHT+IEeQ5tfwRLviSvHY94hXSXwh6CSrWOxnsqUNnGMQFQxKwMIsg/Od1dvTdzUkyubimfxAvJP2w==
X-Received: by 2002:a05:6a21:6e93:b0:1f5:6e00:14db with SMTP id
 adf61e73a8af0-1f56e001894mr16021849637.14.1741708390995; 
 Tue, 11 Mar 2025 08:53:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af283576bc2sm9500013a12.38.2025.03.11.08.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:53:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] more unnecessary function pointer
Date: Tue, 11 Mar 2025 08:51:28 -0700
Message-ID: <20250311155300.13410-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

A few more cases where there is unnecessary deref (*) on
function pointers.

Stephen Hemminger (4):
  raw/ifpga: remove unnecessary deref of function pointers
  crypto/ionic: remove unnecessary deref of function pointer
  regexdev: another unnecessary deref of function pointers
  vhost: remove unnecessary deref of function pointers

 drivers/crypto/ionic/ionic_crypto.h |  2 +-
 drivers/raw/ifpga/afu_pmd_core.c    | 16 ++++++++--------
 lib/regexdev/rte_regexdev.h         |  8 ++++----
 lib/vhost/vhost_user.c              |  4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.47.2

