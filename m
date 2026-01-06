Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC292CE9D7D
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E3F040B91;
	Tue,  6 Jan 2026 17:48:22 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id E85DE402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:48:20 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso7394715e9.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 08:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767718100;
 x=1768322900; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPJ30IhpSUvz9YREXtyK9RZzaVyF9MUBkD3Lf6OcGsU=;
 b=0NYRdzPQeAqImSq8BALSrmteiDPeBA9aqYNSedfVJSgxyri+5E2EZu54umHfTq2chg
 /vf6n6AtvB6P0GJun5PL6uavFw1ID+quM8W+IGLfMnEF/AclCGvu6vuem7w2pFOtbop6
 iO8CfdSXzAlogcJ0x2xGJ9P4n0nbILftj7Rjs5bFV6ZS/D97VGTeJ8f56BotDCo5/7x9
 jVf2FujPKWjlO5XVqrWwxy4gucP9cVJcBUnr/jS+2CF9hSpXmunz+wOmG6gECz8rQB/f
 QsKnA3yR16O8tUGrt/cK3Gek60+IlN4Wx5X+YGO+UMqRIxXaWvKOO99HZgEVBFSYhqpV
 f4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767718100; x=1768322900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TPJ30IhpSUvz9YREXtyK9RZzaVyF9MUBkD3Lf6OcGsU=;
 b=HbiIRYVSzP40WymA/dOH7t9zYinT+WqsvMpeOWQAu+vU+oHBI++LqXo6QU/i8STSh4
 yZf77UiVuw7xi6JZPVFVvz+5d6Iq6R5T6uEskow9S8sI62cusQ2EgEFSelZjhJ75/9BR
 J0i158tfPalDcAU5hSLJUcEWPOZiNlXoA6vmsXk4Dl340DY5gmoWJtSaOt5CUU0fPfc+
 koKBh8isVkBF6C6xHRcppRGUeTpJX1d6pILbnTRN1sE9cAZ8K2P4w+DcM8/XIpj0moi1
 WixRg5TAhXSBa7mo8ZIS5uCLdAv+ah39keUOxNnQJQvtlgmCV+TcZl/l7Xk8GH8p/pvP
 dK3g==
X-Gm-Message-State: AOJu0YyYEYn2SsfJYEto1iM0vy8ODX6JRNJa/re0YnzHuxBQ40oRNUNc
 JTURaZbf/9ugLCEvN4z9mdwXrao45ZMGIlDesOkt67OZheZVlCrk0h7h4zo9ceKCyGNcty4NCb8
 oj61ALjk=
X-Gm-Gg: AY/fxX4uqpuGBC5fF66Czesw15fZ3Pbin57YIYAK9AewdEMeGAvSF5iVBtbPW6qyFa1
 hzWWio93/Z+OjiB/MQvBqkM65mU8Q927teOhzei0xzIno1TPUi8z1Zd5XA7enaRjy17+FY9h6Rd
 +Y9wHCMFkRh1CPLecXW7K4PjhE6uYf1y6JRP8zfEWkTuJZjqUzJ57rkz0z3eiI8ZThtCZaKzN6j
 703UAM+JAE/MVcpWcS8SVV9LlX/spISisDPpRgHj7oI4kcz/shwqVudZCSTlBxmAgWvaBrA+JLf
 0PrHDk9MOdp+JqMbYlWhA/xgMm5MoVE28fam2RloZ5cSHCaJaWurdN0qckp9pFgHCv3iiAV3BUQ
 Ou4lSypT0b0+Le+KEcMn7upk1CEFscUu+X5S7obY1tKcgV5iFYv9ZYJDfDuojcF3FU/qy4JHDud
 R0yqeW34SJoF9j/2dOPAQojMCRuPO33aKdi2K0abug2LArh1azMw==
X-Google-Smtp-Source: AGHT+IEu3ppOnTe8s7AT7dwdSKhJINJfpbCWXvbXwRZ0HezfZ2Uil7pTgUP/UwdpocCSLjVBFDroEQ==
X-Received: by 2002:a05:600c:c165:b0:477:a21c:2066 with SMTP id
 5b1f17b1804b1-47d7f06ceffmr34052225e9.5.1767718100512; 
 Tue, 06 Jan 2026 08:48:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm5197001f8f.19.2026.01.06.08.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 08:48:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] net/null: add a test
Date: Tue,  6 Jan 2026 08:47:13 -0800
Message-ID: <20260106164815.158430-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104222523.329760-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
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

Add a test and small improvement for null PMD

v2 - review feedback and small improvement

Stephen Hemminger (2):
  test: add a test for null PMD
  net/null: revise info_get

 app/test/meson.build            |   1 +
 app/test/test_pmd_null.c        | 811 ++++++++++++++++++++++++++++++++
 drivers/net/null/rte_eth_null.c |  11 +-
 3 files changed, 816 insertions(+), 7 deletions(-)
 create mode 100644 app/test/test_pmd_null.c

-- 
2.51.0

