Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB4ED46BEB
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:29:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C849840647;
	Wed, 28 Jan 2026 19:29:05 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id A5B3C4014F
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:29:03 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso1141175e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769624943;
 x=1770229743; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptUgek3Xv877S4h7xSjZpp0mYldu/7FH9ndk/AMJE3g=;
 b=N9J0vNBKMRxS9LEKOpVW70IIB5cxmnIJybdXJ5GImA8GXX19jOvRmZ0pka2u7Iu7RZ
 bsDRYOCqJGk3JwCRst+vZNGCy2M8hyWuNWDpkrCHlBWDsGcvhLPDFG5n4a1a2TIbM7cJ
 GaSHKWMWFQSJYuHsUrggoELLmazPDUv5EAfsjcjdQSxB2cDEAdXKCjutVtViH5jfJfXn
 RnFM/yP9cTVtRetgG7b4U6o7PSrVguNCclADnUDgfmCP979cB+DLlvV+zAh6B8FOQQes
 VUKtwkIJZr8f43xtoHv1kRws+Fd4V17SB5HWd682j+odJkMwTKmkDwEGovJqaCh31Md7
 DW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769624943; x=1770229743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptUgek3Xv877S4h7xSjZpp0mYldu/7FH9ndk/AMJE3g=;
 b=OmX81YdTD399auxojS2lS9UO1GxGZsOxui1aPAhBDxGQzB7rou7msAmXXI1oJm1UZy
 HW5bhgO/M6mutVTyV1I8Xo9flXX/AJM7Navbov/0s5PIurlQDT3mmMWBWWrfyAYqttX0
 ffaXySwLqkccJk/by5WCFRVgOhxnFHSPaXDkQ83Vpe8l1Ae6fGKToLw0jK4M772GP7Ev
 YntRcwQ7BZhOOrE9tY21mhJIwhsVWwudYxKwSumviFktrinqmFIwVpJ9hasLd7wJov+E
 FqZsVysDeuLKDAubeHxOlNNvfN3podw0yKg2lKkLHaOLJ4sjvBK9/pS18HhCMYLsZI2g
 5XAg==
X-Gm-Message-State: AOJu0Yxe76K9Riky8g9eaoxofFtmZjL5qF6aehncjV5mSNApZX+5+Bu0
 +TLeVDL7G4lDuzFyM9IHGvqedChsNO04SEOVOpaf653Mz2NO7K3F/phz8zmh+jPV2+8=
X-Gm-Gg: AZuq6aKXy+zKYSxF4sMR8YhPga3HCZZNWYPnOJr2yltEcs89l5rfD6Dm1Qi05z4Ux83
 SHqMgYAOLVTkWgMy4NitVPPPedma1u657phTt//5hezWj1z+KoeuEPgXFjz5YA52/M7nTAgCUR4
 G65yI21BFUVDIea/AX9CN5EqHa+y8ZjfD7YAf3lm5ZKovZqNydyhCbb+bRDa8uCDp0mTzFsOb0k
 MwPvddLy4+TSPVkfQFizZ7rA4AVpX8D2vVVwqWZaPBUbNI8GjMYHySrUEn0n0QsS4bAc/DN4wW6
 OPMphHa+YDc5Siai2ch8nCv3evwVLwMDIw/zAEf/ydM8a/EL0ux2QxXHzVuxshNhx2WrBcqW2Pf
 SP5M2/P0xgtzxYOjKizimBSh6e7fvRLPHAsmYE0vhhtxSB1Ml9eIW01w6iItD/WIvVBhJ79kZVp
 jP/5oPFy1k8a/dmBXRf29TXtaY7WSi6x9xIkZGIQjvC/J/yHSCJzIH
X-Received: by 2002:a05:600c:3f16:b0:47d:6140:3284 with SMTP id
 5b1f17b1804b1-48069c75e5cmr70054025e9.37.1769624943180; 
 Wed, 28 Jan 2026 10:29:03 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806d883b12sm1105245e9.1.2026.01.28.10.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:29:02 -0800 (PST)
Date: Wed, 28 Jan 2026 10:28:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org, linville@tuxdriver.com, stable@dpdk.org
Subject: Re: [PATCH v2 1/4] net/af_packet: fix thread safety and frame
 calculations
Message-ID: <20260128102857.0d525e5f@phoenix.local>
In-Reply-To: <CAFn2buB6zHAygTrdEx_gcE+xCbf=3Fz5eDK6UzVX-PEe2KO9zQ@mail.gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-2-scott.k.mitch1@gmail.com>
 <20260128085928.671ce473@phoenix.local>
 <CAFn2buB6zHAygTrdEx_gcE+xCbf=3Fz5eDK6UzVX-PEe2KO9zQ@mail.gmail.com>
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

On Wed, 28 Jan 2026 10:00:16 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> On Wed, Jan 28, 2026 at 8:59=E2=80=AFAM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Wed, 28 Jan 2026 01:36:04 -0800
> > scott.k.mitch1@gmail.com wrote:
> > =20
> > > +/**
> > > + * Read tp_status from packet mmap ring. Matches kernel's READ_ONCE(=
) with smp_rmb()
> > > + * ordering in af_packet.c __packet_get_status.
> > > + */
> > > +static inline uint32_t
> > > +tpacket_read_status(const volatile void *tp_status)
> > > +{
> > > +     rte_smp_rmb();
> > > +     return *((const volatile unaligned_uint32_t *)tp_status);
> > > +} =20
> >
> > Wouldn't rte_compiler_barrier() be better choice here.
> > You are really only trying to keep compiler from optimzing the access.
> >
> > And tp_status is aligned in ring isn't it? =20
>=20
> The current approach replicates __packet_set_status and
> __packet_get_status [1] in the kernel which use the same barriers
> (WRITE_ONCE calls __write_once_size [2] which does a volatile cast).
> dpdk's rte_smp_rmb and rte_smp_wmb on x86 are just
> rte_compiler_barrier [3] but on arm it's different [4].
>=20
> [1] https://github.com/torvalds/linux/blob/v6.18/net/packet/af_packet.c#L=
399-L451
> [2] https://github.com/torvalds/linux/blob/v6.18/tools/include/linux/comp=
iler.h#L194
> [3] https://github.com/DPDK/dpdk/blob/v25.11/lib/eal/x86/include/rte_atom=
ic.h#L26-L28
> [4] https://github.com/DPDK/dpdk/blob/v25.11/lib/eal/arm/include/rte_atom=
ic_64.h#L29-L31

Agree that what ever primitive is used should match kernel.
Surprised kernel uapi doesn't export that some how.
FreeBSD explicitly states what atomic is needed in their similar ring api.
