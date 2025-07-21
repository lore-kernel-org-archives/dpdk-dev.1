Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F694C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 14:03:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA9D340667;
	Mon, 21 Jul 2025 16:03:07 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 6131840662
 for <dev@dpdk.org>; Mon, 21 Jul 2025 16:03:06 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DB24F1400067;
 Mon, 21 Jul 2025 10:03:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 10:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753106585;
 x=1753192985; bh=jBMABqdY145F2wq+Bafeti9QZZc+YeQ9DagoP9GRPYU=; b=
 RsGEzvhq2JHdNzuEAlJnMUFqnT5ovxfLjDs4dDjWiv8j6yYUgVv/gbpcpCAvHGBY
 zmFAzgctKu/fscsoq1YpotGx2mUUKjaujYZyYQOo7ed3UAzy6H5JqCKmF58/SRxc
 v+DuHoMK/voN1jPOO3YAMiNF3fFQ6NGawAnXeydiNXyAKizzLynf8tAm3X7wOVR1
 mcMYcMp5LQIt8BkKWy5aL8TnTiRmf9Ps6nsOekGrn4FlRqd9F6Xi2E425wLKsZkR
 u9QF61FqUymU1Xwo8BbxIDToT9bzzCPRrvTUmzIQSwuYPBcOTK24gj2px+ZmM3QN
 u2yrPhhqkRFCd16oUcTh6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753106585; x=
 1753192985; bh=jBMABqdY145F2wq+Bafeti9QZZc+YeQ9DagoP9GRPYU=; b=A
 3fnLDe75cCjZWPUTCesqdr5atiedH9OdqPEpU9t2lFzd6gf6ytHSf5KO7V4I7gm5
 PxK7pF5L66GaueZdwL3EDLObsvsZQygYAi3DOM2JCXhsoyaQcEToLfU1x4A5Q8un
 f37Dt6pLNBGekD0BIIjLO/z9AXQyev5p3SHBki0FHRHUzYYRKbDPlklyJAKzbpJf
 yXx8fwT13BEfv3TBDN8WXUINLO9N3c+MiMCUjVcXWKdJ5uZ2RhjVGCRiCydgkhAy
 z0BlSp/vJihfSvSo3pqawxhA9QlKS2jAjx5p+Usbw2R+fjzyjkCL/Unes5POcG8q
 o6W3Na7VJhBkEbrdVtTeQ==
X-ME-Sender: <xms:mUh-aEMH87lt1Qwu8Tokw9HNZdWjjYPvycwlIEyIYC7IlUfcevB6YA>
 <xme:mUh-aEn8WCx5b-kDgyWBx1hX1t-RHL_W9xc1iGMK_fV-kBU5FJfEo04NqPEhAPVg2
 bGEK8WwHYyeSbpgxw>
X-ME-Received: <xmr:mUh-aLT4qmfBU8aY5a-ysQ5hKZ447NiilYWMwZ9yYDExFdFyk9-fx34zk7Wr-wgqwu45Jm7OtSOxoJ2EOpxjsKkaOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:mUh-aAClq1HzOTwLYjgyYP4JyEFU05EMcVzgdQmCrRZgdjkifRBt9g>
 <xmx:mUh-aKTEHQGu3hZgFTBxR8eKj_Xkn6ENJd5rDDyZ9Tg6KlU3MLlSNw>
 <xmx:mUh-aGqN6SHHoy8ouUWxyjsOsjAO92wqNNtYEzWWHsBfrpyj5cB_pw>
 <xmx:mUh-aEzzx5mZnCh8vF2FF_VFxUPOj6YY1-rSvbuKU_yPWQSdePcDew>
 <xmx:mUh-aLhtxuUrUJhI6TYepZXM_gO_bTdJHdi7_hW7KCNRO4ZEx904U-Uy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 10:03:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com
Subject: Re: [PATCH] buildtools/check-git-log: print expected driver prefix
Date: Mon, 21 Jul 2025 16:03:03 +0200
Message-ID: <1877314.8hzESeGDPO@thomas>
In-Reply-To: <20250124172434.1422621-1-bruce.richardson@intel.com>
References: <20250124172434.1422621-1-bruce.richardson@intel.com>
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

24/01/2025 18:24, Bruce Richardson:
> When outputting an error for an invalid log prefix, don't just tell the
> user that the prefix is wrong - also tell them what the expected prefix
> should be.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied (with fixed prefix :), thanks.


