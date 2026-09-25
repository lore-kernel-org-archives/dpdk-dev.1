Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1FC98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 11:58:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70F3F40BA6;
	Fri, 25 Sep 2026 13:58:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DC05F402D9
 for <dev@dpdk.org>; Fri, 25 Sep 2026 13:57:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790337479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YNEGvaW90i1aHt5aPeY256ymxtggAYs22MS6Yw99LI=;
 b=U6Y/QwX5CXzWov9U4P4taZ9xU7apa8U3TpWywO7mtELmR91zNkWxEy1PEe4Y6zK9FbUrDD
 dV73YgUy/za7dtcKM77waI0BZjaVRYcXWCpDQRPrT5BLTCkzXJgAoaWauwUJVGici9zTvS
 7PwYxKZLH7hyT1zQ0twv6dWNuS1C4c8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-gyWirmgUNg6xVqVmtSSxpQ-1; Fri, 25 Sep 2026 07:57:57 -0400
X-MC-Unique: gyWirmgUNg6xVqVmtSSxpQ-1
X-Mimecast-MFC-AGG-ID: gyWirmgUNg6xVqVmtSSxpQ_1790337476
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b619951eaeso437525e87.0
 for <dev@dpdk.org>; Fri, 25 Sep 2026 04:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790337476; x=1790942276;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/YNEGvaW90i1aHt5aPeY256ymxtggAYs22MS6Yw99LI=;
 b=j6l5TmwPGaGvBE99INI6ebMDLJorwVVJ7hW0KPeVskhVj0vlw9/7piHVtSZSrD7WA2
 nz8vPczKQnDVSwDEPgWiYTCdxDNQdLhL+iztGmxDfVxlFnJwXUpj+ZJfaB+4Cx8Usoy/
 MwZJYI+a96IHTiw4rkN4GAvI1kqDUH7WWJFFl5JSNf/1JomB0rIbMUGjjZTv2xjGS2Lq
 9TQwfqISBrXx1FHde3BfawYtxsSSGsFYaMzB8bTdMg0LvalteHBKnVqSvTYhCtyzWK3t
 yoCm6dhD9TgzDFgUhET2S+IaVZr4wGCDL0JD2r2ggjkO14wqvjJV4WVazx8oVKfPoQR4
 rDtQ==
X-Gm-Message-State: AFuF++k1GFn3CcRqEkMcl+NXn6JoWFUMBYu5D8rE5Qzj3O0je0KQ9uES
 UfENvXSZ3TWbJee85xM7VxRBZgo9yI7t7mjHEV+K/A32g4g7pehu9551DH8IVc0MPMkC7YDMX9C
 TlIUpN6rCViK1X5Wz7fli1mzv+dNQnWDiah2cER2b6TKTK0PiXfmsM16i70iD3KVo5/EAOTouzL
 sM1NLdpamwsaLBshMpiHo=
X-Gm-Gg: AYBFou0NIktOq6laBk6lMpSQdZhsrHYXogODHO5Jp3VoMZX25xI50ldZAlPXmH2H1Zy
 j3vbsRTPETLqiYmvTSSWugOiCAMHD+3EkhYwRH7t4FvqQ8dOAgrtEWm0O9/Zl7Ht7MQXnYpr33/
 ak2CIg6faBYfddIOGvtn8PhtTxrtIyNQHCOEbRcvJpU3fGaOztc0mXJPBavJ1yX+UiUEtZ4haoS
 HGJnBPV6ee/O/b0Izy4wFP28z8EzUgpezSTZixzx9fvePwr
X-Received: by 2002:a05:6512:1322:b0:5ad:68aa:8a78 with SMTP id
 2adb3069b0e04-5b8df0c3279mr1870143e87.5.1790337476046; 
 Fri, 25 Sep 2026 04:57:56 -0700 (PDT)
X-Received: by 2002:a05:6512:1322:b0:5ad:68aa:8a78 with SMTP id
 2adb3069b0e04-5b8df0c3279mr1870130e87.5.1790337475510; Fri, 25 Sep 2026
 04:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260924141246.4037433-1-bruce.richardson@intel.com>
 <CAJFAV8x2qg7x_g=fQq3odv8cmrP_a=Ax4_HYZVpg-jwXVAujJA@mail.gmail.com>
 <arZS7u1zo5ES3SCZ@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <arZS7u1zo5ES3SCZ@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 25 Sep 2026 13:57:42 +0200
X-Gm-Features: AclHuK8T8yZWdBjW6CrARhZj1di4Dz-6MOaYn7NqznJoFcUfJXc3yyhGbvmhH5o
Message-ID: <CAJFAV8xVRKtpHV+iGRUt5zAqAUGX6CpgNAhsGo9qCCfOfYhwaQ@mail.gmail.com>
Subject: Re: [PATCH] eal: fix C++ builds when stdatomics is set
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5x5LfKcrPN5eriiLYiYSR2yhMxMKKWpoCfzil607HWQ_1790337476
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

On Fri, 25 Sept 2026 at 12:54, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Sep 25, 2026 at 12:13:41PM +0200, David Marchand wrote:
> > On Thu, 24 Sept 2026 at 16:13, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > When the DPDK build is configured to use stdatomics rather than compi=
ler
> > > builtin atomics, the C++ chkincs builds were failing
> > >
> > > In file included from buildtools/chkincs/staging/generic/rte_atomic.h=
:18,
> > >                  from /home/morten/upstreaming/dpdk-stack-std/lib/eal=
/x86/include/rte_atomic.h:12,
> > >                  from buildtools/chkincs/chkincs-cpp.p/rte_atomic.cpp=
:1:
> > > buildtools/chkincs/staging/rte_stdatomic.h:30:9: error: =E2=80=98memo=
ry_order=E2=80=99 does not name a type
> > >    30 | typedef memory_order rte_memory_order;
> > >       |         ^~~~~~~~~~~~
> > >
> > > The cause is differences in atomics in C (C11) and C++ (e.g. C++17 as
> > > supported by current GCC). As explained by AI analysis:
> > >
> > > " _Atomic(T) is a C11 feature. In C++ mode, GCC 15 does not support i=
t as
> > >  a type specifier, and <stdatomic.h> in C++17 doesn't expose
> > >  memory_order in the global namespace (that's only in C++23). DPDK
> > >  headers also use _Atomic in anonymous unions and under extern "C",
> > >  which are incompatible with C++'s std::atomic<T> mapping."
> > >
> > > To fix this in a resilient manner we need to go from two blocks in
> > > rte_atomic.h to three. We have the existing non-standard/builtin
> > > atomics path, but the standard atomic path now needs to be split into=
 C
> > > compatible and C++ compatible blocks. This fixes the build issues wit=
h
> > > C++ while keeping existing C builds unchanged.
> > >
> > > Bugzilla ID: 1985
> > > Fixes: 5c381a3587d1 ("eal: provide stdatomic API")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > Probably worth squashing this in (I tested in GHA):
> >
> > $ git diff
> > diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> > index e0b914a142..b09d72dd87 100755
> > --- a/.ci/linux-build.sh
> > +++ b/.ci/linux-build.sh
> > @@ -111,13 +111,12 @@ OPTS=3D"$OPTS -Dplatform=3Dgeneric"
> >  OPTS=3D"$OPTS -Ddefault_library=3D$DEF_LIB"
> >  if [ "$STDATOMIC" =3D "true" ]; then
> >      OPTS=3D"$OPTS -Denable_stdatomic=3Dtrue"
> > +fi
> > +OPTS=3D"$OPTS -Dcheck_includes=3Dtrue"
> > +if [ "${CC%%clang}" !=3D "$CC" ]; then
> > +    export CXX=3Dclang++
> >  else
> > -    OPTS=3D"$OPTS -Dcheck_includes=3Dtrue"
> > -    if [ "${CC%%clang}" !=3D "$CC" ]; then
> > -        export CXX=3Dclang++
> > -    else
> > -        export CXX=3Dg++
> > -    fi
> > +    export CXX=3Dg++
> >  fi
> >  if [ "$MINI" =3D "true" ]; then
> >      OPTS=3D"$OPTS -Denable_drivers=3Dnet/null"
> >
> >
> > Compilation passes fine in my env and GHA.
> >
> Sure. Shall I do a respin to include that?

Yes please, not worth a separate commit.


--=20
David Marchand

