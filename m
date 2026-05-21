Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A279CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 14:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4CB1402B0;
	Thu, 21 May 2026 16:12:34 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 34F024025E
 for <dev@dpdk.org>; Thu, 21 May 2026 16:12:33 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 7DC89EC0071;
 Thu, 21 May 2026 10:12:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 21 May 2026 10:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779372752;
 x=1779459152; bh=8AExIpiP/ykCshoKukk1gpw+hTI0xLbP4QC7v4z97Ks=; b=
 PxWYi296ffmaFYz8OOfWv0Ev3gkPoll73mTh0Jf9sumCyfWk4SRZkpwq4sAyfrex
 mJ0oR9QUQ7RIfHdMRBfI6Bhh17qp4DkDQn2Eyz8NWbK4xQh14CgJdaM1nXyvi/iA
 ZEDDzVn8IIdmFW84KuCioatGeHCk7R0CceFbPUgrOt9HqvbztqYm53DJoTHspdM6
 oWR3iOpMdmWlu70Qp3S/OU7Lqhx/EO3wCeWHU0fvDYbjJWReegkgZzmj49CUh29e
 //w6iulQXhVWw8IEO5EGOsweEHubnybz+0U8ufvFzurRCsbdek2z271dsA9zfjRG
 6vlOYe89JBhk3IhM9eTnfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779372752; x=
 1779459152; bh=8AExIpiP/ykCshoKukk1gpw+hTI0xLbP4QC7v4z97Ks=; b=b
 FbC3CWi4CmR46uGC+4VPPfIgszPAir8oaEZQ1MHChhpUvyRTQi51fdN1X+ys4v3o
 s7xXLNEUtUitWmeqj3nqsHxFwP6Vliw5T6Jc7XXcwxo8jro92rVOgq5f2sPQENxs
 r4eg0TJEn5DOk+tdUlRuKm3xMGmuU0nMO9Gb7L37Jsf0lT65FNKuhSMqF5GlHal3
 jnZBZcGbmSmo13GHmVVC1HvflGvK2j4F14HM/dE5AGPpvuGWVScq/kzCPZ+QyaPc
 bn0bMBw26QMG9qtZtrOULyL+qoJNeqEm3aVlOmNGeSwsnpyzrlLB+ZmUBuVuO3W8
 CuryGWcaLhSXdBvmGIYzg==
X-ME-Sender: <xms:zxIPavtNRDmBK0sGzZWRhYSDX80OXOs52mdtpKZNCvWU-lkw6VPMcw>
 <xme:zxIPakyhIOvdjvymiZiHgANrBzNp64-WjdIshceGpd1fhoI2VkZKvCTqbVjNdikbS
 acoIOkYNXEIsTx0ha7uYRUlDCV2Yf3WIAFKekSvplDQGQavySh1DN0>
X-ME-Received: <xmr:zxIPah6oc-Ow7Yu1uZOGz4x1U6fruqd6Uiv1QzYyoTVd5mzdNWVVknbSddNq-F6la__im2ZqxxVMju3MekeBDpS_Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegrtghonhholhgvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:zxIPamWAw3IAVvQu-7C0nkGCQoL5x_7M18XvzQFawsblJ92oo5JUBw>
 <xmx:zxIPal1xMqqXEtz0vgslENiV2FRr6gBQB1E5ug7jJ_l7H43jJV8K9A>
 <xmx:zxIPaj1W2tmdBAzR8l7MIjq1oF419JoDkSq1D4r6MSzviw_EJmTj2w>
 <xmx:zxIPao8BD7yyyv1UkmSrCOzwkCU0frW9p5nTSHpzRNVJMvJTukd8Gg>
 <xmx:0BIPavwW1i8nOzUXBuf_M3FNztBHnaJQq3OTfrmj-X0Y8Fgh_X9VJBJH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 10:12:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v14 0/6] Add AGENTS.md and scripts for AI code review
Date: Thu, 21 May 2026 16:12:29 +0200
Message-ID: <F6xl1sKHS3i-gBdz1W30dQ@monjalon.net>
In-Reply-To: <20260414211012.951613-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260414211012.951613-1-stephen@networkplumber.org>
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

14/04/2026 23:08, Stephen Hemminger:
>  devtools/analyze-patch.py              | 1509 ++++++++++++++++
>  devtools/compare-reviews.sh            |  263 +++
>  devtools/review-doc.py                 | 1184 +++++++++++++

Should we move these scripts in a sub-directory devtools/ai/ ?

Still about the naming,
compare-reviews.sh is for analyze-patch.py,
so I suggest this consistent naming:
	review-patch.py
	compare-patch-reviews.sh



