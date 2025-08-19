Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E372DCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 15:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E97440653;
	Tue, 19 Aug 2025 17:29:34 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id D2892402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 17:29:32 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id EFD6F7A0148;
 Tue, 19 Aug 2025 11:29:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 11:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755617371;
 x=1755703771; bh=s/APd69/uC0gwgr711LGvSoLQLr4cWZVTnb5ZeBhrXk=; b=
 kuboQw+wm19yaXh1KBoqjAIxtPRCLJy9haHtxS4jXfpi9NqwJOdfXJs0DYb8W/HE
 k1tlAEPuj1CMPq8wJUUsuwpRKeWxWQlrEZuezU7Zepxux++7m9NsrUqFkShewyz0
 E8bfKGR4DxrU16ydEjWEbKK9HNbzLerRT32STnIMUGtF99gbGGgRccd1JRWe9aUY
 UhjcEWRRNQ4eVOlNpxyxrOerTjkSCO/r5x1qsylWkGxEyIEpaPhQYeLlkJkI4U1i
 q8PAc89M3+DR/wXaJVwremErpH34veYPkRrb/d9FREKKkmNw0Etk240wGuGb1l6z
 rcV87AjhnhBW6Zx+DZf73Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755617371; x=
 1755703771; bh=s/APd69/uC0gwgr711LGvSoLQLr4cWZVTnb5ZeBhrXk=; b=K
 XTJeKRFG5MJ8CqsDHHmjNuNHMMgXBEF/erA+hIz5yLXOJ4cH9U+t/XRdRN4KnQ60
 6el6eg0SAdB2/jwFt2asndilRkflWJ7Nt8C2g8xROzUlzcsOo9v5NRf21BSylqlw
 bTH5Nll6Uog4wWsNxBSU+cyn2rw3tIY8DDN+gfty37qkWlrhtfG+tZ59EYeS6SwA
 AaJF18tXOYsj1R0wU/AjgXm/VTEKBEkS0ZImPZAT37LUI4sN9qtyIcII/nGDgEw9
 zZexaaE399TFTtErnzAcfzsaP+vgW6uu8qJeMZEdIjVDU0kUP44f5cIDRvTq7sha
 Am8nPu5Oj1Wvp7kRQ7FhA==
X-ME-Sender: <xms:W5ikaND38yO8rP2eks2G0ZkJR_fXl8jJbwJC4S3Ywcb2HF7eF9B3OA>
 <xme:W5ikaGFxL8GdopPmnRe8G8hBogtWZmxvFswFUh4G9NzavGPiqi9JSlaakJuRhoLOv
 -VeXWLAWnKZ3bZlsg>
X-ME-Received: <xmr:W5ikaFJ6nF3_NwHaAijsqxAiliGS3rP583q6kjyprQoU-989gs7MfPisEUyLqhYwP8zqNkX1qlkqE72BuYE3QSsYdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehkeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:W5ikaKn2Xv4kanRSz9kPGiFlih0kRukM3B1zufUtC0ZqyjML6UYQjQ>
 <xmx:W5ikaNQpbeBnBCRB6HauhhygdO6IVS6Ucu6iJ0AlskgNvZrKj2Bf5g>
 <xmx:W5ikaMJaapG34zPqOq1w_wJRUZiATxDQodBpjGz7sU2biHZjG5_0Wg>
 <xmx:W5ikaDDX13nEo2Ko4sp8RZttuYHPquDygn5pk9xKA1NMiayB3vXdiA>
 <xmx:W5ikaFIdJ6f_G2DmCnzAQX22L6QBl-ZIVoGQMc8HvOJtbaCYCK6nKLA6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 11:29:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Date: Tue, 19 Aug 2025 17:29:28 +0200
Message-ID: <2710899.tIAgqjz4sF@thomas>
In-Reply-To: <20250819082444.66718343@hermes.local>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <2598643.Sgy9Pd6rRy@thomas> <20250819082444.66718343@hermes.local>
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

19/08/2025 17:24, Stephen Hemminger:
> On Tue, 19 Aug 2025 10:37:27 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > 19/08/2025 01:27, Stephen Hemminger:
> > > +++ b/lib/eal/include/bsd_queue.h
> > > @@ -0,0 +1,1075 @@
> > > +/*-
> > > + * SPDX-License-Identifier: BSD-3-Clause
> > > + *
> > > + * Copyright (c) 1991, 1993
> > > + *     The Regents of the University of California.  All rights reserved.
> > > + *
> > > + * This is a copy of sys/queue.h which is used to overcome
> > > + * missing parts in the glibc version (and Windows).
> > > + */
> > > +
> > > +#ifndef _SYS_QUEUE_H_
> > > +#define _SYS_QUEUE_H_  
> > 
> > Shouldn't we rename this include flag? with RTE_ prefix?
> 
> 
> No, by keeping the same prefix if the user includes both sys/queue.h and bsd_queue.h
> there will be no confilcts.

You mean by checking _SYS_QUEUE_H_ which is the same as sys/queue.h?
So if I include sys/queue.h first, I will have a limited version.
It means we should not include it before any DPDK include.
It looks like a limitation for DPDK users.



