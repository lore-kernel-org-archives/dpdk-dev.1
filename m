Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9923AC28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 12:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B65940273;
	Wed,  2 Apr 2025 14:16:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7D33940261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 14:16:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743596179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jpSfNgmDV5fFvaMXMYm7KLloIeX70c88uYihdTzbmJ4=;
 b=f5jqletWOmb5Rho3b/1H2WacEyGh4Tl8i1xJe4sSfuExsP3/oxfvzcYJZimeO1RDSHg9+K
 tHqrBjoSrd7BcWlRomcEuawVhWa7jvEnPh2hmn4OymrJ7lXRl5spFWu+1kfSvHcJFz6hdy
 4yHx8VzVJnEMPdwARewaN15bj4SMP70=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-FDtlV2dENd2lbMo3_uApYA-1; Wed, 02 Apr 2025 08:16:18 -0400
X-MC-Unique: FDtlV2dENd2lbMo3_uApYA-1
X-Mimecast-MFC-AGG-ID: FDtlV2dENd2lbMo3_uApYA_1743596176
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-30bfd03cdf6so35652571fa.1
 for <dev@dpdk.org>; Wed, 02 Apr 2025 05:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743596176; x=1744200976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jpSfNgmDV5fFvaMXMYm7KLloIeX70c88uYihdTzbmJ4=;
 b=Neo47VLyD6zaW3NUXngi5JsnlPHCjFAZD/Vsd92jTbQGITSyhfdsFOkccJSLE4JWNu
 JwTqwdqfWYRw2DBkWbbMb0T5ULtbbxSMJ8/8MK1hYlNUEQRhP5PiQRajDqxW/+g6WgLF
 REzUmb7owFBZtavyF/sdiHt+1FdtJt2RVWLB3KoHbhkU8XF4kYahRH041q14TmanEDEN
 e3J+3iyRGDjIQCTZ8FbZT4nG9uN/9SCgu1y+o7zC3Gryv2LIvBCDcCqkwmQnVq86MrWk
 GO0KQKCuAAjFXMWuHzJNy9h2Qzp7pRSvbWuyjhQZQWNKEQ03Ov3NtGfCjAugajYRxhZp
 Brmw==
X-Gm-Message-State: AOJu0Yy3M6zQIN86xb93jUollduZTKfmFo7/LV3K3zD6218u2QLBk418
 UWe8GsBpWECzgeumUzBLSVuWBsr/39zGVSfMh6gvQz+waHPHludgZ+GM1bpky5ucklTE1wQpBi/
 8QlUmOcDfe+OdJKSGutwmy3op1W/iR3v2oLd0L4DPtXyS6fuDXKO0B79+uWnZ3H8BJKzwS7+Gxv
 t1Qs5y8YblHor1ffU=
X-Gm-Gg: ASbGncvVcIodAGnszn8la8BpzPPSXtmkvXmQEv67Q7TK/T2p7llYo+gwHXGt2p02iM8
 K3h8s1vJabSjeR9XcK6zMuXBTPZUlD8WxhUvx5jWnyKViQAmb0aWu3BcijqNbvWE17an9dNDxqH
 g=
X-Received: by 2002:a2e:bc14:0:b0:30d:694d:173b with SMTP id
 38308e7fff4ca-30ef91e8d23mr8661151fa.33.1743596176273; 
 Wed, 02 Apr 2025 05:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIeAzCOY9QNnslApeT3yTzGy0W+qDcneo+vXhmX5hTdgNziBXCQAeQ7HtNYjXpQTa7gHsvzJYpeKnBF7VYqBI=
X-Received: by 2002:a2e:bc14:0:b0:30d:694d:173b with SMTP id
 38308e7fff4ca-30ef91e8d23mr8660951fa.33.1743596175869; Wed, 02 Apr 2025
 05:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-9-david.marchand@redhat.com>
 <5048875.4XsnlVU6TS@thomas>
In-Reply-To: <5048875.4XsnlVU6TS@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Apr 2025 14:16:04 +0200
X-Gm-Features: AQ5f1JqG2f4RhmCj7Mx17z5aeDboKo2rRKWU4Qvc9LN_As4U7MNu9vztcqLenxU
Message-ID: <CAJFAV8z5zOf1qLeJgNVTSw16KteWX+JR1u5Em+otOR=iFXpu=Q@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] eal: rework function versioning macros
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WNjhgontG1oDI_p0viY7hhmHuZ1q90WEAXxnf2qTwlI_1743596176
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

On Wed, Apr 2, 2025 at 1:53=E2=80=AFPM Thomas Monjalon <thomas@monjalon.net=
> wrote:
>
> 28/03/2025 11:52, David Marchand:
> > --- a/lib/eal/common/eal_symbol_exports.h
> > +++ b/lib/eal/common/eal_symbol_exports.h
> > @@ -5,6 +5,8 @@
> >  #ifndef EAL_SYMBOL_EXPORTS_H
> >  #define EAL_SYMBOL_EXPORTS_H
> >
> > +#include <rte_common.h>
> > +
> >  /* Internal macros for exporting symbols, used by the build system.
> >   * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
> >   * version this symbol was introduced in.
> > @@ -13,4 +15,68 @@
> >  #define RTE_EXPORT_INTERNAL_SYMBOL(a)
> >  #define RTE_EXPORT_SYMBOL(a)
> >
> > +#if !defined(RTE_USE_FUNCTION_VERSIONING) && (defined(RTE_CC_GCC) || d=
efined(RTE_CC_CLANG))
> > +#define VERSIONING_WARN RTE_PRAGMA_WARNING(Use of function versioning =
disabled. \
> > +       Is "use_function_versioning=3Dtrue" in meson.build?)
> > +#else
> > +#define VERSIONING_WARN
> > +#endif
>
> Why no warning for other compilers?
> Why not warn at Meson level?

Symbol versioning is not functional with Windows compiler / linker atm.

When it is ready, the right warning mechanism can be implemented here.

>
> > +
> > +/*
> > + * Provides backwards compatibility when updating exported functions.
>
> I feel a word is missing. What "provides" it?

I'll reword.


>
> > + * When a symbol is exported from a library to provide an API, it also=
 provides a
> > + * calling convention (ABI) that is embodied in its name, return type,
> > + * arguments, etc.  On occasion that function may need to change to ac=
commodate
> > + * new functionality, behavior, etc.  When that occurs, it is desirabl=
e to
> > + * allow for backwards compatibility for a time with older binaries th=
at are
> > + * dynamically linked to the dpdk.
> > + */
> > +
> > +#ifdef RTE_BUILD_SHARED_LIB
> > +
> > +/*
>
> Why not Doxygen style?

Because this header is internal, and not parsed by Doxygen?


>
> > + * RTE_VERSION_SYMBOL
>
> No need to repeat the macro name here.
>
> > + * Creates a symbol version table entry binding symbol <name>@DPDK_<ve=
r> to the internal
>
> Imperative form is more usual.

Ack.

>
> > + * function name <name>_v<ver>.
> > + */
> > +#define RTE_VERSION_SYMBOL(ver, type, name, args) VERSIONING_WARN \
> > +__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) =
"@DPDK_" RTE_STR(ver)); \
> > +__rte_used type name ## _v ## ver args; \
> > +type name ## _v ## ver args
>
> This is only GNU style. It should be highlighted both in this file and th=
e commit log.

Yes, I'll insist on this point in the commitlog.


--=20
David Marchand

