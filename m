Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D4C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 16:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C52242EFD;
	Tue, 10 Jun 2025 18:25:57 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 164C642EAD
 for <dev@dpdk.org>; Tue, 10 Jun 2025 18:25:55 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 6994613802B8;
 Tue, 10 Jun 2025 12:25:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 10 Jun 2025 12:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749572754;
 x=1749659154; bh=s0Orb7BVB02uPX3ISTJ78DVhKGcMssjRGIsRAYhKosA=; b=
 eh3sRI7EX5/cPVKZFCEFirTE06izIp6YUNuOj69UgLXKRyDnd6G+ENbw2KbCYMaa
 4XsEnQkfPSSmLr5eH3wAZyJjcnXmKp5o9UGWr+eUyVi7I/9LmAwCFgHJm1i7AmRD
 GtZ00V0FFfrCUl5jrxvu17JvhshQeLUDnnrQjLgzwKrcZSbDZhfiPRTg39L1xbx6
 KFqU2OBIeQaprP/R4oHrk1jscYRaDUnKQHS0WpJQ02QiPMFuXT/tpRA6WWhh2c9v
 ybr0WGjqyCUhtMsz2hVfLQ2sQY2Dy2leJF4qlyp8LoypeLAVKtnXw4mz7mpUIMQ0
 me6I42aUnX9VY2f3Y9Isuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749572754; x=
 1749659154; bh=s0Orb7BVB02uPX3ISTJ78DVhKGcMssjRGIsRAYhKosA=; b=Y
 dcYUnZ5PzPudYN+QIL/FNv/W5+5+rvDAfSvFZlsmY6B4fXcehVJaDIlpOGe8EbNJ
 KASdaex9HsbULxPg6nofIQmrZ77ykoKsJ6QXkYfDgIipzqBHRfvv19OzyP138Vpl
 jjD6xVRDlbhPE/48tdXgYmbZbYdqKHf5s4cDW8WeEh1FWbLGaFldBHzdfOdlNw7Q
 Ojeilg/vuzp6V0/PXgChLr+ba7itYwmxq2MPMZNFJ6/HFyre6Wu/QTiH1iCWTRpS
 YFquQL098Jwyol30u+w+DwR7sN6THIfYvr2ctUjU7os5O50sLRboML4pHPZHreJS
 Qu3TenxoWmFnpHtij3BPQ==
X-ME-Sender: <xms:klxIaCRyD2JkuYvkSjtPXhlYnZprx7hvXOMwTFjzHBKcQbGVDAFHnQ>
 <xme:klxIaHwNRlqK2gBfFX6eYiM1-JQmxHbqXzlHsxzN5WsxkntIkgnxLxTMRpzcnbKlv
 O-Y0RFi4wGFWqFl5Q>
X-ME-Received: <xmr:klxIaP19oU36jRi1OWwLqgzYQXagNQJsJ4k9SoyEQGkn84X8i5CBmjao6uPWRfuUV_tbOeMHmL4o8EO3faDLdtRXbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdeljecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhsrg
 igvghnrgduieesghhmrghilhdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhv
 vghllhdrtghomhdprhgtphhtthhopehkihhrrghnkhhumhgrrhhksehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepnhgurggsihhlphhurhgrmhesmhgrrhhvvghllhdrtghomhdp
 rhgtphhtthhopeihrghniihhihhruhhnpgduieefseduieefrdgtohhmpdhrtghpthhtoh
 eprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthhopegtfhhonhhtrghinhes
 rhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:klxIaOBeE_VVSb6Ls9bazVQ6CFURysHcYeR95NTYLDtRQPwc_j3dBg>
 <xmx:klxIaLhpQLOEv5RQEbx-pCy4Dts0BlHSb5m14tIiuIQ3xxsz5tM_yQ>
 <xmx:klxIaKrv7rdb2MeUvpayQdW6xOc0uwS_up7fk-Dsb0DWlnbJ3AownQ>
 <xmx:klxIaOhYZMs-sRU8cBBX2dYZUI0nnB1ch6YkHAzSNpPX2_7iATX3cg>
 <xmx:klxIaPqhXFraa1S9sMobOqEQZDmAf8uvKOos-lssIerDMU1BJk6gkene>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 12:25:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nitin Saxena <nsaxena16@gmail.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>, dev@dpdk.org
Subject: Re: [PATCH v12 0/7] add feature arc in rte_graph
Date: Tue, 10 Jun 2025 18:25:51 +0200
Message-ID: <4302243.3ZeAukHxDK@thomas>
In-Reply-To: <20250605173315.1447003-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250605173315.1447003-1-nsaxena@marvell.com>
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

> Nitin Saxena (7):
>   graph: add API to override node process function
>   graph: add feature arc registrations
>   graph: add feature arc init APIs
>   graph: add feature enable/disable APIs
>   ip4: add ip4 output feature arc
>   app/graph: add custom feature nodes for ip4 output arc
>   test/graph_feature_arc: add functional tests

Applied (with some formatting cleanup), thanks.



