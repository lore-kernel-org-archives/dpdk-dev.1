Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB411CE8D5B
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77641410EA;
	Fri, 14 Nov 2025 17:57:34 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1025A40E34
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:57:32 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7b6dd81e2d4so2017954b3a.0
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763139452;
 x=1763744252; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYe1N1uHfn5f/hjrSxczfn5eGGtV9e4kLgUQd3qDDZs=;
 b=gqobdwDa0QCm+7p9/aUR5GbZzADKJMNMiCuiSC43hsWcRnL7z9zvJd3xe+B1V1s5UQ
 zvTtLyH1y//YxDNG3D6iRTWTvDQ+3x2h2BtBxelvkhRYPC3hDOUbvPvVA/0/RfZJcekG
 wFBhY/TfUZpdeI2b7fw82sxE84gDw1HODLGArzFnG+uCj91BtLzRgBN8C611uOMbe7OH
 ZcJMj+qKN/M3+oJpeSzEkRggt8pltMN4gYM9xqnWz6FrlJEc8lSmJYtRmscAkFCN9ugZ
 BpJ4G2Y9In+64aNH6DbbYr0SADEoE3SANOWJfYy0dcXdy9RTpLui9AofqGqg/b+fk1/x
 i85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763139452; x=1763744252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hYe1N1uHfn5f/hjrSxczfn5eGGtV9e4kLgUQd3qDDZs=;
 b=IJEE+geXm3ab0GOKKKKoBLdwOnyGUPy8hJRQq377inp253DZn3Bkmw8hsJ7mchXbzn
 G+pLugyVHkgaRrBRf78+kDD5oEi3j5rLqzPfyQ1M7IdT+0uQ7KgAheOGkCovnfUSgfR2
 0bbaDKaV+NpRxZRFaVzfyUZNWh59IG7Kjb30Tp6LAYxC40+HTH1vk4gFnI/om69cJ7NG
 SIpyMp8VAequqoZtJXLVsp5yHHQOu7eyFYp4sg10rJekdq9v2RseeZDe4Ux7BthLiTMS
 L5AEH7iXgQZzQk7fftlnBd9tC++73Ydd6TBdnf+1/cKXlio5eV2J6h9gYFsSglk1TsGB
 O9cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2JCSRlF2AmU5ak//f0Qc9ii7hNqh/+vvPe/WRQwdtPAFdXH33Zcyv9bf5iudeWEEYDyY=@dpdk.org
X-Gm-Message-State: AOJu0YyWSBC4tlwSB0wOXzkGi8rvPoUyxtuxsBGVza4KO7PsCV1S+Vf9
 sijrbfMfuPZUWr1xRJxL0VIRDIOb4/NeqsJsdH4vhollYG/pc75BKQXmPVVq/8uY6zg=
X-Gm-Gg: ASbGncvMamrzRbbMf/p/w9H3kmxZ487rSaemN96qCWjSQWmHDKKDN5rR2ZQDgxynhQR
 kBzXJFaO4Z27o4/hHxEhGWtIt00KLs/Z/T/WhIugAQELr7+iu11UrX1nlaJiC8bVkFpdA3uEFmC
 AjQ4E2WJkkMvM4g1TtqYPYrj1reVgVi327U1b7djIvme5pdPYKxRpHJqx+dEbeSOwvorpnWA0yI
 kZZB7I5uJodmCYoaOGBkLXtD5vddE4kXcRfWGb2W1Uo/qcsvWCTAnDphNR3gWJLIlvdxnbI/eVi
 2ADPu1XSnwFKEWetUCLvoBsGgrK7kdqOHQv209EhrnRm7cthOLN5VPF2ktCXgou+jI1or96t0tM
 dXBtImr42+Yt+h61BDSFXasW5k8d/RMAesZqqt5zLe9VJxtETFHb3T3oUlaLKq0UzbMMuBN6WL0
 GVjRd7ZV7TOacB2Kf8njle5wSemLhdSi31mLLT5ApBxLaU3PHVL3ivUg8=
X-Google-Smtp-Source: AGHT+IH1lvHU5/7iEkur6kcBgqpLvjBRo6l0hXKndZeVGIrLNygmvCQ8xbkwkyNyuQrCgDvaJMhDZw==
X-Received: by 2002:a05:7022:ff41:b0:11a:51a8:ec9 with SMTP id
 a92af1059eb24-11b41703d71mr1624866c88.29.1763139451912; 
 Fri, 14 Nov 2025 08:57:31 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885eesm11570579c88.1.2025.11.14.08.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 08:57:31 -0800 (PST)
Date: Fri, 14 Nov 2025 08:57:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, dev@dpdk.org, David Marchand
 <david.marchand@redhat.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 stable@dpdk.org
Subject: Re: [PATCH v5 1/4] net/dpaa2: fix duplicate calling of dpaa2 dev close
Message-ID: <20251114085729.00337584@phoenix>
In-Reply-To: <CAHHRULWc4GVdYxfT9YndSNRHd2jBxTDXoNNnKzCAHpBHE=BR2A@mail.gmail.com>
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-1-hemant.agrawal@nxp.com>
 <CAHHRULWc4GVdYxfT9YndSNRHd2jBxTDXoNNnKzCAHpBHE=BR2A@mail.gmail.com>
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

On Fri, 14 Nov 2025 17:53:38 +0100
Maxime Leroy <maxime@leroys.fr> wrote:

> Hi Stephen and Hemant,
>=20
> It would be great if this series could be merged for rc3. I=E2=80=99ve te=
sted it
> successfully with Grout on my side, and it allows us to support the DPAA2
> Ethernet driver without any ugly workarounds. I=E2=80=99ve also reviewed =
all the
> patches, and everything looks good with no major risks.


Just waiting for discussion to settle out.
