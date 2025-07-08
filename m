Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318B5C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 23:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD24340E0A;
	Wed,  9 Jul 2025 01:01:57 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id B80D6402A0
 for <dev@dpdk.org>; Wed,  9 Jul 2025 01:01:56 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-234f17910d8so45323865ad.3
 for <dev@dpdk.org>; Tue, 08 Jul 2025 16:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752015715; x=1752620515; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zfNYviAjP6+8Iy4wii61nypy/GlZMmHHI0URpdYPXBI=;
 b=cw9Of6u8coR69A2et8lDlbbDZt/0IWBBJ0WFsRhWRRXg/G0+vBNx4rGP+sIP9eJy/V
 ImgSorFVNESS3Oif8g9cPOO6v57NXU4qcjhpXnOgZq3tpqPULyDFHTbZ6f4d1Ikr2Mx6
 nRdLnpPP8vRb2UemvDJSRbwUG8wg0BE2sHoBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752015715; x=1752620515;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zfNYviAjP6+8Iy4wii61nypy/GlZMmHHI0URpdYPXBI=;
 b=i1fT0J67BYrN72GBDjpiMck4x3/LRrHqmPIO3uxX+ddGkiMRficmhhoHr/Djd83PvK
 0Bsc8XnHLhBSKKp3A9RZH9fJbIinozjvrsuYZCy2ain2TXXaZ+bYNHFcyZH4iFY9zAbq
 VJ9N9sFCNnE+ILVWWnQTDjGfAflxUpiBRlelqkUn7DiMTdNSjNN4bKDwjZp/puGrRJJn
 d+YurYV+VkpefYlen/YOfGrPn44VWfDFICQmE8v3UrcEoSu4c4gFMF/nQgqcREQMis73
 +GnOVYzP2VwN9LDCsQVa+EoPBzplGG7z0Txn8EmVs1tCDvpXV4d9DkmgYywu5yVTr1Km
 rCMg==
X-Gm-Message-State: AOJu0Yz0CtZ2rgXdNXvHfa3NOorv3satgFk8UleSPZKic2O9D15WXtaO
 w09/C4aTeWw1CzKXpAWJoXwxoj9mbGHser0P2DGS11dYITlTbyMrXiagwYPjMjf7/hduUrmKJaC
 S0g/3DAzPZnyXKRvJDvVAzAXdii5Q12pHAacePrryXLlCEdsobR5eIjs=
X-Gm-Gg: ASbGncsH2sjoAOBA+J2X45XP4y44nAE01ruEZEvuxZTrFVpJMqwiKrMBem3ddxn9B7C
 0VHrBElcEqIyQn9A0+ucSGeUVn6PdykCkjQSu13+eqsqEYWR8PRL4Gf27B0ODoYJop0SitFi7bu
 ezx9qZAOvShnthBncfHPqGkWLm7oOjx1tpFZDs3NqgmzN61UqIfwFq9lWnUw==
X-Google-Smtp-Source: AGHT+IEixo6ndIogy2FMdQHEnVaMKYpiBc/W929bWWLfxrkfI6m7sN3d49OTDuepJwuuzDPVAmlEtKhyQpDSvn06wD8=
X-Received: by 2002:a17:902:e5c5:b0:234:ef42:5d75 with SMTP id
 d9443c01a7336-23ddb1b9f71mr3307025ad.20.1752015715180; Tue, 08 Jul 2025
 16:01:55 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 8 Jul 2025 18:56:12 -0400
X-Gm-Features: Ac12FXz7vpPZA-FTbMg_gLfmIHS5G8CZ1I79uvLCM6jJc09RYiytr0QjXC1cCiY
Message-ID: <CAJvnSUCDkunBMDbh+VH2Nzzf-R-h6-PNG-xAJY_zQfRNmhTF7w@mail.gmail.com>
Subject: DTS WG Meeting Minutes - July 3, 2025
To: dev <dev@dpdk.org>
Cc: "ci@dpdk.org" <ci@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000583845063972f254"
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

--000000000000583845063972f254
Content-Type: text/plain; charset="UTF-8"

#####################################################################
July 3, 2025
Attendees
* Patrick Robb
* Manit Mahajan
* Dean Marx

#####################################################################
Minutes

=====================================================================
General Discussion
* NA

=====================================================================
Patch discussions
* Merged since last meeting:
   * doc: elaborate on per test suite configuration dts docs
   * Devbind initialization bug
https://patchwork.dpdk.org/project/dpdk/patch/20250616183859.646384-1-dmarx@iol.unh.edu/
   * Fix deterministic doc
https://patchwork.dpdk.org/project/dpdk/patch/20250611140530.51551-1-cfamullaconrad@suse.com/
   * L4 port # packet matching
   * Packet capture testsuite:
https://patchwork.dpdk.org/project/dpdk/patch/20250506132933.1580584-4-luca.vizzarro@arm.com/
* Current development:
   * Single_core_forwarding perf test:
      * Patrick submitting a new version today
   * VF support and testsuite
      * Dean submitted new version - this one has VF creation logic moved
to topology.py and properly resets sut ingress port and sut egress port to
the VFs
         * Only supports 1 VF per PF. This allows us to validate most of
the VF capabilities we are interested in testing, but may limit us on
testing certain workloads
      *
https://patchwork.dpdk.org/project/dpdk/patch/20250617201358.708638-1-dmarx@iol.unh.edu/

=====================================================================
Bugzilla discussions
* None

=====================================================================
Any other business
* Next meeting is Jul 17, 2025

--000000000000583845063972f254
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>July 3, 2025<br>Attendees<br>* Patrick Robb<br>* Manit Mahaj=
an<br>* Dean Marx<br><br>##################################################=
###################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>* NA<br><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* Merged=
 since last meeting:<br>=C2=A0 =C2=A0* doc: elaborate on per test suite con=
figuration dts docs <br>=C2=A0 =C2=A0* Devbind initialization bug <a href=
=3D"https://patchwork.dpdk.org/project/dpdk/patch/20250616183859.646384-1-d=
marx@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/2025061618=
3859.646384-1-dmarx@iol.unh.edu/</a><br>=C2=A0 =C2=A0* Fix deterministic do=
c <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/20250611140530.5=
1551-1-cfamullaconrad@suse.com/">https://patchwork.dpdk.org/project/dpdk/pa=
tch/20250611140530.51551-1-cfamullaconrad@suse.com/</a><br>=C2=A0 =C2=A0* L=
4 port # packet matching<br>=C2=A0 =C2=A0* Packet capture testsuite: <a hre=
f=3D"https://patchwork.dpdk.org/project/dpdk/patch/20250506132933.1580584-4=
-luca.vizzarro@arm.com/">https://patchwork.dpdk.org/project/dpdk/patch/2025=
0506132933.1580584-4-luca.vizzarro@arm.com/</a><br>* Current development:<b=
r>=C2=A0 =C2=A0* Single_core_forwarding perf test:<br>=C2=A0 =C2=A0 =C2=A0 =
* Patrick submitting a new version today<br>=C2=A0 =C2=A0* VF support and t=
estsuite<br>=C2=A0 =C2=A0 =C2=A0 * Dean submitted new version - this one ha=
s VF creation logic moved to topology.py and properly resets sut ingress po=
rt and sut egress port to the VFs<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* On=
ly supports 1 VF per PF. This allows us to validate most of the VF capabili=
ties we are interested in testing, but may limit us on testing certain work=
loads <br>=C2=A0 =C2=A0 =C2=A0 * <a href=3D"https://patchwork.dpdk.org/proj=
ect/dpdk/patch/20250617201358.708638-1-dmarx@iol.unh.edu/">https://patchwor=
k.dpdk.org/project/dpdk/patch/20250617201358.708638-1-dmarx@iol.unh.edu/</a=
><br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzi=
lla discussions<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>Any other business<br>* Next meeting is Jul 17, 2025<br>=
</div>

--000000000000583845063972f254--
