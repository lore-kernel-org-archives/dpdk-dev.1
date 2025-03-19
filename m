Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18562C28B2F
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 02:20:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0545402DD;
	Wed, 19 Mar 2025 03:20:08 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id E7876402C4
 for <dev@dpdk.org>; Wed, 19 Mar 2025 03:20:07 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 1295C1140238;
 Tue, 18 Mar 2025 22:20:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 18 Mar 2025 22:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742350806;
 x=1742437206; bh=7qTJdSkM5NcyYNCs90XromkZKxHvr+elpmdE1rpovIY=; b=
 V/7yyDoBHBvTZ/QIt7yhXOn+PW3uDfkvEeRXVnXvdVuubVpNM5kc9bn0ngq2ks81
 HokvxVeulFPMELCt56BFMzbAAmGnGMqwBcK3vZyAN3VgGUqCuIvL5THdmEZ/k0K2
 F0Q6wV6C99gH3eE1YwIm62zHH7h3DFhrEOAnnJ/3IEUrcUsCjL9iudg+NLv3KfKY
 et7Ik/6x13/6oBtMmF8mTtQo0RVDRyqMJdHzfb3uub84X5EU0DR0s7l4se6c2HFN
 VhB3e/ezFman+FxGjvD2LjEOW+75c4qJru5b45/BHPpq2RVE+xlQN1EZHDJMGoYU
 Q51WtODrB3e1ex/2etzIkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742350806; x=
 1742437206; bh=7qTJdSkM5NcyYNCs90XromkZKxHvr+elpmdE1rpovIY=; b=K
 9QftnKaFRHzGi1asiEOGmyazQSkVBFPWGBb1JljhssoJ6LA5W2lmrJUks+9sb4Qw
 sQvq/m0l2tPfrk9Y4rTN/GRHfG5qqVoNnTvfU4WLYAzEN3UfMuSQBybafjoT65pQ
 tNLPPixputGW1pkTIbJ4GqmVfWfdzs3cm8/ca6/71yaY9Pwsm+U3FA7Wib+ivKC8
 AFic8Y/swWyrUNV3lMFvQvBpmGpnYYe7Uekoyglhk2EIIv6GpvdoI6P7fYQQE+KW
 LJNhd8d01OU3jA6Og+uw7LHoGZEFv3ZL9zdjY/DjtZiBkO5CW89CyBFrgNMaBOH+
 aS+JLXe97qvJOsk1al7zg==
X-ME-Sender: <xms:1inaZ3b8q8hWpvYiQjudzF2GZFOfQ4NTghr34kU0C7eqycdLJ2oEbQ>
 <xme:1inaZ2aeyk588VpM_ZW2ERuuuF9eex160ICRoa-eiweTs1LpJZ8alQv20SkM7C-le
 bGKG824fWQlikkIfA>
X-ME-Received: <xmr:1inaZ59t_Qc9DD5oxbayTP88-lbv1uZN4BPGup46p7xoGfha8OgvsWwN-qATw3oE0HvA1vZrvIGA0z8iFKOhG2l3hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegudduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsg
 hhrghgrghvrghtuhhlrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehjvghrihhn
 jhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopeifrghthhhsrghlrgdrvhhithhhrg
 hnrghgvgesrghrmhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushho
 nhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:1inaZ9ry20xR_PT3-RFc1WgI34hjM7aqTYRI7t8KZGQDvlzLw1srGw>
 <xmx:1inaZyoHEn_PThCyStS-4Z37IBqIvOzHUGkIq8dUZ9tE9-Is079kmg>
 <xmx:1inaZzRlu9TRnMi_3bg-mL7EiMXnKobdudeltTPrn1HaAJS5zHWynQ>
 <xmx:1inaZ6pgRMfccsvqfZEgenMiIg7-rHX5FO3KMoLsSAUFRPT7he0uAA>
 <xmx:1inaZ_AMsjQCQtImqBnv58DxVNZlHqUtet--7I32qhHyoda8vOnSmkUl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 22:20:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: jerinj@marvell.com, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] config/arm: add crypto to cn9k soc
Date: Wed, 19 Mar 2025 03:20:04 +0100
Message-ID: <4526193.B0Pyx7erxp@thomas>
In-Reply-To: <20250308090130.4696-1-pbhagavatula@marvell.com>
References: <20250308090130.4696-1-pbhagavatula@marvell.com>
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

08/03/2025 10:01, pbhagavatula@marvell.com:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Add crypto as extra march feature to cn9k soc.
> 
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Applied, thanks.



