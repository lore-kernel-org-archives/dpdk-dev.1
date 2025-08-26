Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECC6CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 09:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F9B64021E;
	Tue, 26 Aug 2025 11:29:42 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 980B740156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 11:29:41 +0200 (CEST)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-70da75014b6so29344866d6.1
 for <dev@dpdk.org>; Tue, 26 Aug 2025 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1756200581;
 x=1756805381; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bKmlqmhsa/6buyGLOISQmB+ue5P3pLiczaM2mDXJUk8=;
 b=H+F0wpbNPV77AAsAPhGOJdb+rsVUjSyo6nZJluFpvQfPvyMrcVUw9rfu/DwPqrNQhQ
 vZYEkpJBD1rg+OGe/x7ZYjp8yyyxs3/Uy0u53EotlA0EgMgI59tN2rKFbO2aS/me5AYF
 QRrZf1wRbEvL/2+qB+rdTsyzwwBcwbIcYc+d9r9C5PB590e2KbzVTwpETr2xF5XO3HIL
 QRSmcq0TaTA7BN96ywXnCgc/buoDKSGeE3GXXPvQAYyDLKFIDWnk1y75D2OR3NW8ndm+
 O5rk87y8odkivVnvtoPX8b75ypv2jS25kYQcsxvbq+Zdij7POzeqs3a9UuXdkk7O8olM
 NWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756200581; x=1756805381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKmlqmhsa/6buyGLOISQmB+ue5P3pLiczaM2mDXJUk8=;
 b=l2OFZgtmOv/WYMg0+CWY/wrVMumRJHGNx5DCIFw/KZAmMPLzLcqMeOGDqBX4eebOOz
 zPAsLRmW5ySz/P5tEPkE6FVA3WRYkkm38e+9lv6H0cwhKlZnBQmqmxgXU7wdqTc189ez
 BTfGASfE9oqOK2sLRkXRvpDezvPmgvau8FFR+mZn0noHR7X8txrPU13J+5RCl3tdYKIb
 Z/ecqr3DE9Udoa8eWWLufvTPPzNA/fcTbyq5iCsgeXQrnrJ8oU+iuGoAKHUtHnw73Idu
 Ncl5RFIYOInvkhimNg1UdZj4bq4JSszDNAW0y5gbVAnbSSDPv4VYKLJh0VhOb6wjuP2D
 2bfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTzKvpq2kvOypfiBRSvvCoBDwPIA3POY2cCIB8qzLWLeTpC/Djnip0IpW7Jw2vydvJRNw=@dpdk.org
X-Gm-Message-State: AOJu0Yy3Pss/Eq01GW6cA7lBA/Q/D6oayBmPzoU7Ca2j+3VH0Dk4Zr7L
 CgFsH5S+oYfb5HVZEFPFBszF8InVW2qf6VLseoAIYZIKPaWldKYAvf8U4374FMMllSy4764hOHi
 GvhH1a7Y592G0G+tDdPJ2/Ckyl/Ye97RnoMyf6kU3Kg==
X-Gm-Gg: ASbGncswpX7sbdCApTXharzO+Uo/3jDz7SVG7E1QZAT3b0BC/13F7VIJix2wOBjQdrt
 F6+xaEJooXkfJXesLqSeErlP/YOTdDx3fPNMpc6aYj789foHp0pwXYslY51LvZx8Hx7d6OQOvhv
 +XTssoV9S99LZwzwu0I9JXJXbm8qg4AgmG+5Qc9lIMzgGgqoeKKPkv2QrQRtO3KnSqMNSvzD7tc
 DzqhgZEvnKnWoxGDKxSvXSgSstO3ZJw9lpEaZ/ncisg77PdCvs0UL48s4JarEqq/7B1/9Oj0UlA
 z0An6Q28QA==
X-Google-Smtp-Source: AGHT+IHd+pzzU76IKtpTSeN/gG5eKkBeVBOa5EOV+SmtmanHrqu4DQyt2PL/CBOU3cn8RRYodcp00/TLC4C5Mnc45Aw=
X-Received: by 2002:a05:6214:d43:b0:707:77be:fc76 with SMTP id
 6a1803df08f44-70d971ed2e1mr178060796d6.51.1756200580799; Tue, 26 Aug 2025
 02:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-4-ciara.loftus@intel.com>
 <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
 <aK1oNgPbHGeJdgUp@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aK1oNgPbHGeJdgUp@bricha3-mobl1.ger.corp.intel.com>
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Date: Tue, 26 Aug 2025 14:29:28 +0500
X-Gm-Features: Ac12FXzrSMKciF7NGbFz1Ru7C2yWZbcBYAYiabDIAXVzVwNZdXiypRnawJinXrU
Message-ID: <CA++2-x5j0hH3XweLL+=O7-GJOnGSuN8zoFURs13mgFiVh1MD3Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] net/ice: remove SSE vector path
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Ciara Loftus <ciara.loftus@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c5f813063d414f2c"
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

--000000000000c5f813063d414f2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bruce,

Thanks for the feedback!

I have checked at my end, most of our systems (Intel(R) Xeon(R), AMD EPYC)
do support sse, avx, and avx2. I was talking about general availability.
It means, newer features will not be added to the SSE path and as
you mentioned that LTS 24.11 will provide support till the end of 2027.
Applications that use ice SSE paths can benefit from it.

Best Regards,
Khadem

On Tue, Aug 26, 2025 at 12:54=E2=80=AFPM Bruce Richardson <
bruce.richardson@intel.com> wrote:

>
> Hi Kadem,
>
> can you perhaps share what systems you are using that do not have AVX2
> support? Do you do new deployments with latest DPDK on those systems?
> However, if it helps, we can defer this patch till after 25.11
> release, so that we have one more LTS with SSE support still in it. That
> would mean that we have a supported DPDK release with SSE in it until
> potentially end of 2028. As it stands, even if this patch goes into the
> release, 24.11 will be supported till end of 2027.
>
> /Bruce
>
>

--000000000000c5f813063d414f2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Bruce, <br><br>Thanks for the feedback=
!<br><br>I have checked at my end, most of our systems (Intel(R) Xeon(R), A=
MD EPYC) <br>do support sse, avx, and avx2. I was talking about general ava=
ilability. <br>It means, newer features will not be added to the SSE path a=
nd as <br>you mentioned that LTS 24.11 will provide support till the end of=
 2027. <br>Applications that use ice SSE paths can benefit from it. <br><br=
>Best Regards, <br>Khadem <br></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 26, 2025 at=
 12:54=E2=80=AFPM Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@i=
ntel.com">bruce.richardson@intel.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><br>
Hi Kadem,<br>
<br>
can you perhaps share what systems you are using that do not have AVX2<br>
support? Do you do new deployments with latest DPDK on those systems?<br>
However, if it helps, we can defer this patch till after 25.11<br>
release, so that we have one more LTS with SSE support still in it. That<br=
>
would mean that we have a supported DPDK release with SSE in it until<br>
potentially end of 2028. As it stands, even if this patch goes into the<br>
release, 24.11 will be supported till end of 2027.<br>
<br>
/Bruce<br>
<br></blockquote></div></div>

--000000000000c5f813063d414f2c--
