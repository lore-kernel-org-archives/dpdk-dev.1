Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB31CFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 08:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8AB4021E;
	Fri, 28 Nov 2025 09:54:09 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 1146D400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 09:54:07 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 902A6EC036D;
 Fri, 28 Nov 2025 03:54:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 28 Nov 2025 03:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764320046;
 x=1764406446; bh=rn2s++4DYT7HU6EAnbZGMS/yuzok/pbhcKdMt0yx2nA=; b=
 jrG0eLbfmiFP1hReX+UckRsDMIPyvs4QM6x8jCrmAWHwfkdG2IcA+vkcepqw8xl3
 iuj/c/t+msOnqULYlnUzig6VAam0tsdXZQsHVqRpDjF0xvWxhreah2BxWMk5/UlX
 CvqU3TOg1qTQYxUhGIgtvFjJWiizGoqujFIFRjzRw/UR3opTvmp7/XZ1qZYVWMq6
 QvArq1W306HZ0/nRpPIN1Khl8RFDhWeUlVTS9cXbFgir6zFq+92Lb9Ch462Kj1s8
 FDwrha6X7Eyc+fCferzKaEejZsVaeD4LjeBc4YRNpEIkvVlDVANlZF+61fm3Gm1w
 Qh68AOqplQgQZMYZKmAFkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764320046; x=
 1764406446; bh=rn2s++4DYT7HU6EAnbZGMS/yuzok/pbhcKdMt0yx2nA=; b=s
 GYudBLmMLLmKgNf3titIEmyPiUB0B4NkKU3vSNhAkzDetyRAwGQK8N7Eg/Mf6Acm
 Hb1OPzeBdckLhg5RVG0FBEuFHsI3Zg8BQvkYLMdQ684A27h8xyAcAZ0zKKBeeaYW
 pkGfhLX1U1tqNECprhYsA1/E/0Kcxfi9Cb7sXc031Eu6MWBX+VHyhGW5Yz7GB7Uy
 ebkiNpAt31cZAxtVNE4/GUVtB/4gDh6HIwP6Jf7QPBr0/FMNeXaaC+4cTQCEl+n1
 EBsXCTWRtfCZhTWbd96+TMZNC21/vhIhCZLLlapekH7jNBUgRGOE1cHV9j6NC53P
 WWHcYdvnqB8mtYCuPDtgw==
X-ME-Sender: <xms:LmMpaTZG7GInYw8gDaxlS4WH7d7axhl8Ci1iGgpbL6kUT1rGFITgqQ>
 <xme:LmMpaWtUDpHGdwAbUqjS_VgtlEtUSkLJJWSB4E69Jp6l1-bLdb_odJQM6fs8RKlja
 DcaFhMYf6iCcYcLSYMzRIS3xaU9ml00_KvSWeBQg0O9D-CItANA>
X-ME-Received: <xmr:LmMpaVHGKhtVmfLNCqZ5-6JnLJnvLK2Uc5nBanuSVQwIKnYnx27Bj92sL1jzQ03nGIZckJMYrOX2zpIGLZ34pbQqCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeelgeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrgdrsghotggtrghsshhisehgmh
 grihhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 sghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:LmMpaRwu4cGE_QffxrlxaCAMPbfooWe64q9gKR4NbQQ0kez2SKNicA>
 <xmx:LmMpaUjSm9pofidruMRvC3iqH5b1lv61Je90LfHNgK74beu7Ejp1ww>
 <xmx:LmMpaUy8b0ajDugFeC1t0Se3eLRcD9x50ikenTm7w3d6wbzEf1vVwA>
 <xmx:LmMpafLvMEmK8RHTWqvgyUs2nTk-H1s1zO_MfUcSDfZ_fnqyNCzDBQ>
 <xmx:LmMpaTd2nnoYC3-8A3GPKS2wy0LuDUEldGPUaEXNlezoGNv2aifCol8j>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 03:54:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: luca.boccassi@gmail.com
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] test/debug: fix test failure on ppc64
Date: Fri, 28 Nov 2025 09:54:04 +0100
Message-ID: <5872466.31r3eYUQgx@thomas>
In-Reply-To: <aShb5MBcGuyTbb1T@bricha3-mobl1.ger.corp.intel.com>
References: <20251125103935.1729434-1-luca.boccassi@gmail.com>
 <aShb5MBcGuyTbb1T@bricha3-mobl1.ger.corp.intel.com>
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

27/11/2025 15:10, Bruce Richardson:
> On Tue, Nov 25, 2025 at 10:39:13AM +0000, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <bluca@debian.org>
> > 
> > 1001s Running binary with argv[]:'/tmp/autopkgtest.LvdXhc/build.6vT/src/build/app/dpdk-test' '--file-prefix=debug' '-l' '0' '--no-huge' '-m' '2048'
> > <...>
> > 1001s EAL: Cannot use IOVA as 'PA' since physical addresses are not available
> > 
> > This is similar to 6b07762e949036389030cf5a1a9bb8a1e4d6ee2d,
> > on ppc64 iova-mode=pa is the default, but it doesn't work with --no-huge,
> > so add --iova-mode=va to the test arguments.
> > 
> > Fixes: 2b403dd8fb37 ("test/debug: fix crash with mlx5 devices")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



> > +#ifdef RTE_ARCH_PPC_64
> > +		/* iova=pa is the default, but fails on ppc64 with --no-huge */
> > +		test_args[7] = "--iova-mode=va";
> > +#else
> > +		test_args[7] = "";
> > +#endif
> 
> Next release we should maybe see if we can remove the #ifdefs and just
> iova=va for all architectures.

Yes


