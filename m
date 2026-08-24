Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BBEC5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 08:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCD4A4027C;
	Mon, 24 Aug 2026 10:07:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 609E540270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 10:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787558834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z/AsZ5gSJPTuHexNDa+V7wwp+fUymu4dEO9QNjYj0dc=;
 b=REhka0NUKlW0aesQGP+DwDRSdlgUzspofqY0adZTeaiKAXPC2KwjB/WDVXL4IRKDxw8dCk
 yEsRGQo5fiXGR73qDWHXlXIlDcowou9cggdQ2YZSPYS44WFDuUuYJU+p6ng6mRhuk1JCCg
 i80zSpCGZN+ESgZa2KnIbY7ZdDWTMS4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-edrZmvgeMHqsAmo1QOW2_g-1; Mon, 24 Aug 2026 04:07:13 -0400
X-MC-Unique: edrZmvgeMHqsAmo1QOW2_g-1
X-Mimecast-MFC-AGG-ID: edrZmvgeMHqsAmo1QOW2_g_1787558832
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b291a1420fso763024e87.2
 for <dev@dpdk.org>; Mon, 24 Aug 2026 01:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787558832; x=1788163632;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z/AsZ5gSJPTuHexNDa+V7wwp+fUymu4dEO9QNjYj0dc=;
 b=HrXb9bGD7agOlojJhkcdY/V/tlVZY4zny1zecKYmMf6mkky9IX6sQXqSuYEAZzxuZr
 OGtmU7uzyd9AjQgaWI+2oSYacYpeUSso7IDJLMqmXmovDCUxhTuzA5Y4wfA0EOnkAw7S
 IOmzaJSTT3au0D55eHBgQvSJkiwjzXKmbICJdOrZi5MJLMlGVTknlp4rdH9LSIBrk+D/
 hj+Agp/VfQ1UzIwxqn9vrD1eUFQbMUxzOpCpq8SB5wM8S2QTvJbasFwILmh54PcKI2pX
 z/8b8cTaKXP5LF/fd1ZwKX5VIsu0RVFjuTKf939mhfQaYbBnTYmdMFPCjMn5ARiwz3JW
 EDqg==
X-Gm-Message-State: AFuF++nepHhfvUyXHD3pZjkyN2rf7/b7y3uk/SQ2SqjS151JT0RbUkwi
 jR09Z18CyqPWZQavQc1r1Orl7Dj4IIh775iZOYCCZN2Ba9gt0te32BUrcmkZ1S5sYm0Aq1r2S52
 3HLydeKU99wycfjcKPVyt4ueBI6pQFrC8RFgOkLznFYoBt0SiohFO0Gv2/gWgQnN36xK8H0Ptlu
 2YA4TJaNa6/IAj0sS4XBg=
X-Gm-Gg: AR+sD13PPNzocKU3JwYCyYHVuUStRSgWwp7U0PNZX9YGMD7Gr9AuL+KFhxpAJVEatQf
 iEhA6v7ynyC/CQX6j7qXZLto10AMzVMOR02BSOjYP4AHEcZikEQDTKk9iW5lDczOz2+Xlz1lwT6
 SpZQjxoUfUPRoCIdg9KhAZTlcEjgtMml1GWdgJoUeaqmWL6GGcIr2QQktrmR/r68VBaRQ2UfqI8
 raWaJhRAFTI2DSR48P0ZEbiRSud2nMDSqozjiUGCpKplaXC
X-Received: by 2002:a05:6512:1382:b0:5b2:f426:9c63 with SMTP id
 2adb3069b0e04-5b484242898mr8587655e87.22.1787558831796; 
 Mon, 24 Aug 2026 01:07:11 -0700 (PDT)
X-Received: by 2002:a05:6512:1382:b0:5b2:f426:9c63 with SMTP id
 2adb3069b0e04-5b484242898mr8587532e87.22.1787558826760; Mon, 24 Aug 2026
 01:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260820080542.3414447-1-bruce.richardson@intel.com>
In-Reply-To: <20260820080542.3414447-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Aug 2026 10:06:54 +0200
X-Gm-Features: AcwNN1UTAkH2ddCrwj7y8NIYUcshh1b0ATNA3XZK2Sgh6YpJzxgb5WbE257AYP8
Message-ID: <CAJFAV8yg9wgPuMsoZPwQfB=bHo1WD8URb_wtJ=w70Y-j3jeKFg@mail.gmail.com>
Subject: Re: [PATCH] net/cpfl: remove unused macro definition
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xtdKChWSgTYR5BRwb-zyxQCUqJU3yeZeAohqDtVk4Vs_1787558832
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

On Thu, 20 Aug 2026 at 10:06, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The CC_AVX512_SUPPORT macro was never used in the cpfl source code
> files, so there is need to define it in the meson.build file.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

