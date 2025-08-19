Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B94CA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 08:37:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E1B440289;
	Tue, 19 Aug 2025 10:37:33 +0200 (CEST)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id B053D40262
 for <dev@dpdk.org>; Tue, 19 Aug 2025 10:37:31 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0F3AE14006D4;
 Tue, 19 Aug 2025 04:37:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 04:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755592651;
 x=1755679051; bh=4KHcHj8DgO2hDeSsPXw4DBua3AEVBdJSPOwNn9ACF1Q=; b=
 DWXfnW5TL8z51ekpw9KjNXEI4Hxan5OfOuVNIB2HkwIN3FgV5K0Cp5rrqvAqunwY
 35NbmuhF7sEaerMK+SPBXil26KSaqiUON0L0EusgCi3T4djAyfGXBkCVi4ZAniIi
 hcFXCgJy8zwW8DoUfCJNmHVvI974oEXdz8V7SnytPJH6ZIpjdTGuuc63I0bokmuO
 n4U53hFG50KLWkv3fSro2ZrMpva8MPfOV0iFlUsRmuZceijhsxhXrR23ihqbULdW
 EXNG+RDlijBTiWqXHc0qZIXkKJPZOPujbmyxEfkHkQWS/aduqZBgm9C0lpxKxwC/
 e2LBgXrPiLUZGs1IdaYnmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755592651; x=
 1755679051; bh=4KHcHj8DgO2hDeSsPXw4DBua3AEVBdJSPOwNn9ACF1Q=; b=d
 +q3g7UDACKf7ZvzK2+6L7NXJjvUx0RDwILJ3SfXmfl1HJKl6OGaYO4NR3Dh/L07s
 /EBps486/8l8LgkxdOhvGa4z/LwJtQKUiDTaUWcPqhUzzou+cCY3DdSifjHo4KYw
 VnFc7QQugXSM9jzc4kRzRiEAOmJMTfCHU3auQdW4OsdVeQTfGTHKnVlGw+k7Of7a
 7WOXePYfkBz8i5sRxqXXs9Z0kqmuZqwAOU/vF6tYalKGKuO2vvuDJ6RdX7cVYLhA
 0gyz6bvumdwJ9jNnZpnshSYOJQgA+8jSoZjsIp+Lo0neuUs0TKoTCaLs0rRTKbFG
 0yERoDEm9rQceLyPF0Csg==
X-ME-Sender: <xms:yjekaEbBDl5hUk7DMhR1_r6BIelbmIlr_zpdqFqSqqO7tpEBhb5QKA>
 <xme:yjekaJ88X5wA0kuJx0bGaGnBHzTWsZaU-YNWgl0IpzGQsiZoulrWJEkvYzHvFVMiV
 H6MFGQs7ZU5OzhsWw>
X-ME-Received: <xmr:yjekaLi3t8Lu6RTDVTfRb3ZXPoGflCTtoHU8vtefg6bIG-qmMyKdgNu9PwZg1xWvHD1EXzXgXPxlycu1pTFJ23dgrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehtdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:yjekaBe_KZJmlGTGFpbShjp09MH-L8mX5PD4W81vUJQExn4RvnnWVA>
 <xmx:yjekaKpUPyeIGBD6egeU9AKFrjcxlYJo-Qhn7nrUdFiwyZKHBj8xMg>
 <xmx:yjekaODbqpxXyzFFYqEG6o0buB-0n2Se7BPfnwOcDDPGRftb1T-RLQ>
 <xmx:yjekaPbE90M0Vx55XoC8lTmtsj4XMuZi8O01qykQMIwJ3SgC8GjNgA>
 <xmx:yzekaHj3Md7CyQnqt0aRbp6u8A4Uoj78DsKnx6hCWFtB3i2DoB3hmf2X>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:37:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Date: Tue, 19 Aug 2025 10:37:27 +0200
Message-ID: <2598643.Sgy9Pd6rRy@thomas>
In-Reply-To: <20250818233102.180207-2-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250818233102.180207-2-stephen@networkplumber.org>
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

19/08/2025 01:27, Stephen Hemminger:
> +++ b/lib/eal/include/bsd_queue.h
> @@ -0,0 +1,1075 @@
> +/*-
> + * SPDX-License-Identifier: BSD-3-Clause
> + *
> + * Copyright (c) 1991, 1993
> + *     The Regents of the University of California.  All rights reserved.
> + *
> + * This is a copy of sys/queue.h which is used to overcome
> + * missing parts in the glibc version (and Windows).
> + */
> +
> +#ifndef _SYS_QUEUE_H_
> +#define _SYS_QUEUE_H_

Shouldn't we rename this include flag? with RTE_ prefix?



