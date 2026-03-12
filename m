Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B275106ACE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 20:29:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95A4A402AC;
	Thu, 12 Mar 2026 21:29:20 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 1338940275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 21:29:19 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 88F99EC053B;
 Thu, 12 Mar 2026 16:29:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 12 Mar 2026 16:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773347358;
 x=1773433758; bh=hV8E43I3njv5+MWmtvVyWjCavw7gl7DZq2ta/a/OGwI=; b=
 S0pNnsRuHz5F8onSy71cvgoAXknoLORjSSN70RZHp+bhXpmUK9r2gYTxh/p/TeHj
 jYl2obL50dk0RG6JdzZkJUN8kQw7W/uik/6v9gtnHxcpGD1YMv5ytMPVeF43MJwj
 yFUoOOr2ecapdM57xTKRV+UPPzxGxqX+PzRyUobu5+gtQlSncgIUa8/bBjrOQPm+
 3zECrpDaSLU+PA2OmmFhXBe1gqfTfQA5HTa0YiKLGmsJ/Peixi4Oh53K2A66+6T7
 vqAd3W7RHbZZmvu4JJ8VKdrDD9Zs49wNUGiMnLgz5LABCkeMAXqVMzrJgmDUVII6
 nm0QBMamW5suTta74DJF5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773347358; x=
 1773433758; bh=hV8E43I3njv5+MWmtvVyWjCavw7gl7DZq2ta/a/OGwI=; b=E
 3NqIQr0spOlCFxJ7lnF6J4OdzQMzc4HDmuulMO14eqe2O8Q5Zt7bx6SWke31b0Wf
 rIGsUJMRW2YpX9ylDyJog2z9jCxKPxzyxPA+Pu47VEwQb8rfxkSs2zikN4eWZpW8
 iNTMrJDpdvmKCrnFfAaGYwWW/jtcupZO/ko+KVQLBh28uUtW4Ph43sP058a/Wuyb
 r6qo6zxpmXxJXFpSEDDDov94fRUDglFpGZawQn1dEBXE8vKM5XWdVvIUivKVxyFk
 bfG/1H/8nXZsrdrST+E4Wq/GdikzMXY/jQYwM4/nQkTFsynzyq4f1lTPTKvcHDpa
 bglm37fg2Ij2WzjKu8/Fg==
X-ME-Sender: <xms:HiKzadSxTNTCRFrws4Hzz2Tc3iAUFRGDNPkiybXmXVLo_EAW30lNSg>
 <xme:HiKzaXPlfSX3eHovkcIttd6g_FSdnBw3XGUGhUBuAOee9DgtQEvIdEXyheEMDkH9Y
 uzeRMPmQM2tOdWlB--khGjVK_EqoiWrmenA1v0-p4s8kFOQDgeopw>
X-ME-Received: <xmr:HiKzaTgAyxs1VtN68_DYdrYgV8fvT9SnuFMOoSk74pv6ESikhhxdbJ-AyIZdgCdXwdimXcm0tkX-owDsSHXkz7o-Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejjeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehprhhosggssehiohhlrdhunhhhrdgvug
 hupdhrtghpthhtoheprggsrghilhgvhiesihholhdruhhnhhdrvgguuhdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehluhgtrgdrvhhiiiiirghrrhhose
 grrhhmrdgtohhmpdhrtghpthhtohepughmrghrgiesihholhdruhhnhhdrvgguuhdprhgt
 phhtthhopehkrghirdhjihesihhnthgvlhdrtghomhdprhgtphhtthhopeguhhgrrhhmih
 hkjhgrhigvshhhrdhthhgrkhhkrghrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrvhhi
 ugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehgrghkhhhilh
 esmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:HiKzaclODXMqNNwC1bgsTpEiK5RJI1jxwm9bG4HGzooOIeGAIBYPEA>
 <xmx:HiKzaXhaZVRlYaYaV4YGaSptY7PSXk-5ayTEAP3ohRRR5GamnaBWXA>
 <xmx:HiKzaXFWhKV2pY3oiNQqQhEWEMBNDTkJciXGJYr00DTpt-k_hAFljQ>
 <xmx:HiKzaRssTGlPc8IXvBMs76LsLrJTRKzTWEN8S6waZ3oqfaSkC3Kd7w>
 <xmx:HiKzadbgnGCbp2-zcjF0i79bW6QCTd1tzjQkTooWJc5YIzvixVeKxYwh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 16:29:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Patrick Robb <probb@iol.unh.edu>
Cc: Andrew Bailey <abailey@iol.unh.edu>, dev@dpdk.org, luca.vizzarro@arm.com, 
 dmarx@iol.unh.edu, kai.ji@intel.com, dharmikjayesh.thakkar@arm.com,
 david.marchand@redhat.com, gakhil@marvell.com
Subject: Re: [PATCH v5 5/5] dts: add crypto test decorator
Date: Thu, 12 Mar 2026 21:29:15 +0100
Message-ID: <1850904.VLH7GnMWUR@thomas>
In-Reply-To: <CAJvnSUDXGacdubwUaWWK3zZNx6zXPmoJLQm5_AdT7=u-mEqiWQ@mail.gmail.com>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <8652174.T7Z3S40VBb@thomas>
 <CAJvnSUDXGacdubwUaWWK3zZNx6zXPmoJLQm5_AdT7=u-mEqiWQ@mail.gmail.com>
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

12/03/2026 20:54, Patrick Robb:
> On Thu, Mar 12, 2026 at 2:08=E2=80=AFPM Thomas Monjalon <thomas@monjalon.=
net> wrote:
> >
> > 06/03/2026 17:40, Andrew Bailey:
> > > Currently, a test case is decorated to signify whether to use Scapy or
> > > TREX. This change allows test suites that do not use a traffic genera=
tor
> > > to avoid the overhead of initializing either one.
> > [...]
> > >                      if (tt.test_type is TestCaseType.FUNCTIONAL and =
self.func)
> > >                      or (tt.test_type is TestCaseType.PERFORMANCE and=
 self.perf)
> > > +                    or (tt.test_type is TestCaseType.CRYPTO and self=
=2Ecrypto)
> >
> > That's a bit strange to read,
> > because a crypto test can be functional or performance.
> > I suppose we can re-discuss the classification of the tests.
> > If the only need here is about the traffic generator,
>=20
> In my opinion this is not quite true. There is another (and more
> important) need associated with the test categories, which is allowing
> users to run only a sub-category of tests according to their interest
> or hardware setup. I.e. we can expect some people to show up and
> desire only to run functional testcases (perhaps they have a minimal
> hardware setup which is not good for performance, or they are only
> working on resolving functional issues) and the test type categories
> allow the users this flexibility with regards to what kinds of DTS
> tests are run.
>=20
> > we could make it "raw input" or something like that?
> >
> >
>=20
> In any case I agree with Thomas and Andrew that the situation with
> regards to test type classification/organization could use a review
> and a tweak in the 26.07 release. Right now every single crypto_test
> is a performance test (i.e. it runs a crypto workload, compares the
> Gbps output against the Gbps baseline the user set in
> tests_config.yaml for each testcast). But, some open questions for the
> future:
>=20
> 1. Is there a need for users to select only functional crypto cases vs
> only perf crypto cases? Or we can just leave all crypto cases in 1
> bucket?
> 2. If the above is true, should we switch the testcase decorators over to:
>=20
>     a. ethdev_func
>     b. ethdev_perf
>     c. cryptodev_func
>     d. cryptodev_perf
>=20
> and every testcase gets one of these decorators
>=20
> OR
>=20
> We apply multiple decorators to each testcase (i.e. add both
> crypto_test and func_test to a testcase) and have the framework code
> read the whole set of testcase type decorators and setup accordingly.
>=20
> Thomas, is what we have right now in terms of testcase classification
> okay for the 26.03 release, and we can tweak it in 26.07, or do you
> want us to do something in the immediate term?

There is no urgency.
I'm just opening the discussion for future.


