Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C065C021A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 07:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DCE6402A3;
	Thu, 13 Feb 2025 08:32:08 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 8E242402A3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 07:28:44 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2fc0bd358ccso1206475a91.2
 for <dev@dpdk.org>; Wed, 12 Feb 2025 22:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739428123; x=1740032923; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qGWHZ6D7Kj7ZUh+ZPoE8uMbM0Y1phVoObAtNJKzzh0Y=;
 b=Fm4v8z1QeEd3uiU6t0qkV+IWRe7kvFmKVLs4ju1S5v07/pRKgkTBX1YnN3Lw3jXbwY
 fXvdXD0Spuf+peYHlzvvn5IKpBat7DvulIov4udTPsKYhp5I9OAZEO5dQIBdbR83G+3a
 eunQcFB3xUmKJwLFvjhDiQKJiKTCFPIOO5G1DpT/u26nWfk09FXUKIEMCUrB4w+PBFlS
 l+PK4Dvrui/RgCQPzXFYOI+ely9tFMWr/foq6EMgT7VX0Aguh0+Zrby1H6tEeNtN4Uy+
 z2NUjD/F+noG/sA6p0ORZyCyqIhZUbo2EaPyp5qAYqIyXUhyyqtxU3xfFbDqRFURPBcy
 Kwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739428123; x=1740032923;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qGWHZ6D7Kj7ZUh+ZPoE8uMbM0Y1phVoObAtNJKzzh0Y=;
 b=RLQcUjy5m4Gfxzs2bIfAsTlYeDPbV/eTVv5uodNal6HMZHphBPH7w7o7h0JpJy8iGz
 m2/+FMCLv8uN6fY4grh/Uy+5Nzop+pC/O6HxkyY1Uy/V6JRuDS27+iWPQB+fcpyhQjfe
 9G/65C3n7KLVY16ZszRIBcvChX6eSckqCBDhAuh0orefMOS7ayahyQ7B+4XJmjix5BRp
 Yq5AnsiS/qQ1pzIJ0+8YLmeL67BJAmLad5Yc+k6uqTgQLmNL4cjHqprWNvLuTbRlkpj1
 k4zRAh42JK47wY60GpxghrbrSFN7PzXmcahT13uaPBvdFFUlGtX9sWypxZR5Z1Zki86P
 Ii2g==
X-Gm-Message-State: AOJu0YxaDLug2DwYkP4KGjwPq+EoT/yIxN9Ch/TrlP3skPXRnAbbd/Ou
 fZwjfaGTaEjI9Wex/lBTtOW9GTumdAc9ARisSOi5yMKAapy9f++Ee/l05tB5bG9mHd+1KMq4zTm
 g1jdQuu8AHxCWeoRmk7ftIAGe8NrihQyU
X-Gm-Gg: ASbGnctD1PEjtRDa86DwFRifXYCQZD95atLc8nCY7rulwkqj71woQXGc0CgwLY5w3uR
 +hEEiV2thalD0C7m0Tp0TWxS2DXX5lrcWonen4MOSrOWGeAdROW5bIGoG1zfImmOOPAgt+Gli
X-Google-Smtp-Source: AGHT+IHxTirdiVW9qAu+kcQFXDKEWO8Q55i14G8+zGKIoAEAuYhjw+W9OE0RovLyozVAAGo22Tr9QowhY3NGY75Pqpc=
X-Received: by 2002:a05:6a20:431b:b0:1ee:6032:b1e9 with SMTP id
 adf61e73a8af0-1ee6b360aa3mr3871281637.21.1739428123341; Wed, 12 Feb 2025
 22:28:43 -0800 (PST)
MIME-Version: 1.0
From: Dilshodjon Mamadaliev <mamadalievdilshodjon@gmail.com>
Date: Thu, 13 Feb 2025 11:28:34 +0500
X-Gm-Features: AWEUYZm4dkAjb6cRVbnN-CfZpurpjrDDzwFUQutt4infMsvHETkxQUHeq03MLhg
Message-ID: <CALsJrKDNmgDjFqG2=eGYQ6uQNrnMkcyz7-pJ6Z6uctPJHsWxQw@mail.gmail.com>
Subject: Inquiry on DPDK Support for Marvell AQtion 10Gbit Network Adapter
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000678269062e002bcb"
X-Mailman-Approved-At: Thu, 13 Feb 2025 08:32:07 +0100
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

--000000000000678269062e002bcb
Content-Type: text/plain; charset="UTF-8"

Dear DPDK Development Team,

I hope this email finds you well. I am reaching out to inquire about *DPDK
support for the Marvell AQtion 10Gbit Network Adapter* on my system.

I am working on a *DPDK-based project* and considering integrating the *Marvell
AQtion 10Gbit NIC*.
*System Details:*

   - *Motherboard:* ASUS ProArt Z790 Creator WiFi
   - *Ethernet Interfaces:*
      - *1st Interface:* Intel(R) Ethernet Controller I226-V (2.5 Gbit)
      - *2nd Interface:* Marvell AQtion 10Gbit Network Adapter
   - *DPDK Setup:*
      - Installed DPDK and *vfio-pci* driver
      - Successfully *bound* the 1st (2.5Gbit) interface to *vfio-pci*
      - *Unable to bind* the 2nd (10Gbit) interface

*Issue:*

I followed the standard DPDK setup steps and was able to *bind and use the
2.5Gbit Intel interface* without issues. However, I *could not bind the
Marvell AQtion 10Gbit adapter* to DPDK.

Specifically, I would like to know:

   1. Whether *Marvell AQtion 10Gbit NIC* is officially supported by DPDK.
   2. If supported, which *DPDK driver* should be used for this NIC?
   3. If not currently supported, are there any *workarounds* or plans for
   future support?

I would appreciate any guidance, references, or recommendations regarding
this matter. Looking forward to your response.

Best regards,
Mamadaliev Dilshodjon
Master student in Pusan National University, Republic of Korea

<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
Virus-free.www.avast.com
<https://www.avast.com/sig-email?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail>
<#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2>

--000000000000678269062e002bcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div id=3D"gmail-:tr" class=3D"gmail-Am gmail-aiL gmail-Al=
 editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"Message Body"=
 role=3D"textbox" aria-multiline=3D"true" tabindex=3D"1" style=3D"direction=
:ltr;min-height:376px" aria-controls=3D":w4" aria-expanded=3D"false"><p>Dea=
r DPDK Development Team,</p><p>I hope this email finds you well. I am reach=
ing out to inquire about <strong>DPDK support for the Marvell AQtion 10Gbit=
 Network Adapter</strong> on my system.</p><p>I am working on a <strong>DPD=
K-based project</strong> and considering integrating the <strong>Marvell AQ=
tion 10Gbit NIC</strong>.<br></p><h3><strong>System Details:</strong></h3><=
ul><li><strong>Motherboard:</strong> ASUS ProArt Z790 Creator WiFi</li><li>=
<strong>Ethernet Interfaces:</strong><ul><li><strong>1st Interface:</strong=
> Intel(R) Ethernet Controller I226-V (2.5 Gbit)</li><li><strong>2nd Interf=
ace:</strong> Marvell AQtion 10Gbit Network Adapter</li></ul></li><li><stro=
ng>DPDK Setup:</strong><ul><li>Installed DPDK and <strong>vfio-pci</strong>=
 driver</li><li>Successfully <strong>bound</strong> the 1st (2.5Gbit) inter=
face to <strong>vfio-pci</strong></li><li><strong>Unable to bind</strong> t=
he 2nd (10Gbit) interface</li></ul></li></ul><h3><strong>Issue:</strong></h=
3><p>I followed the standard DPDK setup steps and was able to <strong>bind =
and use the 2.5Gbit Intel interface</strong> without issues. However, I <st=
rong>could not bind the Marvell AQtion 10Gbit adapter</strong> to DPDK.</p>=
<p>Specifically, I would like to know:</p><ol><li>Whether <strong>Marvell A=
Qtion 10Gbit NIC</strong> is officially supported by DPDK.</li><li>If suppo=
rted, which <strong>DPDK driver</strong> should be used for this NIC?</li><=
li>If not currently supported, are there any <strong>workarounds</strong> o=
r plans for future support?</li></ol><p>I would appreciate any guidance, re=
ferences, or recommendations regarding this matter. Looking forward to your=
 response.</p><p>Best regards,<br>Mamadaliev Dilshodjon<br>Master student i=
n Pusan=C2=A0National University, Republic of Korea</p></div></div><div id=
=3D"DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br><table style=3D"border-top:1p=
x solid #d3d4de"><tr><td style=3D"width:55px;padding-top:13px"><a href=3D"h=
ttps://www.avast.com/sig-email?utm_medium=3Demail&amp;utm_source=3Dlink&amp=
;utm_campaign=3Dsig-email&amp;utm_content=3Dwebmail" target=3D"_blank"><img=
 src=3D"https://s-install.avcdn.net/ipm/preview/icons/icon-envelope-tick-ro=
und-orange-animated-no-repeat-v1.gif" alt=3D"" width=3D"46" height=3D"29" s=
tyle=3D"width: 46px; height: 29px;"></a></td><td style=3D"width:470px;paddi=
ng-top:12px;color:#41424e;font-size:13px;font-family:Arial,Helvetica,sans-s=
erif;line-height:18px">Virus-free.<a href=3D"https://www.avast.com/sig-emai=
l?utm_medium=3Demail&amp;utm_source=3Dlink&amp;utm_campaign=3Dsig-email&amp=
;utm_content=3Dwebmail" target=3D"_blank" style=3D"color:#4453ea">www.avast=
.com</a></td></tr></table><a href=3D"#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"=
 width=3D"1" height=3D"1"></a></div>

--000000000000678269062e002bcb--
