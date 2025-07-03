Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157CEC83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 08:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECE0240287;
	Thu,  3 Jul 2025 10:12:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 218E640285
 for <dev@dpdk.org>; Thu,  3 Jul 2025 10:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751530346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGhuhlbEdRYjPaF69scpLgSkjCduppQ6KuKU/B2UJKM=;
 b=IgX0Tx7QC9qArap3l1adX5Bq+HDdBGU0Q73tM5xXBLGpHGenPeiKDqJrhJxl+o1zwa6D/K
 AXZmFFFUoqTEkOqBYc26m41C7a+RzTgPc6SyXnFv14bdSoEn3PiGMtBs2Zm5PD+2wM7gUB
 mXVukAAG7Mgpiqhkmis/legRgo6r6ZQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-lv5a6z82N7aCEzg4gS5ogQ-1; Thu, 03 Jul 2025 04:12:25 -0400
X-MC-Unique: lv5a6z82N7aCEzg4gS5ogQ-1
X-Mimecast-MFC-AGG-ID: lv5a6z82N7aCEzg4gS5ogQ_1751530343
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-32b4a06b780so33093991fa.0
 for <dev@dpdk.org>; Thu, 03 Jul 2025 01:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751530343; x=1752135143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGhuhlbEdRYjPaF69scpLgSkjCduppQ6KuKU/B2UJKM=;
 b=XFeciFeAjy8+eg6MyuGns3E+vG4nkVpGoZ17qEydBNO8DpuPaaH3QSccWBQeHvUgN3
 YzJIW4sz64mXQO7RYGl+of6l4bPhG5btkv8z3+OUC4pBgBhNidTfntLDDe6A8g9Ekx9v
 XVL8hexhWBQvC9CEUQB4kjUHxwJgybFmFEG2rV1iWfWzUC241O+oaFQ4ESrDjWqVwywL
 +BmFgpPo05J96Otstm/VEG4jEo3acy2lfmSoIW4IC2wzbYcpKPGhN7CWPfFiYQOS4sDZ
 dquxp1VJCQ4bHeCAzsXLLM3hikRaIO0bccZNdVSc1pukhrWNVS7q5vCjwDjlZs7b6N7i
 N+ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU7eqIf/wy5alapUPmpBll9oYVDz87MWHMDNjnEDAkc0C9tTGVHuqgMwWLetSZkg7OWi4=@dpdk.org
X-Gm-Message-State: AOJu0YwQtFBVyg4rFFQArC0//wiGOpBl9y46hPVNGDbb9k8X3wgXCAYa
 KKf7Y9Vy90MjZDfaxc0ibmZ1BMMXqYf5MgkHwC6hCyAzAD7+aUvw110zEY7ckfEpldnTAvQXt3D
 u7Z9ey7tJr8/Hi5RpHreWlkWDL0eJwLqvfeixy8NXesmjAYlc2ToYJTnNh1cKjNCwz3X3lsNADI
 /yY4WsPbpx8lyvT29d/Tw=
X-Gm-Gg: ASbGncuoVUp8s+rSgtNe6GfPxPjfvEObzvjJfC0ImoA3FvFfvgnrajRRQpxwNi4/svp
 boJ8eu1o2BGl0mJgMo5jE2kK+PhWqeohF0qlDND3lHtTgdV5q+E+5YxjTb+9CZSwyXjJbwCbgws
 Vcwjg18g==
X-Received: by 2002:a2e:aa8c:0:b0:32b:4f0c:d259 with SMTP id
 38308e7fff4ca-32dfff9aabemr18985911fa.16.1751530343223; 
 Thu, 03 Jul 2025 01:12:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzXbpluqi6e2a103lgafEOwwB6GYLXEHVyMY4gIb1L4L4HXAcESUuBrWKZz5KdLb2gmQVX81EGBG84ujN9sfU=
X-Received: by 2002:a2e:aa8c:0:b0:32b:4f0c:d259 with SMTP id
 38308e7fff4ca-32dfff9aabemr18985801fa.16.1751530342729; Thu, 03 Jul 2025
 01:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250702155129.3440210-1-bruce.richardson@intel.com>
 <20250702160138.3441279-1-bruce.richardson@intel.com>
 <20250702112242.7b93d978@hermes.local>
 <aGY4nkFZXSBFCZBp@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aGY4nkFZXSBFCZBp@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 3 Jul 2025 10:12:10 +0200
X-Gm-Features: Ac12FXyDUJvaJMpO7tT-UNWfrl_kgY2Y4ZmFPJmW0vbJuB9Aq0F3HipAXaK5vSM
Message-ID: <CAJFAV8zxhi8DmhxKFrPnFwFJ60z-eMSH3x=32gKzEAu8xJW6tQ@mail.gmail.com>
Subject: Re: [PATCH v2] build/x86: fix support for older compilers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aZUTGQlK4uxLEqyk911P9oDtb4xV3uVrgsfkXi0VjqI_1751530343
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

On Thu, Jul 3, 2025 at 10:01=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Jul 02, 2025 at 11:22:42AM -0700, Stephen Hemminger wrote:
> > On Wed,  2 Jul 2025 17:00:45 +0100
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >
> > > Some older compilers e.g. gcc 8.5, do not support overriding
> > > -march=3Dnative with another architecture, leading to build warnings =
such
> > > as reported in Bugzilla (link below). Add a check for that case, and
> > > explicitly add the avx512 flags if necessary.
> > >
> > > Note: it appears that it is only the "native" flag that isn't
> > > overridden, which makes the issue hard to reproduce e.g. using
> > > godbolt.org, or on a modern machine. For example, testing with gcc 8.=
5
> > > on a haswell machine, using 'native' vs explicit 'haswell':
> > >
> > > gcc -march=3Dnative -march=3Dskylake-avx512 -dM -E - < /dev/null | gr=
ep AVX512 | wc -l
> > > 0
> > >
> > > gcc -march=3Dhaswell -march=3Dskylake-avx512 -dM -E - < /dev/null | g=
rep AVX512 | wc -l
> > > 5
> > >
> > > Bugzilla ID: 1736
> > > Fixes: e361ae3f59d3 ("build: reduce use of AVX compiler flags")
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  config/x86/meson.build | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/config/x86/meson.build b/config/x86/meson.build
> > > index e2ccfb6d12..0dcc5ddee4 100644
> > > --- a/config/x86/meson.build
> > > +++ b/config/x86/meson.build
> > > @@ -71,8 +71,13 @@ avx512_march_flag =3D '-march=3Dx86-64-v4'
> > >  if not cc.has_argument(avx512_march_flag)
> > >      avx512_march_flag =3D '-march=3Dskylake-avx512'
> > >  endif
> > > +# workaround for older compilers, e.g. gcc 8.5 on RHEL 8.
> > > +# if march flag overriding doesn't work, explicitly add flags for AV=
X512.
> > > +if cc.get_define('__AVX512F__', args: [machine_args, avx512_march_fl=
ag]) =3D=3D ''
> > > +    avx512_march_flag =3D ['-mavx512f', '-mavx512bw', '-mavx512cd', =
'-mavx512dq', '-mavx512vl']
> > > +endif
> >
> > RHEL 8.5 reached end of extended support cycle (EOL).
> > Why are we still supporting it?
>
> Folks working for Redhat can answer better than me, but according to [1]
> it's not EOL yet. Also, we support it in DPDK because users are still usi=
ng

RHEL 8 is not EOL.


--=20
David Marchand

