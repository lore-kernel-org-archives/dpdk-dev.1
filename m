Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3895CE909B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:34:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3672D402ED;
	Tue, 17 Feb 2026 15:34:07 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id D483340261
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:34:05 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 579001400165;
 Tue, 17 Feb 2026 09:34:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 17 Feb 2026 09:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771338845;
 x=1771425245; bh=Ik/ZjYKYVM6eYp/azaeTCG1GHuh+0BVyqTq2cyO/y2o=; b=
 ZLogXhrrOVI99cGTbW2qCCj75PENT9v30wt1vQTUzeLvo7gW7sVhwvIiAUVzvyUg
 +d45cju4AFApvldRd/cQ6OT8f06pU57nSDzms7MgI0gC21iU0C5bbp5Dq+WCky9+
 paQ4Ysmny7Mps8srknSGaf8a58ZbSssz/GSN0AnP64WkXEyjq6hpXM6Q/Nse+rrw
 IvDX9q75DzUMJj9sNlbdjv9EjC7s2TMsEjAa4HAY6Wt4m5HVbcOvK2DlZ38bEQE1
 V3YKXI4xYPBTCIZ4P2/i+ERRljxoO+CZFZT1O3qf5ICcYUanw4DYcmdFy2JXcdhQ
 L7ZyUqhnBB/I6G4YVSIlPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771338845; x=
 1771425245; bh=Ik/ZjYKYVM6eYp/azaeTCG1GHuh+0BVyqTq2cyO/y2o=; b=u
 WEydjL+tzY9p4NcCVuzLWiwgS/JuizwbjuB+lJgnkU5ZAI95S8o71Y3Koylku2yG
 KmSzkJX48Z1bo62IvY3+iUdZCN6uvc2QKMoG+nRqu9wDs8E5DcR7EhHVGBEbQKL2
 Fcfs+g1b/1SL/Bmx2UNJiz5luhCLZNummxU387SJ5Sarzvn6r8w6AaC3h2JHCraF
 MqECt3TMyZYbdg2nZwCe3Pni1T/wYu8i46TFfAU6A7qgnVKn9XFXX96pLdXWiIaO
 iAJF8rOgi1GqusIrlNPusP4qEYOeD9XznJvSyp+XHMqN5Gf3TUBgZ5zZcgQ3MJx+
 ETTsgdvoO3kMzQ1DF0SJw==
X-ME-Sender: <xms:XHyUaVKZJd65l1-tdz8etd_o3jGVl79YprHe5JHPEyBq24VM7okevw>
 <xme:XHyUaVff8W5CZ9Trm8PzD3DMJMXchzR9oIWcG6xc7XpVn33fNUEW2oc70STZ-V07J
 zctHCRF4YAQbsrLDiGGcd70wIdHfrFaH1_xJiXrCXkXFYnkgIbu5Q>
X-ME-Received: <xmr:XHyUac30bL1FJtSWjtfVticWVWHUk0VE_p_Bj2Ypi-6GKFIVYhwn6Unhjjqfz_8nlGKdwnEcDK8GpVd8t3rroYPiOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddttdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehrvghshhhmrgdrphgrthhtrghnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:XHyUaehgIrCRO979BAr6BtKSocEUPCTrS0VJP_M25oaROsEZe0qdTg>
 <xmx:XHyUaSS7EZy2WPUPo0W-8EV7hgBMpLQVgYOMhcHMGcKVQ0wnhstV1A>
 <xmx:XHyUafiJqQfspjr9wV7ly5fmlXqj0I9AI9_k5Ut-_xZ1uSwPrk3JKQ>
 <xmx:XHyUaS4KJkBVwcDBm0t9GWu3Zcr9NpDisKBJLgzxz7mB5OlYutrWnQ>
 <xmx:XXyUaV2j6yy5OdmoykHP3emJgnIqXsVEtK6DRqBkLV0oI_E3-QtUR3H4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 09:34:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v8 3/8] pcapng: add length checks to string arguments
Date: Tue, 17 Feb 2026 15:34:02 +0100
Message-ID: <42012286.oYI2Z1FBsz@thomas>
In-Reply-To: <20260216214311.717492-4-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260216214311.717492-1-stephen@networkplumber.org>
 <20260216214311.717492-4-stephen@networkplumber.org>
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

16/02/2026 22:38, Stephen Hemminger:
> The pcapng file format uses a 16-bit length field in the option
> TLV (Type-Length-Value) encoding, limiting strings to UINT16_MAX
> bytes.
> 
> Add validation for string arguments to prevent silent truncation
> or buffer issues when callers pass excessively long strings.

GCC warns on a remaining issue:

In function 'pcapng_add_option',
    inlined from 'rte_pcapng_write_stats' at ../../dpdk/lib/pcapng/rte_pcapng.c:376:9:
../../dpdk/lib/pcapng/rte_pcapng.c:136:17: error: 'memcpy' forming offset [2048, 65552] is out of the bounds [0, 2048] of object 'buf' with type 'uint32_t[512]' {aka 'unsigned int[512]'} [-Werror=array-bounds=]
  136 |                 memcpy(popt->data, data, len);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../dpdk/lib/pcapng/rte_pcapng.c: In function 'rte_pcapng_write_stats':
../../dpdk/lib/pcapng/rte_pcapng.c:346:18: note: 'buf' declared here
  346 |         uint32_t buf[PCAPNG_BLKSIZ];
      |                  ^~~

I have to do this change:

        if (comment)
                opt = pcapng_add_option(opt, PCAPNG_OPT_COMMENT,
-                                       comment, strlen(comment));
+                                       comment, strnlen(comment, PCAPNG_STR_MAX));

I'm not sure to understand why it fixes the problem on the buffer of size 2048,
but it works.


