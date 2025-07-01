Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BDEC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 13:04:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC13D40264;
	Tue,  1 Jul 2025 15:04:20 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 93475400D7
 for <dev@dpdk.org>; Tue,  1 Jul 2025 15:04:19 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id D4F541D00116;
 Tue,  1 Jul 2025 09:04:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 01 Jul 2025 09:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751375058;
 x=1751461458; bh=ypYy4bAlKaEYhTB9ADQHqDKZk7GkBNLcKD8R6Pv1kEM=; b=
 L0WrOYOYVX5Ek02om7KnYLlLxNfU4fYvuaq2iYJiY5UnI5yRBbERtNC5EWYvXm+w
 pHqL8ARD3RBBgSjGVFRErWIcgUtNVXL7J2/KEv4WhkK1fr7kiTDH79jofmDy8N5L
 +CY53U+2aK1W/Uo8x+w/sJFI9ju24wpkQp9583C5bYKDLaWYoBgsz/5gF5+S+jUw
 pw4qA/mvbote37vUY52ZyAoKQ3ZjDuDMVa895dfiHRwzLwx/WTvL1X8czAW++lmj
 wbHMrXo9iAPL25z9kSVyY2DQ4HHpeCZhbkbzJUlnmlcb9d/ur8imtOMrFMaSzKFC
 0krsVuQZ/9N939R4NyovPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751375058; x=
 1751461458; bh=ypYy4bAlKaEYhTB9ADQHqDKZk7GkBNLcKD8R6Pv1kEM=; b=k
 k4eK4RAgv6ueLF6s4myhZ3X+vMkMbuABQKl3D5cMCIExEYkAivh8sZlugNZspP2j
 w0PTePZiuZift6jAt/LPcqv2HTIxvEjxiqZq8OQn3v9ZuJOi5k1A5v6eoSoZGxAH
 wXS8y4LKua+Sg7otf5+qha2E7yTKz+4tWW561jWNwwUsDx0iZwyU1bbpsAYIcwgF
 UNDUBhqGtm6HoN4vu6Ld+KK60h6VYS7ze8xE3hp1d/GLj8mQEoVY0d1vAZlcq77w
 ngfkRo3lrcSS/VZya+gr9BWdCuve/5seIHHpD+DN1LQvdugvlfV0xI5sevu4h4Sh
 M3HsCzn+IMplkJJBiRicA==
X-ME-Sender: <xms:0txjaK24n5GJWgF4OzH4gCdCbTuY8W0SLjQNObpMk2xpEliPfouNxw>
 <xme:0txjaNErXw57hb-tTu9kUou1leAi2WeSKs_t8ur4pxCQJ1eNjeI-0WIwCgdrxFVqe
 JY1LaFBymCz4wgsjA>
X-ME-Received: <xmr:0txjaC7G7znQSeNWZWA0PCuDo9hOzVvKj3LFoW3MlnVzd9oZNOFvMD2e509YFwZAGbx6pA8MOXGLMYNYHOWTSlZ8aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeiudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:0txjaL0hcPIXIS6zST-dznEwafMPVB37jJOPJG6fJ3IbpNyAvpTtQQ>
 <xmx:0txjaNHvjTSCzyMw-sZtIfi0bz6z3KsZNhulh8YNr09bbQ7ZF7z9UQ>
 <xmx:0txjaE9-d7mjhIV9lgjc8z_PUf6WwXJcEzz7VpqV3mC0onxUQWHr2w>
 <xmx:0txjaClTzbgQYM4BCqr4U9Sp_MwKUPfF2q_7tDSmx1JECgL0K8Bwew>
 <xmx:0txjaDVRR6OrwHhNCHuvY9azieBdl-6ZBQR2adgMwjz8jTejxWRfmozg>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 09:04:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] node: fix C++ compatibility errors (option 2)
Date: Tue, 01 Jul 2025 15:04:15 +0200
Message-ID: <7481254.gyZViRk3AK@thomas>
In-Reply-To: <20250630105025.2265901-1-bruce.richardson@intel.com>
References: <20250630105025.2265901-1-bruce.richardson@intel.com>
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

30/06/2025 12:50, Bruce Richardson:
> C++ does not allow zero-sized unions - they end up being of size 1-byte,
> which leads to C/C++ compatibility issues, flagged by the compiler.
> 
>   lib/node/rte_node_mbuf_dynfield.h:78:2: error: union has size 0 in C,
> size 1 in C++ [-Werror,-Wextern-c-compat]
>    78 |         union {
> 	         |         ^
> 		 1 error generated.
> 
> Fix the error by omitting the persistent_data field when it is
> zero-sized, since it's unusable. Any app using the field must already
> specify a size for the persistent data.
[...]
> --- a/lib/node/rte_node_mbuf_dynfield.h
> +++ b/lib/node/rte_node_mbuf_dynfield.h
> @@ -69,6 +69,7 @@ typedef struct rte_node_mbuf_overload_fields {
>   * 2. Overloadable fields: Fields which can be repurposed by two adjacent nodes.
>   */
>  typedef struct rte_node_mbuf_dynfield {
> +#if RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE > 0
>  	/**
>  	 * Persistent mbuf region across nodes in graph walk
>  	 *
> @@ -78,6 +79,7 @@ typedef struct rte_node_mbuf_dynfield {
>  	union {
>  		uint8_t persistent_data[RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE];
>  	};
> +#endif

I didn't do a deep analysis but I think I would prefer this option 2.


