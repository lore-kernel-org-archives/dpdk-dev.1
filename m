Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD6CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A1E84027F;
	Thu, 23 Oct 2025 19:13:40 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id C4D8040144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 19:13:39 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2CA1014000FA;
 Thu, 23 Oct 2025 13:13:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 13:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761239619;
 x=1761326019; bh=pV9DJPK7+lfIDR7WhSjhX3UUGOTHubBnWNHi/bbNUvE=; b=
 g4S011BfNzrY1qJ8qGGzElEX/JGXTkuGUnCYw3WMSeBS5hoa0wqUyXUQ+wRAhNQH
 2bFoipY/BJOsS1eTt5+dZOtD4xJlAnlZ6qENTtKpld+kPMbaKfBx9NZKj8//EL5q
 Cytz6BrIexQuO41PyimpfWPnKIWJKf+LhzZI4WgukmOM3qhxDDUuHBlt5tLIAb8m
 22uXITCjq0SRlo/FuJ3qZuUa0hahAItAuqdmGfjWgFwzB8b2ux0G5wkoNwub4nYX
 HrpCv4VWZRHtORjdne9c4YZ/WlwZvUbjxN5NJ86HYqcDtdjnfJ7mbW8M2Iz7GMTm
 W+nTXer4TbvQ2aRhg0odMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761239619; x=
 1761326019; bh=pV9DJPK7+lfIDR7WhSjhX3UUGOTHubBnWNHi/bbNUvE=; b=k
 iF8CKq/lbzO7h/liToc6DIER09IbbVeuQ61xJ0ZNmulVlIBrhb8LTvGPZ3ASeEBa
 XXUORDdjsb0MQftLpT74lZSeAAQN5pmApmVOSOjjLAq9bjKZkm0NlKMA8Xnm0jKh
 gWo8OtApYoDNWXhvUpZr1aUGiaEF5x2Ne7oZN4cd57GYXQQiJOOH+vAC3n0R+/W6
 Y57jrKrb0kCaIf+sw916W3nGIovLYgd/UuX+oM4pT3ikvglWYaw939bPRMKdzB7G
 aXnVgfNXZK7JBK0WAjEkY2owRp2usozIdZ26Bd8rCPOGjBdTW6WZoQq/oeq6+bYd
 pZKnj01FmvjnkafGBbZRg==
X-ME-Sender: <xms:QmL6aDXRreSIRp3MOliw7Drxm2E3i_WRwIVAO5ky5zkExaLN1etFKQ>
 <xme:QmL6aGjQA-qi6fi7FJ-NuyAP-fvUImCSaFZBvdhS0sfJ0wq9BW4M02I3utKkyEmkE
 ntLr8FzI_0FR4pCCn90z38YKl4NOAcRtTNvJnYcsBNcpugRmM_C>
X-ME-Received: <xmr:QmL6aOaixW62J3WQUVhcArdF9NYCskczTKK3lnzP6m9EmV81plBUzeEG11j6LdCVLidoOoD5zZKjlniQUtvKr1nK-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejtdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhope
 ifrghthhhsrghlrgdrvhhithhhrghnrghgvgesrghrmhdrtghomhdprhgtphhtthhopehk
 ohhnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtoh
 epfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopegsrhhu
 tggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:QmL6aDoEV1n1D5Zd7d4IFD0GsD0RYO66ReEnfceNf9tx571O1NgDMg>
 <xmx:QmL6aLPElFQ_3EUnY_8eYxT_6oVbHZLM75cT8FbvSZZ8o6j22fOm1Q>
 <xmx:QmL6aGoAxMn9BQJUB6shWMQaYSoEo0Ec609LUOPJByhVdnGsDQw7wA>
 <xmx:QmL6aIc9QJao1P7aZjSbN3xUpUJdR5TpVbM8v3o0fQYC0Ms3NEGFhA>
 <xmx:Q2L6aCLWpsXXpU5rpx-uwEMtmxuBoqZn__uwk9LJtPz6vNc-5z9mOBEr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 13:13:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v6] mbuf: optimize segment prefree
Date: Thu, 23 Oct 2025 19:13:35 +0200
Message-ID: <2899098.8uLHfb51uz@thomas>
In-Reply-To: <20251023124858.318148-1-mb@smartsharesystems.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251023124858.318148-1-mb@smartsharesystems.com>
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

23/10/2025 14:48, Morten Br=C3=B8rup:
> Refactored rte_pktmbuf_prefree_seg() for both performance and readability.
>=20
> With the optimized RTE_MBUF_DIRECT() macro, the common likely code path
> now fits within one instruction cache line on x86-64 when built with GCC.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.

Note: v7 is not chosen because long names make this difficult macro
even more complicated to read.


