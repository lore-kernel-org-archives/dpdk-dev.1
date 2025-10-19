Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B9CCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 20:52:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E81D442E15;
	Sun, 19 Oct 2025 22:52:39 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id E128B40DD2;
 Sun, 19 Oct 2025 22:52:38 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CA1ED7A007D;
 Sun, 19 Oct 2025 16:52:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Sun, 19 Oct 2025 16:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760907157;
 x=1760993557; bh=trGAUTtwfOv2vDqKzOYZRY7vrHX951MOVa7BN3X9OnQ=; b=
 fffvwvbKeiImu7rfxCD0AwYzEvXG71IDnT9k6/KYO/vWnSbhl0GS9tdfmk0LDHV/
 66rJhSyHc9+DKEWo9oqZ5N1bkIHya0KSU4FEmf6kiHjbh6ijbS9ehub7MGFURV9i
 dsWqq9rJ8ORdGwZ53kMRP3KwgwEps4Qif1DcBiDEeJSrRM7nbwdztkfMFC74S0Cl
 57Kr2SS2tYr4yEgFP4QarnfHDfa9Fq75nmAEkQKabL4/4g6hwTmEqq8T+8laaYB/
 8nK/OL3WTtXh/xawrMWQLp4CuPqbDM8Gh3fPHj/sXWVnCMeKiraXYBlJozKa2j/3
 Jx36+sZhZ1MeoZqalag+Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760907157; x=
 1760993557; bh=trGAUTtwfOv2vDqKzOYZRY7vrHX951MOVa7BN3X9OnQ=; b=E
 A3C+swVeNUkdUYeC9y9dMJVcch9oWhggdVgnrvdNP+lt9parqER8dKvcc6b41x7W
 RGEjrzoKuJXTfFedL8K7rb3hqD+36Pz0EoPpn0ZneV0WZSC5LI0bEa6IH82n2lZD
 prI1aRLKwNjtE8mANVfsJtJlRr/XtcUPakKcpUnWgUSjJsZN0WlkvMw4PJDGLCJJ
 kiRkmE1nZ8P9akI7CmAlSuuCkdoA5/Nzwgd5YnbX2+x14IqNsIli4sJp+WUJ4uo8
 Jt7yhTFoi4I/iEI+mDNfY8ITpW2M9qt48C1JAqiiWrSrw+wQUJ9z0shsdkkARaHL
 veDK5ns3j7fJ/6gVDa5Fw==
X-ME-Sender: <xms:lE_1aHQzQK0Hb68M514sW327CCr-RmF82Kan9-W-QTr6MnYaubiccg>
 <xme:lE_1aC2AzcthpC1yzIRvGwjD8Zl4rb_73PjWCCUnzgs9uuODf00IaI7eqTfDwxIU5
 fo0vUi9Z20dt4P7hy7s1K2cuQr4pWJ7e4q3_2mBfrQVRdrViMVBmQ>
X-ME-Received: <xmr:lE_1aMtc_goy_VbBbzwkh7_t3NPNSTMLxNtLEY8jS5HMPGmse_OjmfneJDW9vSA9GfQs6ntg0FUuYaTb_FkBwJhAKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehpsghhrghgrghvrghtuhhlrgesmhgrrh
 hvvghllhdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghm
 shdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlh
 drtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdr
 ohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehfvghngh
 gthhgvnhhgfigvnheshhhurgifvghirdgtohhmpdhrtghpthhtohepkhgvvhhinhdrlhgr
 rghtiiesihhnthgvlhdrtghomhdprhgtphhtthhopegtihesughpughkrdhorhhg
X-ME-Proxy: <xmx:lE_1aIjfOFmqe_EN-Fki1TodAHbfUdxoEC9lJ-MOf4_ci_Su0DwbGA>
 <xmx:lE_1aN8a-KqIaaY1T6N2tIakYFrjuueSI6FIdabPygV1dduvt2iE1A>
 <xmx:lE_1aLvoRFAvMQIkp6kEWGz9t8g7MwPGbcAwUH02kGPdD6ycweftDg>
 <xmx:lE_1aBqoEfVtWAIlCgao1rVM8rcGf8al40EKxx24bWP8BcgoAxfASQ>
 <xmx:lU_1aK6Rt9kPqf1NpERKKA6GSZe3N4J1gZknPvSggHAl7Xqi8ScbJ4TY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 16:52:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>, 
 ci@dpdk.org
Subject: Re: [PATCH] dmadev: replace zero length array
Date: Sun, 19 Oct 2025 22:52:33 +0200
Message-ID: <4229816.eFTFzoEnKi@thomas>
In-Reply-To: <PH0PR18MB4086321DB97D825FF9E44D86DEE9A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20251015185946.338417-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F654D4@smartserver.smartshare.dk>
 <PH0PR18MB4086321DB97D825FF9E44D86DEE9A@PH0PR18MB4086.namprd18.prod.outlook.com>
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

16/10/2025 11:50, Pavan Nikhilesh Bhagavatula:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> >> On Wed, Oct 15, 2025 at 11:59:46AM -0700, Stephen Hemminger wrote:
> >> > -   struct rte_dma_sge src_dst_seg[0];
> >> > +   struct rte_dma_sge src_dst_seg[];
> >> >
> >> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> >Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20
> Thanks Stephan,
>=20
> Acked-by: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>

Applied, thanks.

> We should probably add this check to CI.

Yes


