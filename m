Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA2E92FD7
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 22:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC622402B3;
	Mon, 29 Dec 2025 23:01:00 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id AF5114025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 23:00:58 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64ba9a00b5aso10886196a12.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767045658;
 x=1767650458; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5dZjAwSP0t7Ie29AyafqqknDPvRo8m9P60sgDxjAI0=;
 b=nstS6NE8kLIyLaRhR2hplREbFV/kZ7plN5LRXpyD/z4p52oQygXqw5Dniyo/NL7K3B
 FvN5F+Tg+SsOT4kLC5H4vVbHMzGhptnAFdLY2XFGHu539MOsgmew6nmiNZ4KHti7R10+
 5rLa9gKf4YE2NtIQXHxE3iO0ZkoT7athZ67O+t6F8pss1BRO7bKk1/4abgQbnny2O3/9
 8wAvC96kgGEmYtX9BG2Hc51jMLSWYpS9ViMZD7HLMfb2rW+ddLe00UY0n6jQJdLkk0xV
 tiFqchjxyFoPnqgTt+6PfIZheMmkcVD4OAFeaJh+2KzdhCKJ8uzfnQZlHNp6qYICJyar
 73yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045658; x=1767650458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M5dZjAwSP0t7Ie29AyafqqknDPvRo8m9P60sgDxjAI0=;
 b=bOe9EFFWaFBhEi9MOnHMQOt/BBicnXwOnTp8dI8e64zXtM6tYYJQkpdvp+TOnE5ajD
 HgU3oXPJw8PHfcN7j+CpYX83CQ10wpDAST43guEiuZYsDMSvPst6zL0eS0yjLjuXl9je
 TB9dJN1LBVSC9N7BGOqSSayJF709zCFvGcD5E8jSwpjO0aE0ok0lbwaCA1YeW93noGDm
 fAiFDnrkdR+eX40Wtu0hzebWNXdnTQRY4leaciOk6ReZaoeocy6W4Z0qWCD7gTWquexc
 8FiTyyKOZkihF/toFLLjJuI/RFHo9FEBzeGHFyZbrkgNhlWK1yFFY8MHtCA/XEwUw2Mj
 dCFQ==
X-Gm-Message-State: AOJu0YxPnVHIoBOEfoXK4CnftoyljLSE9wftfbCifovtJHffR86rurdn
 Tgyp6Lzw6duy6Y/JQHaTzlE8l+cvADDESfNRyhtaMSLmga1msgPvrfBRmwomsedDHg85ARtoJb/
 I/aCe4+4=
X-Gm-Gg: AY/fxX7uHRU9z3HCnsujsYJq3Hp7LCM1iqXbyB9Jgb6PJEFRsWhX+49Bsz/R9NhO66d
 LSdWplevva732Qf+eaAYoLCsFXR5PpBVyFyFng99HwMzGR8hrWiVcmgsJqZIIZYC/TjWqPGazzq
 PCEofb5WV97dmPeyWx5mT+6CEzpdRbw1i7vLwppvkC2FCj5lfhMiYw+2Qj3bdHhkzz9OQTsmwxa
 pqcINQHHvuhvaJJhbN8ea1AOpEuoAdTyjXrbbeCa+dsNiundWkoAUZOJwJUbdP+9qV1awB7CoRX
 IqZg7oJPeHpO5yQ4iEeFZh8iRPXi9ogR3V6F0WjFYsLgCw13n4OZy1lJgC/ZWTUh7foTciXEf6k
 2fSiTRQl29AYrJvbgje4g4Z8ArxCjmQ5wvMXFSZjSL1WMa/qE+jR4m0wDWB3CiXZbno3fh0yzoo
 yRLROvAFXo2/EgQdfHWtvm25fJHjmkwb6yVspXmlyWOXsxGeZH5w==
X-Google-Smtp-Source: AGHT+IGCctIouUvai3Lm7TQS7E8SLYZcI1xCvYPS9sFWolsJrug376nz9O6klG3RvoAEY28c9QUBoQ==
X-Received: by 2002:a17:907:6d1e:b0:b83:8f35:773b with SMTP id
 a640c23a62f3a-b838f35775dmr179933066b.54.1767045658142; 
 Mon, 29 Dec 2025 14:00:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a62973sm3496359366b.6.2025.12.29.14.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:00:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 0/9] tests: enable and fix format overflow
Date: Mon, 29 Dec 2025 13:59:00 -0800
Message-ID: <20251229220053.21981-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
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

This series fixes compiler warnings in unit tests about
format truncation. It also refactor some the related tests
to be cleaner and use standard API's.

v10 - fix on FreeBSD
    - rebase for 26.03

Stephen Hemminger (9):
  test: increase size of memzone name
  test: add new function to get current file-prefix arg
  test: refactor file prefix arg handling
  test: avoid overflowing huge directory path
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test
  test: fix overflow warnings in common code
  test: re-enable format-truncation warnings

 app/test/meson.build            |   1 -
 app/test/process.h              |  44 ++++--
 app/test/test_cfgfile.c         |   8 +-
 app/test/test_cryptodev.c       |  22 ++-
 app/test/test_eal_flags.c       | 268 +++++++++++---------------------
 app/test/test_memzone.c         |   2 +-
 app/test/test_mp_secondary.c    |  14 +-
 app/test/test_pdump.c           |  13 +-
 app/test/test_table_acl.c       |   4 +-
 app/test/test_timer_secondary.c |  12 +-
 10 files changed, 161 insertions(+), 227 deletions(-)

-- 
2.51.0

