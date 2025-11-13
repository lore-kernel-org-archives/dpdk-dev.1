Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14ACCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 17:33:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02FE440E4A;
	Thu, 13 Nov 2025 18:33:19 +0100 (CET)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43]) by mails.dpdk.org (Postfix) with ESMTP id EF21A40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 18:33:17 +0100 (CET)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-3e0f19a38d0so600455fac.0
 for <dev@dpdk.org>; Thu, 13 Nov 2025 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763055197;
 x=1763659997; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mu9i3Hi+p20IUppgpNCmRSgGwm4sR1zih/12OMRLFmw=;
 b=D8DpgB6RXeP0+tCDivOWtwkebsCOTG8s7ebo4uw2k+yoN7+N26f5tr4VtfixXY6wcI
 KpAbkCSlNHTYlOUvUZg9l0MDamqlonlUpVvNt3ekdSCOkZPaxyketBmrUS47PkP/MyaP
 yvdqyFvJS8nZ2bL1Z6sOVWqXRTt/u4bYqCf5wTVuI0K5TtV6WCifz+BlU8XksfszZwCF
 in8Nc4Ex97oe6uNhwtzqx1DbZJ8MJ+13ZGr7lWfc+HKJRaM87wckzaCFguaWj5OjZN0Z
 xiZu+HbWMYcO24gG6i+aJhcXupUEyTlJRbnMRph9IzgyCdzW0cnbYAIQi0f0fXufjab+
 KbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763055197; x=1763659997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mu9i3Hi+p20IUppgpNCmRSgGwm4sR1zih/12OMRLFmw=;
 b=injJ8VyA1LYYL3R0+d03M/EVSxmFoDYHmf1X5aOIPsdKbLuqUoPyXCNXsr9PB5eABk
 MgrP9X25llLaeO/ZrEnkekcdMaJGiktDAOIKZoI0kDaM9uxMFkWmQuQPqDNv75erYWpx
 n1G7/OVA1oJ4xZgop+jXcBRyguyB8oed31PXxmk70XA1DWWqIJ9ZRu7KppkjWFI7t8oP
 wMkw2SQ5CDMecDelk93I4/dyxcOxi1UhfjORcy7DgDuQAbG/L7PMJ/PdTGq+CTIrPnEy
 61uhVciAt++LXwRmSkYvgupJDpVQiKFIu/IIi8YRqM6K5gXNKb7goHU6Vdhob8UETUhy
 7I2w==
X-Gm-Message-State: AOJu0YwJ0tBxR19AEBX9ljUvmnamUza4+lRwdIG6gaBb8RkmANKnWLZY
 F72FThbaCtegIhbn3/lWyZlt8LTRPoJlKveU7acY5naolJPNdDRlFVNcY/WcxFIk7y0=
X-Gm-Gg: ASbGncsgWdEfJ9BGqWRQQxysiLNxEj8/TmQZJi0edV+ACcLUFtmAxMBtTsoDGxMrIyH
 Ilc8R49I1fo3UGAK8Om/Jj4wdbUL+qlrjr0WHm+qlWx8As0UJFIPm85azkV353s673j+VtCNGnm
 ia4Qg1xsiyp22q44WuNZ9PhV3IiUVQosvq3HVAe3Df2O+gavvKtrcJunMfe7TAmkhAnqIngSq9E
 MnIX+vn3XeSVr4ShldO3XmpNNcwty8I2lDL/2DdKTCzAJT+ud2GtQ4Y9GjDTuCzqrQGxVxMRCfV
 oCIEy7doml2iPXI6hqYWBkDbVJRZcmoqTn5nLT31C0dFoahAfnCgka5zz+fv+gsBB14ieWWIg2d
 xRIZar78x601+ZT+hl+t1wp4rgg+UjGMLwMgAPrEQVqNEPHZqD+CiFhzYU5OIP1oOecxa8v1XpV
 Hd3kjTJN/qKp472PypYusBKD6I4Ui3EKrY/Gd4JpEZoepA
X-Google-Smtp-Source: AGHT+IHwboqN74Egvg0OdlpRLjuZdSWBldVXLfnrvpIzya2aEKE887HClTGUtjQeoFr9yLWMcGK84g==
X-Received: by 2002:a05:6870:44b:b0:3e7:f55a:f108 with SMTP id
 586e51a60fabf-3e869095894mr104759fac.27.1763055197258; 
 Thu, 13 Nov 2025 09:33:17 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e85226391csm1804898fac.11.2025.11.13.09.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:33:17 -0800 (PST)
Date: Thu, 13 Nov 2025 09:33:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/axgbe: fix the build warning for GCC-16
Message-ID: <20251113093303.40f0c83a@phoenix>
In-Reply-To: <20251113164109.522-1-VenkatKumar.Ande@amd.com>
References: <20251113113055.371-1-VenkatKumar.Ande@amd.com>
 <20251113164109.522-1-VenkatKumar.Ande@amd.com>
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

On Thu, 13 Nov 2025 22:11:09 +0530
Venkat Kumar Ande <VenkatKumar.Ande@amd.com> wrote:

> Build warning reported for local variable set and not used on GCC-16.
> Fix the issue by using the variable for missed register write operation.
>=20
> ../drivers/net/axgbe/axgbe_ethdev.c: In function =E2=80=98axgbe_timesync_=
disable=E2=80=99:
> ../drivers/net/axgbe/axgbe_ethdev.c:1744:22: warning:
> variable =E2=80=98mac_tscr=E2=80=99 set but not used [-Wunused-but-set-va=
riable=3D]
>  1744 |         unsigned int mac_tscr =3D 0;
>       |                      ^~~~~~~~
>=20
> Bugzilla ID: 1819
> Fixes: e04449488fdb ("net/axgbe: support IEEE 1588 PTP")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>
> ---

Queued to next-net
