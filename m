Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9FCC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 11:22:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99E4240B92;
	Thu,  6 Feb 2025 12:22:09 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 5B81C4026C;
 Thu,  6 Feb 2025 12:22:07 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6B00525400FB;
 Thu,  6 Feb 2025 06:22:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 06:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738840926;
 x=1738927326; bh=IZrSXEHHk6Nw3mzKyGOTZp6yMoSj9EWfmavR74Dse+Y=; b=
 Er56KoqblG+mqX8pMSZyWVZH4JPwryp+vxie35fcW6FHJCCI9cdOo0JQFV+yD1sn
 YQuOMy0kk4gcBFL3yCEJT623Qjt9C6erGpQQl4OkoSAnQL7Y0sqNsSgfQoNHyD2H
 dF9FZ6lZ3svPJpbD8pLuFd8uPw4VcMlwO7FKrYR5RpSRqKz4fvUuMjyu8oHrAFUR
 koBTcDMs3pA8g7XJvpoXIXlPMiV5UbizzG9Jys0+Wa6TAKyZz4fNF+1F7M6DN7wK
 OOmvqGWswFf63r+PnZEj2cdSVyxQ61OApYg1xArHsIREI/oy7Z/mnNmJ22sqv5BA
 jvogW5cT+iRUPZbdClmksw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738840926; x=
 1738927326; bh=IZrSXEHHk6Nw3mzKyGOTZp6yMoSj9EWfmavR74Dse+Y=; b=F
 fyLXWFrOWyp4IqtfMiv3jlYtbukyHEyu3/pSftWcSdBT0ah7Cu7HjR+SIBJT8LoT
 7fW1tijgHnLKJ9qcvxJSloyoZZ5cVvZgZ+KHbFFLmk/5iP4RRtCPJmK3mcYcuDoT
 ZRRea80aG2V2Y8F9XILhwbQg2q6HdCtl+v7Yptt94YcbCoVUImAaJM3yZs1jLP3f
 1eh4hYabexODryER4k18JKHkutw774tcq9g2rhDvqNaF0yLyvj+ERRsWLazIO75r
 L99wGgYhPWIWTDjCbMP4a+OnZhfsHMV8iAkLKyykfKdyufaL0itMKyeJmW40/f92
 faXYhQpPiaiY6LVWQPacg==
X-ME-Sender: <xms:XZukZ_7q_UYOpQD-nDd_zmSuNViRtlgl-9HU5iHNIC82ebl8PiN4jw>
 <xme:XZukZ05eW4mptWOfYFbQURWbcrRT0ZLpK9-S-2T1__RLWzWGQjMDJi2ADoGBiuHSv
 uQIdgJMAijzOUYymQ>
X-ME-Received: <xmr:XZukZ2eT6R2W7Y7H-V0tp_KSHMtdwwxlBvmT4QbMcviyYO1BuUvJ6JqeqEFWb2PGp5SKHp-nDI-8YIcs2K4vwEnqiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhph
 gvrhgvthiisehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhr
 ghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
 dprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheptghhvghn
 sghogiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhhiphhunhdrghhuphhtrgesrg
 hmugdrtghomhdprhgtphhtthhopehgrhhivhgvsehuvdehiedrnhgvth
X-ME-Proxy: <xmx:XZukZwK5uRB4jmKgckUtpfSd5KNwllkDvpv2GV2VSh9KCgEhiTtznA>
 <xmx:XZukZzJWZ4EeNP3FnHZXpgQF7m3jUZYYpyrDOwrWc3L30xr1bCujJg>
 <xmx:XZukZ5w7b0Nf9KCN8SplIs3UlXjWZp08Nnc_AXKj3aY4D3wjKaoMJQ>
 <xmx:XZukZ_IaWFTGm1vhuDVd2ie1G3PPIkHNKzBPG3NjNcOXbSU95ixweg>
 <xmx:XpukZ68j0A3jmMfDTsaJG2oI67FydneYLj2Ms7-QIEmWgefGxklTybGe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 06:22:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, stable@dpdk.org,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Gaetan Rivet <grive@u256.net>, Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH v5 1/4] bus/pci: fix registration of PCI device
Date: Thu, 06 Feb 2025 12:22:02 +0100
Message-ID: <48302730.XUcTiDjVJD@thomas>
In-Reply-To: <20250206000838.23428-2-shperetz@nvidia.com>
References: <20250129085416.226718-1-shperetz@nvidia.com>
 <20250206000838.23428-1-shperetz@nvidia.com>
 <20250206000838.23428-2-shperetz@nvidia.com>
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

06/02/2025 01:08, Shani Peretz:
> When registering a new PCI device, the device->name field stored
> the user-provided string from devargs (e.g., "08:00.0" or "0000:08:00.0").
> This approach led to inconsistencies when registering new devices.
> 
> This patch fix this issue by saving the parsed PCI in device->name,
> so when a new PCI device is registering the name displayed in the device
> list will be the parsed version.
> 
> Fixes: 23eaa9059ec2 ("bus/pci: use given name as generic name")
> 
> Cc: stable@dpdk.org
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

It's way simpler.
Acked-by: Thomas Monjalon <thomas@monjalon.net>


