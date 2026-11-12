Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C65606A336
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=h1n/SGpC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BtsEzWbe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26BD2427C8;
	Thu, 12 Nov 2026 20:53:37 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTPS id 609A6427BB
 for <dev@dpdk.org>; Thu, 12 Nov 2026 20:53:35 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8122D7A0441
 for <dev@dpdk.org>; Thu, 12 Nov 2026 14:53:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 12 Nov 2026 14:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794513214;
 x=1794599614; bh=7HUxVxjEDiF38OOpI5qufxsnYL7l8m+pvA9H76IZiR0=; b=
 h1n/SGpCGK2CW2CLktZLh9DiLsbejhQAGfkSk6mwKye/QUXFjUJybXWN7T67m+MB
 MS6xadDhAkYCpg0+wlB9ZjvpEcLRepyOSgFPfErhRWi46cokdxbKHHW8YuhYT8VC
 tbKQSpNcqBph3by07WuCJbTP25fAuVgfrhSXG2Iw3pX7HSRfPkkZcJ/w0UO0pp9v
 wgmVj14pplMFDo85+XquaWzAjlp/JlN39cAxzKm7Yh4IKWaOWeEOggxd9HLRITaP
 pplF9h155wLu+MZPqBkb8guRUF0ZuO+aZVv1oKC6e9IslBhrWDf/qbf/R/lg6dJC
 rhqmmzqdg+BPBiSo5gQc4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794513214; x=
 1794599614; bh=7HUxVxjEDiF38OOpI5qufxsnYL7l8m+pvA9H76IZiR0=; b=B
 tsEzWbeWHwlO7ev226rPHSCGvFhxLO4IpsQS476bUIUIENPR22lTrftHbo/TxUHV
 +d357/aaIydnziKtVb1excEFn1QbDtJHwJHGd53t1lIywQSlSx46Qo/guAWihgBT
 OBemTpRuo9M5lGPBlYZxEAbybrZFm85K7mU0tkvT3e8wDfbCaPIg2iMOcQjY6sJG
 0PU5y0rs7S6aAS7wz8YwG/JCV4t0VNI2BOzsZmv5+UnoIksr6+OtBdqkBscA3MXn
 4HLzJmWLuZSx1PLLKeqB1fB2zR9WeWgpL/u11R/+PaFvmkq/9vdlNtmNvP5cabrS
 VrwgmFHsjEJD88Z6ZEmQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794513214; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:1pcB1nyNPrhKtfAQ1GGNl/ISbcDBflEYn2MaNRmwqgOfeNB
 I01YT+ogxkJyYbkmTBSzrpENLhV6MvyAD0XvAoGxxrnzB1c2Pc9mdB0YevvniK3I
 5CXfVNQCFosFHKbjgzPN2qoIyrvgpbXukeZiVVTx89kg6Ly+/5d6aw0q3NYgkKuj
 KuaL7QZM+Qyeu0lhgRhibhsW1GQkPrKTuzEUudCZDN4C18+VQ2QZ7tPLIgGtCZuT
 hIUMDKLjkvaN2MW7bfDGwHgWWchNFCQRv/mlGRbPvz27OMRrsXXjQJOYYdwpcKf2
 fpwEqFjwP/qEaPGh8RNtfxIbKPwSyCHzX9s9OcQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:IHmuS+4L1Swy5dRsnHTMjxOzPXMUyGE9cjdDs6YVoEg=:yZllwZA3oJR8PjPWX04OBWV0BgoUNLx2GhOfoGEqBTk=;
X-ME-Sender: <xms:PRn2akzJ7z5Tz7bZxvOlsSCwkIe6R-cNf0cSPeCQnjYaqAoZ5tay3A>
 <xme:PRn2ahNX_7iWB9HN11W5MsPBwJFEZa1ZSOxbkEJw7JUctMuqQ68p3ILUDPgc9UXmv
 62PPXoNjmR_GV-WJC6PCrkqBlPwt9zcfqxtBX6RTfc_ooZW3rz2WLE>
X-ME-Received: <xmr:PRn2ah5tsEIl7JHzNleSRkiViqA2uAKsIHQI2QoKx1xI5L8w8G38oqhKmTwdAsa8vCPMQlWUlMXwd4WA5k4v2qE>
X-ME-Proxy-Cause: dmFkZTG4TYSJjjd9o7werDr8FI2Oi+2+BkCPhgKe906Hv4weOtIpYodgbHvl6uE/b3XJZ2
 sui9vtTtAg7+knPcR3Fcc79kR9ikaK9SH+W5TCXJmIT4igbrhB6bB4yeG2IQIJjsYc8502
 bj6Cewjwik+Ukgud2fnUaSnq8nlh2+wr0bvUR71m7ZQsE4mCAI2bxL6t9EvS8/vUuDqoUH
 i00OhzwB+uBEo0rUAZGyRiKBvQPzhpdBQBXdM86eKRP9XIRNGj7fHn0cs8MhGsDW/kLqL1
 OIlm4isOU4fut+nuMgxWp2DKMlUJ/4zKnPlX8xTu0k7aiFcmSqY2fuSJas1fV1lMJU/QRa
 3tiqo2cHlT5HN4yyd863lemPUtozXyFjShb2/Ee6bL97s5iMiTdCOksZl1un27omSfMU9w
 yrKnHzZls36J75MxJUatVtab+lj2zD+rwuh0SbcEIFWBQXpNfcK4ks6rHjK4X9W9EyFUFw
 HuQLGeKgc018T1yEWFs6guhhpqQtYwU280XWdYVcYNDs94si0+MZyp+Orjq9ObS8YLwjb9
 MO6T7/MAsA94+dsOY8KjEKSdC2IL1+u7jlApU+dNYolTFsg1rk69WAeqqFuUoMCQZ4blb2
 T/m/z0mTiNLB2zMi9dlY7WUYMhKjzhRXh4oq0c2IyKUgAUNaIYRg2CRE9E0A
X-ME-Proxy: <xmx:PRn2aimrQHrOC95bhNzdMQtGGQJYXZkL1kQIvl-cjJW5MruHkeXZiQ>
 <xmx:PRn2aiQR38divMStxOzk4JMQGpQo59g5bieyYPzqwwHWxx0KDpQS7g>
 <xmx:PRn2ahEUfmyqAQ0viQE3QEbOYhNKHliQy9N-ZnryfTJfu-bAt8MWdw>
 <xmx:PRn2anGg1xsyzEO9m-U0_VuK58GRCCvGaNx7S6rGwHVZwoiZ3zNejQ>
 <xmx:Phn2aorJGwMVoQrvsqmVObVpyiScNRmo2t9P6OXsCaqrMks8f9hhDXUW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 14:53:32 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jerin Jacob <jerinj@marvell.com>
Cc: Rajesh Kumar <rajesh3.kumar@intel.com>, dev@dpdk.org,
 bruce.richardson@intel.com, david.marchand@redhat.com, stable@dpdk.org
Subject: Re: [dpdk-dev] [PATCH v2] examples/ptp_tap_relay_sw: fix build
 inclusion
Date: Thu, 12 Nov 2026 20:53:31 +0100
Message-ID: <9IASiqyUSx20jFcnbit1Dg@monjalon.net>
In-Reply-To: <20260902153331.691687-1-jerinj@marvell.com>
References: <20260902082523.206083-1-jerinj@marvell.com>
 <20260902153331.691687-1-jerinj@marvell.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

02/09/2026 17:33, jerinj@marvell.com:
> From: Jerin Jacob <jerinj@marvell.com>
> 
> The ptp_tap_relay_sw example was not building because
> examples/meson.build was not updated to wire up this directory.
> 
> Fixes: bec00deaa8fb ("examples/ptp_tap_relay_sw: add PTP transparent clock relay")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



