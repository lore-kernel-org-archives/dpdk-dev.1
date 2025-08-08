Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E07C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 17:01:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D11F40685;
	Fri,  8 Aug 2025 19:01:41 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 5D90140685
 for <dev@dpdk.org>; Fri,  8 Aug 2025 19:01:39 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-7072ed7094aso22565266d6.1
 for <dev@dpdk.org>; Fri, 08 Aug 2025 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754672499;
 x=1755277299; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R6olcOJ+ZsYRp894+JR0YIOiPF+TidFPKz9IiZjt+D0=;
 b=yH+TDjmHRBk2lEua8+HPaLDXVSaJg5IhbC1EnzRqqicsKv/z3ZvWr7F0Uaw0vONwg+
 xl7F0qu8TN/Wjk/z0AoMSm0Bfj/VzAyXv5b71QmGYGPl7XHgr0EjfdtR5rje5vRCbD7i
 xeLgl8JDaI5diAqG9wqnoUDcah0U8xRgJzZnhHvdY+ToiO/YFUBnfCJMhCqNrgxud8on
 XtqENnyOW1d1ZxOuoHAMUC8B4BEltiuQzuaH27jehr3nHNpR1hQX4TEiX+grHTH/W1qF
 91QEpkLcqztySYaz1VAbO/ENiSVDcfJ2BOIHHX15PIxm2yMvpHcDLLGZL1C7oWnXc75D
 GJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672499; x=1755277299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6olcOJ+ZsYRp894+JR0YIOiPF+TidFPKz9IiZjt+D0=;
 b=ot5jS85XQHSxterZ98Q+NaDQSVtjsWmQa427wuvC+VHekjN1MUfgeAKtpSusHwhHQ7
 JzS+z1pOt1b7FatJ40LkbJcM78B6we6H3iQcdEwyxUMpHNsTg7izD4h5LRSiLQEi/cwx
 QDbBq09BhkKrqIbsOsGBs/LPqMQKocJwWEwTvJ+ZCAh/DgD7mTIp7WMW/O3PUb7DUFhv
 D3AbbMkiMxHsRRoJmRg/RCkULG+KGg8ZZQV+d9XbLKgzo86FzBR3hady4MPToqmHW1fn
 JHegHTLdn5kT6s8tmwn0dP85Snw1KcgxWSITdRx6B6ttrQOF6ObmoFD/oJsZAIjuYwfq
 yE/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKbEBQEhVDqGNyYhX+KfWDbV4XiKvxyyMbr3P5zU9x4DKwRd2k9DUD1GO/xCCIXUpyMmU=@dpdk.org
X-Gm-Message-State: AOJu0YxluyHABqC3zbJ2fgFe110gxCo0QwOzzuqf1uU5Gu4FmJBABJDp
 mkgeu+s3dCrTLgdT8TqPLiLqKH4trLNvkWDRiHY2QZ4rr98APk11iyLxTmT9xbukoLVdnE60M3q
 DJBptSDTlcBq1Ngb1va3Hsppu0FGnXbh94Z8ap5/7cDNJUPEcZRzPCWR8Vw==
X-Gm-Gg: ASbGnctHmk4APUo0/6WjxgZcteooeCOy9Ew0ZQtNyFBqiF3pZ7UMkl3Kz+NNS7qFdxe
 zIZTJjV+B2y50xxkKW2r3FEb8D+JPUPBl9nIRLF4074c1EKv1zXbKfHURP7rkgbBYZQkncJqts6
 ZAXStl7TzmQKWisuQ1oGtl0ZWlPLEPj7CDnzDuTNA2cq8C6KH3i0OSaCGwKsYCH+AMlT8UeP4HB
 QqrtVG0
X-Google-Smtp-Source: AGHT+IECqEHS+EANpmgbqyeMcul4G4jG8woLZXuZiEeysKlmLg3ngOdLza+MokIHa1lSZg/PaztS3LZ6bgrNi2EpzkU=
X-Received: by 2002:ad4:574b:0:b0:707:7b4f:6e35 with SMTP id
 6a1803df08f44-7099a37255amr47679326d6.34.1754672498516; Fri, 08 Aug 2025
 10:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250808094900.5027f034@hermes.local>
In-Reply-To: <20250808094900.5027f034@hermes.local>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Fri, 8 Aug 2025 22:01:26 +0500
X-Gm-Features: Ac12FXxLtbw6d9vKWc7M889PHZ4eRVd0wvQ-r0fwCkRNA6LE2V6FIO8wcV7J7jc
Message-ID: <CA++2-x4bVDQnChAR9M_ravC9zFno=DhZfutCqc3aua9rXuhmjQ@mail.gmail.com>
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Vipin.Varghese@amd.com, thomas@monjalon.net, Ferruh.Yigit@amd.com, 
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f8b7f2063bdd86f1"
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

--000000000000f8b7f2063bdd86f1
Content-Type: text/plain; charset="UTF-8"

Now, it is much clearer from the diagram that we do not need any cleanup
 in the secondary process if the primary has already been done!
Thanks again for the help!

--000000000000f8b7f2063bdd86f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Now, it is much clearer from the diagram =
that we do not need any cleanup</div><div dir=3D"ltr">=C2=A0in the secondar=
y process if the primary has already been done!</div>Thanks again for the h=
elp!<br><br></div>

--000000000000f8b7f2063bdd86f1--
