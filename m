Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6AD0E6FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:22:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E9C640A6F;
	Tue, 25 Nov 2025 16:22:38 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 961E5402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:22:37 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-29853ec5b8cso68716105ad.3
 for <dev@dpdk.org>; Tue, 25 Nov 2025 07:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764084156;
 x=1764688956; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y0tRafhIZoyhJVzGNefod6zu+Z7gKsZaAltmOL9vY48=;
 b=pWVIEECRo1WStLIyfynLklS8xUYnyMuB0N9YvqSYvwPQsP9D3rv9eBGmXj10pIOPeW
 Dw/53/huqS8EgO9jTxws2+rt7W/V3mEIS78w6W/yD4uEQiQZKiuEc6PTNxoOergsPJyj
 VvlE5Id8VC+PeCkRM89Nd/vaZ5C+tFd6MrfibWhcCug9ZGLx+GoKJRkMW7/B2F7n1cBo
 OMEzGDxd3jsqt+6KyfJqoIPIENyzlcOMYtAnoSH/X9jtdRx5NK00QTbaePwHO7sttnSp
 DL7r506JSwmAMPaNYbVtP2VJeH6xjqTE80BEH53QiX5hXdxvLU449C4sqEuEBj/J+zl7
 kBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084156; x=1764688956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y0tRafhIZoyhJVzGNefod6zu+Z7gKsZaAltmOL9vY48=;
 b=eUBOkybvCvsMdxVqB1xUUvD3Gk1MiuQLsd2FAUjnAmO82X0KA+AzHojlBWXKKHT7xc
 5LFeCwDA87hBb4CzAaN+N++vl2xl/5X6LqfobKwC3qRUU5PrL0gQ6pIDNoc+OtTh9MP8
 +FTpfGFxWOzLp+564rEPBLOXMe1BC6piCh1MGXS5JHVk95W/QFc1gJ6w0joZEDawFzK/
 fTbKoVxGlNWDn7K0mA9Cn3foES8iEda8HSXZF/WbPehTC8v44DtWfiY7sIPQ9zGuMRJ+
 ckYg+NhUZF57btnXOTJ0aZRsBwVbdPnDjq739mlZqhA3V30wvAVGhjIEstDI/CzOCcS1
 iB7Q==
X-Gm-Message-State: AOJu0Yy904ktK/e7NDsOjn+A45Pz+2M+0vRzOKRdlB7a2g5nuPIKqAZ+
 Rffrb1yuKMS+UCkd9rUPs3cjnX6VFUqFwO1YIWTH0To962H/bKUj3H0f24ApdMEBbKCsSIQ5SSr
 ld7AW
X-Gm-Gg: ASbGncsshs1efGca5gFKonuW7qv5S8zRDsMOZsx3U2G836iPavzKt+I5WaUS7ju+q1t
 R43dIr/7a5hYA1n0+NL0rWBIaQBxGIxcJjLicgyPcrxWzeVSgN2x3krLVy8pIjMB/m6rxRMVsGP
 A9EHw2AGILZUdl+WqK8CrNjpsa0sqjKhp5IXcXYslmSXwE180tfwobUB/AWD08423iVs2KE5fBa
 O9Gh2UA9cDYUL/LwexAyak4lIKoXRtEQSIjoRomTTCuEKPiKXq3ufgUxQDAxSgX2gdxbLF9cuaa
 Lr+qMuv97WBI2FDeSvS95WHzNJhuNfXL1ju5U0uK3R+5hbQZHElajhBMNUIskJlP+d96T5eauh6
 H/XmtqtujFSSBPHX6UkzubdWO/LXtayaJY6HOxKHhu46TLQGSYt7IjcFrm9W19PRkZreiHiGoVT
 nKaCmtorlZY3k7xk8juE1glhi4vZR77oeqn4I=
X-Google-Smtp-Source: AGHT+IGWLmrjPfXHiIgK0MtJTRoZjPV3+ZDWEh+UlXROQL9/2f3hWZOFuylTHjUO5iGhyTPeeZqNMg==
X-Received: by 2002:a17:902:ebcb:b0:298:5abe:4b1 with SMTP id
 d9443c01a7336-29b6c6ce8damr177072385ad.52.1764084156476; 
 Tue, 25 Nov 2025 07:22:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b111acfsm172573345ad.19.2025.11.25.07.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:22:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 00/10] test: fix format truncation warnings
Date: Tue, 25 Nov 2025 07:20:50 -0800
Message-ID: <20251125152232.73528-1-stephen@networkplumber.org>
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
format truncation.

v7 - refactor to have common code for formatting --file-prefix=XXX
     which addresses a couple more warnings produced on RHEL8.

Stephen Hemminger (10):
  test: increase size of memzone name
  test: add new function to get current file-prefix arg
  test: refactor file prefix arg handling
  test: avoid overflowing huge directory path
  test: fix format overflow warning in ACL test
  test: fix impossible format-truncation in cfgfiles
  test: fix format overflow in cryptodev test
  test: fix overflow warnings in several places by using common code
  test: use unit test runner for eal flags
  test: re-enable format-truncation warnings

 app/test/meson.build            |   1 -
 app/test/process.h              |  38 ++++-
 app/test/test_cfgfile.c         |   8 +-
 app/test/test_cryptodev.c       |  22 ++-
 app/test/test_eal_flags.c       | 264 ++++++++++++--------------------
 app/test/test_memzone.c         |   2 +-
 app/test/test_mp_secondary.c    |  14 +-
 app/test/test_pdump.c           |  13 +-
 app/test/test_table_acl.c       |   4 +-
 app/test/test_timer_secondary.c |  12 +-
 10 files changed, 161 insertions(+), 217 deletions(-)

-- 
2.51.0

