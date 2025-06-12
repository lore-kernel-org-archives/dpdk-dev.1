Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96490C71135
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 00:41:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90D144021F;
	Thu, 12 Jun 2025 02:41:09 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 84D0540156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 02:41:08 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id C365F11401E7;
 Wed, 11 Jun 2025 20:41:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 11 Jun 2025 20:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749688867;
 x=1749775267; bh=Fi7LjgOjxhNO/Wsbhcycc7Dsq48JMpKX7iYzoG2JPeI=; b=
 epi06gsjQxR6Y83xzYOIBnJFBZebTXSjfLLqztDpaw24329Ub1+l9ySqiBPRZ0Qk
 IiaR212odWxT7btzREzTJc78S56NaVHCoedpE4euyBuvsoyJXu8/HqvG/piIL9OZ
 oV9g+8B7GvlJ6uCW9IpVMnGIOOn31oDg7pP1c+iWX+T0DkFTBv9SAa6Vr3QFPlGS
 W0ymeMVmzJ0KUu66j3ZSO6QbtLdgcEyyBX43NuqWUn6Me68wb4yy17tT1gKdUQlq
 2GFyyzfXih31ampXOrIJixeDb7SyTrmi9fz9QYfc3SyNMzemtzHLBUcV3vot418Q
 13QJIbmwYOTjXCyEBp6iJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749688867; x=
 1749775267; bh=Fi7LjgOjxhNO/Wsbhcycc7Dsq48JMpKX7iYzoG2JPeI=; b=l
 +goPFYw10tgrQSawjZ8gJNwwKrA1aPlxxLY3TrEhQORl8ExiHMyxGGVSqBkxdyVT
 13/RPOZGUYnijaD5j6RzILeTO98dOF18gwtgnSuEsr6ST3wxnb86bn0jwCM/E9de
 tuooUl7jwzHTiW+0ZtpGy+vGJxzTA85P3t/HJb1eh5C0caL1fSt6IN1z6cye92Yz
 llzqxuNdZ3lwtkA0XsZ88KhPxeO4199O8pjzO/aJtWIrvdnlWwxO1LWnko6xb0s0
 qNo0FskW1UspQk7kvW1h2BFp4sfa5MdHFnAg8Ct4AcE/v+fcZYgx0vvXaQniJFfs
 rVzCdSNiHgIDnA4FIpm9w==
X-ME-Sender: <xms:IyJKaCt58YMUj49wFGTOWh-jiqAj673e-or1I1bknC61V8Bl2davTw>
 <xme:IyJKaHdVR2bObkGTsJTl-yWyG6fQlFbTPsoiY2wMlKUSiJuVBohyjrDCaV404X7rR
 bb62zjwjT8eXjdqqQ>
X-ME-Received: <xmr:IyJKaNylPJYR1Wa0L4SIHGkxZK8OiCgw8AUrsqNNrUnHfx-fyui0A3iYo8y20WVPiE1ld6-QCofAOjaytQ8bgYN0bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeeihecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnug
 hrvghmuhgvsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepughm
 ihhtrhihrdhkohiilhhiuhhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhorhgvth
 iilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:IyJKaNOyiWiNY4tu0bLgruP6ExqlsQuchiWmZYHM4ycy0sL_ldK_Iw>
 <xmx:IyJKaC96EkrIE44wNqF-SEn97NCPhnHSHYDFws0j4Rq7LhKV0sxksg>
 <xmx:IyJKaFXc3gljG0JFxnAo9L2MC0qt5p2ltZUaiafmiZ2GwgGJhm0FTA>
 <xmx:IyJKaLe_0bT7KkH4UmaGk1L0Dx-Brm4AdVT9GnVUkQ1dfziTUPjGkQ>
 <xmx:IyJKaC0CHFw9pqoqMi_ZJ0uERciXyfgomWKlIEadsbefwBZlSOxLrj02>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 20:41:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH] eal: add asprintf() function for Windows
Date: Thu, 12 Jun 2025 02:41:05 +0200
Message-ID: <7942373.1B3tZ46Xf9@thomas>
In-Reply-To: <1746495789-14101-1-git-send-email-andremue@linux.microsoft.com>
References: <1746495789-14101-1-git-send-email-andremue@linux.microsoft.com>
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

06/05/2025 03:43, Andre Muezerie:
> The asprintf function is not part of the C standard library but is a
> GNU extension commonly available in Unix-like systems. It dynamically
> allocates memory to store the formatted output string, similar to
> sprintf, but avoids buffer overflow issues by automatically sizing
> the buffer.
> 
> Instead of rewriting it or coming up with some other replacement, this
> patch makes use of the implementation provided by Neved4.

Why not using eal_asprintf()?


