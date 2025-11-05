Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B11CCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93DF240677;
	Wed,  5 Nov 2025 22:37:52 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 515A2402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 22:37:51 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id F02E9140015E;
 Wed,  5 Nov 2025 16:37:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 16:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762378670;
 x=1762465070; bh=4hyMCKiZKB9rJY8FKZFn4er4NzFzO3p08MyzdoEqjTY=; b=
 hDUKiVq2JD2KtZRNVhoTOdRPo2dNhZa1FrF0qRYt380H5NehOM8jy2d5jo7JbnX+
 GdFRUtBdmZy5adqHFUFJnSQ1ukIY/QjVwmi6xliTrSSrWZKlbb5/aGsK5YMP3wVM
 d/m44VIMd7HHAdlsn7pPMlEhQ8sWOX969uErFYGD65I9oWxk09IUY32vbGsTbeEs
 9wGOytbX5mCo1FF2jNd72KXS+5SUHbF0hWwDCP+BWAIjsc2otzrbJQFAJzm+xBcx
 gVQRfeA5TAYMZI4y6/kx16Dc+W40MQLo2axP9NaQEsRusFxypciqTBWBUr399hVP
 rh+aK0BjLX2eqcdVnDJNAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762378670; x=1762465070; bh=4
 hyMCKiZKB9rJY8FKZFn4er4NzFzO3p08MyzdoEqjTY=; b=pp801HxiZOF0CMN5W
 gmaDXrUYCEvhGXtzqt/w84Pd/MpZ6lXazBrjJ4gl5uGH4VYhvinpiqBLOy86Uz46
 p5B7fcBdN7ucPWU5M2fBYFp/VQ0uAezjOfCKyHcXue089jRp5rx5ZWNPtQfgLhXb
 /lQgm2JYMpOJ0ego8DHIUEB0k/Rdy7ox/m9fvlHYU7u6bJAMWIgkY2J2NM2VEwNJ
 W/kblMpaZkpFA46lUVovz5gFRr+g9GF97EI81B/j3i4qaQsvF+iAUUOQurzsbLpX
 XGJGBQM7RYPbewa8U9Ues9ub58TxjCOvg+Yo2ADE/o4ImlTiF6nb+uLchYPJfAaC
 XCl/w==
X-ME-Sender: <xms:rsMLaRNhh8fQg1M8GVuXXI9K9QkG29o6UfwUv914URyn9vPGsV7j7Q>
 <xme:rsMLaZ34_P8xlWmz9JnG47IDsUT3k-HZQ6o_iQ9uOja91GK2S2IZkX_sJECN-ubyz
 0_PNi4FKfsxEusHZf7JRhcQIJGwYrN_yIwPo9AFz-_iO7W1pJ2Daw>
X-ME-Received: <xmr:rsMLabW1f6XWoWi3EpqMhsdSDNDjOH0zCFLVUT_iznocXW4ysR6tgB1EFtjvzpL4px-fRRzywg5XfpYFTV8x5nqEbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehtddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkjghfggfgtgesthfuredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeelvdehhfduuddufefhfffhte
 efgfejteehhfetfedukedvfefgledugeetvddtgeenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:rsMLaagQHVS_095OIYHS3yMQeCj0w9_j0CGR3CCcQb-sZrdBKtKCAQ>
 <xmx:rsMLadByWXTjC8ijtM_6h6t4nI7cu5AY-JaCj8u8A7EOblkcukiG9A>
 <xmx:rsMLabdDcoeWPxT5W6mCNhNgfnzt-DUEOgVDRJkHjwFdjWVgslDBnA>
 <xmx:rsMLaVc0VhThMa4pVS9O5SQoQdJUc_IZxG8D9dR51CSyMQ4VW4iELw>
 <xmx:rsMLaTta_CZhztEnK95uBHdDJH_RQ8MtHAHKa_TF9Gia5pMIz-Cwy88v>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Wed, 5 Nov 2025 16:37:50 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Re: [PATCH 0/5] mlx5: remove useless constants
Date: Wed, 05 Nov 2025 22:37:49 +0100
Message-ID: <2405113.teYOa0iCNi@thomas>
In-Reply-To: <20251102155617.4001783-1-thomas@monjalon.net>
References: <20251102155617.4001783-1-thomas@monjalon.net>
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

02/11/2025 16:52, Thomas Monjalon:
> This is a cleanup of #define constants which are not used.
> Some unused constants are kept if they are part of a bitmap,
> or can serve as HW documentation.
> 
> Thomas Monjalon (5):
>   vdpa/mlx5: remove unused constant
>   crypto/mlx5: remove unused constants
>   regex/mlx5: remove useless constants
>   common/mlx5: remove useless constants
>   net/mlx5: remove useless constants

This last patch is split for constants and macros with parameters.

Applied


