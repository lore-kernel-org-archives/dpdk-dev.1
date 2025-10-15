Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A32CCD192
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 14:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D668F402D3;
	Wed, 15 Oct 2025 16:46:53 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id 8F11D40273;
 Wed, 15 Oct 2025 16:46:52 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 9ED481D0013F;
 Wed, 15 Oct 2025 10:46:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 15 Oct 2025 10:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760539611;
 x=1760626011; bh=0TxhM+Jlb01ewSLxn53FsQ2/oTA4qQeXmTnD4d9/ibc=; b=
 KqexcvZB9fmAKqGVydNfK41BnYqGoPzulfmgdZS7EOgEro6BvNIq/bpMjGSIZ6qW
 +0kigYVaOki3yO+Etj0C3tWeS3r9GFOMbFPJruhKlijvXGyEXT2v2fcpFtWLlbky
 UjDy7QiobBeyz7DwkjnBVJVAVRcA3RHfF9Qz6MlwHME11EKdqmLzfYBvOru0bfoI
 mufhWkptcxNeQ1z+n0/xTqQuXYZg/GnPRBScLBFvT00EFzk3mxSZOxqjJOvallha
 jhRToSeUoEhIIKz8EJSqYxQRHLcu8eWCQ0HiV/7MEK+9Rg6OMFx+xGPMEeZ2BOI2
 ig+CENlJecUrR3ZvsS4cUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760539611; x=
 1760626011; bh=0TxhM+Jlb01ewSLxn53FsQ2/oTA4qQeXmTnD4d9/ibc=; b=t
 m+mlhi91Oq5WSZBG8wbDFQSGPL7qcpOxc4M4bM4N5uyH51b25E4zBKleQC6z4m49
 3AAAdevNS6uGxTDvDQTfFZFG4TAl0uHVRxhvs5Gc84o+LcoWmVBHly+e39g2Exuw
 LhHdX0Wjv/eDnJe6xRItnPBJxBM0twXMhqm8vvVkn6pnPFmrRbShpaujnPV1yaTv
 5GYCGBJGyaIV9cWUS+Jq06H5LyYm6bK6ylS4CtKeVb+inMG6ObqPqWf6WWxY0I6+
 UbR6meq9KbZ8MarjH94JbLI5++xHFsAsYhQ5EEgxpPwuVopwQjLPX9RZeXlY78bA
 GQhxoZuUr8qBxPrnDlOrg==
X-ME-Sender: <xms:2rPvaKQxEWdCD1E5vJhqrWBcUR30yUVJZEhFYrTD4bDxyqC98yNvAA>
 <xme:2rPvaFzyHSlMWGE4zKlAAshBBT1Z62Ou5nZDgijc91Lin99wpZsMrxHRSySz0rdqY
 yunbZTnxy7e6HMcJDIaau8Hmx0Clods2yI2AAqD0JYdP5bjljY1>
X-ME-Received: <xmr:2rPvaCpCDzIqFqBWVEm0eP8ZNzhcFjSyEHxdwlovUC_NPG4h8zdI9QKj7GHQ2Z8fms9v1DNzZeNVrsPhaFlw2r-Z9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefieelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduuddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhivhgrphhrrghsrggurdhtuhhmmh
 grlhgrsegrmhgurdgtohhmpdhrtghpthhtohepuggrvhhiugdrhhhunhhtsehinhhtvghl
 rdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpth
 htoheprhgrughurdhnihgtohhlrghusehinhhtvghlrdgtohhmpdhrtghpthhtohepghgr
 khhhihhlsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheptghrihhsthhirghnrdguuh
 hmihhtrhgvshgtuhesihhnthgvlhdrtghomhdprhgtphhtthhopehfvghrrhhuhhdrhihi
 ghhithesrghmugdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhi
 gvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:2rPvaI34GjP50xQXyLrFIM1x-C8cb7lWuAf8R-v-TlpqIZnv8khrfQ>
 <xmx:2rPvaCxEQe_0BN8QpbLF6s-tfk1y7Yk8JgzTNqErVJyeLhrFhRQVVg>
 <xmx:2rPvaMgUEuVYCULgPFgz8_9n_lUWWIryGh4osjEwGSff5AzLV9wUGA>
 <xmx:2rPvaNrMDFdunhk8cYK8gyA29ygY-W0xnlByD37Cz80bQSpqNEiW-Q>
 <xmx:27PvaNgMjAdjdx7iTOfrquf1KGG7CftI5RuTne7CV-j-SyWyuhxtps_Z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 10:46:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: david.hunt@intel.com, jerinj@marvell.com, radu.nicolau@intel.com,
 gakhil@marvell.com, cristian.dumitrescu@intel.com, ferruh.yigit@amd.com,
 konstantin.ananyev@huawei.com, dev@dpdk.org, stable@dpdk.org,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2] eal/x86: enable timeout in AMD power monitor
Date: Wed, 15 Oct 2025 16:46:47 +0200
Message-ID: <3976740.KgjxqYA5nG@thomas>
In-Reply-To: <39c5c720-4c30-435b-ac28-96b2cd10afb3@intel.com>
References: <20251013031619.2988915-1-sivaprasad.tummala@amd.com>
 <20251013055158.3037400-1-sivaprasad.tummala@amd.com>
 <39c5c720-4c30-435b-ac28-96b2cd10afb3@intel.com>
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

14/10/2025 10:56, Burakov, Anatoly:
> On 10/13/2025 7:51 AM, Sivaprasad Tummala wrote:
> > Previously, the AMD power monitor implementation did not enable the
> > timeout, causing the lcore to remain in a wait state until an external
> > monitoring event occurred or an interrupt was received.
> > 
> > This patch enables the timeout-based exit condition, allowing
> > the lcore to automatically wake up after the specified period.
> > The maximum supported timeout value is 2^32 - 1.
> > 
> > Fixes: c7ed1ce04704 ("eal/x86: add power intrinsics for AMD")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied, thanks.



