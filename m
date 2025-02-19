Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1092C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 15:24:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F7B6411F3;
	Wed, 19 Feb 2025 16:24:42 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id E767540EF0
 for <dev@dpdk.org>; Wed, 19 Feb 2025 16:24:40 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5EAE311400C4;
 Wed, 19 Feb 2025 10:24:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 19 Feb 2025 10:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739978680;
 x=1740065080; bh=12tZrjZ2rd7aCwHye2i05mOHdBRjT9ryWQqv/t9xN8o=; b=
 dhtZukXmqY57lIuR9/MiAiZi58vrmDN/KLfGJDsvs3Au7Ok31AwjGoWaYz1Hf5FQ
 HWvQEWP0hXtLhOTAKpzsqc3DzC3XzCDja+QwSAhZOKzZ5SZdb8jnFnNTTPA9/dEr
 VVVufK63ozkqkF2JHJ7rjSqWhdVP3vhesn/APaQbw++P+rRLZwsqYFOP83qikoN9
 lZlP9NMTGVZq4b/usYGX79DQ3xxU6yE+2jglV2vxu1j3WypEN9TNV9QwOHGFh/Da
 XAe4sVaC9tEwyvkp5naGvWMxC//Ma+wDj2LTISjdbntQUYDSa2nECjur5QJbGSiK
 HGMiSR+O2kykLU66NVDx5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739978680; x=
 1740065080; bh=12tZrjZ2rd7aCwHye2i05mOHdBRjT9ryWQqv/t9xN8o=; b=x
 CX5RSMiont7RsNMd6mHLCsm9VCOSy56co5Wg3DDj+ILQkI8mforhEjXCG2K3YOz/
 4dIfmo1+NcxMqxtknxYkCtRnYckDfF/kUk+0jVRtUrL7+AvOWkmSrOSKKUNIWwjn
 9RVC/LW6aaru0MBn0p+veeXv5vZ6E9rVX3VQ4qbTUWG3KS4hCAzQXVrgJeBMViJh
 u6DpXhZ29DLL5Q19uaeHUWfZWEMrKXr+1owW0Vp+j2QxLE++NdN942ZMfzh0IFn9
 2MPPYF2tPdz1b3YdkyQpfrnQVDJflX80bB4uoYgWyeIjCeSWSD2hzWpXjEBVguSu
 0qqUBf16oHPKOCziaDdIA==
X-ME-Sender: <xms:uPe1Z0MMEOKuodK8lYOPc1OcxGVxZVK_sfhdwFjgyXgvUX3P2CDIDA>
 <xme:uPe1Z6-Gk1vM9fsUBBXUDy4etLLBDXSOEJWpAAtIvT2NPaiPKOOfVOW7Ms5UP4Vve
 XbC8GPZ2ny2OdWe-w>
X-ME-Received: <xmr:uPe1Z7TqhWuXLwZSyQ4QZms2UqJDV-gGde2usYRxXjdD7ftKhEAn2o8hcCNXDxxPatuFPxnsFdtAIsWCbjPILjC5tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeitdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgvrh
 hinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepkhhirhgrnhhkuhhmrghrkhes
 mhgrrhhvvghllhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvh
 gvlhhlrdgtohhmpdhrtghpthhtohephigrnhiihhhirhhunhgpudeifeesudeifedrtgho
 mhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegthhgttghhtg
 ekkeesudeifedrtghomhdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:uPe1Z8sSttOlG4eB8St38rCUuwj6oruHqlrycA2c27yqvbel3w2fyg>
 <xmx:uPe1Z8cm0FJ50NQOdFO4w8s9fVB81HrKM4AucfZ_XcYWJVKejFPAnA>
 <xmx:uPe1Zw3p0Rc0Wydr4_j5AmE22CxAE9ZUxdMnixZuarGjlyYb9oeQGw>
 <xmx:uPe1Zw96W0yTCAltYr9R74INwDmNh5Xzm3tKQdJrbCWHUslotiv4Mg>
 <xmx:uPe1Z6saOAEwaNo13Doc3G4aTHVJAW9Sop-5wiRkyqygcfKhKCPbMtU5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:24:38 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: jerinj@marvell.com, kirankumark@marvell.com, ndabilpuram@marvell.com,
 yanzhirun_163@163.com
Cc: dev@dpdk.org, Huichao Cai <chcchc88@163.com>,
 Robin Jarry <rjarry@redhat.com>
Subject: Re: [PATCH v8] graph: mcore: optimize graph search
Date: Wed, 19 Feb 2025 16:24:37 +0100
Message-ID: <5527926.kQq0lBPeGt@thomas>
In-Reply-To: <20250207013939.1783-1-chcchc88@163.com>
References: <20250206025322.2182-1-chcchc88@163.com>
 <20250207013939.1783-1-chcchc88@163.com>
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

07/02/2025 02:39, Huichao Cai:
> In the function __rte_graph_mcore_dispatch_sched_node_enqueue,
> use a slower loop to search for the graph, modify the search logic
> to record the result of the first search, and use this record for
> subsequent searches to improve search speed.
> 
> Signed-off-by: Huichao Cai <chcchc88@163.com>

Any review please?



