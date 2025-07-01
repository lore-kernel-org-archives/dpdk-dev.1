Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DBBC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 21:46:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA38D4064F;
	Tue,  1 Jul 2025 23:46:48 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6B82C402BC
 for <dev@dpdk.org>; Tue,  1 Jul 2025 23:46:47 +0200 (CEST)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-708d90aa8f9so63858397b3.3
 for <dev@dpdk.org>; Tue, 01 Jul 2025 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1751406406; x=1752011206; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mACcR2LaMV/xpxHenJKwnvKID063Sblz+xGZuWkPyEA=;
 b=VNFpIoRr+dt7Z6rG0+Rem7qRXZpcLYf4SYHywBOyUOJBKa7hwzTURhK0W0By359rV9
 h/f6ibvmiseh+eWkTMRbz7WduHC4B1cziy3lrbJTKiJ/VC99N2DiveUvxixYaITiSuun
 OtN0CrUSSMUMCdfcdZCsYIcoASRiZADymAehI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751406406; x=1752011206;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mACcR2LaMV/xpxHenJKwnvKID063Sblz+xGZuWkPyEA=;
 b=nzR5ia26hOiblp9GASW168hBoXfSEgfrHQsTQWxLr6NqNTF0eOgHyBuQ5q+dy4sNVd
 Min/Imw2mpi0b/LKwfj+kdU58OmrNrcU2Or4ZSUhaAYhOPPRay+wA5SahUf+Sz5tLKq/
 9MpHxXp9okZmTDpoeDb8h6E/n2LRZsUCwtb52LomGkn+MwHffaHBKEE5//JaQmbRSef7
 kWMYN0eHFObrObAqjbqHfi1rp0PpyFcn/ls1uYhuIIVBaB+/RLcPW72LlbFZwus/O7mY
 pycgSSuEVBcpZDv0lcpdTT12NGx6lUpjJIV2/lc88dAC6ctz9VG634X+llt3ZlJHggRO
 6uiA==
X-Gm-Message-State: AOJu0Yy3GPj5AiqcU1AGIR3u5ah0/bk5635K0ijdfq1pdyjzckHuu67t
 e27sp1r0w7+KqtsHz105hIfvhmGgBHkL16ZiD57dQkOHNv4mXhq4zTaBFFSYRl3tasOxcOVgcGx
 3lXRhP0ozIzb/MT+gmVMx1/BVA5n5h2OvgMoDjxsisX8beeYhHQZN/ZbETQ==
X-Gm-Gg: ASbGnctvIyxvPl4ChUUy07dSAplyPjpfxAMmSPC18ahgiLsLXz6ieYEzsqUp/v0vtcr
 Xc7Eya5wXTo6rbsGj2QjCHDShVz9FIYFyBOv7626lAXTx3aT+cVj9Y4D1O0qN0YZnMZYfA09zZc
 hOPqRNCmn1Mk01Il3wE6wLZE9iky7c1Q4BITXRx/FE/VI=
X-Google-Smtp-Source: AGHT+IGgssztPiEUwpDIz3n+IYZ1LcdTRQ/S+Gw6Wo/rh0wiIR4qXfyvOAt6/zXR7aWacupTg+0IRAVpHHfSOWuwaDY=
X-Received: by 2002:a05:690c:9b10:b0:70e:195:e924 with SMTP id
 00721157ae682-7164d55de16mr4723587b3.36.1751406406399; Tue, 01 Jul 2025
 14:46:46 -0700 (PDT)
MIME-Version: 1.0
From: Nathan Southern <nsouthern@linuxfoundation.org>
Date: Tue, 1 Jul 2025 16:46:35 -0500
X-Gm-Features: Ac12FXyCi58Duo0UTRr4ghafPgbWeeaAwPslZvicRmb6iUHvTrHW3X6YksiKdn8
Message-ID: <CAKoDjhwAeUXsX1Gpxhzw+FsjeymqRw_u9XpvdugBcRCbRs8_DQ@mail.gmail.com>
Subject: Reminder to get your CFP submissions in by this Sunday night - DPDK
 Bay Area Summit
To: dev@dpdk.org, announce@dpdk.org, dpdk-techboard <techboard@dpdk.org>, 
 govboard <govboard@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000b607c90638e5148b"
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

--000000000000b607c90638e5148b
Content-Type: text/plain; charset="UTF-8"

Dear DPDK Community and Boards,

A reminder that our CFP deadline for the 2025 Bay Area Summit at Intel in
Santa Clara, Sep. 17-18, 2025, terms this Sunday, July 6 at 11:59pm Pacific
Time.

You can reach the CFP page here
<https://sessionize.com/dpdk-bay-area-summit-2025/>.

We are also very much interested in panel talks, demos, and Birds of a
Feather sessions to diversify the content. If you're interested in doing
any of the above, please email our lead maintainer, Thomas Monjalon -
thomas@monjalon.net, to share your ideas.

We look forward to receiving and reviewing your remaining submissions.
Thank you for your interest.

Again: let us know if you have any questions.

With appreciation,

Nathan

Nathan C. Southern, Senior Program Coordinator

Data Plane Development Kit (DPDK)

The Linux Foundation

248.835.4812 (mobile)

nsouthern@linuxfoundation.org

--000000000000b607c90638e5148b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear DPDK Community and Boards,</div><div><br></div><=
div>A reminder that our CFP deadline for the 2025 Bay Area Summit at Intel =
in Santa Clara, Sep. 17-18, 2025, terms=C2=A0this Sunday, July 6 at 11:59pm=
 Pacific Time.</div><div><br></div><div>You can reach the CFP page<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0</span><a href=3D"https://sessioni=
ze.com/dpdk-bay-area-summit-2025/" target=3D"_blank">here</a>.=C2=A0</div><=
div><br></div><div>We are also very much interested in panel talks, demos, =
and Birds of a Feather sessions to diversify the content. If you&#39;re int=
erested in doing any of the above, please email our lead maintainer, Thomas=
 Monjalon - <a href=3D"mailto:thomas@monjalon.net">thomas@monjalon.net</a>,=
 to share your ideas.</div><div><br></div><div>We look forward to receiving=
 and reviewing your remaining submissions. Thank you for your interest.</di=
v><div><br></div><div>Again: let us know if you have any questions.</div><d=
iv><br></div><div>With appreciation,</div><div><br></div><div>Nathan</div><=
div><br></div><div><p style=3D"margin:0px;font-stretch:normal;font-size:13p=
x;line-height:normal;font-family:&quot;Helvetica Neue&quot;;font-size-adjus=
t:none;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatu=
res:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-=
feature-settings:normal">Nathan C. Southern, Senior Program Coordinator</p>=
<p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:norma=
l;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning=
:auto;font-variant-alternates:normal;font-variant-ligatures:normal;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-feature-settings:no=
rmal">Data Plane<span class=3D"gmail-Apple-converted-space">=C2=A0</span><s=
pan class=3D"gmail-il">Development</span><span class=3D"gmail-Apple-convert=
ed-space">=C2=A0</span>Kit (DPDK)</p><p style=3D"margin:0px;font-stretch:no=
rmal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quo=
t;;font-size-adjust:none;font-kerning:auto;font-variant-alternates:normal;f=
ont-variant-ligatures:normal;font-variant-numeric:normal;font-variant-east-=
asian:normal;font-feature-settings:normal">The Linux Foundation</p><p style=
=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:normal;font-f=
amily:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-kerning:auto;fo=
nt-variant-alternates:normal;font-variant-ligatures:normal;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-feature-settings:normal">24=
8.835.4812 (mobile)</p><p style=3D"margin:0px;font-stretch:normal;font-size=
:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;font-size-a=
djust:none;font-kerning:auto;font-variant-alternates:normal;font-variant-li=
gatures:normal;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-feature-settings:normal"><a href=3D"mailto:nsouthern@linuxfoundation.or=
g" target=3D"_blank">nsouthern@linuxfoundation.org</a></p></div></div>

--000000000000b607c90638e5148b--
