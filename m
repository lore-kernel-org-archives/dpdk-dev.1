Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F7D6CFA1
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 19:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2FE6402C0;
	Thu, 22 Jan 2026 20:01:41 +0100 (CET)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 4DDAA40274
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:01:40 +0100 (CET)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12460a7caa2so1990357c88.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 11:01:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769108499; cv=none;
 d=google.com; s=arc-20240605;
 b=Mx+RwZd3sjUZwoBElOCIXeDOh04iYLNZDmhEqgR61LY1jtqXoEcrZ512t/wTngkFvr
 7U262hWOlWOOEfCuz90ouYKf3y6THWxNlK945ZHj76vyg/hQh29BWnbKsQCm3W+C49FS
 5cXkst7h99P+0tSvIx85dSnJUJ5a6ANF3msDkBBgs3nGjBcY3cGdy4J2Cq7Vb9QDVOLx
 +x2Tm4VGPuIbb+1xpEtg14p5GKi80v+4m4hqkR4CasdJ4x8aPlT+hf2JET48Y07/mR1n
 HSxyzvZm0xTKUSfkMe6ZWLEl9F+G2MSDcfoIqkfeOeN5qtLmbz3w9B1dDBNVv1a73az6
 CoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1AFe360Q+ZTnEp6lkDCaOsJzWkVqxxLqkTKMJUhyCs0=;
 fh=ZbK9G+3CaCx0HV92ecE7sU52nJ7EiOiKjWJ7TPzLLwo=;
 b=ANLDzq+JWR12UngJ8QrccphuhCtI6CeQyDsztyQ0zKHqa+tZfOhEwLPu2xZGguBTF9
 WJb5PaKPK6Ebg60GdNqarrd7jCpUkd0sWOYvbA4mOxVjZsedv2gnYhvt+H4AEmfFUIPo
 UU6kJ5t0kEt1QoAIvT2pcEv+yW8iZhnf1p7Xbq9a2H1vsBqR18ZbIP7Z8lPA9zjj1bCq
 JPupv9Z2d9yBAfnD95B4DeuQiaEwXxxHAhW3ZDMs9XwUX7cOtUqcOQvWd7lv8rcptn5p
 Qux4GZYyrBFCdkqAzLEiSDVyo5ZSzID2WBkH0XRASyrLpKxWvqdTbVFaTygqkj2zJv8I
 W9dQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769108499; x=1769713299; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1AFe360Q+ZTnEp6lkDCaOsJzWkVqxxLqkTKMJUhyCs0=;
 b=AyvhxBMH0m8V/uLMnZYwoWHojh3vtR6uLGIQmg8WnMcGMA3TftO+E/cLcoBhZ7sseA
 QE02i8z6/AYVGZdQCjHhbPi4ruUWNDmTXiakY3u8pn71ABXgHkWIoSO34gpOL1P6CUuL
 rZFh7WPh2jEGQVyLbETOrEhoTio5/T7vJZbzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769108499; x=1769713299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AFe360Q+ZTnEp6lkDCaOsJzWkVqxxLqkTKMJUhyCs0=;
 b=raNUIYNOPbywm3AxL6wnuW7BZU7YFgqswab69b7ylOZ5pHDDx1w+iekKCI7Wky1EQl
 ZIADjVWJgy9k4/RSKPH7HvTPwqkVWnvmmUnOCU1cflE3v4f+4diD0PbScaQJ1ceNp1Pt
 J0/H8v39q6dO4e3e0YFYp/EEqXzQC8XgN7TiKIAEvUJFhiYNNPfgAoQwgv0VDT+ZYDby
 NJqkrFENGeJL9a/jlYNUWMQzLW8u7UwN1IWLy2kVsa3bbkglDusVZfNEEySQHUJkLA+z
 zr2kS2YPx7gaGdHjqiyhjwPr4x2QdKaQes+svhVBJVvhMM6/MyIN+6F5hYzY3raqXShj
 AmuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDFJ8n9iAsBtq9taha0Q4fJjK1bOapvTZfTeBUYSx3xcbyINDxUzyNDwN1rtEKgsukVjE=@dpdk.org
X-Gm-Message-State: AOJu0YyJhhGhzRVTmW8oKV78YOgmblziSdR52SUJRwt43+t+wmjXXuzl
 p20OoG5qSilfre+norw2zoBIi3QE4JOoyFsikRo2UWwchpG28UYtwb+OiXAHwO3a7Cwh4Zrw2yG
 zYDV+lcxZnk2qRjR27dMuK1m7JSrsKz+aqpKoBw0DGg==
X-Gm-Gg: AZuq6aLG1bbAePvtXCqFTRnPcvt5LC0F2mz08UWWmzo4gn3QNJUDkxgsZpSIT/fFP5r
 HZOf45MZDN9yrqpiEr6JbfwbYHep7tFoSpVDK4pKXCtQBpKOfTyfBourVmbvVg5dc+GdeRY1drk
 F0iAHQ+f2TZq4AbQ5y/PiYRfY1vtoIsUHYznYFc5Ytj6pCunuTK7s8dBzzNoUrPM2YgROPFMlw2
 hbbwU9uCAEx6xpV/ZppBKM2GhERx2ddAVT4wkA8cwcwOQPv3Tc4CpZJhm9usruZ16Tt2y0HZSQF
 BHK/7CzmN3RH5uKBwo1oZQlvMm1TvbKbsyfJZWQ8fg==
X-Received: by 2002:a05:7022:68a3:b0:11b:38b6:a95a with SMTP id
 a92af1059eb24-1247dbb88a2mr235710c88.11.1769108498840; Thu, 22 Jan 2026
 11:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
In-Reply-To: <CAJFAV8yEy9Oz3u0ZqyA4RHQPUjmvEFSLH1cAnfMZccehd0+Z5w@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 22 Jan 2026 13:59:19 -0500
X-Gm-Features: AZwV_QiDRSdJnRHHMj5rMOS1Nt9_DvewhonKJEFOkjhKo7-C_eU3iveIEriVx_w
Message-ID: <CAJvnSUC3ze51WFHx=cRMGKezrwXvo7fCXH8o64qJsbWf9SXsZg@mail.gmail.com>
Subject: Re: [PATCH] build: bump meson version to remove warnings
To: David Marchand <david.marchand@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, ci@dpdk.org, 
 Thomas Monjalon <thomas@monjalon.net>, Aaron Conole <aconole@redhat.com>, 
 Luca Boccassi <luca.boccassi@gmail.com>,
 Timothy Redaelli <tredaelli@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a48c730648feab33"
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

--000000000000a48c730648feab33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks David for the CC. We need to rebuild all of our DPDK
container images for the distro build testing etc. which takes some time.
We should be ready early next week.

On Tue, Jan 20, 2026 at 3:32=E2=80=AFAM David Marchand <david.marchand@redh=
at.com>
wrote:

> Hello,
>
> On Fri, 5 Dec 2025 at 13:28, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Fri, Dec 05, 2025 at 12:13:01PM +0000, Bruce Richardson wrote:
> > > The build of DPDK now uses features from version 0.6 of meson, which =
is
> > > greater than the current minimum of 0.57.2. Although these features a=
re
> > > non-critical, they do cause warnings to be emitted on build. Increase
> > > minimum meson version to 0.61 (=3D=3D version in Ubuntu 22.04 LTS) to
> remove
> > > these warnings.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  meson.build | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > With this patch, and the previously submitted patchset for assigning te=
st
> > cases to the various categories/suites, all warnings in the meson
> > configuration stage should now be gone.
> >
> > In terms of the specific version, as noted above I chose the version of
> > meson present in Ubuntu 22.04 as a reasonable baseline. Both debian
> stable,
> > and debian old-stable have newer versions than that in them. For the RH=
EL
> > line, I'm not sure what the baseline is, but I believe that RHEL 8
> shipped
> > originally with a meson version even older than 0.57, so moving to a
> later
> > one I hope doesn't matter. [I wasn't easily able to find out from Googl=
e
> > what the current meson version in RHEL 8/9/10 is]
>
> Cc: Timothy for .rpm distributions, Luca for .deb.
>
> I prefer we get some acks from distributions people.
> Also, this patch requires coordination with the CI guys (as can be
> seen in patchwork, many envs are using old versions of meson).
>
>
> --
> David Marchand
>
>

--000000000000a48c730648feab33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks David for the=C2=A0CC. We need to rebuild all of ou=
r DPDK container=C2=A0images for the distro build testing etc. which takes =
some time. We should be ready early next week.</div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue,=
 Jan 20, 2026 at 3:32=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david=
.marchand@redhat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
On Fri, 5 Dec 2025 at 13:28, Bruce Richardson<br>
&lt;<a href=3D"mailto:bruce.richardson@intel.com" target=3D"_blank">bruce.r=
ichardson@intel.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Dec 05, 2025 at 12:13:01PM +0000, Bruce Richardson wrote:<br>
&gt; &gt; The build of DPDK now uses features from version 0.6 of meson, wh=
ich is<br>
&gt; &gt; greater than the current minimum of 0.57.2. Although these featur=
es are<br>
&gt; &gt; non-critical, they do cause warnings to be emitted on build. Incr=
ease<br>
&gt; &gt; minimum meson version to 0.61 (=3D=3D version in Ubuntu 22.04 LTS=
) to remove<br>
&gt; &gt; these warnings.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Bruce Richardson &lt;<a href=3D"mailto:bruce.richa=
rdson@intel.com" target=3D"_blank">bruce.richardson@intel.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 meson.build | 2 +-<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; With this patch, and the previously submitted patchset for assigning t=
est<br>
&gt; cases to the various categories/suites, all warnings in the meson<br>
&gt; configuration stage should now be gone.<br>
&gt;<br>
&gt; In terms of the specific version, as noted above I chose the version o=
f<br>
&gt; meson present in Ubuntu 22.04 as a reasonable baseline. Both debian st=
able,<br>
&gt; and debian old-stable have newer versions than that in them. For the R=
HEL<br>
&gt; line, I&#39;m not sure what the baseline is, but I believe that RHEL 8=
 shipped<br>
&gt; originally with a meson version even older than 0.57, so moving to a l=
ater<br>
&gt; one I hope doesn&#39;t matter. [I wasn&#39;t easily able to find out f=
rom Google<br>
&gt; what the current meson version in RHEL 8/9/10 is]<br>
<br>
Cc: Timothy for .rpm distributions, Luca for .deb.<br>
<br>
I prefer we get some acks from distributions people.<br>
Also, this patch requires coordination with the CI guys (as can be<br>
seen in patchwork, many envs are using old versions of meson).<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--000000000000a48c730648feab33--
