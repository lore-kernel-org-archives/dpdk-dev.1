Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61183CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 16:12:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C074029A;
	Fri, 22 Aug 2025 18:12:55 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 82AC640297
 for <dev@dpdk.org>; Fri, 22 Aug 2025 18:12:54 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b9dc55d84bso2041567f8f.1
 for <dev@dpdk.org>; Fri, 22 Aug 2025 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755879174;
 x=1756483974; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEFd/WeU8Ndt3hJp8KVD8sCnGPvB5NLHoDw6cKY36Qc=;
 b=fmPIKWH0apSEz0mnYIVs//YqnnVOz0VqdRMoPP9HXUpNdpY3+O5N+c8dlg/gy+wyEt
 nIgd+37tZWcnxkE45KwJxP49cdzQwc1LebTrQWeMXpxkceHohZbK0xLDFlRUe8aDGMi6
 ZuIAQFf2p20BQrAan4ava8kO1GA0gO/AunlWJOFBrUPfoA8mutvfsDU6eICD8aj7f+kL
 Niw8si5q6gJEL8bEqxPN2oBuLTQr2SHfMoW4xu583UHCuCCcplikjkt5/D1lRi3PjB78
 +DOjRxFdbpZQaYlcWX5kXZHYtADWCRROfNRc7In2cE52yYdti/vZua+Uo6ynFNhM4Jyz
 lPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755879174; x=1756483974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEFd/WeU8Ndt3hJp8KVD8sCnGPvB5NLHoDw6cKY36Qc=;
 b=pt3AHp7oA8C9z9X0hZw8SKEFSKwo9S1CDxBz88+D/zzsYkG4yM/sfKq2PN/wu8MpjT
 qHmBIkfiMqiNfooMXTfBZWYHdnN9VV6jVWzX/ZNyxsYMtIVRNL3bt2qH5cCWrKZMR+sm
 PvqvUYWGuZMlMXBEvu9ImFCcx9oKcGGP7r24z+BjFjPR8tkWHygd6oUq6a1r4dUO8QSV
 NN3g1w9AySwcATFbjzG+IViKk0erz5RZCCPp8Db0iWaUgn4NtY/UwYj1cjE9Vp6DNC5X
 edDziKa2JHBINowZII6mQZ8Hgxk29HLWB7ewf9Di9E6ZZDfLtTqwPJNoRv+KTB1uDRUQ
 DrqQ==
X-Gm-Message-State: AOJu0YwftplzMdcpymxCq1Yxzz9s0HHZec/l3C8MCCDscBJy+hPoufs1
 lSDQThAe/wgNQXxpj6/79HLjZI3XkwVfG1FYyvRIpRRh8FFQV17StZwGfgyz4EjXy84=
X-Gm-Gg: ASbGnct/ZzYM/cmSl7hYGCdt9QMdQbH1e1yKQeriqOE2Ioyfvwct+JdyejuudBQpZ81
 Jtk1YtSHvNaiTboZ8KrH3BSMoK8p7dpy7WshnMIBi2y2KiW1Sfsx73XTUxTxqEMOzFJE6h5UdSo
 5WG22OJH3SjWWRU3J7gQXLWE+6sKPenP+FWlcdeycbWJcv5jP1ndOGnlnSHZiQuYJbbT7qhayqt
 /zwpt3gyqNezIHk/WXdJWnMfPTgEvN+rIcFsFIqKSFxVcuSfg5vV68AWmCAP7Pkfl22Eifo5vO0
 XsnCyx5QDhqj8u2qBI9waY/w4vfdUgMzIKjYhh6thJ27YdxiJtgE56O1uBerX3CH4eVhz31P2I1
 vN5VH7zFYLJbTi/lqiFp6cxCu3gpvsYX1k16JI3g/aDoXH9Cju4HHKePQAR3oaWabsLYtXegmOg
 5sxhAIzxhUlA==
X-Google-Smtp-Source: AGHT+IHLvOR6DonJyC4kJPx+MOT8YBix9ByyHpBfYqQmpP0abWTaDSFxW6cqJwi0UIJU6vAFMtuUCw==
X-Received: by 2002:a05:6000:2012:b0:3b8:f2f1:728c with SMTP id
 ffacd0b85a97d-3c5dcdfe0dfmr2147948f8f.34.1755879173653; 
 Fri, 22 Aug 2025 09:12:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e3c589dsm52935f8f.11.2025.08.22.09.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 09:12:53 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:12:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [RFC 3/3] hash: add support for common small key sizes
Message-ID: <20250822091247.0d6cad04@hermes.local>
In-Reply-To: <5427c6f3-4446-4ee3-909e-5f2925d2b286@lysator.liu.se>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250821203646.133506-4-stephen@networkplumber.org>
 <5427c6f3-4446-4ee3-909e-5f2925d2b286@lysator.liu.se>
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

On Fri, 22 Aug 2025 09:19:45 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> On 2025-08-21 22:35, Stephen Hemminger wrote:
> > Add new compare functions for common small key sizes.
> >=20
> > Bugzilla ID: 1775
> > Suggested-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > Reported-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >   lib/hash/rte_cuckoo_hash.c | 54 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 54 insertions(+)
> >=20
> > diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> > index 3212695d92..825889c320 100644
> > --- a/lib/hash/rte_cuckoo_hash.c
> > +++ b/lib/hash/rte_cuckoo_hash.c
> > @@ -49,6 +49,11 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
> >    */
> >   enum cmp_jump_table_case {
> >   	KEY_CUSTOM =3D 0,
> > +	KEY_2_BYTES,
> > +	KEY_4_BYTES,
> > +	KEY_6_BYTES,
> > +	KEY_8_BYTES,
> > +	KEY_12_BYTES,
> >   	KEY_16_BYTES,
> >   	KEY_32_BYTES,
> >   	KEY_48_BYTES,
> > @@ -86,6 +91,50 @@ rte_hash_k32_cmp_eq(const void *key1, const void *ke=
y2, size_t key_len)
> >   }
> >   #endif
> >  =20
> > +static inline int
> > +rte_hash_k2_cmp_eq(const void *key1, const void *key2, size_t key_len =
__rte_unused)
> > +{
> > +	const uint16_t *k1 =3D key1;
> > +	const uint16_t *k2 =3D key2;
> > + =20
>=20
> What we do now is to require the keys are 16-bit aligned (which wasn't=20
> the case before).
>=20
> You could
>=20
> uint16_t k1;
> memcpy(&k1, key1, sizeof(uint16_t));
> instead.
>=20
> Would generate the same code, but be safe from any future alignment issue=
s.
>=20
> Anyway, maybe it's safe to assume the keys are aligned, so this is not=20
> an issue.

The keys are always in rte_hash_keys which has the key field aligned
at uintptr_t.

>=20
> > +	return k1[0] ^ k2[0];
> > +} =20
>=20
> Haven't you implemented "neq" rather than "eq" here? If the keys are=20
> equal, the result is 0. Should be !=3D 0.

The functions use same return value as memcmp() which returns 0
on match.

>=20
> Would it be worth adding a comment like "use XOR to make this=20
> branch-free"? It may not be obvious to all readers.
>=20
> That said, I=E2=80=99m not sure this trick will actually change the gener=
ated=20
> object code - especially if the result of the eq function is still used=20
> in a conditional afterward. Anyway, keeping it seems like a good=20
> conservative approach.

Compiler is not smart enough to get past the array of functions
to optimize across that.

