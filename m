Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D38CEE341
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 17:09:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 733A04028D;
	Tue, 18 Nov 2025 18:09:09 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 0C0A74027D;
 Tue, 18 Nov 2025 18:09:08 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8B9061400030;
 Tue, 18 Nov 2025 12:09:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 18 Nov 2025 12:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763485747;
 x=1763572147; bh=My79XDc6t6YDxdC5H3tEUcrWRWfiR4aFbI0wptKdy6o=; b=
 Dgy4UqFuYLb+vUb6c4u95bhVl2Z7SvjIiv0B/2W1kttu26QGwUE/WmGFscEvvR5/
 Rys0Rq8rcKoJDJwJyBD7RGhtlz4+QVEu5XBO1qOqijszny3gEXfCnJFZBxCMzKNP
 rit/4IG1BO5U4MJXbtW5nISLuPuEvvaIBrBtBpAFNzW9/ZA4uEqAED1a00Tj2y9p
 HAeDJ1gB0B/ch5PZqRGfF2xJgiCsWX2Wdwt99UD0vjATk2LVTPzTErE+WL+7gwTY
 KVP7WnLxHC6vlEIRIs0oHEqA5OrIjKj22GwCIzJt5Lj7sv/lE9Zxm1ih72zj6/If
 m2jZcPHbauJpp4kjf9DqVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763485747; x=
 1763572147; bh=My79XDc6t6YDxdC5H3tEUcrWRWfiR4aFbI0wptKdy6o=; b=D
 3hZZv7PU8rzUhkZETAOL8FEQDNRp30OGTsWfO2+h2Pf2ny19ea5NvNaTP2VSlQGe
 vJ3n+SNut4pCgsWHG78uHO+IikOe2WBzSqQGCsFqcDxbgRWIseunAc1BmgUJw49m
 UOKL5+P3gfsoM/VMfAAmT40xmuhHefi7327QFRIR13apDv28AMcwAQ5lBRlLt7Rf
 tguYHKXtQ/b83bM0nPx8naGJIUQWCcQ2J5yOhTiBieIPIAe2ei0SmTObfKjzm69l
 kDp3jZcaBrk2I56lxRWAgo0Uz21oVDE/voOjsjm95SQOyqJejVI1A/Hxu/IShzgE
 kWU054sFYBqfJatx1j/qg==
X-ME-Sender: <xms:MqgcaYR9jo-W-E6KzUh_K0fV0WC-6yZfKLA5JcTpfUgGjO9D7am4xw>
 <xme:MqgcaVMth21m5HlyTQWY3gOyYraihFMGazcJ6PM-oLw4h9ZcfshzSKkJ1p9UyoHF_
 qPFiGCYHZw0m6cG0g9tV3dH53t2F2CZndY6vldiQZDj1_C-elj76Q>
X-ME-Received: <xmr:MqgcaW7j9Wuyh4STXyfBSdpMSKQ7oipv4yxc6peEvyRSEyeu67AwRKAM_U1bfZFFjpBXfGDVVDuaJoRpyaZufGCaOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddukeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduiedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnh
 ihvghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehsihhvrghprhgrshgrugdrthhu
 mhhmrghlrgesrghmugdrtghomhdprhgtphhtthhopehnihhthhhinhguudelkeeksehgmh
 grihhlrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphht
 thhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhrrghnkh
 humhgrrhhksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurggsihhlphhurhgr
 mhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeihrghniihhihhruhhnpgduieefse
 duieefrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgr
 thdrtghomh
X-ME-Proxy: <xmx:MqgcaQUdGSOLE7P4BYzRPA8SYk87ZmTQO89Qy7CPiR_H_WSESBQBHQ>
 <xmx:MqgcaVNJQ_n-QtfED5-80IGODVbr1IPQSw2lJC57qn72HqjJ7vEU_A>
 <xmx:MqgcafiZnH4IM4MXE0brKWsag-RViJbi6auTm8dgZNzHbPFtsUkbyw>
 <xmx:MqgcaT5pTbaGt2mmdROLDahHJwgDaThNUBJkCGxsTiOXlKSR6x9PYQ>
 <xmx:M6gcaajpSm0TimdASj92ip4hIv5nK9anyVMVvKnzrHj-2_pl9rK2ChIO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 12:09:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
Cc: Nithin Dabilpuram <nithind1988@gmail.com>, stable@dpdk.org,
 "jerinj@marvell.com" <jerinj@marvell.com>,
 "kirankumark@marvell.com" <kirankumark@marvell.com>,
 "ndabilpuram@marvell.com" <ndabilpuram@marvell.com>,
 "yanzhirun_163@163.com" <yanzhirun_163@163.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "ktraynor@redhat.com" <ktraynor@redhat.com>,
 "konstantin.v.ananyev@yandex.ru" <konstantin.v.ananyev@yandex.ru>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "aconole@redhat.com" <aconole@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] examples/l3fwd-graph: remove redundant Tx queue limit
Date: Tue, 18 Nov 2025 18:09:03 +0100
Message-ID: <4301041.aeNJFYEL58@thomas>
In-Reply-To: <CH3PR12MB8233CD444E9194EB5C45DD5186E3A@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <819a994c1ae6461795b6ee8356e2fc32@huawei.com>
 <CH3PR12MB8233CD444E9194EB5C45DD5186E3A@CH3PR12MB8233.namprd12.prod.outlook.com>
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

06/10/2025 10:58, Tummala, Sivaprasad:
> From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > > On Mon, Sep 1, 2025 at 11:39=E2=80=AFPM Sivaprasad Tummala
> > > <sivaprasad.tummala@amd.com> wrote:
> > > >
> > > > In `l3fwd-graph` application, Tx queues are configured per lcore
> > > > to enable a lockless design and achieve optimal performance.
> > > >
> > > > The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
> > > > introduced an artificial constraint on the number of Tx queues
> > > > and limited core-scaling performance.
> > > >
> > > > This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
> > > > redundant Tx queue check, allowing Tx queues to scale directly
> > > > with the no. of lcores.
> > > >
> > > > Fixes: 08bd1a174461 ("examples/l3fwd-graph: add graph-based l3fwd s=
keleton")
> > > > Cc: ndabilpuram@marvell.com
> > > > Cc: stable@dpdk.org
> > > >
> > > > Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> > > > ---
> > > >  examples/l3fwd-graph/main.c | 3 ---
> > > >  1 file changed, 3 deletions(-)
> > > >
> > > > diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/mai=
n.c
> > > > index 92cdaa1ebe..12908acbba 100644
> > > > --- a/examples/l3fwd-graph/main.c
> > > > +++ b/examples/l3fwd-graph/main.c
> > > > @@ -49,7 +49,6 @@
> > > >  #define RX_DESC_DEFAULT 1024
> > > >  #define TX_DESC_DEFAULT 1024
> > > >
> > > > -#define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
> > > >  #define MAX_RX_QUEUE_PER_PORT 128
> >
> > AFAIK, in the mainline we actually have:
> > #define MAX_TX_QUEUE_PER_PORT RTE_MAX_LCORE
> >
> In l3fwd-graph app, this change is not available and instead we have
> #define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
>=20
> > since:
> > commit 88256ed85338c572d73006e4c4530a52d3b477ff
> > Author: Harman Kalra <hkalra@marvell.com>
> > Date:   Tue Jan 12 23:54:46 2021 +0530
> >
> >     examples/l3fwd: remove limitation on Tx queue count
> >
> > What I am missing here?
> This patch marked here was fixing l3fwd app and not l3fwd-graph

Why not applying the same change to both examples?


