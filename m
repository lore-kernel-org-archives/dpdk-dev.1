Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9072C87FD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 15:48:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FF7140BA4;
	Tue,  5 Aug 2025 17:48:44 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 5E46640A4B
 for <dev@dpdk.org>; Tue,  5 Aug 2025 17:48:43 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-459d62184c9so17183475e9.1
 for <dev@dpdk.org>; Tue, 05 Aug 2025 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754408922;
 x=1755013722; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8p2znl8x70+J0Re88A4KyBD/PLSOaLscqnQbKiMWE+I=;
 b=W1RJTwQjxbVO7bJ3HOZkwC+raFnJev2tSl0V43kQp5lO+yiXvL86/UKtDm5Og7r0Co
 SkElH7YudY2keikxLez0t7tEYp1GEfXrSEFmARLFH6z4zdPG2Lw3PQGERg99TEQQnQEq
 v2dpS02dtjIrL4XOptsOD5iR4t0AattMAG4LZjt0T4k8nUrI+7oHPL4Kzr4FVoyes024
 dmG6FCEo7b/D/7pQhJ/d4Hyy3ElQazVviTmesggGD+427RUS2lgrqolLyQPpUVfLgp9f
 aMCQdyi8+4mkU987xi5KFr62mtZglxE6FZ7n0P1Ipk6HzZZJdCIL3i1Bk3gmA3/XvQxP
 r8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754408922; x=1755013722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8p2znl8x70+J0Re88A4KyBD/PLSOaLscqnQbKiMWE+I=;
 b=fc2qDtTO8LMC61e9EtkdCl8tmGZegst5u4DiCIQg5He4o88TiwZSzTBTDUBbG/S7B6
 QxXTy0gTghD8TxeoEXYg8k5xR+0AaTXzVbd5yFzkQXX8sfgHAloMe28RLEun8uTOqiiU
 YIoMRDDqzXD66CfFNFwUko54EiVMUoaZNts8NqfppdEnBhCKXhkYkI8j2iGA6PAFxeBi
 ztc5ZrqjXIBRsjo2q/U/psl27WadOBhiDOcAJKwOF2CMIVMZ1ooV+VLnMURZipxk+ClG
 eqwjVA6NV/SaKOcz2KQ6uovPknbrMoaGfBDPo6XfttiZ0/Gi6nRSJcrnE/g6lE5dKRts
 jJ1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxH4AAr1HKX91wJYdaG59Y8+m7faTHSpO+4UkJ2OZK9euZCk5VgdxnHbR/HVWZk1dF06k=@dpdk.org
X-Gm-Message-State: AOJu0YwR2lOBhYA+KUL9f62X3mItnC3IWLfTiz7rO1OE+VwKz6MBtJAx
 YiYKWy+jAT39i17pb2vgP10aCh5/7EOIdhENRqnbr9RBsw7yJ0ajBqq5wrK+84eqR+I=
X-Gm-Gg: ASbGncvuGk7/TJwkxwNWMpPof4W/OMIdZx+lBQUA0H7MaWOipvWZibxAhrod0uHlQ4w
 Fpt/W2TPAp7x7kwVFpRVMl9CsPovvAocYC+e8/4K8w2/sYk1sZngocSnImucOoakBT+4iK9BTeo
 SJaDNnqoIkSo//+szHh3oCKIeJxRVdNBxzcWZ+Xb0AQRmdXyL/JCxLvPsrAp+o4+PevLNJr3pvt
 ++PgW4EfDo3WnKvdSvRGIowRPJb1DAPMrAdWJwL4GHsjlM6WRsT+4ieAvGoVTzmwRSsfGL0mGv2
 8i341M2Cu/D4A5h4FBuVK/fMcjeDGxpfFxD/TFlJKgRvc4IunvehyGuM0F35ijQqn9wGTI2YDq/
 L3zjHLCEIqBIdF/y6C6uhj3AofzzhMXJ8Ffz+MWSEqkDlQ/ierM8H5QhYWCPLx/zR8IDpH7zcRV
 E=
X-Google-Smtp-Source: AGHT+IEEQVhgLsYClY160egMZUoQ/HLorUbJy4axtGwGRXWV/q3rIy6gqLVDMmqHmrft83ljrDIL5A==
X-Received: by 2002:a05:600c:630c:b0:456:29da:bb25 with SMTP id
 5b1f17b1804b1-458b6b319a9mr108402275e9.19.1754408922309; 
 Tue, 05 Aug 2025 08:48:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58542f3sm9059425e9.10.2025.08.05.08.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 08:48:42 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:48:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "fengchengwen" <fengchengwen@huawei.com>, <dev@dpdk.org>, "Aman Singh"
 <aman.deep.singh@intel.com>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>, "Ivan Malov"
 <ivan.malov@arknetworks.am>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 1/3] testpmd: Do not enable mbuf fast release TX
 offload by default
Message-ID: <20250805084836.0d68f4af@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDFF@smartserver.smartshare.dk>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
 <4102ec21-46b6-4512-bc2f-3cd61f63f8c2@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDFF@smartserver.smartshare.dk>
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

On Tue, 5 Aug 2025 07:48:41 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: fengchengwen [mailto:fengchengwen@huawei.com]
> > Sent: Tuesday, 5 August 2025 02.59
> >=20
> > On 8/4/2025 3:42 AM, Morten Br=C3=B8rup wrote: =20
> > > Enabling some offload by default may conflict with a manually =20
> > configured =20
> > > offload.
> > > Specifically, the mbuf fast release TX offload, which conflicts with =
=20
> > multi =20
> > > segment packet TX offload, was enabled by default.
> > > Therefore, mbuf fast release TX offload (the only TX offload which was
> > > enabled by default) is not enabled by default anymore. =20
> >=20
> > This may impact default performance, many vendor performance report has
> > testpmd iofwd or macfwd case. =20
>=20
> Yes.
>=20
> IMO, any optimizations, mbuf-fast-free or mbuf-recycle, must be explicitl=
y enabled, and documented in the performance reports when used.
> Otherwise the performance reports give a false impression of higher perfo=
rmance, which is only available under certain circumstances.
> I have complained about this before.
> Which is also why mbuf-recycle must be explicitly enabled.
> With this patch, the same finally applies to mbuf-fast-free too.
> I could add a Fixes tag, but I think it is better to categorize this patc=
h as an improvement rather than a bug fix.
>=20

Agree that optimizations like this need to be opt-in.
Maybe ethdev should automatically downgrade rather than reject bad configur=
ations.

The DPDK already has too many "benchmark special" tweaks.
