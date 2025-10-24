Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD2CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 13:46:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C12440151;
	Fri, 24 Oct 2025 15:46:45 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id CAA1E40150
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:46:43 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F0E177A0058;
 Fri, 24 Oct 2025 09:46:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 09:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761313602;
 x=1761400002; bh=gAI+Jbeu7kPsLrBAf7Wtrz3sgvjjzHdvHHyXhyyT1Yg=; b=
 URa/QjAYVkYyZQwmV+NU8L6Ry+MceIutm2beDN4mubvj2G5FaZ6JJxHO3kFKmiU+
 qIRQmpbZZvch8KEV1352hYfjBTZRCdG26rQIJPYIjfg1v6uU/aBev7C68N014FuC
 zyooxJ1sLyv1FNDBANXvINwLhUGEcTIu3roBnorxKpfo3dzmIuj4P1LN6le0ZhTO
 hPeRCgAimpvJ1X6yewdh9gH6z9oZifXWuhjHi7rgc4/DK+j5LhIj9B5coeJ8TNEN
 KmLb/z5InhWtB+BuDCqmCwIefk34sdO7paRZxTy20YZSEcZZFjqGZQxlzVu9vis9
 EwKNr93sQAK45BW61fOMaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761313602; x=
 1761400002; bh=gAI+Jbeu7kPsLrBAf7Wtrz3sgvjjzHdvHHyXhyyT1Yg=; b=o
 WId0213KIXBL1ALGohWFtS2KnT4RA/lgfsa7QtxVKKf6DyvNmuknqhh2764CbB4U
 6F+s8YdOhVMPTP97HCgJW0KjE8AQiInOPUFJ3BThvw8HfbxVH/HYEgnuRaoZD+NX
 ctlzTCj7lzFjc7fgUdPOeCqCpYjxIySHnAaYG+Zo0+qVvNktuh4Km/ZwXl2wxJfr
 ULfLzFt+LZBCZfTPrxBssvgMAiryTuIgoa976dzP9CsFy4zZJClGkLqWA4mIIwJS
 FmjAAdU9KegH1JQ9QcQMzVvfyPm0x2Xfiqqyku5VwvYW5PgLnyTYL1UvFijqvzcj
 UzQ6fadO2DTJn5ZWYGlfw==
X-ME-Sender: <xms:QoP7aN9Q1oW7q9pFMctkfB8fW2pMwPx7kiglpcTHNPClB50yqdwTDA>
 <xme:QoP7aNIWE8d6fZtZhqzBpSBbVx3JOh35he7hXBbBkw9h2JWQmp5j4I_ZVk7wuKFMw
 vV23AFv94_Jh_llGxVxxjT6lDw1ZM65AEQoMgskPSnG4S2_RhM>
X-ME-Received: <xmr:QoP7aOh2JJe7xawN7IMF7MILIdAIzOhV9Sj93r5w6tqdS-v6TTIB-1xIYqiBY0_mpSwd0f2PzaZg1hbcCMDnMRPW2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelhedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 shhilhdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepuggvvhesughpug
 hkrdhorhhgpdhrtghpthhtohepmhhkohdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhr
 tghpthhtoheptghkmhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepshhtvghphh
 gvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:QoP7aF73ZwYWGTLqViArUNBWS9JWmlq6F1h2OX24iUxMjOpZmEcVXQ>
 <xmx:QoP7aOZZPVTRoXMX0sgIlTH9ZKhLkZkvhbTI3eCxgqmktcsMF3BV6Q>
 <xmx:QoP7aC4VjdaiCozBF9a54kDYOA6C2c4VZN44dPxQ4du7w1XTB03Dkw>
 <xmx:QoP7aJAVl7piPCa7iC0LS8fesn9---d6KV1gWyDoCefG44acJjMS9A>
 <xmx:QoP7aOJ8-m5-vkqhwkWB-75Slmt2IPcqeWpqQ72SSkCyyym0UB1aLbUu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 09:46:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Mykola Kostenok <mko-plv@napatech.com>,
 Christian Koue Muf <ckm@napatech.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: Re: [PATCH v2] doc: refactoring the guide for NTNIC PMD
Date: Fri, 24 Oct 2025 15:46:39 +0200
Message-ID: <2974305.OYXXYNVTWy@thomas>
In-Reply-To: <VE1P190MB0830558DE6BA8A793E1D6D5380F0A@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <3590447.BaHzMo0RvP@thomas> <6896421.YiXZdWvhHV@thomas>
 <VE1P190MB0830558DE6BA8A793E1D6D5380F0A@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
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

24/10/2025 15:30, Serhii Iliushyk:
> From: Thomas Monjalon <thomas@monjalon.net>
> >23/10/2025 16:35, Serhii Iliushyk:
> >> +=========================================================================================== =======
> >> +Supported Features                                                                           Linux
> >> +=========================================================================================== =======
> >> +FW version                                                                                     X
> >> +Speed capabilities                                                                             X
> >> +Link status (Link update only)                                                                 X
> >> +Unicast MAC filter                                                                             X
> >> +Multicast MAC filter                                                                           X
> >> +Promiscuous mode (Enable only. The device always run promiscuous mode)                         X
> >> +Flow API support.                                                                              X
> >> +Support for multiple rte_flow groups.                                                          X
> >> +Multiple TX and RX queues.                                                                     X
> >> +Scattered and gather for TX and RX.                                                            X
> >> +Jumbo frame support.                                                                           X
> >> +Traffic mirroring.                                                                             X
> >> +VLAN filtering.                                                                                X
> >> +Packet modification: NAT, TTL decrement, DSCP tagging                                          X
> >> +Tunnel types: GTP.                                                                             X
> >> +Encapsulation and decapsulation of GTP data.                                                   X
> >> +RX VLAN stripping via raw decap.                                                               X
> >> +TX VLAN insertion via raw encap.                                                               X
> >> +CAM and TCAM based matching.                                                                   X
> >> +Exact match of 140 million flows and policies.                                                 X
> >> +Tunnel HW offload: Packet type, inner/outer RSS, IP and UDP checksum verification.             X
> >> +RSS hash                                                                                       X
> >> +RSS key update                                                                                 X
> >> +RSS based on VLAN or 5*tuple.                                                                  X
> >> +RSS using combinations of fields: L3 only, L4 only or both, and src only, dst only or both.    X
> > 
> >When you make a table, you should not write sentences.
> >Columns must not be wide.
>  
> I will fix it. Is there any value for column length?

No value, but keep it narrow to allow adding columns without going out of space.

Descriptions should got somewhere else, not in a table.

Look how links are used in mlx5 doc tables.


> >[...]
> >> +<object>.<attribute>=[<object-ids>:]<value>
> > 
> >Should it have a fixed witdth font?
> > 
> It may have a fixed-width font. I can fix it if it's required.

Yes, it is not a sentence.
 
> >[...]
> >> -``exception_path`` parameter [int]
> >> +- ``exception_path`` parameter [int]
> > 
> >Why do you replace the definition list with a simple list?
> >Did you check the HTML output?
> > 
> I did it to make it clearer when viewing the doc in RST preview or in plain text.

HTML output should be the priority.

> >[...]
> >>  Logging and Debugging
> >> ----------------------
> >> +~~~~~~~~~~~~~~~~~~~~~
> > 
> >Why? So there is only 1 main title like "Features"? 
> > 
>  
> The titles have further structure after refactoring:
>  
> NTNIC Poll Mode Driver
>     - Design
>     - Supported NICs
>     - Features
>         - Limitations
>     - Configuration
>         - Command line arguments
>         - Logging and Debugging
>         - Flow Scanner
>         - Service API
>         - Service API for user applications

OK

> >[...]
> >> -.. note::
> >> +   .. note::
> > 
> >No reason to do that.
>  
> If there is no tabulation, the section "None" grabs all the text below in the HTML.

So the problem is opposite, you must unindent the text below, right?


