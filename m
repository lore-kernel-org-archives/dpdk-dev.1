Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580D2C021A1
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:24:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 174854113C;
	Wed, 12 Feb 2025 15:24:02 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id DA8C14111B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 15:24:00 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 81E7013801EF;
 Wed, 12 Feb 2025 09:24:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 12 Feb 2025 09:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739370240;
 x=1739456640; bh=NDVrSacDRN+0Uw79MV7QsD4WfCS3JOMwAdR/mRmEF7E=; b=
 BHu1bfSts9Y7Ox7VwsVlMxLZ6atw3XuppHFzutA/tj7h7/vOKbUvgS8ZuWYK4R7D
 R/mC6+B4KF+M3+BcvRCcqyX07RQ9kDRHwbd1K6fDnMdpEPkNxKK4BKyi4ZXpvcU1
 2USvLVLkcyNCsQXwAAvbf4MBGhuJVv/yDef7arimQmjNQJkiTKbnaYUbZBVMKayf
 J1K+BjepezUYRrRFZlbi9c4Us8l0Flnh7OLcVrt1Ox1HmnHlJs9CTlstejADVNsV
 olsD//kRCaAnVaBnSZfVtTxobJBlSuBecaH9X0qo3AOqoHDCMU5BWWwmSfVTx/w5
 hmjB4wt5o7sdeFdHvwTYpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739370240; x=
 1739456640; bh=NDVrSacDRN+0Uw79MV7QsD4WfCS3JOMwAdR/mRmEF7E=; b=W
 irLOi8/KObHEafWz2OSUpSJi2pX+kZcK6tApVE2pEUnuhz8XeNBG4b27Ev6HnYow
 whEGO1KAvcIY0WsfuSuOlZQ5LcVOHznVv7fhUbtOpKhXzllc5EgRJQN2EonxJaTc
 9/Abew+5oB6yEnt6BiseAx8JCbrgEv7nBKTd6s67lWV/J28fjsnHR5YSj3v71Tyx
 1lLs7XezyMb6pp+qhaN/J3JQT75eL+aebjmVILmW0zpBBs8tPhjb2cQi58oJNjFu
 maofEGz63f79y21OFe00UeK2EW2Mx1BiKetPiuIiTfJwu6qRHB6JUmelrQpxyAqo
 GGmOqELBLhiJmKaHU/cRg==
X-ME-Sender: <xms:AK-sZ4dDwsau6EwaGKqxsWFxMeG5fQNkua8FNFjcVBe0zhQ1E53yLA>
 <xme:AK-sZ6MmzMM_LUcO5Q1KjHbRWftSr3kUu8nKAjXNgAc6yrGDf7MoaU0jWYuTnTNlU
 x7geioyDvVNpgvYPw>
X-ME-Received: <xmr:AK-sZ5g9R7h4FwnskgtnQ-nt2n7Y7FehJUJQOuJWUoUx4ouVZPAV9wl-pHM5BKKZyMERypaCielzSVTBE3Y3u-HZgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnug
 hrvghmuhgvsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepshht
 vghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvh
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:AK-sZ981r1RRit7BsdUn8buaV7WklcDol29zFXJSozx--m0wn-2SsQ>
 <xmx:AK-sZ0sO2MAuWjE8LN7bOdjN6yDPzlEcRWURgkE3F2FeFMZuUBkMcQ>
 <xmx:AK-sZ0EU4PCru9nZywlS3IREdgLIdt9ebkvUqR_omJydgpO07hQ9JQ>
 <xmx:AK-sZzOXJF5gR5b1UBhQcbZ2UA10CH11pFzdh0x8j_t0cPwOMld6Og>
 <xmx:AK-sZwJhhGshRDI2iDUbWckZF9l7oFUOZAavPVViX6Bwm4_F3WZh6KVW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 09:23:59 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Subject: Re: [PATCH] mbuf: enable to be compiled with MSVC
Date: Wed, 12 Feb 2025 15:23:58 +0100
Message-ID: <25209858.kmuVQn2iE0@thomas>
In-Reply-To: <20250211021916.GA5671@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <20250210143429.5ec26d17@hermes.local>
 <20250211021916.GA5671@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

11/02/2025 03:19, Andre Muezerie:
> On Mon, Feb 10, 2025 at 02:34:29PM -0800, Stephen Hemminger wrote:
> > On Mon, 10 Feb 2025 13:51:05 -0800
> > Andre Muezerie <andremue@linux.microsoft.com> wrote:
> > 
> > > Now that the issues preventing this lib from be compiled with MSVC
> > > are fixed it can be included in the compilation.
> > > 
> > > The "net" library will automatically get compiled as well as it
> > > has a dependency on "mbuf" which will now get fulfilled.
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > ---
> > 
> > Getting close to building test-pmd on Windows?
> > 
> > Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> We are getting closer, yes :-)

Good news

Applied, thanks.


