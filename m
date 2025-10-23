Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F1CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 20:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D630440151;
	Thu, 23 Oct 2025 22:05:50 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 9030A40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 22:05:49 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 32457EC00C5;
 Thu, 23 Oct 2025 16:05:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Thu, 23 Oct 2025 16:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761249949;
 x=1761336349; bh=40EwN2/Q0geCwn9ewfzTFZC2ox25kBWzgf2srrqoxFw=; b=
 S08lzhAQQEBNDz+7T7HHCPgnyuRjYjjO2le+vEpKl/0s3lhJpOQhMHl0C9SVAGU5
 R4Tcho0rjqef8iHSy1VYPhIyLndYHW8I9GKPj4DOpCSTavss1CoKUqpmGZrCcrzg
 EP+CqiAoS+ylMn6m5CaKAQMiiS0U1UbbcwfANQvmsa1pdHydobcCofQR/R8lKZRD
 P+kC05h1QZzo2KmhfuwvUAG/kIGvmlwKygmBsTN76EJmKfHyalLmBYjFA3e5ZoiK
 IRjP9vPEE7PHUJH0VsaUXQXwJdIhxkivXVIM107p2g6LoAfIIklJqvNYJugFYd4s
 2+cus/JAtR8WRNKHC2fjKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761249949; x=
 1761336349; bh=40EwN2/Q0geCwn9ewfzTFZC2ox25kBWzgf2srrqoxFw=; b=w
 gMLNfR7oqtW0EwCRf9plaFgMMGojbsV7A2x/J8daSHQQFGZfrpBV4ku8LtvvVXvA
 JNvu6Lr6g4lE49bAeYmfMWzJTEMitiHlko5R2Bs2rJPAIChwbpjLQs4gfTroefKi
 TZmEyl73W0nw1WtKd/3uhm5/UEohzaSyjlR5spV25phNvA4lFss4Ig/DjaJOJe8e
 +XstbW8hD5lecs1XBzzYjEQeQlMXVmtgpseDN/UW++Ur99VcrRZAr4t4EVKEXHRa
 oD9qqEzHK3MZXVT2KR5BS8fSaKXrKRIjg60bHhL7sF9ElEEyO6LyXRpKpSYzVyrT
 prT5dLqhO2isw3TDntJqQ==
X-ME-Sender: <xms:nIr6aImJMsFyZZjdF8cDQyt5_VkbTNAUgQkFd8YU7vxONLGwjjV_zg>
 <xme:nIr6aEKSDAQsf4vLCgq4Pssxc6Z8Fu9aodRWmsWxpSfiZqRVhNoXTjm0vhNQeFcI7
 3oXL8lG60_P1c0sk5JyGWBd3CdtoJfDSYthNJ9B0r387MsqiQt8Ew>
X-ME-Received: <xmr:nIr6aJabmCR3X0W0JthHYC0bRVuoPASJdb-fF4wfP4LGrjVAV8sigjxyuL3iULZWak_0bN8CNe_z1Fzkzx-GQI6gEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:nIr6aGaingsFEdXu1_JUghXpzvF_wqQP_02SxCjlFJHtQWu78dkTUw>
 <xmx:nIr6aJm_w9YfuDJBQPGgxvSukY4d017RTe1W2GFz4YOfUf2TEYCnHg>
 <xmx:nIr6aCxTYsYSHdjpJu-gf4CaIIoCT_Yp_wCSU5PQkRb-vqw3iKgq-Q>
 <xmx:nIr6aHNv7YwIdJiMacSo9lHy5rDbg4KgwzV72vg5XTUSyjJ66Tqq0A>
 <xmx:nYr6aNGldqeciwvtxrrlepwBfgGObgE04glICQF2_EkV4kQ75V0ujx-a>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 16:05:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/8] avoid unnecessary use of comma operator
Date: Thu, 23 Oct 2025 22:05:46 +0200
Message-ID: <3190671.o2A3GueYyp@thomas>
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
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

17/10/2025 17:02, Stephen Hemminger:
> Clang has ability to detect suspicious use of comma operator
> where a semicolon would have the same effect.
> Easy enough to fix in DPDK code.
> 
> Stephen Hemminger (8):
>   eal: replace unnecessary comma operator
>   ipsec: replace unnecessary comma operator
>   test: replace unnecessary comma operators
>   app/testpmd: replace comma operator with bracket
>   examples: remove unnecessary use of comma operator
>   net/bnx2x: remove unnecessary comma operator
>   net/bnxt: remove unnecessary use of comma operator
>   config: enable comma warnings

Applied, thanks.

Please could you open bugs for drivers having such commas?



