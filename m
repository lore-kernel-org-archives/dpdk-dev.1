Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B0CD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BA8F402BE;
	Tue,  9 Jun 2026 12:43:58 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 356004025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 12:43:57 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id C961FEC00D0;
 Tue,  9 Jun 2026 06:43:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Tue, 09 Jun 2026 06:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781001836;
 x=1781088236; bh=RAssODySkAQCVKeh8PbBONhCGC8sm79Qk4Jvx0QJMx8=; b=
 plPAOqoxeleDQeKELfRNGc+wL8Eah9v+D2/zh/C1Ajy0DFRsoY6MlDq8fjhK8mbj
 cysG5QckI8OHcPxe732TfktleJLG8qI6pBikdZLTIiGqxt+RvQhMGCSU2Jtnrvsi
 CetlKOPAQNXI/r3fvnMzNXOHWxLvohzZCrnUpwFCBNuUuLLGQcccYdGNJ2cy3RZl
 sHjpv5THSDjv+n4lEneMl1AUJzJPbNphdIOT9nt6K02M6T++GpC3p2Pme8rKTH9x
 Z1MAgNfLNALdYHFYzZJrl5K+H+O1TGjLrlSEuAlKcDOeO0uyezgsJ2CNm6tYpO/T
 e1NHYbYRh4isxD9aIKIhZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781001836; x=
 1781088236; bh=RAssODySkAQCVKeh8PbBONhCGC8sm79Qk4Jvx0QJMx8=; b=L
 bKxHaF/KOePmsPyhiVOFZebNgvVYzSRaOWLApQj8ccL4S1ddje+ut/C/87lf/uzD
 a969/2/9/SwtUq38JDMsejfy8HDvI4RKxuFSSVgjPswZ5BeqXFADFsi8B0GLrCnz
 yuJdDfAFBqInEFmraoia8jdLh9d/Qj4biDVBIuMzS/SeL6o9Sv6EoFvGrZjafuF1
 x5nnfhuvoz73ehNpO31Tq9VxxUQXmIUOFHiid2MEQeqjQti+6njWmbBdgRKDWNw1
 yQ82YUkAvnDVk8tY6Gpo2r4X/hxamZL8jkYEZSh/olEt0ytMyQo1amNtL9CRMS5u
 nzpBfoAvgu7lOp4MMFP/w==
X-ME-Sender: <xms:bO4nasiqlKhwi_p6WOk662vCy_-8Ol-xdUJBSqabPSzK04W-Ip_lLw>
 <xme:bO4napVStNZeS6S5Rm0_pdc13ymJchah_dQHBKN7VuLawEPHYlpvMt69xbWVT70bQ
 pKur459KxO5Z1RTVtRMJROLrRW-P0flleEnTf9mXeX7LNMm6XUR0kM>
X-ME-Received: <xmr:bO4najO66Z-oX1vS_2i-T0SZbEVqstCGXr_Odabc27PU-_bjyrmBPntc_7qcRDNtHc59ZTTv_h3KBSXS1r8lLUeKug>
X-ME-Proxy-Cause: dmFkZTEf0yaIq5ICUJvC9A7UDxDvnJnFa04iJzgOe5qAHhzhvQLNLFn4oFEUpdkixp9Ian
 PnNmh0iJjqcIhbzj7xLa86IfxSD4Mx8WjctTcpDnppGPh+qg4mEOI7lJslbCStZckBB4De
 KJlnV28yDZzl1dGpCxzxvhSo1A+HD1VFL18Pwt3ZzPsutfR40pGgwS7fpkOUU4ZL1px+bN
 CaenPfU0Uitrcf6yLO+ikw9ZyQ9OkHgJC1I0CiD/v+yqWz460B6YWPHAzS0HIejCaPSeB0
 tfLh6ah8wWeAlydJtPawDikB6Ap2QYUeMEkQ+xBQlJ0w/rtwJA43AobrRtxkgrLkUvvGBY
 6qI88Qq73It/JIAnm5sxORE4VIwru5TzkmiIoCbJEvwD2AdGue574XrD2c54b7HjGrz5Gx
 92JAkQ5HTq//7antBMmahYx3rBYok2WX42Zs9hm/PuQeShjKoc7sjBaaN9tC8joeYGWTqY
 rJcmoAtwfR28bFcKikQ0MciJU5lvkwkdKOMEfGO1NPDyIbpGbNtfi4NRtBLBoLdBQppMKn
 DooGvWcjtweCvoq5Bk6rfEkj0/AdbkSS5r9Tc8+OnIe+AIZtark7g9FFY/l8aAF1fhN1yj
 0P3GXDMoCGXQOIm/sAgUthwgvipOxt00WBC8zcgxySlLUnudvt9seLtngkDQ
X-ME-Proxy: <xmx:bO4nalYRpKZAuGrHzfZ7YWHMfCtPqptVD44DaEf6alGkD8dXPVs2hA>
 <xmx:bO4navqtNB9RwrjjpuQ84Qv4vwNc-sS53OFrgPfcUwGFD8T0AR33ew>
 <xmx:bO4nahYz_7T2YWtov7sA4ZfwmdwXinNS_hBFADPhbLbadGzLcOKJRQ>
 <xmx:bO4navT_N--BKZ6SQJ6lqzvLhgYBvfckVl_fE92T99OS87u2lTk05Q>
 <xmx:bO4namGRDNhP0AYCiER9IeYEevgwXPVQGqELEkL1Iy0FILBGLlF7hfIu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 06:43:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: =?UTF-8?B?6K64546y54eV?= <lingyan.xu@metax-tech.com>
Cc: dev <dev@dpdk.org>, eagostini <eagostini@nvidia.com>
Subject: Re: =?UTF-8?B?5Zue5aSN77yaW1BBVENIXQ==?= gpu/metax: add new driver
 for Metax GPU
Date: Tue, 09 Jun 2026 12:43:54 +0200
Message-ID: <J2c1Ke4gRXqOUlr2bqZFPg@monjalon.net>
In-Reply-To: <fbe7f8ce-f680-411a-a7a6-82eda60300de.lingyan.xu@metax-tech.com>
References: <6c18e957-c1c2-4b43-9b2c-b36424c1e9af.lingyan.xu@metax-tech.com>
 <CsAn75rzSb2jiQLRSeXkmQ@monjalon.net>
 <fbe7f8ce-f680-411a-a7a6-82eda60300de.lingyan.xu@metax-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Thank you for the detailed answer and your understanding.

One more question: are the lib and module upstreamed already?


09/06/2026 12:22, =E8=AE=B8=E7=8E=B2=E7=87=95:
> Hi,
> Thank you for the detailed feedback and for reviewing the proposal for th=
e Metax GPU driver.
> Based on the questions raised and the analysis of the code implementation=
, here are the clarifications and my action plan:
> 1. Regarding GPU Access Method
> The driver interfaces with the Metax GPU hardware through a combination o=
f the vendor-provided MC Runtime (Metax Compute Runtime) library and GDRCop=
y (GPU Direct RDMA) technology.
>=20
>  *=20
> User-space Library: As seen in the maca.c code, the driver dynamically lo=
ads (dlopen) the libmcruntime.so library. It uses mc_runtime_api.h to manag=
e GPU contexts, memory allocation, and device attributes.
>=20
>  *=20
> Kernel Module: The driver relies on the underlying Metax kernel driver (f=
or PCI probing and basic device access) and the gdrapi (GDRCopy) kernel mod=
ule to facilitate zero-copy data transfer between CPU and GPU memory.
>=20
>  *=20
> Dependency: The build log confirms the detection of headers like mc_runti=
me_api.h and gdrapi.h, which are essential for this integration.
> 2. Clarification on "Rendering" Functionality
> I apologize for the confusion caused by the term "Rendering" in the initi=
al description. Upon reviewing the code and your feedback, I realize this w=
as an inaccurate choice of words.
>=20
>  *=20
> Correction: The intended functionality is purely "Compute/Data Processing=
" and "Memory Management".
>=20
>  *=20
> Explanation: The driver's core logic (as shown in the patch) focuses on m=
emory registration, allocation, and CPU/GPU data synchronization (via maca_=
mem_cpu_map and gdrcopy_pin), which are essential for network data processi=
ng acceleration rather than graphical rendering. I will correct this termin=
ology in the documentation to avoid further confusion.
> 3. Action Plan: Following the Contribution Guide
> I have reviewed the <"Adding a New Driver"> guide you linked.
>=20
>  *=20
> Patch Splitting: I understand that the current monolithic patch is not su=
itable. I will rework the submission and split it into a logical patch seri=
es:
>  *=20
> Patch 1: Add the basic infrastructure (Meson files, maintainers, configur=
ation).
>=20
>  *=20
> Patch 2: Implement core device functionality (PCI probing, initialization=
, context management).
>=20
>  *=20
> Patch 3: Add memory management and data path features (allocation, regist=
ration, and CPU mapping).
> Thank you again for your guidance. I will resubmit the revised patch seri=
es shortly.
> Best regards,
> Lingyan Xu
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AThomas Monjalon <thomas@monjalon.net>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2026=E5=B9=B46=E6=9C=882=E6=
=97=A5(=E5=91=A8=E4=BA=8C) 18:01
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"=E8=AE=B8=E7=8E=B2=E7=87=95"<lingyan=
=2Exu@metax-tech.com>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Adev<dev@dpdk.org>; eagostini<eagostin=
i@nvidia.com>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH] gpu/metax: add new driver=
 for Metax GPU
> Hello,
> 01/06/2026 07:47, =E8=AE=B8=E7=8E=B2=E7=87=95:
> > I am writing to propose a new driver for the Metax GPU,
> How do you access the GPU?
> Are you using a specific library or kernel module?
> > which I believe will significantly enhance our support
> > and performance for this hardware.
> > The patch attached includes the initial implementation of the driver,
> > with key features such as:
> >=20
> > * Basic initialization and configuration=20
> > * Memory management and allocation=20
> > * Core functionality for rendering and compute tasks=20
> I am familiar with connecting compute tasks of a GPU
> with DPDK networking, but I'm surprised by the rendering functionality.
> Do you mean graphical rendering of data coming from the network?
> > Please review the code and let me know if you have any feedback or sugg=
estions.
> > I am more than happy to make any necessary adjustments and improvements.
> Thank you for working on this.
> I recommend following this guide to introduce a new driver:
> https://doc.dpdk.org/guides/contributing/new_driver.html <https://doc.dpd=
k.org/guides/contributing/new_driver.html >
>=20
>=20
>     =E8=B6=85=E5=A4=A7=E9=99=84=E4=BB=B6=E5=88=97=E8=A1=A8            dpd=
k-build-test-log.txt  [48KB]
>         =E8=BF=9B=E5=85=A5=E4=B8=8B=E8=BD=BD=E9=A1=B5=E9=9D=A2  https://q=
iye.aliyun.com/alimail/openLinks/downloadMimeMetaDiskBigAttach?id=3Dnetdisk=
id%3Av001%3Afile%3ADzzzzzzNqZx%3BJYiJwCficINAoHh55iyjKdydQzW5hDE%2FGjddF2Xp=
4ghl2ujmlGlWdfhgNCLOb5s3BZAHvDXTdZhtzGA3q8HJ%2Fv%2FPGnrPJfO1Xc%2BWnHr%2FKRw=
IkHzWFe5Iwm1IZrurr9hW   =20
>=20





