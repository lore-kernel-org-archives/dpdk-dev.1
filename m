Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5981C71135
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 23:38:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1D494021F;
	Thu, 12 Jun 2025 01:38:10 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id CFB3B40156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 01:38:08 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 41E311140228;
 Wed, 11 Jun 2025 19:38:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 19:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749685088;
 x=1749771488; bh=ALZkjULQPz0XNnfMY8AecgYza29IXD+eNxSCqqCmdm0=; b=
 Md/PWyVBFjX8ZMz/ZHFCqKhB88ncfmpSyAi5h9AwKCzCyuPv8n+lgDyx0cRyButX
 CcTkB+wgX2l4ylI0nGPNNrD0+ID47TDuM0wp5gxv2HfPxh1Unk90lFN7U9SN3gJT
 ibjELUJ3HloeTSCwSRBofwVps+lWP+yiv3v0nn1YQUhEhL+VHtsIJ0BWFe0wiZRM
 SRRusC2AiegY+HjFngkqZ5ace4+inmVbiMANCttSAT9xPLEn6TZkwsW86/FRVuB6
 iMGXxH/1oDSpj7h8Wye84OQ2LLVT/Q4j9PYlAatLs8v3JT6KUAgbPwSeKCqjSJXP
 Fq7opgtMZDFqby5XmZNMZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749685088; x=
 1749771488; bh=ALZkjULQPz0XNnfMY8AecgYza29IXD+eNxSCqqCmdm0=; b=k
 WeGY+D4Hye9pv0T6yUOvGDmCD2YyE9A6717K24V+7jKIjaic3uNbeVNGecFT7r3Z
 AQI3SA6DqZw0PVbR3+uu9AWMa5SuVLZ9qLRo+oiuBIdSofO6Wtw1f+wlJUtg7TzB
 PL/wrwpuqOA6ocZRbdT9ib8XR6XD4P/WpX6DLxgknV3nnp9SId6THmsEGr2e7hjz
 PP/63jYgMkPDi+z+gWsUG65xFkp+UyURZqNaxLWvQCofhiYeka9sSBXvvBhCfSzb
 wWtho/GhEdx784upKBcBTpoYeYwnQWDp1HSqT+upmygR/BL+ZVx1SzymuDYrP2Ow
 Hj6rXBbAEDQ1wr3vI0ZnA==
X-ME-Sender: <xms:XxNKaEnR0UHZuG_RNNIlKvgyaeVB_friQpggb59U1a-_reyuCjFIEg>
 <xme:XxNKaD3Onw2itbtXmYOQIcaaDvlzB8kvjonEqQhgl6vydDR8nh-m3UxQlai08IH2d
 PrA_uBJnQV-mzREsQ>
X-ME-Received: <xmr:XxNKaCr28V1RWqU2i-nBk8obOK-B_-mtJwQiBwJnnm13BsfUTSUwRif_akgcXmYWkEsy0JHoGpFiz69oIL_lYf7zqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:XxNKaAn4ygKSceAFDGBcLpdpAhK40Mx-ESxGB_8GpZItQ5sXRm-7gA>
 <xmx:YBNKaC120z34XQSrOkjC1BemCfwC0IatKUyrciuNmBA7Qti9WxL27g>
 <xmx:YBNKaHtbmMd8bFrSfWgsumqMd_ZVpjwIkCktVXFpjr82MuaZIAY8ew>
 <xmx:YBNKaOUGEVDUBGQ9C-pwyjlAjOY0ugzEU5pHOFQHiRs6wGfBOvzeZQ>
 <xmx:YBNKaB4100Q2_kHtT07OJ4WOJ5ElYvexMbuq7Y54hU4SjwS7dCTFL38A>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 19:38:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/32] Use structure assignment instead of memcpy
Date: Thu, 12 Jun 2025 01:38:05 +0200
Message-ID: <5311136.0WQXIW03uk@thomas>
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

08/02/2025 21:21, Stephen Hemminger:
> This patch series reduces use of memcpy and rte_memcpy
> in DPDK. It changes memcpy to a simple assignment operator
> which easier to read, generates the same code, and
> keeps type safety.
> 
> Historically memcpy was used in textbooks because there
> was no structure assignement in original K&R C.
> 
> Stephen Hemminger (32):
>   devtools/cocci: prefer structure assignment over memcpy
>   app/testpmd: replace memcpy with assignment
>   app/graph: replace memcpy with structure assignment
>   crypto/dpaa_sec: replace memcpy with assignment
>   dma/dpaa2: replace memcpy with assignment
>   eventdev: replace memcpy with assignment
>   event/dpaa2: replace memcpy with structure assignment
>   event/dsw: replace memcpy with assignment
>   ml/cnxk: replace memcpy with assignment
>   examples: replace memcpy with assignment
>   node: replace memcpy with assignment
>   pipeline: replace memcpy with assignment
>   sched: replace memcpy with structure assignment
>   table: replace memcpy with structure assignment
>   net/ntnic: replace memcpy with structure assignment
>   net/bnxt: replace memcpy with structure assignment
>   crypto/qat: replace memcpy with structure assignment
>   mempool/cnxk: replace memcpy with structure assignment
>   net/dpaa2: replace memcpy with assignment
>   net/enic: replace memcpy with assignment
>   net/intel/i40e: replace memcpy with structure assignment
>   net/nfp: replace memcpy with assignment
>   net/txgbe: replace memcpy with assignment
>   net/bnx2x: replace memcpy with structure assignment
>   net/dpaa2: replace memcpy with structure assignment
>   net/bonding: replace memcpy with structure assignment
>   net/cnxk: replace memcpy with structure assignment
>   net/enic: replace memcpy with structure assignment
>   net/iavf: replace memcpy with structure assignment
>   net/ice: replace memcpy with structure assignment
>   test: replace memcpy with structure assignment
>   test/cryptodev: replace memcpy with structure assignment

Applied and squashed, thanks.

I tried to run the cocci script on my laptop but it took forever,
so I hope there is no more occurrences remaining.



