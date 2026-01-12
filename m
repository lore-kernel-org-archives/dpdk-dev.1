Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF0DC9EC97
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 15:00:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA81E40156;
	Mon, 12 Jan 2026 16:00:41 +0100 (CET)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48]) by mails.dpdk.org (Postfix) with ESMTP id 246AE40041
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:00:41 +0100 (CET)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-5ec8781f5c9so2925185137.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 07:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768230040; x=1768834840; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H5pbZJHaqB8saPNvkE9u9Zz8GugWZlborQUJcpygpcc=;
 b=N9Si2AN0uIK+Pb9qkmEN2tKSV4Z7WJ2MsUIZuRUYzpcwHfAJahs3qEk9nLWiwxdXvF
 qbm2pxkOXH6Kx0pdV1RckT7VQ5Ogk8GPkmDAIZnfyPQgUMHEEQGCYf7IoifIbbkc6Uuu
 x9BPcMiy6gRxgwenzo0SSi2GfvEiM9fvmzf2GcO+ergAstJR6gIMo0IDrahVRzlmjmmf
 xHv0KNpvfoNYZsXUPscjQWYHKDGSMCzyyU8dZMbeZ4PxWtXHpZrtQdTzJaEQm+liYSN7
 VSpn39VqD3oC2RWKG9o5hsWp+CECPDon0ZECmN91hqmV2+H7klZiCU8w8FHyeh4vnv/B
 0H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768230040; x=1768834840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5pbZJHaqB8saPNvkE9u9Zz8GugWZlborQUJcpygpcc=;
 b=RYojOh5HJElCv7VKVPkcthaO+DsPlNQyV4ThyQb7Int9i8R7mc6i+2GZkf1EpIncSS
 x3laYUV2bmA7yik1J8JgiEnFdf9spqKQ9Ly594XLFn6pqTQfxiTkkpyo8NOaHCUTODN3
 aHqxPpqzjzXHRnl7CeqH7CjyPPQTZ4T75EC1nRscqycb0QdSCPKnLN9C7jHgfT9pnMQd
 LDdbEXTkA4LWg9OM7L81C9CwlW+ogwGnSoREhJdLG1CJPzEwVM75x9tdq/TJvVrtl80H
 bU51YNIalKdd9/XuE5v5un36iTuxsbXH6rJFJr1wrj9G6+BGMqbsQIYZKjOlpmVRFS5W
 Rlrw==
X-Gm-Message-State: AOJu0Yw5hI87oI7c9tBcxD36vsYr4I1PXAUKWeFKbJaX9nsFlC8VQq5u
 zLoLqIQPZSyGOqhZk8Fi2iXicQZefCjDyx9IwinnLIaS3nXmkmACGaeMfETfgEggrNmT9vcLeo8
 crD0hXx2uy4lru+1s0Zuyt6ci6fRlkrIry94t
X-Gm-Gg: AY/fxX6XvXKN9axbbXZBAvORt6MLzy3vKX4J4FieixrEGP6jMh387qXt0HLOr5uv+Ez
 itWfNlKYxw+bBCqfNf87K8uBtAN9CLaIlNSHaLvGbIzOeHIn8c7MGH5AonadPZvHmw8Hq0yoza+
 TH9Eeqv1KFLgPQwGpbRRDCIIk4p+qZrDEAwqghLCyZi+a2OH4tsmMHOpt1TdoBUqls6XApfAOTp
 oDDscFruRFvSujaLu1qNWkkuPpxuRzMsEc82wgRr5CiU4QjPnzjsOC8coJi82K8fj6axsXhrPQi
 AGG3ymxHsH7nG6Iq
X-Google-Smtp-Source: AGHT+IGR3d7pVfWE3SCgR2YXGzPs+gmc9F9pkM9Maatp7Mhw5Y6tX15rIeW9cn82zs/KrKHZmq1qtfhVNHa8KfThZFs=
X-Received: by 2002:a05:6102:3c82:b0:5db:d60a:6b13 with SMTP id
 ada2fe7eead31-5ecb68dc320mr8177611137.21.1768230038862; Mon, 12 Jan 2026
 07:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
 <20260112120411.27314-2-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65654@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65654@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Mon, 12 Jan 2026 10:00:27 -0500
X-Gm-Features: AZwV_QjzxkkYwjV4p_-VEi4Dch70P3gBPj0dasBvsKzpwA_MEWPyyBEBlfnUFjs
Message-ID: <CAFn2buAZ68wHMpFy7LewBSECLsx7=wG0epwuVcJr2jzo2tnf0Q@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] eal: add __rte_may_alias to unaligned typedefs
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
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

> I'm wondering if this is the right place to add __rte_may_alias, i.e. if the scope of the workaround is correct.
>
> Are the unaligned_uintNN_t types only used in a way where they are affected by the GCC bug?

All uses in DPDK are for aliasing (casting pointers to access existing
memory). There are no cases
where these types declare actual data. Therefore adding
__rte_may_alias is semantically correct
and not too broad.

> If not, adding __rte_may_alias to the types themselves may be too broad.
>
> Does the GCC bug only affect the unaligned_uintNN_t types?
> Or does it occur elsewhere or for other types too? Then this workaround only solves the problem for parts of the code.
>

The GCC strict-aliasing bug is broader and can occur with other
aliasing patterns
involving struct initialization. This patch targets the
unaligned_uintNN_t types specifically because:
1. They are known to trigger the bug in practice (reproduced in testing)
2. They are explicitly designed for aliasing
3. All existing DPDK usage is for aliasing

Added benefits of this approach:
1. Simplifies existing workarounds: We can remove the intermediate
packed structs in
rte_memcpy.h for x86 and use unaligned_NN_t directly
(https://elixir.bootlin.com/dpdk/v25.11/source/lib/eal/x86/include/rte_memcpy.h#L66)
2. Provides safe aliasing primitive: If other code needs to alias
types and wants to
avoid potential bugs, these unaligned_uintNN_t types are now a
correct, safe option

> Minor detail:
> If the bug only occurs on GCC, not Clang, please make the workaround GCC-only, using the preprocessor.

I've only reproduced the bug on GCC, but __rte_may_alias is
semantically correct for these types
on all compilers since they're exclusively used for aliasing. The attribute:
- Has no negative impact on GCC/Clang (verified on Godbolt - still optimizes
correctly: https://godbolt.org/z/Gj9EfqMTn)
- Makes the code semantically accurate about its intent
- Avoids #ifdef complexity

However, if you prefer a GCC-only workaround for minimal change, I'm
happy to add the
preprocessor conditionals. Please let me know your preference.
