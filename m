Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2ECE66886
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Dec 2025 05:37:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B11EE402AF;
	Sun, 21 Dec 2025 06:37:30 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id 7038B40296
 for <dev@dpdk.org>; Sun, 21 Dec 2025 06:37:29 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so2321217a34.1
 for <dev@dpdk.org>; Sat, 20 Dec 2025 21:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766295448; x=1766900248; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8mQ9Xco+dQqCkTkEfbbw60Fh+DG3f6THzVByixsNsWY=;
 b=QnUeOHGxSBgkMbeILM5CHcTzfLplcy6fwcwwQ1mPEagdHYjORIE1dz09QTnoORAXz5
 x2LEddM0p6quJAkQNAFrNTexK+unmLah4cbL8wqDb7nqb7z79JQ7BxzYrxUGaJ2fBNlG
 UV2KAZBkcwXdJ1GtWoMZBZws50tjxhSQJxccUgM63aN2i90RaRYDeKz4hN0LqIMfUQFa
 9mSjUxCTmRGp/EUUdBei/gd+ZUqNOJuNb63GV+3nzssQnEWTwyvEG2/TpvOVCxBgs+gZ
 BiVyOjtTuTlJHuOW2LWq3idQjCRSbvX+oDnr2RJkcaDiDFvEuS32g18VabCYpsolIn+a
 S7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766295448; x=1766900248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mQ9Xco+dQqCkTkEfbbw60Fh+DG3f6THzVByixsNsWY=;
 b=a6/rLw5IsDoh3goYjj6oN1zUpeC9WEPB03xfZh5QpnLDZZHWQZunc8WFHaTACGZAci
 XC3jO0NGdxeiolC/RuhOYldwTlKmC42Eg7Ftz6YIJOBFgXHHcbvIcB6GRNJRSAWgBU0I
 z38B8S1Gt/2k6lclZwGof5kMccn8/srI6f70mOS1litgSDynxIM2BxN5vPpnh8ksMIfo
 RfYJg1MZB4HziLKGk78z3MRVKBmafOoE06LG2uf3Qby2lfGDxEBukZOORBtfwJoojMKs
 WKBuc+5OTHmQMo5n8puKimuuc5JBZCF36mPFD6SN/S4951qE9SKZ3jHUhYUHJUACnKsr
 SDgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgjXFd4AReC9ou02RtmwzQiQ4/HME8D8Rklf2AHpkoCI1DAmyxtQkmhKy0szYN97jWv1s=@dpdk.org
X-Gm-Message-State: AOJu0YxHrJkZuTiH81ZYNVxwUZiyP2VQBQO9z93T/Jz240Mwwa0Unumu
 erl9lQEI2KMhKMXEpR3O2H2A7NY0+u9W7OErR4bj8wGxG9Tc1krTXHUVfjEYPX9fDTH1O74Sdid
 hqvs6151q6JEdBqwKXFF3DefnUFUar98=
X-Gm-Gg: AY/fxX6s/Zp0xD7aB9oBrFgb+oSEbm/wliwmKc5qPEeEHR8AO5gfgvEj5ruZAYoXTe5
 0mqZu7uKZapEQc4qzAiOEZcIyWBNc4es8Ju9G1jHyUa/SR9ar2Rz7G6ONgju3KDfwZsgU2KeeQ+
 0VUAc+gdj8MMD+w+Ze6FPf4jVaLLhESoTkMzMm1AmEkivnYRCO3+F8xG88NuKbfZjvksfOVKmkG
 bqAL1ZUwr1zhvC0+11mfsYqkP9ERvJWQVr1YI8Q4al/oIos2V9PCJvGQCBNo2nHwZzdeN6cydLR
 8RcuJcgtIL0zCuAsF1qjXsNAy4ORKw==
X-Google-Smtp-Source: AGHT+IEcyHncRzwrqn36ShyD/YHo4VwJ8lm3RcvX8qjRqKYf8ovAavh7bF/rgyNIF56o8suklXQAvOkIoN3/KE/FJGw=
X-Received: by 2002:a05:6830:3489:b0:7ca:c897:fc5c with SMTP id
 46e09a7af769-7cc66a7f78dmr3872928a34.20.1766295448538; Sat, 20 Dec 2025
 21:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20251212115238.59710-1-madhukar.mythri@gmail.com>
 <DS3PR21MB5735BCEBB4C726C7E0B7AC4DCEA9A@DS3PR21MB5735.namprd21.prod.outlook.com>
 <20251220102503.54d04c5d@phoenix.local>
In-Reply-To: <20251220102503.54d04c5d@phoenix.local>
From: madhukar mythri <madhukar.mythri@gmail.com>
Date: Sun, 21 Dec 2025 11:07:16 +0530
X-Gm-Features: AQt7F2rRtlJJswB87FmMFewUUyZjq_PlzdoMjJbEQu--XdEPAnLF7zn3IvFYbSs
Message-ID: <CAAUNki3mxT3TZNxmiyLYU6zsjXdvCj6ZxCX9QU8Nh7JQ2HV5wA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] net/netvsc: Fix on race condition of multiple
 commands
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>, dev@dpdk.org, 
 Madhuker Mythri <madhuker.mythri@oracle.com>
Content-Type: multipart/alternative; boundary="000000000000c7541006466fb42b"
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

--000000000000c7541006466fb42b
Content-Type: text/plain; charset="UTF-8"

Hi Li and Stephen,

We have a common DPDK application for all the PMD's, in which we are seeing
issue for this Netvsc PMD only.
I mean, for KVM hypervisor with Intel or Mellanox NICs we did not see such
sync issues. Also, with failsafe PMD on hyper-v did not seen such sync
issues.

So, i thought this would be better to fix at PMD level using spinlock.

@Stephen Hemminger <stephen@networkplumber.org> , yes we can store the
device info get details after probe and reuse it later.
For Link-status get with multiple threads we can go with retry mechanism.

However, w.r.t all other PMD's this device info get and Link-status get has
issues in multi threaded application.

Regards,
Madhuker.

On Sat, 20 Dec, 2025, 23:55 Stephen Hemminger, <stephen@networkplumber.org>
wrote:

> On Fri, 19 Dec 2025 17:35:33 +0000
> Long Li <longli@microsoft.com> wrote:
>
> > > When multiple processes issue command requests(like: device info get
> and
> > > link-status) at same-time, then we could see the command request
> failures,
> > > due to race-condition of common function execution.
> >
> > Hi Madhuker,
> >
> > I'm not sure if we should use a lock in the driver for this. It's not
> clear in DPDK documents but in general the calls to query device status are
> not thread safe.
> >
> > Is it possible that the application uses a lock to sync calling to this?
> >
>
> I do not know of any restrictions about threads calling query operations.
>
> For info_get() the transaction is in rndis_get_offload().
> There are couple of ways to handle this better. One would to do
> the query during probe and remember the result. The hypervisor is
> not going to change supported offload. The other and simpler way
> would be to just have hardcoded offload values. The code for query
> got compute offloads is inherited for BSD and unless someone was trying
> to run on Windows 2012 or earlier version of Hyper-V it would never change.
>
> Link status is a little more complex. Does the hyper-visor ever report
> that the software path is down? And reading through the hn_rdis_exec code
> it looks like if multiple operations are in process the second one
> should return -EBUSY. Application could retry in that case.
>

--000000000000c7541006466fb42b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Li and Stephen,<div dir=3D"auto"><br></div><div dir=3D=
"auto">We have a common DPDK application for all the PMD&#39;s, in which we=
 are seeing issue for this Netvsc PMD only.</div><div dir=3D"auto">I mean, =
for KVM hypervisor with Intel or Mellanox NICs we did not see such sync iss=
ues. Also, with failsafe PMD on hyper-v did not seen such sync issues.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">So, i thought this would be =
better to fix at PMD level using spinlock.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><span class=3D"gmail_chip gmail_plusreply" dir=3D"auto">=
<a href=3D"mailto:stephen@networkplumber.org" style=3D"color:#15c;text-deco=
ration:underline">@Stephen Hemminger</a></span><span>=C2=A0, yes we can sto=
re the device info get details after probe and reuse it later.</span></div>=
<div dir=3D"auto"><span>For Link-status get with multiple threads we can go=
 with retry mechanism.</span></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">However, w.r.t all other PMD&#39;s this device info get and Link-stat=
us get has issues in multi threaded application.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Regards,</div><div dir=3D"auto">Madhuker.</div></d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Sat, 20 Dec, 2025, 23:55 Stephen Hemminger, &lt;<a hr=
ef=3D"mailto:stephen@networkplumber.org">stephen@networkplumber.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 19 Dec 2025 17:35:3=
3 +0000<br>
Long Li &lt;<a href=3D"mailto:longli@microsoft.com" target=3D"_blank" rel=
=3D"noreferrer">longli@microsoft.com</a>&gt; wrote:<br>
<br>
&gt; &gt; When multiple processes issue command requests(like: device info =
get and<br>
&gt; &gt; link-status) at same-time, then we could see the command request =
failures,<br>
&gt; &gt; due to race-condition of common function execution.=C2=A0 <br>
&gt; <br>
&gt; Hi Madhuker,<br>
&gt; <br>
&gt; I&#39;m not sure if we should use a lock in the driver for this. It&#3=
9;s not clear in DPDK documents but in general the calls to query device st=
atus are not thread safe.<br>
&gt; <br>
&gt; Is it possible that the application uses a lock to sync calling to thi=
s?<br>
&gt; <br>
<br>
I do not know of any restrictions about threads calling query operations.<b=
r>
<br>
For info_get() the transaction is in rndis_get_offload().<br>
There are couple of ways to handle this better. One would to do<br>
the query during probe and remember the result. The hypervisor is<br>
not going to change supported offload. The other and simpler way<br>
would be to just have hardcoded offload values. The code for query<br>
got compute offloads is inherited for BSD and unless someone was trying<br>
to run on Windows 2012 or earlier version of Hyper-V it would never change.=
<br>
<br>
Link status is a little more complex. Does the hyper-visor ever report<br>
that the software path is down? And reading through the hn_rdis_exec code<b=
r>
it looks like if multiple operations are in process the second one<br>
should return -EBUSY. Application could retry in that case.<br>
</blockquote></div>

--000000000000c7541006466fb42b--
