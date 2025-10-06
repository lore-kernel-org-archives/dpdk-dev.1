Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62764CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 14:34:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72FEC402E2;
	Mon,  6 Oct 2025 16:34:42 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 640C9402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 16:34:40 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b62fcddfa21so996216a12.1
 for <dev@dpdk.org>; Mon, 06 Oct 2025 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759761279; x=1760366079; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JRIyA0c46U3DQyPf+z/KKeGZhqh1ZNcnuI9yPs7Miwc=;
 b=ByGW7MMZhon+TgqYztXR9wbd5Ux+Ynu/dgcikevD2Llmasvh5zkn+Qqz3IeQbfufRO
 7MiWXxsN3F/bMUyyc7KHdz4JhvqAY5L8hEFRLdLbwVsCKfVMsuDbs+iaj2x6/7+wpy6x
 g6MdoDw9lw8yjmPvCI2wAGVC9K0sbezxWUmTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759761279; x=1760366079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRIyA0c46U3DQyPf+z/KKeGZhqh1ZNcnuI9yPs7Miwc=;
 b=U8fg9XMr93eAu+4gsNvJRt9elT46GV4Mu2fAZ5D5SPsnIXj/clBoLc8tA4ghquD4wD
 y4S9WyzfYUpRnjwMUEOBGz5vNa8T3IlrXkKy28Ch2v9fuaXAJlDkPffMzXRk6ypvBX+j
 rZYi5mZAscnC6mR0MTSZFjpNxKqAGu+nNrkacSg7lR12Y5lEgF+zHJFy14EPEAtvXWsE
 78Url47CHqbPdKpCXGrYsOfPTMDjBKsRCWY1vxeo8ZTXY6gCWO5bm6r+UuWQEB3Z0SGj
 +oV21xqcISww7f6w9Y7LN4iC6GAr/RliQdRBT2zzOQ/bvomy6TQHMp7exXuouqJgtDi1
 OJRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzBi3js4ACLESETPDsPRhiGC6qFbSEd3wgdpKAWSxPBWSh+xppYIpSE7CuR9nutgQXvoc=@dpdk.org
X-Gm-Message-State: AOJu0YyQUvB12YSElG3Eed5O4GjYeJcX0qPDk2Q4Nbr+fhTQEORRNXq6
 P5YLixzDjOcaaKCBTXCPaHFcxbmuPZhDaiadLM0lZOvdZXhsafyBTTKQJGE1RTaLS3JmxNyoL3f
 VaaDdOCj2kgqhIXuseq3PKOeupahsfnocRy8s4xbEZQ==
X-Gm-Gg: ASbGncuGONcnhFqYiQ6H1vO2XDqVjU8hTHXtXwrOJcmtXKaf38x9TZJZ0VCXWJqYUE5
 At+kmUAi3nD4g1Pd3KypkpyKBNDgBkfbw5WjOK+WO0bktpxjGb7oD481a2DZ7Ew3Xk1XZ9HJt0k
 IpWNU/YK8iQTySD7jzxIWvWZ7OKSZ1dEu1L0LqzE+AixPSiuR8T122zwWzXWOIJVuVOZY9R1Ft0
 9zaVvujg/SPSJQphStJ0mGQHqn78YuQY53jpM8VicbMSw==
X-Google-Smtp-Source: AGHT+IEoBi3GnigtVisUPAvmi0wJLWBAMBBcQBnRP/xgYcFWHtkOoZY2ymPL6nosw1HWWOY92or1IecAt+AucI3+gXI=
X-Received: by 2002:a17:903:2b0f:b0:28e:7f4e:d694 with SMTP id
 d9443c01a7336-28e9a61a8cfmr177859995ad.28.1759761279410; Mon, 06 Oct 2025
 07:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFAV8zLgkqEyifkG0t5f22pu+55PUXAKXdQXHHK7n2sxenTzg@mail.gmail.com>
 <CAMw=ZnSVkkdF8_V54xWxDths7HyRcW_6Fu3kuiQ-tg2buScCeA@mail.gmail.com>
 <CAJFAV8y196yO8OqBi9_EYp+sKHXk41pf5U=M-yym6fP3R_eP6Q@mail.gmail.com>
In-Reply-To: <CAJFAV8y196yO8OqBi9_EYp+sKHXk41pf5U=M-yym6fP3R_eP6Q@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 6 Oct 2025 10:34:05 -0400
X-Gm-Features: AS18NWCov942aQlFlWndgy6AN9DnzMc8iFfWvb1wyNdQ4tvbAfhSiOqYQo2V57E
Message-ID: <CAJvnSUCPDzafvJ=O2baX31asgRtGO==cd05+GXLdptn4qUnEjg@mail.gmail.com>
Subject: Re: Build failure in OBS with openSUSE 15.6
To: David Marchand <david.marchand@redhat.com>
Cc: Luca Boccassi <luca.boccassi@gmail.com>, dev <dev@dpdk.org>, 
 Thomas Monjalon <thomas@monjalon.net>, Kevin Traynor <ktraynor@redhat.com>, 
 Aaron Conole <aconole@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Content-Type: multipart/alternative; boundary="000000000000f2f64506407e59be"
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

--000000000000f2f64506407e59be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This came up for the DPDK Community Lab a few months ago and we modified
the DPDK OpenSuse Dockerfile to build and use a new version of gcc, per
community request:

-----------

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-14 100

-----------

It runs against our normal practice (test with the core build utilities the
distro ships with) but it was the only way to continue to provide results
for OpenSuse.

On Mon, Oct 6, 2025 at 7:04=E2=80=AFAM David Marchand <david.marchand@redha=
t.com>
wrote:

> On Mon, 6 Oct 2025 at 12:27, Luca Boccassi <luca.boccassi@gmail.com>
> wrote:
> > On Mon, 6 Oct 2025 at 08:43, David Marchand <david.marchand@redhat.com>
> wrote:
> > > We have a build failure in the openSUSE 15.6 job in OBS.
> > >
> https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/op=
enSUSE_Leap_15.6/x86_64
> > >
> > > This failure is due to 4a04a346e7f3 ("vhost: simplify use of
> > > pragmas"), which followed dd7fdfff9bc1 ("build: remove support for GC=
C
> > > < 8 and clang < 7").
> > >
> > > The openSUSE 15.6 job still uses
> > > [   39s] C compiler for the host machine: cc (gcc 7.5.0 "cc (SUSE
> Linux) 7.5.0")
> > >
> > > Is it possible to update to a more recent gcc?
> > > Otherwise this test should be dropped.
> >
> > Hi, that's what Leap 15 ships with, so I've disabled the job since
> > it's no longer supported.
> > BTW I believe you have an account? Thomas and Kevin are already listed
> > as maintainers so they can do these changes too, if you tell me your
> > username I can add you as well, it's just a click in the repositories
> > tab to enable/disable builds
>
> Thank you.
> Ack, let's sync offlist.
>
>
> --
> David Marchand
>
>

--000000000000f2f64506407e59be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This came up for the DPDK Community Lab a few months ago a=
nd we modified the DPDK OpenSuse Dockerfile to build and use a new version =
of gcc, per community request:<br><br>-----------<br><br>RUN update-alterna=
tives --install /usr/bin/cc cc /usr/bin/gcc-14 100<br><br>-----------<div><=
br></div><div>It runs against our normal practice (test with the core build=
 utilities the distro ships with) but it was the only way to continue to pr=
ovide results for OpenSuse.</div></div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 6, 2025 =
at 7:04=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marchand@redh=
at.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Mon, 6 Oct 2025 at 12:27, Luca Boccassi=
 &lt;<a href=3D"mailto:luca.boccassi@gmail.com" target=3D"_blank">luca.bocc=
assi@gmail.com</a>&gt; wrote:<br>
&gt; On Mon, 6 Oct 2025 at 08:43, David Marchand &lt;<a href=3D"mailto:davi=
d.marchand@redhat.com" target=3D"_blank">david.marchand@redhat.com</a>&gt; =
wrote:<br>
&gt; &gt; We have a build failure in the openSUSE 15.6 job in OBS.<br>
&gt; &gt; <a href=3D"https://build.opensuse.org/package/live_build_log/home=
:bluca:dpdk/dpdk/openSUSE_Leap_15.6/x86_64" rel=3D"noreferrer" target=3D"_b=
lank">https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpd=
k/openSUSE_Leap_15.6/x86_64</a><br>
&gt; &gt;<br>
&gt; &gt; This failure is due to 4a04a346e7f3 (&quot;vhost: simplify use of=
<br>
&gt; &gt; pragmas&quot;), which followed dd7fdfff9bc1 (&quot;build: remove =
support for GCC<br>
&gt; &gt; &lt; 8 and clang &lt; 7&quot;).<br>
&gt; &gt;<br>
&gt; &gt; The openSUSE 15.6 job still uses<br>
&gt; &gt; [=C2=A0 =C2=A039s] C compiler for the host machine: cc (gcc 7.5.0=
 &quot;cc (SUSE Linux) 7.5.0&quot;)<br>
&gt; &gt;<br>
&gt; &gt; Is it possible to update to a more recent gcc?<br>
&gt; &gt; Otherwise this test should be dropped.<br>
&gt;<br>
&gt; Hi, that&#39;s what Leap 15 ships with, so I&#39;ve disabled the job s=
ince<br>
&gt; it&#39;s no longer supported.<br>
&gt; BTW I believe you have an account? Thomas and Kevin are already listed=
<br>
&gt; as maintainers so they can do these changes too, if you tell me your<b=
r>
&gt; username I can add you as well, it&#39;s just a click in the repositor=
ies<br>
&gt; tab to enable/disable builds<br>
<br>
Thank you.<br>
Ack, let&#39;s sync offlist.<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--000000000000f2f64506407e59be--
