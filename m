Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8842CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 14:49:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CC204025E;
	Thu, 23 Oct 2025 16:49:55 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 9E82840151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 16:49:53 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 09B1BEC01B7;
 Thu, 23 Oct 2025 10:49:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 10:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761230993;
 x=1761317393; bh=e0ubFd739MbTDaIrqiS9k/qK/lfWTcc95tPpl+Db1Q4=; b=
 MLyU++lpLsRLVyWfN4ZbS8ybAsCF/LvwEgsoQCLl3s+6WeAjXxT9pup+qZuzxBAQ
 YV/mHvosaUvRxBM9IgdCKFyg58W/TLxpYzC4ibnksL1ZpTQuh3if7UXWcbn273OD
 TnCCNZ8KaoR0RSM/VN4lr2qdpWl8WcNL2BC59C7jXXsyjRXrbHemTCfLF5C74rob
 n8S1fWIlCC4VjPA0GcIw61Nk4YIZfXb0hAXKQ5Y0qlqwuFrW64HPQalDhQWsT3W5
 PUSBy0RQpbAvfQYjOPzaXaebizet6Kq/tuVV1L3zfDdcifIBHe+kNfPmxAvFmPY7
 jNWmrmkMZ/X9KalmnImBBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761230993; x=
 1761317393; bh=e0ubFd739MbTDaIrqiS9k/qK/lfWTcc95tPpl+Db1Q4=; b=v
 O50Mv0VAa/nN+b9rhdtLVjUSBM4sVSuUvxGEdeWws4Tw+RdeBadBK8wMHUQBQT90
 3bJ3Clh2WA2ZUhn1cqT/XQ94WyIenDgzI8N9J3es+Jur0ar1c8m8RBndDJwFJqrR
 aXnRrml6FGl7M/YHGhwPBNVAiSJn5U6a2raS2U4a9N5IzBkzGugo+BNFj+LTwQgY
 2HVVEYnuG1zTG2zY7wY3WzIj9RMoqJkfYTE3QKPLu4d5ta/KppZWbQb77PFu8pvG
 /yJsi6Wem5ysrpjs4V8+e95zXfurfdgdSu+UIqBp16G5KrBQada+cG3utg8oGeEy
 ZYFnni3RLLHb27w7kKcmg==
X-ME-Sender: <xms:kED6aG-QxteRp6YeghrpzWdiyKbr98gQRZpRe09-ohmYXOJzKX6Vyw>
 <xme:kED6aPqSn7ErGtS_EzjODSGQSJ-pPHY31XYWDPzs6pthm3pjQTfmU5lh7U6msah9V
 JBV-WgVlVTDE1hS-TCKQuQqY6YuN0dlYrh9-6VSGKKVPmTcgqs>
X-ME-Received: <xmr:kED6aHl4r5-ucqgP4i0FyC5-62HUjn4t7xYZGs5suYWw0iQUZHOPewU0topHRiCUSxV79SwMOWwQgP833rxr-NqapQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeijeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 shhilhdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepuggvvhesughpug
 hkrdhorhhgpdhrtghpthhtohepmhhkohdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhr
 tghpthhtoheptghkmhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepshhtvghphh
 gvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:kED6aOhC8JhKQl4wAuLJXxjMzzE7iluE-32BHeySq8DPCw4eBQCyww>
 <xmx:kED6aHdHDCEcZrUX1TkM9OvGTQWerarcxyoA14fzTpJbQE5sXNG2Jg>
 <xmx:kED6aGjHEBJDJxaZsV5uQZ7HV8y33BML3n_EbwhBPS6V-8UGxMo9WA>
 <xmx:kED6aHwmoi6jVQOpViNhJ8mF5X6ASulOMaGkOynZ2RPkbwX-KRxLzQ>
 <xmx:kUD6aKI9MgmaNeI4Bsg15h6Xd9CPaVnYzREaJWbMiZ8Ro2dp2iBgySCE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 10:49:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, sil-plv@napatech.com,
 ckm@napatech.com, stephen@networkplumber.org
Subject: Re: [PATCH v2] doc: refactoring the guide for NTNIC PMD
Date: Thu, 23 Oct 2025 16:49:49 +0200
Message-ID: <6896421.YiXZdWvhHV@thomas>
In-Reply-To: <20251023143506.587329-1-sil-plv@napatech.com>
References: <3590447.BaHzMo0RvP@thomas>
 <20251023143506.587329-1-sil-plv@napatech.com>
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

23/10/2025 16:35, Serhii Iliushyk:
> +=========================================================================================== =======
> +Supported Features                                                                           Linux
> +=========================================================================================== =======
> +FW version                                                                                     X
> +Speed capabilities                                                                             X
> +Link status (Link update only)                                                                 X
> +Unicast MAC filter                                                                             X
> +Multicast MAC filter                                                                           X
> +Promiscuous mode (Enable only. The device always run promiscuous mode)                         X
> +Flow API support.                                                                              X
> +Support for multiple rte_flow groups.                                                          X
> +Multiple TX and RX queues.                                                                     X
> +Scattered and gather for TX and RX.                                                            X
> +Jumbo frame support.                                                                           X
> +Traffic mirroring.                                                                             X
> +VLAN filtering.                                                                                X
> +Packet modification: NAT, TTL decrement, DSCP tagging                                          X
> +Tunnel types: GTP.                                                                             X
> +Encapsulation and decapsulation of GTP data.                                                   X
> +RX VLAN stripping via raw decap.                                                               X
> +TX VLAN insertion via raw encap.                                                               X
> +CAM and TCAM based matching.                                                                   X
> +Exact match of 140 million flows and policies.                                                 X
> +Tunnel HW offload: Packet type, inner/outer RSS, IP and UDP checksum verification.             X
> +RSS hash                                                                                       X
> +RSS key update                                                                                 X
> +RSS based on VLAN or 5*tuple.                                                                  X
> +RSS using combinations of fields: L3 only, L4 only or both, and src only, dst only or both.    X

When you make a table, you should not write sentences.
Columns must not be wide.


[...]
> +<object>.<attribute>=[<object-ids>:]<value>

Should it have a fixed witdth font?


[...]
> -``exception_path`` parameter [int]
> +- ``exception_path`` parameter [int]

Why do you replace the definition list with a simple list?
Did you check the HTML output?


[...]
>  Logging and Debugging
> ----------------------
> +~~~~~~~~~~~~~~~~~~~~~

Why? So there is only 1 main title like "Features"?


[...]
> -.. note::
> +   .. note::

No reason to do that.


