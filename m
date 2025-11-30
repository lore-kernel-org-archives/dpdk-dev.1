Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE2DCFD376
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Nov 2025 15:44:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8AED40275;
	Sun, 30 Nov 2025 16:44:53 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 1D5194026F
 for <dev@dpdk.org>; Sun, 30 Nov 2025 16:44:47 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 896C0EC0090;
 Sun, 30 Nov 2025 10:44:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Sun, 30 Nov 2025 10:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764517486;
 x=1764603886; bh=r5wPin0naG3GvPtb1mmS7lgLIXaZMXUJ9Y0+J/a58p8=; b=
 lUNk79M7fJVjGx6qdTbSrng3xaMGioG/a46v+GF/8qLdUGsoo1aowPaJYDbzjW3w
 V1aCLn/gbFtlu65BpELXPAgVSA3gtsQSCttLS3d2218SPgnLXuqDBv3PcMMowrZc
 dNv5ZIHMdPf/e5IeilpyY+epmNX2Nev44OmrgrYu1v7vHH/4uXhZfPOy2Me9GPCy
 RGn7pCdvEUOy+TXi8JDyn2XYxuzN5rQGeK5i0cEsz5EhOUuoRSG1o40qUOzZk4Eq
 7N44iKr7JMDkW8xi2+eR5r7j+sNXY4zRQmwfcu2qLsDUhLPZCtRkpO1bHbbFbGbS
 3q1cmEo6aE5bxIx6eQDP9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764517486; x=
 1764603886; bh=r5wPin0naG3GvPtb1mmS7lgLIXaZMXUJ9Y0+J/a58p8=; b=B
 ANVwJFbQ3vwvWvS6wXFcs9LyGzNit10xBmsNy1Zt644vt6Jai/1poXjrl3urdXj5
 PD2W84MpkZZnypZ8u+xefx8XVaz8JHCWNaC5TKyMDaG0vDTtXUkoN0AaXAGMntqI
 R5kXWO9F85/VfERPKdpZMtbNSKZjS57E44AXUq8S4BSea8VV7ESyjfvirPvFsXCV
 EhJWjZIXwGKZh9cd4wtFb3AfXLE26hNjxXKIw0Wa6fIwhhVHSg/CWzL7UCeObDcj
 vh8u5tYqIpTilndPbj4+/A8vxDsjuT0WhUHChyZAb6yEITiPBeQ3sktUunK/Pl0a
 DiQX4fDu+KFHgJ/aRUG3Q==
X-ME-Sender: <xms:bmYsaaelX_opx8lCedWa2rHrSrDpqNaid5TzLUixJATsKKaVOLQ-dA>
 <xme:bmYsaQh_LNOdiZHWG3MaZtmw_inQgUPhvr_F8ubtUDEFz6z3MjOwYUmPhpkEISY9U
 AjL6YcZGNyPJDZWwa_y1nts0ua6hLSQhz803qg88_fSARphXGPgQg>
X-ME-Received: <xmr:bmYsaeRPcv7viuqmm4zxw6VtIRFIGDXoYnOTTJk7bV5TKWXq53AENNSN4n7WAlbcqUFrzsn1CmwoRVBj3W7jdZi7wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheehvddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgrthholhihrdgsuhhrrghkohhvse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:bmYsaZx7NkE5wSbQ2j5NYNwSNtRapWirlYF8eDk3T3q1Ygr7xZ3WeA>
 <xmx:bmYsaZe_WSfaVusRpQjZ0ZDh5KSlAyRFrO0W3_Skl6DfoXtP9KKOXA>
 <xmx:bmYsaVKGZhwcODx16TPBM81jGKrevEhzuEAglw1EFNNmpJsrHdjJKw>
 <xmx:bmYsaaFasw37_7krWdhkAEzXLiIfOAc6d2hxmVPfM1gjOkfDOyU5og>
 <xmx:bmYsaSkr51SqHFYThTP4-cb99jW7_WiQOJSd1RXk4t5kFM0lgm2dJ1UG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 10:44:45 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 1/2] doc: add devargs documentation
Date: Sun, 30 Nov 2025 16:44:44 +0100
Message-ID: <11158378.CDJkKcVGEf@thomas>
In-Reply-To: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
References: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
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

14/11/2025 13:13, Anatoly Burakov:
> Currently, the devargs syntax documentation is missing from the
> programmer's guide, and is only documented implicitly through the devargs
> API headers. Add a detailed description of the two supported devargs
> syntaxes.

Thank you for writing this. It is really important.

> +* **Bus identifier and arguments**: Which bus handles the device (e.g., ``pci``, ``vdev``) and bus-level parameters
> +* **Class identifier and arguments**: Device class (e.g., ``eth``, ``crypto``) and class-level parameters
> +* **Driver identifier and arguments**: The specific driver and its driver-specific parameters
> +
> +DPDK supports two devargs syntaxes:
> +
> +1. **Simplified syntax** - For common case targeting a specific device.
> +2. **Multi-layer syntax** - For device filtering by bus, class, or driver.

I would prefer we see the last one as a generic syntax.
Others are shortcuts.

> +
> +
> +Devargs Syntax
> +--------------
> +
> +Device-centric syntax
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +In most cases, devargs can be used with simplified format that targets specific devices:
> +
> +.. code-block:: none
> +
> +   [bus:]device_identifier[,arg1=val1,arg2=val2,...]
[...]
> +Driver-centric Syntax
> +~~~~~~~~~~~~~~~~~~~~~

If you give a PCI address or a vdev name, it targets a device.

> +
> +For advanced use cases that need to pass arguments to bus and/or class layers, or when matching multiple devices is required, DPDK supports a multi-layer syntax with three slash-separated segments:
> +
> +.. code-block:: none
> +
> +   bus=<busname>,<bus_args>/class=<classname>,<class_args>/driver=<drvname>,<driver_args>

I think we should present this syntax first, with supported bus and class args.
Then we can present shortcuts equivalents with the old syntax.

[...]
> +Summary
> +-------
> +
> +Device arguments provide a flexible and standardized way to specify and configure devices in DPDK:
> +
> +* **Unified syntax**: Works across different bus types
> +* **Runtime and initialization**: Can be used both at EAL init and for hotplug
> +* **Driver configuration**: Supports arbitrary driver-specific parameters
> +* **Complex specifications**: Multi-layer syntax allows device filtering and configuration at bus, class, and driver levels

I'm not sur a summary is a good idea in such a documentation.
General statements are better viewed as intro.

You did a good job, but I think we should move things around to avoid confusion.
Please let's work on it together.
Thank you


