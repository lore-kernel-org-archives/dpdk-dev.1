Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C92E8306E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 09:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46041402BE;
	Tue,  3 Feb 2026 10:51:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0EDDF402A2
 for <dev@dpdk.org>; Tue,  3 Feb 2026 10:51:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770112316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WphknWF8rC9jgk5tROEM6Kz8jCBrFItuGmF94cDrGw=;
 b=b+pj+RNkGcLx78rCcDqeEveyNZTNFIWIrUgEEYY3qS6oCXiWEG7CZzcO2hlH4C5aMmK4Y+
 KouKp0nhR4Xm09KJwUNQepRXzz2EVQ8REDVAtTmjK6/E9g1IPWtiP3shRpFcY9bnp/vRfW
 zIBDWLst3plYY97ch7tTY7duKRhUbbY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-eZqJYT-QOSiwGxOHIQCTWw-1; Tue, 03 Feb 2026 04:51:55 -0500
X-MC-Unique: eZqJYT-QOSiwGxOHIQCTWw-1
X-Mimecast-MFC-AGG-ID: eZqJYT-QOSiwGxOHIQCTWw_1770112314
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b730b2b0aso356431e87.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 01:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770112314; x=1770717114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WphknWF8rC9jgk5tROEM6Kz8jCBrFItuGmF94cDrGw=;
 b=e5LoENDPaonawKe09bRqVgmeZDAF4hEDpTJ7w2dv0KIFI0qXmZxSxVTNlEEPt6Oi+9
 gplJiknAioiVkTHiw++rrL+MupUm55xXus780gl25nsyEs7UYzvkeyM2rdYx+XoEaKUz
 y9lUEzJ6OB/LTY4tPQhFWkuNSEBIBOFeRro0vZaElBApirZC4WRx6q/iWAUmnOW6OysF
 JSGlmM1CaPeuIVpxDU/68CvV61+ltv/z/07MKxPy+k+kY7bJKu/bmunc2r2k/lC/XDkD
 3dVTOAnFPYCgM1tJOrsqjP4StU4FshOPB4mZeNADagVobYyWBdjqn7Q0sDgakBywmoH3
 XPJg==
X-Gm-Message-State: AOJu0Ywugl5DimHQkqbfShYnKVTznlOFB5Kwjm95FaSUJyhxrIqsR8Ye
 no+yuqPso2pnZe5+IHVfpf9IVslnNyiFiCHI1j3JrsuG/eFfFDhLBgH9IAYM1qQHRvgApHuJUtl
 hd2a9XI5n3wWAa8aisnuDVQl3Zc2ZRaDX0ezgPSbIPyAGp350ktuH2ppVGglZUQQCUn4kv1CPOR
 guQ4KrbovD1NJ9Ze1oBIE=
X-Gm-Gg: AZuq6aLGvnbdVO9rKEvDZo2YXbvBOcNkb1oP7/BeUgpfLB7MKUf5gRetbySAbU/RjbF
 D1Ak+puIdWaCsUnj5oqdjXFAUhvOhk+PDlycwDjXbGFhz7kWQGtAW5g/Waro9YJQ8FjMlC7Hurg
 ewht7ZIMiJkNyvnrrZKLTI2mZGEbF//AjGFRxZBzbLjmBheYShetDpupi/XYm2V9UkIwQEoUo91
 5+7BbOccT+O7Nhr4u5K8k4nsWq0me28KIfCnspOVU+4xKyvMf/5uRNLSw==
X-Received: by 2002:a05:6512:3dab:b0:59d:dffb:cd70 with SMTP id
 2adb3069b0e04-59e31707fc0mr855764e87.21.1770112313808; 
 Tue, 03 Feb 2026 01:51:53 -0800 (PST)
X-Received: by 2002:a05:6512:3dab:b0:59d:dffb:cd70 with SMTP id
 2adb3069b0e04-59e31707fc0mr855749e87.21.1770112313391; Tue, 03 Feb 2026
 01:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20260127052900.68045-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-1-scott.k.mitch1@gmail.com>
 <20260202052442.92192-3-scott.k.mitch1@gmail.com>
In-Reply-To: <20260202052442.92192-3-scott.k.mitch1@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Feb 2026 10:51:39 +0100
X-Gm-Features: AZwV_QgSPiJSJQbamE4A7JnDCD77q7suEewt3V0Luz2Zk2nXpgvf08k9BGFKIPE
Message-ID: <CAJFAV8wayi8bsYXsUUb=HmMAcppxF1Brb=owY+4S3WQiGyGuFA@mail.gmail.com>
Subject: Re: [PATCH v17 2/2] eal: RTE_PTR_ADD/SUB API improvements
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org, 
 bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: As4yrnJpKevWO97bQqmt3ecj-zgTlp4_Mm5Jse3LDRk_1770112314
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

On Mon, 2 Feb 2026 at 06:25, <scott.k.mitch1@gmail.com> wrote:
>
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>
> RTE_PTR_ADD and RTE_PTR_SUB APIs have a few limitations:
> 1. ptr cast to uintptr_t drops pointer provenance and
> prevents compiler optimizations
> 2. return cast discards qualifiers (const, volatile)
> which may hide correctness/concurrency issues.
> 3. Accepts both "pointers" and "integers as pointers" which
> overloads the use case and constrains the implementation
> to address other challenges.
>
> This patch splits the API on two dimensions:
> 1. pointer types
> 2. integer types that represent pointers
>
> This split allows addressing each of the challenges above
> and provides distinct APIs for the distinct use cases.
> Examples:
> 1. Clang is able to optimize and improve __rte_raw_cksum
> (which uses RTE_PTR_ADD) by ~40% (100 bytes) to ~8x (1.5k bytes)
> TSC cycles/byte.
> 2. Refactoring discovered cases that dropped qualifiers (volatile)
> that the new API exposes.
>
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---
>  app/test-pmd/cmdline_flow.c                 |   4 +-
>  app/test/meson.build                        |   1 +
>  app/test/test_common.c                      |  20 +-
>  app/test/test_ptr_add_sub.c                 | 199 +++++++++++++++++

Do we *need* a new file for testing new macros?
So far, everything went to test_common.c.



-- 
David Marchand

