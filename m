Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE3C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 14:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1FCA402F1;
	Fri, 16 May 2025 16:44:43 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id C2D7A402CD
 for <dev@dpdk.org>; Fri, 16 May 2025 16:44:41 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 14E7413801CC;
 Fri, 16 May 2025 10:44:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Fri, 16 May 2025 10:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1747406681;
 x=1747493081; bh=XvN355Y7gzdIcmZuXqowdpi6kvdoif/q8FRAwaF05sg=; b=
 CmV3dF5x/1BTieZKhL31DKL0g9NJnCnPUad/MFIJ0Qzxl2sK1x8XQ5qTV5nb7Pwu
 eQLsEqyezRIF7z1jXz1P4sAC5uJqOiQL3UrBfjeZVHeZU018T2u1P3X15R4Cj1ik
 tWvllZSageomiWt+zzOd8BYJwwdKd+bPHiXMtKsvr6wkRd4oRQjf3Tx7bVRA6Kdk
 qPB1wG9fKf6iXn1juMP1bxJHnRau0+S6QS6g/esRJk+Ey+L2fcE1gNcUqf5TwH35
 gth65zEe5OKjlQy94QFUYYygfIT/DD9kIU3KE1tu2dw+vDr9OX997gOR6YZ98AOO
 NNfVhXzzFcIsqP8zOSj4zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747406681; x=
 1747493081; bh=XvN355Y7gzdIcmZuXqowdpi6kvdoif/q8FRAwaF05sg=; b=O
 QH35eB8f1EC93fJmzbDT+8f72RSKhKI3NIXzUfop/DE7a4vatJlsLQqyfqOGdNdy
 tC1NNXJkJS1Nqm3oWvdAqTtj9O1A+gIjBuab/pwzzyVUmoEek4ymo7DVD3GupC6U
 2ioeUV0hj0Y7OwC/UxUf5Kwi/3ec1oA6T3nnQuPtgt34mTAy4dApVdOjewsbdRwd
 0aMAoo40Fn36yPeZFejABbBa+Gv+fZOXk4aP6TxdM8vqW04fvz/KKcNAoz6jXuMK
 v602Cc/KkK8+EoZqUR+kn6LPt5f7pXVN3VHdWFm2bYHb4j7Zmkgl3wQN5aptVp5k
 G3JpKfHyaUDBfWt+yPhog==
X-ME-Sender: <xms:WE8naMKosBAe3eYVFoivfrbzZWEWKCIr9D2Yu-ia_OQRsQYPR9JsRQ>
 <xme:WE8naMJCpOmRjwLxxPVVL1Zbd3jzNn_gO_CxL10OafP7-cd5toTrV4dQiaZfkvYAV
 Ccto6z-98oUK4RnZQ>
X-ME-Received: <xmr:WE8naMsQI8005OLN0p-ChfKe0C7E8TzZfWlE4GF3YXtBrxM0ILkNTPH7Q_lQJLFPJlZ9Hgt8XRDdOVZb9lsTZCiv-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeftddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdej
 vedtheevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughr
 vghmuhgvsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepuggvvh
 esughpughkrdhorhhgpdhrtghpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:WE8naJb0C6Oa-Jx2d6vgKTKq6fa8wCIh-FvnCzeUG6lQRpZWJcLclg>
 <xmx:WE8naDasYfSZscHaau-5ByNfObylN6-Ej8kv17nAxeiU4akIB3L-TA>
 <xmx:WE8naFBz_eS6Q42cLlQJ5DyqicTEX0grD-OrEcQRKqKeeHUGWhmAhg>
 <xmx:WE8naJaK4VUF6ML5myfV_Wa-PKlgaoRo3lBqnKCOdefDsrm7wZGcvA>
 <xmx:WU8naMiACmo4I73fu40NHAGsjiv5-GBp6ZlDYIqEKfZHyWZk7jGX9yo0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 10:44:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>,
 Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Ori Kam <orika@nvidia.com>
Subject: Re: [PATCH] regexdev: enable to be compiled on Windows
Date: Fri, 16 May 2025 16:44:38 +0200
Message-ID: <8651425.NyiUUSuA9g@thomas>
In-Reply-To: <20250516125035.GA29027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746827534-19881-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8y8vibAGFsAR1XPFedR0-q+KC+Rm1=2cNPyJ5vF3ATKfQ@mail.gmail.com>
 <20250516125035.GA29027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

16/05/2025 14:50, Andre Muezerie:
> On Fri, May 16, 2025 at 10:01:42AM +0200, David Marchand wrote:
> > On Fri, May 9, 2025 at 11:52=E2=80=AFPM Andre Muezerie
> > <andremue@linux.microsoft.com> wrote:
> > >
> > > Now that mbuf is compiling on Windows, this library can be enabled as
> > > well.
> > >
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> >=20
> > The test-regex app can probably be compiled too.
> > Yet.. why do you want to enable this library on Windows?
> >=20
> > Support for this device class is defacto deprecated, as no vendor is
> > providing recent hardware implementing this feature.
> >=20
> > Also note that it was not built with clang on Windows so far (I did
> > not double check this assertion, I just based on the fact this patch
> > removes a is_windows, and not a is_ms_compiler).
> >=20
> >=20
>=20
> I was not aware this code was deprecated. You're right that it was not
> being compiled with Clang. This was just part of the effort to increase
> code compatibility on Windows.
>=20
> I see no harm in enabling it, but at the same time, there's no clear
> benefit either. I'll let you decide what to do with this.

The benefit is to remove special handling for Windows,
so I vote for enabling it.
There was no regex development recently but we never know
how it could be used in future :)


