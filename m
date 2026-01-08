Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D68CD1D494
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 21:26:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86E64402DE;
	Thu,  8 Jan 2026 22:26:10 +0100 (CET)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by mails.dpdk.org (Postfix) with ESMTP id 349554028C
 for <dev@dpdk.org>; Thu,  8 Jan 2026 22:26:09 +0100 (CET)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-559a4d6b511so516741e0c.0
 for <dev@dpdk.org>; Thu, 08 Jan 2026 13:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767907568; x=1768512368; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJSUB+9fAVCi5TCFzHXqMn8pt9QUoRZg/ljMvbvocQ0=;
 b=NiwB9TLOt2bHEY4d7erW/WSq+RtGi9qxlXkBwHPvZSHOzf3DER+mddWGsdojqQhHzm
 Psok+wsxE+1LbY1QDH0BSmNDh0utXIxdzB6bo1RY3wR7C6DbuuJ+/wtk23xTg6nCfT7b
 +DWDwZL2cbZEM57qbsXZxe9x9txpj/P6d+ak70jL8hQL+2U3fQI4y+KOude0zk3N+0WJ
 L9CtKrQkDX/xlWrS8QuqsydhDORj1ODKI7C5HKAvYcbZDQCwUI19NPNoNEoI+QuEBYh5
 0lNvvaj386If2btdmj6SwsuTNrcbhBNSD5REj4D6S56Bo44Tto5G3buFtFzQJwCal453
 u3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907568; x=1768512368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qJSUB+9fAVCi5TCFzHXqMn8pt9QUoRZg/ljMvbvocQ0=;
 b=SE0pmB9loiu+Z/IFnENwN0q9yw4LlH58FnCjjcpZZ5ogj/935ZDiPTv51eERTyCVyq
 fb5+s06dEteYppFWmTmUHOg7h812FKlsOThxCfFRrragKw1mHbM1hSeMYKRDKD08VNWZ
 L1h7kidR1v+Dq/aHtZzrsY3B9J8wyDwZlS2i3yGP2q8vrAokIwPaHoYrwnPCm56ALd7E
 j/sFio1F+FzDcEWLIY9ej+oQS4KhuEnGOMoVmec7G8Toj+u8N5RhgUGck6gfcRwWmhDP
 FjECexInMdGnspJIAbAfvmaVm/Zp4f0T/4pWVIcvNk/xPaCvUEVW1nb965hdEq/HO8ZL
 30yw==
X-Gm-Message-State: AOJu0YyspaPaP9/FrYUUr2NzmMUNuF2IwR+tne6sFfozwpDZdRUt+U78
 CzK4zmZSzpovQJqWFnPoZu1dr/CfGCGaBrjToMInDxhqKz42mfK0uDjK1vt9Lr46YaD4uyGwSCN
 b9zCPm/vDKZQXfisZM4Tz2RfhPRe0Vn8=
X-Gm-Gg: AY/fxX4B0PSDDdReht2jCFa1kERNwqR0sm7Vnu7GZ6Hrt8XiLksjyQ0xM2B/1YY/Mw/
 SgsRAwD5Mp6QteVv7fqg2L1bdkJx1T9BcuktW4zIvzLyrDHDk3iQXbRd6Px+AgPGO/feSCKMVFY
 QVrURZHsS0GrpBtCQpG4ELc4imEd9N/gYsECot6w8ZmkjfN8Uf033MGD7C4VQdTfvGelRt24JT4
 Uvd/Bz4g/hb4EKkc6+F0FJ+VURhj/lnBI+QYDAAbJw94w1Y75uGTRWByWqG/ySBn2oA9jIq7bLF
 sUKUJeSwFzwD+xM8SwM5S84j+ck=
X-Google-Smtp-Source: AGHT+IEEGsiMphhT3viIrt8PYAFQC6v7MTSPyy/K13JlyeCD5+0KdhD4uKX2TJSKAkCuEl4W3b5plYVNRSpx7hfMvZU=
X-Received: by 2002:a05:6102:6a85:b0:5db:da81:2541 with SMTP id
 ada2fe7eead31-5ecb685a398mr2632601137.12.1767907568524; Thu, 08 Jan 2026
 13:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20260108145913.92421-1-scott.k.mitch1@gmail.com>
 <20260108082433.3a70ca07@phoenix.local>
In-Reply-To: <20260108082433.3a70ca07@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 8 Jan 2026 16:25:56 -0500
X-Gm-Features: AZwV_QhgTKHNvlFiHDn7S2ZqoFJoq2_lamvUuYM1RMkrREulazXbwf2mBNtuezo
Message-ID: <CAFn2buC7mCHo8PA3vxhtUvqkCboLCZ9coy-q2HpYCf2vAaeERQ@mail.gmail.com>
Subject: Re: [PATCH v7] net: optimize raw checksum computation
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, mb@smartsharesystems.com
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

On Thu, Jan 8, 2026 at 11:24=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu,  8 Jan 2026 09:59:13 -0500
> scott.k.mitch1@gmail.com wrote:
>
> > diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
> > index 822a660cfb..67033875cc 100644
> > --- a/lib/net/rte_ip4.h
> > +++ b/lib/net/rte_ip4.h
> > @@ -223,21 +223,19 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr *ip=
v4_hdr, uint64_t ol_flags)
> >               uint8_t  zero;     /* zero. */
> >               uint8_t  proto;    /* L4 protocol type. */
> >               uint16_t len;      /* L4 length. */
> > -     } psd_hdr;
> > -
> > -     uint32_t l3_len;
> > -
> > -     psd_hdr.src_addr =3D ipv4_hdr->src_addr;
> > -     psd_hdr.dst_addr =3D ipv4_hdr->dst_addr;
> > -     psd_hdr.zero =3D 0;
> > -     psd_hdr.proto =3D ipv4_hdr->next_proto_id;
> > -     if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
> > -             psd_hdr.len =3D 0;
> > -     } else {
> > -             l3_len =3D rte_be_to_cpu_16(ipv4_hdr->total_length);
> > -             psd_hdr.len =3D rte_cpu_to_be_16((uint16_t)(l3_len -
> > -                     rte_ipv4_hdr_len(ipv4_hdr)));
> > -     }
> > +     } psd_hdr =3D {
> > +             .src_addr =3D ipv4_hdr->src_addr,
> > +             .dst_addr =3D ipv4_hdr->dst_addr,
> > +             .proto =3D ipv4_hdr->next_proto_id,
> > +             .len =3D (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_=
TX_UDP_SEG)) ? 0 :
> > +                     rte_cpu_to_be_16((uint16_t)(rte_be_to_cpu_16(ipv4=
_hdr->total_length) -
> > +                             rte_ipv4_hdr_len(ipv4_hdr)))
> > +     };
> > +#ifdef RTE_
>
> I find it hard to read complex expressions in initialiazers.
> Much better as original if statement.
> Sometimes you need a union to convince compiler of aliasing
>

I improved the readability of the ternary in the v8 patch (coming soon).
Rational for using an initializer is to lean on the c99 spec which
guarantees the
memory is initialized. Given the ambiguity around "maybe uninitialized
variable use" I made the code in question explicit on initialization.
Let me know
if the approach in v8 patch is not inline with dpdk standards/convention an=
d I
can rework.
