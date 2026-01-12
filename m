Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10992CF45A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 16:43:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB98140281;
	Mon, 12 Jan 2026 17:43:21 +0100 (CET)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) by mails.dpdk.org (Postfix) with ESMTP id EB3E240281
 for <dev@dpdk.org>; Mon, 12 Jan 2026 17:43:19 +0100 (CET)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-5eea3fe88bdso1376770137.3
 for <dev@dpdk.org>; Mon, 12 Jan 2026 08:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768236199; x=1768840999; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wDXhJo90yLXrag27EQhxNXS7h9Q9nPEPKwqlVxmYng=;
 b=egI9ZgXns224SZ6ShyOFFfgTB3PMWC/6KwI8ptgrrInG8Dt6BRoPsu3yMCCZ6N0sJy
 R22KXFFUFfYjSi9/KAAU2oYNrtz+Gt1LIMuwV9HgGLT21E3ldoQKN9KNESzjY6qdH/1u
 4PhBcBIxjT7hBuJoK6SdWCEIzKZQoTe1MGQMSOagODj5JxJD7K+82bvm9p4oTBk86sFz
 u5UrADeH0RSfzNExrMooulwuaMO0vqOfge9iwcwTPfb5xJNU1kNVD8Zcj+9ArlBw4bcN
 f5Ze5FJ3w23gU1hDalUk53sqGZ4PzGi6ca4jKR9DgZb1aYXgJ/QRqgOFDUxPyofImXZW
 MZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768236199; x=1768840999;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1wDXhJo90yLXrag27EQhxNXS7h9Q9nPEPKwqlVxmYng=;
 b=awsoQVZr9WawtyBPsCh/1CE6y9fOM9a2lg0G9PK+toL08warzMQu455nfO4bscVssd
 BlGXyySa2qrDFtSic+BigPJrkMNYgay9jy2017wB5sXs6598wfDgIZGorKNMtupVMZgD
 LDH6OU/ackNG3iqsdug0yzJQR2w3EDeHIVjiYpta4nIj0DGIkAqKrqaea/UKmGSutkyi
 1BKA9b46rgyoc0rnI7lkt3fY7dh5wgBxxQa0t77dOo9UYkf7DargoknfT66ys4Xv8mkx
 0SJWYr+EN0xDew++9gHzIENz3p7/b7TZpU8tCHN1bKut6b82SIQMwJmMnhhdQtVT8I+I
 kXKQ==
X-Gm-Message-State: AOJu0YzCtKN6fXyYss2ByGj+fSbDYTt6fo55baBoyhQqCKfpc75N4hrK
 eVt1sJtv0nZFz4yWvUxDlRlTieIqx7Gqg5ye/G6GOJgjDCX96NEFjPmOeNY6aO/ueAfVuPMy4OG
 jhCuDzQ5Nf9GJbQn3pUwA65HK3AR/qyM=
X-Gm-Gg: AY/fxX5CEClQrxVMsXi9d8qWn4+VSt3m0jjECnd4ycmnB5OJbOUS+AFufZAhWLT/Wk4
 kgU3RaXSG+sm8xFYku8HJu6yfPx88/JOkgjYPnJvENbGTvsOhgras8lEjqPgD3l/bfm3B2FvAf4
 i4Wo6NYK1bPPBIhY2gUaQX0bic1GZ5F8+//Xb+nFD0658MlVsMBrckwVK7rek9S1EJl32e9O46J
 vCSCnEOGh1Qj5KExBNOgEfYrM3xgEMcCAI9/ICl0d4XkyfbmUKSuqsec/Ju94aEDfIFQWRdB3iR
 6h/tfg==
X-Google-Smtp-Source: AGHT+IGReabhORRyWxVWuvUuFengcVQCS5msIIt4l24yKrO1+cC5r7f/5fd4Kp7yFQ/hqbCpiWgQEGX/nc/7rnhWVtY=
X-Received: by 2002:a05:6102:4a88:b0:5ee:f748:6ceb with SMTP id
 ada2fe7eead31-5eef7486f18mr4244507137.15.1768236199203; Mon, 12 Jan 2026
 08:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20260112154059.36879-1-scott.k.mitch1@gmail.com>
 <aWUcoGX-k12L55KP@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aWUcoGX-k12L55KP@bricha3-mobl1.ger.corp.intel.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Mon, 12 Jan 2026 11:43:08 -0500
X-Gm-Features: AZwV_QgIGKQFP_YhAshQgWjFw4kY3ZeeBZmEUaJ8qv5tCViiS8E8jj3xe_lO3-M
Message-ID: <CAFn2buDQabMZNoajAXrEY4LZ_8GPdqT8zdBvfxwQVMnxucss6Q@mail.gmail.com>
Subject: Re: [PATCH v5] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stephen@networkplumber.org
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

On Mon, Jan 12, 2026 at 11:09=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Mon, Jan 12, 2026 at 10:40:59AM -0500, scott.k.mitch1@gmail.com wrote:
> > From: Scott Mitchell <scott.k.mitch1@gmail.com>
> >
> > Modify RTE_PTR_ADD and RTE_PTR_SUB to use char* pointer arithmetic
> > instead of uintptr_t casts. Benefits of this approach:
> > - API compatibility: works for both integer and pointer inputs
> > - Retains simple macros: no pragmas, no _Generic
> > - Enables compiler optimizations: Clang now can unroll and vectorize
> > pointer loops, and GCC still can apply these optimizations.
> >
> > Example use case which benefits is __rte_raw_cksum. Performance
> > results from cksum_perf_autotest on Intel Xeon (Cascade Lake,
> > AVX-512) built with Clang 18.1 (TSC cycles/byte):
> >   Block size    Before    After    Improvement
> >          100      0.40     0.24        ~40%
> >         1500      0.50     0.06        ~8x
> >         9000      0.49     0.06        ~8x
> >
> > Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> > ---
>
>
> The macro implementation LGTM
>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
> Couple of comments on the unit tests inline below. Most are only
> suggestions, so feel free to ignore if you think they aren't worth
> considering.

Thanks for the review! I will need a v6 as CI detected
compiler/environment combos
with errors. I'm trying to thread the needle to find a way to preserve
APIs and enable clang optimizations.

> Given all the typecasting in the macros, I don't like the casting to
> uintptr_t when checking the return values. Maybe use (void *) on the valu=
e
> being compared-with instead.
>
> A suggestion: can you maybe put at the top:
>
> #define test_initval 0x1000
> #define test_increment 100
> #define test_retval ((void *)0x1064))
>
> and use those everywhere rather than the hard-coded constants?

Sounds good!

> Maybe define a new set of macros for small sized ints? Or else just use 1=
00
> and 50 generally, rather than 0x1064? The test should be just as good,
> right?

I'll use macros for different sizes to catch potential for unexpected
truncation.

> Very comprehensive set of tests, thanks.

No problem!
