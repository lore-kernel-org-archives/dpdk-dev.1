Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB03CA5FB2
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:52:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88B0240ED9;
	Tue, 20 Jan 2026 17:52:15 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 7357A40E0C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 17:52:14 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b8715a4d9fdso775886166b.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 08:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768927934;
 x=1769532734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lcof0tCQHPokIAAyPRwXrJzkYKmcd1a7lF+iWDHiHOo=;
 b=dLw7n7K0nNkoSN7Sj0E4w8UbGRSYyqws7C3cBHDRPe4vmaj3Eul9/XbOKTPLOc7lpi
 brKuP33DPJFyHJRFw87kNsMB4QO4Qu9I4xl3FbzAhezDxLWFzQ/R0jffuISn4Wdh/G+7
 61jxzT2llFbunX7H6Unw7Rr40jfbHHcMenJKGWvp61o67fpDfhCs8Z6S8TbS2cy/vx4R
 8i9+LqrrH4bpm5XJrS+zg3B2p0T8UeYDJBc9g3XIM5cmcoIqx0hBNIP8OA7ahzwBdxKH
 qwZK5qxtR8etGGbFcTHj3SCWBjXmTxk5/CgakTnzkQs313QJpEv0/kAtLhLhlEw4EqHd
 93tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768927934; x=1769532734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lcof0tCQHPokIAAyPRwXrJzkYKmcd1a7lF+iWDHiHOo=;
 b=AQkfRpiApUJbuFfwJxIYfRnlIvA+4ECPKaCaemSislTAtcGmPfoxNeG1msmB3hTOSI
 32qyFcfdzf8KrBNb/fH5B1cGhPc4xv4zt/fU9+m7WaEGlkw0SIV94cqyiTBWu8uuPqTB
 YzHEJ5P33/TDAySPY6OB9rKFc5CfHHfaVJCx7xEwGl0H4ZsILuomPQqqdLmN9r6zf9Ut
 xvphr9Z306IwDddTkpo4WSEGa7s41YjIwdTYCdBbaBWbMVUJequCZstYv8V+2uIeG/5K
 9jXY3PeXqlZY211C1AnDHNrVixH9y4cC7bQjlcYe0161MfF5WxWkKde+0S8biM6E+O8k
 MkBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuNAHII45ilT9aErUgMkKfri57hdd8xd1dpQ/cClAXCdSPwKecBeJ+8eJKwedATDAtZA8=@dpdk.org
X-Gm-Message-State: AOJu0Yw9NIB20atEC+DvWB+qmBxLdRwj+yqbIMboFpGmARYkdiXMLsX9
 7RhPb65PC71WSJ2WR8f9c2yQm4euXdKhz9B6Ewp121im03LJjb8zV4t0tAQZK5+6MJ0=
X-Gm-Gg: AZuq6aJH5f+ZDTmfGp/NMJPY2vrv4OeyQ8F0AtDuIQwRZhOdziGFSZj219SrXTdBGA6
 1Xw5T1MGfNmW5undHMIHfk/3l0KKacAHnrWjHnKsHkYIIRNrWane98soc6QusIsBsUtIxq6bT+k
 bgV3Thr8f6Z6aZ9r5GW0rhWS/V6bNI/0HClZOZq+o81iKU58GOrI1/tTTd8fdgFc6Yx7wcLVSR3
 Xbkay8yHoG40L4VghNJhPOzW/uLvLhp/LBpiixp+Tlgy8GEMZ0NkUUUiO+ggSTqM0cPI61Y/Ipu
 y/1fnUG9qwnfCfCWg7Oat5Trse7yUVGMoHCA4CTfQpBy2wkab99ENqK1OAwyfLueVeZGZoqHlwi
 L6vmKqNeliQXD/rz6M9bRoHnh51VLFtdribw5BVGZWWD5oFiRbK40HK2koPI50VNrop2yo+vMJ4
 1iZh2MDmp4xY7vaxxhza7KsKt4QB9/036uqMZyJBZHe1ZLs0Opz4ED
X-Received: by 2002:a17:906:c112:b0:b74:9833:306c with SMTP id
 a640c23a62f3a-b8796b40f87mr1153214066b.47.1768927933650; 
 Tue, 20 Jan 2026 08:52:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a192b6sm1439947866b.59.2026.01.20.08.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 08:52:13 -0800 (PST)
Date: Tue, 20 Jan 2026 08:52:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Subject: Re: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Message-ID: <20260120085207.722bebe3@phoenix.local>
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

I did some more experiments using pragmas, and attributes.
The good news is it works for some versions of Gcc,
the bad news is that pragmas and optimization changes on function basis
seem to crash old compilers, and be disabled in Gcc 16 and get:

../app/test/test_soring.c:154:1: warning: bad option =E2=80=98-fno-lto=E2=
=80=99 to attribute =E2=80=98optimize=E2=80=99 [-Wattributes]




