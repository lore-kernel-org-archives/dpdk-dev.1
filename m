Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14603CCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 22:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9EC24027D;
	Fri, 17 Oct 2025 00:10:03 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 3F6F34026D
 for <dev@dpdk.org>; Fri, 17 Oct 2025 00:10:03 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-339e71ccf48so1828897a91.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760652602;
 x=1761257402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QEiAb0xWJjn8lHhu3wu2eTcZj3vforkFTrJrk3aQfo=;
 b=Vv/zxpNJiOODvYY14IolfCX9eK0x0A+NoWq8iRDLnFH2FLJpBg4lGftXdgfIooDaeH
 yAttZIl+ZMk43iWPqm7sfM9k9WepQJjyD0I6G84Ws8RpxN1yN4zDzjDJxrEa2MN+kFU8
 T1QrsCItGQFAGd2xWWxX2nCh52ZzGRGuKFbcH6Q+kb2ZIS5s9jXOltnw22rgFF6tEUEV
 uUWZU7FpYeGKMmLQqBiOq5xViC3bwgbI/0jY6KzbKOylclD4V6EhgyTrLrpD0q5FNrEn
 EADs0deWUoqyqq/HiELgKdw39b5rsPqdmwwWdBWWqu+Ez2MjPsJduwxDhM9sr5igE4xG
 laig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760652602; x=1761257402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QEiAb0xWJjn8lHhu3wu2eTcZj3vforkFTrJrk3aQfo=;
 b=M4FxvvId5/yh15GEplBt/2QmtkJxeh311fqezR8JncPIzIB7yCTar8TWl6OlmZCWaN
 xUXcwWjgiXxuZYatufY6fuwqjzgsOtkefn50/nskWexExqV1k5ONGJIVpHL4NOLHxZ5Y
 Rfa0i0u/iC0sQhiUi//DUItHBp/XaXLFC2IHkQ5Hj7Gt5+eLmXpaZ1WMWloJazR/fQqA
 uf2Y6/1MJrgMuGVuJ9i0tIF/Sk8RYKoZHZ76WI4lABUAOnmzI9RFelyDbmVoOy1v7JI8
 206bV52YV6gO9VSOJo/3G7T20KVii7YaZX5kvLhTW0monZbS3YejdHM0/N3luZNJy1/G
 483w==
X-Gm-Message-State: AOJu0YzHd3aZuWSvNyMDmDJ0c+zvL8aErFOsnoPjmuBWs02REvULXJx6
 h4XOZ4i44ukJNkWCx2zfjBq8IUWCNTL9B6yrIEGkoAlW/bm1LsPTL79/GsO2C/3Li0sFTnDcjwn
 qcMnS0No=
X-Gm-Gg: ASbGnctfHj0jqATv1cYt3zSbDdULQzkv+hbTsUb4ojeFbrqEK0cfVObCgXbXfwyKdCI
 eViqmrUcDN7JNAMpfNrAYoS33gStt8f4cEtmcrBibETHqYyiMOOr0tBsOZsNK8y7+y8ABDLjXN8
 pv8uhertZzIlRVQ7HIc0TK6PlL4Xk4pa6FGRv0/6v13jDk2xTW5i3n8XJvd/QUeu5Y1awp3dlLL
 OCrJUoLn40kCYVI0CsQ1Qde1f/NpyHWVrkH4TQLuDqDotdpRsdGuVmDFmioA/a/0yAuEQ/zp9xd
 ws+oXhGTxtJvp/hDVvn/zwfQqaPKqw+W6Y9j+Wotjw+gDCwjtrVHf1j7BnpfSgG+sDdo5Mfsxc3
 0cFUKjv0lMo5dFaLl/dA2gz6wQEozQpfM8644LatLj96zw+g5amof9doHm/JiM0ajO7ApVjch2Y
 uUP3HCCARu8w3eHSscq1mwlqBThC+GJBrz41lm8EAxFHUUvlSqjA==
X-Google-Smtp-Source: AGHT+IGumggvsoRZnLQGRgWFJZ3Mvj+O0gPv4wmq893EoDbpdJTSOfxswL1CRt3kVAX8N2ucSIvaxw==
X-Received: by 2002:a17:90b:3d8a:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-33bcf87bb57mr1652393a91.13.1760652602143; 
 Thu, 16 Oct 2025 15:10:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bae2a4e03sm1731259a91.4.2025.10.16.15.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 15:10:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/3] net/dpaa2: make symbols static
Date: Thu, 16 Oct 2025 15:09:00 -0700
Message-ID: <20251016220959.15671-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015230933.875860-1-stephen@networkplumber.org>
References: <20251015230933.875860-1-stephen@networkplumber.org>
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

While looking at how some PMD's are sloppy about exporting global symbol
names, found that dpaa2 driver was defining some  globals that could
cause problems.

Stephen Hemminger (3):
  net/dpaa2: remove unused frame array
  net/dpaa2: make local array static
  net/dpaa2: make total_rx_descriptors static

 drivers/net/dpaa2/dpaa2_ethdev.c  |   2 +-
 drivers/net/dpaa2/dpaa2_sparser.c | 119 +-----------------------------
 2 files changed, 2 insertions(+), 119 deletions(-)

-- 
2.47.3

