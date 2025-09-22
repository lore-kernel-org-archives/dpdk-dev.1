Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E61CA100F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 15:51:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD40B402CB;
	Mon, 22 Sep 2025 17:51:36 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 5E5ED402A9
 for <dev@dpdk.org>; Mon, 22 Sep 2025 17:51:35 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 810CF1D001EE;
 Mon, 22 Sep 2025 11:51:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 11:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758556294;
 x=1758642694; bh=Lh2eCuR1bc2erNx0UCqclN3F2QaYmTfMJE/KYVKWY34=; b=
 n77rqW4M9nNZeZ/dtnSekDA2dLYfxiaLvSqAc+bmqkbPY7kiKGSFt0fxpH3rgHYK
 aIPQSWj7eb7O7mPWRgj+VCXkQVMwvyNc5FH0VNMiMj8/EZQO78gSap74DdeNxLzw
 W7HD950X7qdi3nxRv1TDLMTraYMuPTtj6FIxQnBj+80EFWgHQbc93CHePTJles74
 ZeyZY8AlHEQJTbiU5hxKYkF1TXenyuNCMOVUdG8yDQPyb0sYmX8RY6/YAc37Q7t5
 UGCAy09VOfIixC1BVk89XS6VLhqcBlUSGDgVSemGqc22bq9hTnuoxmE6oo5PCMIs
 uA29vI2uJEwfYBawKIjLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758556294; x=
 1758642694; bh=Lh2eCuR1bc2erNx0UCqclN3F2QaYmTfMJE/KYVKWY34=; b=k
 wgh3d8IYKwK/+43YLzyStyMwu4dxCgQAE777ZuQxAvVoHIUYxPgZD/KEOaGwn0F7
 HwWkhFXvI+imUnjL9EKQZzcNmHxMdxNVK5dWxJYVbHaHf9BvFMLPta3WytZ2rAv0
 U896axC50gr2RTpZUcgzGlnLLjSFk/s8ToLscn7EblUNiBX0N3Ala2D0+hzHn4WI
 nl0gs7q4cSDMFOaFyL98P6iRbn5ViF7Gygk0zXrV5+EztjHUd3ZCHRJozVwro/dO
 nEy9yR5WsJBYYyvLx2ZKFDcucW27JFnQ7GrZul7HiTb4ohynXprPtxxPZhlee4td
 8SVIDR+vltrZVAJTNch7Q==
X-ME-Sender: <xms:hXDRaLF7CKdQN58y1uLE5A-nsL-7otCO0hk4eSEwRXvC5hXEfPKrVg>
 <xme:hXDRaDz-f5E5_XP8Txw4rHXIRzgcOYg2fAgh6b9jMrAXPhm_avc6C9F-xYxHfmRdt
 6crGJFYcF6F0UeQNHZAM_JOa1vDqbQ6zrlcCs9vLpaEBr8a1naXjZg>
X-ME-Received: <xmr:hXDRaAo7JOExSR3XdfN_OTkSn8MnP90ennDMPhNoQgoX2q7qDvmIE-5gKfkDbL7KkwQ2h9oYl6Z48P4PlMZmtbLV7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepkhhtrhgrhihnohhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegsrhhutggv
 rdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgurd
 hmrghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:hXDRaNgF3Z0RmPiIaDkaj21p8ExEpxfL7iEcKnHaHePGU5ffBTo84A>
 <xmx:hXDRaNgfjiBG1_p1BBZ9lFg9VdD1GxsRwZpw49_3HpR9dQWYxGJ42w>
 <xmx:hXDRaDjJ4L3BEC8PjGjKsFkSiQ8MWqInFuqWR4f4r_WgDh1ttNfVlQ>
 <xmx:hXDRaNK5MxK9A0WF50mkScpLiD_-vx6d0zWp_eA3Uc97MuWeI7IjWw>
 <xmx:hnDRaA7aqyXW-YTBQRA4leVgkMvp9MTXxGvQrAy73WqHTpk95htWHFeO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 11:51:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org, Kevin Traynor <ktraynor@redhat.com>
Cc: bruce.richardson@intel.com, david.marchand@redhat.com,
 Kevin Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH 1/2] build: add backward compatibility for nested drivers
Date: Mon, 22 Sep 2025 17:51:31 +0200
Message-ID: <2842623.IobQ9Gjlxr@thomas>
In-Reply-To: <20250922110708.47879-1-ktraynor@redhat.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
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

22/09/2025 13:07, Kevin Traynor:
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> -# add cmdline disabled drivers and meson disabled drivers together
> -disable_drivers += ',' + get_option('disable_drivers')
> +# map legacy driver names
> +driver_map = {
> +    'net/e1000': 'net/intel/e1000',
> +    'net/fm10k': 'net/intel/fm10k',
> +    'net/i40e': 'net/intel/i40e',
> +    'net/iavf': 'net/intel/iavf',
> +    'net/ice': 'net/intel/ice',
> +    'net/idpf': 'net/intel/idpf',
> +    'net/ipn3ke': 'net/intel/ipn3ke',
> +    'net/ixgbe': 'net/intel/ixgbe',
> +    'net/cpfl': 'net/intel/cpfl',
> +}

Should we build this list inside a file drivers/net/intel/meson.build ?
I'm not sure my idea is better...

> +
> +# add cmdline drivers
> +foreach driver_type : [['disable', get_option('disable_drivers')],
> +                       ['enable', get_option('enable_drivers')]]
> +    driver_list_name = driver_type[0] + '_drivers'
> +    cmdline_drivers = ',' + driver_type[1]
> +
> +    foreach driver : cmdline_drivers.split(',')
> +        if driver_map.has_key(driver)

I feel we need comments for above parsing.

> +            driver_mapped = driver_map[driver]
> +            warning('Driver name "@0@" is deprecated, please use "@1@" instead.'

Not sure about this warning.
We can keep compatibility without saying it is deprecated.

> +                    .format(driver, driver_mapped))
> +            driver = driver_mapped
> +        endif
> +        if driver_list_name == 'disable_drivers'
> +            disable_drivers += ',' + driver
> +        else
> +            enable_drivers += ',' + driver
> +        endif
> +    endforeach
> +endforeach
> +
> +# add cmdline drivers and meson drivers together

This comment is not clear.

>  disable_drivers = run_command(list_dir_globs, disable_drivers, check: true).stdout().split()
> -
> -# add cmdline enabled drivers and meson enabled drivers together
> -enable_drivers = ',' + get_option('enable_drivers')


