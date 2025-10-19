Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B24CCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 21:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D0F040DD2;
	Sun, 19 Oct 2025 23:27:48 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id F2B91400D5;
 Sun, 19 Oct 2025 23:27:46 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 04DC51D00023;
 Sun, 19 Oct 2025 17:27:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 19 Oct 2025 17:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760909265;
 x=1760995665; bh=KEjzzjQDJRC0gq9gBd/64r4taTzlfX3x1G2Om8HzSm8=; b=
 emrXobU5lWTcKANXcnkNQW4sjRij5AJhWxPomfB7NI6bCUKTJH9tOc6LuyYT2lP+
 lka+C8bu+z6DvtHKMQq4iXYk7bWayaETrcqVZaXOyF0Hz/Tqcv8h7jLpiMiEtmXq
 /Y+bX35r1tHwiCAar0rZRk6MSkERVTJcPohgy9HehVYgP+aCUhTH5UyMn6JzybUW
 iD9+s83WHIQmkruuAiVkZikHDdnb+Lo2p4VnA5E9slK8FV3Q6LzEgZqDnaU9CKt3
 Bj0ApDBO/tigABwvwnN88Zn4+wvQR2umHG/ci4/0ar+vi/zODcB8krcj5TXnvUlq
 +zKG1+NpaRSoldVUNdSJpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760909265; x=
 1760995665; bh=KEjzzjQDJRC0gq9gBd/64r4taTzlfX3x1G2Om8HzSm8=; b=o
 nwzxJSMM+79J3gFqjxSCC9z0V3KQPV8XPHYlft6x5WIWHxhnhY4GmX1H49DAeanp
 /adTWPVhqD0hyXa14SbEAzPbd/+sgtVHN3KCuNb3RIwYXpT18lGdFfaMf2tXCYvx
 Khq5e/NdtoD5kjM0RkxU3YiN19XFGxtxXbunfPsrsB41xVKI2tPy6je8yE+Fy28W
 N2tH2S2pLh8qNC2JrnfMFZjEHs7bJt96wkEzfsAOymZjyYSbISRo60B+TuA0/aAk
 4jOSRYsKarvlgwoRRzs1CyRicHwI3PjJOC0q3pjLc0JEkILPZ0YCDPXFAO2N0wSk
 CzS4QHRFgM3zDO9F4sECQ==
X-ME-Sender: <xms:0Vf1aMPgmYm6moMjAOJ-i9cozjR_HNhBOYBGzaK47HR3xmisuXzC2w>
 <xme:0Vf1aDFmyS5suRbAnsNExxvILVP-GzKKuUXorNzfKGLsRyospo1Uz02oN3WV2RjZf
 brnJgnvIAScEIOaFLtbMUSVbO5GIxBFgxC8-Vhl4a5WhNDkyZrBOg>
X-ME-Received: <xmr:0Vf1aLOSj_5r2z0B4DLYZQvZj5OJ18QfRLoZ7iSjeE4AEIL2BxDhuomHVCBS4Y7Kq5o9-MmVxHWiRdSxycX1stJHOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeitddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehvlhgrughimhhirhdrmhgvughvvggukh
 hinhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgt
 phhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheprhhjrghrrhihse
 hrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:0Vf1aM8IITtEfNI3Oz6wgdVIaGr_6hHwob0qWQ6JAXHRVkMN3NZIQw>
 <xmx:0Vf1aPTHuOkGt6PMTDkmD8SjMR_4keVVuKaP_KZ-CfvESIxu0pFgyA>
 <xmx:0Vf1aOloYk37dM5WhdoHjvrtw2LioNE3VW2-0pLqlqjlLWRUFnqIug>
 <xmx:0Vf1aPQ2Nc-XutfiBrL0X6IND1q6fsKEUSKj5wVkF0oMVosxE7FUPA>
 <xmx:0Vf1aKJtdvBD2PVhBiy9X9r21zh4wgQjxln1wdbL5kimfwKGkkNE52FM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 17:27:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH 2/2] fib6: fix tbl8 allocation check logic
Date: Sun, 19 Oct 2025 23:27:43 +0200
Message-ID: <8963590.eFmWaWnqpD@thomas>
In-Reply-To: <DDISITO3VISA.3ER8HBDM4WX4Y@redhat.com>
References: <20251014181755.114300-1-vladimir.medvedkin@intel.com>
 <20251014181755.114300-2-vladimir.medvedkin@intel.com>
 <DDISITO3VISA.3ER8HBDM4WX4Y@redhat.com>
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

15/10/2025 11:32, Robin Jarry:
> Vladimir Medvedkin, Oct 14, 2025 at 20:17:
> > Currently if there were 'n' preallocated tbl8 entries only 'n - 1' were
> > able to be used. Fix the logic allowing to use all preallocated tbl8
> > entries.
> >
> > Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> Tested-by: Robin Jarry <rjarry@redhat.com>

Series applied, thanks.


