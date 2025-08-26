Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD254CA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 11:55:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3114402AE;
	Tue, 26 Aug 2025 13:55:06 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 840374021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 13:55:05 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-70ddadde48fso525016d6.0
 for <dev@dpdk.org>; Tue, 26 Aug 2025 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1756209305;
 x=1756814105; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A1EilSW0TJO3eMrrYhIHwgV+7oD/Blw9zG8olH+flsA=;
 b=WJ/cQH2KVUULka+jY/SrRhXO81DOdI6qcYu90Fgx81etXr4Gv9LpS3hFeTiuuMbLt8
 webaLCB8BCEP/jhibw6oI5vemJgeLaPASBhXxTOpDAj7w8QWuZhWABtU+RNRg9TzpTsc
 SaEX1/wUb8NTev0QabxO/FMcLpYa3rTUANbMYZebWjPj4EY/6xoBCapWQU1sZf3YdvOw
 2Ln5CD1v2u545MinfVt6p2T0v5OaGnWERJE1tO3EzCYNgz83Ku+v24IXNy9JJtzk9GYc
 pbVyaC+tE3+MjBHNusQv2rVJtBp5CbAW1ZCLC1e2E1QBny/R4D+SL64Y6TFjKWPVg600
 T3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756209305; x=1756814105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A1EilSW0TJO3eMrrYhIHwgV+7oD/Blw9zG8olH+flsA=;
 b=WM+kaxrXNPiQP+ops981raHSw6rlv8mNPK61L9Gb5t0jpUFm2UZn/6mGlC8R749Jwt
 4OrvtmKyBnbU5Mntl7xwbkXn5M+awQ+h0oChppFSrDHG0cIBn8EYsp2xNxW36kAsXvCK
 O+S/54hqZnPsTQ5MRFDJZmIBN8+OF2jRtu7d0dACuH851SDv3JNHGS5PI/CGXOuu1a4S
 XsKdbHiKNxuhYatfmIH765NgIXZnYQIx/mmaQrw6/S6GPfPpD9skYFTru4fJ1yLo+9ru
 9Cmi61/InJt9JUhQmeSeyQS2u8lzk7HA+Kh5GrZnNgcByTPh0uav/ctH/qDZ+awPyNSL
 BpwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/3aGNcZqkbMpJYP6fKgVqXpBCEy/V/KFr2rtC4CljZ1ETQL4UWT+rrK2dncRWwl+Efzg=@dpdk.org
X-Gm-Message-State: AOJu0YwSYlqVzpDoxcUyrJ4pE8lAcUlxhfhTPYS2VALYXruqxHfucQ7T
 yPevIg4La6i/tLguEWLcL0/bnvqAdGaXGpLzdMDPipuAZx3lBiwO6xN4jHVzAhqGb04ALRldJXm
 gjUsK/4YvoHgIiOeqnu1guTrNeuidiQ+fQkJt9ZGtHZDr3jNlHjsr4vc=
X-Gm-Gg: ASbGncsNyVPHzVX8P7dIbLEFv1RpNO7zThnRejAAmF+JsqFFFrFiluQnNvGHF4YaqOu
 3qhcCIokk4AIAy3U50T1ONXf/fS8v9nqvP9lQxd+IZFpbrwN2vPXd7PJdeALt3QzOIqdYFV6KRG
 kXxStF0pQ882QF8p/wPCKBWv+0XnMbowx9NH5S+JRvt9RxEFbzhRfEuwIQDgEez189/XQ71j7gY
 +KEZ6vKa+eA2bmp3LPQP7shzrCNIJMg73evM71vuUzi8XlE8HoIuKB++l5fDHX0dNqPS8fTZ5kM
 5TOIBzNLXQ==
X-Google-Smtp-Source: AGHT+IFW2WOkthHea8qaXH7jvjNBWmF/uSjZgGZ1ceOYd4FrVlXhiqyMGoxR2f0xb/gT0tBKKrdG6q6NKCmLLB1/q6U=
X-Received: by 2002:a05:6214:f25:b0:70d:961c:bb05 with SMTP id
 6a1803df08f44-70d9709624cmr183104506d6.10.1756209304739; Tue, 26 Aug 2025
 04:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-4-ciara.loftus@intel.com>
 <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
 <aK1oNgPbHGeJdgUp@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x5j0hH3XweLL+=O7-GJOnGSuN8zoFURs13mgFiVh1MD3Q@mail.gmail.com>
 <aK2Rajd8rypPr7lT@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aK2Rajd8rypPr7lT@bricha3-mobl1.ger.corp.intel.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 26 Aug 2025 16:54:53 +0500
X-Gm-Features: Ac12FXycqkCBDqAs8493-XRVfCyFp0mZNa_8YXyJ2raJ3f9B1ioocojNamOOQAM
Message-ID: <CA++2-x4kcTQwBRKKvhqwjqMBQ2OAmiGtuagqSQ+6Tw74PRGRbg@mail.gmail.com>
Subject: Re: [PATCH 3/4] net/ice: remove SSE vector path
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Ciara Loftus <ciara.loftus@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c2b925063d4357d7"
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

--000000000000c2b925063d4357d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:50=E2=80=AFPM Bruce Richardson <bruce.richardson@=
intel.com>
wrote:

>
> > No problem.
> > BTW: Please don't top-post in replying - it's best practice to put
> > the reply below the text you are replying to. Thanks.
>
> Ohh, I got it :)
> I was triming the quotes when replying but in top-post format,
> will always try to avoid top-post in replying in future!
>
> > AVX2 was first available in systems starting in 2013, (and AMD systems
> > since 2015), so at this point it's been around a long time. The SSE cod=
e
> > paths in the drivers will only be used by systems which do not have AVX=
2
> on
> > them - which should be relatively rare, I hope, at this point. There ar=
e
> no
> > features in the SSE driver that are not available in the AVX2 one, so,
> I'm
> > not aware of any reason why one would need to use the SSE code path in =
a
> > deployment of DPDK.
>
> Yes, I think all feaures in SSE do already exists in AVX2 paths.
>
> > Even without this patch, there will be no features added to the SSE cod=
e
> > paths in the drivers. Any new additions would just be to the AVX2 and
> > AVX-512 code paths. Even for systems without AVX2, if the SSE path is
> > removed the driver will fall-back to the scalar paths, which have far
> more
> > features available in them than the SSE codepaths, which were simplifie=
d
> for
> > performance reasons.
>
> Thanks for the update. I could not exaclty got the meaning of fall-back t=
o
> the scalar path.
> Does that means that the driver automatically switches to the scalar path
> ?
> which is slower but includes all the necessary features that were
> simplified in the AVX2 path.
> I believe AVX2 provides an average performance much better for small fram=
e
> or packet size (about 14 Gbps).
>
> Reagards,
> Khadem
>
>
>

--

--000000000000c2b925063d4357d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 26,=
 2025 at 3:50=E2=80=AFPM Bruce Richardson &lt;<a href=3D"mailto:bruce.richa=
rdson@intel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div><div><br>&gt; No problem. <=
br>&gt; BTW: Please don&#39;t top-post in replying - it&#39;s best practice=
 to put<br>&gt; the reply below the text you are replying to. Thanks.<br><b=
r>Ohh, I got it :)=C2=A0=C2=A0<br></div>I was triming the quotes when reply=
ing but in top-post format,=C2=A0<br></div>will always try to avoid top-pos=
t in replying in future!=C2=A0<br><div>=C2=A0<br><div>&gt; AVX2 was first a=
vailable in systems starting in 2013, (and AMD systems<br>&gt; since 2015),=
 so at this point it&#39;s been around a long time. The SSE code<br>&gt; pa=
ths in the drivers will only be used by systems which do not have AVX2 on<b=
r>&gt; them - which should be relatively rare, I hope, at this point. There=
 are no<br>&gt; features in the SSE driver that are not available in the AV=
X2 one, so, I&#39;m<br>&gt; not aware of any reason why one would need to u=
se the SSE code path in a<br>&gt; deployment of DPDK.<br></div><div><br></d=
iv><div>Yes, I think all feaures in SSE do already exists in AVX2 paths.=C2=
=A0 =C2=A0</div><div>
<br>&gt; Even without this patch, there will be no features added to the SS=
E code<br>&gt; paths in the drivers. Any new additions would just be to the=
 AVX2 and<br>&gt; AVX-512 code paths. Even for systems without AVX2, if the=
 SSE path is<br>&gt; removed the driver will fall-back to the scalar paths,=
 which have far more<br>&gt; features available in them than the SSE codepa=
ths, which were simplified for<br>&gt; performance reasons.<br><br></div><d=
iv>Thanks for the update. I could not exaclty got the meaning of fall-back =
to the scalar path.=C2=A0<br>Does that means=C2=A0<span><span class=3D"gmai=
l-ui-provider ed gmail-bqs gmail-bqt gmail-bqu gmail-bqv gmail-bqw gmail-bq=
x gmail-bqy gmail-bqz gmail-bra gmail-brb gmail-brc gmail-brd gmail-bre gma=
il-brf gmail-brg gmail-brh gmail-bri gmail-brj gmail-brk gmail-brl gmail-br=
m gmail-brn gmail-bro gmail-brp gmail-brq gmail-brr gmail-brs gmail-brt gma=
il-bru gmail-brv gmail-brw gmail-brx gmail-bry gmail-brz" dir=3D"ltr">that =
the driver automatically switches to the scalar path ?<br>which is slower b=
ut includes all the necessary features that were simplified in the AVX2 pat=
h.=C2=A0</span></span>=C2=A0<br>I believe AVX2 provides an average performa=
nce much better for small frame or packet size (about 14 Gbps).=C2=A0<br><b=
r></div><div>Reagards,<br></div><div>Khadem=C2=A0</div><div>
<br><br>
</div></div></blockquote></div><div><br clear=3D"all"></div><br><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div><br></div></div></div></div>

--000000000000c2b925063d4357d7--
