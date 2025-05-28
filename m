Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C50EC3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 14:32:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58A83406BC;
	Wed, 28 May 2025 16:32:12 +0200 (CEST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id BF2E640156
 for <dev@dpdk.org>; Wed, 28 May 2025 16:32:10 +0200 (CEST)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so165050466b.1
 for <dev@dpdk.org>; Wed, 28 May 2025 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748442730;
 x=1749047530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTIDMQYdrz7t7cj1O2J9P1aqWeUu94dmc9gYIDX3RfA=;
 b=erqaK2D3Vf1NJxYBBCZlTAV8PRgN7ZnL5Gf+nipGd8oQ3SKAups+K6831dN2h0Q8Pb
 1eHBY50gmPasG03NtOn+qjlg6Ro77E07EL+WyREGR4KRwTKFvCnP/5sCBPqXsb55H0bd
 JsVP+vlDUFcYBTh7hJbMocRFXOIhyHv/zUzxbcflZsNet9gQPW8GkPSZe7OL4r1BVp2o
 OqVm7PU20mSVjtvhXuCLcUD7KD16VscPJB2Vt/8uI4dneROrSKAn7eKUL77I9ppEepw8
 XxsOO7iWhOC6yGLJKS7ZNPd93qEb4XW5MqDDtGzVSeuGuku/NtPiEqOpvBtacYRbbXa7
 yBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442730; x=1749047530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTIDMQYdrz7t7cj1O2J9P1aqWeUu94dmc9gYIDX3RfA=;
 b=C1sBUut0kK53Odv+Xy4+5PSR5tepxaFSiJOMyHAvG4V1TxIfMDeUuNeLnHIN13KDM+
 uO6YmPLIsKcya6pjvPtcB8rCzmaWVLx93OmXLzE5qMJVoms1Depq8QsU3xO3RR89Sgip
 BVbajfjuCS/YY0/2ctEb+kZAOdYYEwCA7ZbHUnSzWZYCCWjsV8Jd9ZObvFGAk9rLyI7E
 ldVV1QISg8V7E2UpE0xqFP//olXeMgfeR//FlhXOeKehRf2q1M4eKbYSxRE/f3EvOOz1
 pxY8nDBIFjMerdZt4Ejsn7xR6482xgOWpO6hiA/4rtaV/rcJKUvY9Oj5uLCVALZzaZfZ
 Gd9g==
X-Gm-Message-State: AOJu0Yz3lESjS6nap8x6RDLP2yZ4mGxfFoHrLoxrd4yvYTQeO92H+Sla
 UpKEwiWSU9w4ULov+6042g3XR28ThuSe9MYuKWsJp5w1avvJvjKmqRfiPbUP9jOO+v0=
X-Gm-Gg: ASbGnct/Qhr7BXpS/j/PfVptHHCuQsNH7TjjPEKRvbCLu3sFuOx3T2yVEdHG0ZVduK8
 1gSs5ZihnTtDitn+gwGnvHbNqTRnylJWEeM2qrE9Ik8d0NON2zyju8sMeahSVGchGO3bA7lqRtf
 2qXBIPKrTolhysXH4p1xL0eFHjfD6k3HBdTgEF58+pLCDL5iwFSg+hU3Frz0Eh4CMxJ7JkrykoV
 fawV6KVGjeYGGzH1L+7S1a5CJNK1iyjtpAm/h4jzc4zHhL2V0HHO3f2bEI9ygq/RyWU83bOw+Yc
 tKUPF4fE+4i0WpZJnIwG92s+GOk1sgYRtXluC1zHtNkQTyBOpwAyfb7iaTTtuwBRANTAd2rs7ez
 tCWmC2cw60Fvg4j5WO6O5VbIJT+K2JO3fMmJgoO8=
X-Google-Smtp-Source: AGHT+IEGE20ezCzKb9dCzEJ+f8m0O+P3+TUOQZ566X8lDwxHcKZvEY8eT+D4W8ThJ/4oVK2uWzyBWw==
X-Received: by 2002:a17:907:7e9b:b0:ad8:8f3b:de2d with SMTP id
 a640c23a62f3a-ad898891879mr436430566b.9.1748442729301; 
 Wed, 28 May 2025 07:32:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a19c8a45sm115804566b.39.2025.05.28.07.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:32:09 -0700 (PDT)
Date: Wed, 28 May 2025 07:25:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org
Subject: Re: [v1 00/10] DPAA specific fixes
Message-ID: <20250528072538.23cbbb58@hermes.local>
In-Reply-To: <20250528115513.1023689-1-vanshika.shukla@nxp.com>
References: <20250528115513.1023689-1-vanshika.shukla@nxp.com>
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

On Wed, 28 May 2025 17:25:03 +0530
vanshika.shukla@nxp.com wrote:

> From: Vanshika Shukla <vanshika.shukla@nxp.com>
> 
> This series includes fixes for NXP DPAA drivers.
> 
> Gagandeep Singh (1):
>   bus/dpaa: improve DPAA cleanup
> 
> Hemant Agrawal (2):
>   bus/dpaa: avoid using same structure and variable name
>   bus/dpaa: optimize qman enqueue check
> 
> Jun Yang (5):
>   bus/dpaa: add FMan node
>   bus/dpaa: enhance DPAA SoC version
>   bus/dpaa: optimize bman acquire/release
>   mempool/dpaa: fast acquire and release
>   mempool/dpaa: adjust pool element for LS1043A errata
> 
> Vanshika Shukla (1):
>   net/dpaa: add devargs for enabling err packets on main queue
> 
> Vinod Pullabhatla (1):
>   net/dpaa: add Tx rate limiting DPAA PMD API
> 
>  .mailmap                                  |   1 +
>  doc/guides/nics/dpaa.rst                  |   3 +
>  drivers/bus/dpaa/base/fman/fman.c         | 278 ++++++++++++---------
>  drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
>  drivers/bus/dpaa/base/qbman/bman.c        | 149 +++++++++--
>  drivers/bus/dpaa/base/qbman/qman.c        |  50 ++--
>  drivers/bus/dpaa/base/qbman/qman_driver.c |   2 -
>  drivers/bus/dpaa/bus_dpaa_driver.h        |   9 +-
>  drivers/bus/dpaa/dpaa_bus.c               | 179 +++++++++----
>  drivers/bus/dpaa/include/fman.h           |  40 +--
>  drivers/bus/dpaa/include/fsl_bman.h       |  20 +-
>  drivers/bus/dpaa/include/fsl_qman.h       |   2 +-
>  drivers/bus/dpaa/include/netcfg.h         |  14 --
>  drivers/mempool/dpaa/dpaa_mempool.c       | 230 +++++++++++++----
>  drivers/mempool/dpaa/dpaa_mempool.h       |  13 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 291 +++++++++++++++-------
>  drivers/net/dpaa/dpaa_flow.c              |  87 ++++++-
>  drivers/net/dpaa/dpaa_ptp.c               |  12 +-
>  drivers/net/dpaa/dpaa_rxtx.c              |   4 +-
>  drivers/net/dpaa/fmlib/fm_lib.c           |  30 +++
>  drivers/net/dpaa/fmlib/fm_port_ext.h      |   2 +-
>  drivers/net/dpaa/rte_pmd_dpaa.h           |  21 +-
>  22 files changed, 1022 insertions(+), 423 deletions(-)
> 

Don't resend same patch series, twice in 24 hours.
If the series is revised please mark it as v2.

There are multiple compile failures, please fix and resubmit.
