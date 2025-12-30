Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D815EE4992
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ACA9402A0;
	Tue, 30 Dec 2025 19:58:44 +0100 (CET)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 1B54F40267
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:58:42 +0100 (CET)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-649e28dccadso17292176a12.3
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767121122;
 x=1767725922; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ol4UqvUwjIz1uAunIfci5/4BbI1ZoPqXjNFkr1bvViY=;
 b=MluqdvTzHfQWrCnkF4B/hr0SWtnkBH7Tz1zinD/DPBkryJB9JLlf5Jxk1tsG+LP77B
 1E1bElCmVLJEW5DZKSj9ATBlMFdsf4KNqtrdEBkZoEb+EojyJQJIcHWQ1k17RJEwohq+
 iX6wUPnMmAMyow72Zs/8JSnOJpJbIJuQGztDQkaYAtMyDUKKgBUG2kQjYPMf0o643W16
 lUMYQqIaBVixoclcDCIR+8YLPa/Trw8oKQ4npmJgfh8UjrKroBlOCDHUeXv0b37Pg5O1
 4qNUwB1OQ80xLM8irDTkv+ixUU8CllfG3CUpKx6Gc4ceXIq16Wlij7bp/DxLygEI+us8
 vw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767121122; x=1767725922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ol4UqvUwjIz1uAunIfci5/4BbI1ZoPqXjNFkr1bvViY=;
 b=VikocEHxjPVliiJ8AnEYq19gYipZ9EMNYf6a8bYnFNaNKiNLdRyvVvyGfrL9WzOQRW
 y1tKvcuz/ZCE14cRw3gHtTIjO7nrm7pVmNk5sFO5uA+uPh0jomdG2SVTT/Km832D4D31
 j4j4wLk8OXM1gC7VpTxNWe4qoN+dy0+22/BDU0QnnGJLbsHNp1Lz9gSve7mPO5qhynBL
 gkFbUv1ZTakvoa6NmeSQyRRFvvK4RUMUlyeG7sp/SclaSIyAcLOCiYRbR4Zsd6g4fvk4
 N6jsBfvilwgz0GT3eHSQON08T2sGspaIwWNmP+vop8aWnYfP0oEZmkOxDuVrLa104tZ4
 t3CQ==
X-Gm-Message-State: AOJu0YzLHbQQiMxPEYt3jj+DrivKCFTKLNYGSCw3o4nln7uA2xnqIaom
 J1ClgR8BS/gkorvWI58PzVE5zpSFIiRzIKlKb+AtUjh151zUlXeQYGXk5eL2h19jQ1GywxKiWPK
 MxEXz9fQ=
X-Gm-Gg: AY/fxX5nfiSW3epfDBLNII4Joqiy9b7vu3P7xYiNOZXwstYhZlaJd6L/6xye51Vs8Qn
 Hea5CjI75VtLIlvd3VQbcpR85hwRIaUpbJRCz2ImNL8DSpfEX8WJAxzcIKAWOwnKAlwVm0zS8fc
 TgkPrSnfn+nTG7QrHbp/7FIjJsmi+XPQxrIkYl8sLooiNGancEJbcc6+/xzbsXRupsjfg+HebMQ
 3K85hz1VeNuSm03kh0oYhdJAbC5nm8U1RreGvntenu7KN4Bab2HAjR0GDQNyG50AtAZl9p08O8b
 0X2NVZLo5UjQx/2VU6eI28B3ahwR1MlFUqMv9vptNNbS0P6HM8zYQ4eNTwlAk2WPSFkQL6Z1ku1
 RSjvEQBlln9JmQoEsiImgdk7kWAPgmdBpwr++hhPUNRLiQTsJsbN9cTszG7FFGJRfCVKrhY6frn
 a7o8BxNmrvPjlt7tCnOxuNcS4w/FSTVLE73N1u0hXChK6cd65ei5L9i9zlJmLd
X-Google-Smtp-Source: AGHT+IGG/1nswi8m6V4XTYtrq/Wxg2P984Iy2lEDEcC2BAMHqQ9mmSXufxsi/CYA9RQ5/KEprhJ1eA==
X-Received: by 2002:a17:907:a4b:b0:b73:210a:44e with SMTP id
 a640c23a62f3a-b803717902bmr3885931066b.30.1767121122313; 
 Tue, 30 Dec 2025 10:58:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm3745449366b.40.2025.12.30.10.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:58:41 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/7] Fix build with Gcc-16
Date: Tue, 30 Dec 2025 10:55:08 -0800
Message-ID: <20251230185837.301163-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228184300.541639-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is a collection of previous patches and a couple of new
ones which allow building DPDK with latest Gcc 16.

v2 - remove accidental temporary file

Stephen Hemminger (7):
  pcapng: use alloca instead of fixed buffer
  pcapng: add additional mbuf if space required on copy
  test: add more tests for comments in pcapng
  test: vary size of packets in pcapng test
  net/bnxt: fix uninitialized warning
  common/cnxk: fix array out of bounds
  examples/fips_validation: avoid rte_memcpy() bug

 app/test/test_pcapng.c                   | 116 +++++++++++++++++------
 drivers/common/cnxk/roc_nix_inl_dev.c    |  10 +-
 drivers/net/bnxt/tf_ulp/ulp_mapper.c     |   5 +
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c |   4 +
 examples/fips_validation/main.c          |  14 ++-
 lib/pcapng/rte_pcapng.c                  |  38 +++++---
 6 files changed, 130 insertions(+), 57 deletions(-)

-- 
2.51.0

