Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279B7CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 18:34:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34BDF402C8;
	Sun,  9 Nov 2025 19:34:25 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 50FB4400D5
 for <dev@dpdk.org>; Sun,  9 Nov 2025 19:34:24 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id CE225EC0180;
 Sun,  9 Nov 2025 13:34:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 09 Nov 2025 13:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762713263;
 x=1762799663; bh=7ty0V9KBjHoTRNDH2sXtcihPQriu6cdTi+r5NJNvUz8=; b=
 vT92143R6xkPFq+Iu3d07wiTO7cqbYMFI1A8MeJ1RyMMDh59R+nrGTf3u0515Rr+
 Y6Yz+ZthIUz+9lM6MxQk7z2qlXAng55wdiI1O8YxFWH+w0pML6sZxyvjnoUNCLGZ
 T0PDar68vqKV4Pr34RSwgkSeqa3frnSGbhYI7S11sEtf81JArBAP6+cR8r0cC+FB
 setgVJ1B5KEdJwh6j4v1Gc/STY5rThEefaTcutUFoUbAh69SCbbye+HNc06JR9z2
 HULQG5fKzDvm+DzUd7Jp/+qKp9SK4RIhIAFQ+nupLgSv5/nge9EoxUPWmyq7vg1y
 uzm7ejVO2pIN4TH5kMufIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762713263; x=
 1762799663; bh=7ty0V9KBjHoTRNDH2sXtcihPQriu6cdTi+r5NJNvUz8=; b=B
 ewq5L2zwooV7MXq8V0nUpl37PjIHw0Z0zdOa1m4cWacA+JFRzllFQ2TETG9kQjYm
 maW/bPjsoBCM/lPRL/Ky7aygcgyShSmFVhEOkzIq4ZN1g7HxxMMetvFcJeOBRLaf
 wg3Z5k3UWWD5W+2uLHctpfHADreLiypfAFtnOK/to2mLyJXSC/v/S+ut4Bjl4ubY
 R/Oe55gFLgj2ZAYjs7Wqic0hZezq8q/NwDCcb7Lcw/dlUCiACyHDaqoK5aSIb+CF
 zyMrC6TVhNL8NkTkOLGhszfTCx/KQBNfvbGaaDEjWLrgQomKBYnFm0EEFZrjNXaY
 6S90TLVIcbJF4RFSzX8DA==
X-ME-Sender: <xms:r94QaScesZVXvK1bafNe36fkOcjj8xEz8kVJGAKJxq0RRJIk44R2ag>
 <xme:r94QaV2TCVc8WcKSFgdC9V4FLeSWT1buPY131YPRO6EZTNG5X4uljvbIlK-45RIwE
 0F0D3t9Xldh3B6OXCIQsGLtaQljOr8R1c-Z2ykpufURnNjMbbicRbc>
X-ME-Received: <xmr:r94QaThEB9tQCNoDP8PBKClZ9xpqGqd0qUbyzxpMV6VPqbhZaRWwvklDl5YKf-3v0HxzZEOlqHNPzP1_ucGbdyTDRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeiudeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 mhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhm
X-ME-Proxy: <xmx:r94QaTRkgHFSpJlqDAnwnCuLxyEtvykIIuZ4OJML152Ef2jQRvz9SA>
 <xmx:r94Qacjlaw5AVe8hRUGELGDydJ2WnGxNmZYyx1nOMRfa4-00lKh57g>
 <xmx:r94Qab4BJMM3ouvZxQon9fYs7wgjZjKFXv1pvluDnmxHASzuUM455Q>
 <xmx:r94QaRDzntmQ6ZPmyWVPEesiArP0F7jkA9ghej1I6GPN7OZa68UkWg>
 <xmx:r94QaT5p9ompVqwLOaNUngRlic-V2GoR5luxhAD-wcBp3nj17ToF12K_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Nov 2025 13:34:22 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH] mempool: hide zero value items when dump cache
Date: Sun, 09 Nov 2025 19:34:21 +0100
Message-ID: <3000077.oX9e4DgFVH@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FEBB@smartserver.smartshare.dk>
References: <20250904120942.51729-1-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FEBB@smartserver.smartshare.dk>
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

04/09/2025 14:15, Morten Br=C3=B8rup:
> > From: Chengwen Feng [mailto:fengchengwen@huawei.com]
> > Sent: Thursday, 4 September 2025 14.10
> >=20
> > Hide zero value items when dump mempool cache.
> >=20
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > ---
>=20
> Yes, they were annoying. Thank you.
>=20
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


