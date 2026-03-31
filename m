Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E31109B472
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 14:05:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D258402D3;
	Tue, 31 Mar 2026 16:05:57 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 35CC0402C3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 16:05:56 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 46E8A7A0174;
 Tue, 31 Mar 2026 10:05:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 31 Mar 2026 10:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774965955;
 x=1775052355; bh=Y//4msawCnM2rEr/Tgr8UJ2+qvat5ett7vn7NId6/TM=; b=
 tFdY1F5CitV4+8XLFn4xsjxsNf+yHOGTKJ4GeDbkznp0v73dCwK7mA/84Um2zEvm
 bB5Ua2rlx/eHLnMZ0ACTxEaChT1DDpKPwgGSK5FULh6gsEjNcBzUkm+0jTy42H0f
 AGr9XNlvfI1PbpwtiWFJ7ZzVCF+uLbwXlBU/kmHWKT6bfxgrrKvO2ohkjupaWYrx
 Q5QLV8PjbgWcS2wPa5qwNlyup0p/SQS+/EYqRTEasiPGR6RBp7ieM2LmjN6gHHYz
 AhRjxdjtsETZgCFoHRcp4VW8nJto5VgCI2XJdGNJvdYBAIR3SzDaF+p12tj86mf8
 5Lo++paA8ClCOnjqD594zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774965955; x=
 1775052355; bh=Y//4msawCnM2rEr/Tgr8UJ2+qvat5ett7vn7NId6/TM=; b=s
 zKEEuam1rqzNyzETCsWthZJm9/fw4yvbMpf9aU4iSwdfHRhJ1VnsWWfS0iie3DVb
 +4afDeEEQpt90407mULhp/4HUPZQFStXezv7aUnMmyRQPL1ngda2XC5exIIUgpji
 PP/Ii3Yy1i3GsBE8EkkvYK3JJBip40tACxgrcBjaI/d8YBNBJMe4ncCgei9yrt+k
 6QkAilydxkZE7XMBy0ewWdVnA/UwSDE+TM8I4jlR958YWsEUKOsjzmd+oZKhL+mo
 zV2z4B1X/xFnFy7HTR84ifabvLgCDqCKsZ4Mo11gW3zV3VkU/8ealYwa4p3O6FPg
 Xr0OIUTtAg6q0Yyjuy+aw==
X-ME-Sender: <xms:wtTLaZS0iZptHLUqhlPpRzznK_egwlsEDCnkPSJt0EK1pJWRH6JmsA>
 <xme:wtTLafHH-RajPn858eQBifuwxSgwoRpUl1IuSpjulNlwPZfHGesZJ_idVVh3vMvAj
 pE-Z4VHMAj93Hrg8Pv5X85tqAA_SM5J3x3Kec3cnreb_QTASHa5FA>
X-ME-Received: <xmr:wtTLaRmxJ5FWkzNM1OGXq4IrJoG564qrEPKXEr_fvETs4Z6800e4l14Inr7Y8ZbENTavVQaEHs0e8O3JtBgd5siBkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeflecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnth
 gvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:wtTLaS19okDUMdbhhMJvMt0cFYgN4BQAdnO3KPGLnP9F9i72X-0RdQ>
 <xmx:wtTLaVSwaiHPp3_9Og-uXPwjb0InU7CGPgKiT0trCXrlZznanPEaSA>
 <xmx:wtTLacvUIqJpZp3CGi42eEpIlc0q0Rn_1QgYveS58FkoWM0ZEChxzA>
 <xmx:wtTLaSZ67XJkSyvZLH3bWr6renD69zYZL9HSJtyBOd2aGEY6Jvsw1A>
 <xmx:w9TLaT79V7VqrZZuIXSUN7LeMXGGSpstv_Cg6GdklAnykkkyslazJKPK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 10:05:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/2] Deprecation notices for VFIO
Date: Tue, 31 Mar 2026 16:05:52 +0200
Message-ID: <5118586.31r3eYUQgx@thomas>
In-Reply-To: <cover.1772114309.git.anatoly.burakov@intel.com>
References: <cover.1763548356.git.anatoly.burakov@intel.com>
 <cover.1772114309.git.anatoly.burakov@intel.com>
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

26/02/2026 14:59, Anatoly Burakov:
> There's ongoing work to rework VFIO in DPDK [1]. These deprecation
> notices originally were part of that patchset, but were split off
> to easy review and acceptance.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>
Acked-by: Thomas Monjalon <thomas@monjalon.net>

Applied, thanks.


