Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE95D2ED17
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 15:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EC3A40E0C;
	Tue, 20 Jan 2026 16:49:00 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 1D0A44026F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 16:48:58 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64b92abe63aso10952976a12.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768924138;
 x=1769528938; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Savl1S39MeZQqbN4TwzKdNJH1W0D6XcQM44rJFqY0mE=;
 b=PfyOJULshtG/Tb1xPRJd9DXcLq5nHBkwOuWUMiiTfeDtBU2VmGVfnPYat4yynRvAMa
 N9nb8JSdhM1kkzo422U904x+F4l3L1VM9QCz6pS8cNFhhttABWgR1srWhtauIJMaCPiD
 T573PIOIZ+DssmLHXJQRnrVSANFzbGeO48cFj/1ynlSxGF8LV3POhcxXlolSDWCCtawO
 Lub7iMrQfs3UuQzX7NXQ7qoWkgTo0kcARsHpE/d6UoSA9QC589ehmanQ47Y9psMJGgRf
 N8VN30nUjlirQEEreJQRNmDbIPprY0+Ob48nl1UpBuUvGqO5FlJ6/uz+sF+hdFB9YI7+
 06UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768924138; x=1769528938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Savl1S39MeZQqbN4TwzKdNJH1W0D6XcQM44rJFqY0mE=;
 b=UmHVdZFd8XUAupLF3RL2Z88PiuW447ZjGVMO/ohmpcoZbdevPomoyNLQw7IMZjbNp+
 b3lEnIQOzmZ/40oQWFViR94dsjjn8vzuh5pC/ny7Hh10b3Ikas2M5QSqXN1msCDifiK6
 +XCtxLFt6SBl+rUYPfBSMv3ZfB2qUiP0cQAvqM5BDz77mVBs8WL9SbFAh9JOiy9Bskeq
 zhHlGKX9q3yg2jB/2N0ZcOsNN+UtXYJEtWhyoqEDDCK9TEt5zbZVNu5V22nKPNoQ1CEJ
 FABqEWGut9aGcW3D+SpnLz4AeUtm0W+bWQ1Bqh8cBZ3kxGs7eJA7kcejWZLTeiZGId1q
 Jxiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVshC4OnkK6jQBjYXuVFLlqt5bbGAwGfvs6ZgfD9zeSOq4WyMEp62bvMi7kvJ77vlr1lrE=@dpdk.org
X-Gm-Message-State: AOJu0YxC5NnCUiI1aEfO258YUH9sjKAda9VtbwDPU3k/xtqNTYbns/f1
 zdE5NDOqxZjYRwrnDEFin/tRfdTHEyNXMUwEJ3lMYRAPFyQ1tpw3j4Sw6xAdQzP8lMuKuVyVqqL
 SpOEO
X-Gm-Gg: AZuq6aKj7mEIeolLfmjX/w95xHws8zn0IVKLZsEipW7g+FWXPWwyoeTer+hZ3Qy2fJY
 VANcysBJZ47EM2rnUyxE7FV2+hlo18Szce/9+x0kurOz7tGUuS98y6PmItQL4q3NZiRtZl+vcGp
 n0XIgoXMq52upe+U4Hpq3TD+SnPGY6Pkje7nwtEozFSrAuG58VdMFc8gTTsCzsePrsCoy7I6H3Q
 BMCmg7PIuu8d65hAZ045LsvULLnluaw/KetP9OaKBZ8gee9TKkVubDPsoLYxIh6OINNo/p5NW1/
 i4iDmSv4nnyWPsWu2wZX693QiPNfYU1k7cDG7XDA35UnVZDsHc1Jw44UK4D+NXUPwXPAEFb5BIU
 qbUW6eN6uAUmEYeiLDoGUWXhGKPFfPnLzG0qC1UBFEEhPUr6o1mGnMo4XRhJRfY8mwMTlPFdRBG
 17/F8g4aB/+E5yRxCx5BRzgk4+jOkOZpGgbVQ9oqmFhfSkawv0cGbX
X-Received: by 2002:a17:907:c807:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-b8792e099b4mr1194714066b.9.1768924138371; 
 Tue, 20 Jan 2026 07:48:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452cdb0e4sm13460284a12.13.2026.01.20.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 07:48:58 -0800 (PST)
Date: Tue, 20 Jan 2026 07:48:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Subject: Re: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Message-ID: <20260120074851.7d091304@phoenix.local>
In-Reply-To: <d9a4cead8c8e473e907f604b98370013@huawei.com>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
 <20260116064646.224254-2-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65669@smartserver.smartshare.dk>
 <20260119144821.70e2ff35@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F65674@smartserver.smartshare.dk>
 <20260120063413.72e0d725@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F6567F@smartserver.smartshare.dk>
 <d9a4cead8c8e473e907f604b98370013@huawei.com>
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

On Tue, 20 Jan 2026 15:40:21 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Tuesday, 20 January 2026 15.34
> > >
> > > On Tue, 20 Jan 2026 09:49:44 +0100
> > > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> > > =20
> > > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > > Sent: Monday, 19 January 2026 23.48
> > > > >
> > > > > On Fri, 16 Jan 2026 10:32:52 +0100
> > > > > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> > > > > =20
> > > > > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > > > > Sent: Friday, 16 January 2026 07.46
> > > > > > >
> > > > > > > When building with LTO (Link Time Optimization), GCC performs
> > > > > > > aggressive cross-compilation-unit inlining. This causes the =
=20
> > > > > compiler =20
> > > > > > > to analyze all code paths in __rte_ring_do_dequeue_elems(), =
=20
> > > > > including =20
> > > > > > > the 16-byte element path (__rte_ring_dequeue_elems_128), even=
 =20
> > > when =20
> > > > > > > the runtime element size is only 4 bytes.
> > > > > > >
> > > > > > > The static analyzer sees that the 16-byte path would copy
> > > > > > > 32 elements * 16 bytes =3D 512 bytes into a 128-byte buffer
> > > > > > > (uint32_t[32]),
> > > > > > > triggering -Wstringop-overflow warnings. =20
> > > >
> > > > The element size is not an inline function parameter, but fetched =
=20
> > > from the "esize" field in the rte_soring structure, so the compiler
> > > cannot see that the element size is 4 bytes. And thus it needs to
> > > consider all possible element sizes. =20
> > > > =20
> > > > > > >
> > > > > > > The existing #pragma GCC diagnostic suppression in =20
> > > > > rte_ring_elem_pvt.h =20
> > > > > > > doesn't help because with LTO the warning context shifts to t=
he =20
> > > > > test =20
> > > > > > > file where the inlined code is instantiated.
> > > > > > >
> > > > > > > Fix by sizing all buffers passed to soring acquire/dequeue =20
> > > > > functions =20
> > > > > > > for the worst-case element size (16 bytes =3D 4 * =20
> > > sizeof(uint32_t)). =20
> > > > > > > This satisfies the static analyzer without changing runtime =
=20
> > > > > behavior. =20
> > > > > >
> > > > > > Using wildly oversized buffers doesn't seem like a recommendabl=
e =20
> > > > > solution. =20
> > > > > > If the ring library is ever updated to support cache size =20
> > > elements =20
> > > > > (64 byte), the buffers would have to be oversize by factor 16.
> > > > >
> > > > > The analysis (from AI) is that compiler is getting confused. =20
> > > >
> > > > That would be my analysis too.
> > > > =20
> > > > > Since there is no good
> > > > > way other than turning of LTO for the test to tell the compiler =
=20
> > > >
> > > > There is another way to tell the compiler: __rte_assume() =20
> > >
> > > Tried that but it doesn't work because doesn't get propagated deep
> > > enough to impact here. =20
> >=20
> > Does this fix generally imply that when using LTO, using an SORING with=
 elements
> > smaller than 16 bytes requires oversize buffers?
> > That's not good. :-(
> >=20
> > The SORING is still experimental.
> > Maybe the element size and metadata size need to be passed as parameter=
s to
> > the SORING functions, like the RING functions take element size as para=
meter
> > (except the functions that are hardcoded for using pointers as element =
size). =20
>=20
> Personally, I am not a big fan of such idea...
> Wonder is that possible just to disable LTO for soring.o?
> Another thought - if all the problems come from 128 bit version of enque/=
dequeue,
> would using memcpy() instead  of specific functions help to mitigate the =
problem? =20
>=20
>=20

Not sure if disabling for single file works.

My goal is just to make LTO build work without any warnings.
LTO has proved useful in finding bugs where arrays are overwritten.
