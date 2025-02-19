Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752C0C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 15:19:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AE2C40EF0;
	Wed, 19 Feb 2025 16:19:37 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 64A5640E6E
 for <dev@dpdk.org>; Wed, 19 Feb 2025 16:19:36 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DCD9B1140192;
 Wed, 19 Feb 2025 10:19:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 19 Feb 2025 10:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739978375;
 x=1740064775; bh=DslDh2EBSx3tWAWhOdI3LpUn137Z3NgKiXhuiq0ZMd8=; b=
 fthucgK0JevNj892U5zAjBMo2cbefoS+QcCrBcsScV7u0bdJeM5N1AH6RuNODbvt
 7dmp84VLdrDZ9Ozg1pFZ5MDEYcxXevRh/tPrTqLr0n83jno60of/nyvZfGlHKARS
 gdra+G9XNlRTOUwfusr1fyQgkbpVX6bIKE+D/TiScxK3SswCaeo7oIUoUxsRstz3
 z8rJaEjJkt9gzvQfk4FQX0u2raNDwqemVFbKeGufkM/yOJJDJvWqsofCuRRXG9DJ
 JV85XZl1fP91rgaXvvJVGJAH11P3bQSMjfMNrpcYVZAvRXYo1RVdXwedoCpzZ6fq
 65Nqoeg2aptcKbooUk0Dqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739978375; x=
 1740064775; bh=DslDh2EBSx3tWAWhOdI3LpUn137Z3NgKiXhuiq0ZMd8=; b=s
 bxevzPpwelXhI0+8o6/6eyrdWQpSxUsE5pctgMwpemQG3r4E5ifkJR0vdHDZtFA7
 r5UaQhOVIErv7rxVtQPMHxgYZoZEVmeH9JYB4R7kUWWv+VotoEsv88yYhVDUw8yl
 5gSQ531Z87Z/sDH9aTSrMebDq0QVKmVF2EVbkKbhNmWupM6A68NgWVtCW+Bt9Otr
 FDQadTrzHafzSFg49Sv/phCsmyiAuJJ3F4TIUPXMyzBoSV0JZJUuTVnUcsMSX4ND
 T3/tItYnk4Cx8d9yIV9gc0DsvP67EemneY7SFkMHOC/iQUpg07P0fAxB8txCV9lU
 cVBKryYdg78W0aQJ+jddg==
X-ME-Sender: <xms:h_a1Z52OPgKhNo55H23li2xfAzwm59zXK-Y8bwKDQFMOFWSv1nQlSA>
 <xme:h_a1ZwHjdQ_u7DBEyFaibzCt3CQJekqg5TEb1HudDHr8nT6VU4GRCefo_3kuTMVYs
 5_f3_nx9sSv65l-8A>
X-ME-Received: <xmr:h_a1Z57lcJlk4mPlf6QMWjW5FSzUMjc1PRUhDzdJWV4BtRthqP_QoDKPRqflqjPAWRMLoF-jvrt5WiRakVvZ6ZUTDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeitdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepkeefheeftdegtdejheeuuedtgfel
 feeiveekieekleekffelgfdtveeiheehffdunecuffhomhgrihhnpeguphgukhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhho
 mhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
 hmthhpohhuthdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrdgtohhmpdhr
 tghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepfhgvrhhruhhhrdihih
 hgihhtsegrmhgurdgtohhmpdhrtghpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhm
 pdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:h_a1Z20k6blZ0TdX0exgvPMIPZyK-2A89hbRv6yc93SRAP7Vtn6avg>
 <xmx:h_a1Z8E0vvXlWJedFXNO9pVN-wmSWDBe6l3p9e6O-SUOxuZ3drkEHg>
 <xmx:h_a1Z394NAbq7b79POeFsbViFztTuCnRxVg5CTYRHXW3FyBcUZlpww>
 <xmx:h_a1Z5n5SnL1OdatVhgU93ujOENyRgCixL2K_zZhRyKIJGlo5KfpZQ>
 <xmx:h_a1ZxP6p8yLzd1Hd1gH1qYxSkBYXZafij5DiAMRqsDzeqqniIGOrtZx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:19:34 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, Ori Kam <orika@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] examples/flow_filtering: fix destination IP mask
Date: Wed, 19 Feb 2025 16:19:33 +0100
Message-ID: <24267002.EfDdHjke4D@thomas>
In-Reply-To: <20250112075200.5020-1-shperetz@nvidia.com>
References: <20250112075200.5020-1-shperetz@nvidia.com>
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

12/01/2025 08:52, Shani Peretz:
> This patch corrects the destination IP address mask to
> restore the previous implementation's behavior.
> 
> Also it fixes a misuse of rte_flow_item_tcp struct.
> Replace it with the appropriate rte_flow_item_ipv4 struct,
> as the code in this context filters ipv4 traffic.
> 
> Fixes: 16158f349000 ("examples/flow_filtering: introduce use cases snippets")
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
[...]
> @@ -77,7 +77,7 @@ snippet_ipv4_flow_create_actions_template(uint16_t port_id, struct rte_flow_erro
>  	};
>  
>  	tactions[0].type = RTE_FLOW_ACTION_TYPE_QUEUE;
> -	tactions[0].type = RTE_FLOW_ACTION_TYPE_END;
> +	tactions[1].type = RTE_FLOW_ACTION_TYPE_END;

It is a revert of this recent commit:
https://git.dpdk.org/dpdk/commit/?id=7d73fa47f4

Do you confirm you want to keep RTE_FLOW_ACTION_TYPE_QUEUE here?



