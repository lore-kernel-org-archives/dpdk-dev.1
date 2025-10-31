Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D2CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 11:12:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86A0D402AB;
	Fri, 31 Oct 2025 12:12:43 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id E703440270
 for <dev@dpdk.org>; Fri, 31 Oct 2025 12:12:41 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 43E751D0007A;
 Fri, 31 Oct 2025 07:12:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 07:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1761909161;
 x=1761995561; bh=JIZ+x74q5zMY6ISago6HZRVkjk0Zq8Jh8/n6haLdjBw=; b=
 T5QcGS1MRhSVBovXfWy19eA62Ey6dbPc4t3p4EbwTcymC9iA83PSK/Nj3XCPElMs
 PSzwx/HHTj1rDyB4F/OasEyBzdp12SvW51C60hGltpbVous6DhiWwZ/x/d5k+3fC
 6LLXc9LoDUeD7fB2n8FwgTvBd0WrKj/X7swJkkCp50iQGPPe43uGnaGe1NYuL1dy
 cfNjn2qqYX1jmwXbPDyeaBpgoHMAOna+ySwIuCGOJP/ov7OETMKLdNpOxlBpfaXI
 /2tYr4rX8to4R9RPeCo1OP6ociURgnYkxbUkRaNUTy1Nm2HcTM8rN2/LZhiQVRZ4
 3hgWAm2aE+BO0rvAiqCH3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761909161; x=
 1761995561; bh=JIZ+x74q5zMY6ISago6HZRVkjk0Zq8Jh8/n6haLdjBw=; b=B
 KbDR+l7eBwoJajff8VrsOb9QeqnbaY1oshFPlSwgt1ysQhw0Psn3Ktonx+4u7AQG
 spzGo+Y9P7fljE+SLZe/Bl37sEoC7D2lE0RaEnBUTJsT5ON0MUbqim6o+gPV+GEQ
 yCisLkaOMSBxRBcTleTdFZKA4pGdz/BUlvWs7hhztHd2fO46PLT2Ql/TNQAXhinm
 YWzur3B5fn69vblylHBRaNQq84phO7CINHtk8Ua++EZTdOv30Ne5t2EOf0z4UlHP
 0CaJ4kIhJ7OIu8Ioot1SCwVW4pLfKngqhTBJbD4+7Xzz4lBpG/Z0zYxBv/LIupEG
 yvDwZxNBasX80WG3D6hqw==
X-ME-Sender: <xms:qJkEaT8PxlstRzldwsGM5DQlWMDHa8IT7m783yaqGXuChfxNIDAhxw>
 <xme:qJkEacAExnZs83-Es2BIkzfBfRl_fczg1DpTMYHIxf8Okr-IjTRZXO1DYccZOcHrn
 qnOdBpUJT9Gw4S14wwU_9TjYVlk-90Tpa-XZW1dnL4VulSptitkl8U>
X-ME-Received: <xmr:qJkEaTyPk2r__XURopWzeGcNsHrqUUGB0Bk9tnZfIFsqho_qjnBMGcpB-V9Wjf-bAXNcwqsjZncufj_QAcu2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieelfeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhguse
 hrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:qJkEaRSEZ9_YZbg1X-ql57kBf9inj7mwNfppJt9qIyNk8jNSi36V7g>
 <xmx:qJkEaa8qdm5zZlqMP7tbFy7QopCoIPHCt3h1pkPMk2epubE5C_-nfA>
 <xmx:qJkEaYqv13X2bUzAYF58VCMt8dBjXBrJaJ0YOx5XG_4DwWe-fZ9Gog>
 <xmx:qJkEaXk3il3mjEDiRo9tPVaAEJPObCR1BPMzngrl3qAn2HXWA8U0ZQ>
 <xmx:qZkEaQSaQBaE_K6_tq-ADL-7Gm-tImwtomtNe3AnzG4YD9H0FD0ggKhQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 07:12:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: Re: [PATCH 0/2] fix hash unit test for CI
Date: Fri, 31 Oct 2025 12:12:38 +0100
Message-ID: <7529890.gtipl9YmvM@thomas>
In-Reply-To: <20251030175329.4041960-1-thomas@monjalon.net>
References: <20251030175329.4041960-1-thomas@monjalon.net>
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

30/10/2025 18:50, Thomas Monjalon:
> When running the CI tests in GHA with UBSan enabled,
> for an unknown reason, a test is regularly going to timeout.
> While reducing the time needed for this test,
> a fix is added to fail nicely when there is not enough memory.
> 
> Thomas Monjalon (2):
>   test/hash: check memory allocation
>   test/hash: reduce time of functional R/W test

Applied quickly to fix CI tests.



