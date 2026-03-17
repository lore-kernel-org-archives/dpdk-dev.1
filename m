Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66868F33809
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 07:56:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4995E402D1;
	Tue, 17 Mar 2026 08:56:53 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 6612340270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 08:56:51 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id C0F78EC00AF;
 Tue, 17 Mar 2026 03:56:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 17 Mar 2026 03:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773734210;
 x=1773820610; bh=aF3vVZhcefOV/ikDndQ2oZGeYQbbQaEg4vaHR0XDV38=; b=
 Om7DTxtSnmNW5tYo+Ou33A/8wDj4sLJJuv8mmKu5UWA2FGF2dbch2mf3JZwicyli
 u2Md4IEnvrHcOVYP08jULIWOF04tYKeoIqI50NeI+pKPfZ6pyze2WzMWERJkQYNS
 jtW8ylQBBPItHIH+lpcBtxIQID9hvNLzwauDxMqr/0O7/JzRwSKaDSaEFEOYXavV
 pTbvTH/HzoT/X1lV80ZWHFyYUnq5eThGnp/ecba4GFkMl9b+S+hxnApcRN/87ttb
 7OMiFeygUeVbJ3bGpGkA+OWS1Vu9sKBdW6aErvJClTi3p1MVct7tsizuSuF1W7hS
 kKlZVx+dUjGHCsVRA9uEZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773734210; x=
 1773820610; bh=aF3vVZhcefOV/ikDndQ2oZGeYQbbQaEg4vaHR0XDV38=; b=j
 vFgdRsRtNoD/l8CPWpJkayvYkwjrEDeJOd1Q1pBcEXLP22equzQ2DvAbIqT5PZ5q
 ZruYZ10S06yDeQP4hNMu1UxZNLziqms4a0aRqLQaQ+ZZkywnOibFEFXGwXgwHJJ0
 Pt0pglIGZtNQ7iA+36PwTppREPvuRC6r5Rneed4tHmxws+Q7bUNKBi+EaH++uBlv
 4FcqNe8m8IC0sCmziHwkPYM6VFPEh577W1S6PCCGKhVEKMWd/4C8FerWHZ5Upmgs
 QQnk2Prs4Lloj5a+J3WANPHWGpvPa1+rb9GA+9S7eW7k+rXb067t5EJEj6qJ27y8
 svLBIDqgAIkDVNY84Qw2w==
X-ME-Sender: <xms:Qgm5aXxtF44WQdw4T0mMpuRH4hGcQnxc6ESVb5KNvN3ZR2boqXCofQ>
 <xme:Qgm5afu7SBQmVUIvwmWL5EpJGJG7aKhFiYxIPt84U-762t4CJjNcVF_E_EA39cCQN
 7W5_oRoykfCKI-X9LlLgGExdx2yzdeXyiqWNjZEBZLaPTKrqNIQoSo>
X-ME-Received: <xmr:Qgm5aSCIRrpigatA9Qa5-oRrph63nwht9JJ7MZw1jQqzaun4gepfSAQFy8SpnSXrr1KLyAdAat2PUZ5cBSgjbQG9rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtjedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgshhgrghgrvhgrthhulhgrsehmrg
 hrvhgvlhhlrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhm
 pdhrtghpthhtohepshhthhhothhtohhnsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoh
 epnhgurggsihhlphhurhgrmhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhr
 rghnkhhumhgrrhhksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhkohhrihesmh
 grrhhvvghllhdrtghomhdprhgtphhtthhopehskhhothgvshhhfigrrhesmhgrrhhvvghl
 lhdrtghomhdprhgtphhtthhopehhkhgrlhhrrgesmhgrrhhvvghllhdrtghomhdprhgtph
 htthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:Qgm5aZGcoGNw88MNiKrHAHOMZASckxjdEB0yje9XuABCPrm_VeV_Rw>
 <xmx:Qgm5aaAoXz9Z6lpBbDdGJhRiqc4XiQWPDvruAQhZ2maESBhjzGFeFQ>
 <xmx:Qgm5aXkN-d3m3AgkKReeotU5kF-tKdGbdgnYsrpnJ8PyyoD39Xw_Jw>
 <xmx:Qgm5aYNKz_ocRptxU0rTqqqSMdFaGJ2ZbnqJj8wt-AAz-f2_RnoyXw>
 <xmx:Qgm5aRSPXGFioCp650atR6-VHbiyTVJLDTu56nu8uD86C_knhUmoT4kC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 03:56:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: jerinj@marvell.com, Shijith Thotton <sthotton@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] net/cnxk: disable template on generic build
Date: Tue, 17 Mar 2026 08:56:45 +0100
Message-ID: <2287480.NgBsaNRSFp@thomas>
In-Reply-To: <20260310081431.67199-1-pbhagavatula@marvell.com>
References: <20260309101640.32391-1-pbhagavatula@marvell.com>
 <20260310081431.67199-1-pbhagavatula@marvell.com>
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

10/03/2026 09:14, pbhagavatula@marvell.com:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Disable building template files for generic target
> to save build time.
> 
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Applied, thanks.



