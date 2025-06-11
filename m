Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BC8C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 12:34:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEB8D4066F;
	Wed, 11 Jun 2025 14:34:54 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 2D464402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 14:34:53 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 9FD0F138049E;
 Wed, 11 Jun 2025 08:34:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 11 Jun 2025 08:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749645292;
 x=1749731692; bh=u8605P5MrkKUnYQbHSMe1YYaUiJ18F1ZKt4eXIL4kuA=; b=
 CBuw2sI+Nih3r3RI9yG/18IxnI0i7Klwrb0QTVSdFynjFMGTKnIcljlJaT5VAIWD
 ph61Cvz6IQeXL+LurtPjMQMy4jdJR2dQixfUfhPku2dSzt2C/2NG3nBrrepucXYY
 ctrywgKTCLDexyXxJKij3oSlgNvwVUvPvy8W1DqQYwiMQWPlGGNQLElkytdQrVab
 yXK0tSusVavTX3Inm9ZSB2SeFv+WQSRbFt4eeWRg0fAHTq17iQiXoFIWSTK8ekHs
 L337Xqtc2SHqP099aShUkRqhQRPG4ETaXbsMU48scSH5uLK2S1D63PN+RDRzlpfE
 BssBejutPiFGnI+jf5HKtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749645292; x=
 1749731692; bh=u8605P5MrkKUnYQbHSMe1YYaUiJ18F1ZKt4eXIL4kuA=; b=M
 dtj8XTU3aWAvBFF7KZe0LeW8ugVuMirLbR9eNKJXKMH9NgZZr9F/ysr4jMEGViJU
 43QwkZBF00lCWm2tP0t5/ep/p5hEo5pTqJnsE7ahUN0Gu6NqI20qrYN83SjHZf5j
 eSEAOe73/URISqrC3yvau6zQLyV2pihLGzbvNtLp/r6pUcgt8EVDaOP9NRiZQerL
 SmTP8XKseCvdthdQKbC73GjkJ43rI6tVnuzQdl/Si7YHXRfGDCz4tbXYY+Po2Ofn
 ULScbVMxJ8W8M/orM0pnSUofzIVuXDs0xVOqyWrUc1YJ2I7zgPZKb4Kxc9bTwvFS
 HTHLmXKxCHzmSoFOzHIvg==
X-ME-Sender: <xms:7HdJaO_PhQJMGXZRMEDSyUkD7AF84juYTtlXhlerSz3wGFMJ9LUUrg>
 <xme:7HdJaOteFIZj1QLYzEDRMa9Ul5S04lW6ZTeq4j7S_SHijTpKzQL7wVLYORLKUs-Gk
 az59g29eLqgO4Ftlg>
X-ME-Received: <xmr:7HdJaEDk96Xi8TzY5L-FQWbiYZHGtGWxiWQrVHVs3neUbKBKRep_zN1G4zm-xqyD39dGFGzfAsUF0iPhn0yuHCIobA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvddvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmh
 hsrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshho
 fhhtrdgtohhm
X-ME-Proxy: <xmx:7HdJaGcbgZEQSKB-WVy8YXCltLrlycgHE5m-qdBzuiRMas9JCTNHKw>
 <xmx:7HdJaDP5zsOHeD-pCOZ4ZzcnDw2DSwRbTPLt91DAH5RPovVx4TcCMQ>
 <xmx:7HdJaAmJ7sjhNVAjCatZzUhM26hHUoBwQrYvCRnb_ft5WB5VSiL16w>
 <xmx:7HdJaFsAmHFymlFnKg_fJyXzNm0Vb961sM-orvMGe6cN-ZlkYJYfvw>
 <xmx:7HdJaKXAJ7PGhvjP-Puwccc4lwkfwFMuRTSUedZYpN5-w8yLl1e7x5WA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 08:34:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v9 01/15] eal: introduce new secure memory zero
Date: Wed, 11 Jun 2025 14:34:49 +0200
Message-ID: <3950340.g5d078U9FE@thomas>
In-Reply-To: <20250220164151.9606-2-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
 <20250220164151.9606-2-stephen@networkplumber.org>
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

20/02/2025 17:27, Stephen Hemminger:
> --- a/lib/eal/include/rte_string_fns.h
> +++ b/lib/eal/include/rte_string_fns.h
> +__rte_experimental
> +void
> +rte_memzero_explicit(void *dst, size_t sz);

This function is not about strings.
Better to move it to rte_memory.h (even if not ideal).
I'll try to move while merging.


