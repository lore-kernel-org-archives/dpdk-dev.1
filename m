Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6777C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 04:50:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E337E402A7;
	Wed, 12 Feb 2025 05:50:08 +0100 (CET)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 35E3740269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 05:50:07 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4C75325401E9;
 Tue, 11 Feb 2025 23:50:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Tue, 11 Feb 2025 23:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739335806;
 x=1739422206; bh=AZq3FWFxIAz7NcpnWmmObdWlZA/mVHXY2yfmGDFYdWM=; b=
 QK2Qmn68ElrBWCDw7rhfPgTE8nkFJvz6bcypaJHS2VwJ9Z4gSZU9aCkIsEhNqHCx
 qx5dbO0VShD8qwbfq9uDFHgRRN3K3pOrEkirdqS/aX1VzLr1BAHTltIu54PbdPFs
 Vub+qu1FlUYuuDvd2itqfnXc520pOsHiRF3vpPPdqavthjbzNOMK+/yhapORtMLv
 FJWtRISJr7LuBFDDANAef+9LU5W3886zPrqQdJVrXtPw0G6FwWHTYSXxIYNEA1bW
 BZSz70XoU6HAN2lrkVZgZUrdeQ5K4UwZRMLWnwxPP5rRPMjI7i9cf8zfssmuUDGV
 9wy7SnmCte3hZlRbIUyeww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739335806; x=
 1739422206; bh=AZq3FWFxIAz7NcpnWmmObdWlZA/mVHXY2yfmGDFYdWM=; b=D
 Py17wnVuHZMBAR7eh+MLkFIWAqSjp6LrydRpmh1x7scD+t2B0K/XP/KHVcjZobZ2
 tD3IKl5zPwPMgTKeTJdPovs0oVfcg+fSyHoI7b3CQJKSyAknhWx6wnUF0gfJeEdv
 qb+gFRlw4OlC+vp9jkaefi9oyKtlZZArcqAvIfDqQrZ+bnwM6q2m2MGWuQdUeZwZ
 EkyfiybAVdM1teJmW1DbizCsK+f6GZxDMo+TbC/k5K/GwfGgWXO4W28gxjzXk79F
 LYT5xUz9jE7SpBFxrBMIA5ycYOhoiEdlP1qyIVEKcblhH/+dOSVezhO3CxjYJH48
 JMnTh7YIXqC1MoeBnrIrA==
X-ME-Sender: <xms:fSisZ7mPc6GQyXG_7H2MYDtgTAXGSnly8TE_W5wYcQXAzCfxZ2GGgg>
 <xme:fSisZ-2D1sXkYV_i9ufAmKq7Jl8DzsOixPVAvYu2216XcZD5-le4gF2KcdNEqZJDg
 rSUY8UcdqeoDe6QUA>
X-ME-Received: <xmr:fSisZxpyuRLYgQCIEx3i1Zz6CHUCl1ULN4LHNAhBu-ADP_JuwV7osl1oHgQP1oFKlrgcZFUd5cnp36RI0Mke0YH_Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvdeliecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrth
 hhshgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohepsghruhgt
 vgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesug
 hpughkrdhorhhgpdhrtghpthhtohepnhgusegrrhhmrdgtohhmpdhrtghpthhtohepughh
 rhhuvhdrthhrihhprghthhhisegrrhhmrdgtohhm
X-ME-Proxy: <xmx:fSisZzldVJZ3eN-PA0OL0pQ6KQ_rLS0betScO23paKtPGsMllbHplA>
 <xmx:fSisZ52rfGiTAPl5YPKR-xeLUogCreTyP2Q88Dstkh7dtPo-iDwjqg>
 <xmx:fSisZyu85lqCIORu7D1g-YwygZ7n3RTHgh0vdGbqX-PNoLURnPH6Iw>
 <xmx:fSisZ9VRjjWKghFq2gyO5le-ug2V76xWOD4wwHONicfyeYtmf6ZsnQ>
 <xmx:fiisZx-Z8ycUb8I-lejPf0_bujoRzJImDyC2exeHEhCAfpVQhDuUfE_C>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 23:50:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, nd@arm.com,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH v3 1/2] config/arm: strict use of -mcpu for supported CPUs
Date: Wed, 12 Feb 2025 05:50:02 +0100
Message-ID: <62120729.matp6XCIr4@thomas>
In-Reply-To: <20250106183146.540161-1-wathsala.vithanage@arm.com>
References: <20241028233139.922029-1-wathsala.vithanage@arm.com>
 <20250106183146.540161-1-wathsala.vithanage@arm.com>
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

06/01/2025 19:31, Wathsala Vithanage:
> Arm recommends using -mcpu over -march and march-extensions when the
> compiler supports the target CPU (neoverse-n1 etc.). Arm build so far
> has been an amalgam of -mcpu and -march. When march is in use, it has
> been the case so far to silently fall back to a downgraded march when
> the compiler does not support the requested march. This is unnecessary
> and confusing to an end user who could be building DPDK with a
> particular ISA version and performance expectations in mind.
> 
> This patch aims to rectify both the above issues. For part numbers that
> has a corresponding -mcpu, this patch removes all references to march
> and march_features from meson.build. For those SOCs that do not have a
> corresponding -mcpu, a pseudo cpu name in the format mcpu_<soc_name> is
> introduced and referenced in the mcpu field in the part number
> dictionary of the part_number_config dictionary. The definition of the
> mcpu_<soc_name> must be provided in the mcpu_defs dictionary.
> Each mcpu_<soc_name> dictionary in the mcpu_defs have a march field and
> a march_extensions field to construct the optimal compiler setting for
> an SOC that has no corresponding -mcpu value. This patch alters the
> behavior of the build system such that it will no longer silently fall
> back to an older ISA version, it will only perform what's specified in
> the build dictionaries, if the compiler does not support the specified
> configuration it will fail with an error message.
> 
> How to add a new SOC to the build system with these changes?
> If compiler supports mcpu follow the usual practice but without march
> and march_features fields in the part number dictionary. If mcpu is not
> available or buggy (misses certain features) for some reason follow the
> same process but set mcpu field to a string in the form 'mcpu_foo'
> (pseudo mcpu mentioned earlier). Then in the mcpu_defs dictionary add
> mcpu_foo dictionary as shown.
> 
> 'mcpu_foo': {
>    'march': 'armv8.2-a',
>    'march_extensions': [rcpc]
> }
> 
> march_extensions is a comma separated list of march extensions supported
> by the compiler such as sve, crypto etc. Empty match_extensions allowed
> as use of such extensions are optional.
> 
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>

Series applied with the hope there is no regression, thanks.



