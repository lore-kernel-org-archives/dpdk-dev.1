Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5596CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:05:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0132D40613;
	Wed, 24 Sep 2025 18:05:06 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 77E9E402EB
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:05:04 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B5B497A00B6;
 Wed, 24 Sep 2025 12:05:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 12:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758729903;
 x=1758816303; bh=55adYGpUiHtvDzoh3XDGqVbBpltN40Bc6sPgxbSNyj4=; b=
 IaMs7fWB/6Egc3sBxlcQ3vx+0tAYA4ddDf+wxZ7dzkrM1m5FDPVNlGwvm0jX/sV4
 +bZ+ndxj5uLfuVLti2uje7RrMXlF/htWDyKeA5k8SKaL+ebJTOQlF+4nO4pg5gtc
 FgpbYKYDkEBTAN3zl2y3GdBwk/AlAALYe834RamBgZAEkoKJLKXy4zBo1CIK09ks
 MC2h9AsXjzBsJT+ZI4oFc8jJzgasHCsXzMkWd98hP9tgVqkwVJ3LDqb6fI3viyTb
 PDYM22QLayVbPdWolmO38tGau/ur5m+lb7Bge4h7Z0BzkjnQDLRVwLr6YEHjkwXs
 rrinU19t9KiiMSXe9WXOyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758729903; x=
 1758816303; bh=55adYGpUiHtvDzoh3XDGqVbBpltN40Bc6sPgxbSNyj4=; b=a
 T9IPzvBjGm9KJpHd+bue0FuJy1J8yLsr1VLdJ605MO5s/3HIXwC/tloIC+HuFger
 ykbVC//Jdb+ERrFvWFxG6H56KZXX+jHOikzI69ooRSGFHXvsAKCnx64KsX3XhdIz
 CBEHHoDcVj+b1AAMBeSKGvp/8N7yDyRqheyzyEU8RMYLs1Dtf1+2CP0TSnwWMvHN
 L/MPwxpc+7n4gL8tNPkTZRRWnr96BRWER3Gar8DeU1llbfQ68tdRvRwwcF0YAXsl
 fXFGy2VkxbWTOdMsQJr6VTMN54Vy6PK/5j/IcBsmGUIy1vQOCXk9G41BVHjNm1Oo
 IXuyLzTtUk30PRxDuEkRA==
X-ME-Sender: <xms:rxbUaGSAtruT8trZX-l44BwvJYj9y9iHvcpQRx5g_jPitfi_9wbAtw>
 <xme:rxbUaIFv6bkWnms9MEGPcarJ0XAEUkaoe4FDEsTLjB0CJTy1yHST1IBzjwgJZhkPf
 QifCV_RJfiaVaZV1PdvDUOVadkZDGV7HmdhaE6cRZlSX6QQux8JBQ>
X-ME-Received: <xmr:rxbUaGlpfZo3YrNfE_-cp3UPXwaMQvxIogfU06_A-EYdptGILB573Bw3VDiOWNiltTRPcdBt5F7yTyUg2IaOFR6A3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedtgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:rxbUaD3XeYcAuc6y5aTcBxyBQOadg8I2pkOeXevZKRvMiMg2EsJfPQ>
 <xmx:rxbUaCRpxqz3aiWpboHBieHrZWTZ8lwZmrrnB-RAmUJI_d7pHXNTIw>
 <xmx:rxbUaFtl-x8RfWX5O84jDvmHImvtcDaqSBj5yp1GzQMK7CMKr3dAPw>
 <xmx:rxbUaHZnxL4zwkKtF2glsEKGkg33MGzW7KPxJMlPM_f3rd7uIo9ypA>
 <xmx:rxbUaI6jL7n3ktCt47Jh23nG7kbGYsXmkGoXYORtQ6L4KWCQyYyzJ6Oj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 12:05:02 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] hash: fix build error due to missing include
Date: Wed, 24 Sep 2025 18:05:00 +0200
Message-ID: <6284832.6fTUFtlzNn@thomas>
In-Reply-To: <20250924154821.927083-1-bruce.richardson@intel.com>
References: <20250924154821.927083-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

24/09/2025 17:48, Bruce Richardson:
> The file "rte_thash.c" uses the rte_cpu_get_flag_enabled() API but does
> not include "rte_cpuflags.h". Add the include to fix build issues this
> causes:
>=20
> ../lib/hash/rte_thash.c: In function =E2=80=98rte_thash_gfni_supported=E2=
=80=99:
> ../lib/hash/rte_thash.c:79:13: error: implicit declaration of function
> =E2=80=98rte_cpu_get_flag_enabled=E2=80=99 [-Wimplicit-function-declarati=
on]
>    79 |         if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_GFNI) &&
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Fixes: d8f0f514428e ("eal/x86: remove useless include from spinlock heade=
r")
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

How is that possible that I don't see this error in my compilations?


