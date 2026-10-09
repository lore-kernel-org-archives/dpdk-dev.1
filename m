Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A4FCA601F
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 19:16:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6196C402DD;
	Fri,  9 Oct 2026 21:16:39 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id D47DD4026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 21:16:38 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2e7006bbf77so495395ad.0
 for <dev@dpdk.org>; Fri, 09 Oct 2026 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791573398;
 x=1792178198; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l3HUDOoAqC+2G99/cAt7jz0lLVprI/5qFrXQNzbwaXg=;
 b=RMVcW42PB//s9ibAcm4FOSVd2/Zhu4iY+jNdl4axilYtBWXYBcLVvLkSDt+j3jm5Na
 e6GGpFr5ZA5/qHrzjI/IyC/g0W4qbKr8RBDPpDLUGUtOoBNNNjnh42CqgkkMd0oyceMO
 2uNfCl9eFPVr66yYb59dqhMUINxVtohEj//UxX/Cald6nXdOjo1gCnomwMAwoO2zxYOM
 3lmGcUx+j83yW1hcwzFHdVIwZVsbrGODw+WrQ05kEEjbzBy/+vKjNQnvP1gTLjw5Bvba
 DNhx3/KR0Es/7q5MBsFGtHBqoH6Gcnx8CJczDytk+OTOR7sGHYpfXiUGm6I+HziT/wPV
 jBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573398; x=1792178198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l3HUDOoAqC+2G99/cAt7jz0lLVprI/5qFrXQNzbwaXg=;
 b=Q0Oj6yN5QTSRF3XakAnamzbHYTzPcW//iG+grodAqxHhRooUdlHsX81RO+sfLdXaU2
 c00raNa9Mqj5VigzAivtvCNUvsj5WMnjMikXvPsgK3hJAqAJmpjI34fAnpuYyCZCsukp
 bWLq0m8Fd19TbfnEY+KzO1icirZb9xcbO4IhePetcOQu6ApVh2B1JyhCEepACB3zWffc
 tofEB5VDd6Xrsf9rCtCz5mRWgV5sZ9jrbyo/JLOm7XV6f4hd+AZNB21eZ4vGlACw/MGJ
 BnExqF9pLZ1lceIVQcgY8KB0xL02+y7ZpM7l6bjd3wVfiPsQTTVVCKa3SCa+WtpageJp
 RWeQ==
X-Gm-Message-State: AFq9FYIP4w2uLUhdt+sOA6DD0B5SEDSJJvchjWxqA9VoqG8tzCrAPdPg
 QY53LbzgaRpTWqyFzXayVtq6IIknFrFr27PYYv+svakXCWYvRGlr/dhKq/7B1EU5QRQ=
X-Gm-Gg: AYBFou3xJ3U2dDxyVSBbdGy7xvRYGISukd5oHvfXJ/2c2C12h6Mgot0ALZ0l1RAyzQD
 4ThkT4bB43Po7aDrbiw50PKzFs4KGuZYngqif1a/Qd3qxMGRGFrhcFBOCeq9vTGfKtTvXgJd6Cj
 rs0k2FACLBO+ydCp0KW/ugY+WU+jC4ppMvD9el48vpXWPfnmf39YaYmvRIf3PI6b6y75+ikVBCv
 T/9P/3+0YdCn5k3y7ojnQfLmcIH8iEd4TR8gswjFVu7phh+xg0fwFsMszEgANR/ZfSdAHBVmR1p
 FiOLma3l7f7FvlILKb+C6Pf68u9KSBfjtoJfR/669+kGxFqxkjTTRr/oTfq08qmtmVOAqz70h8V
 LwSQRMeZmsFoKTBaCriCM9w64f19lAwZG2y8hkcSq4XiZV1tJTaa6bI13UH1JP212M6D70Fa3p6
 p22/+8JgZcCr4eKB7i6SqAgMwJUtzNT/u8/DHL5FG1wM/PQsNTn01KNqiFRn4/3gb1UkZ07eaP3
 U2jLsP94uRLukNHgczDXhksRCf4Ujq1jsb5Tvdksw==
X-Received: by 2002:a17:902:f544:b0:2e2:dd98:59e8 with SMTP id
 d9443c01a7336-2e8427edc2fmr27208075ad.3.1791573397625; 
 Fri, 09 Oct 2026 12:16:37 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e842300d56sm15378785ad.84.2026.10.09.12.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:16:37 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:16:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Randy Tice (rtice)" <rtice@cisco.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: Re: [PATCH v4 0/1] mbuf: add runtime metadata dynamic-field storage
Message-ID: <20261009121603.1f97aca8@phoenix.local>
In-Reply-To: <PH0PR11MB76165F045BA8ECE8877446B9A9922@PH0PR11MB7616.namprd11.prod.outlook.com>
References: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
 <179130207755.4.10786861462241375385.v4-0000-cover-letter.patch@cisco.com>
 <20261006095123.3166b4dd@phoenix.local>
 <PH0PR11MB7616A68AC3EA1349948CAC75A9932@PH0PR11MB7616.namprd11.prod.outlook.com>
 <20261009091405.46b9f3bf@phoenix.local>
 <PH0PR11MB76165F045BA8ECE8877446B9A9922@PH0PR11MB7616.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 9 Oct 2026 18:12:20 +0000
"Randy Tice (rtice)" <rtice@cisco.com> wrote:

> Stephen,
> I=E2=80=99m thinking, perhaps the best path forward for now, is to contin=
ue using a private mbuf layout and carry the collateral internally =E2=80=
=94 at least for now. The changes are getting well beyond the initial desir=
ed impacts and has potential make things become unstable.
>=20
> I would love to see some sort of solution along these lines in the future=
 so we can discontinue the use of a private patch. To be clear, the solutio=
n is not built around cnxk, cnxk is just impacted =E2=80=94 we have several=
 other platform builds that do not use cnxk but we still carry the metadata=
 in the mbuf itself for performance reasons.
>=20
> WRT the skip functions, we fit under the 384 max for wqe but there=E2=80=
=99s no room for additional growth beyond that with how it=E2=80=99s laid o=
ut. The other 2 are not as sensitive to the size but still have valid limit=
s which are well beyond our use case. Today we carry 256 bytes which caps u=
s on wqe.
>=20
> That said, we plan to discuss internally next week on how to move forward=
 as we prep for our v25.11 upgrade work. I want to thank you and Morten, ho=
wever, for your time and support on this work.
> Regards,
> -rt

I do think CNXK needs fixing.
