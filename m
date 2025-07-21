Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70254C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 09:01:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD2CA4021E;
	Mon, 21 Jul 2025 11:01:46 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 315C64014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 11:01:45 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ABA771400165;
 Mon, 21 Jul 2025 05:01:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Mon, 21 Jul 2025 05:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753088504;
 x=1753174904; bh=m6EgYNnwBDyVD1sAHVbqEFub+S4tkQlv4qbH+1GVfcE=; b=
 i7qcO9ysKPcTcHX3Vb7BbCbHn9OVitwEbmwnSdGcsbtjXT+G9/PcQUlutI5IBz8v
 kVtIrk8BN4Gpri1swiAk6ZVw95I/ZsTSuLVoZWIKBAO8c2aOQgIJPvf1cZw9nTAS
 EPX0FnSgLyltoIBqURqk+4tLklTojMQGcQa1BY0mKYeuDn9zjsx4jm7z8AnbZXnO
 hFbXzwcDmeDNvUWTZF9pVix9VRehslUUbb46+FG81/hBJuyqK2BkymZH5jEpjNaY
 RNy5RPK7rBeQipy7hL2NgRovQQqI3LXGJ4+gtWqxZobJo3pGBRXDhuZMERvJtu80
 gRhtT3kbLCakn7hOSWdUyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753088504; x=
 1753174904; bh=m6EgYNnwBDyVD1sAHVbqEFub+S4tkQlv4qbH+1GVfcE=; b=Y
 XILDncW/kIrtIizOs/t4YC/1F0PqYEsvl0VMJ9B0zww+Z4u+k5MBh/5ZLKq4fCVJ
 OocDkDk2W6PiTzH4Kuyz1p2oHh7ilDQOGaFqSdsbeqRHRoXKtojrYvjz7azMz9Mv
 yVNiiIKdLMWy5hTaDdtAhuN5gNVx/hudUxwyOiBM3pv5Ude1+DTf9kjnVu8h2Dsj
 OWsgHyhnpTK8PtQL3Fhm87DnRCezXi+o8XMyInXOSP8EGz1o2wywj4V9yiI4VU9T
 dxAtpOOD+HjjgzAWpr2nnk3B6FwuXHfJ1la0SApYDopF//1onAt1T3cLPEBIcaU3
 cmkeIdDKWZETh3dG4FA0g==
X-ME-Sender: <xms:-AF-aDGlzeni27SNLlSfIvOlLx2uIMpRFgsCjvX-Ji7JA2i1g3gWAw>
 <xme:-AF-aOSjXmx_k1HeCABsBYj93RpFJYtb8s3pYYKzLfJzCWSkLNel_QKiFlC6OsinJ
 ouL0r-K0B-Ml0gu2w>
X-ME-Received: <xmr:-AF-aHfhK_HXQFQU9JQnV4LctB-MMdj8a9nlG4Nkc5UhRxv8ZvzhaKnPqigZKcA1lXb9bgr_-Uihq3APXhakRXxNFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudeijecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrihhlihhngidrgihusehinhhtvghlrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgt
 vgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrjhgvsh
 hhrdhtrdhpuhhtthgrshifrghmhiesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhh
 nhdrmhgtnhgrmhgrrhgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmh
 grrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:-AF-aFpEt3BRgGfOd9XfIV5wDIgJjh5EK-VN9go87ZoQLBE9m5adqQ>
 <xmx:-AF-aA9mVpi1N03zfzphN6bxOI8_n3ft4HoLdj_iJwvV6Y6Kk3eN5w>
 <xmx:-AF-aJe9xPoEL5liM646IMWHle9wDUOVIAI_PTJBTSHDZFuWpu35TA>
 <xmx:-AF-aCKCftB0BKJQjtuEiXjQS_XRRiaVVmoVLeBVrIqIRcZXa3rEfw>
 <xmx:-AF-aMt3gWqOeLV03sOC_Z8_FO3Z15i1xi0YlW_wuxMGp-mGVLH3H-Lx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 05:01:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: hailinx <hailinx.xu@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v1] net/ixgbe: add nic and updated recommended matching
 list
Date: Mon, 21 Jul 2025 11:01:41 +0200
Message-ID: <4313678.1IzOArtZ34@thomas>
In-Reply-To: <CAJFAV8wW8r5tqBPKrGUrutv+s8x6uyS1L-oCxQ-vEfkawFaB1Q@mail.gmail.com>
References: <20250717061604.3288049-1-hailinx.xu@intel.com>
 <20250717061604.3288049-3-hailinx.xu@intel.com>
 <CAJFAV8wW8r5tqBPKrGUrutv+s8x6uyS1L-oCxQ-vEfkawFaB1Q@mail.gmail.com>
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

18/07/2025 14:13, David Marchand:
> On Thu, Jul 17, 2025 at 8:55=E2=80=AFAM hailinx <hailinx.xu@intel.com> wr=
ote:
> >
> > Signed-off-by: hailinx <hailinx.xu@intel.com>

Please make sure to have your name here as Hailin Xu.

> > ---
> >  doc/guides/nics/ixgbe.rst | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> > index a03ec7a7e8..6380e18feb 100644
> > --- a/doc/guides/nics/ixgbe.rst
> > +++ b/doc/guides/nics/ixgbe.rst
> > @@ -36,6 +36,8 @@ Supported Chipsets and NICs
> >  - Intel Ethernet Converged Network Adapter X540-T2
> >  - Intel Ethernet Converged Network Adapter X550-T1
> >  - Intel Ethernet Converged Network Adapter X550-T2
> > +- Intel Ethernet Network Adapter E610-XT2
> > +- Intel Ethernet Network Adapter E610-XT4
> >
> >  Vector PMD for IXGBE
> >  --------------------
> > @@ -93,6 +95,25 @@ Windows Prerequisites and Pre-conditions
> >  - Loading of private Dynamic Device Personalization (DDP) package
> >    is not supported on Windows.
> >
> > +Kernel driver and Firmware Matching List
> > +----------------------------------------
> > +
> > +It is highly recommended to upgrade the ixgbe kernel driver and firmwa=
re
> > +to avoid the compatibility issues with ixgbe PMD.
>=20
> We never recommended such things so far for ixgbe.
> I think this is a wrong thing to advertise.
> The same applies to other Intel nics, btw.
>=20
> You may insist that you validated with such a setup, but most users
> rely on in-tree drivers.

Hailin, would you reword to not recommend out-of-tree drivers?


