Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65337C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 09:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96E0842C24;
	Wed, 18 Jun 2025 11:47:17 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 867B940EE2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 11:47:16 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 0E7C413803AD;
 Wed, 18 Jun 2025 05:47:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 18 Jun 2025 05:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750240036;
 x=1750326436; bh=WTcVHqS4XBkZsobgEKgxINfqqpwjhwQjioU8nWfWsXY=; b=
 BS3BpAhLXvj+s2nMkYxpmVeeJ/Mt8CMpK8NBek+HasPl095A2vLYAxZHgQ86LhHc
 I457DIo6xJyciV7makIkXpjouJjr2/F9ylciPbM4P6wmwBRqfiDdPuKd6sgsqecd
 Q7LGD3ZBO92H/ILEi9B1/OAKxUjQhf+zsJOUb4eucyaoU7k/VoHnPcMAUMq/HVys
 lU+a0PFmVnBKokKl2Mzd9GnRoj9OVa4T6/4XVEF+CA9XRayWHKXhjtz0+SzZmtzB
 PvuCMW3Cm06r2XO3etmvSDqN1dvu9T+9Lk5/KYqtmeAqgKjxGiHgs9NG3PXzfJh5
 Fw4vjApKW1sHEUoBvwHt0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750240036; x=
 1750326436; bh=WTcVHqS4XBkZsobgEKgxINfqqpwjhwQjioU8nWfWsXY=; b=C
 X6Zi3PnDImi9CSFq9FXOsbuD+Oq2mUfNb3rsU5HOKBZzl08FJdPNyrXtpkhE8P0f
 FNOpHlzNYGX54w68jZxAKEz1FDG9yczgqeESkoZz1p82tAHDIrcYHdgEC8b8IUIT
 XzD3U91yj+tvwO6Rf+4B0JfFZ8wxEnbgSPTJax58lx+hgBBWAKg+meVLhxi1nFIF
 qp6esBB8aB7PA9yPuwmvFr1QRSnr6rhtzYMU6AdmvV6mwkO7d8y9ObXPeOT1KBK2
 695Ahq72qJS8RewnQyeIocMi5dY7rhKqvPU6z04ucgknzCIXOgS5YiEBTu2OT95X
 vmD/Qnoe48VM9KEa9sh1Q==
X-ME-Sender: <xms:I4tSaCR3xrmG-XDJGDa5Y0wSD09m5akwdVJz1n42-i5AzYAGDzHl3A>
 <xme:I4tSaHwusb0aCTaAIa8lpjTk9u9tMfqNvJtdaEy-V3Yr8RNzUstT3-aIrrMIdN5e7
 vIzPfqEOC_qQOQGEg>
X-ME-Received: <xmr:I4tSaP2K5E2iObqzXCXKkfKBvV2pZgq23xyBvOmoWE8RftGbVP_68L_Q8N5pLGLhrSOGD55w1JZgue6T8c-tHqPQHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpefftdeuhfehvdekleelveffvdelhfel
 hedvgedtvddvudeuieevtdfgjedvudegfeenucffohhmrghinhepughpughkrdhorhhgne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhm
 rghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepthguuhhsiiihnhhskhhisehmrghrvhgvlhhlrdgtohhm
 pdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtg
 hpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepsghruhgt
 vgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesug
 hpughkrdhorhhg
X-ME-Proxy: <xmx:I4tSaODnTUs4SjGShSu6rvT9fzJ1moxpxQjN3Z_HgRzNlHdfFg-_ew>
 <xmx:I4tSaLi-Qk3syEl52WBydTc49LoQ1Q28_yuA00IcUJCR4Fka_JF-aw>
 <xmx:I4tSaKogS7-B_O8DXtkfMralc4bB9he3Mfifp9tMlkaXnkluKnZBFw>
 <xmx:I4tSaOg1q-0FvcBW1Qg1Qr1qzM2wzis7E7uweGiwhEvZTnliIuqOsw>
 <xmx:JItSaEA7fhWx-6gjN4l9S6n-JVa6Qd7iVCO_eI6J-KfOe_SU4lX1y1rJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 05:47:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: jerinj@marvell.com, bruce.richardson@intel.com, dev@dpdk.org
Subject: Re: [PATCH v2 6/6] trace: add PMU
Date: Wed, 18 Jun 2025 11:47:13 +0200
Message-ID: <3793563.K4a6FZZPjd@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartserver.smartshare.dk>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250618065618.4045910-7-tduszynski@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartserver.smartshare.dk>
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

18/06/2025 09:16, Morten Br=C3=B8rup:
> > diff --git a/lib/meson.build b/lib/meson.build
> > index 1934cb4a29..87b567f01b 100644
> > --- a/lib/meson.build
> > +++ b/lib/meson.build
> > @@ -13,7 +13,7 @@ libraries =3D [
> >          'kvargs', # eal depends on kvargs
> >          'argparse',
> >          'telemetry', # basic info querying
> > -        'pmu',
> > +        'pmu', # trace depends on pmu
> >          'eal', # everything depends on eal
> >          'ptr_compress',
> >          'ring',
>=20
> @Tomasz,
>=20
> Please re-read my v1 review feedback [1]:
> The PMU library should depend on the EAL, not the other way around!

It should depend on the low-level EAL, yes.
But as of now, EAL is not split so it is better to avoid EAL dependency if =
possible.

> How else is the PMU library supposed to use EAL functions like rte_mem_pa=
ge_size()?
>=20
> @Jerin or @Bruce, do any of you have some suggestions for how to achieve =
the proper dependency chain here?

I propose we don't use rte_mem_page_size() in PMU lib for now,
so we keep not depending on EAL, to avoid mixing all in future.
Later we could fix it if we manage to have high level EAL as a separate lib=
rary.

> Worst case, we will have to move PMU into EAL. :-(
>=20
> [1]: https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35E9FCFA@sm=
artserver.smartshare.dk/T/#u
>=20
> Besides that, good stuff. :-)



