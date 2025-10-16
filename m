Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E761BCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 08:43:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2694240B90;
	Thu, 16 Oct 2025 10:43:03 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id B7903402C3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 10:43:01 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F116C7A010C;
 Thu, 16 Oct 2025 04:43:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 04:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760604180;
 x=1760690580; bh=t1Aqz24SbAI/jyYXuRv4KyvWQ79timAVweQLowJ95Fk=; b=
 EpCDTbmyk1kOiTckztQXK0pQXzKO9F46WtccIOVxveBHYCTAwTfao5Pw49cVjyJU
 5L3KoUdga9uoaQ7rYgNTpy1+0D/d3zYISxh3TsxtqiyTcljjuMtC/AWMSna053XD
 MG+p8bYnl+EbxZ+zf3qMao0vMA3OpsCfIMAX0Jj74odAUBMVJ7JS4YpRIdc7ZdTL
 eygWMpcneMnPiHvfcrfBvruDD/9Ekm0roKO0mk9gWUimwqg/vjI+mEzgoBlrau9D
 ZnZAVzq4WyZ/PXWdZ4wUeOO+txEimcRD9r7j61itkAef1j4dSDlyZ8bR7JaWLvUt
 MmS712Qpjx2AE30X19bAhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760604180; x=
 1760690580; bh=t1Aqz24SbAI/jyYXuRv4KyvWQ79timAVweQLowJ95Fk=; b=e
 wb8GN7mGFggXfIkEpjW28lm+7uPMSJn4MSt95siEdZIcI2Q25jCdlMrtw3SRidMN
 R1HYtO0aJRlgbBfRTa28QhWCXSOH5RDHHJeWU8yIPjCjpEwsrT+BHf+NFUw8Nrk2
 dlmAdQIND8cCQ+9RGrRThVHsZN+w8hDV2iMW0BZPgO+XUVcu8GowOtRYivz1uozE
 YIcpBl2S2csNwOh/W9YV+WMSdrDxHwFBBguUGb00p0hqgCUcAsuv7kSFP4uzzZdC
 dvt8zIsQF4ZAxGei6IcPXQ9P+qfukrhP9wkOpena+uTiBnswDsOevtwoMzXVTKnN
 q+wINCsZtNL0Mp9ui8K6g==
X-ME-Sender: <xms:FLDwaOW5KYH9SRQ2lX6KxW2b6OHBSNJstt2D1J4L7sdOeUvkCLPwWQ>
 <xme:FLDwaFgDFAAWKMqwkaSYZxz8eKUU920d-IvAJ1W3pU_UOXpOOs_9cUoYLFGSa7Dxm
 PYhkQG3AMdv9kFN3qoNzHhfjNjzhLaUc1r1kOJnB6TP8SCux2u0cg>
X-ME-Received: <xmr:FLDwaBbzrnalcGS6sFlObNhhKQ0F-vNjYhW7tlfxV_KqRxa7m0BkF2mM4Q9siObfsNqpW5_gUlRHOuh7kE5uh3Bm3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
 pdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhhphgvrhgvthii
 sehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiug
 hirgdrtghomhdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdr
 tghomh
X-ME-Proxy: <xmx:FLDwaKpI-eGrTMAT_eGcSK30NDYbax6E-KKsfMHakeePKL4cRyk35g>
 <xmx:FLDwaGOIaIKx4UcxDlz8D9HECv1LgrSjUO0AY5YLGadFQrhK7CWDwQ>
 <xmx:FLDwaFpy_pQQyXQ83hfV2VBNRIFPoRfSm-w0vHYarrxxtdE6XODFcg>
 <xmx:FLDwaLdgwMkmoRO0T83fENXthUMFX-jJ5-xtX75RXxZGUDgIi5nw8g>
 <xmx:FLDwaIRK8r7zWThQs9BK9uwcodSsKzxz7XdC_4jRRmmiJUWGw4dknAl_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 04:42:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 shperetz@nvidia.com, viacheslavo@nvidia.com, mb@smartsharesystems.com
Subject: Re: [PATCH v6 7/7] usertools/mbuf: parse mbuf history dump
Date: Thu, 16 Oct 2025 10:42:57 +0200
Message-ID: <2863952.HovnAMPojK@thomas>
In-Reply-To: <aPCocj7Kn4KMTBm4@bricha3-mobl1.ger.corp.intel.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <DDJ5GW4K1EPR.1KCSDT2O9LO5G@redhat.com>
 <aPCocj7Kn4KMTBm4@bricha3-mobl1.ger.corp.intel.com>
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

16/10/2025 10:10, Bruce Richardson:
> On Wed, Oct 15, 2025 at 09:41:18PM +0200, Robin Jarry wrote:
> > Thomas Monjalon, Oct 15, 2025 at 21:11:
> > > 15/10/2025 19:50, Stephen Hemminger:
> > >> Minor stuff.
> > >> 
> > >> $ flake8 --max-line-length=100 dpdk-mbuf-history-parser.py 
> > >> dpdk-mbuf-history-parser.py:14:1: F401 'sys' imported but unused
> > >> dpdk-mbuf-history-parser.py:29:27: E203 whitespace before ':'
> > >
> > > Interesting, thanks.
> > >
> > > I'm a bit lost about Python linters.
> > > I ran black, should I run flake8 + black? something else?
> > 
> > Just black. Flake8 style is completely obsolete. The unused import
> > warning is legit though.
> > 
> > We should have a centralized python linter process in DPDK. The main
> > issue is that most of the code will not pass as it is :D
> > 
> ... yet!
> 
> For python scripts in DPDK I wouldn't have a major issue about having a
> patchset with the results of a black run on them. History tracking of the
> python files is not as important as for the C files, since they don't have
> that many bug fixes on them to root cause. Once we get everything nicely
> formatted then we can mandate proper formatting going forward (and
> integrate into CI perhaps).

I fully agree.



