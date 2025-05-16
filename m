Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343FCC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 18:57:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18A7B402D1;
	Fri, 16 May 2025 20:57:40 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id 47533402CD
 for <dev@dpdk.org>; Fri, 16 May 2025 20:57:39 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7086dcab64bso23506357b3.1
 for <dev@dpdk.org>; Fri, 16 May 2025 11:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1747421858; x=1748026658; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oaziy6iAC/+E6zDLWKJbditkuqw8C4+00mZpLPGn2g4=;
 b=eduU8PbOqyVImyHkG6fti/Z0pVxiH7K7GazhyZeQEAigqe335HsXG6EcPyXzK4dqRd
 BNQXaT+/d9xyFhqkPSUj+BlGgggkQFuuYxqnLhtRuq4mUZxjYSXO8TObzLmOkEL27ITj
 e2JRiDik6JhAIi4sE7YhBjaaQN7ia8a8wHPPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747421858; x=1748026658;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oaziy6iAC/+E6zDLWKJbditkuqw8C4+00mZpLPGn2g4=;
 b=CtED0WvU1Xi805RzIFdqbekRmWDC5+RJ+EocqgD2EphHuEb20ts/BIle/HWBsUrb0P
 LoHArmH0iPx48RoTtnKReG5YKghhpc05gFb/bxiDgQF6pFppfVHxSGr4JmQhKIvoh81g
 aZFGjXoIzWMAn2WJUZcXpBmqahn4bCiXXuMIbJlrBf6F9WwQMVaqAFAd1J2j9XNCQgnh
 GiwfpeyoDPv5+MwndTirczAMtHa3k9AvV91fT1y62eRskQPEDM2Uc1jc+xqkg9Cp2z0f
 aXXX00iS83iUc+laEjfYq6NxsegLVBwyylaeiU228y6KUzOdwP4SzZn3tdnzuhCKF3hS
 gYfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp+ZT2nqPUxCa61HbhPYCT57cL26BSAGE/g4bLzZBIMSb3TGpl/qUojMy5pY721Pz6rPc=@dpdk.org
X-Gm-Message-State: AOJu0YxcoiHzuUz/A++j9plrWBZJPTAwGbJ64Xv1UQ2Oia1eQUf/HlSU
 8Vpn2RyYVcf+dp/eDdFHVLvG0HNFkOeamT5p+VcHMjoUmhCYi0TWcptU4DxDhVHYYvVaSu++eXs
 m9JubkIRxZIcyaKzKNpwUsIFOWHpfAKnkBb2Yao2B95/5duLjTghRZwcJtQ==
X-Gm-Gg: ASbGncuGiDWyN2b85fsVZaGzlnLOWF5KwgmXB7u0b7JtM8NPMOAee3cSetFKbNVO5FR
 hHICNBd6c1rdE9lClUL8OlDus4KPkKKOpNr+cHzNT5+5QTOZdqOC+L6Yh51+PV//26876YBlp6K
 cVEElPIcqGNNb9pGcopi5b3cxQTuHgQ0cB
X-Google-Smtp-Source: AGHT+IFyhcDXUeTeg8CaTJhf9f/JkUeLCR8tF30Z9oxEkcPvQPfLle9mX3yaHoshun93zFupi3QPoF4l/2GIb1LBADI=
X-Received: by 2002:a05:690c:6385:b0:709:1f2d:f89f with SMTP id
 00721157ae682-70ca7bc21c1mr65986827b3.36.1747421858555; Fri, 16 May 2025
 11:57:38 -0700 (PDT)
MIME-Version: 1.0
From: Nathan Southern <nsouthern@linuxfoundation.org>
Date: Fri, 16 May 2025 13:57:27 -0500
X-Gm-Features: AX0GCFs-T5f7igA1EqKd7AoHWkbOT4icqJQXdrxJyl2pbGTTaY-MW3OwNvPsk9E
Message-ID: <CAKoDjhxSyhE-fGeD==mU4SZJpunABp42SEodCXgpGZqTpdznYA@mail.gmail.com>
Subject: DPDK Bay Area Summit - Registration + CFP
To: announce@dpdk.org, dev@dpdk.org
Cc: "O'Driscoll, Tim" <tim.odriscoll@intel.com>,
 Ian Jolliffe <ijolliff@redhat.com>, "Song, Keesang" <keesang.song@amd.com>
Content-Type: multipart/alternative; boundary="00000000000026ffdd0635455bcc"
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

--00000000000026ffdd0635455bcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear DPDK Community Members,



I hope this message finds each of you well.



I=E2=80=99m writing you to announce the CFP launch and open registration fo=
r our
second summit of 2025 - the Bay Area Summit, to be held in Santa Clara, CA,
at Intel=E2=80=99s Mission Blvd campus headquarters on September 17-18, 202=
5.



This will be a hybrid event - live and virtual. Registration can be accesse=
d
 here,
<https://linuxfoundation.regfox.com/2025-bay-area-summit?access_token=3DeyJ=
hbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiaXNzIjoiaHR0cHM6Ly9zc28ubGludXhmb3VuZG=
F0aW9uLm9yZy8ifQ..FdCe2BfXRL2Spqq1.TN1Dc2xUaJ2WPQQmO3iP4V4Q1go89iVMoO9IcfR5=
Ju25B3oBIwL3WMS4p7D-MVk0bX3_W3ECqGBmYsuvolBv4V_BbK8T_feJ8NxhyNslz2LPAWzbWny=
6bwDWcjN0BJufe011BthL8SipQrY4Fuo3VXgeIetIBXWMuRWlsHJODgUO6FTP7XC1y3c02rPO37=
tYHws0vOBi2KHXe4OuVTeU_LsdhX8BH_-sQNSgOKUbUfc-2Rjt85YQOZ9wWHd3DRQn3B2-8ukBk=
ikyDUlTAVs6tIpuZT6OnBIXb56sINx_DFpesGI.3q9xjVFXHpxyOvf3wp1srg>
 and for those who wish to speak at the event, the CFP can be accessed here
<https://sessionize.com/dpdk-bay-area-summit-2025/>.

In-person registration closes at *11:59pm Pacific time on Thu. Sep. 11th.
The CFP closes at 11:59pm Pacific time on Thu., June 19th.*

We look forward to receiving your submissions and registrations, and to
seeing you in Santa Clara.


Warm regards,

Nathan Southern


Nathan C. Southern, Senior Program Coordinator

Data Plane Development Kit (DPDK)

The Linux Foundation

248.835.4812 (mobile)

nsouthern@linuxfoundation.org

--00000000000026ffdd0635455bcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"MsoNormal" style=3D"margin:0in;line-height:nor=
mal;font-size:medium;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span=
 style=3D"font-size:13pt;font-family:AppleSystemUIFont">=C2=A0</span></p><p=
 class=3D"MsoNormal" style=3D"margin:0in;line-height:normal;font-size:mediu=
m;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-size=
:13pt;font-family:AppleSystemUIFont">Dear DPDK Community Members,</span></p=
><p class=3D"MsoNormal" style=3D"margin:0in;line-height:normal;font-size:me=
dium;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-s=
ize:13pt;font-family:AppleSystemUIFont">=C2=A0</span></p><p class=3D"MsoNor=
mal" style=3D"margin:0in;line-height:normal;font-size:medium;font-family:Ca=
libri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-size:13pt;font-famil=
y:AppleSystemUIFont">I hope this message finds each of you well.</span></p>=
<p class=3D"MsoNormal" style=3D"margin:0in;line-height:normal;font-size:med=
ium;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-si=
ze:13pt;font-family:AppleSystemUIFont">=C2=A0</span></p><p class=3D"MsoNorm=
al" style=3D"margin:0in;line-height:normal;font-size:medium;font-family:Cal=
ibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-size:13pt;font-family=
:AppleSystemUIFont">I=E2=80=99m writing you to announce the CFP launch and =
open registration for our second summit of 2025 - the Bay Area Summit, to b=
e held in Santa Clara, CA, at Intel=E2=80=99s Mission Blvd campus headquart=
ers on September 17-18, 2025.</span></p><p class=3D"MsoNormal" style=3D"mar=
gin:0in;line-height:normal;font-size:medium;font-family:Calibri,sans-serif;=
color:rgb(0,0,0)"><span style=3D"font-size:13pt;font-family:AppleSystemUIFo=
nt">=C2=A0</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;lin=
e-height:18.4px;font-size:medium;font-family:Calibri,sans-serif;color:rgb(0=
,0,0)"><span style=3D"font-size:13pt;line-height:19.933334px;font-family:Ap=
pleSystemUIFont">This will be a hybrid event - live and virtual. Registrati=
on can be accessed<span class=3D"gmail-Apple-converted-space">=C2=A0</span>=
<a href=3D"https://linuxfoundation.regfox.com/2025-bay-area-summit?access_t=
oken=3DeyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIiwiaXNzIjoiaHR0cHM6Ly9zc28ubGlu=
dXhmb3VuZGF0aW9uLm9yZy8ifQ..FdCe2BfXRL2Spqq1.TN1Dc2xUaJ2WPQQmO3iP4V4Q1go89i=
VMoO9IcfR5Ju25B3oBIwL3WMS4p7D-MVk0bX3_W3ECqGBmYsuvolBv4V_BbK8T_feJ8NxhyNslz=
2LPAWzbWny6bwDWcjN0BJufe011BthL8SipQrY4Fuo3VXgeIetIBXWMuRWlsHJODgUO6FTP7XC1=
y3c02rPO37tYHws0vOBi2KHXe4OuVTeU_LsdhX8BH_-sQNSgOKUbUfc-2Rjt85YQOZ9wWHd3DRQ=
n3B2-8ukBkikyDUlTAVs6tIpuZT6OnBIXb56sINx_DFpesGI.3q9xjVFXHpxyOvf3wp1srg" st=
yle=3D"color:rgb(149,79,114)">here,</a><span class=3D"gmail-Apple-converted=
-space">=C2=A0</span>and for those who wish to speak at the event, the CFP =
can be accessed<span class=3D"gmail-Apple-converted-space">=C2=A0</span><a =
href=3D"https://sessionize.com/dpdk-bay-area-summit-2025/" style=3D"color:r=
gb(149,79,114)">here</a>.</span></p><p class=3D"MsoNormal" style=3D"margin:=
0in 0in 8pt;line-height:18.4px;font-size:medium;font-family:Calibri,sans-se=
rif;color:rgb(0,0,0)"><span style=3D"font-size:13pt;line-height:19.933334px=
;font-family:AppleSystemUIFont">In-person registration closes at <b>11:59pm=
 Pacific time on Thu. Sep. 11th. The CFP closes at 11:59pm Pacific time on =
Thu., June 19th.</b></span></p><p class=3D"MsoNormal" style=3D"margin:0in 0=
in 8pt;line-height:18.4px;font-size:medium;font-family:Calibri,sans-serif;c=
olor:rgb(0,0,0)"><span style=3D"font-size:13pt;line-height:19.933334px;font=
-family:AppleSystemUIFont">We look forward to receiving your submissions an=
d registrations, and to seeing you in Santa Clara.</span></p><p class=3D"Ms=
oNormal" style=3D"margin:0in 0in 8pt;line-height:18.4px;font-size:medium;fo=
nt-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-size:13p=
t;line-height:19.933334px;font-family:AppleSystemUIFont"><br></span></p><p =
class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:18.4px;font-siz=
e:medium;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"fo=
nt-family:AppleSystemUIFont;font-size:13pt">Warm regards,</span></p><p clas=
s=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-height:18.4px;font-size:me=
dium;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-s=
ize:13pt;line-height:19.933334px;font-family:AppleSystemUIFont">Nathan Sout=
hern</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 8pt;line-heig=
ht:18.4px;font-size:medium;font-family:Calibri,sans-serif;color:rgb(0,0,0)"=
><span style=3D"font-size:13pt;line-height:19.933334px;font-family:AppleSys=
temUIFont"><br></span></p><p style=3D"margin:0px;font-stretch:normal;font-s=
ize:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;font-siz=
e-adjust:none;font-kerning:auto;font-variant-alternates:normal;font-variant=
-ligatures:normal;font-variant-numeric:normal;font-variant-east-asian:norma=
l;font-feature-settings:normal">Nathan C. Southern, Senior Program Coordina=
tor</p><p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-heigh=
t:normal;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-=
kerning:auto;font-variant-alternates:normal;font-variant-ligatures:normal;f=
ont-variant-numeric:normal;font-variant-east-asian:normal;font-feature-sett=
ings:normal">Data Plane Development Kit (DPDK)</p><p style=3D"margin:0px;fo=
nt-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helve=
tica Neue&quot;;font-size-adjust:none;font-kerning:auto;font-variant-altern=
ates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-feature-settings:normal">The Linux Foundatio=
n</p><p style=3D"margin:0px;font-stretch:normal;font-size:13px;line-height:=
normal;font-family:&quot;Helvetica Neue&quot;;font-size-adjust:none;font-ke=
rning:auto;font-variant-alternates:normal;font-variant-ligatures:normal;fon=
t-variant-numeric:normal;font-variant-east-asian:normal;font-feature-settin=
gs:normal">248.835.4812 (mobile)</p><p style=3D"margin:0px;font-stretch:nor=
mal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot=
;;font-size-adjust:none;font-kerning:auto;font-variant-alternates:normal;fo=
nt-variant-ligatures:normal;font-variant-numeric:normal;font-variant-east-a=
sian:normal;font-feature-settings:normal"><a href=3D"mailto:nsouthern@linux=
foundation.org">nsouthern@linuxfoundation.org</a></p><p class=3D"MsoNormal"=
 style=3D"margin:0in 0in 8pt;line-height:18.4px;font-size:medium;font-famil=
y:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-size:13pt;line-h=
eight:19.933334px;font-family:AppleSystemUIFont">




<br class=3D"gmail-Apple-interchange-newline"></span></p></div>

--00000000000026ffdd0635455bcc--
