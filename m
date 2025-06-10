Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D69C5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:24:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84E994281D;
	Tue, 10 Jun 2025 08:24:30 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 43DDF402D4
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:24:29 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8BF30254016E;
 Tue, 10 Jun 2025 02:24:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 10 Jun 2025 02:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749536668;
 x=1749623068; bh=s13KNB8GPQ15sCuStfgDjDjx91XlNc2I8EGkKzMM9Es=; b=
 ccwY6piNG0fyoXXu99EfncBFFpnEgxAQ9/awZ2H36tbbTu11QDCgo0GsN5dubipG
 4GUyQWt3jK9Hs0oN6/zzHwekIu6XKvsFLOL3aLyZYoEQyOolvB/MNfKOUpo2j5id
 PSBqiyErJTP8CpWA7NcXfwJ1h7zJgmj+MgCfYLdVfTibnsN2K2+Sgv65qRSxK0sh
 Vnd9VDDx7aft3cEWLDcOq9ZNJLCIJ7o91oxX3s3ERn2Sx8xl1X0iZ5C/NMrmJHlq
 Xbuma5b37KjBMYoqbJzlA/zcVOS/1kZM2g2tEjMnRXqHERVujy4Zyus7sTOp98/a
 /PQENTnZ7GhaYxNTdY2jYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749536668; x=
 1749623068; bh=s13KNB8GPQ15sCuStfgDjDjx91XlNc2I8EGkKzMM9Es=; b=g
 G8T5Z2PYwRteIrua4uDpFbVteTzt9tN/EiZZjhIpOR8WLMTr3kn/Ay2nV0e7eum+
 foHZYusOkgt8DBb5UyqGH1cSUA6RMa9iSPPxad6ZbHITg3s4Hfe+nNGNpFoL9Rg9
 WJZRddufYyKQcz14lzkwlC/xGq5sgNo5epJ6hCYMF2h65NAVwnIuf+zvsPKYDFU/
 gBHIWp85Aqdlr1C5cWPxD3iY4im5r4kZeC708/8W1RCscNX9/zTGrzR2NkZlCSBv
 SmLGigu0oLkpYXoTyYa8IoZJDwATxXKfYFRBOOd3YD05OW4/OAOORby0MMIyjWzd
 0efqbfQH7iAesXY5KGOkw==
X-ME-Sender: <xms:m89HaOtAcJN1_OwOWEBPBA1FiTFw5k-KNpGFcHULaCN2w4wNu5boyw>
 <xme:m89HaDfiuIuO-17Ar0MEyGbpRZlXh3XgJcvGjOcBqcrAyAi2LwykAeBrIsroe5w0e
 SNShULsoWgvNu4HeA>
X-ME-Received: <xmr:m89HaJwTCs1jrPrJ3faj_97URyQPf8JSc4pDs60Pb-n5PbFw93-mUTgZMBccQptbrBJMLdkCYdpehaLRbWP6nbkDRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdefjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhfrh
 gvvgesfhhrvggvsghsugdrohhrghdprhgtphhtthhopegthhgvnhgsohigsehnvhhiughi
 rgdrtghomhdprhgtphhtthhopehnihhpuhhnrdhguhhpthgrsegrmhgurdgtohhmpdhrtg
 hpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhr
 tghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtg
 hpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:m89HaJPtm_vv89xRS_aRlBGzFnvEKnztNgOn5B19z2oleigZ9F9cJA>
 <xmx:m89HaO_9nfJNMGlaC7z-vwqX3KmGguC11LVi7_cYaEoGrd1NcN1IXw>
 <xmx:m89HaBV1pBoh91r3LrddshMs0aCQ5-hV564iD-QpIVX2jylc-iHVfQ>
 <xmx:m89HaHdJMLFtq8AtzgS9SKCia6V8QUSbFrPexm6_rJGv5jHHlLP3nQ>
 <xmx:nM9HaGbtvtx833R2hzlJoLstMyOKMZYcq7T0naJiqUx_wLqUIihVw74S>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 02:24:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jake Freeland <jfree@freebsd.org>
Cc: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH 0/4] BSD PCI Fixes
Date: Tue, 10 Jun 2025 08:24:25 +0200
Message-ID: <13278384.5MRjnR8RnV@thomas>
In-Reply-To: <20250506174046.1136711-1-jfree@FreeBSD.org>
References: <20250506174046.1136711-1-jfree@FreeBSD.org>
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

06/05/2025 19:40, Jake Freeland:
> Hi there,
> 
> The following patchset includes a number of fixes I've made over the
> past year relating to the PCI driver. Most of these changes target
> the FreeBSD platform.
> 
> Let me know if you have any feedback. Thanks.
> 
> Jake Freeland (4):
>   bus/pci: Use force-noreplace flag when mapping PCI resources
>   bus/pci/bsd: Map resources at EAL baseaddr
>   bus/pci/bsd: Eliminate potential overflow
>   bus/pci/bsd: Fix device existence check

Applied, thanks.


