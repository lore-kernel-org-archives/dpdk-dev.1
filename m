Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A226AC5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 20:13:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54105402EE;
	Sun,  8 Jun 2025 22:13:20 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 80B184026B;
 Sun,  8 Jun 2025 22:13:18 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id E8AB21140167;
 Sun,  8 Jun 2025 16:13:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 08 Jun 2025 16:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749413597;
 x=1749499997; bh=2wk50riOdJls3YAq1+G2smEIqW2zRaUaGXOl4FFP1WQ=; b=
 huBZ029yd3RZ+xAQT9r/eF7Uj3ZzzZgDaqlCLBQhLbfb/2gOPNutLV+vZ7Zfc18F
 k2LjOG2PCctgC4A+vygnMiIhSP/bEoeQ9pl7KjH0PKj2N6fAcVadKQeugX0HxgWg
 N7K9UhDjWU46WdbOW3A4Y7/wimMV9QI4WvJzFMadgimuiLWFdCI4PWeWe3yZVMiQ
 /MAeJCRyo0FFnrH5u9RG3gdPpwEklijQGcZIwZ61VncQipvRJMycWZb2qH/oBJ9n
 6GQkwTQRvK+ZADTJjjIjmM+MWQlA6wQbGHCajbE97SSQLXi8DIgvycLBnQKIgs/3
 MS72AzIGVDFmZBfP47Ty7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749413597; x=
 1749499997; bh=2wk50riOdJls3YAq1+G2smEIqW2zRaUaGXOl4FFP1WQ=; b=n
 W74xk0a3MUGOa/a27tk9syTv83w5TOD6S0fsQPSqFcdtZPJ6rJxWfCCXwnu4Qz21
 UMtuMJM8GYX/5dPV8BfeLLawRK9euRIZyCp9uUMqAa188Bmm4GNfSZdKPHSGZ7Jh
 iS9/huMv7dWpsR7ITVuJECUYg4Bz+gh6YIoLuS6eVIAb+iTaN3cRlx7SBwcQbQLd
 ak1kHjgQS4AytJ2OkAg5P8GUpYsOJJ6IkyUOS06B5YqAGnY+/l8BOiSzc6BTg5L8
 +vKcjSgml2qcuL1NGgVfoUO7hMXTCH8uhd1NvVngtygp7TCkeRe6vS30ZE8ENuAs
 VgoGwg/d/3mR55WasizUQ==
X-ME-Sender: <xms:3e5FaNFm9_fFw2QzEIY3PynldRxznM6V730VXPP6CwiZ1AcJZi6sKw>
 <xme:3e5FaCWpWCl1efWp5byASey7aWShJhedAaKvm81TQlljliXyVA6r1CRQrUKkFtl6i
 bBD_UYBVlAt7QIC-Q>
X-ME-Received: <xmr:3e5FaPKaMz5AemyOUIE4saoScURc5mXAcCujVd13NBB1izEzFFjRGv8A-rACH8XmmPeckAQaKmyTTQ_-ceBFWxY7og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeek
 ueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvih
 gurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtth
 hopehrohhrvghtiihlrgeslhhinhhugidrmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:3e5FaDHRKdE6VqFSqGGIVaLuTiN5MqgWFQg-0Fb0edPWacO-uFsyIA>
 <xmx:3e5FaDXcLzTAWHptCT7G0ZFzJtbO8qZ3t6igJ7oK4hqbMQEncHs6AQ>
 <xmx:3e5FaOP8-q_qRwUk78ThFDKgnTm7VO55q6e1mDl01MdVnXt7gFcwXw>
 <xmx:3e5FaC0w89r68pTWcwelnCe8fSzsGkDrtdocK86nYzzvFIjXRnZ5uQ>
 <xmx:3e5FaNgzBQ1cP9lP9fTY8L5DFQIfBsnFwuu47XF1NfSMtaiq84Mhg7U8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 16:13:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH] test: fix race in per lcore test
Date: Sun, 08 Jun 2025 22:13:15 +0200
Message-ID: <4251275.1BCLMh4Saa@thomas>
In-Reply-To: <20250317143015.2559854-1-david.marchand@redhat.com>
References: <20250317143015.2559854-1-david.marchand@redhat.com>
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

17/03/2025 15:30, David Marchand:
> In some CI, this unit test can fail, as the main thread may get
> rescheduled while lcores execute the callback waiting 100ms.
> 
> Bugzilla ID: 1668
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.



