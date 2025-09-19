Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFDCCAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 19:08:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE73840647;
	Fri, 19 Sep 2025 21:08:56 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 2D67E4042F
 for <dev@dpdk.org>; Fri, 19 Sep 2025 21:08:55 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A33211400153;
 Fri, 19 Sep 2025 15:08:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 19 Sep 2025 15:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758308934;
 x=1758395334; bh=GEqVqqsHdCCmjzrmrCPX3C5o6z5XP+SDL9PBnKSQqV4=; b=
 fKDndsy425KzyPvmotSOKyI9knkTjuf+CjZiMEGCBErBDyFRNDqRt2kQFRbwh7vk
 ZXxI9PfimnL1KkPljpsHlmz53YM4ZbKG2toXhP5q55g/8j4tmyAgCfaGLmElKBT8
 E9TeGqZbZHSE2v8McRaNWOdhxMV1vkdp3KXLYVtaIUEJloRcfVrgejowzSokFeah
 KT2pz1yBkqTgAfXhwTLxR6yUg9Zf+HJJsW6gvVlgkieXuY6HYhOkDRXPeUjHPbCl
 rjHGi/pBDXpRE5k1ph9vCNtto8O6xmQThz4swPnq/0oGZ3z2TYfVyzHZ0eO8Mpnk
 CSVLbWIsWN5zQAZQ1pWp7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758308934; x=
 1758395334; bh=GEqVqqsHdCCmjzrmrCPX3C5o6z5XP+SDL9PBnKSQqV4=; b=U
 SkfeHuWeiYzKKVhcBg5yP/GDpeIPFNS0qOY0oZ+r2A6s1qInm1Q9KvmrLVuvrqHt
 LAP/VOsIfOeRCp9aJZJWmF30UvN3VGw01beUcigcQtSNBo1bNe1oRN2K7ifMdSeC
 WbghUX4STVrD9JVfvsNiZiYf7xw4XbrUaE671g+YK6KvXGOTuivQYu6DQ1rIOG5w
 KrCdHsOwKYuT1WavUL4RZlnoqjMRx3uTtdlqG/WmtXAD6/27TOXgPS1FEwwgcWIZ
 H6WmVaKYLKc0CXkRDsLghVGH2Su6Of1/LgLt5KbkpDY3XPmhNzxTfAyQfIV5WLmQ
 5jRH3V9Id71Naz8DXUKgA==
X-ME-Sender: <xms:RqrNaF57Ivi885rTA5WF2KrLlgOZhsKz8XsLPqsjRqp-lTrGtJ1dtg>
 <xme:RqrNaOaNP4PPDyDCnqZsR-E-NqSwVCyNyydOwfzY0_dTdWGfYHmpiR2aMV5TP1tWZ
 whiLAHr7fRkhUn1Mw>
X-ME-Received: <xmr:RqrNaC45NcXmXsXiLIzJ_prRMTboNlykId-Ulnmh2sn418HN6rLbTmtzNwFIa0vn8S9MxBF3bAiCNqzvqpeFGoKRYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhihuhgvtghhihesihhstggrshdrrg
 gtrdgtnhdprhgtphhtthhopehukhejsgesfhhogihmrghilhdrtghomhdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhkrghrug
 grtghhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughs
 ohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:RqrNaJBphpgvj44MTfER5uy2gUQG9Efgtlvw6L7e0qRLxx-NjCQtEw>
 <xmx:RqrNaAeszuiUA114AsBgsCM4ljlNfO1eg2myv6yysJPW2ZriIbL5wA>
 <xmx:RqrNaALROs0KxykdIowAh2OLhJDsJ5HcVSJizopfgSXtkzGROiUBXw>
 <xmx:RqrNaD0LHJufbF52IyVgdIQJjg57kYpJkj3Wf5xujMGx2Bg_EWJ4Tw>
 <xmx:RqrNaMV3ciuNw66dhcsXVredYdxxzq_-P-T6m1k3Jwsbr_pU-Ln-eDKw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 15:08:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: =?UTF-8?B?5a2Z6LaK5rGg?= <sunyuechi@iscas.ac.cn>, uk7b@foxmail.com
Cc: dev@dpdk.org, Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 1/4] config/riscv: detect V extension
Date: Fri, 19 Sep 2025 21:08:52 +0200
Message-ID: <2941954.PIDvDuAF1L@thomas>
In-Reply-To: <39a1099c.30100.1996351c0d1.Coremail.sunyuechi@iscas.ac.cn>
References: <20250919163358.2887335-1-uk7b@foxmail.com>
 <3159839.72vocr9iq0@thomas>
 <39a1099c.30100.1996351c0d1.Coremail.sunyuechi@iscas.ac.cn>
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

19/09/2025 20:52, =E5=AD=99=E8=B6=8A=E6=B1=A0:
> &gt; Please could you add a cross file in config/riscv/ for rv64gcv
> &gt; and use it in devtools/test-meson-builds.sh so we can test compiling
> &gt; with the vector extension?
>=20
> Sure, I plan to submit this next week.
>=20
> &gt; Another question about RISC-V maintenance in general,
> &gt; what do you think about other pending patches for RISC-V?
>=20
> I would like to prioritize merging the hwprobe detection. The related wor=
k is already mostly done here:
>=20
> [PATCH v3 0/9] riscv: implement accelerated crc using zbc
>=20
> The next step is to contact the author for a rebase and then review it. A=
fter that, the following patch will be handled:
>=20
> [PATCH 0/2] eal/riscv: implement prefetch using zicbop
>=20
> In addition, our team has several riscv v extension optimization patches =
that we are refining and will submit soon.
>=20
> I would prefer to be added as a maintainer, as this might make communicat=
ion with other authors more efficient.

You are welcome to become a maintainer of the whole arch RISC-V.

Please send a patch to add yourself.


PS: please could you find a way to have your mails formatted differently?
The quoted reply has "&gt;" instead of ">".
Also the threading of your patches looks broken.

Don't hesitate to join on Slack if you need advices.

Thanks


