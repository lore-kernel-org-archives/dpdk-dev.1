Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBAD26293
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 19:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3E2540E0C;
	Tue, 20 Jan 2026 20:27:36 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id A44634026C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:27:35 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so28596885e9.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768937255;
 x=1769542055; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSVPK8Sf6XjKALrDkp+hh0Mz1QhLE7RZ7LqOeznCees=;
 b=zm0tguoZg1scTsGXS7zi3lUuPsefNWLhwfw59u4AZ4hbD2RoQUqx/BTWcAv0L5vWVK
 xun5Mqbl/B81B6NqUezVeKSHjezWc8//DVBpCHzMC/gIURupZp+nUGWT0QHHba5ThsFf
 MtWiPlrieURKYz/+iGlCDz/WIbqjEVaUCrpY5Riw0h5gRkhmMwfuZqdl7z29JZjt42AG
 Yh/tlNylLQDBWCWEJZjYjWWgSc16jZzc32bjdX4bAFwXrBBOmeU/IIdzD3KPHfxMgbRW
 JaTGMVs59/7IYnSTmZws8jpvYwEY4y12ijL2DV36ykVUe/MDX8TnOBXiQt0Q8TZzkvMm
 P0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768937255; x=1769542055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kSVPK8Sf6XjKALrDkp+hh0Mz1QhLE7RZ7LqOeznCees=;
 b=TA2sgl5eXhZPeSh2UPLeGvHN8XSC8fir3StSp79BtK+8FBsavVy3ODmuvbGbEvb3tu
 HAGoCuGbmHnqH41Qh84YLHXG8QmQ1DhGowpNZAJjaZUovZaNAyAKs8KR34nZDIbDImKp
 IM7aRMUI84jHy6hrIvwCGSbIsPj7CoidWEokK5wfCCBOr7LU9qNgQ9qK4b0lRukZ6jg5
 XkIOkX/i15KT8EWMyPDVrYbJ/bqeMSDyu0GA1hFDbkcXlz3o69Cfpi6b46vRcn61OkIY
 Aslnv9iBi7gIHFO3VTWBGtoJ/A8+/1y2h9sM8UUvtJHpGiGxLxvftlPfqftTEa3YIHSB
 m86Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY5R4/yAEXGJ6mi9J+pS6Mxvd8bS6BpAgfZQJ5dEXfJefWK7Xp4bvCS7DrbLb0k6Vk8/4=@dpdk.org
X-Gm-Message-State: AOJu0YylEGF9E38OxDFbycZKaekxsDzAZXDgCANWEFfDOKZLZJepqo7m
 D+UWszRuCLpP4RZyaCY68LF34vZLkH6WpESUEAb8nlcxM1eKSWn6iYRQnyIWSNuekEw=
X-Gm-Gg: AY/fxX5Y+aONZQZSNCOEsWebwx8wTPZo767Xdc9eaCsn80mD0yYs/saYhwoVMPP5z1Q
 Ij5Nz0OehjblLYdxcbpKn2lysHNEIR2TnXM5kX0PFHLVueApUwa4ZTHqleq90N4ovuBDuk50RKL
 17MihHv/xzdl0eVQyEHzzd9YnKYa98F1fxKackgOP/CAetfZKQvkEjZsq7xHQ5wmd1j+BP8m1Xg
 aik9N8hy9L9ah0gqzn8JRoH5ixEP7NW22MKgFbqRvhKv0gQeHrRyd8q3xO6K7KVbK4ALRP30RU5
 PAak2cwqBG4ej3vdj+2tG1W7Pbh9vbxT1NCxH+oNKzYwzmOQvkETvGydncBeRJr9e8OsjxwUipT
 fBrR0tyFg7WRpkmShUBwDg5vipD8ViYVzjHabO6GFC8xGfYLx1qVdbL/bCLxd7knVcnQHevrb0e
 P3xw2L1efMYMrJndpSrGr/Ci7/kokM1g1m7ndAudK6kgrDLXkEA+aQ
X-Received: by 2002:a05:600c:548a:b0:477:1bb6:17e5 with SMTP id
 5b1f17b1804b1-4801eb10f27mr178956725e9.30.1768937254889; 
 Tue, 20 Jan 2026 11:27:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c05c3sm255945125e9.11.2026.01.20.11.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:27:34 -0800 (PST)
Date: Tue, 20 Jan 2026 11:27:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
Subject: Re: [PATCH v3 1/6] test/soring: fix buffer overflow warnings with LTO
Message-ID: <20260120112728.146e63b4@phoenix.local>
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

A much simpler and clear solution is to just get rid of __rte_always_inline
and use inline instead. The compiler still inlines a lot but it can make its
own decision.

The attribute always_inline is not always faster, in fact in real world
applications it can make things slower because real applications get i-cache
misses and lots of inline expansion makes it worse.
