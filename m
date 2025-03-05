Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A200C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 11:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89AF3402DD;
	Wed,  5 Mar 2025 12:00:14 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id F3A1340275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 12:00:12 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 46708254017A;
 Wed,  5 Mar 2025 06:00:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 05 Mar 2025 06:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741172412;
 x=1741258812; bh=rvQPquDIca4ihaEsHllxcr4oX1Jj769TwTvd8drYfAE=; b=
 A/FHxvSsr8A8pu+o3HoWgO47yG7JqGcGLKR9mWv8ZYEOXOFZfsSdtS4qbxFvg3bu
 m53Yd+Vs/nfYlJBD1flqiRMJFhcuEyvKSg8B2Zj6H6FVcnFKh8l6fLwATa2iiG+2
 y0TpFXfZ59LNXP9mWvjG1TPyVe/B1PDmeyTSOgk4Nv6ms880gGbk/qZI0lz5Szp4
 Z1NT1m6KoALrQxQsPlyC3z7x6a8nroSDzhwAoBqE5q0yo1JIrb6BLFGSSQf9afOb
 cjAdE+Zp6sf+uWoC3zuNoxtEQhFkzQRnn4s67nHs/VILHQVmQH5oPJJzfmBM35lC
 9loDT0p/wiqwiPoZ/MlaZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741172412; x=
 1741258812; bh=rvQPquDIca4ihaEsHllxcr4oX1Jj769TwTvd8drYfAE=; b=H
 iML4wSDRcyaQ38CaBZtOqaDIZBx11n/yI48Zi8HctQWj1wSfZlYcMYcUrk1fzvfD
 h6HWowyNFjzssDOOuVEyDIyf09mXI26a8KFRV+QX+YZ/wpUCkMdbDOxSz2F2G9Pe
 0Pt2MBMP+pbmMOl82jlQohH4oVC+BP7NtOW5oP9DZZouRGIKRjyyyC7RGoyGHMEi
 ZrYL6pNI+M5xtR5AvIDdBv5TMhlfsLBjB8OysamXK1LkPq0cJq9XdKBXBj25Ed9F
 VkHnq7nIZoBY++80KL8myFglCw+I755+8K4tnEN859RdCIvG1/HZM7I3kjgyItzW
 K9Ig1KTB5ralFgboCmkMA==
X-ME-Sender: <xms:uy7IZxNHr48ecasMTHT_j0Dh_lpoy4luQAUpc1n8NQjyca5BY8xWKA>
 <xme:uy7IZz9x9u4SwDNnHpf4c-LcY1K7bwYM-pV7hnqZAbKBZXRK56o5OVl9i89XPKwHb
 Srjytg6uQ1xv2PYYw>
X-ME-Received: <xmr:uy7IZwQqIShrEeyvxI5s39Kh2Qpop6pGV29_fsr4YExFmk39DWHsUaYUytlT7T4SRfGOWzrNxJ1X3b_K5IJZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdegieefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtoheptghhvghnsghogiesnhhvihguihgrrdgtohhmpd
 hrtghpthhtohepghhmuhhthhhukhhrihhshhhnsehmrghrvhgvlhhlrdgtohhmpdhrtghp
 thhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:uy7IZ9vncVqQV8pJkoVEUgdQgzefLNG46jQdmn0-1FZh1NB0FdVuDA>
 <xmx:uy7IZ5c-9rw8GSr7Jw3N_75Q8_wLs0NtovSoXqwKqDLlTKP91OSctA>
 <xmx:uy7IZ53sLtfsH7rwRv71G0WX5OoQ9ko4IR1h7TNhwfZnwvvP9Ptk6w>
 <xmx:uy7IZ19e6YDqkhV9W9FysyFts59dx7ipfdi0XH1CRyBUk1eJtQi5pA>
 <xmx:vC7IZyHCrnXsw8Yu40JjgYMYv_uRVeMGR9UG9u9JmtpXMk5I0izX7vdh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 06:00:10 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] vhost/crypto: fix locking
Date: Wed, 05 Mar 2025 12:00:08 +0100
Message-ID: <4967556.aV6nBDHxoP@thomas>
In-Reply-To: <617065b3-c58f-4278-82c8-b43009a4cde0@redhat.com>
References: <20250305091217.590887-1-david.marchand@redhat.com>
 <617065b3-c58f-4278-82c8-b43009a4cde0@redhat.com>
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

05/03/2025 10:52, Maxime Coquelin:
> 
> On 3/5/25 10:12 AM, David Marchand wrote:
> > vc_req_out->vq->iotlb_lock is taken twice on the same thread:
> > vc_req_out->vq refers to vc_req->vq (after a memcpy), which itself
> > is a reference to the vq.
> > 
> > clang probably does not detect that the same object is already locked as
> > it does not track object referencies.
> 
> s/referencies/references/
> 
> > 
> > Finish the incomplete and incorrect cleanup and only refer to the
> > &vq->iotlb_lock capability (required by vhost_iova_to_vva).
> > 
> > Fixes: 88c73b5434e6 ("vhost/crypto: fix thread safety check")
> > 
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >   lib/vhost/vhost_crypto.c | 95 +++++++++++++++++++---------------------
> >   1 file changed, 46 insertions(+), 49 deletions(-)
> > 
> 
> 
> Thanks for fixing this!
> With the typo fixed:
> 
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Applied, thanks


