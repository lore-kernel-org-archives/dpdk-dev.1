Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D098C44503
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 10:31:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BDD34026C;
	Wed, 21 Jan 2026 11:31:19 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 2A2E64026C
 for <dev@dpdk.org>; Wed, 21 Jan 2026 11:31:17 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 909941400182;
 Wed, 21 Jan 2026 05:31:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 21 Jan 2026 05:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1768991476;
 x=1769077876; bh=Jn7wLKOdmX+3tLBMvC3J42v2VMmZRb/58GWd51aUTbA=; b=
 rn0plx8zZ0qFOCN4RKuD89+MBRyqvi5Kt4Ry+Ge/td/QZc+0ZruCcyntqVh5DCVi
 Rr12DI1GuzcyCftFkEeCpIXV6HGDnbIOugHp0txpJe8nXBgWp0SkYb7g8SJwPE28
 5UZa6/7QbUYvD0L7XbgYAowtP/b1mV6hpM/HpedKilwgacMaTw+LHb3fXCPe0Byz
 TXJZeDRHcE0CqiTOE3WZHZbO+o3AmvtHu3rK03CyoGdBKiHZYw7gw6YUx/36IbHO
 kuFZWv0j0Eb/Oc9Ulqurs1dgoGbItDUFsgDAOOhqsodAZ3tpCmHmQimqOoacQ3s4
 b09NLd4n/tgem4VBXDdZ4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768991476; x=
 1769077876; bh=Jn7wLKOdmX+3tLBMvC3J42v2VMmZRb/58GWd51aUTbA=; b=E
 zhhqXET2IidEUWrf1l1ZAroyQPJCQOkCoD4v9O5/ncFaK/fPKjIDyq0bd4eqE0FK
 sSyFfqcuNAmeHNTrUvAsiHuKKdcoBCT/z60paSpXZdbLLL6r6R6lYUYy2NVYK7VK
 5ZiWqaJ17n+Lc8e2ZSKwYTPkhUeGrcDIbghUZhJ7eR+HwI4+jtuTD4AB5u1mULNE
 yCEoiUs3DsFVGru49LMQ3hudvU2yY2xvSJLpt53J+JT8qRD1Z7p9MpwmkdNau4aq
 tAofApIZwmBxrqh0Cqc8ASnRt4wTU3C3CJxVJQZRbeVpCrGOUtvPYAsAtgAXvaN/
 DkOx3eG2cJ+SuiXnd33RQ==
X-ME-Sender: <xms:86pwaRDxqWbW5eY-5096vJL5fazHOFdA4ZpedG5WGx_1OJ0N2O6ipA>
 <xme:86pwaWjE3uK7tLTDxw8s1lI0TM6OnbgX25RU0hnSznap7TvY6y4rbRySR0z_x-4MY
 4mz1dUh-wmHH5Z9GucJDJSceyRea3bJEbkXttz8E8lDAwf0mRTE>
X-ME-Received: <xmr:86pwaRkeGWv_7OziZFKepdeA9bo_3AWJBRQ7XRobmL7cP_fyZLN1ygIObcDw4NQGmyDQ2wAnnyGjLgekAyRgrGEMpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeftdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepphhrohgssgesihholhdruhhnhhdrvgguuhdprhgtphhtthhopegsrhhutggvrdhrih
 gthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:86pwaapU6HBLnF1KjzJSeBU5JnpX7yV0JsDFe7ixfDtv5S4Sg4Laew>
 <xmx:86pwaSH-9fSAP2c5tKT8mJglrkL_dkuSi-KTCpysTpxD7Vr9_GJdKQ>
 <xmx:86pwaewnEYIxmFb_rOa-ASH--flWP_Gsobjy0ex-HaHvc4Y-QADFnA>
 <xmx:86pwafoap8hWSkjTcWKHKqu2K5Opgsv9RBSp55IFjQoGLCdsBXRjcg>
 <xmx:9Kpwac0kRyMyaYJpVRVPtYDgCnIcr-5-jV8jAmJF2DgQp6ADn1g8SoO0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 05:31:14 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, probb@iol.unh.edu, bruce.richardson@intel.com
Subject: Re: [PATCH] doc: raise an error on warnings for dts
Date: Wed, 21 Jan 2026 11:31:13 +0100
Message-ID: <1865655.TLkxdtWsSY@thomas>
In-Reply-To: <20260121100127.1701459-1-david.marchand@redhat.com>
References: <20260121100127.1701459-1-david.marchand@redhat.com>
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

21/01/2026 11:01, David Marchand:
> Similarly to commit 6572fc926037 ("doc: make sphinx comply with ..."),
> pass -W to sphinx to catch warnings.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Thomas Monjalon <thomas@monjalon.net>

Note: "dts" could be uppercased in the title


