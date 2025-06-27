Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4BFC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 182EB402AE;
	Fri, 27 Jun 2025 18:00:50 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 2CD98400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:00:48 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CE9551400190;
 Fri, 27 Jun 2025 12:00:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 12:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751040047;
 x=1751126447; bh=ZwPSfCyXOkGPKIu4EyxhhWOXcNWnIkff+/2cKql2frw=; b=
 gP4FaeGb6xf6tGQoGq4dDxuT9blBdF0P6Zcue99QoxP+1PGeZA285AQ14hzNBHX/
 /OQ8/npenRy5S4nZvNvM0w4amzgtt3a7af6EoaJWw8si9Uzv4NXnBCwGNfyKAWia
 L+60mSUB82W+vQddbDU/rU8Mysd8BhZsIiJi2wiwc3c/58M0s8WQoTKUlLYo1Ptg
 aBYpqJpFl851biwAf30li0YGsPC1m2jQ5NebxSuTAkvm7t7X6DDRpvIJLHKqQPRh
 22v1Bcu4V/xRWjtsyyWcIrbbSQPTjfA5jqPAkV7XIZoT2UqmyuPJcHH+N8x/RDQg
 435qXAixCeK3zo+J2lB+Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751040047; x=
 1751126447; bh=ZwPSfCyXOkGPKIu4EyxhhWOXcNWnIkff+/2cKql2frw=; b=S
 I0GMY2eh6SrXDv+dliRnaZ4d6sKOZSdaVNZf1xomxns6bGwBh5RS8Dy7Cwhp+fuv
 ijBn6+49i7Q7A/ME6L33NXSVF8wXKMms8hlKg0HWi6TUMhlMuaidWGHb6tVYPsoU
 htxL91smz8slEcC+qMeapGZ63z3XIwajr3Rhmidhz8KzxM+33l9Jcm5mlE0xp4gY
 3UIu3Qyf15PwFOSyP+Ysl3P6ehHaa5y/Ejf4dksWb+mqdSZA6BFU2iaX9RlpIw5Q
 nY9CCofsRvG89aUh16WtPVF5G9eEg2MSdXx3rrkeCmRJMJ5QdsfAb9RGhSEPW85L
 YNglclizQqYS1KVcmfRTg==
X-ME-Sender: <xms:L8BeaLB43WGaEOemkSUJJff5sJ9Mdvw8A35fTsilYlVvy7cDmi7lBA>
 <xme:L8BeaBif8M9bW2D3xjT0m6Jfn8Y3CkS53WR_cIQ6nM_ZMuYRJJAbCNw84erH8PU6d
 sec4OsX8ZEgFsY3tw>
X-ME-Received: <xmr:L8BeaGml4yk55-jTpiXTQLJaK67knpXvGXfkq32Y3CzJBgJI-L_LSOgJ9DV9A7ttc4Yjh5bxmeEKvLEaWegh95GJIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttd
 ejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtd
 egkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhr
 ihhikhhonhgvsehikhhirdhfihdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:L8BeaNwvOSylECCSsvYMj-ihN4lN7RmApwkGVcWLg-OC1ZqWf80zag>
 <xmx:L8BeaATNbFh1r1ehMFd59x7_oS0HY4XPRuNRBy_7y6HWC6v2K4ooFw>
 <xmx:L8BeaAZ_G1_8crS5kNVkav7UXYC1n450S18edkuzG009w7qJ76cyjQ>
 <xmx:L8BeaBQL-vL_it_8fMpdXyLRUpak-XDzwpJCriZgjthHPUr9-ENrKQ>
 <xmx:L8BeaLkC-5Qr89IsEiPq-PRmE5ESek4A0ldHf4xIThsGtbvgPySoSgyj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 12:00:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: priikone@iki.fi
Cc: dev@dpdk.org
Subject: Re: [PATCH] bus/pci: fix automatic interrupt type selection
Date: Fri, 27 Jun 2025 18:00:45 +0200
Message-ID: <7218036.9CP3fYhb5E@thomas>
In-Reply-To: <8f5b22d3bedef793bf489c230b52b145@iki.fi>
References: <8f5b22d3bedef793bf489c230b52b145@iki.fi>
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

20/06/2025 13:47, priikone@iki.fi:
> Check if kernel returns 0 interrupt vectors and try another interrupt
> type in that case.  Failing to check the vector count can select an
> interrupt type that's unusable.
> 
> Signed-off-by: Pekka Riikonen <priikone@iki.fi>

Please could you be explicit about the use case you are trying to fix?


