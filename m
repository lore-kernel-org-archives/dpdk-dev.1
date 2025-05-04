Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB77AC369DC
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 May 2025 21:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A82B402A8;
	Sun,  4 May 2025 23:22:25 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 686AE40156
 for <dev@dpdk.org>; Sun,  4 May 2025 23:22:23 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2295d78b433so36071265ad.2
 for <dev@dpdk.org>; Sun, 04 May 2025 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1746393742; x=1746998542; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uDBK6KDEOW1SL9TGKZp2Jr5owXTfEEtFCn2X9gE0dsY=;
 b=aSFvZb+lg6iZD22jS0l9hcrbGl0F3t1Hdmud9bEjLJz9KmZs9w52Hv2flM2n4334q5
 rgo8hE8e8K2PM3vhNAZQIyL6I5XStTKsCeS2dSXqfUSLmvOTJdhpaLjUOGrbFx/QSje6
 qOmiyEVSNghkK0W/FQNmHYHoLBv+N5CRWQvfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746393742; x=1746998542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uDBK6KDEOW1SL9TGKZp2Jr5owXTfEEtFCn2X9gE0dsY=;
 b=IPhn/vbSM31Se4rCJNPqBnzub/440Aovdi13EojXf+wUuSy7KcPJDyyw93rieMCMLe
 SjCV9qgRJKJxfVp/ZTd62u4lJvJBBE7MMp+ghEIXdLFnosk8z6nGiNOoJM2dP3sb0ujN
 WbuUIOQ7NnpCmJNaglv4+knpgW+B9nnltvl6eNbynjwUsoAa0AdVWXLaSla6f6mujMrV
 W/n50yehYejLdHNFLXkguD1/2yqHZFwmEYKzDgqRn1gxmTgQgOVRs8L0//91OQDgHWeU
 TSe9ZVkx3rccePJx5qOMOnazrr8e2T100Hin5FhOpYsWWvRjczJJM8WYSDZ1NEarV5Xq
 JG2g==
X-Gm-Message-State: AOJu0Yx748MIvsgAgX0sYiNfswA2hc4p4+O9sEVXC3EtVivmkZL220Aw
 iuUnWHgaymAzIvs3TZ+r8XVZqeIYcJVK3qLW1iqZ7AjDJ+H5xyYaWioEdxW37BZIx2Y4TiyeU3P
 xWN68W95QXF7ZsuTin6EAhCBx3qbpgq69h6O3LA==
X-Gm-Gg: ASbGnctxcfyb40odN7YIxTdgkhl5eFUVCzkvw+NKH8xjlWj5fwqLv/MYgaQ1dHI9Hg4
 CqxDFlAptxFajOGNCDVb+2RCFttTg2eEdUs14cnfrFTcRSn768zjceR+G7wTC128jiI5rpZ+Lw3
 TI1f797IRGTcXcVDpyZU4VCjqLywtKbthdhryVP5HNO0ha7xxwq+nbqsA=
X-Google-Smtp-Source: AGHT+IH9I0eqW85i0Ut5W9aCZVyUMcalsIuHGQ3qn1QKp9SRDC1bUc1ls4hOgO+kn5PrfJITLVggsSOk01WmcvwZSD4=
X-Received: by 2002:a17:902:e750:b0:224:1221:1ab4 with SMTP id
 d9443c01a7336-22e1e8e686bmr82391045ad.22.1746393742538; Sun, 04 May 2025
 14:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
In-Reply-To: <20250502151134.536799-1-bruce.richardson@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 4 May 2025 17:17:49 -0400
X-Gm-Features: ATxdqUEB-kKclZvcFyNGEE8Mr3MpM__gVP9Z_4pvfYWIaTgvLr-B84DQvkEyYEg
Message-ID: <CAJvnSUCCtrzXMKALi6UpnpMD__M1Y+T3z8de+3TFNPJqE+LS-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] rework and expand EAL lcore options
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, mb@smartsharesystems.com, 
 stephen@networkplumber.org
Content-Type: multipart/alternative; boundary="000000000000a98b13063455fa89"
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

--000000000000a98b13063455fa89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard the Community Lab DTS failure just reported on this
patchseries. I need to reconfigure the testbed and rerun the test.

On Fri, May 2, 2025 at 11:11=E2=80=AFAM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

> Following discussion earlier on this thread on the previous RFCs and
> patches submitted [1], this series is a slightly different take on
> solving the same fundamental problem - making it easy to use CPU cores
> with ids >=3D RTE_MAX_LCORE, without having massive amounts of code
> complexity internally. As previously discussed[2] this patchset
> implements proposal "2a" and does the following:
>
> * marks the old coremask parameter (-c) and service core mask (-s) as
>   deprecated, so they can be dropped in future. Everything should now be
>   done using core lists where possible.
> * consolidates the, previously separate but similar, "-l" and "--lcores"
>   flags into just short and long versions of the same thing. This does
>   not affect the "--lcores" flag at all, but expands the scope of what
>   was possible with "-l".
> * a new flag, with long/short versions, is added as "-L" to allow the
>   user to just specify a range or set of physical CPU core ids to be
>   used by the app, and have them automatically mapped internally to a
>   set of lcore ids starting at 0. This provides the "easy solution" to
>   the original problem stated above.
>
> For completeness, since it's in the same area, the previously separate
> documentation patch, adding examples for the "--lcores" parameter, is
> rolled into this series as patch 3.
>
> [1] https://patches.dpdk.org/project/dpdk/list/?series=3D34911&state=3D*
> [2]
> https://inbox.dpdk.org/dev/Z_PIBLQIT3eu6Ab3@bricha3-mobl1.ger.corp.intel.=
com/#t
>
> Bruce Richardson (4):
>   eal: deprecate old coremask-based EAL parameters
>   eal: merge corelist and core mapping options
>   doc: provide examples of using lcores EAL parameter
>   eal: add option for auto-mapping cpu ids to low lcore ids
>
>  doc/guides/eventdevs/dlb2.rst                 |   6 +-
>  doc/guides/faq/faq.rst                        |   8 +-
>  doc/guides/linux_gsg/build_sample_apps.rst    |   7 +-
>  doc/guides/linux_gsg/eal_args.include.rst     |  61 ++++--
>  .../prog_guide/env_abstraction_layer.rst      |   3 +-
>  doc/guides/prog_guide/meson_ut.rst            |   2 +-
>  doc/guides/prog_guide/multi_proc_support.rst  |   2 +-
>  doc/guides/prog_guide/service_cores.rst       |   8 +-
>  doc/guides/rel_notes/deprecation.rst          |  10 +
>  doc/guides/sample_app_ug/ip_frag.rst          |   7 +-
>  doc/guides/sample_app_ug/ip_reassembly.rst    |   7 +-
>  doc/guides/sample_app_ug/multi_process.rst    |  14 +-
>  doc/guides/sample_app_ug/qos_scheduler.rst    |   2 +-
>  doc/guides/sample_app_ug/test_pipeline.rst    |   2 +-
>  doc/guides/tools/testbbdev.rst                |   2 +-
>  lib/eal/common/eal_common_options.c           | 202 +++++++-----------
>  lib/eal/common/eal_options.h                  |   6 +-
>  lib/eal/windows/include/sched.h               |   1 +
>  18 files changed, 168 insertions(+), 182 deletions(-)
>
> --
> 2.45.2
>
>

--000000000000a98b13063455fa89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please disregard the Community Lab DTS failure just=C2=A0r=
eported on this patchseries. I need to reconfigure the testbed and rerun th=
e test.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, May 2, 2025 at 11:11=E2=80=AFAM Bruce=
 Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com">bruce.richard=
son@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Following discussion earlier on this thread on the previous RF=
Cs and<br>
patches submitted [1], this series is a slightly different take on<br>
solving the same fundamental problem - making it easy to use CPU cores<br>
with ids &gt;=3D RTE_MAX_LCORE, without having massive amounts of code<br>
complexity internally. As previously discussed[2] this patchset<br>
implements proposal &quot;2a&quot; and does the following:<br>
<br>
* marks the old coremask parameter (-c) and service core mask (-s) as<br>
=C2=A0 deprecated, so they can be dropped in future. Everything should now =
be<br>
=C2=A0 done using core lists where possible.<br>
* consolidates the, previously separate but similar, &quot;-l&quot; and &qu=
ot;--lcores&quot;<br>
=C2=A0 flags into just short and long versions of the same thing. This does=
<br>
=C2=A0 not affect the &quot;--lcores&quot; flag at all, but expands the sco=
pe of what<br>
=C2=A0 was possible with &quot;-l&quot;.<br>
* a new flag, with long/short versions, is added as &quot;-L&quot; to allow=
 the<br>
=C2=A0 user to just specify a range or set of physical CPU core ids to be<b=
r>
=C2=A0 used by the app, and have them automatically mapped internally to a<=
br>
=C2=A0 set of lcore ids starting at 0. This provides the &quot;easy solutio=
n&quot; to<br>
=C2=A0 the original problem stated above.<br>
<br>
For completeness, since it&#39;s in the same area, the previously separate<=
br>
documentation patch, adding examples for the &quot;--lcores&quot; parameter=
, is<br>
rolled into this series as patch 3.<br>
<br>
[1] <a href=3D"https://patches.dpdk.org/project/dpdk/list/?series=3D34911&a=
mp;state=3D*" rel=3D"noreferrer" target=3D"_blank">https://patches.dpdk.org=
/project/dpdk/list/?series=3D34911&amp;state=3D*</a><br>
[2] <a href=3D"https://inbox.dpdk.org/dev/Z_PIBLQIT3eu6Ab3@bricha3-mobl1.ge=
r.corp.intel.com/#t" rel=3D"noreferrer" target=3D"_blank">https://inbox.dpd=
k.org/dev/Z_PIBLQIT3eu6Ab3@bricha3-mobl1.ger.corp.intel.com/#t</a><br>
<br>
Bruce Richardson (4):<br>
=C2=A0 eal: deprecate old coremask-based EAL parameters<br>
=C2=A0 eal: merge corelist and core mapping options<br>
=C2=A0 doc: provide examples of using lcores EAL parameter<br>
=C2=A0 eal: add option for auto-mapping cpu ids to low lcore ids<br>
<br>
=C2=A0doc/guides/eventdevs/dlb2.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
=C2=A0doc/guides/faq/faq.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
=C2=A0doc/guides/linux_gsg/build_sample_apps.rst=C2=A0 =C2=A0 |=C2=A0 =C2=
=A07 +-<br>
=C2=A0doc/guides/linux_gsg/eal_args.include.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
61 ++++--<br>
=C2=A0.../prog_guide/env_abstraction_layer.rst=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A03 +-<br>
=C2=A0doc/guides/prog_guide/meson_ut.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0doc/guides/prog_guide/multi_proc_support.rst=C2=A0 |=C2=A0 =C2=A02 +-=
<br>
=C2=A0doc/guides/prog_guide/service_cores.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A08 +-<br>
=C2=A0doc/guides/rel_notes/deprecation.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 10 +<br>
=C2=A0doc/guides/sample_app_ug/ip_frag.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A07 +-<br>
=C2=A0doc/guides/sample_app_ug/ip_reassembly.rst=C2=A0 =C2=A0 |=C2=A0 =C2=
=A07 +-<br>
=C2=A0doc/guides/sample_app_ug/multi_process.rst=C2=A0 =C2=A0 |=C2=A0 14 +-=
<br>
=C2=A0doc/guides/sample_app_ug/qos_scheduler.rst=C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +-<br>
=C2=A0doc/guides/sample_app_ug/test_pipeline.rst=C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +-<br>
=C2=A0doc/guides/tools/testbbdev.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0lib/eal/common/eal_common_options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 202 +++++++-----------<br>
=C2=A0lib/eal/common/eal_options.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
=C2=A0lib/eal/windows/include/sched.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A018 files changed, 168 insertions(+), 182 deletions(-)<br>
<br>
--<br>
2.45.2<br>
<br>
</blockquote></div>

--000000000000a98b13063455fa89--
