Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CF1C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 20:22:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBCD34025D;
	Sun, 29 Jun 2025 22:22:43 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id B01EF40151
 for <dev@dpdk.org>; Sun, 29 Jun 2025 22:22:42 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D43CF7A0034;
 Sun, 29 Jun 2025 16:22:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 29 Jun 2025 16:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751228561;
 x=1751314961; bh=P95PU9d4FWuTqWoZXozFFjwL10PBNszgVRAL7axxH7A=; b=
 Y/Teh/hi7u2xfbR41x2AfUhAmbPthUYwAFsG0NdlZHoiDE2nVmU5k9DKJVzMKAEF
 apA26LR/WHYpDShoX6mS9ws1a9ngc9zeuYi9eDwfEN2kUw4GJJZ7dM95NsCVYwWt
 UHYyhCMPj4YNt0IPcVBHRBZ91YARpV7RVOrKzvFUUyKCNgjfWPwLfjrSGMAwTJCm
 awTQK+o6kxdr8ufikuN+n/z7TNnBJiPW6JqYgmFash7sL/ryr2gzjqRlTGic+ZWl
 agJkp3kfIZSdfCnQBnON772nUcQodGE4w8oLx/wshNGt8tdBLWW55D/KMz4//Shx
 PMtOQtuu/rIieyXph5yoDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751228561; x=
 1751314961; bh=P95PU9d4FWuTqWoZXozFFjwL10PBNszgVRAL7axxH7A=; b=P
 AL66Bw0Wf66c+ArKHME6GqvOzFKK5WJQB0nwd3Tp9hNrIYyw3/36fGHvMyB4CFOq
 xgl5gpuYSdqYqfwReh4pxuqMh53jyJWooCLqBdvkVLbyFF7+4pna19pDTLVwZaW8
 x/a2HG7KSShf34RS5Zb3UZkTxyb2k4f8OZwvPgHD5QkqumQFYuATY4LGHmjVH/gy
 qPqJg6YT5UCrhRdIj3cLRBwymKxJJLJjzg3O7NsWX8UrmHQTaE+BB6W73OOljmXQ
 sgCaQL1xMjARgKPf2S4dyNpfWBbbVTppoQNh2Z5+QJWbXrGxnhzE0HvDBR2o1ooh
 QG+rmZdUzs192EV1XXPfw==
X-ME-Sender: <xms:kaBhaBWxivCbUmFUSxyJp5wG_9aZkXn70DVVQ0cgtxvUmXYuuuprgg>
 <xme:kaBhaBlgeMNkXsC25QM4txQ1RsKHthnEOWOb14KkUBGjbK9_bo8gCcHzteYx1AQOO
 LKTiRQwFMKk7RR9cg>
X-ME-Received: <xmr:kaBhaNa4A53SoJV79IRPqQktpxwNKeebRYmD-_tn9rYHzbbhkWNnCgJ2lTLkmZaOu1Th2ZUMQdwUI2SXCvn7bPAcWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddvleev
 jeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehpsghhrghgrghvrghtuhhlrgesmhgrrhhvvg
 hllhdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepjhgvrh
 hinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprghmihhtphhrrghkrghshhhs
 sehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjrggtohgskhesghhmrg
 hilhdrtghomh
X-ME-Proxy: <xmx:kaBhaEVj0XDzfJjR7NmPoy2g4qXYxMXC2it3uKFIWXmFVTsYK2iBfA>
 <xmx:kaBhaLkGN76DRqwhs6MtA0qsNcA3Dwf8M0GlFxdjUncqF_0cSFCr7w>
 <xmx:kaBhaBev6o54Ren2CqlY59Mo3jz36j3y2wOyqL--JcxwfCUjaJY3UQ>
 <xmx:kaBhaFHIDIFfa0JFIIfgVHGjP4Mxsabuxakjmtg8p3lN_e5gc9XxbQ>
 <xmx:kaBhaPwSLtnGOD7uATTTSw33n-JK9QKLlTTnFOCOUQW8uxBUm7365Od2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 16:22:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: pbhagavatula@marvell.com
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 jerinj@marvell.com, Amit Prakash Shukla <amitprakashs@marvell.com>,
 Jerin Jacob <jerinjacobk@gmail.com>
Subject: Re: [PATCH] doc: fix missing feature matrix for event device
Date: Sun, 29 Jun 2025 22:22:39 +0200
Message-ID: <5264375.2vfOZ694Ok@thomas>
In-Reply-To: <CALBAE1O3gUvoxBcQRjYWqc-d28h_QpGNr8UVsnRhV-pzakr0XQ@mail.gmail.com>
References: <20250613231519.32933-1-pbhagavatula@marvell.com>
 <CALBAE1O3gUvoxBcQRjYWqc-d28h_QpGNr8UVsnRhV-pzakr0XQ@mail.gmail.com>
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

16/06/2025 17:05, Jerin Jacob:
> On Mon, Jun 16, 2025 at 2:02=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
> >
> > From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >
> > Fix missing feature matrix addition for event device DMA and
> > vector adapters.
> >
> > Fixes: 66a30a29387a ("eventdev/dma: introduce DMA adapter")
> > Fixes: e12c3754da7a ("eventdev/vector: introduce event vector adapter")
> >
> > Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
>=20
> Acked-by: Jerin Jacob <jerinj@marvell.com>
> Tested-by: Jerin Jacob <jerinj@marvell.com>

Applied, thanks.



