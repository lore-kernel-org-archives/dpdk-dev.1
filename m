Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1995AC7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 578EC4026B;
	Fri, 27 Jun 2025 12:44:17 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 369844025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:44:16 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A74107A0141;
 Fri, 27 Jun 2025 06:44:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 27 Jun 2025 06:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751021055;
 x=1751107455; bh=Q4T+NwmgzaMwzZWsitswkR6Ab4s5Iz7FCr3661eYbFM=; b=
 LSvhWt0OvxDNzutVB6lbjIlBmavgUpTZ7RtS8eKFpVaNkiK0uy4uPLvb/Pc8W5zD
 3rba+X7et7o7/vFc76it0HxR7Iq5Ykoqklywv6EQAIGP/q3qGW+P2htqt4rEqRi7
 ygS4XUUEp4c9NybDO+cZdu5AnFolbkVNPZvHF9z4cLjTTxr7dpoGRBMSh1F3nlag
 whnad/VFHPn7/UZv4eYDyWGd2v6norP1+N20t4S4AMqGR3Rhm+RuydFcqJYazt4l
 dO9WxpU6lXb7tQp7/WTjpafFe5rZ1g4wWOyvjmrl1bukSgP7SJYBD2pM0UGZnBKo
 PsdDjh9vJYIt7rLFnOk+WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751021055; x=
 1751107455; bh=Q4T+NwmgzaMwzZWsitswkR6Ab4s5Iz7FCr3661eYbFM=; b=B
 NhOgpe5yxMuXf3k5ipeV9/3/r9yRYUc2UVSP880P9HGBDOam/sFWq8NXeZjAHWyE
 3TAwslRmSt+3KEOd1n06Cp4wTfnScPy6Leu5+Ua+nWUwaMpDwOMkXDcS+LysByWs
 Mdco5hCTwAhPtU4nC26ZZF5TNNrb/7MquNlSk9SUcoiFUYX/q+7sqelnAjBc8sH3
 /BKLZURWaPkkzLqiFyaylEWkBmEGszCeSr+KzgrvgE5a+OobFwaWDYoMAs7+ti8M
 W4Q4DaDguACywoM4rNlspDRbDfJkz7rCRpeyQKlOzfc1XM3GFLETMyN14PDT2xf7
 hKNfCyab2GTVQVZOH1eZw==
X-ME-Sender: <xms:_3VeaKlCkKW6TUfdE6waPyvjnN6X1SQtYX_FGk_-udfKhJ2HqqA2lg>
 <xme:_3VeaB1UEmSvknGz4AYyJs7u3u3AzE9KqgGbAlZlstWU3IRhGiY5VrnqH81ZEb_KD
 ww1HuoV4gb8JJVobA>
X-ME-Received: <xmr:_3VeaIo2fLt9hOyz1Tj4jp8bCh0_SOt8wsNM3qkU-19_1mnbc2ngT0WJFNIN_mn-iTikT3Iti3UEmB9mNSITQ0pfsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvkeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinh
 htvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 sghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:_3VeaOmg_qRvygCxgxLoKfZHlYhv6sqpcLxcsKQkLPOKnexXMWoU5g>
 <xmx:_3VeaI2dC6bK_qN8-QMiuaciRbv-Z8yp7hdsa_YrXK2oFj2C0GzltQ>
 <xmx:_3VeaFtfYSe5iuVbtEVbqdlw6gCvUGIHILFpmdyMumJBfOMFVDGdaA>
 <xmx:_3VeaEXtooTcwM6mMvcm099IDFCJfn3oVT29eRevqJL_W_oC8iueUQ>
 <xmx:_3VeaA5731wwaT9bfsb2q3VZ2CdcbHxbRF3mVV8-uYv4ILhpqlVqOqw9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 06:44:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v1 1/1] memory: handle invalid socket ID's when allocating
Date: Fri, 27 Jun 2025 12:44:13 +0200
Message-ID: <3956282.MyG8hOvIyE@thomas>
In-Reply-To: <aFVkMQ6jc27mTJG2@bricha3-mobl1.ger.corp.intel.com>
References: <4e785f17154922f775c56558947b2f967f25b23c.1750426216.git.anatoly.burakov@intel.com>
 <aFVkMQ6jc27mTJG2@bricha3-mobl1.ger.corp.intel.com>
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

20/06/2025 15:37, Bruce Richardson:
> On Fri, Jun 20, 2025 at 02:30:23PM +0100, Anatoly Burakov wrote:
> > This issue was reported by static analysis. It is a false positive,
> > because both `rte_socket_count` and `rte_socket_id_by_idx` only report
> > information about physical sockets, and these specific calls are made
> > during EAL initialization, so no other sockets (i.e. external) could have
> > been available, so it is pretty much impossible to get invalid return here.
> > 
> > Still, to avoid future false positives, we can fix it here.
> > 
> > Coverity issue: 470131
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks?



