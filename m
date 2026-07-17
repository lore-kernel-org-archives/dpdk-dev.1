Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0378C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 12:49:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABF19402D4;
	Fri, 17 Jul 2026 14:49:25 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 55AD2402D4
 for <dev@dpdk.org>; Fri, 17 Jul 2026 14:49:24 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CBBC11400076;
 Fri, 17 Jul 2026 08:49:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 17 Jul 2026 08:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784292563;
 x=1784378963; bh=kKAPU4S223qfqa2jyC7SGYo8efZOGMsXj9gzdXsQNH0=; b=
 AdUmykWWhlevxinMiyM7sSl5w1muosKgOvVOC8yqbemxoyCAZ2NBFeTeehaGYF31
 FcVZ1sPodnZHWLq6K7R4q8KUY1JGUcrtSZNFaWL4RiwTtCD4Li9Zl6i3xd8Duz4/
 vFs9RERbzQHnwMvHm8vVAVYJLgJqD5sF+yGoLJZE9brGPo6m3Ha8GEb8730Sk1wW
 5ou30ljAukJEh/LCrZThVTRqJpZDKCcC+h4ipwy1BtkBD6XBYjsscdEJ13sG2+mV
 wv6yTks4jXX2cXrXVfWj3BWbydnSP9AXXmiy/lUTBqrPREvpTxRV5V2wmVh/j7m+
 G1Q8Hc32JJsdYRU3+6pJ4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784292563; x=
 1784378963; bh=kKAPU4S223qfqa2jyC7SGYo8efZOGMsXj9gzdXsQNH0=; b=T
 I5W7ITi/Z3HggAG41aBpau+Q9kDrbyFZh1f46v4r4rox3sBqKB45swv6b7M4nTdf
 QMTZ9jEC4/Y5HqrpBbx0IVTI8UgftW+2qnDMvympbVj3E9FAEzT3lDBzsNxhyrgP
 aOC1P1cbfDX/6urT56Ik7qEWVOB3a929ZzcG8q6wMF4Tm/nfpt87wMTna19s2rWy
 ncnjD7OvGs/oFmcIo6hpx2dycE+rOlKHaA8rd745CCMUCKdPZN+BiJ1uGO+RIbxs
 JCmF5qrHPzcV1ssU9Ck1ksUWOn2d/fZr+QJWFarZp+p1UMUjvYWslIClHIxZODKn
 JPqgV0MrJ1gNEgV+fAvJw==
X-ME-Sender: <xms:0yRaaiKCfWW0zajsLvYQHuiWUXgyAZCEZ7tWry-d10PBqTfBa4MmSg>
 <xme:0yRaaqR1RHcPNDSAfQW5_YwmfJt89vsndJzgkrEqSoQp2IBETLefYEasRajErQUbd
 e_AnnVF235Ja6hx4amJYFm066LSxHZL4VH2e4n08WJbnfeM85px>
X-ME-Received: <xmr:0yRaaqp42mJPdBVGlnXGgjhJCLK36N2Ne1nDtnTEeACaFoRNemGZoBJZVwsW-hR4mVQrfWJZtxWQGduwhw>
X-ME-Proxy-Cause: dmFkZTEFSS+AIk3P/SLxXa0eAIKJhSar3npsFFil75D1xaANjjY3O6CbvQCsdQmfXq6HQK
 c6W98TlgXzinWL/VEc2VV/AbZm+s+tBpS4MD8x527iuABhUQr9Ll8DshcFHrH7qFgMj+sQ
 N64paUKbV5rDuKVBqdY062bn4cv1QpyE55vph78aFT5G26mIoIehU4Qk+S0+JcIcRPn/hk
 upHKe0rgEyao/QcRpAR3kcjHBYpQx8I/Nj6WLIZbA7UI+vEFuBx1zlEetKd0G/Yt3fuW9B
 VCrS7D30Ac4xImyQAQ/yGuOoar1Tk6F1y00MsYXapTKcE3LuLyTYrdFLkoUUAmiJaBDbWf
 eN1pkaPe7Jmpk1ilZSMtJZd0OGMHeWQr0p036uaJ5FMnqS2tWk8jjyBZZTGXtQnQ0NsXj0
 gfbscH6ZLToB0P+vXiamJozX8jpS26zvEVUOVR7IHeCZBjILn3/AqopuMG0qn46kMSXtfP
 HX5Iyu5zgg1sNIjHiMbS/9+3KWijpIAYqj++HfdZ0RWg73iJcdtlDsv2EUa47CXE7gapu0
 WwukXic8sOPmW73h5H5VZ/PpHt8qdbcQjVApx7pUPWEq/eJRwPfiZRq2s/Eq4FE1ajTo61
 MWOJeW8PzLrzS9CbKMzPnS/YxBYCYDT7auoaIXg5C398eV3/GqRhxLoKL1FQ
X-ME-Proxy: <xmx:0yRaavrcVGuzEfgZME22LAnGI4MIkqkESZ_et_l5630zhAGGi6vV7Q>
 <xmx:0yRaakPADOJadRkLxPV-FXkGj_jskCI_yf0oJZyx2deikTXURnGwAA>
 <xmx:0yRaaowcDuVG5B7NKb7PrvtEWztj1n_sI3C9RbSsjSpyJL7Tbpm2cQ>
 <xmx:0yRaalsl-ZrCSXy57oHmzbGtgpedcmQaSG8eAJO988NKFRXXrw3bfA>
 <xmx:0yRaaihRENwvTgPbbTs00euRTnwqkmMPkLTTTE7pkaIDCLyu2ZK2uO7j>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 08:49:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 6/8] doc: add missing globs to doxy-api.conf.in
Date: Fri, 17 Jul 2026 14:49:20 +0200
Message-ID: <R96dKgyaRl69srX90yAl5Q@monjalon.net>
In-Reply-To: <3146b71600564d1fb36690091a1c5d6f@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <89E6AkFFQ-mRyIB3PXdwvg@monjalon.net>
 <3146b71600564d1fb36690091a1c5d6f@huawei.com>
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

17/07/2026 10:18, Marat Khalili:
> From: Thomas Monjalon <thomas@monjalon.net>
> > 07/07/2026 10:50, Marat Khalili:
> > > Public headers starting from `cmdline` (except for `cmdline.h` itself)
> > > and `bpf_def.h` were not previously included in the documentation build.
> > 
> > Why bpf_def.h is not prefixed with "rte_" ?
> 
> I don't know historical reasons, but I would add this "rte_" prefix. As far as I understand 26.11 is the next opportunity to do it, right?

Absolutely


