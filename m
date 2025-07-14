Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB6C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 20:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EC23402EA;
	Mon, 14 Jul 2025 22:09:24 +0200 (CEST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id E67444028C
 for <dev@dpdk.org>; Mon, 14 Jul 2025 22:09:22 +0200 (CEST)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-717a2ef8943so47027747b3.1
 for <dev@dpdk.org>; Mon, 14 Jul 2025 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752523762; x=1753128562; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvrPCs3TgX7Y2Wbcc/rvWvVECNcEC/1vWKicwHeQQq8=;
 b=L75SMGY7p/sQWlvL5rpI2rKcsuKF/kDEOWM8bIfHJv5lbZQrQCdMEyY66ph68OoZfy
 0VROsS8SqpyTX8HolBFFbWG5xEK9VnY0B3DesEexLtQGAIQHRhjdkFC0+WiPjoe9ka5N
 8B8HQ6BnDdZPfutp6ZMLqZ53pqi84APN6YZRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752523762; x=1753128562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvrPCs3TgX7Y2Wbcc/rvWvVECNcEC/1vWKicwHeQQq8=;
 b=jIGLSFPrL9BHuGxkvMTsKQPdXF8bTYwedh9A3IiY+lKQEXB1brtkVSfgkh98OlYQl+
 VPbgmdiJDDRcPtD/BqJgUh9G+YTI0e+FmrvNc/hDW/CirUjoEkl0oIrkL2U2PAmVDedz
 1HL1Nyu98gDB23R0paK0e5VvocwpNF+519uLJfFs5IjudfJzJzNXc5eyp1yreuYvDVyk
 s0eUqKwPXYsZNJntIzIHJHbPfcIjWVaCqotwPS6Wk4jMH2Tb1ED9GZ0mYjzR7AAHm1NJ
 UdO1LQ8d78eyN5akvoC7vaz1YMG7R5AMj/qrvu7S3w7HHVOQ2TYZbg9VDANQo2qgtpXW
 0CKg==
X-Gm-Message-State: AOJu0Yym7A1xcDhNTiQeb1ciJlTBNVhwXggh8pP7yFCrgRlt+h3tLuag
 KOcumUEI/g43x1Cm1TkwXIJWUUgCZpVfMnvo8nYORLL8oEX3KgvQKLBc+h4bRegSZ3QtLnyGDJJ
 SrYwdHu1NwQqYbQOsnmOz0GLtgmqwf+6gik7Bcwhb0g==
X-Gm-Gg: ASbGncudOT9yywZ3xq4LII/y20iY5WgAsrC+jcQuEMM1LP3bSW4FzZN26WfkdLuxDLH
 vNZj26nGDYmwg3NVuGYaz1n0p3qRyHNpJAFYqV4KMGl1qZY6NW7roAUaPzw428MWbne74KF9rwC
 ufvCzf1kCoF2A/d/diLRC2TAOcmY1iPrNb8Tr5USeHqOM2HFBRw48+2NcfAzIIQwnqO7ciBwEAE
 nH5vV+Rh0YeAqkQG7pEuhE=
X-Google-Smtp-Source: AGHT+IFq6/0XRiSqQGxm7ziiaZzswd4gsjexeN96qQRBYxRT109wusOL6QJwFktsVSuhi4Y0hIhl6T+cWV94ogy5HoQ=
X-Received: by 2002:a05:690c:6a0d:b0:70c:bd93:4519 with SMTP id
 00721157ae682-71824c16422mr3898287b3.21.1752523761833; Mon, 14 Jul 2025
 13:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250714133014.44597-1-bruce.richardson@intel.com>
In-Reply-To: <20250714133014.44597-1-bruce.richardson@intel.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Mon, 14 Jul 2025 16:09:11 -0400
X-Gm-Features: Ac12FXxB8Ce3u4gj68PKTCyi8v3aAFKI4G8ISL2S9skuaHChOafToC9TyU_WuD8
Message-ID: <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, techboard@dpdk.org
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

On Mon, Jul 14, 2025 at 9:30=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
> not very well documented. Even the documentation that does exist appears
> contradictory.
>
> For example, the doxygen docs for the mbuf flag
> RTE_MBUF_F_RX_QINQ_STRIPPED says:
>
>   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
>   is unset, only the outer VLAN is removed from packet data,..."
>
> but the docs for RTE_MBUF_F_RX_QINQ says:
>
>   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
>   headers have been stripped from mbuf data, ..."
>
> Without a good definition of what the correct behaviour is, it's not
> possible to assess and ensure conformance across drivers. Update the
> documentation for NIC features, ethdev and mbuf library to all report
> the same information: that VLAN strip feature is stripping one flag, and
> QinQ strip feature is removing two.

I'm working on testing QinQ/VLAN stripping features across PMDs, and
so far I've found that our Intel devices are capable of QinQ
stripping, while our Mellanox/Broadcom devices are not. When QinQ
stripping is enabled on an Intel PMD, the test packet is received with
its outer VLAN layer stripped, but the inner VLAN layer remains
intact. Thus, the doxygen example is more accurate for what is
currently supported. I'm also running some tests on VLAN stripping
behavior, I'll update this thread with the results once these are
finished.
