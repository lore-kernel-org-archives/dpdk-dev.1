Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659AC77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 16:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FA0640267;
	Thu,  3 Jul 2025 18:10:15 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id A0BFA40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 18:10:13 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6fd0a3cd326so628056d6.1
 for <dev@dpdk.org>; Thu, 03 Jul 2025 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751559013;
 x=1752163813; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zSsM/GBOvZEt7b0jH3HJ7sa3t8exIxxqQQ5290+ZT8=;
 b=qG5JF6a4D+zUulHkcx9LAdisI7MgKbTTRnsdNJWCEr1jy4W3qCOkCGsnzTMwER08V/
 UbKy9Qyf5UyDFjnScPgM15m7A0jB7gE/Hl3tujEt1YH8A3vnKwZ0u4aSZD3+mZgcAMtn
 UhtZaQkcFoIVC0W9ZnTFPdrhoCeW0xP12liknfLpIjL07IfijbH97+yEqGFo8CZkCCUV
 Wk/TxUidlMtZsykSfoDMWIHkl6UF35ZnEIALc6e9fDUvJFUKEoekX27cMVKLRHYdCmI+
 s9rfg+ZimJ3vbE2MR5Ekt+4iuffZvIKoCoLM8peC6kbZHKZPNcHjuSOg4Bbe7uGlGH8s
 or+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559013; x=1752163813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zSsM/GBOvZEt7b0jH3HJ7sa3t8exIxxqQQ5290+ZT8=;
 b=uAxuWc4GH/au3ikWOAmpvtso9ZrOfJzSu1ZUjH4Ryk3vvCeA1SktVpCCd/rrJ+1XJM
 1qnILvyPmjWdyB62yfDQQGwPabe8C7VmkDYe6EiRwdWHxjljyog6XG6u9Zzj34UPaNW7
 0wIr0c2PlJflAQV4Wk0tGWoFxFwo/E6MH/uOJtDK8+cEzxaamnGHLfgE6DUojtveRQwO
 X2RpfObKmjwvPtEijBHp6ZdpfKFrP08tr7C/aOyQ0R80bMkZFFmDh2XQSyyA69MhANWM
 jVaSOvJEFdLk9QAqL/6k9Z9feMeq5yLwpuLvO7TJVCcnW2HCwMjCu84mF3esgy7VOecd
 J+/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHailE1Wo/xrkYvyA/ZBJE0/MBYShIi6PqYiDEyCB1ZIx9IIjSvget5UMjUtssz82aWhQ=@dpdk.org
X-Gm-Message-State: AOJu0YxpF4QoOft2et5q8r0IOcCywVOHT83G1nScQik9AMt3Jm7f5p9Y
 HYHQymwAxG+rQNa6HzcRHiy84Lw69BVEX13rs/qG3wUJCx4kPkY/zXjOpjTK9BL5qto=
X-Gm-Gg: ASbGnctFDEplGOflNMMNQHzW+HXLZgHbe8XFydN0Mx40+EKlXQLePKzLjGbMCBHqde+
 cZfwU+DhvE3ykFAt947XigfHbbko/Rc33E2PdPHyt5NjAg+2Io+dbiCRTjlOG4YK3UwB5yIKK83
 My18BxTBfmPaTRlpDROla88KP9eSDt1HzLZftSX8La/BoQVPIstVytNmYFL3iL6Wzve3noKOLcn
 U3jCl8vY3bAkq6mh6hY3uOm6i52xhfIMgp4hlZNVvpdyk64Glh0UPy8838GTIzdluYJ+hYkMcPu
 twB2xQIlqvv/9/EkRshie5TMF1G9br1KtymC2THk9wJgAxmJcBktSw3eZC0yZttN2UTDfzpxvGV
 Qtu6Ie9SAH8GVRHEyQMZtFzqPG01MpWFKHqbKCinHs9p16Xn7GQ==
X-Google-Smtp-Source: AGHT+IF1jY4j8GL6qRSGtZSGs812+537LULAKYu1udGpNONyVxM3U0mCYdGu+fL8qYP/WsNRElsBRg==
X-Received: by 2002:a05:6214:5195:b0:702:b4d3:26b4 with SMTP id
 6a1803df08f44-702bc91d955mr61008166d6.25.1751559012776; 
 Thu, 03 Jul 2025 09:10:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7718da94sm120280236d6.24.2025.07.03.09.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:10:12 -0700 (PDT)
Date: Thu, 3 Jul 2025 09:10:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, Konstantin
 Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>
Subject: Re: [PATCH v2] build/x86: fix support for older compilers
Message-ID: <20250703091009.7ed2166b@hermes.local>
In-Reply-To: <CAJFAV8zxhi8DmhxKFrPnFwFJ60z-eMSH3x=32gKzEAu8xJW6tQ@mail.gmail.com>
References: <20250702155129.3440210-1-bruce.richardson@intel.com>
 <20250702160138.3441279-1-bruce.richardson@intel.com>
 <20250702112242.7b93d978@hermes.local>
 <aGY4nkFZXSBFCZBp@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zxhi8DmhxKFrPnFwFJ60z-eMSH3x=32gKzEAu8xJW6tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 3 Jul 2025 10:12:10 +0200
David Marchand <david.marchand@redhat.com> wrote:

> On Thu, Jul 3, 2025 at 10:01=E2=80=AFAM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Wed, Jul 02, 2025 at 11:22:42AM -0700, Stephen Hemminger wrote: =20
> > > On Wed,  2 Jul 2025 17:00:45 +0100
> > > Bruce Richardson <bruce.richardson@intel.com> wrote:
> > > =20
> > > > Some older compilers e.g. gcc 8.5, do not support overriding
> > > > -march=3Dnative with another architecture, leading to build warning=
s such
> > > > as reported in Bugzilla (link below). Add a check for that case, and
> > > > explicitly add the avx512 flags if necessary.
> > > >
> > > > Note: it appears that it is only the "native" flag that isn't
> > > > overridden, which makes the issue hard to reproduce e.g. using
> > > > godbolt.org, or on a modern machine. For example, testing with gcc =
8.5
> > > > on a haswell machine, using 'native' vs explicit 'haswell':
> > > >
> > > > gcc -march=3Dnative -march=3Dskylake-avx512 -dM -E - < /dev/null | =
grep AVX512 | wc -l
> > > > 0
> > > >
> > > > gcc -march=3Dhaswell -march=3Dskylake-avx512 -dM -E - < /dev/null |=
 grep AVX512 | wc -l
> > > > 5
> > > >
> > > > Bugzilla ID: 1736
> > > > Fixes: e361ae3f59d3 ("build: reduce use of AVX compiler flags")
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > > >  config/x86/meson.build | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/config/x86/meson.build b/config/x86/meson.build
> > > > index e2ccfb6d12..0dcc5ddee4 100644
> > > > --- a/config/x86/meson.build
> > > > +++ b/config/x86/meson.build
> > > > @@ -71,8 +71,13 @@ avx512_march_flag =3D '-march=3Dx86-64-v4'
> > > >  if not cc.has_argument(avx512_march_flag)
> > > >      avx512_march_flag =3D '-march=3Dskylake-avx512'
> > > >  endif
> > > > +# workaround for older compilers, e.g. gcc 8.5 on RHEL 8.
> > > > +# if march flag overriding doesn't work, explicitly add flags for =
AVX512.
> > > > +if cc.get_define('__AVX512F__', args: [machine_args, avx512_march_=
flag]) =3D=3D ''
> > > > +    avx512_march_flag =3D ['-mavx512f', '-mavx512bw', '-mavx512cd'=
, '-mavx512dq', '-mavx512vl']
> > > > +endif =20
> > >
> > > RHEL 8.5 reached end of extended support cycle (EOL).
> > > Why are we still supporting it? =20
> >
> > Folks working for Redhat can answer better than me, but according to [1]
> > it's not EOL yet. Also, we support it in DPDK because users are still u=
sing =20
>=20
> RHEL 8 is not EOL.
>=20
>=20

Right but 8.5 is, did compiler get fixed in later 8.X versions?
