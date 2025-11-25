Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CF3CFD31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 00:47:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFA60402EF;
	Tue, 25 Nov 2025 01:47:34 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id DF404402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 01:47:33 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 792121400035;
 Mon, 24 Nov 2025 19:47:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 24 Nov 2025 19:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764031653;
 x=1764118053; bh=hy/pb5YycdnwtWlOhj2c6clulBEWOcE2XFRO6YcBwLo=; b=
 kWlLM5cloTdASraKhhIqVsw1dMOctxHuEJOqiSlYm2RW4CJs/CljN8q673zhohvK
 Dge70ivOWeG6OEEBlZkHXZ+rkYr9oxpEnS+QoG3nYEPh9HQ4//KNeo+7CF86Wna6
 5hlJnHeBc7Byo7fYWx6iZxlh/B6L2rxPQsZQLqJB+faZeZi+oj3xeKD0RDVzk4xS
 i6rmiu1JK2JbnmfOLPtDNzenh+kwhF8hM+wAQXOmDTR4kkmB+cMfWwML3oJa6uEw
 8P7272Rqylcq1CqbAwCioHERYqgVG6QmI78T1sfQHEyUiXZ2OvASMkfj4yU43Y2a
 MjXnS7xkCOjSnwC3/fhnwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764031653; x=
 1764118053; bh=hy/pb5YycdnwtWlOhj2c6clulBEWOcE2XFRO6YcBwLo=; b=i
 Pf5NFvyY3Z5AUeyECpeQzo5RzcGVzlmWFEm5j6qDicbE4G7VHhSJpYs81nwY14Gy
 D5QN8r52ZPIiakELmLCPUGOG5ZfN6wKibBnBzEx39y600u5Z+fOJyEF4fBK1Od0d
 9bXsdjXuR7DerE9WrwIDbpXsVcOt7hb3S6ozQRJ+ONmND1UrjkbC9BcE97qfKBO+
 imrxDLNRNyKNfQg+EmP2+W+N3LXiOBXKG+/7CSRZ2grWb63BYBYl0CkSED/G2ENz
 2YabBfJlz8KPOvHFgLuFNPfFNvCVHGtmiRaTFnIUd57qXjMQoy4SAB2JeSfbSY0Y
 ZgADvmEaVFfpLFo1NH3xQ==
X-ME-Sender: <xms:pfwkaeybvDH28A6YFe9NEcNHJbg3ZVefD0yUFIheRaguZ3PNCXALxw>
 <xme:pfwkaelWjKTidyCu43-3UmfjGGfDqH-SVVWXhlSC-eqCoFht54nQBvLF5rqLtV-UB
 -8E4dz4ZeFf17yW0SuTUKCyHD_PTaDJwezIpVAt6lmPhXx_Go_zLxU>
X-ME-Received: <xmr:pfwkafcJNy5icBgcnFmeLqCsNURkY4uXjEK9oaxm-p0RQJGegB9bUSPcZAJSyM7-0A5A8jOxcOUt8p3M_E8M8ZVBYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedttdekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhes
 ihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:pfwkacof6TORWCvqY6JDoOVaGbMDVf6OPiGfhaR6fBQWKGV9jjVQgA>
 <xmx:pfwkaV4NiDsUHEHb9FoabNjKJ-3XklJ5Z1qiM3neXjRF27RbvDm4BQ>
 <xmx:pfwkaaqoYlRFCIn_X3pEKRa9JVpDlR4OKex_VixXmLYCKJB0teh9CQ>
 <xmx:pfwkafgHpORH0PzpxpGuYkdU0ZxTwj2wS2LAjvLJTSoeygEARavoLw>
 <xmx:pfwkaT8UOcDWpd2iiSqyZlXdxx7DaGdGOhmzqXWUSc739nHQETSOWxt5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 19:47:32 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] doc: update FreeBSD python version
Date: Tue, 25 Nov 2025 01:47:31 +0100
Message-ID: <2719082.QkHrqEjB74@thomas>
In-Reply-To: <CAOaVG17EcSkRTkXNundxXymFid=m-EMXrYRNnMpO=NpJq6dkvg@mail.gmail.com>
References: <20251103193038.135022-1-stephen@networkplumber.org>
 <aQt-hNN9Zkdr-BjE@bricha3-mobl1.ger.corp.intel.com>
 <CAOaVG17EcSkRTkXNundxXymFid=m-EMXrYRNnMpO=NpJq6dkvg@mail.gmail.com>
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

05/11/2025 17:46, Stephen Hemminger:
> I just wanted to be able to cut and paste from documentation to setup test
> build VM.
> 
> On Wed, Nov 5, 2025, 08:42 Bruce Richardson <bruce.richardson@intel.com>
> wrote:
> 
> > On Wed, Nov 05, 2025 at 04:13:39PM +0100, Thomas Monjalon wrote:
> > > 03/11/2025 20:57, Bruce Richardson:
> > > > On Mon, Nov 03, 2025 at 11:30:38AM -0800, Stephen Hemminger wrote:
> > > > > The version python used in current FreeBSD stable release 14.3
> > > > > is now 3.11. Update documentation accordingly.
> > > > >
> > > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > > > ---
> > > > >  doc/guides/freebsd_gsg/build_dpdk.rst | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst
> > b/doc/guides/freebsd_gsg/build_dpdk.rst
> > > > > index f98292bf41..c8b2964a4b 100644
> > > > > --- a/doc/guides/freebsd_gsg/build_dpdk.rst
> > > > > +++ b/doc/guides/freebsd_gsg/build_dpdk.rst
> > > > > @@ -16,16 +16,16 @@ The following FreeBSD packages are required to
> > build DPDK:
> > > > >  * meson
> > > > >  * ninja
> > > > >  * pkgconf
> > > > > -* py38-pyelftools
> > > > > +* py311-pyelftools
> > > > >
> > > > >  .. note:
> > > > >
> > > > >    The specific package for pyelftools is dependent on the version
> > of python in use,
> > > > > -  Python 3.8 being the version at type of writing, hence the
> > ``py38`` prefix.
> > > > > +  Python 3.11 being the version at type of writing, hence the
> > ``py311`` prefix.
> > > > >
> > > > >  These can be installed using (as root)::
> > > > >
> > > > > -  pkg install meson pkgconf py38-pyelftools
> > > > > +  pkg install meson pkgconf py311-pyelftools
> > > > >
> > > > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > > >
> > > > I always find the python version included in the packages annoying,
> > but I
> > > > don't think there is anything we can do about this. Thanks for the
> > update.
> > >
> > > Do we really want to update the doc after each upgrade?
> > > This version is not the truth, it depends on which FreeBSD version is
> > installed.
> > >
> > Python comes from the ports collection, not the base system, so it's
> > independent of the BSD version. Therefore the commands here should work on
> > all supported BSD versions.

Applied, thanks.



