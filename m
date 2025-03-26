Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2533C3600E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 21:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83CF54028F;
	Wed, 26 Mar 2025 22:36:21 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id C62B240156
 for <dev@dpdk.org>; Wed, 26 Mar 2025 22:36:19 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-223fb0f619dso7591535ad.1
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743024979;
 x=1743629779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1vzyXNtNyIqt5/7+d+TcqplB0lrTR9m/nE3L/prPQHo=;
 b=rOyPh2x+0nhVoR+Fh31YuDMFt8rGLaBTM8ZGaTg/cNG9ZJ0+kQf+RjM+4IbC6tQxoV
 ATEDBshVJVa8ya6TASzfdsTtDqEI/IuyyiLXaZDMf1GwWd7HP3PsAbJDoDXlPmAeQnu6
 u5o6pvHIbxZutgDCpUr9RECVVMbktdfm9Ko/ZD7hHWav2+mfxVROGiAkUCCUJPlXSN1k
 nO3ZAaYyLFPmWnOWhbqHtbe0XnJ4mHyZbk+z52iFTDmCT1U9xmnSj1Id66ZQJ3tRrhAR
 i0UuBO8eyBCRAjbMXyzjppQOLVMgiegTwYdQSp4U4J7V8tuATKkyaHnz4fGpDicKMgAl
 5pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743024979; x=1743629779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1vzyXNtNyIqt5/7+d+TcqplB0lrTR9m/nE3L/prPQHo=;
 b=wlLd7bFwbj4H2J8oPjGqqP0UcJt9OGEg1skZTjXSkKmXsd+es6uviMcq7O/KvSmBRm
 iwA6D3V3ZLMxiTr5tNh3wADQgTrGuPnxqqoO7LF0H3Yp5LGDM4n6ESTn0aqIEhpMC+c8
 zwvhDcD3J15RjSuv5gQK4FGCsehG2byTiFO3MGMiqvI/gJ6xKlwan9x6Mh1sKwVzj52T
 Ku/bNb/ej4fO3DFgqUmwY7hyGylwS4FTh8LDmKUVyzFIsksRgFT9q1Sn536Zho2ikYcz
 B+By5+OmIuBgiOMW8ov0oHLRDtooQpnZdHf0p02N9dbrJeycQZcHRfvQ32RQmd5XVIE2
 Z3MQ==
X-Gm-Message-State: AOJu0YzjPt9jtqBNjdy7o1qUNdsNC5KVK4/YsxXjcSpnNTkkUKl7ydH/
 TlZaExgkeLZdNgB3nA1nk9VrSSeJUvsvsZ1KusD1pZCelgt9BeivxgxutrI0hnWINqMfuO9FI0N
 d
X-Gm-Gg: ASbGnctqs/k5Cbkh6YcVX5SYOL6F2a9mNh0mwDGKWHLYfv2xH9U0aRFEVgmTLBjEnaK
 Q4EW1HdG/bteaiarIk/1NaN/dqb1fbYJhsfBbA0tQ3PQfM8BG3HtugwZy+pwFNm2ZVTkFSVGxQp
 A9mPvVAHLY1zCdZqA8El5I0qI5+A81age96k8/atxMQq1al8YTv0Je/qzOXYeDrZcrk8TSQlw6D
 9q6udJLo17uQIZElut+md8ZkstZ76RnNDNlNgZZubixUuapFLuKOOLt+j0Jshg4zl8dJdNScVJa
 9Mc7jsCA6+NtSKKN6M0/Wx+/cDW31WKx9BnEVAf0p/OGXKEIFFnjBckUotFlZxwTdvxTM1HwA62
 JJkmss49YQH69I/l4zHJA
X-Google-Smtp-Source: AGHT+IHm6oWR1j5EkthStgL5qtyOOQm09j/B827kp2MHc8DTOWhKNhwhDQ3Jj9Pw9OjQqf6iUn9i5A==
X-Received: by 2002:a17:902:ebc3:b0:21f:136a:a374 with SMTP id
 d9443c01a7336-2280493c09dmr19445145ad.43.1743024978499; 
 Wed, 26 Mar 2025 14:36:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4597csm115807525ad.75.2025.03.26.14.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 14:36:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/4] net/null optimizations
Date: Wed, 26 Mar 2025 14:35:24 -0700
Message-ID: <20250326213608.581345-1-stephen@networkplumber.org>
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

While reviewing use of null device for testing, noticed several things
this driver is doing which are unnecessary.

Stephen Hemminger (4):
  net/null: Tx optimizations
  net/null: fix packet copy
  net/null: optimize Rx
  net/null: count all queues

 drivers/net/null/#rte_eth_null.c# | 754 ++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c   |  95 ++--
 2 files changed, 788 insertions(+), 61 deletions(-)
 create mode 100644 drivers/net/null/#rte_eth_null.c#

-- 
2.47.2

