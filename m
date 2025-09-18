Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B5BCAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 09:06:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F161402C9;
	Thu, 18 Sep 2025 11:06:53 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 3642040288
 for <dev@dpdk.org>; Thu, 18 Sep 2025 11:06:52 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BE4F9140017D;
 Thu, 18 Sep 2025 05:06:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 18 Sep 2025 05:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758186411;
 x=1758272811; bh=qjNKVN5yFIrsGsmeDKwAztenjwBK5smwH64tEDCC9Ao=; b=
 GNgKT9RJcmShCYD0CJJHul8N32iuNvcIUpIFCD9rtzYMJxkgRXsu445IUonjdAvF
 Kgp9OaJgiASPRn/IsYEatM1DFHq8kHl2PuY71i3CghUibLAiIEmSaAErQMf7/zpr
 zy84YU8vNf2XgZbvZ3+JV20+BzVsFjP4G7UDfi1WysunOQQ4vX+JhLBS0xY9AEYZ
 I4WgWuc8n20iA2oQLu1cGIK6Xc2yuRSJ8euBPaMMmK5F2ZH6eTJ4lFXlJlgPbtTl
 iEzu2lP2Kz/na+lCfO8IHAE4Dw6MD6kbih4DQ/jrM6Zv+HGiNoAP8b2k5TGqLJVC
 EMfl8rq/spKAA4o/EpvIsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758186411; x=
 1758272811; bh=qjNKVN5yFIrsGsmeDKwAztenjwBK5smwH64tEDCC9Ao=; b=J
 OW2aT8de9aXtQIux2az6uPAG+lacIs9E4tK+rtmQdzrLxBzdzuX9ShjVdyaxtyAv
 r1/hUE0dV4uz8HXCas3hKDWOuAm/Jt1gerXoYt8ce5zA8s68ggWAje+KxptSZddF
 46LLKrFbzB7qWX/NkxHXBy4ahEVw/yhct6NFTCYAsH8+i034ik1eF1+8wxWocwP5
 fuPS86SPLPlJDbTu/ysFQlyCLXi3/CgS/2MXFGumiyOLW+E2WEBb/A8dnnOZo1B0
 VW/eM1CJmKACHUV8qWENcCzZVR181bF6Tozcpta6tPj+9SUs0KMU/scPx06hTOfy
 lH+a/7+tvCGBo9UpzpSqg==
X-ME-Sender: <xms:qsvLaM93aRQm_WwvlRxjEJ7E4VAzU9JFRboqf4Mz0CR4B7x66qWPDQ>
 <xme:qsvLaGT5ZjDtqX9y-5fhieP9zPdVQkGPWVHmEAICQAmRnK78IOJZsRuIGpAGv0Q69
 mE5jnG6XRIYrCoTYg>
X-ME-Received: <xmr:qsvLaIXu4zfugkriQ09RJiQj3WXTkU9Ww1paQTW4JCe3hbOxGtvTJTHJCl7_dyLnZhow1d_iX2Nqkn5-0U2OCX48XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheelfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepffdtuefhhedvkeelleevffdvlefhleehvdegtddvvdduueeivedtgfej
 vddugeefnecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhn
 vghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 eprghrihhkrdgrlhgvgigrnhguvghrsegtrghtohhnvghtfihorhhkshdrtghomhdprhgt
 phhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopeguihhmrgestggrthhonh
 gvthifohhrkhhsrdgtohhmpdhrtghpthhtoheptghhrghsfeesrghtthdrtghomhdprhgt
 phhtthhopehhuhhmihhnvdelsehhuhgrfigvihdrtghomhdprhgtphhtthhopegsrhhutg
 gvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehfvghnghgt
 hhgvnhhgfigvnheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhihhhuihhsohhngh
 eshhhurgifvghirdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhp
 lhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:qsvLaIRFmkDPcMb43KrED4BdEU20fTIjQa8E539g3RjToda-tBVMug>
 <xmx:qsvLaI0ySdqG6dVLTwNWtDzEDM9kWgFygmd5ZYvUXHJWEHfKmHVG0Q>
 <xmx:qsvLaAcMr_DOiSWaIoVMBhFrHm5NNNSG0YtCibW8yDJWIyhewtT2Eg>
 <xmx:qsvLaIPgzMAxDMwOqKShyHAr6pUn0eSHC13GYvgHJ8MXCMIHScZbng>
 <xmx:q8vLaLDZh323ixtJ9Ie2FuAUsIIgsEQLe_gSjLdIFPhxw0tU5lx3X4CE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 05:06:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Arik Alexander <arik.alexander@catonetworks.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Dima Babich <dima@catonetworks.com>,
 Chas Williams <chas3@att.com>, Min Hu <humin29@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Huisong Li <lihuisong@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ivan Malov <ivan.malov@oktetlabs.ru>
Subject: Re: DPDK LACP implemantation
Date: Thu, 18 Sep 2025 11:06:48 +0200
Message-ID: <3392247.jE0xQCEvom@thomas>
In-Reply-To: <DB7PR03MB48906F6B09425E675420A8A6F217A@DB7PR03MB4890.eurprd03.prod.outlook.com>
References: <DB7PR03MB48906F6B09425E675420A8A6F217A@DB7PR03MB4890.eurprd03.prod.outlook.com>
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

Hello,

17/09/2025 16:07, Arik Alexander:
> At Cato Networks we are currently working on implementing LACP LAG (bondi=
ng device, mode 4) using the DPDK library.
> During our evaluation, we identified some shortcomings in the implementat=
ion =E2=80=94 for example, the lack of support for short timeout and the ab=
sence of proper handling for partner key mismatches.

Thanks for reporting.
I'm adding relevant maintainers to this thread.

> These gaps, combined with the lack of complaints or upstream patches addr=
essing them, raise concerns about the maturity and stability of the library.
> We would be grateful if you could clarify the following:
>=20
>   *
> To what extent is the DPDK bonding/LACP code deployed in production enter=
prise environments?
>   *
> Is it possible to share the names of companies or organizations that use =
it in production?

Sorry we don't know where bonding is deployed,
but you can check who contributed to it.

You are welcome to report the specific issues in bugs.dpdk.org
and/or send your improvements.

Thank you


