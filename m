Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B67C55172
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 17:01:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCEC0402BB;
	Sat,  1 Aug 2026 19:01:56 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 47E5340299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 19:01:55 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so1862850a91.2
 for <dev@dpdk.org>; Sat, 01 Aug 2026 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785603714;
 x=1786208514; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OB8KWZIB/3YGC3i1Uqf2+JxEt4tORwORhv7CppP9qmM=;
 b=pf+g6/b+CLuZp8qmAbpX1A/+cpjVsFTDZ+9fJ0cjotiJ7eHNIv+zLMWEHzaOUqfbYX
 vMEoAZGDOZ31tXugWwB+b9lbQg6KMu5zTKfY7Xh0qRUX6/fk3+12gYBlq8fOqgKZp0Hu
 1lWmO8+AnafjxTNjJUAnp4LDTF1btMifRfn/yC7Fe7DnRzovrxQubfvoEj1YVG8OYeP/
 bWnkrBRsn1/WcBgb1+6kGDvGRUXFrAskrgwSyEzyf65/50IgEh7GR5CUMHICB5IbtL9s
 nkRmeQ4VihWVW0Sn1KgiYAdOTPPxICI+XqprbQDb5L0z72jib1iMtaeQi+2kyYD2ywg9
 5u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785603714; x=1786208514;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OB8KWZIB/3YGC3i1Uqf2+JxEt4tORwORhv7CppP9qmM=;
 b=ZKTEnVANyk/24KO3ZHrEpr8kAjypIdZiMOb3tpZH3B4g/k9W4U5RWa2T4Xm+WJlG4D
 SDHmjLG5kYpiDtZi6g/ckRyWaEd9dI46yy9DJDh70RAHgKbeI4VwLWu7tzvpu/lr6JlF
 7d3Q/4G+CBeEcuWXxf/KLjMqZ470AwgUsULMwDqAn7qUs6J6jD4+guL2ZcdDPS1hEo+R
 e1zIH94PxLKM8Zn9FMe53CZx+0vX6nBjKGv8X8MA2rq2Q0kaEJbhivldQO3SC7lnloQ1
 1+Csyrjag96Q659pW2852cNyIRZbm3rectuXwvlIcr/JiW4fE22SW1ZEMMPmmTRnr7IY
 feNw==
X-Gm-Message-State: AOJu0YwvdbNxpFnbcupyxB6dEj5xudajWOi9nUDRHlVa5wqZc56t0mHH
 L4Syt3iZUf73e2Nq+iqJ/GWD2ZiBsMiJMT1UR5p3NhjdD0Lz6y2DKm97fpsZRLxLS9k=
X-Gm-Gg: AR+sD13Yh1irulPcPjnkGtmdxl/4RVe5i5QmktKXWv4w9oshuZjd2GNjLUMb1iYIVAf
 v5ZSGeQehy1vlA+3tqCzRK9Jmm2b04lkSGOQFU0hXa3h4JjQHCeTSDh4lSOsksUKr6VgSk/5kRZ
 T9eMEzsFBDQqPCv02GIFVd/FBx3vfIwqr3OYQ+wFcQCJDlqyl7XQJS0kNRDQynXexS1g3ujDfqE
 PnlPLvAWe1/aTJE41WtvRHbP1++n/DQonpZ+Gagby4mnh17ouSNtmdLwfP9BmaoMsle12j6bho8
 ETGo7Wz4qVd4qD1SkdRplbc0Ywd2+FARjjmpjBOgoZaLSgyrtQYuhdzKPFqjxG4syNDgD4vvvi3
 OeYXKNL1sadj3WXyuM34f6iKFhFQeH0qjoh5ycbQzciwhbB0CAgGDNK8r6sr90L10vs8iD/xTwe
 culFrFfA9B59gv6cfrxWcUjEghAESvCK3pe1NwS1ToACMIZC0hGb5effBk6wyN1pUijOx5G0DIm
 FUYiFoD2Wh1ksvziXT1B6+DWI7oe7vH7vbaX1VfnA==
X-Received: by 2002:a17:90b:4c0e:b0:38d:c74d:29c5 with SMTP id
 98e67ed59e1d1-38fbc495711mr3523515a91.19.1785603713851; 
 Sat, 01 Aug 2026 10:01:53 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e04506csm19917136eec.17.2026.08.01.10.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 10:01:53 -0700 (PDT)
Date: Sat, 1 Aug 2026 10:01:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, <bruce.richardson@intel.com>,
 <konstantin.v.ananyev@yandex.ru>, "Vipin Varghese"
 <vipin.varghese@amd.com>, <jerinj@marvell.com>, "Maciej Czekaj"
 <mczekaj@marvell.com>
Subject: Re: [RFC 12/32] stack: always use C11 memory model implementation
Message-ID: <20260801100150.6e683948@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659AA@smartserver.smartshare.dk>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-13-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659AA@smartserver.smartshare.dk>
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

On Fri, 31 Jul 2026 16:53:45 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> +TO: x86 maintainers, ThunderX maintainers
>=20
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Wednesday, 29 July 2026 19.54
> >=20
> > The generic and C11 lock-free stack implementations differ only in
> > memory ordering. The generic version uses a full barrier where its
> > own comments state an acquire fence is sufficient, and seq_cst for
> > all length counter operations.
> >=20
> > Only x86 and ThunderX still used the generic version. On x86 the
> > switch removes a locked add per CAS attempt in push and pop; TSO
> > provides the acquire semantics. On ThunderX the pop fence weakens
> > from dmb ish to dmb ishld and the push fence goes away. Unlike the
> > ring, no platform selected the generic stack for measured
> > performance reasons.
> >=20
> > Remove it and use the C11 implementation everywhere. =20
>=20
> The lack of measured performance difference documentation is not a valid =
reason to remove the generic version!
>=20
> It would be reasonable to assume that x86 (and ThunderX) use the generic =
version for non-insignificant performance reasons.
>=20
> If there is no performance difference, I agree with this patch. Otherwise=
 not.
> This could be verified by providing the missing measurements.
>=20

Surprisingly, the performance of the C11 version is better than the old gen=
eric
version that had smp_mb.  That is because C11 code generates no locked pref=
ixes.
Gets speedup of upto 60%.

Between main (with rte_smp_mb) and the unified C11 version on the 32-core x=
86 machine:

Test	main (n=3D9)	unified C11 (n=3D9)	delta
single push/pop	46.62 =C2=B10.30	33.41 =C2=B10.10	-28%
empty pop	1.47 =C2=B10.01	0.98 =C2=B10.01	-33%
1 lcore, bulk 8	9.06 =C2=B10.05	8.20 =C2=B10.08	-10%
1 lcore, bulk 32	6.09 =C2=B10.02	6.15 =C2=B10.03	+1%
2 HT, bulk 8	42.05 =C2=B10.31	39.24 =C2=B10.52	-7%
2 HT, bulk 32	11.92 =C2=B10.13	11.89 =C2=B10.10	0
2 cores, bulk 8	78.90 =C2=B10.60	72.96 =C2=B11.11	-7%
2 cores, bulk 32	20.74 =C2=B11.56	7.70 =C2=B10.13	-63%
32 cores, bulk 8	6126 =C2=B172	6121 =C2=B189	0
32 cores, bulk 32	1953.9 =C2=B12.9	1984.6 =C2=B113.3	+1.6%

