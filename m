Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F52CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 18:16:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDADD42E3A;
	Fri, 17 Oct 2025 20:15:57 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 28589400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 20:15:56 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7800ff158d5so2150514b3a.1
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760724955;
 x=1761329755; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUHmR2h9MA2f7UC2UnkIBrUDqAEZ+vAUKSQcKxXs1Kk=;
 b=LCgz22AbbTAnB7DNPQLSAJlIx+60bxoPPsjCOF3CKJjJ7VvGx62MOTCy62yaRgOALC
 0//Cqk9VinQHhepT+AOsCAobqSv5GDpL8w6mf8T3KQ/ua9zp8KlvyyOupkSHabTxtpqX
 yFN8C0iYA4Hx8q4EnXmQ1NMv6A6MPAVUPQFO5KL+2YHMgPUIPiIK+ZRfYe3LtNmbjiKg
 18UIlJLOevUi2Vmz5RpIg2tUi4lAOBkRjkRoluQV68HeFzNkjqrg57wmf7aKVdqYVGOk
 mYz1OsiGdtn0mh7C6oiv9I+D3+A4ui5uYwxyexwJU7nceHYClTOiigOPSCB4cnUZNUaT
 rTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760724955; x=1761329755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUHmR2h9MA2f7UC2UnkIBrUDqAEZ+vAUKSQcKxXs1Kk=;
 b=IUoJR9WO1RUtYhi5pFYM2+UCB+5HgUsFG0UB1525Cilqg6NXVYCVWvsKyz2L9eMuif
 wNcs4v1BZAQjTjV034Njghu80RJmCHydwl6KaW7jsfSh6qpWoR5PJ96kii1lpvsoBnV6
 b0fFxMxwVuUZmZCRNScFCT2MW+NYn8zLqYhvfSHqSBYfAMrrsvSUNBJv91nkwP9CkqLY
 JCz+nJVX04KZWBCF8Pt+AuUPW+LCta6kPNCfMd8qPa6pMMT357Cclx9WhEGXokDxor6x
 QGASPBaSf87xl5iWZpt1fX0PynUsGzW3+fIMGQP4Fz09qur5OU0It5zZ50ngx9ONYwsa
 7f9Q==
X-Gm-Message-State: AOJu0YzbotyS1jCgd6ha2VDz7LScbU8Ll7FhZvOqZZpkiXO0FMF06CeA
 M5L1+eE4iUJ9YEZRi3DDwudveQgVovN7bDnJc9zju5+CEMxaC+98nQRc7Ee/nOo0X8I=
X-Gm-Gg: ASbGncuSH8Ew+AIFLBtgkuh+hUefGX+Hno009CHEKWyGY34K1h2VadXX1thME5YA27o
 9uQNh4TFn/8AvY4OJSOZD9pnVDos2MoSfw9Qx5iYcoOWeZa+UgLV6Yb/BV6xxFAx3Jt2HqlYZg3
 r61nR8LZThr+lwgQqAldjiY0IFvDhDZGzeyHmIbdX4BSRyb5bZKtu3jdNZIbwTt5smK+Xdv8x5N
 Jn3VbIUHSRVpE8ebDQy5kYG5i7V7ST39EUgSKyk0qN3gaOSHwfZ6/+AccxNSc7VCKfV5h9GP6PS
 SqwK8RJSkQkeP9y6EKLZmSVvg6nCsApjEe0VkwJC5wAyjjdroDhgGJAz3Xo315l0h959UKz2K9D
 ckf78wMPR5crkjiFpYN32LtktMVPmcA20JrDdyEzlQS4Cn8wI9yTzTbKenB/u2uo2IaF+2I+qcd
 vZArKm/rk5i2Tzal66dGTshzdxS9lzmYXNXB7cwVU=
X-Google-Smtp-Source: AGHT+IH7c9kzpTGP1paOQfFfr+d+FX7qmeNlvyEsEBTcB88gtRRu+o2IJhgIVIg/PdbNNuOdI1R8+g==
X-Received: by 2002:a17:903:350d:b0:28b:4ca5:d522 with SMTP id
 d9443c01a7336-290cb94765fmr60489755ad.39.1760724955239; 
 Fri, 17 Oct 2025 11:15:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebcdefsm1825405ad.16.2025.10.17.11.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 11:15:54 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:49:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v5 0/6] DPAA specific changes
Message-ID: <20251017184932.28122e88@phoenix.lan>
In-Reply-To: <20251017044848.3269627-1-g.singh@nxp.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
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

On Fri, 17 Oct 2025 10:18:42 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This series support timesync APIs, improves
> queue reset logic and include minor fixes.
> 
> v2 change log:
>  - fix 32 bit compilation
> 
> v3 change log:
>  - update commit message of coverity fix patch
> 
> v4 change log:
>  - separated queue shutdown and logging patch into two.
> 
> v5 change log:
>  - update commit message for FQ shutdown patch
> 
> Gagandeep Singh (2):
>   bus/dpaa: fix and add FQ shutdown
>   bus/dpaa: imrpove DPAA bus qman logging

Spelling of improve is incorrect in commit log

> 
> Jun Yang (3):
>   net/dpaa: Support IEEE1588 by timesync API
>   bus/dpaa: Disable qman Invalid Enqueue State interrupt
>   bus/dpaa: Set max push RXQ number

Do not capitialize the Support, Disable or Set

> 
> Vanshika Shukla (1):
>   net/dpaa: fix resource leak coverity issue
> 
>  doc/guides/nics/dpaa.rst                  |   3 -
>  drivers/bus/dpaa/base/qbman/qman.c        | 459 +++++++++++++---------
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  27 +-
>  drivers/bus/dpaa/bus_dpaa_driver.h        |   6 +
>  drivers/bus/dpaa/dpaa_bus.c               |  51 +++
>  drivers/bus/dpaa/include/fsl_qman.h       |   6 +-
>  drivers/common/dpaax/dpaax_ptp.h          |  95 +++++
>  drivers/net/dpaa/dpaa_ethdev.c            |  69 +---
>  drivers/net/dpaa/dpaa_ethdev.h            |  13 +-
>  drivers/net/dpaa/dpaa_flow.c              |   6 +-
>  drivers/net/dpaa/dpaa_ptp.c               |  50 ++-
>  drivers/net/dpaa/dpaa_rxtx.c              |  93 ++---
>  drivers/net/dpaa/dpaa_rxtx.h              |   2 +-
>  13 files changed, 580 insertions(+), 300 deletions(-)
>  create mode 100644 drivers/common/dpaax/dpaax_ptp.h
> 

