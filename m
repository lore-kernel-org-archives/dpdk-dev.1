Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBBAC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E64D840693;
	Mon, 11 Aug 2025 15:21:49 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 62186402AC;
 Mon, 11 Aug 2025 15:21:48 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D30B21400097;
 Mon, 11 Aug 2025 09:21:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Mon, 11 Aug 2025 09:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1754918507;
 x=1755004907; bh=OvPS88J7eOE1jXthcH4fFzssTdArhxg0+JRlNwyCQ3Y=; b=
 qVq8vZpfpzQt/ZUisbhXnthZEu2U0N21KLC3R1+eiLCMbQuviZvIC/ZnBenAgFGT
 1yxTygNK94tY46nO/gwtO6yAjZb9Sz7kFu6SdOyU1ZASdqbDYKy91HkeuUJm05K6
 E+Z4VZAbWwEEa41tKUY8Nkf77bXTq7B2kTUT5OIg13cYnm9DnjBjWECjojovm3V3
 O+yUjwNtcpfEuEHFkMHGQyPqK1lv4QW5Z+AldY4XspgSVFQnRJRClfYfPaZvKxh0
 yJfEBzxw0i5YidjADnZmUd+UjSMKRT7G0cdXAzBh8QkvlNDNESeJcBnzyM+cO9aW
 +e+4kx88bqeWg0taSHrdcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754918507; x=
 1755004907; bh=OvPS88J7eOE1jXthcH4fFzssTdArhxg0+JRlNwyCQ3Y=; b=k
 KqTtEIsDRMY9MwbL9fIM0rbdsvjI9dZsrykHQwvOvtFPp7a9A130J9blL/8r7ZvF
 Mj+elUkzEppfkGwLmOOITOM/FWzsQpRj2MjglQ6AGkbYA+OFEeU0YLF+fbSFl9IJ
 bQUK208DY0SFnemJOxYKDUNhM5HDE4FSA8b5f7jXmC9ZomKsH3b0DXn5ZVj3MmEZ
 Ygj0kkKRjq8bNze6/Rwrj9ZxBPePpm3HVHw75KB33PbDsZmaY8wcaOTUC7dnCQ6C
 rA+592+VIC7pBbuN+EYPkiZD1zYoSsq/X/PF+hzWr5IDpgPLCCrxRZAe88sNkpaQ
 2F+gu6KfCOHCHSkar+OPQ==
X-ME-Sender: <xms:a-6ZaIhcT5hKUgGxE9Fgp1sO3q8HbBDaz_DzMk9IqkFoG5SLOOiDBw>
 <xme:a-6ZaGapN-zyk-RMeaVrBALSQMmo1QjpjUmqq7V0UL39VYWVzNGmiqagCxYfNhzcM
 mnUDZTfBkLJEMbzIA>
X-ME-Received: <xmr:a-6ZaASrGU_PV9ApxyCFNe2-Tj4rS4ToczSKSxQE2aQLFD7yuQ7YtCEpx1ndtt_2imo0CmKZ9L7quBCqp_11cZFjUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvheeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epphhrrghvihhnrdgsrghthhhijhgrseguvghllhdrtghomhdprhgtphhtthhopehprhgr
 vhhinhdrmhdrsggrthhhihhjrgdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhope
 gsohhrihhsrdhglhhimhgthhgvrhesuggvlhhlrdgtohhmpdhrtghpthhtohepshhtrggs
 lhgvseguphgukhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:a-6ZaJT7VYDi1mLctltsG8MDXePHmgKVIWIKaXzRiX_HRLSTi3kA5g>
 <xmx:a-6ZaERAtK4HixiK-xgKU4uoW_Wx5eCpTNBLOFYXfK5DyYoL6rhmAA>
 <xmx:a-6ZaO4xQsBwalvcXWer0b096ujWdA49iTQtNnFR5ydGcYXPDRenvg>
 <xmx:a-6ZaA1wb8QnpyuwAg7Uxb2GbvZ0vlOnf34JqFDinuh2q8vwcPaN-A>
 <xmx:a-6ZaOTo2kI5A-4j9g3myaMJbcixxuGkbT0jaSucb6e2uy9Ip3n8Vl-n>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:21:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pravin M Bathija <pravin.bathija@dell.com>
Cc: pravin.m.bathija.dev@gmail.com, boris.glimcher@dell.com, stable@dpdk.org, 
 dev@dpdk.org
Subject: Re: [PATCH 0/3] PATCH 25.03.0: vhost_user: configure memory slots
Date: Mon, 11 Aug 2025 15:21:45 +0200
Message-ID: <2263105.NgBsaNRSFp@thomas>
In-Reply-To: <20250808051305.2386231-1-pravin.bathija@dell.com>
References: <20250808051305.2386231-1-pravin.bathija@dell.com>
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

Welcome in DPDK community,

Thank you for contributing.
Please check this quick guide about our tools and process:
	https://core.dpdk.org/contribute/

There is a link to register to the dev mailing list
so your future patches and replies won't be moderated.
Note that you can disable receiving all list mails after registration
if it is too much for your box.

More comments below.

08/08/2025 07:13, Pravin M Bathija:
> add protocol feature support add and removal of memory
> regions/slots dynamically.
> this patch set has been tested with multiple instances of fio
> connected via libblkio to spdk target backed unix domain socket.
> please apply this this patch-set to dpdk mainline as well as
> version 25.03.0.

We didn't plan to maintain a branch for 25.03.
Do you think we should?
The next LTS branch will be 25.11.


> Pravin M Bathija (3):
>   mailmap: add user

This patch can be squashed with the next one,
but it is a detail which can be handled by the maintainer.

>   vhost_user: configure memory slots
>   vhost_user: support for memory regions



