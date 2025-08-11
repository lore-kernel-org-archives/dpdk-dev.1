Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A66C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:27:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEC4C40649;
	Mon, 11 Aug 2025 12:27:58 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6C092400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:27:57 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4b0c5d57713so21742931cf.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754908077;
 x=1755512877; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xUQ8CJvJNf1mXDVWwv4Ilry/j3mRmyLCEU4IROPoPvA=;
 b=pRygogISe7XETE176K01uiqQtlZgN5RWA9KBSXOFwEmYNeVYSVS/XppJvabEfxC/YI
 OlkRX4iYNcwLlu+1pLULdGeNdjGYce/2qIw+r5heM6OwQQoGf5ldZaylyzLGkobcejs+
 J3oLZ/WzzdsC675nlSIGGzrFUyCoZYczvlxVF3w3M9d1hJNJ7sXbaKCZanBgnhlS5xrg
 ChQ9Bb8SbcEcUklSY+oG8lZd8SuW47j1HRUNp8d/ManC/7qthkI6KXkDvHbbl5vzZ5kk
 4sjNhfLJs/uV2o+DK+gPRW/kaCFw3U03OLvlsK6F7dLGUqpaybKNTrD+uE+DDLcwKL/m
 2Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754908077; x=1755512877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xUQ8CJvJNf1mXDVWwv4Ilry/j3mRmyLCEU4IROPoPvA=;
 b=mrc2QtX99IIoSwBYTptybzOB5c/5DpcvgqC2TqRy0xCyIYlanOk67qVcTLusWYBhoA
 r70kmkJr1MQmzSk+chAxuMTgSnayFN5i4QvWDJbkq5NAJlhb/zVVeQWG//Y8jawqu3/p
 IrKpYMLueqlgwshxbkuah5U0PKmM670uWxSUdvmoxDB3ksA3itNq01Bu2ARFvCBKne0Y
 SmFtcHr8uPbm1YJNMMGTrjLyPrs3uBzV29RficsQurzsuwmZxdoIBhvr0Wrb/7AnQStE
 OiKNQiU/lZP0Tcf2whVBxH3oqgnsWi7xTiEnK1hcGnKnLRwuul9pxpSaE8A607XsVpkJ
 SV1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp6JTOSgJ4EK6qAgka4oT65TM0WQoI3FgQmcriTS7UWefYUlIrpXmu2vRk2whO7xoN4xU=@dpdk.org
X-Gm-Message-State: AOJu0YxRLpT9AqvIV61Sq8EZAy7KuJPKgQqXqjqPek6Na2gMCk/BQGzn
 Si581dkwzVp8spVUvjG2KhZflpbN0hBzL7p39OBEIReXGvnrQAXJ6fHB97Vy14XHwbeCNwOFQue
 q782eZHKgwW1/OZG0Kh9ryhSXK6TOtVWDiADV2yW16A==
X-Gm-Gg: ASbGncsKGc7V+ANyPyuO0eRLF5HcsCIr3T8noz2SMvu/I6ayJ2KG07xWKSwNA9paxlh
 kyQ2Z8coynZFVw2Hy2/STDtKDBcj3TeWqjYUyQMvp+Z31eXthB98lxGSHaGrD0GwfQw4yhXxDDc
 1vn9WsyJaOyNF5wNl2xwIHqDhnWldM9/YK3xjijG/d3VYE6RDdAfxjVB89zMXVR7FjZON/aLRcU
 2WW
X-Google-Smtp-Source: AGHT+IGdDVAqAWc7D2oGqe2Qao8GSsQXw1XSIOoPycs36cmK1v7r574o5R34e8btUmi0VdII4A65zr08JBDs9f87Cgk=
X-Received: by 2002:a05:6214:ac6:b0:707:4cbc:34b3 with SMTP id
 6a1803df08f44-7099a2e5e5bmr175592936d6.15.1754908076557; Mon, 11 Aug 2025
 03:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144850.2392840f@hermes.local>
 <20250730052412.78178-1-14pwcse1224@uetpeshawar.edu.pk>
 <PH7PR12MB8596F632CAD6508EA7EAB843822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808091735.561e6cbb@hermes.local>
 <PH7PR12MB8596A4119DA21A976EE806008228A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8596A4119DA21A976EE806008228A@PH7PR12MB8596.namprd12.prod.outlook.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 15:27:45 +0500
X-Gm-Features: Ac12FXzQ55XnYF_6wOcsrU5dY1DZoCCDgm-p5U8fBMOJ5NodohcaNuCg10uSJRM
Message-ID: <CA++2-x74qwH_3dnuvDJyHDUiaXm5eQURrHH-6HDRHbH8ZtMnPQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary process
 by monitoring primary
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "Yigit, Ferruh" <Ferruh.Yigit@amd.com>, 
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000846708063c146097"
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

--000000000000846708063c146097
Content-Type: text/plain; charset="UTF-8"

Hi Vipin,
Please check
https://patches.dpdk.org/project/dpdk/patch/20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk/
The details are provided over there.

Regards,
Khadem

--000000000000846708063c146097
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div><div>Hi Vipin,=C2=A0<br></div>P=
lease check <a href=3D"https://patches.dpdk.org/project/dpdk/patch/20250804=
113322.53650-1-14pwcse1224@uetpeshawar.edu.pk/">https://patches.dpdk.org/pr=
oject/dpdk/patch/20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk/</a>=
<br></div>The details are provided over there.=C2=A0<br><br></div><div>Rega=
rds,=C2=A0</div><div>Khadem</div></div></div>

--000000000000846708063c146097--
