Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7508CD4F52
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 08:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E4E040677;
	Mon, 18 May 2026 10:49:50 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id C880340679
 for <dev@dpdk.org>; Mon, 18 May 2026 10:49:45 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3EB7F7A0118;
 Mon, 18 May 2026 04:49:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 04:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779094185;
 x=1779180585; bh=n+oYWBv8CdkcoI+amiDIN7i+cFaRODN55ZtHPd0mi3Y=; b=
 IFDrtBQIAC6fgGoJroH6oo+abBE58q+zXoUOCVkjSLq0MWrGPdbkSd0mMR5+BHPg
 NBAPqgCHXtotfIG/8U4Jp7ftQDEa/SqjD1ff+CFo9V3mu2/ZWT0R3hsXaKTqyLBR
 dcB+x8q+5J5qgOWc0fcQBNVq1xFztnWijg7AF5A5l+M4bCSIqQD2nZfxPxxgEdW8
 l3DPWuYp7/OKJLHA8gwePjR5+5B8nsci3H/owkln3QRsXRXNF4Oqq8oITMTVeGBI
 fnj6AcGgjyGaAEx9+/mavTnqSrzymzmWXfhaoQdkrUikSRIFzz5ytM2AkW1fWLYb
 jEeVb5FMrF0Dqc/14r8gDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779094185; x=
 1779180585; bh=n+oYWBv8CdkcoI+amiDIN7i+cFaRODN55ZtHPd0mi3Y=; b=v
 R4fmZAcb+ZAppGQiTXnMFpw+0dICqKtPVd8wqEcCAGIJI771tqPfLeiRwmPcabkq
 ZcbKy/BOKmtbeMW5c8xJMYfjJ3oUVuJ0hAkuGRDWP3Lf8wy/F+PNDG8+QZCI20z3
 pcmiiZY+MX+jS3kbFWEVofiKk1N2PeT1RIGWX7ULeXw1Ywzd+6L9SHBcmPnFaaET
 /yUuj6CkWkppPRdFXgGSUr6/NCmZ1bzW8189sX7TGPA+xRGqCkjHwLLcV3a0jqrF
 HcXPtIP6QKyLeIKMHscsgufb/KoCsR38snTA8Bhbtj2lv79235EWHQ9/cUFOJLT8
 jVZWN+RbZvdn5gfgx/aaA==
X-ME-Sender: <xms:qNIKal_ZzB0C6ZIPbzWIl2mi86b7Sq7ntmT-oQDuvqc6_keRhx1nzQ>
 <xme:qNIKamDUwkI8rq_gclXQiZzWJ3cy9tu0ho1zQRxFyYeHXSK4GsKWSHwliTG6IXeg7
 MVd8UijCsTRukBPQ7zRkrxh3E5yEz16y-orn0GaQ3KukaNw_XEb_w>
X-ME-Received: <xmr:qNIKaly2QY95HRxblOM13WhRpp514aokcY0OXSokd1ksDcpePiAvvQCzg3y39ysE7H7xY5VDTwOGkClrFCMcwUHGRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekgeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:qNIKarTsNMaHDOq3-nZP-ioCMu_WmDtZAbJ96VaifuPkXuEgLxUOQg>
 <xmx:qNIKas92a3M7pkA4cLp8c8lu5ICsvWvVpUEnnCpdqFZLCs-xvt-hMw>
 <xmx:qNIKairZLeLcI32W8PZbUnI8bkbDA8bpOj4vGTBQ2V0mJ2Uab7yiqg>
 <xmx:qNIKapmwHwezy6nkHhtsgG33zP9HjKHL9INRh3ioRfmNtx8YPWIgyA>
 <xmx:qdIKaqE2qiENkU943CAHKzhJ4Qh_BRV_r5N882njaRzNzGB4q3zqw8ns>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 04:49:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] freebsd/contigmem: support mem sizes in MB
Date: Mon, 18 May 2026 10:49:42 +0200
Message-ID: <SITYM07SQOW_cYfEAZru5A@monjalon.net>
In-Reply-To: <20260320170038.338674-1-bruce.richardson@intel.com>
References: <20260320170038.338674-1-bruce.richardson@intel.com>
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

20/03/2026 18:00, Bruce Richardson:
> Rather than having to specify memory sizes for contigmem driver in
> bytes, which leads to very large, awkward numbers if dealing with GB of
> memory, add an alternative buffer_size_MB configuration option to allow
> specifying the memory size in megabytes. The existing "buffer_size"
> option is kept for backward compatibility.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



