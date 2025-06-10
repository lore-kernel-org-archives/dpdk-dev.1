Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA63C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 07:17:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2892402D4;
	Tue, 10 Jun 2025 09:17:33 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 74EEF40299
 for <dev@dpdk.org>; Tue, 10 Jun 2025 09:17:32 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id AD7E811401C0;
 Tue, 10 Jun 2025 03:17:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 10 Jun 2025 03:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749539851;
 x=1749626251; bh=mke19AmbhY+iya43Ws2OWP16eHgrzAtpOKwnriQIxoo=; b=
 hh51q2LgjsIPKHMojMfXxZYpvUGaJnqX31CUYwvMu8gQa8u+ixTPdxEJwOaFnFR4
 TzU5KEvSlg0cBF8SUHCM2w7+i3FSQJheWFbj2fTS5s7ge3r/48r1KR8rNneC4CGc
 X7Cy585CDZYhd3VAs2lAL1dQRM46OXfSHCmPvstNmRmyW4wm4dR3FoBndbTB+oKv
 WQXRSrPfIf0ImONlZ0XoGgTbiaefeLswMOaPg2R6My1VZcZk38fO4pG0PnsXgoms
 J6TKBwwRPO+SrhPTd0BYu52j/WxYTpZFrVR+V2VMkhM+iD/u8JCi7DDn1C+3i1YF
 ZoGTdP1WR/qQ9bMvHVTXvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749539851; x=
 1749626251; bh=mke19AmbhY+iya43Ws2OWP16eHgrzAtpOKwnriQIxoo=; b=a
 kw9fXtaZWxBUjQPtSFlpH4zuhie81iz528V4kfYho3wFvZt8ytYLZBc5uJJwmdzv
 159bieJJlEndlLe7A6/yV++toxkecKOAR6F6f1AZ4HeVlXwEsoCVFhhcUp1duxVu
 QLQBPkghxAw59KqeUjW3WKh19VlE8Y18riwy9VDvePAPFH5bYGjQLVRLkAK+V7sq
 ZwBkVXpncHhXRNn14nfV59CKwvzGUnsAIg1FPrmz3LtnOWQRCRlEa44Is411r4zn
 AfrxYlWOsKR7KjpMzIHX0gF7I73ubiOFZWjt4Qkko4ZUGNTPcd+EgIH51UQtd7vQ
 xpeMg4CGPyEE6DwVuzjIQ==
X-ME-Sender: <xms:C9xHaJ9YAL-FN0I5Uw5rhTx8C6CYWi-4chVTgQvEt5KlE75-r1pN_A>
 <xme:C9xHaNuxTn-CG3YT2F1HXAd0rF4hnK0s1PvU8AqdCUl_hCsgP5pItNAxLqvxl682H
 44B1_6wP146H1Z8nA>
X-ME-Received: <xmr:C9xHaHDUkL99pfltul5FEBa721NdjmXQujqfJmGzy9zR6CIrqMKRjNH_9rML_Iex-4Nyi7wNb9y6VQrWqODjyjEpiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdegvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruh
 gtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:C9xHaNd_qus8er2b-0m3uVHcJNuEZIce9wyIyEXRxq7wMQHcGaXF1Q>
 <xmx:C9xHaONc6w7NuutoXrdtSpMbEzKZr9Sd3oJ2PhfZbVxfUTRex8Cvgg>
 <xmx:C9xHaPka1csCQcKZscEUzE1M4405y3RvlnWSyflvRxSDng3MOuQ6CQ>
 <xmx:C9xHaIvDIX6dV00QPHvv-vRSWhY787axO3e8uKN1H5PSitkCu6RV1g>
 <xmx:C9xHaDdK9RYFWo1pkAPFu7aFZF3bmtz_0v8OcMTrVZMNAfXZaz5T-Yhm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 03:17:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc/linux_gsg: update recommended compiler versions
Date: Tue, 10 Jun 2025 09:17:29 +0200
Message-ID: <4263180.ZfL8zNpBrT@thomas>
In-Reply-To: <20250408171835.2833766-1-bruce.richardson@intel.com>
References: <20250408171835.2833766-1-bruce.richardson@intel.com>
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

08/04/2025 19:18, Bruce Richardson:
> Rather than specifying a minimum compiler version, update the docs to
> recommend a particular compiler version. In other words, earlier
> versions may work, but are not officially supported, or may give reduced
> functionality.
[...]
> +    GCC (version 8.0+ recommended) or Clang (version 7+ recommended),

Please could you explain in the commit log why these versions are recommended?


