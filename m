Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE7DCF34C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 14:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2CA940267;
	Wed, 19 Nov 2025 15:55:18 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 9E6B640262;
 Wed, 19 Nov 2025 15:55:17 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 2DA3AEC01E1;
 Wed, 19 Nov 2025 09:55:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 09:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763564117;
 x=1763650517; bh=hGrnWY8EPyAiN4HtW7yyfpOeHOZAQVfqVkuc1KqrETQ=; b=
 NQDL7rkDQj8YMy/qW1DAjwE305VnNZOGdAxbeCUj7jfSr50jgTKjEl0iOg/WQDJB
 Sh0ZegF5dQJ2nP/Qe0Gy6mJiv/tKkId9USKE0tpc/U8sRQFkfHDLi3x25TJWyZBy
 KC9p4F+GqtYBljXHizRGg/BAEWWXqKsiN46YvFGJR0Rrk7lUGkGaFXENGN0D9V4I
 s/4O7DxS4b3G27hqEJM2vrzPGNbuR0Bb7JVCau1cax4ByRgu6Pyj6ndAI8iIi84k
 BDFRy8h9mO/fbm3Fy8+5c0hN1Pyf/k+te5eysTKuTlerooKotji8SA3dYwZ/qH37
 tD+2pIGbryuIY2h+URJHng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763564117; x=
 1763650517; bh=hGrnWY8EPyAiN4HtW7yyfpOeHOZAQVfqVkuc1KqrETQ=; b=T
 khl3KGyUISngHNdXL75SVEMSn/+CBhy0OUfUJbcgCXjhRx8NOnCp3KRr4rxkYI4u
 Mp5MEHUqPNj6aTFa78Hlk6vlhCcZU+MAqMr5wE735obzmiANcvIFwXZDE38NHPBF
 R1oiTKYLTlDUAN4zNagOwaTAEVeGHU++9rkc1tEB6rln36jYi5aQtPEcrOL0WNmW
 aKvC237HRMqIvL4/7KGyRI86PC2huvpF9r0DlSjU4xPMQssxNK72M0Rix/37qsHl
 MUdm1V/NcN64WPHZsYctApw5MZl9T55maI3vjJvZIjGj5jQG68VMWWShwDq7C/Up
 sJHIHnS7M1h81YFMn9UWw==
X-ME-Sender: <xms:VNodaetlXQUiA-ivrgDMXHZw3xyo-eqAVqjQEKccTrKddeUnliJfBg>
 <xme:VNodaS6rYAxQfiK3gWehWrb3Bfq08aLVrJa-DcYmJNCTnNr-97jQPjWQFp0sdnqG_
 LXqxfwXNOLIW6kCtpBeeGlyTCiVo6EB5IgPGVNowj25qrQLkWQb>
X-ME-Received: <xmr:VNodaa07h2XsWluobyYLsj5hiQ8Rd7V3oxLS8lpHiZaJJglxHy2N2fYFruagk6tnntgFfBe2F2NkgLzyTNBom9-ZHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeggeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VNodadhJWPcQC8Q35CMMEpT0Bq3npN18XsaQ74LGJsW9MaNq5wrVbg>
 <xmx:VNodaSrx8mYj6Sdd7StDqh8f2_wVngMJhIww7V4XRFEGK2ERFF7SfA>
 <xmx:VNodaYM6Zi-7JS3MMrYxLbwMuiqSZAFliSAZpPWzUKDdnZcd9ZJdjg>
 <xmx:VNodaW2mh6y8OqJRdidWFFStfKDuHS1Jn3jhgp5KmGeYtZ0nj2RPdw>
 <xmx:VdodaeXMBgX2-GdnzF4Tgw4Qmr1Mmx5vJBkaYufH2E_AveeVdkYx20Nl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 09:55:14 -0500 (EST)
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
Date: Wed, 19 Nov 2025 15:55:12 +0100
Message-ID: <882704772.0ifERbkFSE@thomas>
In-Reply-To: <CH3PR12MB82334C3FDADDAA01A13107D386D7A@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <3175023.Icojqenx9y@thomas>
 <CH3PR12MB82334C3FDADDAA01A13107D386D7A@CH3PR12MB8233.namprd12.prod.outlook.com>
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

19/11/2025 14:56, Tummala, Sivaprasad:
> From: Thomas Monjalon <thomas@monjalon.net>
> 19/11/2025 13:08, Tummala, Sivaprasad:
> > From: Thomas Monjalon <thomas@monjalon.net>
> > 06/10/2025 10:58, Tummala, Sivaprasad:
> > > From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > > > > On Mon, Sep 1, 2025 at 11:39=E2=80=AFPM Sivaprasad Tummala
> > > > > <sivaprasad.tummala@amd.com> wrote:
> > > > > > --- a/examples/l3fwd-graph/main.c
> > > > > > +++ b/examples/l3fwd-graph/main.c
> > > > > > @@ -49,7 +49,6 @@
> > > > > >  #define RX_DESC_DEFAULT 1024
> > > > > >  #define TX_DESC_DEFAULT 1024
> > > > > >
> > > > > > -#define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
> > > > > >  #define MAX_RX_QUEUE_PER_PORT 128
> > > >
> > > > AFAIK, in the mainline we actually have:
> > > > #define MAX_TX_QUEUE_PER_PORT RTE_MAX_LCORE
> > > >
> > > In l3fwd-graph app, this change is not available and instead we have
> > >> #define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
> > >>
> > >> > since:
> > >> > commit 88256ed85338c572d73006e4c4530a52d3b477ff
> > >> > Author: Harman Kalra <hkalra@marvell.com>
> > >> > Date:   Tue Jan 12 23:54:46 2021 +0530
> > >> >
> > >> >     examples/l3fwd: remove limitation on Tx queue count
> > >> >
> > >> > What I am missing here?
> >> >> This patch marked here was fixing l3fwd app and not l3fwd-graph
> >>
> >> > Why not applying the same change to both examples?
> >> Yes, that's what the patch is intended for to fix l3fwd-graph and tx q=
ueues will scale with lcores and limited by RTE_MAX_LCORES.
>=20
> >But it is not done the same way.
> > Here you remove MAX_TX_QUEUE_PER_PORT.
> > Do you want to do the same in l3fwd?
> Yes, it's better to fix the same in l3fwd as "MAX_TX_QUEUE_PER_PORT" is r=
edundant.
> I can submit a separate patch for l3fwd.

Better to fix in a single patch.
Please check if there are similar issue in other examples.



