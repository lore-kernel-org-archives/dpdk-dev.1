Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D47109E527
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 22:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 995EA406BC;
	Wed, 25 Mar 2026 23:39:51 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 31C104067B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 23:39:50 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B31DF140024D;
 Wed, 25 Mar 2026 18:39:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 25 Mar 2026 18:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774478389;
 x=1774564789; bh=ozy6U21cLezaw+z1hWeQ2/61kAOkr5dWJ50UjVVLY/w=; b=
 X6WrVDIUmYZbQzmH+en9ar1O09ZI3zQn4f6RmLQx0te6mLcCigY9lMv2APUXfGTJ
 JGsN6mUL9oIFQUovE4m+IYpKxwWE0G1ojNniFO3wGPsBJDEVGuSAGxW7QR4w7CNG
 urf9d1eEr2M1U54tGkMkCul7r68vtI5YCyJoV41n519wXf46soCm61q9UHpU1yhg
 osb8sp/mcsm+5zqX3ab95wow+aBqZeDTarNSR/Df1yTastwRhfHtcVL8PuhKmBE3
 Q0PuwwKGMbYH7/svax6PwdrGKsTbyCNHdUpO+dqh9lDYFfTUS9FPkKhlX4rd78IB
 LdSWLFwaUz+uuWUC5ozeZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774478389; x=
 1774564789; bh=ozy6U21cLezaw+z1hWeQ2/61kAOkr5dWJ50UjVVLY/w=; b=U
 +wqRrV+ov9Pyw0l6wTq3z01IHNo5LlfcUk7l+QmLqGdcp9Ju2SmHkhzmgul81qLI
 WVnmwyQUlYPozoEnXmZ7QwAorPmlUMcBPXsOJkGknyNHxK5DZI8ql2U+AHELHwuE
 ctvDG8S2XKvgLUAoEoE9LN2UV94/aENTdXM6PwO8L6bz/LRlZbwHPZmKAnHuLkZ7
 IsvaAvYxJtiwnX7vVr64MSMV+MhMezIqmhkrAQtGvOEH/v0P8AwSnoUGJ+W6GLzM
 rLSAqTdtA1aBtL70zsaOKC4dPNhwTtw4pc/MW0KuFaT33Nl68IzDkDCpqv3WREyr
 FrnqLc+rctv5IZ6BcOcvg==
X-ME-Sender: <xms:NGTEaeUlm23SrtPQo0eyCxca-qj-rjcrZnyy9ThuOlb6h_3X3SCshQ>
 <xme:NGTEaathyJ7m4wpIPtQM5Jyz1cqI03hqxvEmpzXcnfIHsUiXeD6Lwmh8gxAROTEnU
 woIkAPdERK7TM6qijA3kA_luu6Rc75-8RIOc7hO-D6BT6ZUkMZ4RVM>
X-ME-Received: <xmr:NGTEaaVBiGRNeCFaZqZwEvhfO3-452zSjkiA3E0VfeqDs4KW_DJP9gHK69bDdfyp5D-7OAslw1p3u0PT8A9Nyl1w8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehieelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhn
 thgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 grnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhlrggsshdrrhhu
X-ME-Proxy: <xmx:NGTEadnxSDYkUvck_phP7me6qVTO9VlLyAaukEBGW0N6lnzS55vsZg>
 <xmx:NGTEaTb9TTbSBeX6hDZ2uvLuG2QCau7b0BK1CjxGSzL2LaFi5Pl0eQ>
 <xmx:NGTEaQNim0uHxN3H-Xm6M25_tVRvaw9MLcceNSO9SN3EU_MO5z4WeQ>
 <xmx:NGTEaQajPG0l3oErC9vntACTRx3F4AwofxPamxNzpHHVeZ7kltvm6Q>
 <xmx:NWTEaZVFgbx_YsUmncjAPEBvHgLpzrBcERtL9ptdjOmW6rzQ5fuoIEUe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 18:39:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] doc: remove obsolete mempool creation advice
Date: Wed, 25 Mar 2026 23:39:46 +0100
Message-ID: <5059612.BEx9A2HvPv@thomas>
In-Reply-To: <8f5e4d96-2e8b-43f9-bfe8-c79095813352@oktetlabs.ru>
References: <20260319091300.652853-1-mb@smartsharesystems.com>
 <abvmHkNQ8s_i38pB@bricha3-mobl1.ger.corp.intel.com>
 <8f5e4d96-2e8b-43f9-bfe8-c79095813352@oktetlabs.ru>
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

20/03/2026 06:44, Andrew Rybchenko:
> On 3/19/26 3:03 PM, Bruce Richardson wrote:
> > On Thu, Mar 19, 2026 at 09:13:00AM +0000, Morten Br=C3=B8rup wrote:
> >> The descriptions for the mempool creation functions contained advice f=
or
> >> choosing the optimum (in terms of memory usage) number of elements and
> >> cache size.
> >> The advice was based on implementation details, which was changed long
> >> ago, making the advice completely irrelevant.
> >>
> >> This obsolete advice was removed.
> >>
> >> Also fixed a copy-paste bug in the rte_mempool_calc_obj_size() function
> >> description.
> >>
> >> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> >> ---
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

Applied, thanks.



