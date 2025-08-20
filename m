Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C569ECA0EED
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 10:07:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DC78402DD;
	Wed, 20 Aug 2025 12:07:51 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id 69B1740292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 12:07:50 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-70a9282141fso68661746d6.1
 for <dev@dpdk.org>; Wed, 20 Aug 2025 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1755684470;
 x=1756289270; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rx0KEXzlj99ob0bHO/75FcGdM/2fY+Hf0tZ0rHCLH7k=;
 b=TkS5O54aGTVoLhU/QIQs7Q560v3xTUpCSz4AcmCDjH+v9L6s0dqjE+AZk1QZtyniwG
 c2K6JrwxLX0r09gF0DfO2xkGeJcxlCDahFT5JMgz//plEkpUdL7arppW/q49SiPmaST1
 bK3ata1q/mJ/4PpzD/ZBxyYJrGSUzyrSlKSaxdpIf/oLGunSBtH3XbRJpavt3dHb5fFr
 U8Ew4+gx70tWkfcs/CW8pjCxy7R4qv86oQT20lZR8nEbdVHurLfnpI7PUs/gGUgZpL3T
 0bu2IJHpinort4mNkikbIDdzRocaR/Ae1tyTiDwGAo+vqtLwVSH4Ias99wSdZTdfbLaC
 bgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755684470; x=1756289270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rx0KEXzlj99ob0bHO/75FcGdM/2fY+Hf0tZ0rHCLH7k=;
 b=lviNw4G1HKyQNTfjLQV8+9gpUofXPTwwtq7TiWwh5ChHaVTO8hN1yBOMtXVebOxAkW
 gKrrvOWs/slZkI3S/HHEF/shIFdzmNaoUZNcmyVAF22G1zr71B1PhCBkssFolwytwX3i
 jdWMAtMYsrTOAmlv0W0gh8Dr87b6ET/gC2RONQcHefO+/VhMiy9ZOwbiwNuy1shpsWny
 +oSwFSyVpaVV2/+aSFs1oGI8PX8WC2Agq32kWgZfl2k4mp/l2S72Y5Ag8g29FLb5/mG+
 ech8IPxuEdVTHv8ycYlUCnKqrEyVMJKtiZ4WPh1b+7GOHPdHD2BYS6iEo/qkvbD1RP0/
 KqCQ==
X-Gm-Message-State: AOJu0YwjLCweE7LvbrEtHi8ZeWIQpChG4AMB+Gn7OlleEUMeVbnAVaEz
 9R3E6gjfkXaZQrVhIfS+C9KCS9B+CtMw48IsfkOjmJUqMDH56n2bb5LZF6/EzErNaRra2IdsA6R
 tAL2uGJg/kT33++Q3rLy+50hAQHFA8oQkgK3e3pLNrQ==
X-Gm-Gg: ASbGncti26nlL92wKB0TuQyR4dAixsbhlwEeOzzJiDwkhjgSYlVo9PZmCq5qORTwDBq
 UIo27Gf8JQ8F9PmIWSwqD50kxw7ucPAjCaGFxCdm0An52AM2tqbujf58Ahbe90uIjotx0i9CADi
 927bPmAS8POg9UBOufL7R+1982rWiKunDsb+evlgexPwBSUPgoRyU46t68Is4pDgZI/XNQKxImu
 aDE
X-Google-Smtp-Source: AGHT+IHCvxlStqbEqE7FDFNNjoadxCSQWi/B/RHheXKwkHbozzP22EX7ToZ/n35BqQ6b9ZTXAZfWnF4sP5KK1WMZaMg=
X-Received: by 2002:ad4:5ca3:0:b0:707:5694:89e4 with SMTP id
 6a1803df08f44-70d770dde04mr21262946d6.47.1755684469514; Wed, 20 Aug 2025
 03:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACGKW7TYR50ehjwexYrkrtCG2qq7-Ayj89K+wyoO5e2a2+F8hA@mail.gmail.com>
In-Reply-To: <CACGKW7TYR50ehjwexYrkrtCG2qq7-Ayj89K+wyoO5e2a2+F8hA@mail.gmail.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Wed, 20 Aug 2025 15:07:38 +0500
X-Gm-Features: Ac12FXzYtBUh8dDWq3uUQJP6Rt3YMU8GEmK9zC3Xq_UI-fUAiloUuTBRfzyWRng
Message-ID: <CA++2-x4JLt8bZeEZVqc0jbC+t+fnS69udbOb7GyHmioQsw8BYA@mail.gmail.com>
Subject: Re: Segmentation fault when running MPRQ on testpmd
To: Joni <canary.overflow@gmail.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000024b9e2063cc92533"
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

--00000000000024b9e2063cc92533
Content-Type: text/plain; charset="UTF-8"

Hi Joni,

Please try the following command for enabling mprq.
./build/app/dpdk-testpmd -l 0-15  -n 4 -a 03:00.0,mprq_en=1 -- -i
--nb-cores=12 --rxq=12 --txq=12 --rxd=4096 --txd=4096 --burst=64

Regards,
Khadem

--00000000000024b9e2063cc92533
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Joni,=C2=A0<div><br></div><div>Please =
try the following command for enabling mprq.=C2=A0<br>./build/app/dpdk-test=
pmd -l 0-15 =C2=A0-n 4 -a 03:00.0,mprq_en=3D1 -- -i --nb-cores=3D12 --rxq=
=3D12 --txq=3D12 --rxd=3D4096 --txd=3D4096 --burst=3D64<br><br></div><div>R=
egards,=C2=A0</div><div>Khadem=C2=A0</div></div></div>

--00000000000024b9e2063cc92533--
