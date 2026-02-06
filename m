Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D70CEE20A6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 14:02:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE6914028C;
	Fri,  6 Feb 2026 15:02:01 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 881864028C
 for <dev@dpdk.org>; Fri,  6 Feb 2026 15:02:00 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 3180AEC0096;
 Fri,  6 Feb 2026 09:02:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 06 Feb 2026 09:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770386520;
 x=1770472920; bh=BtyuKFRToxYUtbNXbK4LsedC1gul5+xevv5t6SmKfI4=; b=
 clIkuTFb0xdHxu9HTWiCjHxvsSajjBWfLGU3kvGoEHFSuS/yZZW7uZBteHiQ6e9a
 czyDsVi2It3qP3lt+f6gIo+GrjFTMcotihY5wSfpB1pTdGJRvrlnEsJfpgd/EyYg
 jw8309f7h4M4KTuo6y9AnSZKldBn/fkV5yTEkSrld4FrCSpApUyvG4Rf8IAMkan0
 IhCf7dlj615HTmF4fmHGoAXF3TMaLJwD15sbIh71k7lO6SUf5d/8gpsO6CugukG4
 Ljc8I9X+ZDXWjCxgYPSMlNDTRUo0FHnaljmHChR4AaZ4TIoadZrXTvf9R5c5cbyT
 TdV5imhHIYeEb8jBBPtYew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770386520; x=
 1770472920; bh=BtyuKFRToxYUtbNXbK4LsedC1gul5+xevv5t6SmKfI4=; b=g
 yAl/COriTSrn6zlr/2wj2r3ScNWvhT+804ftQWXnjrf0QT3uCB9VGxXsj8fiB7CR
 lT1z7atD8hqsiGUgsSCLiy2se/y1PWUjPPETZV0qK4FIW9UjFzWnWG9eAty3Co7d
 1sQTMzsb2Asf3NUlVpKmvQMkVielcudc6kLwYqGtA1NCtG/+UrlKfnv9RlfrrGWv
 Xm5CyzUt1nECz0LZCE3328fl6iyowJGgDIWtzo3+Vmy9Ia0GBuD0BQ1uLpGHbMe/
 8nX6SDwhaiBTjbWMEfsmALmZgHlbBgy4oy4iC6hZztwjTkMpM1EKt4rHPmttJmqI
 YjwcdmtuJNtW1DA4U5ZjQ==
X-ME-Sender: <xms:WPSFafnbWwXDKOf9N2m1g8V4L5F5DM-USlvSN7KgZh8sOuocrV24Iw>
 <xme:WPSFaXJK4iQK8qkG2ACDv4oQaFgNXvWLPT8T_PGEk1N6iKc9Be6ibU5YuqsiQUOLb
 x8D_7dGHaLmaZ2wSRWh3llCcYUqktPClcwYEJYR0aRtqwejK_Fxwg>
X-ME-Received: <xmr:WPSFaUzR6FtzswC2q40vqjw1gaO2k7RHqz06os9cSE7w1X-2lWzrMD_QVW1OimFuTadd61W4fn6gavKel1pmhgnqYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeetieejvdegvdfhkeegjeevgffgleejleevvdduffelvdfgvdeugfef
 heejjeeikeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhho
 nhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepshhishhmihhsseguhihnrgdqnhhitgdrtghomhdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsg
 gvrhdrohhrgh
X-ME-Proxy: <xmx:WPSFaftcDdp4Y3O_Cgz4MMAtAumnHCsSxIkrBSuuLHtIhgsf3ZJprQ>
 <xmx:WPSFaTshHG8B0v-8nKcUY6fwTO1GUnBpURdpijQ4GSWK-9LkwG9f_w>
 <xmx:WPSFacOrA0psouJdf8B37xe-NydARBokCSeQnJleGPbWDzMZt_AIRw>
 <xmx:WPSFaZ3PBqzxUd-QJ5yDTV-dxSPfztHGcWxlCsuAAyTgNfxmNFOEXA>
 <xmx:WPSFaSaI9JEnfh1dnQFP5RI1VB87EPM9UsOJBgKBuktRd9Z_b_kjpsgo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 09:01:59 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v10 3/6] flow_parser: add shared parser library
Date: Fri, 06 Feb 2026 15:01:57 +0100
Message-ID: <2762564.TLkxdtWsSY@thomas>
In-Reply-To: <20260204065338.0fae67fe@phoenix.local>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
 <CAPQRu6Gb0tMH6f-5T7_vCVK23mAkEOmXn-T+X_DYaWsNZdYtjg@mail.gmail.com>
 <20260204065338.0fae67fe@phoenix.local>
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

04/02/2026 15:53, Stephen Hemminger:
> On Tue, 3 Feb 2026 09:34:26 +0100
> Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:
>=20
> > >
> > > The kernel version of checkpatch complains here. The DPDK shell script
> > > seems to be set to ignore this but.
> > >
> > > WARNING: break is not useful after a return
> > > #15008: FILE: lib/flow_parser/rte_flow_parser.c:14763:
> > > +               return cmd_flow_parsed(out);
> > > +               break;
> > >
> > > Should I create a new patch set or just let it be at this moment? =20
> > Lukas
>=20
>=20
> I am ok with it as is.

Better to update.

There are other warnings:

WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over strncpy -=
 see: https://github.com/KSPP/linux/issues/90
#13052: FILE: lib/flow_parser/rte_flow_parser.c:12825:
+       strncpy(buf, str, len);

and a lot of WARNING:LONG_LINE


And on a more general note, I would have expected to ask the opinion
of rte_flow maintainers, but they are not Cc'ed in these patches.

I'm a bit skeptical about adding this outside of ethdev library
which defines the flow API.


