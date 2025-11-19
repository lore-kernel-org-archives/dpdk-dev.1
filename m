Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C7CF34AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 12:57:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEA9F40267;
	Wed, 19 Nov 2025 13:57:17 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id C331C40265;
 Wed, 19 Nov 2025 13:57:16 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3D0A51400146;
 Wed, 19 Nov 2025 07:57:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 07:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763557036;
 x=1763643436; bh=Pp8tIsBp1A6r/x7cEJE6d/2D4jsIqAnXW30D+yY8ovg=; b=
 iBm4F8PLZDTh0GqvnbGPfCWL634gSLkLJf/CqqFi/oUtum31fZBagL+3pAeDCt8W
 9IG492cXtI3jZ4vF2TGJd081VbOxEBgQ6vyQ2CWydsJCEebUeSu6JG3Ec3177l2v
 cKn+CDgTAJ44AQIgSrIRt23AyySuCXEn2MpZFDdUDdZ8iobnyRfV4Gug3fv14QoE
 MwZy1J2vohgKTJcN7cFVbLxD9nC57Yp1KbW6+/TSp0nbbYDHUm2L46jQKw7uTzTq
 3DzAKj9uOTXmInhzSprdvwPuz3luoIGWEcplls3Jg/zWwe5H44IcmrZ0WhaDlc2/
 0R0vCOJ+2GOAHfL0mD516g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763557036; x=
 1763643436; bh=Pp8tIsBp1A6r/x7cEJE6d/2D4jsIqAnXW30D+yY8ovg=; b=a
 G4EEe+TEMLRfb6O8Go4lOcv8kYHy+R/l4dWSrF7Suqk0ByFtXYKYB7LGkvScoyOE
 DbsAekoDfJt0HG0UTy7icftcbVUBPsXBDrenGZIfpwLWjeeMb950/mwt9D9yKAnO
 BAQvRvMIzJKE09HFn0kLNXtVXQwYk2ktMWoaAKJ3SSWExlYl7Sv4h+AzegQLyt0a
 T/zcXW6ZrYY2awiyXGDF2su9OU+WmbfqNNnLVhAuyTm4g45IBDNDG5FLD1vNC77w
 gPkpAwkFrAHC6p8EbN20rj2320Gb05L5XyaRU7Xjih1tTmZFzZOQWtWEGntYlPo8
 HLSVsSLsIeL9lMfzhEltQ==
X-ME-Sender: <xms:q74daVMyOQVQn7CfQ3usc5UrNRM5-N3xNXWrlJrmp0m4RG4C0SJqPQ>
 <xme:q74daXYjfBZ6QWpOH1mHWu9sJ5BJRvou9QqT0g9_u7BetWDst0QWDyDjrHvJWd24L
 LbRxnjol1krBNgGQEyqrIVuBYTo6J3QDBceEuj3fYPGLfBCvmW0>
X-ME-Received: <xmr:q74daVUiqrOOyEEi2vH4INmInJQe-FjGJsMSTHJH-yxyyfFsWRFqayCl9dhXccRYKeppvKb6hRpMVdFLV_5X1x3ZUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduiedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhivhgrphhrrghsrggurdhtuhhmmh
 grlhgrsegrmhgurdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhih
 vghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehnihhthhhinhguudelkeeksehgmh
 grihhlrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphht
 thhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhrrghnkh
 humhgrrhhksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurggsihhlphhurhgr
 mhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeihrghniihhihhruhhnpgduieefse
 duieefrdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgr
 thdrtghomh
X-ME-Proxy: <xmx:q74daWBvT-pcF5D3JnH9MK2NAy7ppkMQkJFIrFumCxhFilvAmjTHFQ>
 <xmx:q74daRIcRm_OucB72m-BquarfM2aJOe15YrtgxcVHgvgX6Kjuad_FA>
 <xmx:q74daUvvOzGGRqPhWutxMSeNYAwvquA-QethcUKVIuaNhdLaMj_tvg>
 <xmx:q74daZVPUY15p-nJIk4UK2OaqpIXf9asuYf99IaTiSqToZAA87JrDw>
 <xmx:rL4daXdTU1yEyG4UHG0DsX8mHqUOjfiQC8WUKvuXE-5FbI92hBDuWvKC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 07:57:13 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Nithin Dabilpuram <nithind1988@gmail.com>,
 "stable@dpdk.org" <stable@dpdk.org>,
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
Date: Wed, 19 Nov 2025 13:57:12 +0100
Message-ID: <3175023.Icojqenx9y@thomas>
In-Reply-To: <CH3PR12MB823340B751F8D8DFA890146686D7A@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <4301041.aeNJFYEL58@thomas>
 <CH3PR12MB823340B751F8D8DFA890146686D7A@CH3PR12MB8233.namprd12.prod.outlook.com>
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

19/11/2025 13:08, Tummala, Sivaprasad:
> From: Thomas Monjalon <thomas@monjalon.net>
> 06/10/2025 10:58, Tummala, Sivaprasad:
> > From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > > > On Mon, Sep 1, 2025 at 11:39=E2=80=AFPM Sivaprasad Tummala
> > > > <sivaprasad.tummala@amd.com> wrote:
> > > > >
> > > > > In `l3fwd-graph` application, Tx queues are configured per lcore
> > > > > to enable a lockless design and achieve optimal performance.
> > > > >
> > > > > The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
> > > > > introduced an artificial constraint on the number of Tx queues
> > > > > and limited core-scaling performance.
> > > > >
> > > > > This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
> > > > > redundant Tx queue check, allowing Tx queues to scale directly
> > > > > with the no. of lcores.
> > > > >
> > > > > Fixes: 08bd1a174461 ("examples/l3fwd-graph: add graph-based l3fwd=
 skeleton")
> > > > > Cc: ndabilpuram@marvell.com
> > > > > Cc: stable@dpdk.org
> > > > >
> > > > > Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> > > > > ---
> > > > >  examples/l3fwd-graph/main.c | 3 ---
> > > > >  1 file changed, 3 deletions(-)
> > > > >
> > > > > diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/m=
ain.c
> > > > > index 92cdaa1ebe..12908acbba 100644
> > > > > --- a/examples/l3fwd-graph/main.c
> > > > > +++ b/examples/l3fwd-graph/main.c
> > > > > @@ -49,7 +49,6 @@
> > > > >  #define RX_DESC_DEFAULT 1024
> > > > >  #define TX_DESC_DEFAULT 1024
> > > > >
> > > > > -#define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
> > > > >  #define MAX_RX_QUEUE_PER_PORT 128
> > >
> > > AFAIK, in the mainline we actually have:
> > > #define MAX_TX_QUEUE_PER_PORT RTE_MAX_LCORE
> > >
> > In l3fwd-graph app, this change is not available and instead we have
> >> #define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
> >>
> >> > since:
> >> > commit 88256ed85338c572d73006e4c4530a52d3b477ff
> >> > Author: Harman Kalra <hkalra@marvell.com>
> >> > Date:   Tue Jan 12 23:54:46 2021 +0530
> >> >
> >> >     examples/l3fwd: remove limitation on Tx queue count
> >> >
> >> > What I am missing here?
> >> This patch marked here was fixing l3fwd app and not l3fwd-graph
>=20
> > Why not applying the same change to both examples?
> Yes, that's what the patch is intended for to fix l3fwd-graph and tx queu=
es will scale with lcores and limited by RTE_MAX_LCORES.

But it is not done the same way.
Here you remove MAX_TX_QUEUE_PER_PORT.
Do you want to do the same in l3fwd?


