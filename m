Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D57CCD192
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:51:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C3AC402D1;
	Wed, 15 Oct 2025 14:51:36 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 7906E40273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:51:34 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id A3B771D0007C;
 Wed, 15 Oct 2025 08:51:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 15 Oct 2025 08:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760532693;
 x=1760619093; bh=5ueQuRSxZV30JrI1c9ZjjNI7mAeJt0Z+let23FerHPM=; b=
 hpxcZWk90jYEPKYc+kF3WlHQxZ1TP84qgSP53igMmvMNm4mTEWc6u3Z3+RE29Fbm
 3FlpLnNG7vQLJGdNX70B4p7tENX6cQipnTjpkfpZFVESq/EL5tpQus/5HXNkf9uD
 Qcu58FjcaZOrxvntSSO+UeakSquwtWu66j+MiVkGq1w5bA/rrAap4HoIYBwrOlLd
 vjTOyTPFXAMku3+yezVrv6S1qJNyKhfurN3MCJRF1LyfsmjKcEbg5o7K8hJ7EkgF
 am4Ykir9JflfNwqMVI9ZIw81C8TBpySRwvqQ1HcjxRXpgc0j9+XUkkdJJD/dtWac
 1oztZHZqOzJESJKtq9oE4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760532693; x=
 1760619093; bh=5ueQuRSxZV30JrI1c9ZjjNI7mAeJt0Z+let23FerHPM=; b=d
 /fA5oLGVJ6HIx8EiJGjksb+jq0nHPf73XfBeUfJ+3Y8FDwi1GVsTR6jsAKJf3NAt
 5IqbuztYhzllH2rzCfbi6qa8TKVXostKTcoPR4JlxhP5fc88ottFAuH3qoJLlebT
 DBANTqXEdvQWgnkGsu6y2XLuROb/sKYmZUFTTOJyX5PChNBfTSkw1weE5UUN29DK
 zbym3eV5syljsuDFMI4oLF62t4E1VbUR+oJFV2cWJTbo3hOKHFXfAGrvQ8Sl4Vfy
 ASeRPa1aMA8Qb7CopZkH/fzTYDGSlKWd4SPmnM7GM/MgivPhNhNCX8hnYQfAQ/U+
 8eCg4jo0ZTAWAA3t9mAoA==
X-ME-Sender: <xms:1ZjvaA04uXGFqu-eqbdayFp7u1c-wlEehnLgaIvZRbmAEDekHbr1-Q>
 <xme:1ZjvaB9yYeHLewXu6iHCIbcGxC4b9MrI0xtgg-210IYsNmixC59X8_XQ2tfM1nmxb
 TLOZwiV-90zttRad_0HHvIBnOo3gCWAUzs9fHvXfxc01X3lk1ZeaQ>
X-ME-Received: <xmr:1ZjvaBMErDxbGNVdHAo-vOVuHxug79mZu_6y3HIYncHfxoHCYUtlp8kt272B7HPfZgMezstLGyjieHFfalelXaveDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefgeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtth
 hopegrnhgurhgvmhhuvgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphht
 thhopegrmhgrnhdruggvvghprdhsihhnghhhsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:1ZjvaFf4CyKHG-4Hohw8XQLneP7pnXjaJPJhs0tiPZn8QpIeG6tLvQ>
 <xmx:1ZjvaAWkgNdwaOtys2dwI6vZj-yAhRV54qHwzkqcqX1SuluZAeLV7w>
 <xmx:1ZjvaNituuPAv52IOi3n_-yAJR8b2TwOeFUbEfal3KarOaUo-2yMjg>
 <xmx:1ZjvaP9cBZiJmLk1verJOwPyAb1Kuanl3giDd4UtG5-nqiHCx5KciQ>
 <xmx:1ZjvaB1lMlDR6HjrK2zd6FpL7Z4Phr1Dv2GKNQudYUJeq8Tc0TcGicT0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 08:51:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, andremue@linux.microsoft.com,
 Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v4 3/4] app/testpmd: allow multiple commandline file
 parameters
Date: Wed, 15 Oct 2025 14:51:31 +0200
Message-ID: <2963163.BjyWNHgNrj@thomas>
In-Reply-To: <20250731160041.914837-4-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250731160041.914837-1-bruce.richardson@intel.com>
 <20250731160041.914837-4-bruce.richardson@intel.com>
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

31/07/2025 18:00, Bruce Richardson:
> -* If started with the ``--cmdline-file=FILENAME`` command line argument testpmd
> -  will execute all CLI commands contained within the file immediately before
> +* If started with the ``--cmdline-file=FILENAME`` or ``--cmdline-file-noecho=FILENAME`` command line 
> +  testpmd will execute all CLI commands contained within the file immediately before
[...]
> -   ./dpdk-testpmd -n4 -r2 ... -- -i --cmdline-file=/home/ubuntu/flow-create-commands.txt
> +   ./dpdk-testpmd ... -- -i --cmdline-file-noecho=/home/ubuntu/flow-create-commands.txt

These changes belong to the previous patch.
I can fix it.


