Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A95E83061
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 08:20:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E856402EF;
	Tue,  3 Feb 2026 09:20:56 +0100 (CET)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) by mails.dpdk.org (Postfix) with ESMTP id 7AD23402A2
 for <dev@dpdk.org>; Tue,  3 Feb 2026 09:20:55 +0100 (CET)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-5ed065f1007so3634223137.1
 for <dev@dpdk.org>; Tue, 03 Feb 2026 00:20:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770106855; cv=none;
 d=google.com; s=arc-20240605;
 b=hMCypN657r1Qv7gCLa+l8HCNWUau10Sj4/Us5V0y4Mi/AHO+L+vTpSU9Nq7J/gjsq6
 gSocTbvAwMlbuu1JzmCgvqVSw7ayja24Qyh8mlhGo9QSroxMsH6TOy5LP51FLINMFrCH
 VUWAn5oBNAxJvDtS52GamHTiM0pF4pe4BDcHW1OQRWDh2ApdKJD5ZlLrQg91FCUqY2Yn
 lOeSiVS+yejKr6GxCU5638YBHDn4MVO5cSrSG/G+jxeoPy7t775JlbBjJXGcSYfaCZKE
 JbbzJN2VLFqTNLQCv2310WoNp7I0Xbg5WVxA+Q4szC6lXdyYw74Ugm793BJrzghKER18
 pUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LVBUcnmsqUhyFnyNh/pdaaE2cjc7eD2lcE1PaOKRgVo=;
 fh=8oGxs2oF7z9SqOmD6xCfa+YvejyAOOsO/9wX54LOipk=;
 b=Oq2HKieAxzkmAnjhKaDg7I8j/n2z21ZcYCW/+n4poNjoyhWnkpm79NExNtCPqQoi0z
 kvi1zJwW3hQQ40glN01MOL/lF7q1SS7mQ1aBx4KDd0j4kYgTGIiamtIbtbwBf1wzQK7r
 J9MYS7+a37YlOYAU845KyerwBW/KCVhiWDLwOrSBqopSrb+RwF6nB3uJJ7gcx8s9kSV5
 pj5cgAhgoCibZJyzEEtdduQS6yRP+lS77uNINiJuQcznplZh4u2X6vGqylREHpcrBU2Z
 zi35DZyEJnY5PdEzXw0x/A5dtDKl3AZIer2RsvLoYhw+0I4i806yXGIsjYTtNMyyVvcr
 TFcQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770106855; x=1770711655; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVBUcnmsqUhyFnyNh/pdaaE2cjc7eD2lcE1PaOKRgVo=;
 b=NPI5mu0X2EcmsbYst1ErOswUemfoSWtrYE1GS9myLMUX+c1FEV9w6IaAypwstNzc/3
 /tVd60Rc9DNTJsdmRFRr7jHd7L0cWqBsoSSqe4hV1WqansS2+jwlq3ru+al/alwOj71H
 hjnlN9ciEmRXHRhJ3ixgn/x7lhJv6Elnl7jSUGarROBRMRN1wNSclfUuDNYHDC1CYoLr
 GsXQ3IhV/Z8yOVCG1Z/ZpnZq+idJ1GNp9uavYvSEf9uNfK74fwgpl1ul+5QL2Acvol1Z
 8A369re5NGsTvQaesMJds2HWtrV08t/xNUxVTx+SNy4r1vbySro5iqHCudsRlWVXVHx3
 Nmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770106855; x=1770711655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LVBUcnmsqUhyFnyNh/pdaaE2cjc7eD2lcE1PaOKRgVo=;
 b=UJESaX1nM1tlYPhnkLRdFu1V6otP2YE9OYK6ImsFQiBueyVXsPRaITsu8u+DvZOkRk
 cOmbP0Mtqo22oUDUHdi3Epek1a4r8WLFwkP1yzzJDdslRw9KuRfsXH8F+Hs23rqhaYqN
 hNMDsT/kHzupuI3aU37kdPNJ2SRAQv6o3P1Wb5fzvX9UVmUG3EiTo8xvQcUAbTKHTDGD
 BhPr5FLdgC1jkVPGri7nrFkRKEqzto9l+xkYS3+TzcTGnOBRppa30k1SyqNTPNbcLs7j
 /kI8n3YfnDIjcTJCbTIM52XKBhO7+ZWkVK51eyyDRJbprjxfkMfBgc4TvoRbJlDoAUmg
 znbg==
X-Gm-Message-State: AOJu0Yy0NeDOJyFIHSessSRSKJKAhCvI9N7zJY7JSPCyzPW1QybXp/mc
 klzj3Duqi6gTPWDeWfJ8G/zXUnNH4MMjT9jHXM3EwHDSU36Phgo0qOx9PmuekKU7alP59tedKv1
 niAmJZBgn/13GNP2pUICei258VhjS8o61ngng
X-Gm-Gg: AZuq6aIxViiBk9S5LF7sWbOdMKJqNH4J/vycudReaozW/NRdDCsrOWJzi2yp9yk6SXn
 zJus/jt4L/PsMhnXTEy6PzL9W31iykCP1gTX3ZNL1Y16ogJh2isU07Kt4+Ko8TjYrtrNBgu9/Dk
 Ocp/rS+qxIHtQWqCvxTRAFGpJyP+VTRLip8FpG8a2bnDFycKV4wm+u91Q3DdGanFZxM/xFa6/+1
 ixUuo9nJ5eUo6EF4VQqv8LfQJORd4nN8uUg79c5uKOZ01UMEtl6KFeRkkaOZJ2yzuxkSeaUviFN
 EoplbA==
X-Received: by 2002:a05:6102:50ac:b0:5e4:95f6:3dca with SMTP id
 ada2fe7eead31-5f8e259affamr5281495137.30.1770106854696; Tue, 03 Feb 2026
 00:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-5-scott.k.mitch1@gmail.com>
In-Reply-To: <20260203070740.62305-5-scott.k.mitch1@gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Tue, 3 Feb 2026 00:20:43 -0800
X-Gm-Features: AZwV_QhnfFoL_2F60P_rlPXLia2hF-PJr3sVrI6WASZ0E4avyPYay0tPp4Ew5tE
Message-ID: <CAFn2buBHCKj52h0k3ApW_5jG5BK7PUYu2Agmqs0576mUZ_+yXw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] net/af_packet: add software checksum offload
 support
To: dev@dpdk.org
Cc: stephen@networkplumber.org
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

gcc warnings are resolved when built with Depends-on patch
(https://patches.dpdk.org/project/dpdk/patch/20260202044841.90945-2-scott.k=
.mitch1@gmail.com/).
Did I indicate the dependency correctly (reference
https://doc.dpdk.org/guides/contributing/patches.html#patch-dependencies),
and is CI expected to apply dependent patches before the current patch
series?

../lib/net/rte_net.c:672:28: error: taking address of packed member of
=E2=80=98struct rte_udp_hdr=E2=80=99 may result in an unaligned pointer val=
ue
[-Werror=3Daddress-of-packed-member]
  672 |                 l4_cksum =3D &rte_pktmbuf_mtod_offset(mbuf,
struct rte_udp_hdr *,
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  673 |                                 l4_offset)->dgram_cksum;
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~
../lib/net/rte_net.c:675:28: error: taking address of packed member of
=E2=80=98struct rte_tcp_hdr=E2=80=99 may result in an unaligned pointer val=
ue
[-Werror=3Daddress-of-packed-member]
  675 |                 l4_cksum =3D &rte_pktmbuf_mtod_offset(mbuf,
struct rte_tcp_hdr *, l4_offset)->cksum;
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
