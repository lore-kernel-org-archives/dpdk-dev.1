Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD9CC61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:33:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BAF04060F;
	Wed, 11 Jun 2025 12:33:17 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 6ECA940144
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:33:15 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 9598911401C6;
 Wed, 11 Jun 2025 06:33:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 06:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749637994;
 x=1749724394; bh=L3RCxoOuk3+hs7wPyLOaNe6ClNYGx6z625AdEL+4J1M=; b=
 UPdDmEul5RBlog/2kEWhdxjXuDoEgJP4oPfx/i83TmSjhyfVVRtYavy0Zg8Mm9wG
 w0+gMl8T7ijKI4sHzGx1nNd3+Xye5qTQShTlDnwrt8HzWAb/fsyRMpb+eo2prh1x
 gr/DY+bbxbYATYd8KQkmNzHfvoofL0nC8n2SFTBjwCtVO+icL2HzerQ12RPRDUon
 5gauPYCxb34Ja6Pld6zJMS6qr0NWUT4U1wtMJjkVk1OrrczYn2S3njzCneS3C1n3
 lGYckRc+3tu5hKZkI25INxIxFeeLEAeg6yU8v9mQjMFxMGMuNvRkeyozpS5Au2MF
 hOCA2AQk4kjxaFyiCuppaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749637994; x=
 1749724394; bh=L3RCxoOuk3+hs7wPyLOaNe6ClNYGx6z625AdEL+4J1M=; b=U
 h91e3VyAgvcuyj+A0+1MnFK791HuAGJaNL5cfVEpoPpT0dbC9qSasYW3ZIbeyQEI
 Kdmtl0iTP7p2LO+TKlmz0n+rgrFX95UF9fA2pfGtrvSC7jYo5tJ1da0Uzfw3jg0C
 dMiikOyquUPIarGkM8WdekD3IfNkB5kWIeUNxciR2R0b+pvpSMN0XC6x+ZKBafau
 M50bqUOS1dBzlZkg3FSBrIfi7DQwL6V8JRIJna6LWBvV6AeiZr7P3EJDz4iE4Knl
 RmhiOXSVPUkNVzU3cfyuOdzn3kFpi5Nw0DXYx+gzusAS+uIKqhSujmEiAAH6HLtI
 jqCKQ3PFH5rRBMDpaygMA==
X-ME-Sender: <xms:altJaHtLKitZjOK7J6Z1yP4TAveD3Ty0XMjxAHqIgOUyX_qvK_jBxw>
 <xme:altJaIfBLOjqJtt8l5wSp3bMOhOe8MgNoJ5iEhAkz4_C-BpGJKj7yxMBn_BlHM947
 CWbyK0j_-VC8GBDLQ>
X-ME-Received: <xmr:altJaKwIwoIOTsLD7jUHqNF8-CTcsm4sMdgrc376dax0ys2I7xcuk5CDc__Obzdz1Jg7WNsszh69dH95KYlF5zUlkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvddtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggufi
 hivhgvughisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdho
 rhhgpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoh
 epvhhlrgguihhmihhrrdhmvgguvhgvughkihhnsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepnhgurggsihhlphhurhgrmhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehpsg
 hhrghgrghvrghtuhhlrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehskhhorhhi
 sehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprhhkuhguuhhruhhmrghllhgrsehmrg
 hrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhhsrgigvghnrgesmhgrrhhvvghllhdrtgho
 mh
X-ME-Proxy: <xmx:altJaGOl22s5wF3auxa7IiyM3orS3phFtDvlhrz222U0jnanW331Aw>
 <xmx:altJaH8hpNCx0KgI__phlcOlG4a7kKIR3l-zU5dY1-ByjO_kQ97BKg>
 <xmx:altJaGX59M_2I3skY0P2h7d28WGxu_k03_oFAlFuI-II39blNriPtg>
 <xmx:altJaId_GJXtGVugTVO2VGjsitkImJhIWko6SSwfPjXG_Fc_V_klzQ>
 <xmx:altJaE8BVxVqJ4X3s6z7NsOPfprRKSPggI7Hdo1998NM9claDWVieNhS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 06:33:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ankur Dwivedi <adwivedi@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, vladimir.medvedkin@intel.com,
 ndabilpuram@marvell.com, pbhagavatula@marvell.com, skori@marvell.com,
 rkudurumalla@marvell.com, nsaxena@marvell.com
Subject: Re: [PATCH v3 00/14] add lookup fib nodes in graph library
Date: Wed, 11 Jun 2025 12:33:10 +0200
Message-ID: <5448833.usfYGdeWWP@thomas>
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
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

> Ankur Dwivedi (14):
>   fib: move macro to header file
>   node: add IP4 lookup FIB node
>   node: add IP4 FIB route add
>   node: add process callback for IP4 FIB
>   node: move next nodes to public header file
>   node: add next node in packet classification
>   app/graph: add IP4 lookup mode command
>   fib: move macro to header file
>   node: add IP6 lookup FIB node
>   node: add IP6 FIB route add
>   node: add process callback for IP6 FIB
>   node: add next node in packet classification
>   app/graph: add IP6 lookup mode command
>   doc: add FIB nodes in graph guide

Applied, thanks.



