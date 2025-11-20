Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385ACF9C7A
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 17:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB1974026F;
	Thu, 20 Nov 2025 18:39:25 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id A788840262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 18:39:24 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 975D27A01C6;
 Thu, 20 Nov 2025 12:39:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 20 Nov 2025 12:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763660363;
 x=1763746763; bh=b8DlCSjwyl/vIWKYB6TZXbPGlS/zFm4hNml32X9Tayg=; b=
 nCwdkz4vJ6++7JkkRcmJvn4o5SNsYctaGW3L++0sgnymz0U+eGE+H4rhsSYO/+8j
 p9rVBiYTa1JTWPEXLsS3TodQd+h2nKsFjG4pN+YdvMQCPyXCGDGTTRUawkVKYDMb
 rJvNnvMz8QDUNhFyxyAlSFkiMZA++xR8AlopZTofQAa/53RGDOxsJ2DukldL8VQX
 qM7GgV3MRIXwVckBRW5mMDBDw4cigzn3kDLWs+DaiNoKrw5/gA0OmnUhuyhAJczq
 cqfU25orr88TiAJlZbs6Y0ZcU1pErVieY4MeZY0rXwJe9o85mz7eZ9xev4LhrAD6
 xswTsEo9cPKi8sxKTdf0Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763660363; x=
 1763746763; bh=b8DlCSjwyl/vIWKYB6TZXbPGlS/zFm4hNml32X9Tayg=; b=3
 ESBjKif29w2hAJ4CCZIQgRrCbPxfamjLNwAk2gN9i0zw/+Pq6B/YbWRK+OO26SK+
 93R7vqSKNilaj0Zjx07jJv+x05myKzdSE7GEIUMcs9wuTuy1XnuHA7nCoD49NZbK
 IMhT5Jm7d5/AS8I+KiglsYzM1UJjJuQQyfylPC5BZ1yqpEvf+ymIFSjw9M6W2h/B
 SNqOolxS7+dz7TDrEXUaMJGfu0vqg5q0FKn+7sOr3KkSnoVJSXLHxXsBNBJ6YTIf
 WSMRiA0Lg5P+v+qU17ii7k99Q2H1wsgwqyjCQVwc780LUtUReEQahv7uJapZnRUx
 y62tygo36zHaOGIvVsLag==
X-ME-Sender: <xms:SlIfaeary4BZjdRBlS_xZXNiHNf_iyo1_3e2rRJ5_785MFD0u3ecwg>
 <xme:SlIfadSnFbaZtGYv6OoYYJUIxFbNg4bScX-3tKsvMhI-PMofqt4jFFWdQkewbA_p5
 QKiS5Q_ROawZxVAI6kRs-CWSa970alkWUwJqby_aT1jTu7IBYpT1Dg>
X-ME-Received: <xmr:SlIfaV8IPFvjOVfgiWBjE3hzjUX8jPPEqpnHNEVYOzWSPt-WHGfkAdzq_f9BciKAbeBOEwWKbk-t5HlJJ5EqWvVdJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejjedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduvddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepkhhtrhgrhihnohhrsehrvgguhhgrthdrtghomhdprhgtphht
 thhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslh
 grvhhosehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdp
 rhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhopegushhosh
 hnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhurghnmhhinhhgmhes
 nhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:S1IfaVhV2p4RUjeT62V0AyYNYB5Bt0w0Go3T8fNCbtxmqCY6Q8uFAQ>
 <xmx:S1IfaeafFJG4kxegoxAKhW8dWJ3-H7cVMq1uMIQWMWX8w7OcxsFAqA>
 <xmx:S1IfaS_2Jlzy83gAXfFCOQ8-5ibiXw08VbqCl51u0Be8WcSRbj13aA>
 <xmx:S1IfaYOiozmyGIecw26_GkKMN3H-Grssx3jF1mR8nGXrT0QmO3E6Pw>
 <xmx:S1IfaZvnJ6Mdgn1PQ-UoDEcZovuwKXECBPPC1pDYCGZKSSux3g_6x8-h>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 12:39:21 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: rasland@nvidia.com, Kevin Traynor <ktraynor@redhat.com>
Cc: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org,
 orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, Roi Dayan <roid@nvidia.com>, xuemingl@nvidia.com,
 Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH 1/4] net/mlx5: release representor interrupt handler
Date: Thu, 20 Nov 2025 18:39:19 +0100
Message-ID: <5256033.1IzOArtZ34@thomas>
In-Reply-To: <2da88441-307a-4287-8387-d1906edf3755@redhat.com>
References: <20251112074015.8901-1-bingz@nvidia.com>
 <2da88441-307a-4287-8387-d1906edf3755@redhat.com>
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

20/11/2025 18:08, Kevin Traynor:
> On 12/11/2025 07:40, Bing Zhao wrote:
> > From: Roi Dayan <roid@nvidia.com>
> > 
> > Looks like commit the cited commit removed the representor
> > interrupt handler cleanup by mistake. Fix it.
> > 
> > Fixes: 5cf0707fc7e9 ("net/mlx5: remove Rx queue data list from device")
> > Cc: xuemingl@nvidia.com
> > 
> 
> Hi,
> 
> Some of this series (see below) is fixing issues in older releases, but
> does not include stable tag to indicate the fixes should be backported.
> 
> Just checking if this is deliberate, or an oversight and they should be
> backported ?
> 
> thanks,
> Kevin.
> 
> 25.11 dbaed15366 - F net/mlx5: release representor interrupt handler
> (Fixes issue in 21.11)
> 
> 25.11 aef94343d3 - F common/mlx5: release unused mempool entries (Fixes
> issue in  21.11 (partially fixed in 8947eebc999e @ 21.11))
> 
> 25.11 8d1fe10768 - F net/mlx5/hws: fix buddy memory allocation (Fixes
> issue in 22.11)

I think it is an oversight.
Usually I fix it myself, but this time I missed some.

Raslan, please run devtools/check-git-log.sh for each patch,
it is raising such issue.


