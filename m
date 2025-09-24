Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1830BCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D8AE4065C;
	Wed, 24 Sep 2025 18:50:56 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 700DF402D8
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:50:54 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id AD2F71D00183;
 Wed, 24 Sep 2025 12:50:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 24 Sep 2025 12:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758732653;
 x=1758819053; bh=DvBEDDmD7aqGbBcMP705CPGFDIr1ELHpCvaHaHr8H5U=; b=
 bfM/2YiXPMK92Gk/ohLNeZIMiEc5zYoU7xwkMRm4+6TXhwJ8W2g5GX7mC26+9j0H
 /VA1+t5t7ZlIbSQOw7SYXVqbIWeOoD0xZSQ694xN5hFYrZu5C7iWlwC4bNF74A/t
 sXEgxwObjhXoCcFMKS9NR42Z6GHuDSi4MmWoiINitLZTkMvVcwY9ffTELSKJFk2m
 bfT8SyK+c/1Yarnf2Oqu6psdm8dZd2ewL/7/mywSHKFH5y3Q0tuwEcbU7EdfmhfJ
 eVIJ23MDYVVyDbwAjErT6ZS8YY91ZxpX4JjUq+tGk+JnP4W9vlZ/HtQLyhbpjHeM
 9jbdZcBbPvvnZZ6+/fVuUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758732653; x=
 1758819053; bh=DvBEDDmD7aqGbBcMP705CPGFDIr1ELHpCvaHaHr8H5U=; b=X
 Oz50/IwIcT5dgdd/2LrjY7F5M+VneiFm1011ke8AOVhRrubnVGT7er0d20OHdGyO
 wVJrtNLIdqJW5IiNr9/rTCMNIGx/02vJtjjlnLsHkKU7LMzPeVtm8qUqHciKcp2L
 A8C80wS+FgNe0OzHeavERLvbCDns9XrPUDo3361Suze5Dx5irzYPbW7fV4xqRp7Z
 rEuS5Y5sSA6kGwJrjhwpAIcGZl8DHPo+hMSxc5cEiLdgekF+06W6AMo/VQ2fTqXW
 bI34MgvZmXdkGUebfmfIEHvt7Y71vvrRDa8SoajyePixUO219UKtW4s28mR1fagj
 Heh/CgyzjoEkzFYl0kNZw==
X-ME-Sender: <xms:bSHUaOiIVl0r_XziF7_D6EDhh-AYSFPsBiWwZY77dshqEmIVZenAeA>
 <xme:bSHUaLWnY6TkneI__Ri1btfnNye7n3aExC-ZzFjsZ2qERDzof9gMafNcHmzvMVvNm
 dAUVwzTL162yC1GUOh7be1yUiyOgGLSHSOUnaS7-8tHsiKcHuWiRA>
X-ME-Received: <xmr:bSHUaI0P9ibytTCWdDfb2UREHj9Cfzywh_ge3XfQgFFT97mzTEhVMpyVPiKh42QqJZEZIBSrvfjG7AXN8aMWBA__hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedufecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkjghfggfgtgesthfuredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgf
 dtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:bSHUaJHsTB1VVqoPzinnw6ZLyj0xPK_4Lw__l9qqa99JajdRIdbpBg>
 <xmx:bSHUaOj1P56F-nELrzQTbSBSKasFhAeCNBQBx93dUf4jTRnIUuyNdA>
 <xmx:bSHUaM9s5OGOEOeII0iLMskiuTHReimaXrtdXhyJkjAbr3QWEDSs8Q>
 <xmx:bSHUaNrLniK1iWSaRaa36_Lkiibusb4ikwk5uHGZjQXo2oQeNlbsLw>
 <xmx:bSHUaDJbcAV5KAmTa1Wjr25-uxvdI_zGLkp0rt6d-yOzklLEgLMNIctw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 12:50:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: Re: [PATCH v3 0/2] lib: fix AVX2 checks and macro exposure
Date: Wed, 24 Sep 2025 18:50:51 +0200
Message-ID: <13998226.VsHLxoZxqI@thomas>
In-Reply-To: <20250924154641.2684705-1-thomas@monjalon.net>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250924154641.2684705-1-thomas@monjalon.net>
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

24/09/2025 17:43, Thomas Monjalon:
> I've found the AVX2 function is not used in efd library.
> Then I tried to make AVX2 compilation simpler in efd and member libraries.
> 
> While at it, I've hidden a macro which was wrongly exported in the API
> without having a correct prefix.
> 
> The v3 does not have the patches removing build-time checks:
>   - efd: remove AVX2 build-time check
>   - member: remove AVX2 build-time checks
> because I'm not sure losing inlining for cleanup is worth.
> 
> Thomas Monjalon (2):
>   efd: fix AVX2 support
>   member: hide internal macro

Applied

The 2 other patches from v2 could be reconsidered later
if we measure that the performance hit is neglictible.
I probably won't work on it, so I let it to anyone interested.


