Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD51C282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 23:20:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E91840261;
	Tue, 11 Mar 2025 00:20:43 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id E137B400D7
 for <dev@dpdk.org>; Tue, 11 Mar 2025 00:20:41 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2232aead377so22920195ad.0
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741648841;
 x=1742253641; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufrXnaTLduPhX31jxkjV3Ev6W/PIr1yabHyBrhmRymU=;
 b=DnKfiqejR/Bfwxk912NgxTEOb2u8BFMaAQ3Nzp4WOQZ9kCKOsiL2uEBfNJuVA0swgW
 4P3qOhZwQ7JGcLdh9Zcno9CMx2YyLdpy061mOj6hP436Taz0tclEPRwYNw6J2osKaDKu
 HgZlDgjwix2ZBXjEES3SbaOmlfeC5u5YG/ZRKMqWFGAegPA4xaTe3SMImHrSP5uJENNl
 +MMZS/m/J2ae+xwIpdtbHkb9zROuAPKSJ4IhRRbalrjl9fcwiZYILZhJy8CO+dZH5S07
 otm8Qhz9TdTa++LxEgwjx58WZHJWZ6zdurO2V43XLKlQQM/vO2LOqF2Mn/Ls7f3dnOex
 lcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741648841; x=1742253641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufrXnaTLduPhX31jxkjV3Ev6W/PIr1yabHyBrhmRymU=;
 b=srrh8TllGHZZrR1V2GkJUNAm2KJBKVrz+lk/qfSd78SUL8giCFxc9Hlabx64nVJksO
 uTzv2WMjjBa0dk3PHBReypziYcdAvT5H0rQLgoKBXf4ku+yVKcqZVAkc6287LOn6+3zd
 2rIX6bbl7DApbwgu9416JDeeBX5h7gazNNF/O78WOTwlSpx/+5p8/viW7oA0a12fzEjg
 XUD74I1L3GFhA0c8/M6NosOUoc9zQvIY7QEBQn8+jumkDtiHHK6YrmYl21I93+j1TGlQ
 dqDKwIxiCTVVMe6bWANGPweTKxGMbOaBD/D7QCe6PwEbkoGJowpWc3zLut2BJ5XBGiLs
 PzEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhEpk/YMeG4AQNjmJVp/MT6kJbYVnytfQap71FrZRolo8d92kuK54/0vDNrNxJ0vXboVs=@dpdk.org
X-Gm-Message-State: AOJu0YyPCTxZfLSi7DNNFPvsxk2aoKg/kYhuwPiYiFKGxiqiJ5FeumvU
 //McFIpYSDePMPgAdu/FtAOVotejhb3iR2M6vG6riT3GtQDiCZ7mf1cEumbmN1o=
X-Gm-Gg: ASbGncvuRyIukUTRps9Fi7vWhc88Ro0JA4LsiNMzU2+VQYNTLxz8mJ1gO3vIeYy2ya9
 MzIxHDSX8yNXTzW/N2EIxG1kHu22vn4r8QJN0FWupiAz8QCNqJsyKBS/GPdfj/7wXBPm9uzul64
 hTe2atksFNWh1T2IbsXu2BrtzY6+MAOgW3Bj1Dp9+UxyQXo4HYkCt46o4tQzJ/4ZhG6QJHuPUv0
 C5ndyHBrDYLVk8S0StgV2GrP/a88pTaN3n73gKRqS86tfUCcEJUjlJXGgDT5pZVYCduzESD9hKY
 PYNuxQ5pQJC0SQnLHknqv9p5mSYkWb4l7aVZPLgH7ORQ7jeUQxkqp7gfVViBcwYFE8oEJHmiFR9
 ijJy7fbtQRjV6rVvpLsKvdNnWgApsSXRU
X-Google-Smtp-Source: AGHT+IFf6YXEOQ/uKt+gM7o3Mr2Hqyc7IBxI2qSXQXGCfRnPj97VEScD/twU540oe+gzWmkLrPajHQ==
X-Received: by 2002:a17:903:8c4:b0:223:52fc:a15a with SMTP id
 d9443c01a7336-22428bdec6cmr230441175ad.33.1741648840928; 
 Mon, 10 Mar 2025 16:20:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ea390sm84189545ad.69.2025.03.10.16.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 16:20:40 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:20:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [patch v2 0/6] Support VMBUS channels without monitoring enabled
Message-ID: <20250310162038.5c05ce8b@hermes.local>
In-Reply-To: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
References: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
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

On Mon, 10 Mar 2025 14:42:51 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> Hyperv may expose VMBUS channels without monitoring enabled. In this case,
> it programs almost all the data traffic to VF.
> 
> This patchset enabled vmbus/netvsc to use channels without monitoring
> enabled.


CI still reports a build issue
