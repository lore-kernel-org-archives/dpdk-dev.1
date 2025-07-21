Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A08AC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 16:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0F82402DC;
	Mon, 21 Jul 2025 18:02:20 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id C62E140297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 18:02:18 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3138e64b42aso4708746a91.0
 for <dev@dpdk.org>; Mon, 21 Jul 2025 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753113738; x=1753718538; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lD2d0NLitjn/v11HEV3od+rJjyrInSUnctDBK3mW0UE=;
 b=WC5SkHfhDcyMQ+XmvYDietwltSZ2tJ1Kw8yUCVoltDRQ+VrrZQERDLGqrkNJJYjmw+
 mj73zVlqByVs9S0H/HRQZErlhDygS83Dz8hbbfkkCtC0aiFxh1AVFgI2doiSZRz5hi6z
 rINHwFtWqPX9pgufVizT54XzeCJ1isRbUORnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753113738; x=1753718538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lD2d0NLitjn/v11HEV3od+rJjyrInSUnctDBK3mW0UE=;
 b=KfLtZcfwfWpRfOn5jq+3WqRR1+Ew5SXqg63HWCsRx2oxCrHieOSBY065njUE++S4JN
 wHLQuN6/bwvXObtOtarinNTIV/Cd5qXC/i8E5Q9yTWyKMqYFwCOAwdn3ZaBx7GA7J3ud
 kUWd0SUF/T2R9QxEW6S8JdoNhK0k3vwEyPfE4qLL+7beLRJPWjgOIAlURDcZ5WqhoPr3
 G86uVp31t4hF2DSeSFCLc47BwOdoIlPDr1YHHsNN8vPRDhhPPm5yPg4EH7UPAI52OoFx
 P1J3QYx/7z9Gn1CjhcilZPFT8WfEboGqooCMKX4dGlojwOITDo1Cy3jxe2DoVHulBfaC
 j2rw==
X-Gm-Message-State: AOJu0YyagXbK5ftU0UXP0azDL3YE0r8Qm0bMWQfcdBampa3MaR13VUX4
 eSFH5SRzAXLQmJ2o+F0fCfe3gNfF5mGu1W3WVHk632QF405EC++FurM5YBPNYxUJAjp/R27efc1
 xU/UxivPrXTBJLgWLBUXPnkYT50EzC+AlRFCLbnmyhw==
X-Gm-Gg: ASbGncsPZ0KJCOoRFH0QoZGddS34M1ncoRfCvgseNNhHl8rjKIHUkS9V2MHNS8Swiod
 9HyqeoKdPbJ1RcRKw4Q9JADiioePyRjn/NVo/jEJJGxQkSUpoeibs0pZhQdRFtOwbxPhGr6dcJw
 XzdgEMME878rx7S/ZNN8fkjZcbT/lkTHtkcDApQNHR6exx5lMGK2HUJPtOx/oaOcfTZhR56esOD
 A7DJJgtKOhXPyZpfoZjIQ==
X-Google-Smtp-Source: AGHT+IHnDKa7hGrRcsV2w4uycxAn5MfVdKugPUd/srqhKb5nBZwyr5IXQKP4oK0nd+WfrFRWivJHgrL+RkiI41uC75E=
X-Received: by 2002:a17:90b:278a:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-31caf8ef3f3mr23144886a91.23.1753113732841; Mon, 21 Jul 2025
 09:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <543e940a-6990-4cdb-a5eb-e036485a16e6@arm.com>
In-Reply-To: <543e940a-6990-4cdb-a5eb-e036485a16e6@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 21 Jul 2025 11:56:15 -0400
X-Gm-Features: Ac12FXwDC7CocmpWbTMzx4gCiiWezWiDbDC7JD8kInINZs3HKGcdo0JkqzsDJdo
Message-ID: <CAJvnSUA8=a=piyz9+j10K_naqqdaHKyn=nT=4__d1YiAsQSOXQ@mail.gmail.com>
Subject: Re: [RFC] Proposal for stable developer-friendly DTS API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, nd@arm.com
Content-Type: multipart/alternative; boundary="0000000000004c2008063a729926"
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

--0000000000004c2008063a729926
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 2:57=E2=80=AFAM Paul Szczepanek <paul.szczepanek@ar=
m.com>
wrote:

> Hi all,
>
> Now that we've written a significant number of tests and developed a
> consistent usage pattern, I think it's a good time to take the next step
> toward project maturity: establishing a stable, well-defined API that
> developers can rely on across releases.
>

Agree


>
> We got some comments from the devs present at the last DPDK summit and
> they are valuable guidance on what direction you'd like the framework to
> go and we're taking them onboard to shape our roadmap. Very much related
> to that we'd appreciate any comments on what you'd like to see in the API=
.
>
> API proposal goal
>
> Split framework internals from functions intended for use by test writers=
.
>
> This API would offer:
> - Discoverability of available functionality
> - Clear boundaries between public/test-facing APIs and internal
> framework logic
> - A stable interface for writing and maintaining tests
> - A DPDK-style release cadence and compatibility guarantee (i.e., write
> once, run future-proof)
>

The notes about making the API stable make sense:
1. So, is there a suggestion here that the API can be broken once per year,
and that would be a new policy? Would that happen at a .11 release with
your proposal?
2. I assume I can add functions to a DTS API module, but cannot
remove/change existing ones during a stable period?
3. I guess we can either have reviews and maintainer review enforce the API
stability, or we can develop some checks that will try to enforce the API
stability. Do you have a preference?


>
> With this split, DTS becomes effectively self-documenting =E2=80=94 users=
 can
> explore and use only what=E2=80=99s in the api.
>
> Technical Summary
>
> Introduce a dedicated api/ directory that contains a small, focused set
> of modules exposing all the functionality needed to write tests.
>
> All test execution logic and framework internals will remain private and
> continue to live in framework/, where we can iterate freely without
> breaking user tests.
>

Sounds good.


>
> The new api/ modules will be stateless, accessing test context via
> get_ctx().
>
> Users will import only what they need:
>
> > from api import dts, tg, sut
>
> and use it as module functions
>
> > tg.send_packet(...)
> > dts.verify(...)
> > testpmd =3D sut.testpmd_create(...)
>
> Because the modules are stateless and the context is already managed by
> the runner, the changes to the existing framework will be minimal.
>
> Initially, we=E2=80=99ll have three modules in api/: dts, tg, and sut. Th=
is can
> grow as needed.
>

Makes sense, although I think (and hope) it will not need to grow much.
Keeping in mind that we we want the journey from "not knowing DTS" to
"having written a testsuite" to be as short as possible.


>
> The goal of this approach is to provide a clean, intuitive developer
> experience when doing API calls, with logical namespacing and good IDE
> support for discoverability and usability.
>
> Next Steps
>
> Feedback is very welcome =E2=80=94 feel free to reply here or on our slac=
k
> channel #dts-dev. If you would like to join an upcoming DTS meeting on
> Thursday to discuss this live send us and email (or ask on slack) to get
> an invite.
>
> After initial discussions I will send a small RFC patch with framework
> changes only allowing further comments.
>
> I will follow up with a V1 patch introducing the new API and updating
> all existing tests to use it.
>
> Thanks for reading! I'm excited about getting DTS in more hands and hope
> this will make it even easier for contributors and users to write
> robust, maintainable tests.
>
> Kindest regards,
> Paul
>

--0000000000004c2008063a729926
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 15,=
 2025 at 2:57=E2=80=AFAM Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepa=
nek@arm.com">paul.szczepanek@arm.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
Now that we&#39;ve written a significant number of tests and developed a<br=
>
consistent usage pattern, I think it&#39;s a good time to take the next ste=
p<br>
toward project maturity: establishing a stable, well-defined API that<br>
developers can rely on across releases.<br></blockquote><div><br></div><div=
>Agree</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
We got some comments from the devs present at the last DPDK summit and<br>
they are valuable guidance on what direction you&#39;d like the framework t=
o<br>
go and we&#39;re taking them onboard to shape our roadmap. Very much relate=
d<br>
to that we&#39;d appreciate any comments on what you&#39;d like to see in t=
he API.<br>
<br>
API proposal goal<br>
<br>
Split framework internals from functions intended for use by test writers.<=
br>
<br>
This API would offer:<br>
- Discoverability of available functionality<br>
- Clear boundaries between public/test-facing APIs and internal<br>
framework logic<br>
- A stable interface for writing and maintaining tests<br>
- A DPDK-style release cadence and compatibility guarantee (i.e., write<br>
once, run future-proof)<br></blockquote><div><br></div><div>The notes about=
 making the API stable make sense:</div><div>1. So, is there a suggestion h=
ere that the API can be broken once per year, and that would be a new polic=
y? Would that happen at a .11 release with your proposal?</div><div>2. I as=
sume I can add functions to a DTS API module, but cannot remove/change exis=
ting ones during a stable period?</div><div>3. I guess we can either have r=
eviews and maintainer review enforce the API stability, or we can develop s=
ome checks that will try to enforce the API stability. Do you have a prefer=
ence?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
With this split, DTS becomes effectively self-documenting =E2=80=94 users c=
an<br>
explore and use only what=E2=80=99s in the api.<br>
<br>
Technical Summary<br>
<br>
Introduce a dedicated api/ directory that contains a small, focused set<br>
of modules exposing all the functionality needed to write tests.<br>
<br>
All test execution logic and framework internals will remain private and<br=
>
continue to live in framework/, where we can iterate freely without<br>
breaking user tests.<br></blockquote><div><br></div><div>Sounds good.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The new api/ modules will be stateless, accessing test context via<br>
get_ctx().<br>
<br>
Users will import only what they need:<br>
<br>
&gt; from api import dts, tg, sut<br>
<br>
and use it as module functions<br>
<br>
&gt; tg.send_packet(...)<br>
&gt; dts.verify(...)<br>
&gt; testpmd =3D sut.testpmd_create(...)<br>
<br>
Because the modules are stateless and the context is already managed by<br>
the runner, the changes to the existing framework will be minimal.<br>
<br>
Initially, we=E2=80=99ll have three modules in api/: dts, tg, and sut. This=
 can<br>
grow as needed.<br></blockquote><div><br></div><div>Makes sense, although I=
 think (and hope) it will not need to grow much. Keeping in mind that we we=
 want the journey from &quot;not knowing DTS&quot; to &quot;having written =
a testsuite&quot; to be as short as possible.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
The goal of this approach is to provide a clean, intuitive developer<br>
experience when doing API calls, with logical namespacing and good IDE<br>
support for discoverability and usability.<br>
<br>
Next Steps<br>
<br>
Feedback is very welcome =E2=80=94 feel free to reply here or on our slack<=
br>
channel #dts-dev. If you would like to join an upcoming DTS meeting on<br>
Thursday to discuss this live send us and email (or ask on slack) to get<br=
>
an invite.<br>
<br>
After initial discussions I will send a small RFC patch with framework<br>
changes only allowing further comments.<br>
<br>
I will follow up with a V1 patch introducing the new API and updating<br>
all existing tests to use it.<br>
<br>
Thanks for reading! I&#39;m excited about getting DTS in more hands and hop=
e<br>
this will make it even easier for contributors and users to write<br>
robust, maintainable tests.<br>
<br>
Kindest regards,<br>
Paul<br>
</blockquote></div></div>

--0000000000004c2008063a729926--
