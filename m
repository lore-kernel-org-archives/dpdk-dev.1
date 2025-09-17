Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69600CA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 10:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CE284025A;
	Wed, 17 Sep 2025 12:03:31 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 1798040144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 12:03:30 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 8BAFCEC02AB;
 Wed, 17 Sep 2025 06:03:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 17 Sep 2025 06:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758103409;
 x=1758189809; bh=zrfPq3BQHnpKCySJU4tL0N7hnmOwA6tNKodNzlNkfE0=; b=
 DxBPPVOe/2jygBhwWcJThD/l0Ofsjl0ExiEP04+T52NRkmzHAML7+uBuZ4XDKaNP
 N0QLAJt31Iosk8j6FOIT8HA7cim4sW2O8Lv8AGtbfDkzPXlV63rNfp7FHOu95QPL
 t8133ddf81jviAjKmTTmfliAdHuf0rEYnVFIwMhNRIj762W7+vMIaGM1SOl7YzPJ
 6B8SnunlKiRkaXaqHnOpyFtBe//qnoyhysbk+mFtMAtShW9haO6tDHbec1JeQO6b
 5PsOcxR+wcMnBl5RdGDVUKB2LMKuy7l16Y1F4RIF8KMmW+Eg1Tq6BDnu2Ykq9t1k
 YZDLAvFuxDXY5DgwglosKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758103409; x=
 1758189809; bh=zrfPq3BQHnpKCySJU4tL0N7hnmOwA6tNKodNzlNkfE0=; b=A
 9T/9yW5n6TO8s8Sb9psLhjdUpcazDqRclBV5LoEbZemEXXhR7NADwCuziNJ9EMlq
 YsMzdZu0kbVBdmDcrvU1+EmpuhGECvno2kzPKcRDqehOj0T7Y8450IDueQxqJX8a
 +DtXJoNRd7O3Ima4fRAKDyTvBEuDbTD+6BDPpNuQNpGgVxUrxh28IKHkQ4kfjFXd
 gSoY1bohko9IdbhpYzpc4OvwLAeIkVh3hrN+GF4BS6M4g56ITU9MxGKWlIn3Toqp
 M0BhQovD/krBrYAQ5gY+Vp5snYWBhPNUiwGlU4+Qu4grk0ZGj73mL32OL6OsJHXj
 RVEMD39uD+t49xlJXNzsw==
X-ME-Sender: <xms:cYfKaO_OlIviwX4nxOiCJNw9zb3QK6LvGvF-s32W9d4inW-HCpkunQ>
 <xme:cYfKaEHpha5zcHCQpOWxlmuSNDwgNrYzbWnAGH2CLnSxOjQaPLAX_RN_uxwreiwSZ
 1u7_9U5q8fy3pFYcg>
X-ME-Received: <xmr:cYfKaEOdrR9XoNfA3dEJERheQ6FySZcmaTQ_CfWq4Z63Bn__xPtvcWMtCAj5JV_eacehj7O4YFGLlhKqmeHd82sHAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepueffveetffdtuedtfefhffdtudevteffkeegleeflefghfehjeeitedt
 veejjeevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhn
 rdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehgvghtvghlshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtghomhdprh
 gtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtghomhdprhgtphhtthhopegvrghg
 ohhsthhinhhisehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:cYfKaGe6DC9dabhC7JaQkl-p04XJCu5lR0Pkcxwi_vtioTzN375tFA>
 <xmx:cYfKaBsSeSZHUwDjK1e-sfM9fx5ny6zrsaWPbaOwG7-CxqiSwnNgxA>
 <xmx:cYfKaHm0ynfo1nhq9ij1FyOggHym3zc1PAU6OjYww3Y1hhc826RerQ>
 <xmx:cYfKaDzn-3AUpheR9_n6o5eOuwDUkzmosY82bCkXrGyxJkT8zd0qjw>
 <xmx:cYfKaIfld3LtR_wpGCHkHptCJIdpss8-fzj4ut9R6khfoTqOZM0jHy75>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 06:03:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com,
 eagostini <eagostini@nvidia.com>
Subject: Re: [PATCH 7/9] gpu/cuda: extend NVIDIA GPU device ID list
Date: Wed, 17 Sep 2025 12:03:26 +0200
Message-ID: <2884915.PYKUYFuaPT@thomas>
In-Reply-To: <20250915144137.54858-7-getelson@nvidia.com>
References: <20250915144137.54858-1-getelson@nvidia.com>
 <20250915144137.54858-7-getelson@nvidia.com>
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

15/09/2025 16:41, Gregory Etelson:
> From: eagostini <eagostini@nvidia.com>
> 
> Add new NVIDIA GPU IDs taken from public driver list.
> https://github.com/NVIDIA/open-gpu-kernel-modules/blob/e45d91de0224e17a6bf7c971d8f165090b3c07a6/src/nvidia/generated/g_nv_name_released.h

It is not synchronized.
For instance, there are new Blackwell, H20, etc.

I feel we can scratch all these patches and do 1 well synchronized,
and documenting a sync command as code comment.



