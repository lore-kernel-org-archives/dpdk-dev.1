Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECCEC282EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 02:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B17A402DD;
	Wed, 19 Mar 2025 03:17:28 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 1B343402C4
 for <dev@dpdk.org>; Wed, 19 Mar 2025 03:17:27 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 1990C2540200;
 Tue, 18 Mar 2025 22:17:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Tue, 18 Mar 2025 22:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742350645;
 x=1742437045; bh=HinAqrXXVdPqI5Laoekckfp62erI7RDNkeslAOpJC7o=; b=
 vW7KRJITn86/mmJzacK5KhWsgASXoQ5ZHwHgiM+Nserpt8oozp6xSJOW444U95/d
 fqDYg0hJqHwzL2kH1rKSJRnBIviNB9j2Wb6UONebN9t2KsfwFQmRmPGGRLNXCmhv
 1lrJJptSDlhmdB0yJVN2vi2fi80w1JVLid144y9dcsHfdip+GS0ehdrXxNYAX0lI
 0VxEXm/KD+Q+i9QUQktW8+mLJPM1HJZOmoROemHBm+xrupZDDBftn2QriRaLJUzL
 Fg98cJNX22yvxpja2eUarHZ4mNPur5RcWPhAV7MvpogViHWStWk/uUhZirmiVf15
 JtNayKEASJfl21BhJHwo1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742350645; x=
 1742437045; bh=HinAqrXXVdPqI5Laoekckfp62erI7RDNkeslAOpJC7o=; b=h
 9gzxfQ+lLIWS92jl+50fFudyQ0Us+SVKlnGbmIL7r4rnPYL38EPwW9B/JXgonGY4
 sKlbjRuzEcI5a5NTr3Z+j/eZvP9SbQ9KE3QSxfqnkwcN/43P1bsmmMsuk9fXrb4A
 QCEJSEubAt4rmE2EUdwIrvG+23DmOykHe2SvqBCjLDFOo/qwufrbDT8zwvvDHHA9
 1b2vvLzgXi7sBFO4exoESdIrU3mcz/kh+ggQ51FZ9Y10MksfsBwJylGxmLkY1qrB
 H+L0X3pdnzCmnH9yUA2s4hPYhzmHSnQ/oFw+INDR4zPKhfuwmt0HOzEgp0dOioHU
 Ih2T4m+JQpoxpvWSrCgOg==
X-ME-Sender: <xms:NSnaZ8ocTKckMaG_Pkfztr82lXtp_DmGQaQ714kqLP8LwDtbgWAMwg>
 <xme:NSnaZyrac5tdWMR9pXMyViOihWTfoLl4NEH0R1yO6wtIeI6MCS0zpnul4FpGcEGgJ
 2dcWXXcJ14V-WOfDQ>
X-ME-Received: <xmr:NSnaZxP4bchv3RLhjaowD6qZalQUTykt8nlN2Yz3LhKw8ebWGmEYo1SysgJvIgGEqwTYuvmogwxythctNMUZ27QwFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegudduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsg
 hhrghgrghvrghtuhhlrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeifrghthhhs
 rghlrgdrvhhithhhrghnrghgvgesrghrmhdrtghomhdprhgtphhtthhopegsrhhutggvrd
 hrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehhohhnnhgrphhprgdrnhgrghgrrhgrhhgrlhhlihesrg
 hrmhdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:NSnaZz4eG5SKOGwoCXFSpeYpKa6qHSXF0LjQBaZW6hPdI2xlDg5AQg>
 <xmx:NSnaZ75YI07S_oh8G2eptDxccA_9ttvUIGmK1dpP3KxZt8nUhT1glA>
 <xmx:NSnaZzgZ1hq1aYU8Vu0eapd-J10qtF6VhkHbP6I9aBxpbIP1fOMxLw>
 <xmx:NSnaZ16eDgrTBhpjp5TyAhXAO3swWhiWjbIl_t3EAd4UafTMewLCpQ>
 <xmx:NSnaZ4tIgokH8Ni5K_KOSPjDAfb7uvdz4OZBMXcJe27WgjBuergFn5qr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 22:17:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [PATCH] config/arm: fix march features not being set
Date: Wed, 19 Mar 2025 03:17:22 +0100
Message-ID: <7959955.YiXZdWvhHV@thomas>
In-Reply-To: <BY3PR18MB4785BC97AD137F9FFFACAABDC8D62@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250308085902.4383-1-pbhagavatula@marvell.com>
 <BY3PR18MB4785BC97AD137F9FFFACAABDC8D62@BY3PR18MB4785.namprd18.prod.outlook.com>
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

> > From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> > 
> > Fix extra_march_features not being added to mcpu flags when SoC
> > configuration advertises them.
> > 
> > Fixes: c02c01dbf907 ("config/arm: prefer strict use of -mcpu if supported")
> 
> Acked-by: Jerin Jacob <jerinj@marvell.com>

Applied, thanks.



