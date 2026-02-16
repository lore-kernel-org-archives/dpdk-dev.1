Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1253EEF5872
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:39:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A60640296;
	Mon, 16 Feb 2026 18:39:15 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id A5A6340289;
 Mon, 16 Feb 2026 18:39:13 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id D0F851D004F8;
 Mon, 16 Feb 2026 12:39:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 16 Feb 2026 12:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771263552;
 x=1771349952; bh=Mi/Ce2wuOeZCL3Vq7OoOZ+BBWqM4KxgqN5YhuYvZLaw=; b=
 O/Gd5bRFlAWW5e3JSjjnx4OEW5Gcm5oK1FrF9hSwE8ABbxfLW0YPfzNrwuAQ/QXE
 tTrAWR7cwiJMmYAqc26AqAU3+osADLyYLgxOWU5lA3Gi+PKZbZtmVcim7/WLQS8s
 3XQ6xwxsbW7UH+YwEZe4bVkdHagwxL5lK0WL0qQSb6s1Vizc+E6QvLdYto4usrmC
 iV0fhU7BcFWVUX307YT4YXAZYNn4RR0ezvC1s7oasPVw+r3kmQzExSoxS+zimexr
 Pwrd3h9zBN2cC3I3rwzl7Vd37E8trQVZCDCaaEOjYlO+GyDI6sOmB0mIY+f1HxoX
 fwCdIYeslSyXdmUp4S/XpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771263552; x=
 1771349952; bh=Mi/Ce2wuOeZCL3Vq7OoOZ+BBWqM4KxgqN5YhuYvZLaw=; b=B
 PisKlVUkLnLjLcAQrmX7ph9z1/iXjVSYKsutkrUC9knx55dBqDV440WffxkpSXu1
 v3bhSaKqiuxgdd+dunftBb3hXp2ag2NWDLoODCl6FBbfzeMFCT0ploOWEHF2SAAO
 nFNha35xtIsf/MsjkUhf8MHghPSQYP8RsMmDEwYZUGwQeCfi+zV6CLA4YfenLtHo
 XgndCdGeFBfn7+eIvvEy60BIWX0QNQ00WX/gTl1qjykTyne3wt8cZSDxiKMbp07t
 uU+IJpRT8buqN+eJoYHiF5pX8wOhig9vVIvv6nGY3ucMHc4I8FOtddsEpWD9bwV/
 EuGZd/YSEWdH+CEDXVEcw==
X-ME-Sender: <xms:QFaTadNbyFaSSrKfIypFW1s6yeyizsrbuE7sDiOdWXi0OZYGFPlmZg>
 <xme:QFaTaa7JgiWB9ug4Pz7-LBpOQaO8A7ZNVU6aiA5GGS-fQoF26Bcp0dMI_GITzmR2B
 aHC539dnExzW4UthR7Ti26WQ3CwExc4Y8FYNaxzdLkeupKYRdX_HA>
X-ME-Received: <xmr:QFaTabSpUliTeERfq7hYJMgFtc1JzXURHHJH93kJRelDEOYjejqunZpKK_WF8g2DSDyveqA3e3rjMzAgi-3ZT-VmwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejgeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopehthhhivghrrhihrdhhvghrsggvlhhothes
 ieifihhnugdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthhtohep
 shhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopeholhhivhhivghrrdhmrghtii
 esieifihhnugdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgv
 ughhrghtrdgtohhm
X-ME-Proxy: <xmx:QFaTafD9Z2iKuPVXDCwxJTx9EXvEWcw1OVc1ivAJak3POMTPNri2kQ>
 <xmx:QFaTaTGb8AbBS67c7LqepKwGWzRiTWfFU-ojc_L3cv5NNRGjEn5NFg>
 <xmx:QFaTaRCIuz0s7oFoyn_9SB3wisHcL1BucfQnAiw9RVeA3xQsyTdV0g>
 <xmx:QFaTaTUjjFtILtTZY5p0pIMzyEfbyNyn5QsxKRM7-zytyFqoybnbHg>
 <xmx:QFaTaark6Gw8Q0fKc06GyTzQTpodiC9YiOLJFFuzqnM8ej-6mgM6BLwN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 12:39:11 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>, dev@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>, david.marchand@redhat.com
Subject: Re: [V2] drivers/net: reorder Intel drivers list in meson script
Date: Mon, 16 Feb 2026 18:39:10 +0100
Message-ID: <3565693.M7mRfaRNBu@thomas>
In-Reply-To: <aZMASdK2HOCqukIs@bricha3-mobl1.ger.corp.intel.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <aZL177s7Wu3vLsPl@bricha3-mobl1.ger.corp.intel.com>
 <aZMASdK2HOCqukIs@bricha3-mobl1.ger.corp.intel.com>
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

16/02/2026 12:32, Bruce Richardson:
> On Mon, Feb 16, 2026 at 10:48:15AM +0000, Bruce Richardson wrote:
> > On Fri, Jan 23, 2026 at 05:57:41PM +0100, Thierry Herbelot wrote:
> > > On 1/23/26 17:50, Bruce Richardson wrote:
> > > > On Fri, Jan 23, 2026 at 05:27:07PM +0100, Thierry Herbelot wrote:
> > > > > After an upstream patch (see Fixes), net_ixgbe_vf is no longer
> > > > > declared in testpmd PMD info, when compiling under Redhat-9:
> > > > > 
> > > > > > $ meson setup build && ninja -C build
> > > > > > $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
> > > > > >      "name": "net_ixgbe",
> > > > > 
> > > > > Name 'net_ixgbe_vf' should also be reported.
> > > > > 
> > > > > One workaround is to move 'intel/ixgbe' as last in the list of Intel
> > > > > drivers. This restores net_ixgbe_vf under Redhat-9:
> > > > > 
> > > > > > $ meson setup build && ninja -C build
> > > > > > $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
> > > > > >      "name": "net_ixgbe_vf",
> > > > > >      "name": "net_ixgbe",
> > > > > 
> > > > > Fixes: 04f1b16c54f3 ("drivers: merge common and net idpf drivers")
> > > > > Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> > > > > ---
> > > > > V2: use shorter lines in commit log.
> > > > > ---
> > > > >   drivers/net/meson.build | 2 +-
> > > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/net/meson.build b/drivers/net/meson.build
> > > > > index c7dae4ad273c..8d96244cdbb0 100644
> > > > > --- a/drivers/net/meson.build
> > > > > +++ b/drivers/net/meson.build
> > > > > @@ -32,8 +32,8 @@ drivers = [
> > > > >           'intel/ice',
> > > > >           'intel/idpf',
> > > > >           'intel/ipn3ke',
> > > > > -        'intel/ixgbe',
> > > > >           'intel/cpfl',  # depends on idpf, so must come after it
> > > > > +        'intel/ixgbe',
> > > > >           'ionic',
> > > > >           'mana',
> > > > >           'memif',
> > > > 
> > > > This is a strange one - did you do any investgation into why or how this
> > > > fixes things? You describe it as a workaround so any hints towards a proper
> > > > root cause and fix are welcome :-)
> > > 
> > > Hello Bruce,
> > > 
> > > This is indeed a bit puzzling: it seems that the expected ELF section is
> > > present, a 'strings' dump shows no difference between a 'full' testpmd and
> > > one missing ixgbe_vf. Still pmdinfo is missing one PMD.
> > > 
> > > The issue was not seen when using Ubuntu-24.04.
> > > 
> > [Not unexpectedly,] it appears that there is more to it than just missing
> > this driver. Installing a centos 9 VM and doing a clang build and comparing
> > the pmdinfo output to the GCC build output, I find there are in fact 3
> > missing drivers in the output: net_dpaa2, net_ixgbe_vf, and net_sfc_efx.
> > 
> > Changing the order of things to move down ixgbe makes ixgbe_vf and sfc_efx
> > reappear, but sadly net_vcpf now disappears. :-(
> > Therefore, more investigation and root causing is needed to find a proper
> > fix.
> > 
> Doing a bit of poking with strings on the various binaries has shown why
> some of these strings are not showing up despite being present in the
> binary. In some cases, the bytes leading up to "PMD_INFO_STRING=" are
> printable characters, in which case the PMD gets omitted from the output as
> the ascii string found does not _start_ with PMD_INFO_STRING.
> 
> Given this info, I'm not sure whether this should be fixed in the code, is
> a compiler issue, or whether we should just modify our script to find
> PMD_INFO_STRING anywhere in output strings not just at the start.
> 
> Suggestions?

I feel it would be more reliable to find the string anywhere.


