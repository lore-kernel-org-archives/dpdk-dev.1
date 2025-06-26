Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73CEC7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:15:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4107E402AE;
	Thu, 26 Jun 2025 15:15:03 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id F3314400D6;
 Thu, 26 Jun 2025 15:15:01 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 57A12EC01AF;
 Thu, 26 Jun 2025 09:15:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 26 Jun 2025 09:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750943701;
 x=1751030101; bh=ZFe+n+FsERmj+1x+Mp1k3fhK6RdcQrcULU3q5QpR1L4=; b=
 B/Aq7thJW1jcLhRGWpiiluHaTRDbOiRyms4OFVp4VoFupiFJDuMlT+bTjk4HGwPI
 6xn6CG/1A0NWL6lS2wU88F8aVPtmOedrPKKYsI9dZKCPVo3lgiDrJN5HHgHK0XE5
 7gUvfvipvYuXEY63DSbB9IQWNLdvhr484A8g8Co6wylEF7Qjp38tQQ1JZNH7wd1K
 qD5A/XicdtJCm76Rr7824+b1ZjG0s7atlgcx0aPB602eZvna78lTeLAQGH9jEYsG
 pd4f65AKhZq33K+/6DqKxDNOM/gi8inbbLyXy5y8cIESwtpnIm4RqP/wJff2fANv
 pQQpjziiKAOB23LGicbqoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750943701; x=
 1751030101; bh=ZFe+n+FsERmj+1x+Mp1k3fhK6RdcQrcULU3q5QpR1L4=; b=Z
 nbavFoSFPrvJ1iKXRb/JCD98QKinA1G6bwH6k0uv/KpTDJKCz18wsiVvCGfN+H/N
 TM32lqJxC3du5QVo5vIjbXwI6iAwUlvZzp0mgVWVWsSeE6vEaIVCFZZ+r+0Rd+ck
 shA5IHkRJBWBFUlbA1dhQUgg8dZNzIXlEkc5CdLtCNqAVuNP+Tx8G76vmXpnok+c
 rWK4YpFqLZMhEYzyhWntYG/mOzYl46dNLKwUkxX8ktg1TWNSL0s+Tow74RYPFFDi
 /eWsI3zJqvD0j/atWE/R5YFsmSGe8zIzvRA+hdH3wEzrkeuwXQ0/qz4OEYrtsbVC
 c0drP2ae8JVcMOvWlKLew==
X-ME-Sender: <xms:1EddaAUcyIWvQqx4ecUifb-ivzzj-gn9Inwx_5COc_qOpH-e6SXI3g>
 <xme:1EddaEmI8jEF3sH8zSAfOdG3s7mbB2vABtYEBDC7RSlcU1obvZ6StStdcU-u4sNKJ
 er4iQSIpS_g8m7_ZQ>
X-ME-Received: <xmr:1EddaEb1YRP8ErmqG_CKHAkf86gvEi8VDfJN87opydHm0L5C1yNJjJ-QXr5Lf1Vj1is6PcsueI78bNdnk3qAAj6kug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehgvghtvghlshhonhesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggslhgv
 seguphgukhdrohhrghdprhgtphhtthhopehmkhgrshhhrghnihesnhhvihguihgrrdgtoh
 hmpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
 ughsohhsnhhofihskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvg
 hslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopegsihhnghiisehnvhhiughi
 rgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:1UddaPW-fVg82ohcBmWj-l3WzyFV42XJePgnhKRAO5ThDeSewCBi5A>
 <xmx:1UddaKkwOmPKgPuaLdhkJwffdpn-A_0QLwSTUCWmM_hwTcZlPrVHzw>
 <xmx:1UddaEcqMXK1kJlsCKgBkEMlUNXKfGmpkHaG7f88HiZpYHHYRpNVCg>
 <xmx:1UddaMFb_Mj2wVZRYAdC30r9gBl5hRkVZH3jm9RFjXSb8pzN6Kwgxg>
 <xmx:1UddaGy5D9fR9C-Z2c-f9DbiLA1nvYeTPHqRURDUTNPYkriMITgExQmC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 09:14:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Xueming Li <xuemingl@nvidia.com>
Subject: Re: [PATCH] common/mlx5: fix extraction of auxiliary network device
 name
Date: Thu, 26 Jun 2025 15:14:57 +0200
Message-ID: <4436503.9XhxPE3A7Q@thomas>
In-Reply-To: <20250615074129.52396-1-getelson@nvidia.com>
References: <20250615074129.52396-1-getelson@nvidia.com>
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

15/06/2025 09:41, Gregory Etelson:
> The PMD reads auxiliary network device name from the Linux SYSFS.
> 
> The current implementation closed directory context before it copied
> a file name from that directory into internal buffer.
> 
> The patch closes SYSFS directory after file name was copied.
> 
> Fixes: 777b72a9339c ("common/mlx5: support auxiliary bus")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

It was working by chance before this fix.

Applied, thanks.




