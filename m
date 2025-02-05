Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A02AC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 15:45:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E347440289;
	Wed,  5 Feb 2025 16:45:06 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id E782340270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 16:45:05 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 617741140120;
 Wed,  5 Feb 2025 10:45:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 10:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1738770305;
 x=1738856705; bh=qVk+poPMjLNsBluKBpr8mzNUYzLbhWeKhInYsZiUPzs=; b=
 VzXepAAWGTeDNFoVshs1w/oU03wwTVLluHQ2c6GbMdvQQ3oeuuOtT4D/yJn5XwPq
 e2+TTj/OcV1/KFOxDS4xCJ8ActmvXmt5WMBtm2UHDkBkf4vBHBATtGnW0H/KRZms
 F3RAG3o07Vv49OoEDH06gIkQLCe+6PaUGtvRDZ0DsO5iG38MUL6EcuJmQ0Jv74r1
 VngY/hcMKRlHFKZoOOGaCNrm4J5QJUwiV2b49IZFO1B0DqCpm1qZD8UfdjRGidgH
 TURfpMXCD6MzAAXTNePEUiSg5VWmfqmkb1NXxsb+/OhoS4o49TZMEkOColwFt85/
 0yFvQb2bwsmRXESZnc1/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738770305; x=
 1738856705; bh=qVk+poPMjLNsBluKBpr8mzNUYzLbhWeKhInYsZiUPzs=; b=Y
 RDsBq1ByFyol0C6gKgWosrdKMTt101wGBLGiy2MKDP2XT3pOMiHGWzqUXD5XWfl+
 iPYX9fK/7kxr6F/HLHyPIub6pj3NwG3Kt9TH/Xst1nQ3NTwwvWohV0AtO0rmUcyg
 sKtsBZkpLkJPxTLO3YdUKL0hvZNw0B4toOYxLlAoNC+m5P35BlMezVBwwyI2oXyH
 frRWOvGlSTYOj8w70OEcuKjuWXsa+XU0jAkd/7KjpQePf7Cuq6cu4g9OYof5uykA
 e2fIcZl/0x/4oPi0HtHgdHSUYU2urPj9/DAZx1vXVZjvLnBOH+7puEaRAXm0B6CE
 nPrA/zHK62IT3137Bq5ZQ==
X-ME-Sender: <xms:gIejZ_YUJu7kIqU4HMd074bZt-5jAV45okn-MmsLykzaryxvmSCg-A>
 <xme:gIejZ-YMyos6ABkj0EXnHBzxq2QMJSdswd-1VO8Ga2ds50PS3vLpmE_U0TVNorIEi
 P_NNXApXz7ksfvz-A>
X-ME-Received: <xmr:gIejZx96BlzOI7OrQ4QXkou4mgw2n99k7-1zN9vK0_KQHcyo73FYJxgOrd-pTGrLrrwmvaiHtMFvNdamwyTKjREmcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
 fufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgr
 lhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrh
 hnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepfigrnhhrhieshihunhhsihhlihgtohhnrdgtohhmpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepfhgvrhhruhhhrdih
 ihhgihhtsegrmhgurdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkh
 hplhhumhgsvghrrdhorhhgpdhrtghpthhtohepqhhirghnrheshihunhhsihhlihgtohhn
 rdgtohhmpdhrtghpthhtohepnhgrnhgrseihuhhnshhilhhitghonhdrtghomhdprhgtph
 htthhopeiihhgrnhhggiigseihuhhnshhilhhitghonhdrtghomhdprhgtphhtthhopeig
 uhgufieshihunhhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepjhgrtghkhieshihunh
 hsihhlihgtohhnrdgtohhm
X-ME-Proxy: <xmx:gYejZ1pF8bvRGNysdGLrlXUcBx-cELDjZ-zEp7oEqdsFU6mz2uIemA>
 <xmx:gYejZ6onRQGC9kmSgCU43yTme2wAJMSPVIs5vlevpn9_thamhaEmqA>
 <xmx:gYejZ7Q7sykCgLzA2h0id_WNdg5HfKoE38z1VRJ1x2fPJKaM1kijBg>
 <xmx:gYejZyq1gV1rMKqurqLtTSuxw_Rfd7OOQhJTbe0sqczjXch6qSiNeg>
 <xmx:gYejZ3j4TCYn2SZ-0ncgs3NgpJyJk7TB8nVfz1OlfWfbAH8yG72UWacZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 10:45:03 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Renyong Wan <wanry@yunsilicon.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, stephen@networkplumber.org,
 qianr@yunsilicon.com, nana@yunsilicon.com, zhangxx@yunsilicon.com,
 xudw@yunsilicon.com, jacky@yunsilicon.com, weihg@yunsilicon.com
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Date: Wed, 05 Feb 2025 16:45:02 +0100
Message-ID: <3203749.TQGk6oTFT5@thomas>
In-Reply-To: <cd6b3b85-1356-4b59-a36a-c5ddb6ab4f64@yunsilicon.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <2040007.zToM8qfIzz@thomas>
 <cd6b3b85-1356-4b59-a36a-c5ddb6ab4f64@yunsilicon.com>
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

05/02/2025 16:37, Renyong Wan:
> On 2025/2/5 22:43, Thomas Monjalon wrote:
> > 05/02/2025 15:37, Renyong Wan:
> >> On 2025/2/5 19:44, Thomas Monjalon wrote:
> >>> 28/01/2025 15:46, Renyong Wan:
> >>>> XSC PMD is designed to support both VFIO and private kernel drivers.
> >>> What's the benefit of private kernel drivers?
> >>> Why are they private?
> >> Hello Thomas,
> >>
> >> Thanks for your review.
> >>
> >> It can support the bifurcation model without unbinding the kernel
> >> driver, by utilizing our private kernel driver in conjunction with
> >> rdma-core. Currently, our kernel driver is not open-source, so it is
> >> considered a private kernel driver. This patch series only supports the
> >> VFIO driver. Our kernel driver is currently in the process of being
> >> open-sourced on kernel.org, and once it is available there, we also plan
> >> to submit the code that supports our kernel driver to DPDK.
> > OK that's interesting, thank you.
> >
> > I think it would be the first DPDK driver to support both VFIO or bifurcated model.
> > How will we choose which one to use? With devargs?
> >
> >
> That's how we designed it.
> We designed a low-level device operations framework named xsc_dev_ops to 
> support both VFIO drivers and kernel drivers. Each xsc_dev_ops is 
> registered before the main function runs. During the PCI device probe 
> phase, the XSC PMD selects the corresponding xsc_dev_ops based on 
> rte_pci_device->driver, therefore, there is no need for devargs.

I don't understand.
If both VFIO and the kernel driver are loaded,
we'll scan the device twice?
Will it be probed 2 times?


