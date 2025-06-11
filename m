Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8F9C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 07:15:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F211402C6;
	Wed, 11 Jun 2025 09:15:42 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id A799B402C2
 for <dev@dpdk.org>; Wed, 11 Jun 2025 09:15:40 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F111F2540226;
 Wed, 11 Jun 2025 03:15:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 03:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749626139;
 x=1749712539; bh=RMNHnMDFSBM9c9MMQky+Rjj74TMlba+fOrDSPdAyNJY=; b=
 FhiBxu+kuDU/afsSNHJYOm8r/K14eXD5O2V62pKnpR+wQt/XzRT3onlZrl4eRCrb
 roWR5LhHfdUilkct5dnJSNjewvj5TQHWM7Bjrwn72tlck0f5i0ujeykcIWlMGqGV
 2bKEj+VIw9Pq/5YN/D1EZd4TZgVNFHwPYic8iYtcrFr0sOMVRFwFEiiLqihyMPAU
 Ulv1sujtaxMOlXhw1iQ/cfbtv4s6pHBgXZyurIrbWWlJmeIbfZwdt4qMQXDg9Qp4
 YZ+OtQ+tWmHx7S91Y/1T0BgWUDawNrH+3OwxS9I0O6GrvAYq3pPXPKgBUUGAy1cn
 dgbGQ/DIi0Ctkg31i+We6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749626139; x=
 1749712539; bh=RMNHnMDFSBM9c9MMQky+Rjj74TMlba+fOrDSPdAyNJY=; b=h
 ZwHvFj0HJSQ5WcVWtCAiavKf6sjLTtgF75I72Tiw9mel9i6lWqPH9GcJ9NVq21sj
 yujlaQTiiLO6Ky4P4mZT9SPZl9I+Os5wHN9sF0CVaPP/KkSwtx/Hv0nKVLgwk+js
 V3PSnqeB9mZ6F2oADxdModbNvO+gxOHBEa6P/ZzQfsFzwHx/HKjItk62vIAP8y6G
 IAQNKBI2TDLBU8bQ7Q/npYbq7724UU2FTW1GsmrYauYOpkIoao35KwVG/U3m5/sx
 kYXly5kVWD8IU7jDmJuLU+kGdxKrFTCWOh23BD70k/eQ+duGQpEReEHt939Z8pBK
 LBTpxrUjd2Qy6Ki4QJGpg==
X-ME-Sender: <xms:Gy1JaNy1CJ-9NOwivFfAPGvxKg_47QES6fiBJFWl4z4Gs7V1TgpZ6A>
 <xme:Gy1JaNQy30ARljIzMMMyUBzgxIiSCUEpHXb5CX2LbSiJjWhf6CcpzmHTxrJPUcF3o
 FuDc1FI_SHY6rccxg>
X-ME-Received: <xmr:Gy1JaHV0g9Gby8ZhT5XqzYpO6yHkhrhNZnRg_Tam1EOBfLYD52m6--DYDUzLPho0QeT1k71sMShNAVNn3uMghWiR_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudekjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhirh
 grnhhkuhhmrghrkhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehjvghrihhnjhes
 mhgrrhhvvghllhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvh
 gvlhhlrdgtohhmpdhrtghpthhtohephigrnhiihhhirhhunhgpudeifeesudeifedrtgho
 mhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:Gy1JaPgfWWbC06I7VvCLZojTN3IDhAfrWQHf0b7vmPxkVBVDrFjqaQ>
 <xmx:Gy1JaPAwj2v1i6janyDF4tgv7er2mecwZ-sOoGA1-YvwzG3c91EAtw>
 <xmx:Gy1JaIISFjAUg1-uNGujbJZXL-1uxliH8fMF6PlsaueSBVoaMmBNlg>
 <xmx:Gy1JaOA-fIxa384Klq6LLxTz2e8A8SFtiCuflw7lrm8r7ouIfxwi0g>
 <xmx:Gy1JaP7MwCTMW9Ndd6VQxyixyBlPWMIZM5KyZvE5iR5wIF5w4zmU3Eve>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 03:15:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kiran Kumar K <kirankumark@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, dev@dpdk.org
Subject: Re: [PATCH v7 1/3] graph: avoid global node ID counter
Date: Wed, 11 Jun 2025 09:15:36 +0200
Message-ID: <4401004.BjyWNHgNrj@thomas>
In-Reply-To: <20250505062422.588450-1-kirankumark@marvell.com>
References: <20241126044402.1209998-1-kirankumark@marvell.com>
 <20250505062422.588450-1-kirankumark@marvell.com>
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

05/05/2025 08:24, kirankumark@marvell.com:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> The node id is determined based on a global variable that is
> incremented every time a node is created. Adding changes to
> remove the global counter. Make sure that the node list is always
> ordered by increasing node ids. When creating a new node, pick a free
> id which is not allocated.
> 
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>
> Acked-by: Jerin Jacob <jerinj@marvell.com>

Series applied, thanks.



