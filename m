Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B7D74EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 308C94026F;
	Fri, 23 Jan 2026 17:01:48 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 728574021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:01:46 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12336f33098so2410781c88.0
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769184105; cv=none;
 d=google.com; s=arc-20240605;
 b=h/tA3o6CDzE2X/D6wzCom9iS3Pc/OfDRFm2DB13iIrGusZlmYKxASzq27wQpRVdqE2
 4JpcG6jcxjmz225nH+eI+G2aV6c3AA6jSCzQI3z8G4H/DRj1ncDBpjqsb1+irKKrbnvN
 Hm0fiF7RGeYMwVxgzqUJ3JHfeSlZ+ZrLsZ9w7JD3KVK5Irv+4hnkFNSzVhZBWELiRcBM
 kr8+0v0hR87LhoNomLx6FrYUwNylEtCKoyFvBE3YbS00o0sauwCqOMH6M/VJEA6nZu/k
 Mc1bfBpLQx6lM/xwByEBmClwDUbJZ11McgMe2AEtJbjr67MDLnGDgBOrD2VgY8NlTpxQ
 mgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EyBLS5wrZ95mL2USzYScMMTh1hFzTDBsOC5G/0+24JA=;
 fh=FVybw4ASM7v4zj0EM2buhl7a7/ZXQvEJJvN0hfMgIIo=;
 b=Ee6HSLcdoFYXsGKGhcPwdnJn6IGxyoyx+sq81/aJL/9ohgGgphjMSIyKJA0T4XYowb
 5QTi/K56LPmhj1O+fPaICBiZTU9XE6iYZjZ6UtqbE9k65PZMpEE/E6mSM+Hd+Ck+zz+c
 Gw310DzrExg/vFJ947sPOjhzmn7nUYTukghZNbD2X7w6dSnrBZ3q2O+DYeThiF+eiJWZ
 jAzTWUB54fUT2cO1Ql1VLbEIsVG4VUkfE3BEU1F7Z2k1bSrwD7yudzArR14Fe4QnMXct
 pDpiXNTjq7YRZyFZjTBdKa7+6NCbsRpCU1TDO5tRzTxPcYz7eXugfff4AwN3Zc10pEoc
 hH2A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769184105; x=1769788905; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EyBLS5wrZ95mL2USzYScMMTh1hFzTDBsOC5G/0+24JA=;
 b=NvEqK/0BK6lWfmj/fgJO65t/75KMjQy26gLeFZYtYHdZPUkGhh5QtnmKdRGtW1nw9J
 qqWrSN844pjzpqtSpOXOyUg7x4vfh6gtXPb7GN50+yWAjzYJfHbFQzEnnpT9PHOtrSQQ
 2Zc+txN6ZSpYt8iGvKhoxqgbvSoqaWtzHgofU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769184105; x=1769788905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyBLS5wrZ95mL2USzYScMMTh1hFzTDBsOC5G/0+24JA=;
 b=nC1+o2r6jditq85ZOKsISj+1Akc7zBKldTpPeCJtvaVbpyxe5wvzHkVVTFQRt6xGmG
 B336dk69/4lasYSjHhQFhL2ACMzBoTH+JXa4jyUj6Blaol6mLDh8LzQZhSrzK97qQZRx
 ryaMaSjS78QeQWkPqmtmIJA3QvDeUSmWdAyyL1sh/gk5mtNSrp1lua0MEReIVgFlF43a
 eUtXtoh2Fj3CwPyHpH1VwzJqN9XXEfqrF8iZ162yHC4pEV6L9/Mdm6Vx0u/rqmQoUR9l
 ocAYZp4czDMywtCq0f2XfqQR1Kn8yLlqfWjNoZviJwzHDxf8wPfnfkH0FW04yyDNHspG
 rNGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDscxQwrfa2Vjas2DHgiAS5hAphdfC7ovsEszZ+R+nL/pstazU+T8qx/4FSln63s6Hgqs=@dpdk.org
X-Gm-Message-State: AOJu0Yyf+XrJztApXwK9srgTBcWj6DApzLB6kiKfaHDB828dfumDWAo5
 rrujdgojK7cx2O8iLIa/nF9YuNmSYdoPVFES5P5OdGYdyRFSYqYB5FJ+5cHKSkXbZF7rvtfYP31
 5ImHBcvWOOEpjstAz3pc3N6ZWHpdZiY0ZyKRYHSUoDQ==
X-Gm-Gg: AZuq6aJRQpFGiN62eXPj9TMrLoAEXN6iiItBs6bFah7diFXiB8XUp2Gw6Q6D8nRKVfF
 zVjuGUPuckkiBWdfwCZD9R+FE3Kjl6GjClBEQ6WktuqUi6Xx3VAL6rBroLNUKTeZ6SlDx/LWC8A
 OXfZCp/gqr8DHXgyOr1E4SwouCQX6YHYEPG7vzdCdZEmUFkci14rrrX4UFqHZLQ9rUTnAa9KstO
 okI45GXThBCyq2bq8mA5rDv/pKpgPh0dlpjp1KkgLuu+OuqNe+v0y1aZSE/XI94iyNZwNCFpx8Y
 ShRuNcubwXIWtZM1Rydy5O0NdTyThCz8OcSbIFz8AlVxVC8bFbWAgM+ZlTDS
X-Received: by 2002:a05:7022:670f:b0:11b:1c6d:98bd with SMTP id
 a92af1059eb24-1247dba9436mr1658417c88.9.1769184104679; Fri, 23 Jan 2026
 08:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
 <CAJvnSUC3ze51WFHx=cRMGKezrwXvo7fCXH8o64qJsbWf9SXsZg@mail.gmail.com>
 <aXM5LAcV6EC6L9VS@bricha3-mobl1.ger.corp.intel.com>
 <CAJvnSUCd3MpiHbTuv17bXdQK+rfeXwiacW3=sJqpJgMxO3YkFQ@mail.gmail.com>
 <aXOXIJerY0lZz9VA@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aXOXIJerY0lZz9VA@bricha3-mobl1.ger.corp.intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 23 Jan 2026 10:59:23 -0500
X-Gm-Features: AZwV_QiTNrZ6s_B4pKLhzuSw1rkbHIhFzI8ueBoowtbW7gqBjzgXAhjjlJ0IugM
Message-ID: <CAJvnSUBOU7QTb6kp2RypHnk7rF5QjSjk5G8WtsEEgT23VmW-vw@mail.gmail.com>
Subject: Re: [PATCH] build: bump meson version to remove warnings
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org, ci@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>, Aaron Conole <aconole@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>,
 Timothy Redaelli <tredaelli@redhat.com>, 
 Matthew Labrecque <mlabrecque@iol.unh.edu>
Content-Type: multipart/alternative; boundary="0000000000001a1ae5064910464b"
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

--0000000000001a1ae5064910464b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 10:43=E2=80=AFAM Bruce Richardson <
bruce.richardson@intel.com> wrote:

> On Fri, Jan 23, 2026 at 10:35:53AM -0500, Patrick Robb wrote:
> >    On Fri, Jan 23, 2026 at 4:02=E2=80=AFAM Bruce Richardson
> >    <[1]bruce.richardson@intel.com> wrote:
> >
> >      On Thu, Jan 22, 2026 at 01:59:19PM -0500, Patrick Robb wrote:
> >      >    Thanks David for the CC. We need to rebuild all of our DPDK
> >      >    container images for the distro build testing etc. which take=
s
> >      some
> >      >    time. We should be ready early next week.
> >      >
> >      Is rebuilding all container images something that needs to be done
> >      every
> >      time we do a minimum meson version bump? If so, we probably need t=
o
> >      look to
> >      take steps to make things easier to do.
> >
> >    Right now we do build new images any time any DPDK dependencies are
> >    updated, including meson. That's done with the dpdk-ci template engi=
ne
> >    (an application that templates out Dockerfiles for DPDK CI
> >    testing): [2]https://git.dpdk.org/tools/dpdk-ci/tree/containers
> >    However, to simplify we can just move to installing meson at runtime
> in
> >    all cases. We already have to do this sometimes (like when testing
> with
> >    an LTS that requires a different meson) so doing it in all cases
> >    wouldn't be too disruptive. And, of course the main point is that th=
at
> >    would allow us to accomodate a version bump like this  without
> >    rebuilding the CI images. Let me know if you have an opinion. In any
> >    case I will chat with the CI Lab students about it.
> >
> Having it installed at runtime would be definitely good.
>
> The other thing I was considering is whether we actually need to use the
> minimum meson version for all build testing. If one or two containers hav=
e
> the minimum version that should be fine, and others can use the distro
> supplied version so long as its >=3D minimum.


Okay, both of the options above sound good. From my end if I had to choose
I would just do the first solution (install meson at runtime in all cases)
because it keeps our process uniform across distro testing and there is no
"special" container. But, the second option sounds good too so please let
me know what you think is best.


>


> /Bruce
>

--0000000000001a1ae5064910464b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 23,=
 2026 at 10:43=E2=80=AFAM Bruce Richardson &lt;<a href=3D"mailto:bruce.rich=
ardson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Fri, Jan 23, 2026 at 10:35:5=
3AM -0500, Patrick Robb wrote:<br>
&gt;=C2=A0 =C2=A0 On Fri, Jan 23, 2026 at 4:02=E2=80=AFAM Bruce Richardson<=
br>
&gt;=C2=A0 =C2=A0 &lt;[1]<a href=3D"mailto:bruce.richardson@intel.com" targ=
et=3D"_blank">bruce.richardson@intel.com</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 On Thu, Jan 22, 2026 at 01:59:19PM -0500, Patrick =
Robb wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Thanks David for the CC. We need=
 to rebuild all of our DPDK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 container images for the distro =
build testing etc. which takes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 some<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 time. We should be ready early n=
ext week.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Is rebuilding all container images something that =
needs to be done<br>
&gt;=C2=A0 =C2=A0 =C2=A0 every<br>
&gt;=C2=A0 =C2=A0 =C2=A0 time we do a minimum meson version bump? If so, we=
 probably need to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 look to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 take steps to make things easier to do.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Right now we do build new images any time any DPDK depend=
encies are<br>
&gt;=C2=A0 =C2=A0 updated, including meson. That&#39;s done with the dpdk-c=
i template engine<br>
&gt;=C2=A0 =C2=A0 (an application that templates out Dockerfiles for DPDK C=
I<br>
&gt;=C2=A0 =C2=A0 testing): [2]<a href=3D"https://git.dpdk.org/tools/dpdk-c=
i/tree/containers" rel=3D"noreferrer" target=3D"_blank">https://git.dpdk.or=
g/tools/dpdk-ci/tree/containers</a><br>
&gt;=C2=A0 =C2=A0 However, to simplify we can just move to installing meson=
 at runtime in<br>
&gt;=C2=A0 =C2=A0 all cases. We already have to do this sometimes (like whe=
n testing with<br>
&gt;=C2=A0 =C2=A0 an LTS that requires a different meson) so doing it in al=
l cases<br>
&gt;=C2=A0 =C2=A0 wouldn&#39;t be too disruptive. And, of course the main p=
oint is that that<br>
&gt;=C2=A0 =C2=A0 would allow us to accomodate a version bump like this=C2=
=A0 without<br>
&gt;=C2=A0 =C2=A0 rebuilding the CI images. Let me know if you have an opin=
ion. In any<br>
&gt;=C2=A0 =C2=A0 case I will chat with the CI Lab students about it.<br>
&gt; <br>
Having it installed at runtime would be definitely good.<br>
<br>
The other thing I was considering is whether we actually need to use the<br=
>
minimum meson version for all build testing. If one or two containers have<=
br>
the minimum version that should be fine, and others can use the distro<br>
supplied version so long as its &gt;=3D minimum.</blockquote><div><br></div=
><div>Okay, both of the options above sound good. From my end if I had to c=
hoose I would just do the first solution (install meson at runtime in all c=
ases) because it keeps our process uniform across distro testing and there =
is no &quot;special&quot; container. But, the second option sounds good too=
 so please let me know what you think is best.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
/Bruce<br>
</blockquote></div></div>

--0000000000001a1ae5064910464b--
