Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE15CA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 08:57:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61BE64025A;
	Wed, 17 Sep 2025 10:56:59 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 2EAC740144;
 Wed, 17 Sep 2025 10:56:58 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id C0EB2EC0071;
 Wed, 17 Sep 2025 04:56:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 04:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758099417;
 x=1758185817; bh=+AzqrN8ibPPheKaU9DnmB2zeGelqNT15hBVYlK74kJk=; b=
 XLxKTPHPuQPUwnmFNAPdSk2slqVLhAPF72mCmmPt1nbs/5THt4T6LX7kJyI5TbLP
 +vPrrxxR+c/Tz2+F5nlP12GyMC0+ImmxeekZdONSlaw0x8SJlXBjPUM2aKZ6UmuX
 2+GYMjVGx4iqU+O14PcWO5lAUr4O9svdYhHCtJW58FVp+ahQ9VEwGgsf+lD9in7M
 iSBL0JlhTUwKYV3k8FH+GUaoImZz4kXxZRiSubJMx5L4z+whXDH4xCDDXQ8+gyLe
 g/3GHsGHoprjTIFJt7iE3WsnPBdrelY16R2ekIdF9KTnfx11jFpbGyQ5feMWxQnO
 p0HxJ/gfw4ZnVo8r343Y8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758099417; x=
 1758185817; bh=+AzqrN8ibPPheKaU9DnmB2zeGelqNT15hBVYlK74kJk=; b=B
 pewquigrIIy7gIbkAj2hFXmr0V+RvZ4a/EN6R7rQ/r0JfXXPgPm3IbUKnzRS/KcE
 EMHsaDmNTdWiV4C0aLHlHhClfFbd2/GCF+h887tUCTgbgz5DprW+pucqUWt+aKCm
 FT7GJEIouxHxWI4hr0Iz6ZNZkpEJuA0GkxQx9iQ6naEatM3M2AS0AYa53eqXqlps
 PGPZufZgI9GhjH3Y/3PGO/xzjEkwZ8uh3+oSQf0Vld/XrOgNStj6kT9a2A+LpgiP
 FKYzog7Qxhhq8hKPBiQpIjiw2DaGDuMvQ3eXxz+5B3ytqE+p8m1xf372jW1ZRYqy
 zX89hGhBWRvD3bW5bit0w==
X-ME-Sender: <xms:2XfKaNfCy7_Z_IbY03sVFZ9LNA6vn2DcBBC9V1ePb3ZmfvuVcrnQhg>
 <xme:2XfKaGEp1jj6qOM3LOXOva2hE7AHUlkzwS6K542wt9Dxv9mvhOr0fkdNSJIWm-9Hr
 WeUlLzE7Yzx9x_Ckg>
X-ME-Received: <xmr:2XfKaOWE90KAVb_2YRNk2xHGw5OO9HFOC6GDwwXjG-JB6D7Jfs8oCbf7-cADzwgzRuzZARjiJFPZZ0RPtmu_pJsofg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfedtvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrsghl
 vgesughpughkrdhorhhgpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrgh
 gvsegrrhhmrdgtohhm
X-ME-Proxy: <xmx:2XfKaFJhz2suWHsQdX6rGqOU6VtQC-cTN-rhQtlcCrRcbB-a4BoPYQ>
 <xmx:2XfKaO8pdOU5lU1nbp_k3n3R8GrGRaI_HWw_UkUd5iVswwJhQH_sQw>
 <xmx:2XfKaILKt6dsWMM4xSWXklc5qe_cz929XJdU37jBY_GJu5dC_VOLYA>
 <xmx:2XfKaDlToENd0zOXhX2OMYe5caR6-PmLy_noGDKB8tUvGsqgoUw76Q>
 <xmx:2XfKaLnxZ2-mZFksdqAPLUjpmA8y2utJn7sVIbZaNYW77McqSV45bkwW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 04:56:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, stable@dpdk.org,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] config/arm: support crypto in cortex-a78ae mcpu
Date: Wed, 17 Sep 2025 10:56:55 +0200
Message-ID: <4241362.aeNJFYEL58@thomas>
In-Reply-To: <PAWPR08MB8909F6D501EA994F2EBE38549F3EA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250805062233.222260-1-shperetz@nvidia.com>
 <PAWPR08MB8909F6D501EA994F2EBE38549F3EA@PAWPR08MB8909.eurprd08.prod.outlook.com>
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

> > ARM cortex-a78ae configuration (part number 0xd42) is being built without the
> > necessary crypto extensions. This results in infinite loops in the crypto
> > performance tests applications because the hardware crypto features are not
> > properly enabled.
> > This fix enables the crypto extension in the mcpu definition.
> > 
> > Fixes: c02c01dbf907 ("config/arm: prefer strict use of -mcpu if supported")
> > Cc: wathsala.vithanage@arm.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> > ---
> > +    'mcpu_cortex-a78ae': {
> > +        'march': 'armv8.4-a',
> > +        'march_extensions': ['crypto']
> > +    }
> 
> Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>

Applied, thanks.



