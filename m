Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981DC83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 14:29:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 076A7402DA;
	Wed,  9 Jul 2025 16:29:56 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 1DD91402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 16:29:55 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id 5B4791D00153;
 Wed,  9 Jul 2025 10:29:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 09 Jul 2025 10:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752071394;
 x=1752157794; bh=V8tc/qzfWQVRzMwcl3AQHv0A/uJ/f4reWFjRslIiot4=; b=
 gCcGl7UYR9T2T9GbCRy3u/9TamuhhXndEMPRyXXpDB0QKhoVquT7FM77DacbOJ4o
 rcoOIU9OFzfoUR8zTm37vFHcXkMRNO5dN58IU7k+TSGKaMacssZtAG0Szad0aR+C
 QarK64TY3sI7mfI//9dZ7hLagMgVlolBiyDSqPrIIP5ioS4HopxUhT3r8PKNQ8kF
 RaYlFYWDovJkeA9zgXdSQ3wNkvHvC07K9ip97z+B7XEvI8cC1aAW4Uw0FV4tp6/A
 ces7hDgqxs32uz69RUjeY6jL1DeuA0Am9LsPKb45fkLsCh2QOwf99bo6OT61jzYq
 A9EI5H7SOSDRzYeDW2KyVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752071394; x=
 1752157794; bh=V8tc/qzfWQVRzMwcl3AQHv0A/uJ/f4reWFjRslIiot4=; b=V
 c2/bs3HiaWiDX8eAaLjsujJ1slK4ycye5l3mPal6LxF9uT56BW5Ww+rMFOV2+pXl
 V3QW18gClBUaFGTLrLpYga8nIdsRspu8qp1Wn8zzzBQ68/SnUiwkY6EfXWaniFNt
 kr7TS018EzP1z5WqtYYOZnau2OXh//ovx36DbKbyqLC6omB2G8n9nnHUh0nrgGf5
 WBSfNWy3w3N8HL4/iSJWHGIyDVAqpo2cni/bSzXtO2H58uumGrNHdYPKiQgPbd5q
 JsjDzA+hmLcCcP7NK3QgEc3gfgNNGzAd6Xpmsvr5v0jvYwUV8QzaGo4Q+FjEQ7JJ
 DE4voFcB9yQFOL9uxxi0w==
X-ME-Sender: <xms:4XxuaMQOoFdCVI4nv8YpzbUx7EphwrW822m4cstqDbpY0IktNXedqQ>
 <xme:4XxuaDYUr4xeYTYOiWCb-cogYXGNpU3dtylA2Hb7n_bLLGKFUUhYPloEdo6t8YxNB
 2o8CaaEIaIUK4YbQQ>
X-ME-Received: <xmr:4XxuaJ0WTlplH5k1v-4io3Yio1ulpyuWUEiyeR8JbgjQoi-aXq1WR_GRUoxSST2XyNbMKqufskVouzJX-TutflimeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeektdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrmhgtghhovhgvsehmihgtrhhoshhofh
 htrdgtohhmpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdr
 tghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:4XxuaDW3ys6TaiqQIxlbqzWowe4m_hJmeeyjtp-hSAhAif4wQ3qd-A>
 <xmx:4XxuaDUjkPDACjdtECTW3BKrTvZx8ML3zeL4lMcw_9sLEfVx5_w1IA>
 <xmx:4XxuaCcXPsL_DV4heVVtwzNeOWH6GzzQvPOiAJn7jUn6yzzSbVQLnQ>
 <xmx:4XxuaMVmwrE61Z4jN5LWczxkT0uesqyqfCKgobafv7kxiwf9wBR9ag>
 <xmx:4nxuaLovRpC23ZHTZxXdNt9iHkU31PpAEWRJ1zKPgdzVVVxk11-b1rV3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 10:29:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Matthew G McGovern <mamcgove@microsoft.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] examples/symmetric_mp: log/ignore promiscuous fail
Date: Wed, 09 Jul 2025 16:29:51 +0200
Message-ID: <8729787.zIJbB62Pao@thomas>
In-Reply-To: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
References: <1747766224-31511-1-git-send-email-mamcgove@microsoft.com>
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

20/05/2025 20:37, mamcgove@microsoft.com:
> From: Matthew G McGovern <mamcgove@microsoft.com>
> 
> The example apps have a few different failure modes when enabling promiscuous mode:
> 
> - testpmd will warn about the failure and continue.
> 
> - l3fwd has a flag '-P' to explicitly require promiscuous mode.
> 
> - symmetric_mp will exit with an error code
> 
> This patch changes symmetric_mp to warn and continue.

Why not doing the same in examples/multi_process/client_server_mp/mp_server/ ?
What about other examples?


