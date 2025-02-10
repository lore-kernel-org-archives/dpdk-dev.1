Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75037C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 19:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ACE8402A1;
	Mon, 10 Feb 2025 20:04:05 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id D63ED4021E
 for <dev@dpdk.org>; Mon, 10 Feb 2025 20:04:03 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-21f74c4e586so39876665ad.0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739214243;
 x=1739819043; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJYj/q7qcuqXMjbaXKJePvE+0roxzGmAG7vyH5BWXrU=;
 b=XsTfzAXrFrUAv9vNSJrnMErNslZiXQ85B/Rk3cvZDTfHwnbGDSLrAoh/rCPn9mPmZ2
 KSubuRK7z9PcaxIsDyh0q9wHoam0EX0ylXLbKazKsvxWFdhxzUUew6dOmAZCU2HNbH/n
 V2EdylAjXDZXy/EfHgSKi0twlJ4Xpa9bXhKE0STjIUUvJtVP4zZEH5t5aIn7WqCIDDsD
 IcoM6ifusxzkHzyiTFd9ZwRTYn+idIPMCn540heKZ+bFH8pWul+HUbJZ+2yT8b0ALthe
 q9ljTFlpoyLbCGHR9eTmmSL6qwH3m4bNOLoo7naKyod96irA95lmymQU041CfjHtB/fi
 xHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739214243; x=1739819043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJYj/q7qcuqXMjbaXKJePvE+0roxzGmAG7vyH5BWXrU=;
 b=smqLPOUBEim19DI9uVN2ut/chlPJXaBT4CPDo2SqippzLaHpZsp1AS4sfUeO9qdjRL
 IiaVBqtV/kKuMt6GGDRX+U8gwDNfNH3D1L7gg2Jz8a3hywtfrddCdw5+xYWmiv1eDIpy
 IZ3L+fljjD/HD5KYFIgTFxaPma/ng/MzSlEiBzMUYt+5sY0Y/JM1tkXx6VKQV9gqn41j
 qaarTaSA7gyupHe3ShVDV5HV7sI3dzl+/DuEwDhW34RywNdJ2mPtN+Ala1TuqOnppfCV
 qwJLWq5utB4vmTDL+MhjiuyY8aNMsaSFU6iHShab+EVZBGDF39X3SSojlfCW2gRNKLiq
 WyNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN6miPBEvHB517dbuwpY4jkfEdKe6WVDWgq/EkZjNcjxKLXc3L9eBJIhKWpepG+BIyl98=@dpdk.org
X-Gm-Message-State: AOJu0YyFbOnY1ZYDKhsRz0z67Vgw1HIlmWn2yHYBdn93pWjryh5NLVsm
 /0AgVnDRVxiEOeK1Ktqb4vKdrn8N9g5Xd0b5Cl8tH0ZdBeNBex1pLI6saOAu36A=
X-Gm-Gg: ASbGnctbjhweH4CLagD5a7IIavwY3rF68qktku8+7K0Rbc+xjTs9QpApicFwuYi1dkx
 Dw5NP8aLoVACDXjsPcsaVfRBwPxLHBFH8oQEE6owEEj4cOCVs0Mhc2GY1pRGK7dPVyZ03xISY9B
 FvINeWkhripzHdrxghDKys7NumJ3n7YzX/tq7syeQBTtIRIhjdEo3BrOvDFWzBHTYs6s3osp0gq
 lFBL+QsJfSnGDGm7JcCAMmV2K9EbmX9WcvJSyqnOwjZJvpgUlPXNNZuoPbotxkC51yyXK8PYz4c
 Vz6tinqAYM88b0V/XM9SzQ7b7yniAlFnMY2fkhw99Eg2Dn64bl+LlDmNtX9H7/55ngVB
X-Google-Smtp-Source: AGHT+IGBGCAymwq76ht9W/D+9R3b76Jp0PkfeZ+HW6UAbtRwLjF2EW7NO7RqVMCKKE4GzgAszIJtMw==
X-Received: by 2002:a05:6a00:c85:b0:730:75b1:720a with SMTP id
 d2e1a72fcca58-73217f94a60mr991505b3a.23.1739214242749; 
 Mon, 10 Feb 2025 11:04:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73093ab315csm1877120b3a.143.2025.02.10.11.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 11:04:02 -0800 (PST)
Date: Mon, 10 Feb 2025 11:03:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v8 00/28] [v8]drivers/net Add Support mucse N10 Pmd Driver
Message-ID: <20250210110359.2b844491@hermes.local>
In-Reply-To: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Driver review checklist for mucse PMD

Mark items with:
    =E2=9C=94 passed
    =E2=9C=98 Failed

Basic hygiene
    =E2=9C=98 Look at CI results in patchwork; notify submitter if any fail=
ures
    =E2=9C=94 Merge cleanly with git am; look for missing newline at EOF etc
    =E2=9C=98 Run checkpatches; warnings are ok, but look more carefully.
    =E2=9C=98 Run check-git-log; often get some minor warnings that are ok
    =E2=9C=94 Run check-symbol-maps.sh
    =E2=9C=94 Run check-doc-vs-code
    =E2=9C=94 Run check-spdk-tag

Builds
    =E2=9C=98 Normal Gcc build; make sure driver is built!
    =E2=9C=98 Use latest experimental Gcc 15 to catch new warnings
    =E2=9C=98 Clang build using current version (clang-19)
    =E2=9C=98 Doc build

Rest of checklist skipped, not worth running with these kind of failures
