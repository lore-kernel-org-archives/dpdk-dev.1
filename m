Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FDD46BE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F15D4026F;
	Wed, 28 Jan 2026 19:00:30 +0100 (CET)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) by mails.dpdk.org (Postfix) with ESMTP id 44EEC4003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:00:29 +0100 (CET)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-5eea31b5cb7so63520137.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:00:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769623228; cv=none;
 d=google.com; s=arc-20240605;
 b=G/9yad1TyAtxoaKCIZmzGYndZTTjibnjCvikC09hzF8GpS1ZDR6D1eiB5TF8uin7Mo
 CxCm1yHx4GNvBoljqG+bbJFvyEVHjqhNAIofhl+TS9eIlZ/vilypl8Pnu4FtZsfhzNDH
 X8+mggeQS61kOaVm9HVkpfEXYZ3FmN7IH7umIn/FqwMQRQdrAtmCK0icyLogmxF4Pi81
 OaazHhAb29cXzMqM1cZ+S9yXaKFP4z/3Pvlp/ajpZVuok51GRYJBI8gHrpKv6OinB2bW
 lzNC9aPk4zHva1DDdxGDuHjKK7bLMhw+XvhJWn8PGvf9i/fCe7N5Su6A2wx/uFQfssfR
 p9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fdfTotNL+psNykSoOSoJCmbY/L7i7+TpBJ/eIoBtq4I=;
 fh=1c4TJrSHP01pKxi6GucbcO4vteuKi1v4GQTIV17P9es=;
 b=PBuZHLzSedmG0LSwJPSRZbnF1M9mdxXwlyc+AcNNmX3L0sWqsWOrorRLJRKij/KEJE
 Xr6W9ZJcAo87Sd4Tz/DOJRqrqA+NokzSjfTgt3MdvP1zYlNfdJEI9nV/BfUqxhXyO2TH
 5RbDAOGLwDAZPQKHBVfCgtXS8Kp4mtbWp3e6xS4LDiV5WHL+a3oouzML1ZvdRUe4YEnM
 VQWhR8zj9WhmRG67gxVn1YPUW3fPHbCr48Bv78z6WENrRXVq7U/n32om8o06pL5YAhl0
 VfrtJSSb70WwHChIkhA4GUK4qSskUaAZZtGHdkLeiHG3kD8tUVYuHVyiiTthf19819nl
 C5Mw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769623228; x=1770228028; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdfTotNL+psNykSoOSoJCmbY/L7i7+TpBJ/eIoBtq4I=;
 b=bZlX2vBezIzU7Z83FnqFstTeicJuei0d/K6TzlUXrpdht79eB1zLGsbu1ziquUGGxO
 MzPDHzCNwWuuMXUFvnWFBOVawSqwfPUASDTAbXm684I3KBGzEUs24O669aD2P/DUM1Gz
 i2EBzONk6hdTqir3gDPJ1OWEostpjcJvxykjunF3OmejS3z6mzJaE0P66+skkxOODvj9
 DGcuevk+JFzufLKhFR8c6v+2mn+lH5Q6tkzg8U9LrovoHtesUbIsZy1cRTayvta51GVL
 WewD+0rtLkAh/VBTPrgwbydjKfHy7RsoOz/KLngU6LFWwnwqCikX8eOAaVUqecoRJSOS
 QQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769623228; x=1770228028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fdfTotNL+psNykSoOSoJCmbY/L7i7+TpBJ/eIoBtq4I=;
 b=IVLqyyzQNQYNZEL3JglZKpkCfVzpK4p3eE3lOXqazN6m9tOOwshNg9HVYNUsEtYGZe
 bt5OUmAW9WnpMkjWLskfYmmUlfPYL8m5fjtADJoG54zUzWU5BL6z0jyxpZRx9m16OlIe
 flUv+fcSv9N87GV3l0J/YXJ2yV20NR8nbFuNuvfXX8spt+tc8jIJ7wVzQMikJ6/W1chI
 nyg5eF2zfdfkB/FXchYIiOpGrN6aaOqWaSDRw8YueExH6OFmMW+XvUitTBe7SBxkZ2Mu
 wTAtjJ1iHabMjhhp85xjnTAPWZ2QMn63tq9AGTzKG7v/zvUJCxVOYHTfcrzSkllFsILW
 xxgA==
X-Gm-Message-State: AOJu0YzZUIZU0GX2qvgC2Wxm2hOIBYxrpMuc3Hkiiss4jrlQo62Q8bXY
 xnV6+Mn6LhmmWfycxDJueSrXcu/SI2Olmz4pK2SI63N7o9GR9hu6DvSc8bkCxnwg+weylDffLKD
 Uzbm3HSlMy+jeMLp9qDsQL8JDEpXjXb3Y1seI
X-Gm-Gg: AZuq6aKb9UaQ0DFfl4AmG5P+ubjy11OuwDTh+r3NKvnkx0sPlkRb4bmjPP6YtLMUpGn
 luJEwaVB5Y/S97dhgS3rqnJkzVThpwPqcfpTT1iYe2jvSdAc0h/0RyjL6SjfMp+28ow/Jc/5FIh
 xs7USHoYG1hTTpRrd7TsqKGYcgxz/Ldo1296aadpvNUvhALs9+v72lTa3M2CdrczaD1dKFDzc54
 QwNhg2aSsy3rnwKNFy2i+UlHx25RfN1nyhjHyJmAzHOwnzgu5O+6rGpVC6VGVfN2rAKK1UZ4kyu
 MAtiWnBDm7C7REhKyt1QyCRP8Vmwc7UTIg==
X-Received: by 2002:a05:6102:3052:b0:5ed:f26:5615 with SMTP id
 ada2fe7eead31-5f7236a9441mr1910400137.18.1769623227403; Wed, 28 Jan 2026
 10:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-2-scott.k.mitch1@gmail.com>
 <20260128085928.671ce473@phoenix.local>
In-Reply-To: <20260128085928.671ce473@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 28 Jan 2026 10:00:16 -0800
X-Gm-Features: AZwV_QiYvUefx7WUgfIIvADiIniWi0D3nBFZUILHhQ1kea04LTyEou_rm_bakCI
Message-ID: <CAFn2buB6zHAygTrdEx_gcE+xCbf=3Fz5eDK6UzVX-PEe2KO9zQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net/af_packet: fix thread safety and frame
 calculations
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, linville@tuxdriver.com, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 28, 2026 at 8:59=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 28 Jan 2026 01:36:04 -0800
> scott.k.mitch1@gmail.com wrote:
>
> > +/**
> > + * Read tp_status from packet mmap ring. Matches kernel's READ_ONCE() =
with smp_rmb()
> > + * ordering in af_packet.c __packet_get_status.
> > + */
> > +static inline uint32_t
> > +tpacket_read_status(const volatile void *tp_status)
> > +{
> > +     rte_smp_rmb();
> > +     return *((const volatile unaligned_uint32_t *)tp_status);
> > +}
>
> Wouldn't rte_compiler_barrier() be better choice here.
> You are really only trying to keep compiler from optimzing the access.
>
> And tp_status is aligned in ring isn't it?

The current approach replicates __packet_set_status and
__packet_get_status [1] in the kernel which use the same barriers
(WRITE_ONCE calls __write_once_size [2] which does a volatile cast).
dpdk's rte_smp_rmb and rte_smp_wmb on x86 are just
rte_compiler_barrier [3] but on arm it's different [4].

[1] https://github.com/torvalds/linux/blob/v6.18/net/packet/af_packet.c#L39=
9-L451
[2] https://github.com/torvalds/linux/blob/v6.18/tools/include/linux/compil=
er.h#L194
[3] https://github.com/DPDK/dpdk/blob/v25.11/lib/eal/x86/include/rte_atomic=
.h#L26-L28
[4] https://github.com/DPDK/dpdk/blob/v25.11/lib/eal/arm/include/rte_atomic=
_64.h#L29-L31
