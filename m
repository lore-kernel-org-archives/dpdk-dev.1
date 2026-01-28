Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E233BD46BE5
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:45:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F3AE4026F;
	Wed, 28 Jan 2026 18:45:02 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 4B3554003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:45:00 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id C9A61EC0090;
 Wed, 28 Jan 2026 12:44:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 28 Jan 2026 12:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769622299;
 x=1769708699; bh=mGPd/8r+tuGljVcxca4O5MuKK54g+T837OwBGbEewhs=; b=
 cVV6zxBfLxvoghpw2dTvfE8lQ62wsqNZVxrwXh2lMZkYWytcmEkKSEPf0xQkj2tN
 yaSWx7cZzaTHVxLEXm6rlC8mdBvaaJ/M4ZW22A52f/JPU7KSIVYVc5MxGBiyRlvT
 rqwxb5cC5UsV5xOWAl9bYiZwF0wGnX0fOZR/kDqUn2rknu1efuQwCD5hkiZFikrm
 6hG2eHELeUGPCTkFqnx9e394VbOGPtyHyvBgE7wJqkDKyYwUJSpsAM2Ew1MYKYLk
 qCoMHYKeCuqC6ElCpwSrEt7e4V5o+WKZkdDIYiScUbDppg9l6ilZ3rMeQ9QudG5d
 n29Ntx7l2aTugV4OpDS8dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769622299; x=
 1769708699; bh=mGPd/8r+tuGljVcxca4O5MuKK54g+T837OwBGbEewhs=; b=G
 XJzSgdYtup9pBx1nBJE6f6JS+BPcQ+JwBRfkGSNNAg1sJ9OIa8JIxBbQae3ygH2h
 rsytibxozPgb+MfEb30RyrxTS4sbPzIn/yRhQi9U7HD6rtFsF8w+Yg+IZFb5xMIa
 aGQQcvuhBlmQVaYPzNty05ck4RA7SRnkncRdMe3P1Hj4HxRzpWaperaNQkbAAEPY
 gEBDi9qBRtWrw0Kvqo5QZUDk7blL3IuRcqYYacC9+BrxCur3bqTCRm5FzBYL3aNq
 RCOUP9Ml8iL8Nkl/FF3VV1ghWJnuRg8AORursp3/C+mmBu+rDh5lBHUiciolxQ6X
 IGzITuozu9RZT9PkClx4w==
X-ME-Sender: <xms:Gkt6aT7-JOlD0iVJV75K13vxVFlhmJVrwOOWiuWiRGvsxyRroEndUg>
 <xme:Gkt6aZ1yjOJnhuI7JKpZNd43J08Bslqy9kSI0TGoSEjRyeGKSjZ_2yBohYmDU293s
 n7_CJXdH2jUWwgP2kjLo4Ac_cX9Zj64QlpvVDQYsmbTlxDFj3TF>
X-ME-Received: <xmr:Gkt6aazgLlL303xxsfIKQfCd--2XVXHr-DuS0fuck2sroWD-Fayw6yxqI3OMlpe_5k-5Qu3Lh7cLJltLhxm9c5_XeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefleehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeevledtudetjeekueekhfdvieeileefgfelgeeiieekleegveelieet
 gffguefhtdenucffohhmrghinhepshhpugigrdguvghvnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthho
 peguvghvseguphgukhdrohhrghdprhgtphhtthhopehhvghmrghnthdrrghgrhgrfigrlh
 esnhigphdrtghomhdprhgtphhtthhopehsrggthhhinhdrshgrgigvnhgrsehngihprdgt
 ohhmpdhrtghpthhtohepkhgrihdrjhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepgh
 drshhinhhghhesnhigphdrtghomhdprhgtphhtthhopehirhhushhskhhikhhhsehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtohepshhtvghvvghnrdifvggsshhtvghrseifihhnug
 hrihhvvghrrdgtohhmpdhrtghpthhtohepmhgrthhtrdhpvghtvghrshesfihinhgurhhi
 vhgvrhdrtghomh
X-ME-Proxy: <xmx:Gkt6aSn74Q_KuvIwkkqml8dmjpsSRPQU3vwPYqBF5BFAucSWkVF6HA>
 <xmx:Gkt6ad9ooJx4aMuiJBF7sJigQ6xc9TqeOF2-XmOn9vXw7OAHZIkyYQ>
 <xmx:Gkt6adq_XScX1t0Ius3b2xA_PceEgQUYWUQlaWT4dZzZRcamntVuvA>
 <xmx:Gkt6aRIoIqlRO_A9v_NASsqgwAiT3pwxWbHfrEKuHknaoFD5I4qKiw>
 <xmx:G0t6aZ3ivavJ1L_5zsxomUvzPnn5i3suYv2ajdoRVDvOEZe-YZ9RK_-l>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 12:44:56 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Kai Ji <kai.ji@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v2] license: standardize SPDX tag
Date: Wed, 28 Jan 2026 18:44:54 +0100
Message-ID: <11418515.5MRjnR8RnV@thomas>
In-Reply-To: <aXo5i0oz3ccqSBnG@bricha3-mobl1.ger.corp.intel.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <20260128162219.2929316-1-thomas@monjalon.net>
 <aXo5i0oz3ccqSBnG@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

28/01/2026 17:30, Bruce Richardson:
> On Wed, Jan 28, 2026 at 05:20:52PM +0100, Thomas Monjalon wrote:
> > In the Linux Foundation SPDX recommendation,
> > there is no need of parentheses when 2 licenses are possible:
> > 	https://spdx.dev/learn/handling-license-info/
> > 
> > The useless parentheses and spaces are removed,
> > the keyword "OR" is uppercased, and the comment starts with /*
> > 
> > The script check-spdx-tag.sh is updated to detect some syntax errors.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> I actually think this would be better as two patches - one for making the
> changes across the various files and then a second to update the script and
> readme.

Why?
I like when new rules, applying them and checking them
are done in an atomic way.

> Acked-by: Bruce Richardson <bruce.richardson@intel.com>


