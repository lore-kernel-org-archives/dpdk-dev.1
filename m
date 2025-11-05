Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A21CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:13:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 985C940A70;
	Wed,  5 Nov 2025 16:13:44 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 9AA1D4021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:13:42 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4EA4D140024C;
 Wed,  5 Nov 2025 10:13:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 10:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762355622;
 x=1762442022; bh=SqL9fql0cfq+XUDLKlBm6r93rjJhWwhE+qQugB0y3r8=; b=
 sXifAGC4iJYN0/wEaF1GoOF26xwoni9k13skVzxRbhf+PGac0T0l7x72C/LyRBPa
 REY0T4d5ynJSvfFkeH9gdJuKrtPhzQi1v5OynpWbx7ggpFI+CG5F/xsOZ7CaFHv4
 26vOTsCwvv9b9KdUpCql294JowN+HjM+3HKDhws1XIxRawoTln7QEkxOV/8Wk2yK
 rqA732hafaqG5xYP7p6p8eHZSHAKgir+NNLBvfygc33CQcGuHZ/QoD7uANWc+VwE
 LBlN1aaAmsWvykKl61D3Utm/atc4GcIeZq2jXdvDQxS+yQyhqHCCvZbBlIWSEuqQ
 OCJPh9t1tPpq587YgdhuoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762355622; x=
 1762442022; bh=SqL9fql0cfq+XUDLKlBm6r93rjJhWwhE+qQugB0y3r8=; b=t
 koBWqUH3o4MIRLx1OkFzqJRlI98+9qg/a8HJR/FzZsHFYjWvm9rG1KKfo2I/Guxn
 X9brY+W1YMVhhYzI6nyGKmOlUXbnH+Ad9YE8XmQLXq8wuEyEosmWCFqvw/qZuWC/
 p4MoodmW8MNP5oGVHE3CghiCSxYZXP+d+rDtYStZLCI30mva+W/BLK4LWeavbRmW
 dfaQZOydfJyM2qIJyZKBKXNJZMCMyFxobCNYYz99BDqI2DOgRh05D4hCI+RPIUtu
 TaNs4rk95K7e0tt/5FndAs7Nv7mkoXyqAAgpeBPG/jEwb4+s/XP+kdi2Ynr1OHob
 KUe2UoNObjTRCPlGgnEhg==
X-ME-Sender: <xms:pWkLaZi8kD0zyIJLg_xYoOR-Yy8VMiWc3nvR-Y0ciyd6GgqPXo1ZvQ>
 <xme:pWkLaSXIyIlmN2HqYcuMVaQrE6EMU9-fFVXNAm0r8nNiYN6laRhdzbCcUnFs34NJE
 GrjVagKNMxxEVou-u87hNwpFeuF8TaQ6BQANPiMYfp6t_o0borHFA>
X-ME-Received: <xmr:pWkLaYMo_4E1SNWGkgwD65_1y2s7Tj4NSaXw98J-cqdpYUrU4HaVjVSPK5O4iGzgDLczqNm6uebFlAkdtReEGbF3xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegvdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:pWkLaWbpnzyQN6cSb0nmB7vEivIQtmS2U5XB1OoP7_QjZ0sgWMrC6Q>
 <xmx:pWkLacoMTk6NX5Xmm-ldVvCUNhroPEUxoIsz6nkQxEaw-qXfi33U0A>
 <xmx:pWkLaaZxu1XkVzRjmVADRfqPylC7F3gFqJS2Bv82P7eh9nLfX3uuSA>
 <xmx:pWkLaUQDVAzUUGIY4amu0-UvXHNgs5-NSqnCBFuvrGvbu0FRJU9aVg>
 <xmx:pmkLadvZaEyrIZDa41A2CPLHh6fj8zCAlj4Y2A4ESNMY4_9ZSDTyQmr7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 10:13:41 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] doc: update FreeBSD python version
Date: Wed, 05 Nov 2025 16:13:39 +0100
Message-ID: <2829936.sGnKIMrFRI@thomas>
In-Reply-To: <aQkJMHX6NWmZcJEd@bricha3-mobl1.ger.corp.intel.com>
References: <20251103193038.135022-1-stephen@networkplumber.org>
 <aQkJMHX6NWmZcJEd@bricha3-mobl1.ger.corp.intel.com>
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

03/11/2025 20:57, Bruce Richardson:
> On Mon, Nov 03, 2025 at 11:30:38AM -0800, Stephen Hemminger wrote:
> > The version python used in current FreeBSD stable release 14.3
> > is now 3.11. Update documentation accordingly.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  doc/guides/freebsd_gsg/build_dpdk.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
> > index f98292bf41..c8b2964a4b 100644
> > --- a/doc/guides/freebsd_gsg/build_dpdk.rst
> > +++ b/doc/guides/freebsd_gsg/build_dpdk.rst
> > @@ -16,16 +16,16 @@ The following FreeBSD packages are required to build DPDK:
> >  * meson
> >  * ninja
> >  * pkgconf
> > -* py38-pyelftools
> > +* py311-pyelftools
> >  
> >  .. note:
> >  
> >    The specific package for pyelftools is dependent on the version of python in use,
> > -  Python 3.8 being the version at type of writing, hence the ``py38`` prefix.
> > +  Python 3.11 being the version at type of writing, hence the ``py311`` prefix.
> >  
> >  These can be installed using (as root)::
> >  
> > -  pkg install meson pkgconf py38-pyelftools
> > +  pkg install meson pkgconf py311-pyelftools
> >  
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I always find the python version included in the packages annoying, but I
> don't think there is anything we can do about this. Thanks for the update.

Do we really want to update the doc after each upgrade?
This version is not the truth, it depends on which FreeBSD version is installed.


