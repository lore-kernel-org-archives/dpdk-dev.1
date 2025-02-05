Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A20DC02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 15:47:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5067A402DA;
	Wed,  5 Feb 2025 16:47:25 +0100 (CET)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 5E72E40289
 for <dev@dpdk.org>; Wed,  5 Feb 2025 16:47:24 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id C1E0013801BC;
 Wed,  5 Feb 2025 10:47:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Wed, 05 Feb 2025 10:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738770443;
 x=1738856843; bh=k5jpelpTVfLngtTZHDTOscZqxwULFE7Bu2cN07IFsio=; b=
 fR8XBU/2U3zhDME8Q6Q0vqbIydAjXJMaukZnRFEV4zqhJLzAVTD9wS9Rqeg9ZrJw
 HAgxx1aoMo+73kH1PbOTBMYgkG6UHCL3Zjgkyn22R8ZLN/CCbkiClCnCY7uW0+1+
 aHv49BkMhkfocO5zDDQbKchNcqkZei+Fyfz5eclATb3U8DVMPDHxRLPsteQYEYkX
 bQsDu7Q07qfrl0TDHtEASnxZSgS+YOEVt6ebpRRJ8KS5JgGjiCTC9hHvvqS0k4gE
 v8PR1MLjIKbdksIpO0qtENSvx8iNPLGfIwm4KGKgARxEmgOuVvk5eNlJEGP4CWaF
 COoJcl8l53O2RMKLhT3bOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738770443; x=
 1738856843; bh=k5jpelpTVfLngtTZHDTOscZqxwULFE7Bu2cN07IFsio=; b=X
 CGTxdayaJFYOtaozpVmqKdwVs4oE7xax7W05SO/2tm08sn40Tzcq/RqtRWF6PSKU
 q6klRkTplpefPqGSHqJVKUxB4Sy12s4zaObMKlxuELJPeq6Bx0DJ7rb6vWkM7LSe
 YVzL6Iz2VlkUOB06R/jXarh9G7NF6pV3uo9J0yR45R8pEUYFtIuFOpP6ykYbUqq6
 +zlf06Rmm2XXHwRNFMOJE8qOVZU9hSWt3osIvUUkKxEQlyik4jBV5Ry8dCpsDq3V
 ZAQ8ZWXiEHSJNr4nlrAQS2vBBkD8e6I4JTMfEYzkfxJtSl4NFNyaZhGmVE78N0mk
 UlYqWayxDsdkYUAm2kDlw==
X-ME-Sender: <xms:C4ijZxyb7M6SmIfXVlkX54ixh7bAtUkv24GiFCtjDYg9SDj3ZGzVEQ>
 <xme:C4ijZxRP3zvgNZmX7xT6zX8H3sd3i4fslatFzgmKGW96R6WkhX70QKIdsk5sxNmQo
 8SIRILKzRb5biqvQw>
X-ME-Received: <xmr:C4ijZ7X78FQA1Ui6aIKpTEv1jClPjGqd1XwkrNLyFd8Z-F1rBI4_GQwKocjJzmzLE_LQeQ4ONmFI9POlPXYt4INW2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrh
 hutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeifrghn
 rhihseihuhhnshhilhhitghonhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdroh
 hrghdprhgtphhtthhopehfvghrrhhuhhdrhihighhithesrghmugdrtghomhdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtth
 hopehqihgrnhhrseihuhhnshhilhhitghonhdrtghomhdprhgtphhtthhopehnrghnrges
 hihunhhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepiihhrghnghiggieshihunhhsih
 hlihgtohhnrdgtohhmpdhrtghpthhtohepgihuugifseihuhhnshhilhhitghonhdrtgho
 mh
X-ME-Proxy: <xmx:C4ijZzg2f_JretpjVR7_c6dal7c2OCrOhu05MLtvIYEO2vjD0yZmTA>
 <xmx:C4ijZzAqxFJRF_YS36xN5gU-s-R6Fn4uApdj-3JpzQNKqqPdP-1VIA>
 <xmx:C4ijZ8Kyk4CVI4I5PqMvjTJj3mXt2I6KRo1CN-GsEP6vqAtnKN0DBA>
 <xmx:C4ijZyD68uq2dvdCGbDn3WXjylJEN0A9VUzBqE3hivayQcQv-WJ6Uw>
 <xmx:C4ijZwL6Y8v_AIncL8HTsvePgEMU3AP-qzFgBZoHlbRT2EAaLAkYpsMj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 10:47:21 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Renyong Wan <wanry@yunsilicon.com>, dev@dpdk.org, ferruh.yigit@amd.com,
 stephen@networkplumber.org, qianr@yunsilicon.com, nana@yunsilicon.com,
 zhangxx@yunsilicon.com, xudw@yunsilicon.com, jacky@yunsilicon.com,
 weihg@yunsilicon.com
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Date: Wed, 05 Feb 2025 16:47:20 +0100
Message-ID: <2301554.KTMopqUuYO@thomas>
In-Reply-To: <Z6N8vYkKc01RQu2p@bricha3-mobl1.ger.corp.intel.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <2040007.zToM8qfIzz@thomas>
 <Z6N8vYkKc01RQu2p@bricha3-mobl1.ger.corp.intel.com>
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

05/02/2025 15:59, Bruce Richardson:
> On Wed, Feb 05, 2025 at 03:43:30PM +0100, Thomas Monjalon wrote:
> > 05/02/2025 15:37, Renyong Wan:
> > > On 2025/2/5 19:44, Thomas Monjalon wrote:
> > > > 28/01/2025 15:46, Renyong Wan:
> > > >> XSC PMD is designed to support both VFIO and private kernel drivers.
> > > > What's the benefit of private kernel drivers?  Why are they private?
> > > 
> > > Hello Thomas,
> > > 
> > > Thanks for your review.
> > > 
> > > It can support the bifurcation model without unbinding the kernel
> > > driver, by utilizing our private kernel driver in conjunction with
> > > rdma-core. Currently, our kernel driver is not open-source, so it is
> > > considered a private kernel driver. This patch series only supports the
> > > VFIO driver. Our kernel driver is currently in the process of being
> > > open-sourced on kernel.org, and once it is available there, we also
> > > plan to submit the code that supports our kernel driver to DPDK.
> > 
> > OK that's interesting, thank you.
> > 
> > I think it would be the first DPDK driver to support both VFIO or
> > bifurcated model.
> > 
> 
> Not quite the first, but possibly the first net driver? :-). The idxd
> dmadev driver supports both. It can be used either with VFIO or the kernel
> idxd driver.

It announces only VFIO:
RTE_PMD_REGISTER_KMOD_DEP(IDXD_PMD_DMADEV_NAME_PCI, "vfio-pci");

How does it work?



