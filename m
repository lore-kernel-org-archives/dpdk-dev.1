Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72904C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 09:10:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4988240661;
	Mon,  9 Jun 2025 11:10:36 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id D223E40658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 11:10:34 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 50FDF1140277;
 Mon,  9 Jun 2025 05:10:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 09 Jun 2025 05:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749460234;
 x=1749546634; bh=4SVjl/Bb88I1UNDOoGqnxRKHRMC74aFVJzQCXoaPp68=; b=
 BM5ZtsCQc0n0iXQ4yTRbXiTC34jMSWwga+AiZIXOUPSuj58FZphCskmMb1fkYXwc
 FHFMlI8GVN7hAn3XAEagissBcoqKy6KuTTijD49cVla98X9stAeStyyVELehHS6O
 agA7X86PBTLgIkswraOF5//itFFqvZmcVXtvos9XybxENWbvH/tV3Q2dXTNYMh/J
 AohcBfc0FmWVWR3JNpuVlSwr/WNBxWEjR9lx4LGlF33xD54buPOF7CSG86Rt7DFz
 LJmqlItY2ostrBBKnyJoi5vdHlFXgbwx96ZZ0KvNcbZz0QpvNPM7LuYaB2HcLkCN
 yZyXBEYQYUSiZ07vw2KFsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749460234; x=
 1749546634; bh=4SVjl/Bb88I1UNDOoGqnxRKHRMC74aFVJzQCXoaPp68=; b=c
 g9hrhAYDkGHZmvatI1ggVAwmmRYAG4a7h1hDsVYTV8Mlah/n6P/TkdbzTIlOm46/
 VFK3Z65bZleCrTsizdE0hwvb/X9IUtG3zaKfOCtUgQ1famu25lZ/GIi6ohBoYXj2
 b24spR0WF42zyuMwtkPqMaFyQzvrJUERHAkPsbfCi8K+G2248yDZ77nmKY+pxlIF
 +FfQ4QzAyGbZxljpzuahbtAT61Mt20cdRWHImR9hCWWmcYwyfzii3QkXb+/FOZmK
 BZqbdQrSvc2ylxGQ4m7M9Q5Sk7ZnsvBR2JS+BHlqUobTFQcUkZInfhIGZXgTU4ux
 iIvfan++OkiR9wUuRxHnQ==
X-ME-Sender: <xms:CaVGaL2PHRCEpC0inlXHRBJUM5OmibDAQwgQIH8DVfrXRWolIu8VdQ>
 <xme:CaVGaKEd7BvFB8_2Jx3nWY_zyj-4RDQDzkDimHCKaZkZLslqSwBZzHYjpxrjhMNBF
 Wx3u5FANhPIhro2UA>
X-ME-Received: <xmr:CaVGaL6b8-tnQl6HjB0ewThvB_Vmd9AoDel9V_lC-hAeoyE_9woRI7oF18NFp6-S7CVZyA7qmR3ab4EAcMUFz-PdBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeluddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedt
 heevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgvnh
 hgtghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopegthhgvnhgsohig
 sehnvhhiughirgdrtghomhdprhgtphhtthhopehnihhpuhhnrdhguhhpthgrsegrmhgurd
 gtohhmpdhrtghpthhtoheplhhonhhglhhisehmihgtrhhoshhofhhtrdgtohhmpdhrtghp
 thhtohepfigvhhesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehkvghvihhnrd
 hlrggrthiisehinhhtvghlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghr
 ughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhihhhuihhsohhngheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepiihhrghnghhfvghirdhgrghosehlihhnrghrohdr
 ohhrgh
X-ME-Proxy: <xmx:CaVGaA1wsfA687XDnliGjznyGi9_doB34zLnFwDG0FFmZmCJ3x7QsA>
 <xmx:CaVGaOEneLQIn7IV5H6YZcYKDmG_KTsQPOkEaiqwuW2kfzJMfqrs9g>
 <xmx:CaVGaB-9Ty0hEF_9vA7FqXNlhZzqbbaU6gWnR2Zx9CDhrLe7eYDNPQ>
 <xmx:CaVGaLnxDpw5XruxRJYUTmGPSLlb7wGnuEQJiIYx5vkU0TRyRtFwnA>
 <xmx:CqVGaK49dlQuj2kZe_ol5iUO9hSEGx8NpOuambHDxBzNl9FofXahroF2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 05:10:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Huisong Li <lihuisong@huawei.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH] bus: invoke TAILQ_REMOVE when bus cleanup
Date: Mon, 09 Jun 2025 11:10:29 +0200
Message-ID: <40867944.XM6RcZxFsP@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA56@smartserver.smartshare.dk>
References: <20250220080906.49705-1-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA56@smartserver.smartshare.dk>
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

20/02/2025 11:31, Morten Br=C3=B8rup:
> > From: Chengwen Feng [mailto:fengchengwen@huawei.com]
> > Sent: Thursday, 20 February 2025 09.09
> >=20
> > Although eal_bus_cleanup() is not invoked for multiple times, this is a
> > good programming habit to remove the device object from list when
> > cleanup bus.
> >=20
> > Fixes: 1cab1a40ea9b ("bus: cleanup devices on shutdown")
> > Fixes: 62b906cf06ba ("bus/uacce: introduce UACCE bus")
> > Fixes: 65780eada9d9 ("bus/vmbus: support cleanup")
> > Cc: stable@dpdk.org
> >=20
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > ---
>=20
> Thank you for cleaning this up.
>=20
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.


