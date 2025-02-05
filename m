Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D3C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 146BB40270;
	Wed,  5 Feb 2025 17:57:43 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 2816040261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:57:42 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9A0CF1140132;
 Wed,  5 Feb 2025 11:57:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 05 Feb 2025 11:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738774661;
 x=1738861061; bh=fy1erEadLKp9ddVp/Fn3drQR1zhiR7aX9ESO2pf7YRk=; b=
 UksFwlidFYmLonPbGLY/T0IHu6KUr6DlbHq4a6cOa45+ClM1Nnzh9mXWfWjQmAtQ
 sfnF2MnwUtLWC6LiCCU8LGDm5zUMndSRQ6UbHjMmsSYelXpuf3UCGDqczMAD5yUH
 RA8SHYp6wOAghRk0a1QCkMZAlhkUVKlnA9odEdRSAqPqPWzNF+Uq0gnatnQjdfwU
 XV7i+/mkhQ9MvWBnWQY68HQZnnyCmiQyCpXpIpfJkj1A4UScXhkm7R+lOsgj1fuK
 KN03tvfNGVRhuFeFdSBKbd68IwycYrXZo40lzTKFmO3wU5JWxACWEx/EBVj1FSue
 swk/pWQOAnBXCGMD4wzuAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738774661; x=
 1738861061; bh=fy1erEadLKp9ddVp/Fn3drQR1zhiR7aX9ESO2pf7YRk=; b=w
 8CZ4cjcrAIWiQLCvUQ99XWcb+VWwvteaNfNbv5AWJAYnrNzOUogmKgMlF0XQXZc/
 dTxYtYnrKQzSBxbPKrdQLDVyB1OSImFuvePrCPPrU/rwqQX/ELOwKPYTh9NDOp2A
 IiK22SdJ8anszoPn9M97M8cMjA1r/nwTskYvu8jaGtpGbFEcgARsT6OqKkkutaUY
 f6WNbh9uW4U/FeczhG2y1+9NCmnWzauZGfmFYN6BS3u7LI6VBMzAwwt5wPPCP+4O
 D/sl2Gzd5nD2hToUD9crVifKgDF2m7eZy72zHrEe/fB7R5UCXbuBAg2m9fcp5Pa2
 VrbelLV0u9gFpuly7x7jA==
X-ME-Sender: <xms:hZijZ5KcdRQWc5u_bLFooSTMlX2X97IypFrjYnZaXtMh8Z78nS2N6g>
 <xme:hZijZ1LyTJtEfx0ESv2HJAgHCg_aKa-F8KVmMvHLfCRbicoZrQ48HfBWp3uJJ5G1F
 x1gDuF_EdqD_yoEFA>
X-ME-Received: <xmr:hZijZxsxcbiRpbPcjla0XprK7avPnBywP2OPcoEhePR1Ciu2KlOfKpc4UsUVVYuN7G1qAZ5s5xI7rQ-N8EN-8ckVBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedttdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrth
 hhshgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohepsghruhgt
 vgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesug
 hpughkrdhorhhgpdhrtghpthhtohepnhgusegrrhhmrdgtohhmpdhrtghpthhtohepughh
 rhhuvhdrthhrihhprghthhhisegrrhhmrdgtohhm
X-ME-Proxy: <xmx:hZijZ6aWFy7DF00xV7MEiy1UaDRJdOgI8b_7pYPm1ukPsBe1bzqHtw>
 <xmx:hZijZwYNsOK-ypRIDGwISPUkXQU2mwaxPlAL-Tkd3H0YZ088dZS61w>
 <xmx:hZijZ-CLF2cRqxwJI9b1ju_xYyaW1fyy6BzHENcBK0KdTai_T6YVcg>
 <xmx:hZijZ-Zfz7Ei34ptdu0jI5412dWBab1VRrhf182jXOzyMB_Uw3Zv3w>
 <xmx:hZijZ_wm0jqx0tJCe502Gd_F8Y8QZhz0cxkegwn_65ENY4f9jEEZ7Bba>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 11:57:40 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, nd@arm.com,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH v3 1/2] config/arm: strict use of -mcpu for supported CPUs
Date: Wed, 05 Feb 2025 17:57:39 +0100
Message-ID: <19321312.jiFIW2sfyF@thomas>
In-Reply-To: <20250106183146.540161-1-wathsala.vithanage@arm.com>
References: <20241028233139.922029-1-wathsala.vithanage@arm.com>
 <20250106183146.540161-1-wathsala.vithanage@arm.com>
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

06/01/2025 19:31, Wathsala Vithanage:
> +    'mcpu_generic_aarch32': {
> +        'march': 'armv8-a',
> +        'march_extensions': ['simd'],
> +    }
> +    'mcpu_thunderx2t99': {
> +        'march': 'armv8.1-a',
> +        'march_extensions': ['crc', 'crypto']
> +    },

A comma is missing.

I can fix it but I am afraid you didn't test it at all.

And we need the CI to run on it.

Please send a v4.


