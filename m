Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C2EE909C0
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 15:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 985734064F;
	Tue, 17 Feb 2026 16:06:44 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 4C5FE400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 16:06:43 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43591b55727so4889809f8f.3
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771340803;
 x=1771945603; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vm8a5rEoc6qQmS4kJJ2H6LpiJNYUBZ+GEdrb7CAJ8AY=;
 b=GsHY/emPXQ06KG13GaU4AYBWm+p4d5a2IJrwOjMFAuDHsrp+tDbuqw1Y4aZUj5w+zR
 igLuv5ivPFHcl8V2J1DgnVEeJVErNdnNsh4TD+Tu1GYSYeDw9lVR9iT1BMxyzdyVPRh6
 08nq9x4HvtbjIqxjSGVv0KIcernAMHhH3qClUzA+kZQGkfZIHnRdLZGsf4kvoni9KlHk
 dOkJU1TwLIvHOAmpE5DzBWLB2ZuKYR/0tLrlXfqzVgxV+hC7JvTrB1wYkOeXtEI9Qofq
 0Lg2/hsQwJwvqvw/IGlA7qcMqxWvAla9/9nRz7JNHVs3YILc/HecbS4BfogY+NQfDGoi
 9qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340803; x=1771945603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vm8a5rEoc6qQmS4kJJ2H6LpiJNYUBZ+GEdrb7CAJ8AY=;
 b=vEjRoCSjEIFeKmz5jzOFPIOTkBoZglJT2FM9KVXtghJpGHEIutFoGk7CknsAG/W91u
 IEbDD766yVV62XDnYTdp8gYKiPqE7wJsSeJEQn+eNyebcBuS5LtfMjubOYu+HRd3xEuM
 mQ4ttpMaY7iXL3Zu6fjNQmBGi5UGffKo5CkJH77yNzCvJLBT/2cxdIBpJga060J4eLqZ
 Vl8N3d7NQiNY5ZT16d4wdATWU3ZcKCKubG8wTxVSLkx5vXdHIWwIZ2xpIr4UmfPnTBVg
 KYpSn6SAf4uX0DBY4/rIzUtEWkJAewyYzwDfogYNqXpimoVBDoHmyjJ90qx9klwrV/0T
 iuLw==
X-Gm-Message-State: AOJu0Yz/jWgBeC6UWQr7vPDmLmSSii1vla/uHT/RSw8nYZSmoSckurAz
 we7HZfQW3IxnEp5pquLkoqnPzC3FMkSEQI3x3+Q1EXd/HGBzP0S/vtpl05OquXWMTfPzlzlme16
 KDoe2
X-Gm-Gg: AZuq6aIS+oOK7mTDbFPpwlV0sgZOLgL+7iG+sDJJlgSesA/p+3AWCWEFAQ9LNSHIe4C
 KEdJ0BtifGTtEDvYTqo0PgzUFIcSO06IfI2O8dlbg9qfOwwBxVbIkP1NX3CWofotBjMatYw3K/f
 O9ltkGIXJTq1+7v55VzagntBba3xOzSqNOuTVvKY+FQH2sgbH1OlpHLdXAOgPtjrethSk0Qhk/s
 9NhON1nL0pq/glPEi1VTHAUeePRPBVtOSVN/ak6WCE3VugwQdb3AjTjesfgN0yN9tpoOaxnkY0v
 B+gcrUS+XsdNgTqFieWKB6qGmFWo7lSLpSbteYSNot7KNvPxmU1gk/CfeNvV9xGYKxuroDx4g6Z
 7tCpqUVefk6tIwza5SmxO7gmqlXb6yy29i8p9X/rZVVN7UhFqZkzLlGbekW0aKklSzEineV8pzc
 x4k6kRbTwW9IPeLsWrsc5W9pvZIYW85gdII/YwQVurzpw25OT42I2013dRtR6vnQ==
X-Received: by 2002:a05:6000:26d0:b0:430:f494:6a9c with SMTP id
 ffacd0b85a97d-4379db619abmr23019875f8f.17.1771340801154; 
 Tue, 17 Feb 2026 07:06:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6ba57sm28492012f8f.15.2026.02.17.07.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:06:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFT 0/4] net/mlx5: fix several correctness bugs
Date: Tue, 17 Feb 2026 07:04:58 -0800
Message-ID: <20260217150635.134031-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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

Found these during a code review of the mlx5 driver.  I don't have
ConnectX hardware to test, so sending as RFC for maintainers to
verify and test.

Summary:

  1/4  NULL pointer dereference in mlx5_txq_start() - txq_ctrl is
       dereferenced before the NULL check one line later.

  2/4  DevX queue counter leak in hairpin counter setup - the
       counter object is not freed when the subsequent modify call
       fails.

  3/4  Use-after-free in ASO age and CT management init - on queue
       init failure the management structure is freed but the
       pointer is not NULLed, so a retry dereferences freed memory.

  4/4  64-bit counter truncation - uint64_t* cast to uint32_t*
       leaves the upper 32 bits uninitialised, producing wrong
       hairpin queue statistics.

Stephen Hemminger (4):
  net/mlx5: fix NULL dereference in Tx queue start
  net/mlx5: fix counter leak in hairpin queue setup
  net/mlx5: fix use-after-free in ASO management init
  net/mlx5: fix counter truncation in queue counter read

 drivers/net/mlx5/mlx5.c         | 13 ++++++++++++-
 drivers/net/mlx5/mlx5_trigger.c |  3 ++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.51.0

