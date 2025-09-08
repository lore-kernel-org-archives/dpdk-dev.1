Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEA7CAC582
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 21:29:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 249B7402CD;
	Mon,  8 Sep 2025 23:29:54 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id ADDF14025A
 for <dev@dpdk.org>; Mon,  8 Sep 2025 23:29:52 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 47317EC026F;
 Mon,  8 Sep 2025 17:29:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 08 Sep 2025 17:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757366992;
 x=1757453392; bh=nB6kIED994S8AtjzclFyg0NzcDP+ZIw1TndLkjnogL8=; b=
 p2ihL3M3su/3fn7O0Ng5NmqY4bEUyyXr+r6h/BDiqDrnZvJqTHhfJ/mFqQS80vmH
 k5d5C6O1tpbXPKYfgPZFN3hb0t2d87Hkbjm1iUlnCcaXYWtXMeY8zF+Vw/gqRUSK
 GYDgiXMCgvyYu7BbVMLbEDN51qXApPIYe0pRcIacnKYTU/FhfXpswpNcbA2OocFi
 nCh/TrTZBOZV8Xej7kSy86aj4Ripmkj5rZ7OY+kZ3V/GPt2Ia4ZduWfbbd1Im/dW
 4DH/23G8m5lh9NnxqxeXFXpVKkYGehRVrkmIXEAkGNDRjvfNJ+fIKnXKWb10LZXU
 iHHmIGFkiDW92B9bzeUTsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757366992; x=
 1757453392; bh=nB6kIED994S8AtjzclFyg0NzcDP+ZIw1TndLkjnogL8=; b=G
 fvkoSbaiTcQNttRIsJMOQkeCUCzdr1nfh87WjNwU/4Kb8dJYYHVl5Px0GBCu8AYH
 wTnuoXuWiRuu3q+P1FEuNpxbVQa00JA31wRBnd4gyKzcf+yMAlQv6bWeJkC4OPBL
 pLDsv6YQq+6TaLW9AxtYURik2yFWbJEJ4ClW9rHXCAcb6lPzIHcxMvvU8PDcEHuR
 flR8fDxcOmakYtpo7CoZLIwSKoud3kiGFRuBk7m0Dtgllqu6E1Dmrgm6EgxejD0c
 exnB81PWKVeDMQ5pP+rULud7wz8OvHla/Z6qtiMBcBCktVuS/SzVdxAYMPv1/aPt
 MfXL9wVZWAK0ZPwLPC3hg==
X-ME-Sender: <xms:0Eq_aLWkn55JHdarCVcpDUTuq3DZSvW7IBIfpQbjbBBuAQf3EU_roA>
 <xme:0Eq_aA8okFg5U4N9oevYbNY8lSLCWOnjM82I8GFxuWc4t069Eds9Foab3JXgACQNq
 TWz5fKXWtb5PCbFWw>
X-ME-Received: <xmr:0Eq_aA6ZpOsYl9cKq7gDMSo5usT3VXcCWBBKw99uVJtvkrFpFcLbCe3I5WN66m0ncwlAXRztl1JRsT3zQGLVJGB3BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeivdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddupdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehgvghtvghlshhonhesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhhkrghs
 hhgrnhhisehnvhhiughirgdrtghomhdprhgtphhtthhopegushhoshhnohifshhkihesnh
 hvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnhhvihguihgr
 rdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
 epohhrihhkrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhurghnmhhinhhgmhes
 nhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:0Eq_aBmB-vwmGmGOTNeoArYOyG_sNf0NL2HIOhFQVQLDu2EgsaShyg>
 <xmx:0Eq_aLHzKdpWi6OaKZD-tTR3qMc8DQIe_-DAgObd8M4EyYvTfSAeNQ>
 <xmx:0Eq_aA8MSLEbcm1Hq46wC1ZCcGEhj7hwZj1NnsuzXJMYigVbkLDb_A>
 <xmx:0Eq_aElvO029SxjQeghFVBYHQFq1fhPTqzwI79b9utZCkxwCPLjiZA>
 <xmx:0Eq_aBE6C6NkTZEIY7vvGIim37JP3ym1JwFCMxG5L3B4jpuJeG52B3Rj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:29:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, mkashani@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>,
 Raslan Darawsheh <rasland@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix external Rx and Tx queues access
Date: Mon, 08 Sep 2025 23:29:48 +0200
Message-ID: <1834226.VLH7GnMWUR@thomas>
In-Reply-To: <07562abd-18cf-4080-82d1-3d98b3608d52@nvidia.com>
References: <20250731060849.18117-1-getelson@nvidia.com>
 <07562abd-18cf-4080-82d1-3d98b3608d52@nvidia.com>
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

18/08/2025 08:32, Raslan Darawsheh:
> On 31/07/2025 9:08 AM, Gregory Etelson wrote:
> > mlx5_ext_rxq_get() and mlx5_ext_txq_get() functions did not return
> > NULL value if query index was not referencing external queue.
> > 
> > As a result, calling functions did not expect the NULL on return.

It is not clear what is the problem.


> > External Rx queue:
> > 
> > - In mlx5_ext_rxq_get() remove assert and return NULL if a queue index
> >    does not point to a valid external queue.
> > 
> > - In mlx5_ext_rxq_verify() validate that probed queue index references
> >    a valid extern queue.
> > 
> > External Tx queue:
> > 
> > -  In mlx5_ext_txq_get() remove assert and return NULL if a queue index
> >     does not point to a valid external queue.
> > 
> > - In mlx5_ext_txq_verify() validate that probed queue index references
> >    a valid extern queue.
> > 
> > Fixes: 311b17e669ab ("net/mlx5: support queue/RSS actions for external Rx queue")
> > 
> > Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> > Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 
> Patch applied to next-net-mlx,

The patch is returning NULL but it is not handled in calling functions.
Thus MinGW compiler detects a problem:

In function 'mlx5_ext_rxq_ref',
    inlined from 'mlx5_rxqs_ref' at ../../dpdk/drivers/net/mlx5/mlx5_rxq.c:2303:8:
../../dpdk/lib/eal/include/rte_stdatomic.h:155:9: error: '__atomic_fetch_add_4' writing 4 bytes into a region of size 0 overflows the destination [-Werror=stringop-overflow=]
  155 |         __atomic_fetch_add(ptr, val, memorder)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../dpdk/drivers/net/mlx5/mlx5_rxq.c:2215:9: note: in expansion of macro 'rte_atomic_fetch_add_explicit'
 2215 |         rte_atomic_fetch_add_explicit(&rxq->refcnt, 1, rte_memory_order_relaxed);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'mlx5_rxqs_ref':
cc1: note: destination object is likely at address zero

I dropped this patch while pulling next-net-mlx into main.

Please provide a new version of the patch addressing these issues.
Thanks


