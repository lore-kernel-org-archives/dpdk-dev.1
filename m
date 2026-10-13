Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649DBCC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:30:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 844E44028B;
	Tue, 13 Oct 2026 14:30:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D4C504027B
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791894629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dC+y5ZPqL86SHOIFWJxeHZnQEBGf5Mgkj4PuvOn0iQo=;
 b=eDdPyO7a46eXxyB65SbgE0DaNto+/CdOyVOBfe9Ko7vADdobVZQQypUnA7FlZSPmGfHJ4n
 zMMNI327S8qSLLPEOYDXBidJoLbYvYhXxHfVJ2oE0oDLxp0N/p6R6ziMdQNUYYrdJXlOyj
 6OAh1MXFTm2LJWwROTRXlsIcVN9VL0Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-xjpM7_AtPF2PH0XY2e6UvQ-1; Tue, 13 Oct 2026 12:30:28 +0000
X-MC-Unique: xjpM7_AtPF2PH0XY2e6UvQ-1
X-Mimecast-MFC-AGG-ID: xjpM7_AtPF2PH0XY2e6UvQ_1791894626
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a9e7d65fe4so11307561fa.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 05:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791894626; x=1792499426;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dC+y5ZPqL86SHOIFWJxeHZnQEBGf5Mgkj4PuvOn0iQo=;
 b=a1RkHJESVO9rGp2s+GP/dx9+fiQpfpfS5CEqJoomyMMF9ftiRJFxkpmjsojBmVNLrm
 pUrvs0Yr153x6ie4lA33y3eUvgNCoCRcD3omkP9AOIrq2dZq9xdS9awIRGmGx/w39Ud5
 yPwC9m8ENsfe8owWnt0JXEcrMwFFBx8mGzpyI4eIEQT0toxz7hNXiG+yp3oWPWu4u5Oi
 5Omt2+9b1u6LcjkW1Xu2ghyMiQ++8yJbnVw0GwqFjUue4ljRoR0i4rUb68gHvv9CqnX9
 f7So5nqjJL/GCW+wq3gonopPKTPe1YVAZ2fsTVAeujudCZ7tDkfID0AF5abkoJNpje/4
 ihbg==
X-Gm-Message-State: AFq9FYKucEQfThwSxnWFaW1j77vVxKCGuCUV9bIuWu6KJDwzJsa/ygDi
 AOQ3qgPHs6WClA+pfin43yDgK44a/Ex/zh5IjghTY0XgrIby/j5PZiQTthTwp5ctZuFW9JiVE7+
 WvpdoA6HM+SwSDeBC8zOxKtqQDPAnS6nQj78WxjgHpVHWBGNiOiHgDLVyyHzLXZ9xQcfSTNYmvN
 WLzBm3fVBD3vBeQjuOvnE=
X-Gm-Gg: AYBFou0o5MIDZBcoO4r4BYbYYrvuFzxQA3Fb3QsQwSEOwRM9Rb/TRVVzSaMon0l6jOj
 FdIQZZp3rm9zctjR+MZe2PhUBj5O6eEegPuBWre77Feyt5SsAtwkyHOXtlDkExekl38BpnyfA1L
 qFdd24Y4I7ZroL+N3TGDpFwqqyYFTLKV4g0jIX2VZ5e6vP654ZydsAHXWNbq3ysJBx0GKTUKKUI
 LAT8zbufFa7HEXuTcuDB4dEkt8JJX/q7etamfdnJSVOhM1z
X-Received: by 2002:a2e:b019:0:b0:3a6:53b7:65f with SMTP id
 38308e7fff4ca-3a9c56e2e18mr20909751fa.24.1791894626317; 
 Tue, 13 Oct 2026 05:30:26 -0700 (PDT)
X-Received: by 2002:a2e:b019:0:b0:3a6:53b7:65f with SMTP id
 38308e7fff4ca-3a9c56e2e18mr20909661fa.24.1791894625865; Tue, 13 Oct 2026
 05:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261006082056.46426-1-dragos.tarcatu@keysight.com>
 <asZCmYlJ2KmItl7J@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <asZCmYlJ2KmItl7J@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 13 Oct 2026 14:30:12 +0200
X-Gm-Features: AclHuK_AHg2hmqUQFVIOJMjBzXNkCUGCHK9QkGS4AMwObaO1voNRX--Mr48oHeU
Message-ID: <CAJFAV8z9-JxbWTAWUOM1p_fc14bFQd5BA=A5p+NZuhg3sUV43w@mail.gmail.com>
Subject: Re: [PATCH] eal/x86: check OS support for AVX and AVX512 state
To: Dragos Tarcatu <dragos.tarcatu@keysight.com>
Cc: dev@dpdk.org, konstantin.v.ananyev@yandex.ru, stable@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gk81zDg9poBwsQsxF-SZRAVN-QmfudQ7tf36UxOBcOA_1791894626
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

On Wed, 7 Oct 2026 at 15:01, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Oct 06, 2026 at 08:20:56AM +0000, Dragos Tarcatu wrote:
> > rte_cpu_get_flag_enabled() reads only the CPUID feature bits.  CPUID
> > tells what the CPU implements, not what the OS enables.  If the OS does
> > not enable the related state components in XCR0, the first AVX or AVX512
> > instruction raises #UD.
> >
> > CPUID can report AVX512 while XCR0 has no AVX512 state. Old kernels
> > without AVX512 state support leave XCR0 at 0x7. A kernel booted with
> > clearcpuid=avx512f removes the AVX512 state from XCR0, but CPUID still
> > reports AVX512F. Similarly, gather_data_sampling=force removes the AVX
> > state.
> >
> > On such a system, the rte_net_crc constructor selects the AVX512 code
> > from CPUID alone. The dynamic loader runs this constructor before main(),
> > so the application gets SIGILL before EAL can parse any argument.
> >
> > For the AVX-class and AVX512-class flags, also read XCR0 with XGETBV.
> > Report the flag only when the OS has enabled the related state.  Use
> > XGETBV only when CPUID reports OSXSAVE, because the instruction faults
> > otherwise.
> >
> > This change also affects rte_cpu_is_supported(). If DPDK is built for
> > AVX512 and the OS does not enable AVX512 state, EAL can now stop with an
> > error that names the missing flag. This is possible only if no AVX512
> > instruction executes before rte_eal_init(), for example in a constructor.
> >
> > Fixes: 3934bb741354 ("eal/x86: identify AVX512 CPU flag") Cc:
> > stable@dpdk.org
> >
> > Signed-off-by: Dragos Tarcatu <dragos.tarcatu@keysight.com> ---
> Tested-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

