Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C33FCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 20:15:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 889944064A;
	Fri, 26 Sep 2025 22:15:55 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 68BEF40277
 for <dev@dpdk.org>; Fri, 26 Sep 2025 22:15:54 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4dac61ed7a5so20327211cf.3
 for <dev@dpdk.org>; Fri, 26 Sep 2025 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758917754;
 x=1759522554; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TH+56s+sSOQ8ILaTxJuXNYQSlIgdcULczX6PJV7IYo=;
 b=pph+rwjNlNoDkkz60GvyLSnwI5oMnkzgwUU9gSOT4SpLpHE4eaqQdcDE5HzOgjytQI
 Z5Lcc4KPHqrxYKpvzeas/S6cW/0ySJWNFzr2o62lfzWLe+oU7saKo61R+v+h1NY3kx4S
 qzl+EOAuFKDd39DvqkFcb03XSBV8hbiIeM1g4lXJXKMNMdigb9eghCweVX1ASZANEWPv
 FjrGQ2y2+lom0ii4fRfwGh8+oULHBaTRueoF1S1hRmeYfkZYd5FKZieDnrkxaBARueiU
 ylnD8e3RJSuFy4OL0TwU6ZlsnZ+0ZJcOeBhKzBsYxmkzIM3OsvPgsp2889vnk3Bs8K4i
 RBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758917754; x=1759522554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TH+56s+sSOQ8ILaTxJuXNYQSlIgdcULczX6PJV7IYo=;
 b=rfBfU1M395iN7w80sBa3t4Z27oBlQLVTS6qBiWVku3BF52LATU1cxiMdYAnK+TMBGF
 UboZj1NaGuv1l0wdvta5ZqnNJaA6tubI/tN//42+UbuGbTIAnVfwxN1LetK4KirUUtpK
 x8rp74aQoT74FzGPqZi0GbbmiiPtaPh+Nlq5WTUKJfI8sJ3ihJHQt11lHS+TWHg+ZxTk
 7alEdcpQ1nG9xQPn8UJuBKF1Hih4piH0sbKlbHU7/XqEVPzF9rC13sgD/DrP1p/06GKj
 PMwriZvwqOHq4jzLT/oj68DerAJ1HhK+dgRSzYhab/orEvXyFCZTq4lMFi6dtJjfs6lj
 bp1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEiPonpPBnK8zv2tihHF0WXnmH5rA+A+duJJLfq9SSs9UJGZifRbT0xBhx81fE6himsik=@dpdk.org
X-Gm-Message-State: AOJu0YyXCb5Cue6o+FyTe/0O3IvywpkMqbGgFAmpVmvkLC8g+wuAGUQv
 L6Pcn1AHTMKK5PF7Kj7FbmFEmg8X9qLJIWVmIR44sZBoxwunTcHfCWJHjYenTW8GsoE=
X-Gm-Gg: ASbGncvFt7jaMXRI6ABekLtqGTaLXSeIYjSkwHoi+of4kmSWYZO1a2Yae07PQ1u7gdZ
 3apiHpHbAFsT2AoV5B1b5ciWQSwP1sTh/fEsJe9DoKhrNDCoh7FeQR4uASVFZGIo7c6u+G2JKhl
 4KXmtNlq5Lyx4FNjKdVk51YolcgrTSToHiNYeTLrKFZ2e4reZurTL1ZEl9dtjEJoj7uMMSR4ASw
 WxXQkja5y7H/BvIgXrphyKmWTIBHUQRcPYFULCGZCGQHcDdmGzJ399fUtsUOJGY3Qy4WO1lcqGp
 4Q8Y5VJLs+1SlfcU/qZHYiquuxrtdYxWSStdLC7IsRBrRtbJEHuBXw67IZvAbC1IYXaV6qvOKP8
 ATblVQfZmUenlmdSg25o40CXDvs+drN3/F0PU6JNfBa62zBIgh4vukGDX21Ni1nfETitQp9++n5
 w=
X-Google-Smtp-Source: AGHT+IGdJkJAtl5cvBolTOo8k7sde/rQLBOwyAxahh9JzVmaAIp6ZoxcCM9C1064i9Hp8gSNZEBwsA==
X-Received: by 2002:ac8:57c9:0:b0:4d9:186f:8503 with SMTP id
 d75a77b69052e-4da4dcc0bc2mr125597771cf.81.1758917753485; 
 Fri, 26 Sep 2025 13:15:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db11ce0e76sm31692441cf.48.2025.09.26.13.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 13:15:53 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:15:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Kai Ji" <kai.ji@intel.com>, <dev@dpdk.org>, <gakhil@marvell.com>,
 <konstantin.ananyev@huawei.com>, <bruce.richardson@intel.com>,
 <thomas@monjalon.net>
Subject: Re: [dpdk-dev v3 1/2] eal: Add rte_consttime_memneq() to prevent
 timing attacks memcmp.
Message-ID: <20250926131548.3f971417@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6547B@smartserver.smartshare.dk>
References: <20250926154905.54416-1-kai.ji@intel.com>
 <20250926160209.56496-1-kai.ji@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6547B@smartserver.smartshare.dk>
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

On Fri, 26 Sep 2025 21:17:08 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Kai Ji [mailto:kai.ji@intel.com]
> > Sent: Friday, 26 September 2025 18.02
> >=20
> > Bugzilla ID: 1773
> > https://bugs.dpdk.org/show_bug.cgi?id=3D1773
> >=20
> > Signed-off-by: Kai Ji <kai.ji@intel.com>
> > ---
> >  lib/eal/include/rte_common.h | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >=20
> > diff --git a/lib/eal/include/rte_common.h
> > b/lib/eal/include/rte_common.h
> > index 9e7d84f929..ddbba083be 100644
> > --- a/lib/eal/include/rte_common.h
> > +++ b/lib/eal/include/rte_common.h
> > @@ -700,6 +700,40 @@ rte_is_aligned(const void * const __rte_restrict
> > ptr, const unsigned int align)
> >  	return ((uintptr_t)ptr & (align - 1)) =3D=3D 0;
> >  }
> >=20
> > +/**
> > + * Constant-time memory inequality comparison.
> > + *
> > + * This function compares two memory regions in constant time, making
> > it
> > + * resistant to timing side-channel attacks. The execution time
> > depends only
> > + * on the length parameter, not on the actual data values being
> > compared.
> > + *
> > + * This is particularly important for cryptographic operations where
> > timing
> > + * differences could leak information about secret keys, passwords, or
> > other
> > + * sensitive data.
> > + *
> > + * @param a
> > + *   Pointer to the first memory region to compare
> > + * @param b
> > + *   Pointer to the second memory region to compare
> > + * @param n
> > + *   Number of bytes to compare
> > + * @return
> > + *   false if the memory regions are identical, true if they differ
> > + */
> > +static inline bool
> > +rte_consttime_memneq(const void *a, const void *b, size_t n)
> > +{
> > +	const volatile uint8_t *pa =3D (const volatile uint8_t *)a;
> > +	const volatile uint8_t *pb =3D (const volatile uint8_t *)b;
> > +	uint8_t result =3D 0;
> > +	size_t i;
> > +
> > +	for (i =3D 0; i < n; i++)
> > +		result |=3D pa[i] ^ pb[i];
> > +
> > +	return result !=3D 0;
> > +}
> > +
> >  /*********** Macros for compile type checks ********/
> >=20
> >  /* Workaround for toolchain issues with missing C11 macro in FreeBSD
> > */
> > --
> > 2.34.1 =20
>=20
> My comments here still apply:
> https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F6547A@smartse=
rver.smartshare.dk/
>=20
> Also, this is certainly not a common function, so don't put it in rte_com=
mo.h. Put it in rte_memory.h as suggested.

Yes, Should be next to existing rte_memzero_explicit in rte_memory.h
