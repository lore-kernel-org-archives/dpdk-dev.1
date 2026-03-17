Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76778F3380D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70B60402D1;
	Tue, 17 Mar 2026 09:02:52 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id C211E40270
 for <dev@dpdk.org>; Tue, 17 Mar 2026 09:02:50 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 830C0EC0086;
 Tue, 17 Mar 2026 04:02:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 17 Mar 2026 04:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773734569;
 x=1773820969; bh=fX+r0ozzmaqC2r4+qmKEJNRORjYPhedC+tkAhmldNdo=; b=
 H0cjhhlt4cRlv2kKLyj3w/c8PpDpjnTRc3KDlpmAbUJxJarC1fo0gHonoQWl5hTe
 /0KcLA1VLGgulSDeL1lNajj4sx5VvbsWH/ut4W61rejhTuJwIWT1wZXKehmZQnZN
 IGHU4dTLAaf0kUmSJGQ5pDp1Su0NU1/5vHj0FhW7uKjnu47HnZ9FpRrdd1e96oCb
 df2x3aQkmNhHNXdjVOONPAs17csbVZlnmlOEsIW9cy2I4ytqQ45VnrBnh0LMoVJe
 G8m5Hae29Z3rW61T8PKXRpEIBLp7lsWKINnnA5iHczci6X1N0V53GYV2l9cL3241
 enMNpgXhvyz7rczPQlLGow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773734569; x=
 1773820969; bh=fX+r0ozzmaqC2r4+qmKEJNRORjYPhedC+tkAhmldNdo=; b=G
 g1B7/x4tkcePJ47hcbUPT4QIwLnRJSgg4pN27OCS8blFnZKch0L0zZbPfGJap08i
 I+jg9Mva7J/7I69GG6yEk/diR4t82ejsxbTLTVJiTF9X6TN/dxHgyysqo/yXZiDU
 uHjuO0DFNnXlSffxySNcGXIknHa9eR+KmMSoDguwfdEU9OYm3P8SKAdx8+uU8uca
 EVRQk7bnEl2w4J0dyr8PcNpHzMMoVyBL3OYzyGb82HSoWLhaaWiHtyl3g63k3nGB
 4af840JcPk9OOgxIhqv9YtvhOCJQ5OAbqCRhjo7vhbR+LQ6c8dDWqO30iGmbSW75
 sQq1/Qu3KCNA/QUniRwNg==
X-ME-Sender: <xms:qQq5aZwIFSKnD1dUsfWdZzZiqBDBKHSp7PYniOSXahbsuJ_zdXOeqA>
 <xme:qQq5aZZTEqv6YRVIYqA-x6OPZLBog7aretSWOsttqUG1BVtQUkuOHGFnGjYj9pDSb
 2qXdsPDSzWW08JNSG4xgccCqDZSUpeoMe8m2NcvbGO7HUKIHTF1qA>
X-ME-Received: <xmr:qQq5abRkAd5K-DIdEDvq1_pwmuK3DqHy9Jg8g9CIFfScdNx4DZPo9RI0ir04c5FCjMF3mbpzGhrjP2o8xZRq9gzWfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehkihhshhhorhgvrdhprggumhgrnhgrsghhrgessghrohgruggtohhmrdgtohhmpd
 hrtghpthhtoheprghjihhtrdhkhhgrphgrrhguvgessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:qQq5aTxZMBiKQW-u2MEBuWgD0o_LRmxbNts0MFc79zYL-X5N_Gus0A>
 <xmx:qQq5aV30-3Xv3s7PqkuhQDLNgcfcIDd80kOnCBgdp7D1BU5qBKKT5A>
 <xmx:qQq5aZ6nrl6W7wR1Ly5NJo7pVUiBYJ-W9-Ic2ru8wghd4agIRjHV-g>
 <xmx:qQq5aQWI3nGVxkYBDaPx0RmPhVxwdvfRPHThhCJy95_PyEo3dRGzuA>
 <xmx:qQq5adVQ_F7kSfyqvAYhEhq0-obJ_34LaFxQSFVFk0stgoCU2WsXYUCs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 04:02:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH 2/2] net/bnxt: fix shadow variable warnings
Date: Tue, 17 Mar 2026 09:02:45 +0100
Message-ID: <15698507.tv2OnDr8pf@thomas>
In-Reply-To: <20260312002123.867357-3-stephen@networkplumber.org>
References: <20260312002123.867357-1-stephen@networkplumber.org>
 <20260312002123.867357-3-stephen@networkplumber.org>
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

12/03/2026 01:20, Stephen Hemminger:
> Fix things flagged as warnings about shadowed variables.
> If the variable was harmless overlap then just drop the shadowed
> version. For min values case use RTE_MIN3() and RTE_MIN4().
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/bnxt/bnxt.h        | 6 +++---
>  drivers/net/bnxt/bnxt_ethdev.c | 3 +--
>  drivers/net/bnxt/bnxt_rxq.c    | 6 ++----
>  drivers/net/bnxt/bnxt_txr.c    | 3 ---
>  4 files changed, 6 insertions(+), 12 deletions(-)

Why not removing cflags += no_shadow_cflag ?


