Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C634CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 16:25:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 407D2402F1;
	Tue, 26 Aug 2025 18:25:38 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 749FC402E4
 for <dev@dpdk.org>; Tue, 26 Aug 2025 18:25:37 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45a20c51c40so45211295e9.3
 for <dev@dpdk.org>; Tue, 26 Aug 2025 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756225537;
 x=1756830337; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abRXREuyj1H2nvV8ra3H4K8OBuEuNL0pw9o2TpLKnGQ=;
 b=gE7tg1TodhSbxTu6aF1OmHrUpp28xDtlGKAZezFxYB7wrXaZ6237QhFM7/aEF+l0dl
 f4hln0G/CMcIlf5z1HcHNbnowkCtKGhnxOjK0AmiV/zMm/n+gQaQqqfU13ihhdV6t6/J
 CxOp+j5iVu3qpTCj/ULDWZTGRxBkwgaf+HS7GC0fUk9/r04I1pyskrRypmmN2hvxhg5d
 POUqZKHcEnjSpHDG2h1s2mpcEjFWGF5Bn5jr8YP/9pnjXMX6QOGtAxZrJR+xkQ6l7Bry
 aAsWrp9z3QFN3Kc+PXpriWhemxs7PMASextzi5Fy5pUJX65rPb2xAInc3m+5IspwvKjf
 4Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756225537; x=1756830337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abRXREuyj1H2nvV8ra3H4K8OBuEuNL0pw9o2TpLKnGQ=;
 b=cLhz5OGQCriyskhzQGOZgqQhDTw+AnxTy28KOW74wJ9HcTuMx8M0CJcfhzZQJttEBF
 fhRZtNpbmh6Iqi3KOJ730nBFIMta+bTJhrMXHXFK1iJNtAOp7r5C9JRl7VwSeIs7K/6w
 9shHhwhx89EVPSAx8EKGjSHl01Hs+1tWHveIWNPIbqp3RJ/yj0i6eQlmA+frWlygcmwX
 7JybQgPsJzwm+k8+5Lt0B4SIWzLegUrDs+a25LY6SM8fduoDBt/OtS17ZEy/gczl+HgL
 jfd6rvwLIyt9crof72J2XKKlm1KN9UNTMQvDJNP+dtzvS1e4+zTlzRvWFXV1vJY4jAZC
 wmlw==
X-Gm-Message-State: AOJu0YxlDBRlTDgVrRuZUMjfs9QOV+M4ozVD8lo1nhvnLlX4JmyE3dhx
 YrL0flQUzvowYB+J5sOzTNwLxVJ1zVi/Ip8C4PTsm2XqPczgYke3pCwqOA41GuaM3wQ=
X-Gm-Gg: ASbGncsjH8FIXZAz9ItwOL1Ft6YSSHwnp8in050oiIHTRyTc+gYAQSoFGdcfY7QSyWq
 jaaE38dn72f3YaSQ/kJ6nS1bHNkvn4vHlSNIooPJqQ+CZKFI6Gnn0Hk1ZKy6BXYvFtdsBm50rLq
 gpj3IO9/GDXxSwAPrZqHsbHA2PqQssP/ze46n52lJldHFF5rsxo8Xagt6JeKx4pRjba09jEYF7E
 6REWsv5E2tLZ+DFYwkNZe/mrjZ//5dXWn2GdPv3+4YyiWGXqtDPoQHXLMuGon+yUmPRRudKkMV+
 5egdG7WKUPs+eh1UW48hGy/BEjUzJv0SVoIvZeTNABVbjUwhTHs4h1zRaFD6V2G2Rv1uFlhrvty
 H561Dldia3zO774lCPja73k+ix7bE+oe3iUFTKr8HA13hwOKSbo1pe9hq9lhHBiaNxyBWCNkuku
 s=
X-Google-Smtp-Source: AGHT+IGWvAz3k7QlvVoQw3efk4AjMMKcJss6MEIB+MjqykibcbggatyIPtBGiP0O07CfUxcKgrWEwA==
X-Received: by 2002:a05:600c:3b23:b0:45b:47e1:f600 with SMTP id
 5b1f17b1804b1-45b517dc59bmr141019325e9.36.1756225536763; 
 Tue, 26 Aug 2025 09:25:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66206a55sm18030605e9.3.2025.08.26.09.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:25:36 -0700 (PDT)
Date: Tue, 26 Aug 2025 09:25:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>, Yipeng
 Wang <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 3/4] hash: reduce architecture special cases
Message-ID: <20250826092530.1167e741@hermes.local>
In-Reply-To: <05cd927d-e4e9-441f-b247-0bdc138c8de0@lysator.liu.se>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
 <20250822182110.27599-4-stephen@networkplumber.org>
 <05cd927d-e4e9-441f-b247-0bdc138c8de0@lysator.liu.se>
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

On Tue, 26 Aug 2025 16:36:38 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> On 2025-08-22 20:19, Stephen Hemminger wrote:
> > Make comparison of sizes compatible across platforms.
> > Keep the special case code for 16 bytes for x86 and arm64 but
> > also add simple xor for others.
> >=20
> > Need to keep rte_hash_k32_cmp_eq() exposed because ip_frag
> > code poaches it.
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >   lib/hash/rte_cmp_arm64.h   | 56 +------------------------
> >   lib/hash/rte_cmp_generic.h | 35 ++++++++++++++++
> >   lib/hash/rte_cmp_x86.h     | 60 ++------------------------
> >   lib/hash/rte_cuckoo_hash.c | 86 +++++++++++++++++++++++++++++++++-----
> >   4 files changed, 116 insertions(+), 121 deletions(-)
> >   create mode 100644 lib/hash/rte_cmp_generic.h
> >=20
> > diff --git a/lib/hash/rte_cmp_arm64.h b/lib/hash/rte_cmp_arm64.h
> > index a3e85635eb..2b2a37ebd2 100644
> > --- a/lib/hash/rte_cmp_arm64.h
> > +++ b/lib/hash/rte_cmp_arm64.h
> > @@ -2,7 +2,7 @@
> >    * Copyright(c) 2015 Cavium, Inc
> >    */
> >  =20
> > -/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
> > +/* Functions to compare multiple of 16 byte keys */
> >   static inline int
> >   rte_hash_k16_cmp_eq(const void *key1, const void *key2,
> >   		    size_t key_len __rte_unused)
> > @@ -27,59 +27,7 @@ rte_hash_k16_cmp_eq(const void *key1, const void *ke=
y2,
> >   static inline int
> >   rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_le=
n)
> >   {
> > -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> > +	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
> >   		rte_hash_k16_cmp_eq((const char *) key1 + 16,
> >   				(const char *) key2 + 16, key_len);
> >   }
> > -
> > -static inline int
> > -rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
> > -{
> > -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> > -		rte_hash_k16_cmp_eq((const char *) key1 + 16,
> > -				(const char *) key2 + 16, key_len) ||
> > -		rte_hash_k16_cmp_eq((const char *) key1 + 32,
> > -				(const char *) key2 + 32, key_len);
> > -}
> > -
> > -static inline int
> > -rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
> > -{
> > -	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
> > -		rte_hash_k32_cmp_eq((const char *) key1 + 32,
> > -				(const char *) key2 + 32, key_len);
> > -}
> > -
> > -static inline int
> > -rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
> > -{
> > -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> > -		rte_hash_k16_cmp_eq((const char *) key1 + 64,
> > -				(const char *) key2 + 64, key_len);
> > -}
> > -
> > -static inline int
> > -rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
> > -{
> > -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> > -		rte_hash_k32_cmp_eq((const char *) key1 + 64,
> > -				(const char *) key2 + 64, key_len);
> > -}
> > -
> > -static inline int
> > -rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_le=
n)
> > -{
> > -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> > -		rte_hash_k32_cmp_eq((const char *) key1 + 64,
> > -				(const char *) key2 + 64, key_len) ||
> > -		rte_hash_k16_cmp_eq((const char *) key1 + 96,
> > -				(const char *) key2 + 96, key_len);
> > -}
> > -
> > -static inline int
> > -rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_le=
n)
> > -{
> > -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> > -		rte_hash_k64_cmp_eq((const char *) key1 + 64,
> > -				(const char *) key2 + 64, key_len);
> > -}
> > diff --git a/lib/hash/rte_cmp_generic.h b/lib/hash/rte_cmp_generic.h
> > new file mode 100644
> > index 0000000000..f846d562e3
> > --- /dev/null
> > +++ b/lib/hash/rte_cmp_generic.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(c) 2025 Stephen Hemminger
> > + */
> > +
> > +#ifndef _RTE_CMP_GENERIC_H_
> > +#define _RTE_CMP_GENERIC_H_
> > +
> > +/* Function to compare 16 byte keys */
> > +static inline int
> > +rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len=
 __rte_unused)
> > +{
> > +#ifdef RTE_ARCH_64
> > +	const uint64_t *k1 =3D key1;
> > +	const unaligned_uint64_t *k2 =3D key2;
> > +
> > +	return ((k1[0] ^ k2[0]) | (k1[1] ^ k2[1])) !=3D 0; =20
>=20
> Remove '!=3D 0'.
>=20
> > +#else
> > +	const uint32_t *k1 =3D key1;
> > +	const unaligned_uint32_t *k2 =3D key2;
> > +
> > +	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) |
> > +	       (k1[2] ^ k2[2]) | (k1[3] ^ k2[3]);
> > +#endif
> > +}
> > +
> > +/* Function to compare 32 byte keys */
> > +static inline int
> > +rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len=
) =20
>=20
> eq -> neq not worth the trouble. Correct? Some other patch set.

ipfrag is still poaching on these, so not changing
