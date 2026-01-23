Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF2D74EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 15:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C25B4026F;
	Fri, 23 Jan 2026 16:38:17 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 797624026F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 16:38:15 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-11f36012fb2so3725273c88.1
 for <dev@dpdk.org>; Fri, 23 Jan 2026 07:38:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769182694; cv=none;
 d=google.com; s=arc-20240605;
 b=bNcJT8vNiAYoZymptxdqEI1fDboXOnjEttyqtuz2D0em7dhhi90MBNqCnIfvDAFOkd
 4xm8dmchz2/hZOK61T+cI5V39KOCeKfGpdjKRucxL3C1gsYw8JUQtMO7mHw0t8/GiVoZ
 wGtre+XyDILUHox99PCKO+O7+glkwWspI24W+wC6f+pL0+YzFjg2N6yvIkXEUuyywFSf
 UaE5cYNHlmS1GBq5tqAPn2ZILsmp9WbveMKWHs/gOTuPjXihSDUJMBPnOC3qHjv3COl2
 EA4FcH8pXpDhCvM1YoNmw0o/yXJZfWeRXdC8PAI6s4a0cQm6oMssXivizEJ1mi5LsInb
 yFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OJpwIdi5NUoQyEZBGmK4NXay2bw9cZwbSqueXOJ7cgs=;
 fh=FXa+7kCBBTrEVycpKNOpmwepJbnWvom/AnZkto3CptU=;
 b=Y4y5vf6BrVQXbosZB/ADoncDwyqeS4jCbNR/+4AuogJ5k+mAuavOEpCCWKx71rlWL1
 wE3E9hl7FSmxJ1u9o5RV8Vys6YZouyYBDqgGGsmWqQj3dLeFIIPZfFSXL3QkJG97/VV6
 Bguhm1EE6F3/vRbjsCnyoraK8hL1QBcOKEIIgrcK7YmURiiwJJVPmUdSAsW7FHxLnEzr
 tGejq327Cac+U3yWD+h9XBh/8BrWd8cMYuKTy6HeXdi9auPEW4G+v8T8y3FSiaGvCZar
 XOU6B72aUsfnr4hGsfaq6lPr/FjelRkNI7D7UKxdaqEAQeyLff/OPZf9iCYrsXeM1c78
 rCew==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769182694; x=1769787494; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OJpwIdi5NUoQyEZBGmK4NXay2bw9cZwbSqueXOJ7cgs=;
 b=JIF0T1Z3s9i6ptaZRZ6v4Xgh/RZ9M+8uVEVAZUY3yaZZ8OnWX0oJXZyc2xh2yePZFB
 L8RkQtp0D+s6MkIJAFfp+wX2axwWXl7RGY8g16qyqbFQJIWeJ/B9cm/uf+N++cyQon9f
 LzOnrCGPg+ajBYm21GGhMIv3e3TiKudHqOTH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769182694; x=1769787494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJpwIdi5NUoQyEZBGmK4NXay2bw9cZwbSqueXOJ7cgs=;
 b=lH2juiKdjdyEac7JDQQTvORj/EhuRTu4ypdPkzVznPDYFRzvuJeV+qZRCr8rm/zmQW
 gf97VREVpL7NtbzsOqkrlQANb2d/yGP6W644s5raoBkZR0EqUiOzGrxNBWVl5tBuN7Gn
 h0q8Oi1bNdsjJ4k+STWckKseJxjFgwEanM/nfXy40SiG7h2+clA3lUoAWHipKXncr48+
 rNa7gOc1R313o72sysqaO1v1JtA4lIOPQk71LhSaiHZeEQaiwoJlMKLwxdCcTW7z/1Sf
 x36hO9ExWzxk6Ekl76rfbIey8z0B2tMjN4npr/1NnSJ2efT4IvMnDY43hxwn1fJ8malu
 IXTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF3cNSxuXIXqZDq/VrfKZhzbY/a5CnAW9DUWTUPC+BIDKrtpb3MWzeGHQKqnMWJWQtoo4=@dpdk.org
X-Gm-Message-State: AOJu0YwDhsH4//2yi6k+2xwZjLj3cLhzwsfU53rocoeuUN3yOULl3DTx
 9R6L2WmFjzCfLz9dh+IILmYIKCL0Eu4jTcEYQ0jf5cJzDJWXVeMJPQ58oiO1iWErFzvy1LjWYZ+
 fNu1gLxilW65tusddF4450gcs1IjTYgm6To1QNdfxJw==
X-Gm-Gg: AZuq6aIZr68GLxB5LD3gv6ggHuWp98k9F+a2nWDqfd+L2eHHELitO93rOeXm/KIjIiN
 XqLTBegkXEBy82bv+CRkkjvdQtb3ohI3EKg4+2rtrKp09BUi0dM7wzDmcenq4sI6gj3U5sp1sXM
 cn5aGC0y5Oz2QbSIr19UhTZUN7OqyvYOAUlubl2I73U7P79fYyGuFL1iTswEe63sIfGJf1Xd/FO
 6IQY7/rIN8t8dyuszs81lAD19n6cgC8r1HX+6Qtyy4E7gJ9moRCDWSQzPIjYbeWHgdV6akUz7bY
 mWdrjlrbSz4HS8LsywBR2536BcRH/SZbURpgIyJU5evq1fH5ak63/ZAtjjqD
X-Received: by 2002:a05:7022:b98:b0:11b:c2fd:3960 with SMTP id
 a92af1059eb24-1247dbf824dmr1186757c88.28.1769182694264; Fri, 23 Jan 2026
 07:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
 <CAJvnSUC3ze51WFHx=cRMGKezrwXvo7fCXH8o64qJsbWf9SXsZg@mail.gmail.com>
 <aXM5LAcV6EC6L9VS@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aXM5LAcV6EC6L9VS@bricha3-mobl1.ger.corp.intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 23 Jan 2026 10:35:53 -0500
X-Gm-Features: AZwV_QgS4qBMYpiOEKcYtSJW2Q5iWbXEBNskvP9Hr4rmMLFcigDxxB6oaA2wTGc
Message-ID: <CAJvnSUCd3MpiHbTuv17bXdQK+rfeXwiacW3=sJqpJgMxO3YkFQ@mail.gmail.com>
Subject: Re: [PATCH] build: bump meson version to remove warnings
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org, ci@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>, Aaron Conole <aconole@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>,
 Timothy Redaelli <tredaelli@redhat.com>, 
 Matthew Labrecque <mlabrecque@iol.unh.edu>
Content-Type: multipart/alternative; boundary="00000000000008e19806490ff2e1"
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

--00000000000008e19806490ff2e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 4:02=E2=80=AFAM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> On Thu, Jan 22, 2026 at 01:59:19PM -0500, Patrick Robb wrote:
> >    Thanks David for the CC. We need to rebuild all of our DPDK
> >    container images for the distro build testing etc. which takes some
> >    time. We should be ready early next week.
> >
>
> Is rebuilding all container images something that needs to be done every
> time we do a minimum meson version bump? If so, we probably need to look =
to
> take steps to make things easier to do.
>

Right now we do build new images any time any DPDK dependencies are
updated, including meson. That's done with the dpdk-ci template engine (an
application that templates out Dockerfiles for DPDK CI testing):
https://git.dpdk.org/tools/dpdk-ci/tree/containers

However, to simplify we can just move to installing meson at runtime in all
cases. We already have to do this sometimes (like when testing with an LTS
that requires a different meson) so doing it in all cases wouldn't be too
disruptive. And, of course the main point is that that would allow us to
accomodate a version bump like this  without rebuilding the CI images. Let
me know if you have an opinion. In any case I will chat with the CI Lab
students about it.

--00000000000008e19806490ff2e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 23,=
 2026 at 4:02=E2=80=AFAM Bruce Richardson &lt;<a href=3D"mailto:bruce.richa=
rdson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Thu, Jan 22, 2026 at 01:59:19=
PM -0500, Patrick Robb wrote:<br>
&gt;=C2=A0 =C2=A0 Thanks David for the CC. We need to rebuild all of our DP=
DK<br>
&gt;=C2=A0 =C2=A0 container images for the distro build testing etc. which =
takes some<br>
&gt;=C2=A0 =C2=A0 time. We should be ready early next week.<br>
&gt; <br>
<br>
Is rebuilding all container images something that needs to be done every<br=
>
time we do a minimum meson version bump? If so, we probably need to look to=
<br>
take steps to make things easier to do.<br></blockquote><div><br></div><div=
>Right now we do build new images any time any DPDK dependencies are update=
d, including meson. That&#39;s done with the dpdk-ci template engine (an ap=
plication that templates out Dockerfiles for DPDK CI testing):=C2=A0<a href=
=3D"https://git.dpdk.org/tools/dpdk-ci/tree/containers">https://git.dpdk.or=
g/tools/dpdk-ci/tree/containers</a></div><div><br></div><div>However, to si=
mplify we can just move to installing meson at runtime in all cases. We alr=
eady have to do this sometimes (like when testing with an LTS that requires=
 a different meson) so doing it in all cases wouldn&#39;t be too disruptive=
. And, of course the main point is that that would allow us to accomodate a=
 version bump like this=C2=A0 without rebuilding the CI images. Let me know=
 if you have an opinion. In any case I will chat with the CI Lab students a=
bout it.</div></div></div>

--00000000000008e19806490ff2e1--
