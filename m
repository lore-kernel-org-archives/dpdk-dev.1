Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75F4CCD195
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 09:45:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00823400D6;
	Wed, 22 Oct 2025 11:45:29 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id E9B8C400D5
 for <dev@dpdk.org>; Wed, 22 Oct 2025 11:45:27 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 72836EC0096;
 Wed, 22 Oct 2025 05:45:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 22 Oct 2025 05:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761126327;
 x=1761212727; bh=Y3YqAGodFFgFtT04jr3K1mPb5E6L8sR/bolA9ZKg3UU=; b=
 ROq/ksRebUcJJPmHNK/qN2GKmiaDbTQ8AmJM88bXNlw/0CyYQxppPju0DDxUHPDl
 b/Isy2dTkgfP9Yp9sD9G/A7tkIYMTniEptxMYcSpMjEcIZ6BVC4rAh8oc6ZTPIpo
 r7DL32Oo7SuVOcGukXPoiji6QEw6c629kvmKXs3PGXwkK/E1AqnKITfoyB3pcooY
 e0qmQZvPzoQ6TGYCShA157b8kpcmBmW0ef+Hq7VkdyZtzf+5VHjLSROfgRhPvWUd
 FWbuPkVvo90x/WTXE5c3sBHr1RRwH7ALBNuHEgMIFw5s3OgGW/5XIiEdQHZGghZT
 SpRtN1CEQtILXpsPDMcnGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761126327; x=
 1761212727; bh=Y3YqAGodFFgFtT04jr3K1mPb5E6L8sR/bolA9ZKg3UU=; b=w
 vudRc/nNjXZqndwp76S/0rIuUjLswOVlWOEUNwAAOrhPjUMuWAP2wqCI6IoGrthL
 qGij4mT6Q3eNIpc3Wjh9qyKnS9B/lbUsmmWGhTNuGZbF/NaHamm2sf//VlIOHQAa
 SANZbHAKTLGzwR1SHi0jJlGqO6PR4xOjP62i0W+gtKe3aCPRx4Uw2qRxo/fYXcVa
 SnZmObuse2rhxdfgAifq34lPKqxcZOe+CbRBoBq5jnMNxjrCKK+IEBDwszTUkpaR
 KXuggxaHlEQb80ZhfsUj2rAb+oWcGwBuBO1k/ndxLZ+0569cskufBKXrOwJKZ4Oq
 FBkybOCinUCrvecs2uL/g==
X-ME-Sender: <xms:tqf4aGE2KaK9rpm7GZWkzRaS0bVSXKwEhNn3jfE0EIwM1kfMgvMEgw>
 <xme:tqf4aFSVDKgp1HL4Pa-R0Hn9Lxmb-GcEGheXEI8z7l3vIppu9c5jxqPDbYhQcTgMc
 gQssCp27DsBdptZvD9YCVdoQDFbVxQCwVQrehlfSfp9xwvSR2WDzQ>
X-ME-Received: <xmr:tqf4aCdOZlR68rIStU4CJd9ZhVzIi4HIKBY-5Y0rUvGbBzeHiG7jA7fdy_b2Ae_gp7YsZC3NptGYPk-jWb9uWWvGYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguihhmohhnrdiihhgrohesnhgvsghulh
 grqdhmrghtrhhigidrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhk
 phhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehkhihordhlihhusehnvggsuhhlrgdqmhgrthhrihigrdgtohhmpdhrtghpthht
 oheplhgvohhnrdihuhesnhgvsghulhgrqdhmrghtrhhigidrtghomhdprhgtphhtthhope
 hsrghmrdgthhgvnhesnhgvsghulhgrqdhmrghtrhhigidrtghomh
X-ME-Proxy: <xmx:tqf4aEqrfQBZ4kYEHAFFXrU7ZpspVHtY_qHmI7EMd2Me3H4fBhzXMg>
 <xmx:tqf4aD_aixU3XairDsDq6SJt0vB_kWGsRGepmX7JSHUkJgafRNFfjA>
 <xmx:tqf4aAdWKg0Vg8IoE9kDeTP_xFl8n0Js1BHLoG3u1ClC3XbCCBPapA>
 <xmx:tqf4aNIJ9ZNAMxmdF6P_FJxMNEMCOQKvKksKF1z5N-sRhX8SANNz-w>
 <xmx:t6f4aK9x3WIIEMFBbDL9WCCxaG72uVjCmZ6FIBcdKd_YVZHoi0OAdoK8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 05:45:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dimon <dimon.zhao@nebula-matrix.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev <dev@dpdk.org>,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon <leon.yu@nebula-matrix.com>,
 Sam <sam.chen@nebula-matrix.com>
Subject: Re: =?UTF-8?B?5Zue5aSN77yaW1BBVENI?= v13 01/17] net/nbl: add doc and
 minimum nbl build framework
Date: Wed, 22 Oct 2025 11:45:22 +0200
Message-ID: <4139672.som1txNFv6@thomas>
In-Reply-To: <1a671259-db95-4d13-9986-c28ff8c360bb.dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251021072102.2308eb46@phoenix.lan>
 <1a671259-db95-4d13-9986-c28ff8c360bb.dimon.zhao@nebula-matrix.com>
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

22/10/2025 03:37, Dimon:
> To clarify, the nbl driver does support all the features listed in the documentation.
> There was a misunderstanding on my part about the submission process - I thought we were supposed to submit basic functionality first,
> and then add features like TSO, checksum offload, and FEC in subsequent patches after the initial driver merge.

Yes it is a good approach.
If you are confident enough, you can also submit these features
as separate patches in the same series.

Please try to update the documentation along the series
in the commits when features appear.


