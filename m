Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9ECFF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:56:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7152040673;
	Wed, 29 Apr 2026 16:56:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2EF7A40666
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777474608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhhlkNHaD61yGy+sBpIsGQjPN8iiIAkaLSlpsRsFeWk=;
 b=AIA/U2yya6p0B5hNZYEHMhGwj7+NAsjNJQjR2OK5lm7T5UMqksvUJacKyaZPhJHcplVJP7
 Vueqq8sxzox9pdwdHnMm+lx7/zr/dXIOc8m/troIeO0SbY8H9Dmqq7qWu/E3RbLtqQ3iix
 U4BumIaLQUsCLJpomPn9HZBWFlErWtU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-UIbVmRmNNLKzN3dk8CyITQ-1; Wed, 29 Apr 2026 10:56:47 -0400
X-MC-Unique: UIbVmRmNNLKzN3dk8CyITQ-1
X-Mimecast-MFC-AGG-ID: UIbVmRmNNLKzN3dk8CyITQ_1777474606
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a41434a287so429800e87.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474605; x=1778079405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhhlkNHaD61yGy+sBpIsGQjPN8iiIAkaLSlpsRsFeWk=;
 b=OkJnRXjMx/ATxTFFAxyc0XBkIkO1UUGtE6W9d+04p9egPbDmXbMScHOnUFs5o4IiQR
 WrW1Ve5/+KPDRAieeaKZ6rTP6uIcqfGNvKtFY2o4MlSNuInPLc4GWrPs0cHTjqGwyDnu
 CFyZ0sVfxB43NKapr8J+g5ogjJI88Mp7GcUCSA5bUHanFEm8PVcI3zlukOTkg0+4l3rG
 pay+5No46cEUlrxlnKJJwcn1lRy5gduWH724NwqXo+HSUqjvNJliZYSS51Cu5/cyRT/5
 mIL4woJIl2caJdZnYBksJsRvvgAKrINrvWoGNr0aCKoEKyrFZAMRD+1Fbf23d+xoFmLv
 7qyw==
X-Gm-Message-State: AOJu0YwXx3fPHwvDzV50WXSignK1ifej0n/V4EfPL+O53R+XQQ0hm7Qd
 QLE2+CgQlnxrQVq3pm//M9aRQWl6zR1Qq4XiCLYuviwn4YeyIOdmQ6O+kFqSHgf8KzR34Igq4QQ
 XaH8f2luItnPvGMIai8NcN25+Rh/braUy7kT231gmMKB5VdwkpIzT5DXpPie9W1xDl0pBbWtgtZ
 fgooM0nP/ZHNsfIcup/cU=
X-Gm-Gg: AeBDiesm8KgPahpOBbnzEC7zhUk++HEuJlZlC4RAvP3RCk53SETXBYvPFaXb6bcA94l
 2vkjEIi/3I5glUKhHFrLwD+fUIc6bmkT1aRIf83MlGg5EN2NM6O5Bq8Iutvo5q5S5oJHh7eyHju
 YD3NhnfXOe8ykItoPsm3EE97yRY5wu3V/TAu9wVRuqzIm2dLFgNHZPrS5xDnrVse57dW/2gP2ho
 cPSGwW7tWpeyHvDbcRIUyvHohVjVa0pW2XmEWV8YJDwtJ6u03ytXpRHuHVyRp2mVX6ht2BHyvHk
 O82Q
X-Received: by 2002:a05:6512:3d18:b0:5a4:1b6:dd31 with SMTP id
 2adb3069b0e04-5a749fde826mr1219421e87.13.1777474605506; 
 Wed, 29 Apr 2026 07:56:45 -0700 (PDT)
X-Received: by 2002:a05:6512:3d18:b0:5a4:1b6:dd31 with SMTP id
 2adb3069b0e04-5a749fde826mr1219409e87.13.1777474604979; Wed, 29 Apr 2026
 07:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260421195227.1425625-1-bruce.richardson@intel.com>
In-Reply-To: <20260421195227.1425625-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 29 Apr 2026 16:56:32 +0200
X-Gm-Features: AVHnY4KJ401WS24HkEZap05d-0CrQSKy6aP692vVoALXEcgqEIqMx119lWszR6I
Message-ID: <CAJFAV8ygMBuw79R9uo2wq9MOWp1S1K0XHA+rO4pk+gwq291KMA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Get fast-test suite to run on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
 Adam Hassick <ahassick@iol.unh.edu>, "Mcnamara, John" <john.mcnamara@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yfrOiQW389X1bw5oSP65fGkA3gcm-PishJD63TI9U2M_1777474606
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 21 Apr 2026 at 21:52, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The standard "fast-tests" suite is used to sanity-check large parts
> of the DPDK codebase, but it failed to run successfully on FreeBSD,
> with large numbers of failures. This is a long-standing issue reported
> in Bugzilla back in 2021 as issue 761.
>
> This set attempts to rectify this situation by allowing the suite
> to run without errors. Mostly it does this by disabling test suites
> that rely on features like multi-process which are unsupported on
> FreeBSD. It also fixes the test_debug suite which should run on
> BSD but was failing.
>
> V4: resubmit of v3 rebased on latest main
>
> V3:
> * fix typo in patch 1
> * expand explanation in commit log of patch 2
>
> v2:
> * squash patches for fixes into patch 1
> * separate patch for some cleanup of process spawning into patch 2 which
>   does not need backport
>
> Bruce Richardson (2):
>   test: fix failing tests on FreeBSD
>   test: simplify spawning extra test processes
>
>  app/test/process.h              | 20 ++------------------
>  app/test/test_debug.c           |  6 +++---
>  app/test/test_eal_flags.c       | 26 +++++++++++++-------------
>  app/test/test_external_mem.c    |  4 ++--
>  app/test/test_interrupts.c      |  2 +-
>  app/test/test_mp_secondary.c    |  4 ++--
>  app/test/test_pdump.c           |  4 ++++
>  app/test/test_timer_secondary.c |  4 ++--
>  8 files changed, 29 insertions(+), 41 deletions(-)

Series applied, thanks.


-- 
David Marchand

