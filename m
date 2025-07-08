Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93136C8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF7C040697;
	Tue,  8 Jul 2025 14:53:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E8BF540677
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751979201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6QFP3c9I+L5beay+ztF72VECwxOavXvWl1BVi/opNc=;
 b=NdW3RlwW4zJ7t1amCWK/KZNurUBi7F0L51C7Wbg20VYEcvW+DVshnls+qpJOVpym7yXJOI
 aokRUj2tlJE1LgAXMsm4He3lWkw5z2AKjw+6PWkyD6EUvXjlxr8IX3YZanoUcMg7oz1M0/
 WgH3SywEH5K5/9Xj4nPqCYi24xwpToM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-Pxg2z_3YMs-WXtDNFVAF6g-1; Tue, 08 Jul 2025 08:53:17 -0400
X-MC-Unique: Pxg2z_3YMs-WXtDNFVAF6g-1
X-Mimecast-MFC-AGG-ID: Pxg2z_3YMs-WXtDNFVAF6g_1751979196
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553ea44a706so2728351e87.0
 for <dev@dpdk.org>; Tue, 08 Jul 2025 05:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751979196; x=1752583996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6QFP3c9I+L5beay+ztF72VECwxOavXvWl1BVi/opNc=;
 b=OpgMPvrG5pBuDhITcVzj7ToPaB4kVlwZSn810iX8EXbKSuuL/3WO36IagHvuBJ0rFX
 dpBeNNYSXrDlc9khimVZ1fntP5cQjITjdHOlxlCdV34+VJXtAJqVXwORQAyfCZw9hmO9
 qsfXKfgSEq2M6+DSG8g7YV7Vw4+oIrwnWLkgZTrWD0ExQyHPRXaPPuhzX0MQH5Fms+1L
 KIcs+PuvkbUqnOJeKYOx0PEmfw7TpHX5C+REDbokrQ/mHxSPzvxzG36R5jGwl/WThVwt
 FswlM0Hf9WbpECAhu1DthohkYkmjNL9U7pNg+ad/QO/KT/CGLKvGQst7mXvXdPPQt9DU
 GmBA==
X-Gm-Message-State: AOJu0YwoWT++qu3E5tBIJtC4KvcLez720bmBS+A8vJVW/M9EvQT+Bq/e
 AzGZgNU1ikQN1K/FS4gYLIryZE4aFwnw4zWFdltWFXeC3ntn976sRo+1X3C2xY777BIDV1wSH5t
 bY04vaqxxgzZut6KQjONjhdLpPPY2nGUN8v4hTXTVKKIp+cXuMRY92zZcjJcgXVwQgN/oD9hPQV
 7CgUkb5IdNqNNVSOvys+g=
X-Gm-Gg: ASbGnctKznv95JQrjPj2MObVDr8acvW7t0PkUfJ4c3+ufi6RxzeVrnu9HnA3D6it16l
 IkvxrufPkhUa/MGVD5yW2KAhCO38O6m9M6q95lTFH8dxzQNsBNmVegUpZyQGa6L3HniVNOSvHN8
 wzGH9p3Q==
X-Received: by 2002:a05:6512:e88:b0:54f:c10b:7290 with SMTP id
 2adb3069b0e04-556e894f6d9mr5200383e87.26.1751979195748; 
 Tue, 08 Jul 2025 05:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnAA0Qx7MHbaW8B4X3ATR0mVnEJBFXOJKprkRlxUgcnQZ1mBdXDwUYecETUVg0TaNH8TXUKlb7/n7SAaKNk5s=
X-Received: by 2002:a05:6512:e88:b0:54f:c10b:7290 with SMTP id
 2adb3069b0e04-556e894f6d9mr5200371e87.26.1751979195269; Tue, 08 Jul 2025
 05:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-17-david.marchand@redhat.com>
 <aG0TbXztzouaF0MO@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aG0TbXztzouaF0MO@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 8 Jul 2025 14:53:03 +0200
X-Gm-Features: Ac12FXzUyTVGVtG6LrBaD0H6BAKfvRZrdldfI7jMrbArTyZzubO2wuFAS961SK8
Message-ID: <CAJFAV8yTZQtDQHe-aMpQtSyeLgVW0xg7GD1N2=usjbhcS7rb5Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] test/power: fix tests without power drivers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JXSu4A7aesw7s4Iv2oeAIUJkF0F3Fgfa4v10YcLvIf8_1751979196
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jul 8, 2025 at 2:48=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Jul 08, 2025 at 02:28:20PM +0200, David Marchand wrote:
> > In the absence of drivers, skip tests instead of failing.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  app/test/meson.build | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/app/test/meson.build b/app/test/meson.build
> > index 7d38f51918..79d635b42b 100644
> > --- a/app/test/meson.build
> > +++ b/app/test/meson.build
> > @@ -145,10 +145,12 @@ source_file_deps =3D {
> >      'test_pmd_ring.c': ['net_ring', 'ethdev', 'bus_vdev'],
> >      'test_pmd_ring_perf.c': ['ethdev', 'net_ring', 'bus_vdev'],
> >      'test_pmu.c': ['pmu'],
> > -    'test_power.c': ['power'],
> > -    'test_power_cpufreq.c': ['power'],
> > -    'test_power_intel_uncore.c': ['power'],
> > -    'test_power_kvm_vm.c': ['power'],
> > +    'test_power.c': ['power', 'power_acpi', 'power_kvm_vm', 'power_int=
el_pstate',
> > +        'power_amd_pstate', 'power_cppc'],
>
> Is this better done at build time or at runtime? Unfortunately we don't
> have support for "or" operations on dependencies, so if even one driver i=
s
> missing the whole test file will not be built. I would think it better to
> look for the drivers at runtime and return TEST_SKIPPED if not present.
> WDYT?

I don't understand the intent behind this test, but test_power.c
requires this list of drivers to be present.

        /* Perform tests for valid environments.*/
        const enum power_management_env envs[] =3D {PM_ENV_ACPI_CPUFREQ,
                        PM_ENV_KVM_VM,
                        PM_ENV_PSTATE_CPUFREQ,
                        PM_ENV_AMD_PSTATE_CPUFREQ,
                        PM_ENV_CPPC_CPUFREQ};

        unsigned int i;
        for (i =3D 0; i < RTE_DIM(envs); ++i) {

                /* Test setting a valid environment */
                ret =3D rte_power_set_env(envs[i]);

From this, I chose to disable all other unit tests.


--=20
David Marchand

