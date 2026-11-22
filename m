Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F9606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=br4+sDzK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NjmknckS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9586F402D5;
	Sun, 22 Nov 2026 10:23:34 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTPS id 64874402CC
 for <dev@dpdk.org>; Sun, 22 Nov 2026 10:23:32 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 466641D0055A
 for <dev@dpdk.org>; Sun, 22 Nov 2026 04:23:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sun, 22 Nov 2026 04:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795339410;
 x=1795425810; bh=vHFGT9d5eezt5/dyetP6VwwU/iwPARi6b19m+WAvFPY=; b=
 br4+sDzKE/7HbdA3ko155zXrsE62TvwuTPBkxYWm3NnxrSxNnmqoIxoQe5nMuD9J
 j5atRONcebUeAZeTax9GMbGOqGwJUHoGPvX+Umdp8/62J3K4vM0U2iOSLMp8pQtc
 xL2/r7sPWDd/HREA/wIs+UTXuUOwqQbAwGBRX9ZZutvG0nDKm+ZmnvLADv2j0am3
 jkEfFhfgBm6uUONKqaGfpknDgtizVnFuSDUlTwmJ9kMs/VRiqm3K7sYMaffn/rgF
 zIL3MmVtEa3xK+NqxSu+2KVhBAVBJiLw/IfKH7o7mnaGpuF6vuk4/2JqjQy2s97s
 KB7w1YkyBfu0Pqz1Im3q9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795339410; x=
 1795425810; bh=vHFGT9d5eezt5/dyetP6VwwU/iwPARi6b19m+WAvFPY=; b=N
 jmknckSH5wo1i4cNrrpuBQ4VCBg7ybhJz+LbQljmvzTzV6s09v9mq60pbAWVjX9k
 zS9Bmn6vE2a6P/1mC2dfiR6FocGFTiwELJ2afWWAAs18O02fsWJogH9ooA4tyfub
 NqbSfrqEmNsQzdULoTRxaWjAKYoI6T2FmQPzZTTYC7OEIBXVUjK0rOUU7ivqIlsK
 eH2mPfuuvZVfLogfQgqjjZeXP8F/2mcumpApQzQvY8aQw1apnhI9kRb+TbSGWgV3
 UUpW2sjngtqaYR+/qhvSvtxE6UGJ2OV1k2y/j9AgXwXyd6+Gk8XnJHydzrCu+6Cq
 w0u+126hoGm9la2OGw7aQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795339410; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:X2qW4q5Nqj3HcNHwcFUrIrEx/uJyEu4lFMoDCv8NqmRBPZ5
 dhouO8mWRs3TGQchTVE+45PGxTTriRNtbV29pJI6Am6Uy98C9/dHu9n6TRLBn+wR
 USEMLXvSEvd/R61NDT/LKMd/PIO9lBTqbDAZPDqzY2vwKBist0kkg0BPQJTeFb/F
 SJV5s1x6S1A7vDcIrSw8TQeYcRFUbStikCZ0347u76af323QNnwAx7KrTASdjdTP
 62xn9voU2E8+9SqVd8hcufGOIYOXeQBdfXC+6T3F+TUjEhmW/Wqlq9zuFxBmBXwv
 Vc+xlsb2zr4lZCC4vYTHlCAWHIm/54i9UlBFdxg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ofjXmJsu/zDPmZ2v2vTriRlVUw7PhN+N3y9B6a2H3rU=:s3ldDKe4X5qtlUS75Uk4extuKqwZl50fySjEmbqGPdU=;
X-ME-Sender: <xms:krQCa6HSypb1_vXcM9G7PSyjbVelRQvx18RcKu8jgznNsNRKwsv05Q>
 <xme:krQCa1a0UYr7_gU3CCmurJEEIpUxAGaksvZWMQ9ioC5gjOKt2__XM7KUgFstJrQeh
 03bPF9wAPJcoZCMwm4U6PBjlvpPCkcAUzT1iWJgH3IFUp5LiB7V-M0>
X-ME-Received: <xmr:krQCa0Bo8ZN19nQXpUTDg5b8yARX7UaAg26DoV2T2UoV2ik37bwdkucjJAyNxZLJbmtSNRGSTDSx0kpZRcPcuL8>
X-ME-Proxy-Cause: dmFkZTFFxVq80fHHN0o9JDCP9mLq6w5TxVYCGKaIb0Z48pv9gkd3/xnKT0FbVzf6GKh4bU
 xnMiYLEAxrxlByZHMENav8+OlDYs678HBx/ihso5vrQktzAEYRwshdzS2EbjWNITn3iDim
 pYXgMCgVZmOQzr6xKTGRBHZXZup2V9c/duMrPdeD9csMDG+6HsaIr/rlmz0m7xpiqw1le0
 /6xch1hqg9mSDhBPQUzTB8gZrq87s9ciESG6d0KR3ag2nqkBqkierNizwT6XckLBmBQKZo
 d+8g1cpy+jLydLWvlpy77ubIob7jlOeyrvUKwGSIO2W2QKyzL6l3D7XAY3aFYmUWAEpXcj
 Mfx5k4+iSlZYcY6KYbsBnYFYD1NfXBKUtZOUYydj3p6HCLdnmMyb2ikH/5GyIwZzpPi1w8
 B4cP6abYbmgOn4kLOEGVoUPcenG2xUh30sshsbZa4nZ4hgO7mskploz0jOsCQ/SkHmEI5J
 i+q59ycDEVZ7kRoEAdypbBe1OtmQLI3vwtScrTCdd5Mt3mbUwkgGZMxnAF6GVTQgJiZ89Y
 enu5ctKWdrTNWthAgmn3HGbGHSfBx4EYw0KzE8hpljdVslk6DG0FbrT8wQt7O21LTphuss
 50ieWbKDxB/NV3oq+yTzkt5NgWF+FvSz/KRqgFKCgyg41JMCfnHPcTKACaGA
X-ME-Proxy: <xmx:krQCa1ne2wo5nUNeCdfsImPxcPA1VpCbl39ohujN_RhjfEDOL4qYrA>
 <xmx:krQCa9xf-uS6ge0WGx8BV9QDVkzrd7mzspRsB1pWIdVOSTivgIFncA>
 <xmx:krQCa3SWcwz7W6aqS2wiDinQ1CZRaVg6IF8gLq0xTewRgB7mmzLeOA>
 <xmx:krQCa9_VkZloCN_jQUSZN416De3jWcgPuJ84pnWtuQrzlHRU1Shvmw>
 <xmx:krQCa6iX5o0hXH7UZ0KITPEP5PbXzUolmiOIlJL2xTZCHlxtQoeuxSy3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 04:23:28 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Renyong Wan <wanry@yunsilicon.com>
Cc: dev@dpdk.org, nana@yunsilicon.com, qianr@yunsilicon.com,
 zhangxx@yunsilicon.com, xudw@yunsilicon.com, stable@dpdk.org
Subject: Re: [PATCH v4 2/3] net/xsc: fix leak and missing null check
Date: Sun, 22 Nov 2026 10:23:26 +0100
Message-ID: <YSPAk0PzQzWZ902MEu49rA@monjalon.net>
In-Reply-To: <cd058a44-77ab-4db6-9c15-fa38c6f73d8d@yunsilicon.com>
References: <1794914060.606144@yunsilicon.com>
 <PHN9AhH-TR23VM6YCYNEYw@monjalon.net>
 <cd058a44-77ab-4db6-9c15-fa38c6f73d8d@yunsilicon.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

21/11/2026 09:04, Renyong Wan:
> On 11/20/2026 6:36 PM, Thomas Monjalon wrote:
> > 17/11/2026 12:14, Renyong Wan:
> >> xsc_dev_init() leaks the structure when the dev_ops lookup fails. Free
> >> it there: xsc_dev_uninit() cannot be used, as xsc_dev_close()
> >> dereferences xdev->dev_ops.
> >>
> >> xsc_ethdev_tx_queue_setup() misses the NULL check on the
> >> rte_malloc_socket() result. Return -ENOMEM, as the Rx path does.
> > 
> > I don't see how fixes are related.
> > It's probably better to have 2 commits.
> 
> Hi Thomas,
> 
> You are right, they are two different bugs in two different functions.
> They ended up in one commit because the GCC analyzer reported them under
> a single entry, written in the original report as:
> 
>   46: xsc_dev_init() leaks a structure on the dev_ops failure path,
>     and the Tx queue allocation is dereferenced without a NULL check.
> 
> So I fixed both where they were reported. They are independent though,
> and each one carries its own Fixes tag.
> 
> If you prefer two commits, I will send a v5 with four patches, the code
> would be identical. Please let me know.

Yes please, better to split.



