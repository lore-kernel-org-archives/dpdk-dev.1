Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DBBC83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 17:39:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 720194026C;
	Mon, 21 Jul 2025 19:39:08 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 9E6794021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 19:39:06 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 03E36EC0287;
 Mon, 21 Jul 2025 13:39:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 13:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753119545;
 x=1753205945; bh=aJJ1PaFN/wJ73Q2DfPmNaiOxTdIyPtovxRHzICF9M3Q=; b=
 nFszL7GthR5ec7Nm5CD/5oZXltZb6obFDwAV65May0eAN56d4KpmH/gJz6tlQ/wU
 cgvkdDam2WNmBR+GVDphMcm5Bq4Xxjeo6h7CXyjbSmOqPb3axzkVIIRqWnflVI4a
 ATHvLsTpA0LqY6ZXmBjDFTRMgaUFJcK+L7j+ug61oEtdNns7R4ZlE3GI9fcWMFoQ
 jdhSYBdE0ydy70/ijeJtHJwPCC5FCbZ/FQQ9brc99j+JrZTIB21UJlpllecIFCd5
 WiB5a8zrBuK+t62+L1lmUPPxAUlnhIAG3hLQgo85cRmkZHfmZqF+1Lo3L8qBrw/l
 v0dIyRY/SpXNgRbZXlXiUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753119545; x=
 1753205945; bh=aJJ1PaFN/wJ73Q2DfPmNaiOxTdIyPtovxRHzICF9M3Q=; b=H
 PPn7w9XooQlIylXO7j932y7MdNJqZmfUOe50UAZvbskK8KAtWCNTwiifMYVUoNEb
 iLlgKS4DLnuESdfD3q83nVPXT2Pdr4r6Jt8SaY397f74Ed6egjVrDFRwjF4Yd5/S
 pYx8JYzyXFzVL24gw/K+XVjSyDJk9TBzeirb/QjGDG7rUaqAQQj3kvvEoc625IAh
 nFDdkm3E+FM02LXOPWg0sNvCP8YVpU7qNWDouEcH2G2yiTxSog1y0do0Drt+NLr6
 KrWgChB4afy5tNTWdJtvtycIj+XDDujbqc86taSS+ufE9ErqAzY37BkpIAdrxBhD
 kE3kb2gX+27jJpzYHj+wQ==
X-ME-Sender: <xms:OXt-aBHKzbLQbx--yHBrjp4T1lykZSFtEMQkYuVoNl5lrPSN1xrd1A>
 <xme:OXt-aESXD2ForPTG4seHJtnsJv9WHN2rX3rZYXrkKeOBospQRD-mf96WaMEognw6b
 Wki912GXPNnfjTJZw>
X-ME-Received: <xmr:OXt-aFfBq7eLybkwxFabqUAhWXuI6UfbrdI8WbLz5Ue3HMqO7cIP-yHJki3MCmcpL5i0Sf6TyWHMEAR89l2S7J4e_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdeilecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtohepug
 grvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegslhhu
 tggrseguvggsihgrnhdrohhrghdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrg
 htrdgtohhm
X-ME-Proxy: <xmx:OXt-aLrWzHpBD0_CecJZtHG6UyXLUt4RfhTQ_Lfvcio38MRV3Ll85w>
 <xmx:OXt-aO_4h3WOEZTRKfOAeaSs_5m-IcXQ1DBGsUBjXqRTlMtwln-BTg>
 <xmx:OXt-aPeGVVlvzd1RzO7g3Xzz0i0AgeWCEstgRYstuGTD1qmY9AhDDg>
 <xmx:OXt-aAKAkA2CcrNcHrz5cI3azYtMrGHSc7dJB1yOEpHa1vLEG5AyYQ>
 <xmx:OXt-aN_sQgw1-RmfO9fPOGd7bN_4Wy6Ut338aNi6eLmk4Fk8fsia2khs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 13:39:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, 
 David Marchand <david.marchand@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Kevin Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH v2] doc: update kernel version requirement
Date: Mon, 21 Jul 2025 19:39:03 +0200
Message-ID: <6697631.K2JlShyGXD@thomas>
In-Reply-To: <8fc75987-9397-4290-8c22-d4c6354e2fd2@redhat.com>
References: <20250409035408.199320-1-stephen@networkplumber.org>
 <20250410152117.5822-1-stephen@networkplumber.org>
 <8fc75987-9397-4290-8c22-d4c6354e2fd2@redhat.com>
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

21/07/2025 12:45, Kevin Traynor:
> On 10/04/2025 16:20, Stephen Hemminger wrote:
> > The 4.19 kernel version was end of life in December 2024.
> > Update to 5.4 and also add better description of what "not supported"
> > means in this case.
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > ---
> > v2 - better wording
> >=20
> >  doc/guides/linux_gsg/sys_reqs.rst | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/s=
ys_reqs.rst
> > index 5a7d9e4a43..ba48b8afc0 100644
> > --- a/doc/guides/linux_gsg/sys_reqs.rst
> > +++ b/doc/guides/linux_gsg/sys_reqs.rst
> > @@ -105,11 +105,20 @@ System Software
> > =20
> >  **Required:**
> > =20
> > -*   Kernel version >=3D 4.19
> > -
> > -    The kernel version required is based on the oldest long term stabl=
e kernel available
> > -    at kernel.org when the DPDK version is in development.
> > -    Compatibility for recent distribution kernels will be kept, notabl=
y RHEL/CentOS 7.
> > +*   Kernel version >=3D 5.4
> > +
> > +    The Linux userspace API is compatible across releases but there ar=
e some
> > +    restrictions. The oldest kernel tested by the DPDK testing infrast=
ructure
> > +    is the oldest maintained Long Term Stable (LTS) at time of release.
> > +    The DPDK is likely to still work with older releases but it is not=
 guaranteed.
>=20
> It's just word semantics, but I mentioned before, I don't like the use
> of "guarantee" that is is implied for newer kernels.
>=20
> We can simply say that older kernels are not tested with and/or that
> DPDK is not maintained to keep compatibility with them etc.
>=20
> > +    Compatibility for recent distribution kernels will be kept, notabl=
y RHEL, and Ubuntu.
> > +    It may work on older distributions, that are no longer under stand=
ard period
> > +    but this is no longer but this is no longer tested or guaranteed t=
o work.
>=20
> "but this is no longer" is repeated
>=20
> Again, it is implying there are "guarantees" for newer kernels
>=20
> > +    The following are outside the current support window: RHEL 7, SLES=
 15.5, Ubuntu 20.04
> > +    and earlier.
> > +
> > +    Some drivers and hardware support may require more recent kernels,=
 check the
> > +    documentation (e.g. :doc:`../nics/index`)
> > =20
> >      The kernel version in use can be checked using the command::
> > =20
>=20
> With some minor tweaks,
> Acked-by: Kevin Traynor <ktraynor@redhat.com>
>=20
>=20

Keeping only the non-controversial parts, not mentioning any distro or vers=
ion:

*   Kernel version >=3D 5.4
   =20
    The Linux userspace API is compatible across releases
    but there are some restrictions.
    The oldest kernel tested by the DPDK testing infrastructure
    is the oldest maintained Long Term Stable (LTS) at time of release.
   =20
    Some drivers and hardware support may require more recent kernels,
    check the documentation.

Applied as minimal change.


