Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2FF106ACDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 18:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D74EA402AC;
	Thu, 12 Mar 2026 19:55:44 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id BB32F40275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 19:55:43 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4624414002B2;
 Thu, 12 Mar 2026 14:55:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 12 Mar 2026 14:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773341743;
 x=1773428143; bh=pU3aihqSOy1H8hhJLsKquGi54xPgKVlgaOj0pIvt/as=; b=
 SgomeW8Sv8k1QHSJETFUH19AscvO7qRrk9oAUZbEmu8F7GG7nJzZcS/AXVC9Hk0g
 rqhda7HWl5GUW3c1BtsJP+fh44jQTX5TRfkZft37ldOvuBsiWP9yEtI2IbxA09PE
 rh3+LivM3LyU1PIj8prJMBxPU3TdScPvm7u9av4ueajTjrCD04izMy2DhBArnVzZ
 SvNZm1RjTFx5Cc3jm/muQF4Ya1b9/5fHG7t5uezdvkwcGFnEHyd1R+odqfC+v3TR
 QbDzvvOc+hUTsS8EFirCxUrmBwN8uJmoLIeX/hecyMhaZZhP3elf8c6eM2f4TmQz
 syDs0sfYhN0SSo9yw5rn/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773341743; x=
 1773428143; bh=pU3aihqSOy1H8hhJLsKquGi54xPgKVlgaOj0pIvt/as=; b=0
 G4aZ3OyBibUd3XBRodekl4ivlYbVhXK+26z4HWtEKorRELuKcOZXOykvcnGqRARE
 txGgrjHflpJxwobEwsl4WyHNhSUIeK9mREkyxttY8egP/p9CEvbGcdROlDchQ4TT
 6c0DMss8W7cJOoUNloWGLqLKrZ3AZzVaEA+5IUHCz9b6uvFrvLeWU/AxhhVtLVFu
 l+UISbixIcagR8QfU5T5wJt0VujnzfGjH3vNuV6pFji/PnYq7Q4T1WJKKrL0oTer
 vmILt+Qcs/KkH1P6nnuKz/+ZAmsrDBuMAIJiqvMw6V7ZAt0M9ZJOydfv2D7SwQJh
 qESTN1lOQVa14FOCFvGjA==
X-ME-Sender: <xms:LgyzaQNptHfZDk9bXKyH9mD-G3tyAb-kh9uh_lLfWGpwRZX5Q9iyhg>
 <xme:LgyzaXYej4jmkezsLg3IgkKnj88eOqxWN2rzBrlBhfGNtgFu0feK17oE8eOEk5OZ6
 _JdO2wykCVkyxSXxXTiYu5rBRpk48GpzAC3C-qgpvJP916u-x9e>
X-ME-Received: <xmr:LgyzaX_4HOxgxK-FThoYkIxawRihsUjLkz1oe3Go_y0wpxlv4G2Fb0c1I4CKNGKYf9SqoOdNw9kOUw0mfYZde11gWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejheehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrsggrihhlvgihsehiohhlrdhunhhhrd
 gvughupdhrtghpthhtohepphhrohgssgesihholhdruhhnhhdrvgguuhdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehluhgtrgdrvhhiiiiirghrrhhose
 grrhhmrdgtohhmpdhrtghpthhtohepughmrghrgiesihholhdruhhnhhdrvgguuhdprhgt
 phhtthhopehkrghirdhjihesihhnthgvlhdrtghomhdprhgtphhtthhopeguhhgrrhhmih
 hkjhgrhigvshhhrdhthhgrkhhkrghrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrvhhi
 ugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehgrghkhhhilh
 esmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:LgyzaQTPdz4D4qkalH0Yf2dc5rbfjbwp07C-Y4e2gxhM7hyASrUTHQ>
 <xmx:LgyzaZf1VgAffzTqwKexk4DTr-9Bfz5W727zJ2rAZ-TnrJ_ZXUfA0A>
 <xmx:LgyzaaQ8Vc9CKGG3QjGIjECrx5uDnA4pz4g4SvK0wm72T_pyza_Prw>
 <xmx:LgyzadIBFFdC647258oSsJyhqTGIdTSIzACUztzDsHw4ti1CK0BrTw>
 <xmx:LwyzaTBzJgqlMgnSv2r97LEBwcirHb1oCwNEsaLcTXvIFkz-8eAR1jZ3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 14:55:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: probb@iol.unh.edu, dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, 
 kai.ji@intel.com, dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com
Subject: Re: [PATCH v5 5/5] dts: add crypto test decorator
Date: Thu, 12 Mar 2026 19:55:40 +0100
Message-ID: <2341241.iZASKD2KPV@thomas>
In-Reply-To: <CABJ3N2XxFso=mKLObZzy5bPiLDRewNmNU=15WCh2koz=4EdnqA@mail.gmail.com>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <8652174.T7Z3S40VBb@thomas>
 <CABJ3N2XxFso=mKLObZzy5bPiLDRewNmNU=15WCh2koz=4EdnqA@mail.gmail.com>
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

12/03/2026 19:48, Andrew Bailey:
> On Thu, Mar 12, 2026 at 2:08=E2=80=AFPM Thomas Monjalon <thomas@monjalon.=
net> wrote:
>=20
> > That's a bit strange to read,
> > because a crypto test can be functional or performance.
> > I suppose we can re-discuss the classification of the tests.
> > If the only need here is about the traffic generator,
> > we could make it "raw input" or something like that?
> >
>=20
> I agree that "crypto" is not exactly a true description of the
> purpose for this test type. It is probably better for the test type
> to explicitly describe it's purpose. maybe NO_GEN/NO_GENERATOR
> or NO_TG. It just so happens with this series that crypto tests are the
> only cases with this type, which was the cause for the initial name
> but should change in the future. Furthermore, we could divide this
> into performance and functional versions of this flag.

Yes I think we need to consider the level of abstraction required here,
and the cases we want to cover.


