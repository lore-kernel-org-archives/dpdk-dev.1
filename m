Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8C9C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 17:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54E61427AC;
	Wed, 19 Feb 2025 18:42:27 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 6BA604028B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:42:26 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C613211400B9;
 Wed, 19 Feb 2025 12:42:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 19 Feb 2025 12:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739986945;
 x=1740073345; bh=s8XNWrVyv3KGYr3VOezhkIW/DLOVIL0IypJ4zpHw47c=; b=
 GBRP7EzHaWvJ4U+YCQ27wTkPos1p+6wo5v3CfCj77b3TFVvOpslmt+PgnGEgFHnk
 PemWdQ7LHApXRyBmsJk0C05HiYRKNPUcno2883GirvYEFZgocpXvqXQd1P85vet1
 73RDzuyPLkNW5A4zKtRK8Oe/FZx8vVazAie02lNVtm5PMlN3DeDX7ZxUpLpg2L0k
 OY+tgAHt3iPQ1yxD9hjULUj/CwZD/Mywdxy6xkOo3KVrNrKGB2tAldRRVC2xncGa
 d3nFgtK6s2MPoKVKbpyrEPCW0wMExfILmB8TVfTHdzwrtCQvAgNSh/mLEhmDlWv/
 voZFEYRxpR5fK2lRrnp0TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739986945; x=
 1740073345; bh=s8XNWrVyv3KGYr3VOezhkIW/DLOVIL0IypJ4zpHw47c=; b=j
 F4oEhav/OuPjR+I8B55Tx61UuLWmc5zSHFr5J9Slz6K0SnHJcV8NnfeOIWOLM8wr
 3g/lBl2S8H2eMFXMDR4GzaWT77k7eEBDHonbPx0if4qPJNaQxOk4HMBjWTofdL9Q
 EdfOS2j2GWCfuBCevmpycyNsRuyvFyv0Ir1rhgZmhpwAqH4/h79bQJbMWneReG5n
 RmvCuOb6S8WXZSLYQsvqdpo2yYw2qROn/fhZ6EWgKR7mZ4YIx4vcOqCV7sJrRJRb
 Gxm0ErtnmGj5PObZUQJOXxthlHar6huyU9izlPOBFussWGqilAEUpBg02qKcxmqY
 kynNc15u1qc98pwMQ31ow==
X-ME-Sender: <xms:ARi2Zzw6rXuqtEmzy_9lguGBorfVYp_k0vX0tW8gItmD4DKVnW_rsA>
 <xme:ARi2Z7TPWUrfCn9I-XY5b0aTDz085BsNuTsVYiMappL-y77hIQnYnOYGjp2kqCGs-
 U1usNODwUW0I1BuAQ>
X-ME-Received: <xmr:ARi2Z9V_KeKrSOjgVN6QEKsaPIn3Z1f86jWlZJydP6plLmdTfYYx6GpkwlzKdR0u3piVX_PzprcS8nuhJzZPLsmDCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeklecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
 fufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgr
 lhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrh
 hnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehkohhntggvphhtudesghhmrghilhdrtghomhdprhgtph
 htthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgr
 rhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:ARi2Z9g3xGeUDYQFzGwHC6xB9wXmvU82sKcfOjWQHx_zKFjWeekCYw>
 <xmx:ARi2Z1CbG4Aetq2_BiDtVuzU_20SFQ1sc5BcioVTEmda7IHWUFNyUA>
 <xmx:ARi2Z2Kd8Wdm9hM1QuYOsd2JppqEvcIZtzCl9l-EzpLcZSnqXsRyeQ>
 <xmx:ARi2Z0CgO9p4TKmh3baYN5JZEdb0h1fZolGABHDV3dZNl56jY5R0HA>
 <xmx:ARi2Z0ONt_l-66skC4AORaJkeUaCNz_rGCkpk3g0AnwYA558vGaGGihb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 12:42:24 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ben Magistro <koncept1@gmail.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: Link custom libarchive meson support
Date: Wed, 19 Feb 2025 18:42:23 +0100
Message-ID: <3484257.VLH7GnMWUR@thomas>
In-Reply-To: <CAKx8PBic6QVBP2ntcke_mxxjjPmAtGmMY4YtSN0gZ5wmjcfTRg@mail.gmail.com>
References: <CAKx8PBic6QVBP2ntcke_mxxjjPmAtGmMY4YtSN0gZ5wmjcfTRg@mail.gmail.com>
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

11/02/2025 19:46, Ben Magistro:
> Will acknowledge this may be more of a meson question and less of a DPDK
> issue but things didn't seem to work as expected and had to tweak the
> config/meson.build to want to start with the DPDK team.
> 
> Our project is cmake based and we use fetch content to pull in our external
> dependencies (eg dpdk, libarchive, etc).  We recently noticed
> (rediscovered) that DPDK was not linking libarchive which causes the OS
> provided DDP for the Intel ICE based cards to be unable to be
> decompressed.  Previously we had some additional items installed that
> provided an uncompressed DDP file.  As our project already builds
> libarchive we did not want to install it at the os level for inclusion into
> DPDK as we may now be mixing versions within our application.
> 
> In our cmake we added -Dpkg_config_path to help meson find our libarchive
> build (it is not installed as it is statically linked into our app).  This
> worked but did not expose the include and link directories or any libs that
> may also need to be linked from the pc file.

I don't understand this part.
It should be sufficient.
Are you saying your .pc file is not correct because not installed?

> We had to make some changes
> to get those added and allow things to compile cleanly.  I can confirm the
> changes here work but feel they should not have been necessary.
> 
> What is the correct way to link/use a custom libarchive (or any dependency
> for that matter) with DPDK?  I've attached the diff for the meson changes
> plus the generated pc file for libarchive that we are telling meson to find
> with the pkg_config_path parameter.

The correct way is to give the path to the .pc file.
Please give more info about what is failing.


