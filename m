Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040CACCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 15:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E683240612;
	Tue, 14 Oct 2025 17:15:00 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 8BC07402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 17:14:59 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D876D7A016B;
 Tue, 14 Oct 2025 11:14:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 11:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760454898;
 x=1760541298; bh=ltaA5JSIWFL1ofJjaQQLkYLMgt0/e+o618N/pJ8cZ/0=; b=
 c3Jb4WTHJ+gcUTGgI4/+4+tnrTB7ZhGLr0nxJbeV3/dwbDqmsUJM+z4kPddGqc6z
 ozfKZTg3r2L2T/064sEkkelvb9f79EyUMV9thTN0F6hy4iQAC9JUzvHMbov2zo8b
 GMqsIqAtM2vVwaydAegXFkit3/IZGfJXh8Iqpa/7lcmj93U65d4JnbmuoreCbMaZ
 iIg5X6lsWeceuUxZzABbwikRNDUc7ZEZIDjYh4y+O0NEOPEF+C34UT+fxRvdyVFf
 2XOYD5swTM8leRNbjPCYbQUbopYAV9FQlL7uNoTDqZH2YdDB47pUVhEAYj1r7IZl
 /ryS2Um99fco0IU2AZjPdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760454898; x=
 1760541298; bh=ltaA5JSIWFL1ofJjaQQLkYLMgt0/e+o618N/pJ8cZ/0=; b=k
 RTqyzR2kNsVtEiB5zV66/LB7Q0hRwPPAUmyHC7FSkSqNaHacn7tRTjmtYcC8+Pvn
 MSd6pC1JzunRv3Npky1WYOJcHPZY1FJ3qnXzq4rUn7+kMICbEURtlzXcE5c50POm
 sTcGLKM+8c12VL9nLC1fDXLrkFB8jc+z+HcA87v0IWuxhUivJ5wFqsuN4dgsgrEK
 i3eDZ3WANChW1caYYesACt9QinqWPTjH9F7Qv4OFEaCUM4mNF6koxJ0ziwdTgEi1
 NvHzizH36T1Qg9rsTrhKuObBhDeOMdBS00ovH2CPnslczqGZgGN/t203jDTzhDpI
 D3in5DZvYdViHdp7WT1dQ==
X-ME-Sender: <xms:8mjuaDAMoB6JH7jzfPtb9H7YNPHNyFP8LLjn4jcpqacOdtmxCizcDA>
 <xme:8mjuaF09A3P9M99GHcEL1p3HpTzm0XdAY6WhW-NqjE0MC6zSnEM4Pjmnn1TyH6x48
 vkb37Q1cEnW3Ic7XL550RZTKAhhzjgr62jM5GeoFT1uoVC67P7QVxY>
X-ME-Received: <xmr:8mjuaBW4PSjyY-KSaezIzVMEnroQA1Pf0Yq5cBQWEsSQe77s1hTWYCeDXrgG7fY4ni8sHQOtfRJUvNT_0xXmDfkX3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtkeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsoh
 hnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:8mjuaHnemVeIVdZhL8OdOEIu_6QJ0wjWX77an0sc8OqKEfNuGg9piA>
 <xmx:8mjuaLBlOcQYYsrb7Q7tqlpG7CYIMJgReNfHB5bIYgxLWwnbr7SlDQ>
 <xmx:8mjuaPe05qNsZy9tLzn0s32G10dBGNPgcMCrSbG5yybIuIkOIGeKDg>
 <xmx:8mjuaOJ0S_9sAYbrKeUl8kE4FDdmkX7pqaYdDXayCtmVb5m7nrl9Xw>
 <xmx:8mjuaLr-UP1eJELQMLSk4JhBo_pidsmFxuhVChwsar2LtoPWh977-9eP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 11:14:57 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: Re: [PATCH v4 0/3] fix build with MinGW 13
Date: Tue, 14 Oct 2025 17:14:55 +0200
Message-ID: <6162643.29KlJPOoH8@thomas>
In-Reply-To: <20251014091528.936405-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20251014091528.936405-1-thomas@monjalon.net>
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

14/10/2025 11:13, Thomas Monjalon:
> After an upgrade to MinGW version 13, some compilation errors appear
> in PCI, mlx5 and bbdev code.
> This series fixes them all.
> 
> v2: improve bbdev patch
> v3: try to fix Windows build of PCI patch
> v4: restore Windows build + fix Coverity warning for bbdev
> 
> Thomas Monjalon (3):
>   bus/pci: fix build with MinGW 13
>   net/mlx5: fix build with MinGW 13
>   bbdev: fix build with MinGW 13

Applied


