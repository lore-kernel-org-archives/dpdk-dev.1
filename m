Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1184C44508
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Jul 2026 17:00:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CC3B4026A;
	Wed, 15 Jul 2026 19:00:20 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id DB07040150
 for <dev@dpdk.org>; Wed, 15 Jul 2026 19:00:18 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-92f0b5ed131so246759485a.3
 for <dev@dpdk.org>; Wed, 15 Jul 2026 10:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784134818; cv=none;
 d=google.com; s=arc-20260327;
 b=nMKUnyd5X6LvPjl9mYtjPg2LICDE1PJiwbwnpdX33ks6nrP6bxKucBJDkT7hHajp6H
 Txk0HbJsQqNUxX+wXnf+hcn3MnBvMCQfqVxaT1yFVVVnhH1XLLCgKfqe+gkkmBMehgSi
 wHOrBRNhJuhIiNfp9BtkepV/KqSsHUBKIxcsCzuBEP8qf5Eqd1gmxxL22SEPsYYBT2L3
 FHFDuUihr9j1d5jGTAxVJqD2JuKIh/zqUzgdPDBJmRBXEErABFS01qDY1CUOT1zdyT46
 mnbKdVVxqysEIhrZAmuoKQY4elEhzYwF7qu4qx4VYsby9PABDbR21nTTRVwvAPDqJtwZ
 APLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=m9a/j/d0mP83OcVS/TJX1TwvbByrzwGxmrAbCSEYwSM=;
 fh=BUm6JRbBBgtANn3g5d93bB0ozBCtMby5I8NSfnA7E1k=;
 b=FKbkYuhGLC6lRw/KZKlbqB2QmhvQNcnCG0IcFmUljfDNXnkwFFNct5ysP+JEi7tNjA
 Q6l3CUrN9X5wbh/TkaSPjyEEwwKT0Qg7SG+8bx2JAwP3PuTxyEr+WIAD3jAc7Of3tS7L
 e52rBg3pbNBsHx8NAHyvp42MdvQUxd08StVdBYTA1xtQOa6W0Sy8KZ9Nks2xhLnnXrqH
 GqAa6DOx7ezTdcBHLs9osXC3XGRwqYHFapuIjnqNJ/8jgcTdevkq1iwPq1zzXhKaIfIw
 dVWMiasuxQIPc/eiaLyyciay4Oe95QTkAEFOWUvi2RqyDaj7OHwiDfaqremwBNFWrWMV
 uqWQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784134818; x=1784739618;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m9a/j/d0mP83OcVS/TJX1TwvbByrzwGxmrAbCSEYwSM=;
 b=qhwaRjFQaU9raSs+6/s7QjKvkk54uRaPbJESz2eD/mIVj+lIH6OGxNQWwImBpsWBDO
 yA6fW0rExWujcLqIsnCDWepq53mx7xm+bGle8paxP4bOPxBIvtR8qUyo77d49g/dNRiu
 DqK0iGOWcp8dSZF6TNkI/OvQlYFdF6Fch7gzI0Y4Txsfo5U1mG48R9JXzQoOn9h0xwXM
 uK5aJCg26UN53dUFbqWDIXDoiSSOh6ChXtM9OEMhJ92pAg41KKhMk/Hq1KsDr363kKIK
 A+w3dhF0D+XAWBaTkY2qmNgCfS4BpyY+PqyWiVuEFq9k6xf/zRmaZBY3kf6zZnxm7y+F
 oC4w==
X-Gm-Message-State: AOJu0Yx5XH9kzkt7r/VMzleyu26lInOfn/wZeI7gSmNH63O0Da14I3Hl
 DAbcIjP+NdjOeb6wzDpPSPCIB2WRB0FdxsZRCK4wBRXe4wAv9vLTnK/ooVm47tY6rmOXvNToM/p
 tuJIP03HI+U2PZAJ9t7KTqNERXoKK/Uk=
X-Gm-Gg: AfdE7clKNTS/dmHg4IeIJSps7lh8i2ZorKR+2Cb6sZC6/vxcLFX1gKf3oLyLJ2TBcET
 KScb5mvFqjesHIm4n2oS6c87Wn5vzHFcMwVJR6yf/aFxWI4vlAm6oyvo2uQu+XQgk9lgfhqK2tB
 UJtmS+xxMF/ZqX5NkR0KJJiDKTBHek4aF4Y5NUZVNNgpCZxifqLUtuRzHhfk5fJL+EWbhheAEDE
 AHjvqc2Aovt2QBcFaib1fn3WSR3YqqtAMiIeeCQbfYds+ZNt1/9EsJzs/K4x//0Bo68GZYxA84z
 V/GQIawvL+W3qDO0JRWcgzFGzMw=
X-Received: by 2002:a05:620a:260a:b0:92e:c118:18b8 with SMTP id
 af79cd13be357-9309640434fmr312501885a.87.1784134817882; Wed, 15 Jul 2026
 10:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260630123857.392884-1-maxime@leroys.fr>
In-Reply-To: <20260630123857.392884-1-maxime@leroys.fr>
From: Maxime Leroy <maxime@leroys.fr>
Date: Wed, 15 Jul 2026 19:00:05 +0200
X-Gm-Features: AUfX_myTKoPB7RbDcvxe2BYzbIcMs6ksTdn7nzJoIw2Ua7f6blB8cXzIuMLzX0I
Message-ID: <CAHHRULVvBsUjxVJh++BKsV_tGJLnh2Fuo+fJYh-=M_rsTKmVtg@mail.gmail.com>
Subject: Re: [RFC PATCH] net/dpaa2: fix RSS at inner level for non-tunnelled
 traffic
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org
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

Hi Hemant,

Do you have any preference between the different approaches proposed below?

Regards,

Maxime Leroy

On Tue, Jun 30, 2026 at 2:39=E2=80=AFPM Maxime Leroy <maxime@leroys.fr> wro=
te:
>
> When RTE_ETH_RSS_LEVEL_INNERMOST is requested, the IP key extracts use
> the innermost header index (HDR_INDEX_LAST). The hardware only resolves
> that index when several IP headers are stacked: for a non-tunnelled
> frame, which carries a single IP header, the extraction returns nothing.
> The RSS hash is then constant and all such frames are steered to a
> single Rx queue.
>
> Always also extract the outer IP (header index 0), which the hardware
> resolves for any frame. Non-tunnelled frames are thus hashed on their
> only IP header, while tunnelled frames keep being hashed on their inner
> IP.
>
> This is a deliberate tradeoff: the ethdev API defines
> RTE_ETH_RSS_LEVEL_INNERMOST as hashing the innermost header only, but the
> hardware cannot do that without breaking RSS for plain traffic. As a
> consequence, two tunnelled flows with the same inner header but
> different outer IPs may hash to different queues. This limitation is
> documented in the dpaa2 guide.
>
> Alternatives considered (feedback welcome, hence RFC):
>
> - Hash both outer and inner only under RTE_ETH_RSS_LEVEL_PMD_DEFAULT and
>   keep INNERMOST strictly inner-only. The ethdev API leaves the default
>   level to the PMD, so this stays API-compliant; it changes the default
>   hash for tunnelled traffic.
>
> - Add a generic RTE_ETH_RSS_LEVEL_OUTER_INNER value to the ethdev API so
>   applications can request hashing on both encapsulation levels
>   explicitly, instead of overloading INNERMOST. This needs an ethdev API
>   change and agreement from other PMDs.
>
> Fixes: 32f701671d2f ("net/dpaa2: support inner RSS level for tunnelled tr=
affic")
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  doc/guides/nics/dpaa2.rst              |  6 +++
>  drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 64 +++++++++++---------------
>  2 files changed, 33 insertions(+), 37 deletions(-)
>
> diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
> index 2d70bd0ab9..b7b68f0cd5 100644
> --- a/doc/guides/nics/dpaa2.rst
> +++ b/doc/guides/nics/dpaa2.rst
> @@ -558,6 +558,12 @@ Other Limitations
>
>  - RSS hash key cannot be modified.
>  - RSS RETA cannot be configured.
> +- Under ``RTE_ETH_RSS_LEVEL_INNERMOST``, the IP hash also covers the
> +  outermost IP, not only the innermost one. The hardware extracts no IP
> +  at the innermost index for non-tunnelled frames, so the outer IP is
> +  added to keep RSS working on plain traffic. As a result, tunnelled
> +  flows with the same inner header but different outer IPs may be
> +  distributed to different queues.
>
>  .. _dptmapi:
>
> diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/b=
ase/dpaa2_hw_dpni.c
> index 07f4a3d414..b002dba171 100644
> --- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
> +++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
> @@ -398,48 +398,38 @@ dpaa2_distset_to_dpkg_profile_cfg(
>                         case RTE_ETH_RSS_IPV6:
>                         case RTE_ETH_RSS_FRAG_IPV6:
>                         case RTE_ETH_RSS_NONFRAG_IPV6_OTHER:
> -                       case RTE_ETH_RSS_IPV6_EX:
> +                       case RTE_ETH_RSS_IPV6_EX: {
> +                               static const uint32_t ip_fields[] =3D {
> +                                       NH_FLD_IP_SRC, NH_FLD_IP_DST,
> +                                       NH_FLD_IP_PROTO };
> +                               static const uint8_t ip_hdr_index[] =3D {
> +                                       0, DPAA2_DIST_HDR_INDEX_LAST };
> +                               unsigned int n_hdr, f, h;
>
>                                 if (l3_configured)
>                                         break;
>                                 l3_configured =3D 1;
>
> -                               kg_cfg->extracts[i].extract.from_hdr.prot=
 =3D
> -                                       NET_PROT_IP;
> -                               kg_cfg->extracts[i].extract.from_hdr.hdr_=
index =3D
> -                                       hdr_index;
> -                               kg_cfg->extracts[i].extract.from_hdr.fiel=
d =3D
> -                                       NH_FLD_IP_SRC;
> -                               kg_cfg->extracts[i].type =3D
> -                                       DPKG_EXTRACT_FROM_HDR;
> -                               kg_cfg->extracts[i].extract.from_hdr.type=
 =3D
> -                                       DPKG_FULL_FIELD;
> -                               i++;
> -
> -                               kg_cfg->extracts[i].extract.from_hdr.prot=
 =3D
> -                                       NET_PROT_IP;
> -                               kg_cfg->extracts[i].extract.from_hdr.hdr_=
index =3D
> -                                       hdr_index;
> -                               kg_cfg->extracts[i].extract.from_hdr.fiel=
d =3D
> -                                       NH_FLD_IP_DST;
> -                               kg_cfg->extracts[i].type =3D
> -                                       DPKG_EXTRACT_FROM_HDR;
> -                               kg_cfg->extracts[i].extract.from_hdr.type=
 =3D
> -                                       DPKG_FULL_FIELD;
> -                               i++;
> -
> -                               kg_cfg->extracts[i].extract.from_hdr.prot=
 =3D
> -                                       NET_PROT_IP;
> -                               kg_cfg->extracts[i].extract.from_hdr.hdr_=
index =3D
> -                                       hdr_index;
> -                               kg_cfg->extracts[i].extract.from_hdr.fiel=
d =3D
> -                                       NH_FLD_IP_PROTO;
> -                               kg_cfg->extracts[i].type =3D
> -                                       DPKG_EXTRACT_FROM_HDR;
> -                               kg_cfg->extracts[i].extract.from_hdr.type=
 =3D
> -                                       DPKG_FULL_FIELD;
> -                               i++;
> -                       break;
> +                               /* outer IP always; inner IP too for INNE=
RMOST */
> +                               n_hdr =3D (hdr_index =3D=3D DPAA2_DIST_HD=
R_INDEX_LAST) ?
> +                                       2 : 1;
> +
> +                               for (h =3D 0; h < n_hdr; h++)
> +                                       for (f =3D 0; f < RTE_DIM(ip_fiel=
ds); f++) {
> +                                               kg_cfg->extracts[i].extra=
ct.from_hdr.prot =3D
> +                                                       NET_PROT_IP;
> +                                               kg_cfg->extracts[i].extra=
ct.from_hdr.hdr_index =3D
> +                                                       ip_hdr_index[h];
> +                                               kg_cfg->extracts[i].extra=
ct.from_hdr.field =3D
> +                                                       ip_fields[f];
> +                                               kg_cfg->extracts[i].type =
=3D
> +                                                       DPKG_EXTRACT_FROM=
_HDR;
> +                                               kg_cfg->extracts[i].extra=
ct.from_hdr.type =3D
> +                                                       DPKG_FULL_FIELD;
> +                                               i++;
> +                                       }
> +                               break;
> +                       }
>
>                         case RTE_ETH_RSS_NONFRAG_IPV4_TCP:
>                         case RTE_ETH_RSS_NONFRAG_IPV6_TCP:
> --
> 2.43.0
>


--=20
-------------------------------
Maxime Leroy
maxime@leroys.fr
