Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F12C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:55:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 725794042E;
	Mon, 11 Aug 2025 13:55:54 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id E4F064013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:55:52 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-70739d1f07bso52871446d6.2
 for <dev@dpdk.org>; Mon, 11 Aug 2025 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754913352;
 x=1755518152; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A8+cLJLUR9n5X0zpeOZEneSgxf/YofKEN2lZkSCQuN4=;
 b=RZ2ckMKVpm+xHm66OvfT6+7myOHyKosYFRrkK7IlIOS3t3BV1T82zFdymiDkcOFSLE
 IFumdVeNeIldCi8IsCBU2lD8IBDVdS02sVkxGAgs1dqu7ah6TI/IbdiR6XMK7RltNm6c
 hlVmVLqQfi7SNEZTQEY4bEG8JJlcs3oFj0kaTzT2KdPosP2PQne385J5bBbhXCwgu0Yb
 1JnTcIvFEwK5pHA2BOgxpNQ2Vp8lHozwNbbIJlANuItwh5LxNuT2IGD0K0Ehlz5Paouv
 ycjSFLpuomJ5lJBZ4ut5xrU4WLclhAiDF2VcJMmOoe2xc76ly/zyvr37SKFjc2p22j48
 /Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754913352; x=1755518152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A8+cLJLUR9n5X0zpeOZEneSgxf/YofKEN2lZkSCQuN4=;
 b=JPPDflmVLk3KL9MoU119XQgZYoAmX1lBisFb0mrtxXPmlexdX1KBhK9heZwjhWWlga
 u1r2vDmdj39EJMx8hIjZRjfX4a2/ipDyWtMugYYtk74oKgEYcL/5/JWYzsXGP1Rj0831
 QmpXya4wapP7dUSxuhTEkM8usFnj9EELjjPPwkoKFH6ExhF5tMb962FV8+vloIDRGXw9
 BS6EweAtHEcfrXCoJVZIpYioC3u3Sq0VgC+pRq7TcM5rMWZ0kTbpcghtlxb1MoKI8xNn
 yxRxPEFkbXEl9g4WjZsm2xM3tdRS3Uynbn7lvggT5RQ29/iTGHBUpYWU96/StR3Y3eBd
 pGpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/w3XWiPlrtICUP7mMMJyGGS/aPkqN7zcyNVDtAiF+8JIqn+DZGqoHi+zLemfYtsp/meY=@dpdk.org
X-Gm-Message-State: AOJu0YwzpMJ5WBkK8c6Byhf2gxO9cwohmwcICBdMtxNzZswqR6EcbhxX
 a7KHNlaaP/e7gHaa/f1KZaJkNSHVvIGa4eMyGQPKxgHUOPdsv7yRTiQKos4PwMHCD2+NHG9IQ96
 Iq/XaJakcP14rAJDxrJ8t8Z7CRzfReRqb8RuBVEtKBg==
X-Gm-Gg: ASbGncumMkU32ewgO6gVqsAGVwHSBmOm2S7DyQ6Q6HkaBsLICE4GXFeKsKuFgNNGQUH
 AASmZJ+PrEnzoY02y27vam+3eNi0R/tW9RpSbo+3HgyLotDS5+W6T6ygJgHUsiO3njTuo8DMpCb
 aUIbViziAEvITZddyR3p0TYaBgInxAFqfstBqk9Dm6q/gfPlNMhMVpEfEB8EnxBE35oF+tO8HiR
 aFI
X-Google-Smtp-Source: AGHT+IH7Tq8K4dLuxAUeoKya8EUXSjAZtJsaNDLN7xmD3UEKuPPK6tj1KAWEXE6eXxa9Tq4T3KNaiVC5+Nc5f5VRs7E=
X-Received: by 2002:a05:6214:c62:b0:704:f952:1884 with SMTP id
 6a1803df08f44-7099a5147cdmr184463026d6.49.1754913352202; Mon, 11 Aug 2025
 04:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR12MB85968E4B05D92C12C963F1E2822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <20250808114909.1606758-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250808094900.5027f034@hermes.local>
 <PH7PR12MB8596C293ACF92D446DBD10508228A@PH7PR12MB8596.namprd12.prod.outlook.com>
 <CA++2-x4i2OegW0u2a6AJepCFgqjLbwzqdw+es3BqrABgqM7FZg@mail.gmail.com>
 <PH7PR12MB85965BF756C6D234FB8714068228A@PH7PR12MB8596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB85965BF756C6D234FB8714068228A@PH7PR12MB8596.namprd12.prod.outlook.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Mon, 11 Aug 2025 16:55:39 +0500
X-Gm-Features: Ac12FXzdRv-R9PvncUg86WbJJVzi3J59_fc5OFp09K4VCgMHUpKI-9LActaTpv8
Message-ID: <CA++2-x5FZSB56rrVLU96hSosLGHybQWPFPo3VPe=y8YHZBhfqA@mail.gmail.com>
Subject: Re: [PATCH v7] app/testpmd: monitor state of primary process when
 using secondary
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "Yigit, Ferruh" <Ferruh.Yigit@amd.com>, 
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000f84da8063c159a59"
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

--000000000000f84da8063c159a59
Content-Type: text/plain; charset="UTF-8"

Hi Vipin,
sorry for any confusion. I am only trying to explain that these patches are
in its final state (waiting to upstream). You have provided your valuable
insights and
I am very thankful for that. There was much discussion about these patches
from start to finish.

Already mentioned that with Stephen and other community members, the
discussion was started earlier and I have provided all the information
to you in a singla email.
 "First we tried
to prevent the crashes at PMD level, but it was not possible to
add checks in each PMD. Then we tried to add safety checks
in the ethdev layer, and it was not suitable as with primary closing
all reference to device information (pointers) would lead to crashes."

@Stephen Hemminger <stephen@networkplumber.org>  agreed to add a
primary-secondary monitoring mechanism.

I am always open to healthy conversation!

Thanks & Best Regards,
Khadem

--000000000000f84da8063c159a59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Vipin,=C2=A0</div><div>sorry for =
any confusion. I am only trying to explain=C2=A0that these patches are in i=
ts final=C2=A0state (waiting to upstream). You have provided your valuable =
insights and=C2=A0</div><div>I am very thankful for that. There was much di=
scussion about these patches from start to finish.=C2=A0=C2=A0</div><div>=
=C2=A0=C2=A0</div><div>Already mentioned that with Stephen and other commun=
ity members, the discussion was started earlier and I have provided all the=
 information=C2=A0</div><div>to you in a singla email.=C2=A0</div><div>=C2=
=A0&quot;First we tried <br>to prevent the crashes at PMD level, but it was=
 not possible to <br>add checks in each PMD. Then we tried to add safety ch=
ecks <br>in the ethdev layer, and it was not suitable as with primary closi=
ng<br>all reference to device information (pointers) would lead to crashes.=
&quot;=C2=A0<br><br></div><div><a class=3D"gmail_plusreply" id=3D"gmail-plu=
sReplyChip-1" href=3D"mailto:stephen@networkplumber.org" tabindex=3D"-1">@S=
tephen Hemminger</a>=C2=A0 agreed=C2=A0to add a primary-secondary=C2=A0moni=
toring mechanism.=C2=A0</div><div><br></div></div><div>I am always open to =
healthy conversation!</div><div><br></div><div>Thanks &amp; Best Regards,=
=C2=A0</div><div>Khadem=C2=A0</div></div>

--000000000000f84da8063c159a59--
