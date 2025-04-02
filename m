Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4873C36014
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 08:00:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEE80402B5;
	Wed,  2 Apr 2025 10:00:28 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id E484D4029A
 for <dev@dpdk.org>; Wed,  2 Apr 2025 10:00:27 +0200 (CEST)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal
 [10.202.2.53])
 by mailfout.stl.internal (Postfix) with ESMTP id 184551140181;
 Wed,  2 Apr 2025 04:00:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-13.internal (MEProxy); Wed, 02 Apr 2025 04:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743580826;
 x=1743667226; bh=KVf6s7/0LopIpTDHOXZBUFedhWjdmQeCJ+62vCM3+xw=; b=
 h5k5n2h9Sp6mSXhSWUS6GCijU2QfSMWFzq37FGbVz/g43Yt5XZwSLapbuoSF3Mli
 whfqSZMJYj6T4Po7HLvkhFSqGAgxWxKJPOSXNiIYCbI2qTKzfUpuOElE44C+arie
 tvlaFsAALqhAqDJmC8uMSseEktyUpIHirBl7LdFoHxYNvLHihB5if7+zP+O1ysdn
 +Tt+0VOqLY42EKUfjWFEraSKitVAV4mboSALhuOTv8Cwl2JcmWam7bvyScZun6je
 Vxy5RP/kPKmbrwxd9lsZFOLnLZ6nt5OQSZmx5e09+mprt72xoD93pmaQ6uyulMMP
 3/KGsTyB+zSWD6jUs1iImQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743580826; x=
 1743667226; bh=KVf6s7/0LopIpTDHOXZBUFedhWjdmQeCJ+62vCM3+xw=; b=S
 MbKPsl2MIywcCajtSWNewLxNf7zTh/sgWR4VJkR+GbgjVJw9TPdXLclZ6KvjzU/C
 wZSQ1B6MSVQaGFheAbEUyCB0FkmBiKJU3XjZmKrj/Mr9flcoCjiLoDgJcNvJTumt
 2wlandnwd2bJY5D/jlZcH77F95F2hyhdV7brE/Qp+W2AcOjv97kklahzPVXP+Icb
 r3MZ2YUkXG24ErxdBzEFqlVlxxxLqYBPLncoVCrziJnVo8BlvWJqAmHZ3QXDbfQU
 T+cxWKhm+VOOAZp+7RSHk76yfFYjsrOTTV68i/6QDRMA76D3Ji43YrzwATGUTRHw
 gwib23hYWkzWwK7vXoG+w==
X-ME-Sender: <xms:mu7sZy-5wmWqgA-m9nM6OF2v-IO149NkgSxx-PkoOnLskuMDs1lJNA>
 <xme:mu7sZysvkwd_KARl1oRR1pyqReVNoxg2VuKbBGtTh_-UlU-JWQzgq3Vl5vexVjx8Q
 aAt05FUcpSueRVLiA>
X-ME-Received: <xmr:mu7sZ4APEDMnnPZWxb3Mzh_3iRojcT7T0AtBuBJZRelHZRJSIOco3DRioICceAl3lJWoOD1BGoyIcmlsRHRye2Fftw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehudefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdej
 vedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmihgtrhho
 shhofhhtrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrh
 hoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:mu7sZ6cFp7oypRui-s55OzR14G056MaN6llircVEbVuz555SRm8q-A>
 <xmx:mu7sZ3M2acyXKje2CCfG2tK54_k-x3YAWStxAo3-JTAFFec_BpzqYA>
 <xmx:mu7sZ0kdovx1G7_AILBRBH9eOwDO45aV6ALE24i43p47kqijpCY5MA>
 <xmx:mu7sZ5ufP_flLj5-JRUlmM5rcapJ411Dkv02zv_vFjdDQgTdlqKPUQ>
 <xmx:mu7sZ1w6VqoTBMzO7KublMwy039EFNZP3Fq0h33EqtL449snpOyOS5eG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 04:00:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v6 4/8] build: generate symbol maps
Date: Wed, 02 Apr 2025 10:00:23 +0200
Message-ID: <4318907.8hzESeGDPO@thomas>
In-Reply-To: <CAJFAV8zJSs6MyE-V=EokwxhKw=2_f+7ohphLP8eP-3WKsW9AUA@mail.gmail.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <4725377.72vocr9iq0@thomas>
 <CAJFAV8zJSs6MyE-V=EokwxhKw=2_f+7ohphLP8eP-3WKsW9AUA@mail.gmail.com>
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

02/04/2025 09:00, David Marchand:
> On Tue, Apr 1, 2025 at 10:25=E2=80=AFPM Thomas Monjalon <thomas@monjalon.=
net> wrote:
> >
> > 28/03/2025 11:52, David Marchand:
> > > Rather than maintain a file in parallel of the code, symbols to be
> > > exported can be marked with a token RTE_EXPORT_*SYMBOL.
> > >
> > > From those marks, the build framework generates map files only for
> > > symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
> > > becomes unnecessary).
> > >
> > > The build framework directly creates a map file in the format that the
> > > linker expects (rather than converting from GNU linker to MSVC linker=
).
> >
> > At this point of the series, the build is broken.
> > I suppose it is a tradeoff to avoid squashing 2 big patches together.
> >
> > This is the error I hit:
> > drivers/meson.build:275:37: ERROR: Unknown variable "sources_avx2".
>=20
> Hum, I'll have to reproduce.
> I had tested patch per patch in previous revisions, but I have a doubt
> after the rebase on top of Bruce series..

Yes my bad, it works after pulling Bruce's rework.


