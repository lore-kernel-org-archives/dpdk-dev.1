Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA46FF33817
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 08:51:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECAC8402D1;
	Tue, 17 Mar 2026 09:51:37 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 946E840270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 09:51:36 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 43067EC0176;
 Tue, 17 Mar 2026 04:51:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Tue, 17 Mar 2026 04:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773737496;
 x=1773823896; bh=DMYQv2lQqiJXldvM9iBfkBffGzohmxzDoxtyvazrLfc=; b=
 FXpl099BhSu20dG2ZWQCSt3NYtImxUcWLsso3HnjDnEktN1HzMCkwRbMa1IH8LVZ
 x66/kWb/92frqt5WxiloHjT+2v/U6HWr/45F0QMS9LLV+OcEdksmrtV4u5KnOSOk
 ysamtS6XCxJckKCyBeSNXLa0mSpTfuDe1qBd0gKxI1atNNuvB56OU0I4WQ2REMKC
 gMGKL9F7UfCnX9UprmlaE4RQFwWRWkPY/YqgOcHL5+K3IUznP9FddgtD0LhGyeST
 c9roz0+lgeo1izGZt4XGIPh/KLzRRcE74aFIe/CRYOfkSHNMNeRy+PaNXv29hmty
 7xUTJEatx4aPL5pvhzizOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773737496; x=
 1773823896; bh=DMYQv2lQqiJXldvM9iBfkBffGzohmxzDoxtyvazrLfc=; b=b
 +66FPEnef2v6Teeu0vGhdDTEMu2XuIeutFR6jQTFCbEN5jpoQJFXSk6vpaCIvO4M
 vEfHQaVYsIE0jelrQb6qxtnBmXLbwyOTeHl1av4mwlB19H9Tnvkdapnc+IDnMY5J
 /uK0ORKRMirIUr7nrOwEgpLczVyXOawpii285nQ+/kDFTIIXwLFNFnf+LllbozPK
 3spwVzMUnCZ6H/+DVZ1ZvdXEGGpdF/UjQlvRmjE6+6T/Di8HxbIociIR2HJC/F2s
 W+1MyFnqnfct8EPVjhu6nsatjPKxPzRekmDjPjpIy/crvElXLwymskewKl4W1gXl
 Ook23ng2V4/i3XRkjneig==
X-ME-Sender: <xms:Fxa5aWQCz3RSf4vtNAWiWC9HZmwYgs5QPkCfQ4k_N8cibG5J6ngTNA>
 <xme:Fxa5aQHIEUIQEysVeFHa55x4dKSXfKgMMbjOBnZYVreF91qCZt258tdouO1bgbmKR
 2jess29vJc1HXbBf1PqN3KqsWsXJPAOLVlbGAYTfmbCnoeObJIUMw>
X-ME-Received: <xmr:Fxa5aS_BwzXRipYw5KS4tOtSHNJACAWH7cUt7jkwl2kq-hsY58WmXeYF5LcVQ803fCRgLGIRI_Ysm958Hf1G-fbleA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhlrggsshdrrhhu
X-ME-Proxy: <xmx:Fxa5aaJyD08OI0JcIyYIq2SpRGeLzLtJCfx7aiMT9awutA1Rbndfdw>
 <xmx:Fxa5aVZjZ-jk1MbpMUsaEmELCpaCqIQO1WqiuN1hf2YT-0Mj9Pa5fw>
 <xmx:Fxa5aUITV-cgsv19SeDI4hmEoZKInknAPCP4pGSxMVQxIApOTMPJ8g>
 <xmx:Fxa5abD6mSKJO5gJ-arC3ky3OAVInROzjkhNlN6D1miuGBOy-SGjSA>
 <xmx:GBa5aS4-326BUXOjcRvBxeHxP7s9qVy2Kv618sk1jsy8EXL8Mao8Jeai>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 04:51:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3] mempool: simplify get objects
Date: Tue, 17 Mar 2026 09:51:33 +0100
Message-ID: <9641618.rMLUfLXkoz@thomas>
In-Reply-To: <2d2f055b-b833-4ca5-a9ba-e40ab8c9cf7f@oktetlabs.ru>
References: <20260120082049.466224-1-mb@smartsharesystems.com>
 <20260216092750.94137-1-mb@smartsharesystems.com>
 <2d2f055b-b833-4ca5-a9ba-e40ab8c9cf7f@oktetlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

17/02/2026 07:53, Andrew Rybchenko:
> On 2/16/26 12:27 PM, Morten Br=C3=B8rup wrote:
> > Removed explicit test for build time constant request size,
> > and added comment that the compiler loop unrolls when request size is
> > build time constant, to improve source code readability.
> >=20
> > Moved setting cache->len up before the copy loop; not only for code
> > similarity (cache->len is now set before each copy loop), but also as an
> > optimization:
> > The function's pointer parameters are not marked restrict, so writing to
> > obj_table in the copy loop might formally modify cache->size. And thus,
> > setting cache->len =3D cache->size after the copy loop requires loading
> > cache->size again after copying the objects.
> > Moving this line up before the copy loop avoids that extra load of
> > cache->size when setting cache->len.
> >=20
> > Similarly, moved statistics update up before the copy loops.
> >=20
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20
> Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

Applied, thanks.



