Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E8109E527
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 22:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA44A406BC;
	Wed, 25 Mar 2026 23:33:38 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 133B24067B;
 Wed, 25 Mar 2026 23:33:37 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7D67B1400233;
 Wed, 25 Mar 2026 18:33:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 18:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774478016;
 x=1774564416; bh=VUdZIINMG9md9QHMdx/BlgiMAi7LncTn7xBMDGtdnGQ=; b=
 dt/EION/Y/1EtB/62hhn7wR2iZJqUhcpVBg3FbJz4zU24IhvyAB3rz3Arzw+DySB
 HSyvdWg7oIQRHrdSVcQRV0aJPVG10rB2E6IUz+/oc/2FQksa1vRACt9NJcZKh9ce
 e4FgAdbrLYA7gaxco7jhkf6wOgatIfyWzNIGfKF0zkBNStzV8SVGFf2zd0M96Dgq
 PnNy4Tl1bx7h3M8A5bTO3Ywn1GNBzKihXVJ12frZIt+Yz444Umd/QQAjNJZoiLfs
 izSZmTfKNJMPDzGIxNyeomgn6SxgNcqmNY0952zWvbx+cXV9Z5zSKvkc0wyDZ5UB
 drkT4W5gI7s/mJrh52cGNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774478016; x=
 1774564416; bh=VUdZIINMG9md9QHMdx/BlgiMAi7LncTn7xBMDGtdnGQ=; b=A
 rSp0dS7ubnleHtMwtEOb73w/a4kk2M6btz2pmKK2D7hX68+gSVbpWMhoRxm1cEE2
 Rig8mDmAhSj4BZSafIY2xt3XP+wGxsTYdC0/Tnb/m3TkOpInyvM7J5HoMENeqZHa
 rYdY25srhsz14ZWd7L37uwAefWvEvw85HnGsdR5bAgS4LwQqTQB8mrPYrBXLo/S7
 HWINgCdyvVxunXECS0eSfMLJ52hPjgFY7BroIS2pmQKKYmGUoJZS21JxTdvJufBG
 TbfSh3saDhSx9OrBRtui8JV4NbNrs7CYg3WdaHAXJMPj26KS01T17gSRigmQiBdn
 uYeFJdRyfJ7YYDxXe1U+A==
X-ME-Sender: <xms:v2LEaX0AFJZqQ2F5U_ZJB9oZsjKVfLFwcN1szaxoWIsDsW7NKEbhwg>
 <xme:v2LEaQLjfQqTPjNV11COypuF6ShFXGKrc5-EZuj_Osmo0EVjpMm_rMWzd19MRO03l
 m4wVajYVjHHBBloDR_tkuohbC_b-BbZAI8aGNCA9UGCD9827sTrGQ>
X-ME-Received: <xmr:v2LEaXzPPwdi4AdkwsAQFvTdChBS6Lz1mDXrw4WB7zcoO-X-6xQderEbXnDFCD_-z_XQSDu-DPdRAyXPnAn6ArGaMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehmrghrrghtrdhkhhgrlhhilhhisehhuhgrfigvihdrtghomhdprhgtphhtthhopehsth
 gvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopegtfhho
 nhhtrghinhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrd
 hvrdgrnhgrnhihvghvseihrghnuggvgidrrhhupdhrtghpthhtohepfigrthhhshgrlhgr
 rdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohepshhtrggslhgvseguph
 gukhdrohhrgh
X-ME-Proxy: <xmx:v2LEaeW6TceGjXAOwQpy5ozU6W77GGYOn7tBJduUeuVSOgR2469uZQ>
 <xmx:v2LEaXgPqyaoOjUC9o0TG6PjG3AY5WRJ3uI14OScoVWyliQUrNyKAQ>
 <xmx:v2LEaeCDRO7NiBEKJM_Auisq279qjtjZZKKGwO33Vt7CcKVlT-HDEg>
 <xmx:v2LEadv0ZfwaT5ksMMUe4Oul0aq9cDX44AZjO1cfL2J1nMiFxkvL0Q>
 <xmx:wGLEaaTqoGWNr9YvwXlLXKg1BKYq5e267h35BpSoDjW-S7pMxaQqBAiK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 18:33:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Christophe Fontaine <cfontain@redhat.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, stable@dpdk.org
Subject: Re: [PATCH v2] mbuf: fix read packet data
Date: Wed, 25 Mar 2026 23:33:32 +0100
Message-ID: <4378235.OBFZWjSADL@thomas>
In-Reply-To: <20260319124329.729034-1-mb@smartsharesystems.com>
References: <20260319084048.652493-1-mb@smartsharesystems.com>
 <20260319124329.729034-1-mb@smartsharesystems.com>
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

19/03/2026 13:43, Morten Br=C3=B8rup:
> The sum of offset + length, both 32 bit unsigned integers, could wrap
> around, causing comparisons to give the wrong result.
> This was fixed by using 64 bit instead of 32 bit for calculating the sum.
>=20
> Note:
> When the branch is not taken for the initial "if ((uint64_t)off + len >
> rte_pktmbuf_pkt_len(m))" comparison, the sum is known to not exceed the
> maximum possible value of rte_pktmbuf_pkt_len(m), UINT32_MAX, and
> following sum calculations can proceed using 32 bit.
>=20
> Also, fixed a related bug in an mbuf test case:
> It expected reading a length of UINT_MAX from a non-zero offset to not
> fail.
> And due to the offset+length wraparound bug, the read operation did not
> fail.
> This test case was updated to expect the read operation to fail.
>=20
> Fixes: b84110e7baa2 ("mbuf: add function to read packet data")
> Fixes: 7b295dceea07 ("test/mbuf: add unit test cases")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Tested-by: Marat Khalili <marat.khalili@huawei.com>

Applied, thanks.



