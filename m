Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6853FC54ED1
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Jun 2025 22:49:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FBCD4025D;
	Sun, 29 Jun 2025 00:49:33 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id C10C940144
 for <dev@dpdk.org>; Sun, 29 Jun 2025 00:49:31 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-237311f5a54so5442685ad.2
 for <dev@dpdk.org>; Sat, 28 Jun 2025 15:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751150971;
 x=1751755771; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFb5mSgNXCwRTaWVHCwbfMABkuS4o6MzLUrKvL+Q0eA=;
 b=EN2l8cNrBvzMx9w3U9vvgXn39l9vpE69eeGw2D8/pu0hkwY4t3VK4vQf+Nh9Fj6Sw6
 DaSeBFlZcKde+9lwLu+0eN9CTYGshlCxuBWTyshWMlWKTtFEcIVGRVfgZwebLHU/dBEA
 W/jz0US9F26UDNnCCwGhavdCDAqJnSVzI0BhzlzHw6XRXSe1ETltOvf45R2kWhNR/IwD
 fk32d506LmAN6W+ve/TewsvT+JcfxuCxjoRblG1LqI1PDl0fxUHFmhIvgx62sBjF3bke
 OCFLH3XjptHzSuW02Nv7aqjh4eQ7n5WPSABUr8NERosgW51ODfOTxAOu5vBEuSWMnY3Q
 bGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751150971; x=1751755771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFb5mSgNXCwRTaWVHCwbfMABkuS4o6MzLUrKvL+Q0eA=;
 b=rxIncjlYMusnTpG/X6teyo9ci/7YiTV0X7GOzr6/y5gGxS/B7lJHrT/VvSjROgnlV1
 ArQ1C954UQ3eyU0xHPMIsYQOYMgUMmwAjECw98T7qh1Td5AqRvBdRGk4R6oNn04vxXZu
 ONSEMKVjh2CBpSXSIEMxiCcu9bbwl4j00bd/9Zz63RTK202DmK42nYv47FoZB4yE1bbC
 0AI8rJhJlMbCOcrJ7hD9rA7dSazIklZ31dzZ6iO3BUCAtXfX/6kFTzhuEM8N8aUyQp0q
 zV3fLhhg3WykNSQJuT+MasWMCYcdoO6/tZNH5qtCucAV3lhJjl7azUdFXl14bvWW54BH
 g9IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv6Vn+THNWStsRltHZMwFkYgpHjMeIz+ebhCKkYd4oMV9N7GUrZ8uQrMn3DGJVtRp9JQg=@dpdk.org
X-Gm-Message-State: AOJu0YyDgyWlz3oYQt5gZTS7ascsh30Q+8cZbExXh/Pci+HVvkG3hYYc
 efGtrKTUG8d2UV51U3RdWdUBi4dAo6rHhTBA37JdaPIrEia2D0dwt9JDM2f+ujs5028=
X-Gm-Gg: ASbGncuPAOpa/DByPzxi4PM+zfe0nYcJuipFyHI2Z2ZQVe/SMRCDVmwzuXli9qtE5x2
 RP6JFuVDqAsElAktYG6Glpsm4bGTP65+J3XQhX/Ch2jIhdgiH+87bMk7cxP9awF7cHVNUkwVCMB
 /1ufb7Mkqpk5XjE9N3Ru95M8mEAgkEeFAp2xRarFTNsTdwIgzfHw2P7SYVcJs3nERKB7Z6Tsfl9
 3nJBkKUyWqz/tGtMzRIwAtvHYbryMkd3T3l1RO3DN+ktXs74LhDCh1jypPdmu0ae8m7DzN+hK7V
 BKAEw1vwwseMs843TfYnmZUGtftm+rCvLXBADaKxifV9DzVYpsKvGasLn6YB6CzXTf7FQNDoQFh
 MUzU91x8b+aKIKkrY9d14/vB2ghO4a5ljdjlmykI=
X-Google-Smtp-Source: AGHT+IHdhWdpTqmeyhZIcEkAaoy3DJPTCI1wKD74Z06nB4/T5150VexfqGGgywWeORf8QMKfkM44OQ==
X-Received: by 2002:a17:903:1a2e:b0:235:7c6:ebc2 with SMTP id
 d9443c01a7336-23ac2d86931mr105754675ad.4.1751150970803; 
 Sat, 28 Jun 2025 15:49:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3b8be5sm45392825ad.189.2025.06.28.15.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 15:49:30 -0700 (PDT)
Date: Sat, 28 Jun 2025 15:49:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Thomas Monjalon" <thomas@monjalon.net>, "Tyler Retzlaff"
 <roretzla@linux.microsoft.com>, "Anatoly Burakov"
 <anatoly.burakov@intel.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>, "Maxime Coquelin"
 <maxime.coquelin@redhat.com>, "Chenbo Xia" <chenbox@nvidia.com>, "Tomasz
 Duszynski" <tduszynski@marvell.com>, <dev@dpdk.org>
Subject: Re: [PATCH v3 2/3] eal: handle sysconf(_SC_PAGESIZE) negative
 return value
Message-ID: <20250628154927.6161b011@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD5B@smartserver.smartshare.dk>
References: <20250610131348.248800-1-mb@smartsharesystems.com>
 <6180155.ReJHH8Nr61@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD53@smartserver.smartshare.dk>
 <21665758.gIjEHFZm8d@thomas>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD5B@smartserver.smartshare.dk>
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

On Sat, 28 Jun 2025 18:45:44 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Friday, 27 June 2025 20.30
> >=20
> > 27/06/2025 19:49, Morten Br=C3=B8rup: =20
> > > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > > Sent: Friday, 27 June 2025 19.35
> > > >
> > > > 27/06/2025 18:38, Morten Br=C3=B8rup: =20
> > > > > > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > > > > > Sent: Friday, 27 June 2025 17.58
> > > > > >
> > > > > > 24/06/2025 10:03, Morten Br=C3=B8rup: =20
> > > > > > > +		if ((ssize_t)page_size < 0)
> > > > > > > +			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
> > > > > > > +					errno =3D=3D 0 ? "Indeterminate" : =20
> > > > > > strerror(errno));
> > > > > >
> > > > > > We don't want more rte_panic().
> > > > > > You could log the problem and return 0 here.
> > > > > > It will be a problem later, but it may allow the application to=
 =20
> > > > cleanup =20
> > > > > > instead of abrupting crashing. =20
> > > > >
> > > > > Disagree.
> > > > > That would be likely to cause crash with division by zero later.
> > > > > Better to fail early. =20
> > > >
> > > > Which division by zero? =20
> > >
> > > Functions dividing by page size. E.g.:
> > > =20
> > https://elixir.bootlin.com/dpdk/v25.03/source/lib/eal/common/eal_common_
> > memory.c#L313 =20
> > > =20
> > > >
> > > > I don't think a library should take this decision on behalf of the =
=20
> > app. =20
> > >
> > > I expect lots of things to break if sysconf(_SC_PAGESIZE) fails, so =
=20
> > the purpose of this patch is to centralize error handling here, and only
> > continue/return with non-failing values. =20
> > >
> > > Otherwise, everywhere using rte_mem_page_size() or =20
> > sysconf(_SC_PAGESIZE) should implement error handling (or ignore
> > errors). =20
> > > That's a lot of places, so I'm not going to provide a patch doing =20
> > that.
> >=20
> > I understand.
> >=20
> > The problem is that we don't have an exception mechanism in this
> > language. =20
>=20
> Yep.
> And everyone assumes sysconf(_SC_PAGESIZE) never fails, which is probably=
 correct, so nobody implemented error handling for it. Not even in rte_mem_=
page_size().
> Coverity detected the missing error handling, and warns: "Although rte_me=
m_page_size() is declared to return unsigned int, it may actually return a =
negative value." This defect applies to all functions calling rte_mem_page_=
size().
> This patch adds error handling to ensure that rte_mem_page_size() only re=
turns non-negative values, or doesn=E2=80=99t return at all - i.e. fails wi=
th rte_panic() - so Coverity is satisfied with callers not implementing err=
or handling for it.
>=20
> It would be borderline waste of time fixing all the callers, so I fixed t=
he root cause to satisfy Coverity.
>=20
> From an higher level perspective:
> This is a low level EAL function to determine the page size. I would cons=
ider it reasonable for such a low level EAL function to never fail.
> If some O/S decides to not have a "system page size", and fail with "Inde=
terminate", e.g. to support multiple page sizes, we would need to handle th=
at somehow. But let's ignore that until it actually happens, if ever.
>=20
> If you are skeptical about this patch 2/3 in the series, we can escalate =
the discussion to the tech board. If you really hate this patch 2/3, I will=
 honor a NAK from you. The patch is not important for me; I'm just trying t=
o clean up.
>=20

In such cases, I look at glibc source and see if handles it or not.
Looks like only used a couple of places there, the result of sysconf(_SC_PA=
GE_SIZE) is checked
in one of the tests; but is not checked in the loading of locale's.  It exp=
ects a valid power of 2
value there.

Ok to just die if value isn't valid.
