Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EEBCCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 20:42:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9A31427D3;
	Sun, 19 Oct 2025 22:42:26 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 5149540DD2
 for <dev@dpdk.org>; Sun, 19 Oct 2025 22:42:25 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 6F4F41D0004C;
 Sun, 19 Oct 2025 16:42:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sun, 19 Oct 2025 16:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760906544;
 x=1760992944; bh=2C6nwjf4wxd8sH9JP79WyLNK49rXR1tmmw8r3fMqqCA=; b=
 P7JWVJP8q4ujRnUXtgTg0w+TEbz+T7j/vIu13qIJWfCMrYd5lKdjRTJHunvX6mRw
 lWQJErhjWynKTOA62Z/ufdM4e/FyCxcNQ6NtI/pjbgmVjv/2FQEpBVuHWLSZH/5k
 cPKLUMx9vYeeACLpQ46dBN+0guaohQUutfZCZ42ECq1pC6YIOofNGP1sGgDMh1Ec
 3jHIIKVRIrsd/HDvxuVM8r215sP1i/+wxQ49TGTvtY6TXhhmY+C4q/IuvLXLkuJt
 xcLiYafIbWzu11vD7vy5pZR5r420rjOR7fy6BTY6OEOb+z3bPpmm1JirLGEJGP0C
 s8iSQyiYz6jL6YQDZ0LxnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760906544; x=
 1760992944; bh=2C6nwjf4wxd8sH9JP79WyLNK49rXR1tmmw8r3fMqqCA=; b=B
 Jik45Z/+fPyU8m3fNFzJBWKnPedzAM+Gov+vkzPfNWQJEWR9IYBiHRk4fbo1Wzt6
 DhU+Cg+pcdCMCzNCSdZODa8fl8vWaNXQ7QTgGOzVl1nwtXQU1V+YsV1Sxj5v2YOM
 52AsczV/Dd5Pl6rzpbNoesszVNba2Shg+rXA9NrKY0MumRsLYmQX3OHByoE6bDwL
 CIlnWATkdiQprId+bHzNVy+DfpG/2DlGRoWn5tOPoTqe0FLDf/Uwg6s8wLyc4Oew
 oH+tFjUqyHmOV0I/HBnfalP5vMo7E3eicw6aD9cmBoWiWmrSX3NFnu/qCKkvR1B7
 pFyh5meDJ0AAFlQtrdmfQ==
X-ME-Sender: <xms:L031aF6-9gns2V70t8RMHUNN5GvRdNH6D_BHkejrSKehq9hC4AFE1w>
 <xme:L031aM_hDELbstyMX9UVI1hfmsyI1bXEyvT11zxEk8jDNy6gMZdj3StVil39stz7e
 y6gjLN3s7xRk0Vt7tgtHyYx6cB5dfezaX_y-_jSmRjaNz346Rr7IA>
X-ME-Received: <xmr:L031aMV6CtMv6nI8jwE2MQr2voaarfV3R6kXp1uaa6q8wQlMU489gvZZ__U7VQW1RM9gNCyZ6rPzssex67_wc_Jo0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehleefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhope
 gsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehk
 ohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtoh
 eprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphht
 thhopehivhgrnhdrmhgrlhhovhesrghrkhhnvghtfihorhhkshdrrghmpdhrtghpthhtoh
 epfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:L031aPo-yNfWzPBubp05s3k3Esl2uP7F5990Japr5p6x7_9hA3jHhQ>
 <xmx:L031aGkq3DYfg1IdGKO22-FtWJZ0h_N1_1p-YHIhny1GXWOKtXgzhQ>
 <xmx:L031aH2CjcXJlAWoeqlsqcebkalbobJ82rVA5TCQdZ4ZXk2O9JS5nw>
 <xmx:L031aLRr9xkmcFTRe-tmMxuCOV-YqVoI9oswdYVxqk-aLsMV9XgHfA>
 <xmx:ME31aIsnBtVPIwUts7Q3p71_dMITI6kFio1lgPBLdUtCk1J4iIFZMgw_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 16:42:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 0/3] mbuf: simplify handling of reinitialized mbufs
Date: Sun, 19 Oct 2025 22:42:21 +0200
Message-ID: <5540762.F8r316W7xa@thomas>
In-Reply-To: <20250823063002.24326-1-mb@smartsharesystems.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
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

23/08/2025 08:29, Morten Br=C3=B8rup:
> This series contains three changes:
> - sanity checking a reinitialized mbuf (a.k.a. raw mbuf) was de-inlined
> - reinitialized mbuf free and alloc bulk functions were promoted as stable
> - resetting fields of reinitialized mbufs was optimized, making the reset
>   operation write-only of the mbuf, instead of read-modify-write
>=20
> Morten Br=C3=B8rup (3):
>   mbuf: de-inline sanity checking a reinitialized mbuf
>   mbuf: promote raw free and alloc bulk functions as stable
>   mbuf: optimize reset of reinitialized mbufs

Applied, thanks.

2 notes:
=2D do you know how much it improves performance?
=2D it is adding (more or less) new functions directly as stable


