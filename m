Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF1C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 18:11:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9192410F2;
	Tue,  3 Jun 2025 20:11:25 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5D9E4410F2
 for <dev@dpdk.org>; Tue,  3 Jun 2025 20:11:24 +0200 (CEST)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-70e5e6ab7b8so54543747b3.1
 for <dev@dpdk.org>; Tue, 03 Jun 2025 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1748974283; x=1749579083; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WrYVdUYOCXMB2iQ1EMKzQnlowP2lAFFmQMBymfEdRH8=;
 b=DdrZskJhKyO3xQIdMjAElcelNeiPhUh8x8wuNSVeZiWQUB5BorU08BxuQ4wyTQ9fmk
 xOIgU4cYyxy01/iLPsr7cZUKEVvjMEqlYxwbz5wLEQYcHlbu2p3OSJbMefuuPBmeA9JY
 f2PCpa4iK0nXjisn5N0S4tmyJSxjbeX4jYh24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748974283; x=1749579083;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WrYVdUYOCXMB2iQ1EMKzQnlowP2lAFFmQMBymfEdRH8=;
 b=AC77vxFFO9bm9lnd4eqczZcC4pKFmQbzQaAD+M8riQf703UJAyV6VT6Q5Y0r5cluxn
 mD7MHrm6iBeZtG7GG6ZGVOrnfcjDTmaBhepUfRFCKINweASuGoAebp0q7hQK/ZDZ+XEY
 JWmumHiHzgc3Hc3jXTlWGldtHsT52TYlC/ZtVvMTX0keT5hxpoLo1NwRc57fd2IGaA8e
 fBM8oz9XaYAAMDQ5NkKXexsDr8SMyUcYsy5xMvR3TEo1Jsy/B/wVJojDDDDsWdRXMiWM
 wPMtfn5Uyre/isugMTpV3S78gceJbwt6Ryjhr0uKIh8TlQXAL8OZe12wfRVqWcGbIlAc
 JxpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSerCAKifxlcSdctmadHYl5BY56E9Xz/WQfFpfYFPxWDDbfHBTWToVWUPXr0ou6H+RWEI=@dpdk.org
X-Gm-Message-State: AOJu0YzaBHcAi+80XUZooDbmSkZDG3zTGpuCJKG1krg9otTnFkueXZXU
 HEZI+Vl/GJn47l0uCiyPjANnbCRa53H1x7hzeZH3xYb9T30Nt59wUzsh6VQwl21YUXl47UfG1Eu
 gkgbwAaIsajneIc1zNbM263KClsdG8Hur2Y+jjTHQPw==
X-Gm-Gg: ASbGncvMhI10D0pL7tEJd3aq2pFiERKHLWbhg5K8KJsIIR+Nx3gn4R1JvlpdmOtA2a+
 9fQzUrEOf6kjCUF61mXD52G59PcQb2os0nSmSwT+atrq+bnxG71tEPL/hHGUnnf2j0ql6Ii5/Nr
 8tdaNxKJuKooKHkHQIXJwkBgnyjd2Tvpbh
X-Google-Smtp-Source: AGHT+IFGOyyUGu8uDTgnLVLZWSu1VFTiTLn0lZA3cKwtgAixPxvmTwvYdNPtNbTDyPVJN1qg0oNMqF+/1Qo/QVh7T5M=
X-Received: by 2002:a05:690c:6e12:b0:70e:21be:a6c5 with SMTP id
 00721157ae682-70f97f2a942mr285472237b3.26.1748974283534; Tue, 03 Jun 2025
 11:11:23 -0700 (PDT)
MIME-Version: 1.0
From: Nathan Southern <nsouthern@linuxfoundation.org>
Date: Tue, 3 Jun 2025 13:11:12 -0500
X-Gm-Features: AX0GCFuGfotEYReCfIWoYvm0KdTJIwx9GoC_vHd_xxviR2zcwsp_r7YBYubSxx4
Message-ID: <CAKoDjhyzhkv+p-=2m0CjkPymNxdc2XBx8hbH0j5hjbk2CFVNrQ@mail.gmail.com>
Subject: Santa Clara Bay Area Summit - DPDK - reminder to submit to our CFP -
 17 days remaining
To: govboard <govboard@dpdk.org>, dpdk-techboard <techboard@dpdk.org>,
 dev@dpdk.org, announce@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e4464c0636aeceb2"
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

--000000000000e4464c0636aeceb2
Content-Type: text/plain; charset="UTF-8"

Dear DPDK Community,

This is a reminder that if you are interested in speaking at the Bay Area
Summit at Intel's headquarters in Santa Clara CA, from Sep. 17-18, *you
have 17 more days to do your CFP submissions.*

This will be a hybrid live-virtual event and virtual sessions are fine for
those unable to travel to the states.

When you get a chance please visit this link
<https://sessionize.com/dpdk-bay-area-summit-2025/> to do your
submissions.  The deadline is *June 19th at 11:59pm Pacific Time.*

We look forward to hearing from you

Many thanks,

Nathan

Nathan C. Southern, Senior Program Coordinator

Data Plane Development Kit (DPDK)

The Linux Foundation

248.835.4812 (mobile)

nsouthern@linuxfoundation.org

--000000000000e4464c0636aeceb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Dear DPDK Community,</div><div><br></div><div>Thi=
s is a reminder that if you are interested in speaking at the Bay Area Summ=
it at Intel&#39;s headquarters in Santa Clara CA, from Sep. 17-18, <b>you h=
ave 17 more days to do your CFP submissions.</b></div><div><b><br></b></div=
><div>This will be a hybrid live-virtual event and virtual sessions are fin=
e for those unable to travel to the states.=C2=A0</div><div><br></div><div>=
When you get a chance please visit <a href=3D"https://sessionize.com/dpdk-b=
ay-area-summit-2025/">this link</a>=C2=A0to do your submissions.=C2=A0 The =
deadline is <b>June 19th at 11:59pm Pacific Time.</b>=C2=A0</div><div><br><=
/div><div>We look forward to hearing from you</div><div><br></div><div>Many=
 thanks,</div><div><br></div><div>Nathan</div><div><br></div><div><p style=
=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:normal;font-f=
amily:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;fo=
nt-variant-alternates:normal;font-variant-ligatures:normal;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-feature-settings:normal">Na=
than C. Southern, Senior Program Coordinator</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">Data Plane Development Kit (DPDK)</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">The Linux Foundation</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">248.835.4812 (mobile)</p>
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal"><a href=3D"mailto:nsouthern@linuxfoundation.org">nsouthern@linuxfound=
ation.org</a></p></div><div><br></div></div>

--000000000000e4464c0636aeceb2--
