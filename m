Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC7CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 16:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C580F402E2;
	Tue, 28 Oct 2025 17:25:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2BFFD4028D
 for <dev@dpdk.org>; Tue, 28 Oct 2025 17:25:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761668730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFI7YDQKDF+U6RGhr60yB0n/IAuyMYZd1OeN2oL0u6M=;
 b=cMv3VuIf1YWtY2KRxbsl22qym5qHRUXdKg9AUu3es6wjCMOmtEMeDO2WFdZMJPv2URazbF
 a5qn56psR72+beGR+V+4gds0Q98S0YDL0cNU86U6gxu2i9VKy8s4o8uUzYG6I1XH7CnJg3
 F8tdUl64g9XPY40n7CrCoVxB35Rvs/c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-MVqA8lY3MiauLaXwnbfbzg-1; Tue, 28 Oct 2025 12:25:27 -0400
X-MC-Unique: MVqA8lY3MiauLaXwnbfbzg-1
X-Mimecast-MFC-AGG-ID: MVqA8lY3MiauLaXwnbfbzg_1761668726
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-378dd2050b9so31874771fa.2
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761668726; x=1762273526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFI7YDQKDF+U6RGhr60yB0n/IAuyMYZd1OeN2oL0u6M=;
 b=xS/Jm5CjQYNtszC7izLlZTqSR83vVttBO3UlkwfDYKZYf3vsSbmoYWzOkTl76604PM
 xZNBpZbydUOAcobGC+5+r6eMe9RfNgx5cAzEsdf5aOmRYQOd9TYu3NW5J5k1KPBALMEH
 O3ZmaFKdnwSl4lzyJNz6rerrHcF6fnK3HucfkCaClq9G5KRKxfepHmRz+EU3+xGJwUy+
 nf158RGK+knjCQV2A9EUiHy8AQRCNU54GXAru+5I4Me+9mA1BFSw7qs75nIF+LtUIEXh
 y+Z+DHdEP6A3eH1bhDyKwllkHEu43ol7kBjqOmN+7Mn6R11cZtfream6OuS4DA0HQlgU
 hcaw==
X-Gm-Message-State: AOJu0Yyc64QdqOXOJzzyd5Ao3ZUMJ4D9fnO45KDpa06YVxAdpP5ZrHph
 KySJD3BecTQMWcBHSXEnyUeLPbDBtfiOZgRPTTD1O4eCkGd1/0QqBpqMn1oe6vhnUMTdg3i3ob7
 ngSuL3CSPA1eUJu3muIwB7lLsb1t1aX9I6LIHlBiU3nXj57SG64p1Q/s4XgLrYUXT/Z58u+RryH
 J1pRkD98xBJ9fCKU+w2QM=
X-Gm-Gg: ASbGncsLIE0mlHR8cL77HYSBVu90tWi4sAeoWR9QnqDJiNZIXrUL0HBIzKQ9Fx8p1hx
 3zhqpI1QGP2O3EwuZOrrr8etRP11cDT9qCaZzjNE8mYd+sxesBsh7luqQ0yV1QwZhgjmZA3GfG/
 vtr9r1vg3iCBokQgLCcJKXrlPy8JM+IJ9+7Ji/zd7tVi8Z4VXU/AkvHU/KBQ==
X-Received: by 2002:a05:651c:1a2c:b0:372:9fd0:8c44 with SMTP id
 38308e7fff4ca-37a023b0be1mr239461fa.3.1761668726293; 
 Tue, 28 Oct 2025 09:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtH4XDR0zlzlYloQ62nvDpxShfnJD0/o7XqU6WfyhNXfev3QjFI1uXt9Yjem01h6Nuu5XzwyXuA7qd+Dw/ucA=
X-Received: by 2002:a05:651c:1a2c:b0:372:9fd0:8c44 with SMTP id
 38308e7fff4ca-37a023b0be1mr239391fa.3.1761668725882; Tue, 28 Oct 2025
 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251028143952.4160487-1-david.marchand@redhat.com>
 <CALBAE1NCaP7G5BzGpZWbNt-ZgZMRPor5+0dERNNWVyWnFsUW8w@mail.gmail.com>
In-Reply-To: <CALBAE1NCaP7G5BzGpZWbNt-ZgZMRPor5+0dERNNWVyWnFsUW8w@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 28 Oct 2025 17:25:14 +0100
X-Gm-Features: AWmQ_blWmPkogrzBtI1cUcixf8oVSRvsP0Lr1TnsITnfhqJLbZ5gU1PmSOpVlE4
Message-ID: <CAJFAV8zBp_oSeT=4c_3_A3zHynJ9a5f7YcWwTQNPvGFn6ZUrYQ@mail.gmail.com>
Subject: Re: [PATCH] trace: fix build with clang 21
To: Jerin Jacob <jerinjacobk@gmail.com>
Cc: dev@dpdk.org, jerinj@marvell.com, stable@dpdk.org, 
 Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SSfw5rArfh4LGFBy24uBZLzenpKehz_Jy8GJE6BRtF0_1761668726
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

On Tue, 28 Oct 2025 at 17:21, Jerin Jacob <jerinjacobk@gmail.com> wrote:
> On Tue, Oct 28, 2025 at 8:26=E2=80=AFPM David Marchand
> <david.marchand@redhat.com> wrote:
> >
> > This was caught with recent clang.
> > The RTE_TRACE_POINT_ARGS() macro expects at least one parameter.
> > As a (void) function does not require any special tweaking with
> > __rte_unused, we can simply replace with a direct (void) token.
> >
> > Build dir: /export/dpdk-next-net-mrvl/build-clang-static
>
> This can be removed.
>
> Add Fixes: if possible.

Indeed,
Fixes: 856aef55de95 ("trace: fix undefined behavior in register")

> Acked-by: Jerin Jacob <jerinj@marvell.com>

Thanks for testing.


--=20
David Marchand

