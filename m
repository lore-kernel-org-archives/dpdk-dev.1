Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3051CC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 20:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59C0940292;
	Thu, 20 Feb 2025 21:54:29 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 04B374026D
 for <dev@dpdk.org>; Thu, 20 Feb 2025 21:54:27 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2fcc99efe9bso2254097a91.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 12:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740084867;
 x=1740689667; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXLHUAVRqIUhkJxgOEorzfVWOnpIxSGJvo19A+WYHoA=;
 b=eZueyeWR48KAsqOlwWlC74VEBUZxGuzMnDJRed3lrUF7fLKYbDjQRS+wgzcThvN9iu
 hamFIH4vGlu+TFoPUtvjAZAuYA+l0aVusBmDKfTcTzEP0417Dbo7TY9dG1PocPl4egFl
 nNrW9nBtU/slmWR5YZyTGWdZ24Jx/6eVzEfosW8MtrU+2xc5szxgWqeI9BNZEqQIItou
 +HwuiRTDuM+NsvAJPpH5OHutwYKkYKCHfldmaAoEape5ooxUtpjvVxXYPl8WY3S7Mek7
 vNp9niGS0eU2buK+ZyDdDw26MPTae27q3g4YdvTHQ9nWa9LB6wE1dh8MhuXn+EEX+IBm
 GpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740084867; x=1740689667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXLHUAVRqIUhkJxgOEorzfVWOnpIxSGJvo19A+WYHoA=;
 b=cTVZrp1LaRJqQmR2S3CRGuZZi9BUszmpEDCXF9pMq6gPnwdtJtGlVZCFOwzUZw2orL
 7Q5cm/RKAd3f5Y42nIKI8za3fNfb0yVUhhakrYVYWumXYt9GFsUZiccj9xNuzvb6FQLs
 1CV5mSOfA2l9oaemM92qdOK2ZeI40FRCsZy/3KNL171tYVYyKi5AF3jH3VzUW+nDFjMH
 DNQRhQwUrgADdDfWe9ZqeBeZLM4+DuD9UbExHvyLrk99kD7d4jOKDCBZMe0T8ui5+1gz
 ogNyljkcnCV8NA5O8qkVySrwJuzja9zxTCpdMI4sGBzffPA4xH30MCsAThcie6/oW2gC
 22vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/pyPc8wHPjfvQP5bII2S1vOM00Q7794C/dmU4TMRwvgcBTNokiD1THcrrqDHDsF4rjfo=@dpdk.org
X-Gm-Message-State: AOJu0YwE/XsKoWzEkT3r/Wj7G7IAp/Ac1FIyLxpVfvshZiYYtp2VH6+I
 PQR0H8et31vudhi/fXXz7JzMGCcbAm1cCA2mJHwUUDag2x2CNDvde/HUM/vB0EQ=
X-Gm-Gg: ASbGncu+B3LuAea/12pgIt2cWfMQleVskhnT2iyLWZFRJHv01vkvxquOuwVG4jVPKk9
 qTiSYKbmFMUwwvnoywvWwjaapoPHI+om9t19QISgXwo1G6JeBN9tDPW7UtAsmjPywWeQs7fhpPM
 MYVYod8goBQoiBg+7aHLr5hm5ctEX2zNk2zYoCLwSKzNI0MB3HqkQ0OlvcWPWIDeDWDByhHkOzt
 kYdVxJKAuY6Kgemh9wcvLu8R1f+/CHL5JcqikvPOceqbP7FNcHYSDEK47Bi3vbMlkdmfy8H6J1m
 xCP11ltSoOhx/fovGEk/I7SKcBAbcgP3mw27jDJR2AItb7+xXqn2gGwURBZgHPkqEmvc
X-Google-Smtp-Source: AGHT+IEl5NPvl9HCMJX4jxsUeYxBY4eNs5LBlmc0uzUxWBp6AQQW904i45VVlzuNvtGx3wSTK8HLHQ==
X-Received: by 2002:a17:90b:3e8a:b0:2f1:4715:5987 with SMTP id
 98e67ed59e1d1-2fce86ae503mr330408a91.9.1740084867105; 
 Thu, 20 Feb 2025 12:54:27 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13b91227sm14328911a91.32.2025.02.20.12.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 12:54:26 -0800 (PST)
Date: Thu, 20 Feb 2025 12:54:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 0/2] fix testpmd DCB command
Message-ID: <20250220125422.266b3947@hermes.local>
In-Reply-To: <20250220070651.42123-1-fengchengwen@huawei.com>
References: <20250220070651.42123-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 20 Feb 2025 15:06:49 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> This patchset contains two commit which found when debug DCB module.
> 
> Chengwen Feng (2):
>   app/testpmd: support display DCB all priority's TC map
>   app/testpmd: fix segment fault when config DCB
> 
>  app/test-pmd/cmdline.c | 6 ++++++
>  app/test-pmd/config.c  | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Applied to next-net.  Added Fixes tag to the first patch (since cc to stable)
