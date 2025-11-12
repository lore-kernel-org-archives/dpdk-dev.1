Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C10CD3429
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 17:03:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AEF640DCB;
	Wed, 12 Nov 2025 18:03:09 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id C518340687
 for <dev@dpdk.org>; Wed, 12 Nov 2025 18:03:07 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 37812EC0283;
 Wed, 12 Nov 2025 12:03:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 12:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762966987;
 x=1763053387; bh=JNZl0PbEL8aHUUZ6430c+xUlWKsGuUEo2qORIT55ALc=; b=
 qHldQ4IL1lsnapXk19iaLb5Uh81lJKGZq5YK4aERk4VKrRlWXorgDAO47QPJipTZ
 MVx8nfLEhdJ08f3gicpbhaqc26+k5Lsc6xjD60HUxB2xSSUKVSdwvtxwooUI9oXr
 OURS/AmcY658XSf1pwglrbSU/d9WybpwHmT+Ps5Tg5hOyYPR5Rr5gAYOKMa2+lvY
 1FtV87M4Ehzttt+GrGqVGfz5xOq/iPkU27mFb29ZkAIvUbwC6TvZPMD0C9Qht0RV
 8TGKzgQloEErJv4cuaVzNdc7JKk8Nnimt2lOTvhQD2u0qJ9O3Kx+/WQwqwRWEVg4
 Q3uGdENXu0R2fFf+gjOe2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762966987; x=
 1763053387; bh=JNZl0PbEL8aHUUZ6430c+xUlWKsGuUEo2qORIT55ALc=; b=p
 8PhmCcduOCfktDxG0ZTstQ63e7TfUuiBTT6/gxawvTCvPZcw3sMMa4jZ99laxach
 rBiSC0wpgeWG/Mj/C6JLcenP5fmqHUxCFffHpDeEReThw6SnB/F33lgsn3+GAA+l
 OoOI/R6UYwo6xrzgJVujNUijRsddT7SMmmJsuq1U/x7aF2iStpMMBwYcmCcAyaMC
 CtbkiBUN0N9shuvGHfvIPGAtfkTkiUrIOa7jlppK9Q4da8qzVM1UDT3G/Qudd4TV
 1hqIvSq73yIm83HnqqfiFJ1e4HxtK13Q7Um0jF4uG3qViLt/djIotafnB0w21jiC
 C3uwMsjlnslXr/uxCdLpQ==
X-ME-Sender: <xms:yr0UacwgsR2NQLP_bGwOi2P4sZVihIa3YAFT97els7oE7I0twwdwvA>
 <xme:yr0UaWTehcTUMuKTU3x6j2zDcdl2sI1il8-0bIoClN6EQ4RooYJYgBCyQKnKokhh7
 ln5OVu6yQii1rAUpByChfz1XboUPmSXepGyyXzjbSQbNAkL7-Mpug>
X-ME-Received: <xmr:yr0Uab9-RuPOB5NuxeG49YCLdnDurOK5zdxHQjDwy83Q-4UKIHXHVXBU-PDr9bRCh1QohKPU-ShBOG4dkn7aYtoSpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrihhlvgihfheslhhinhhugidrihgsmh
 drtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:yr0UaVra0bwyUTPi2dUMoRvsPZY6k6Oq0DeKd4IbBLHPK2xKFUWl2g>
 <xmx:yr0UaQlSRTDzF-w-qQOkWam0R4y_OUHFAdNHtxK-wWvEJ9nwBho0Gg>
 <xmx:yr0UaULvG-EO5FLDX31zu3aXRcJYFwOAiUaAuYgyqvwW3N76T2RWKg>
 <xmx:yr0UadzdRpo8fwIy3GlXmSZFUa5HqP0mD766wy3YFmaIilj_2sblbw>
 <xmx:y70Uad0Q05UcQDRkdUEr2aLhVkEYzfqkP5N9rXKVjee6r304gxgMW6mp>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 12:03:06 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org
Subject: Re: DPDK release candidate 25.11-rc1
Date: Wed, 12 Nov 2025 18:03:05 +0100
Message-ID: <4265389.h0BymrIErR@thomas>
In-Reply-To: <110ae6b9ad494456a4df46322f211eeb26baf7c0.camel@linux.ibm.com>
References: <24022415.5W6oEpyPa8@thomas>
 <110ae6b9ad494456a4df46322f211eeb26baf7c0.camel@linux.ibm.com>
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

Hello,

Do you plan to contribute these test infos in the release notes
in the section "Tested Platforms"?

Thank you


07/11/2025 00:09, Riley Fletcher:
> IBM - Power Systems Testing
> DPDK v25.11-rc1
> 
> 
> * Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
> * Basic PF on Mellanox: No issue found
> * Performance: not tested.
> * OS:- RHEL 10.0  kernel: 6.12.0-55.9.1.el10_0.ppc64le
>          with gcc version 14.2.1 20250110 (Red Hat 14.2.1-7)
> 
> Systems tested:
>   - LPARs on IBM Power10 CHRP IBM,9105-22A
>      NICs:
>      - Mellanox Technologies MT28800 Family [ConnectX-5 Ex]
>      - Firmware Version: 16.35.2000
>      - OFED 25.07-0.9.7
> 
> Regards,
> 
> Riley Fletcher



