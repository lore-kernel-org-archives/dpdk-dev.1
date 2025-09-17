Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC939CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 08:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DBFB4025A;
	Wed, 17 Sep 2025 10:45:56 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 1922E40144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 10:45:55 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 79DFBEC0188;
 Wed, 17 Sep 2025 04:45:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 17 Sep 2025 04:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758098754;
 x=1758185154; bh=vP8y6tzjB9Mi/tDxP63pcN9KQm/k649gFy35vtWgBaQ=; b=
 fdhFxMNp324eKr65Po2SAoDQUAlt85t+ZBPj05SpGkCjEDpdAk6BBqf1KO1u0oN2
 /xiH6MAoA7Mg9/6F8OjRH7jm8vusVrI2AxLRPFrXjnjgt0tzDwLnIDMj2SchIGVO
 oNs4vuvUjv1McgtYyRfGSjw01e1tOEov4YqbsfPQjZtUd2PwDNFROrCHSsCV9rPU
 bYCb/LE6RWiY6QfKDIhz6y5uR5j7u6Wj6twM6pi+we4GR6hT4r+4Je1SbVo4ngAz
 0FJCX3/qoIrsOJ6vcyO9L5FeW/xfppRhj1WvyC9QTET4K/yMGDT0zJ1pIsiNvd6f
 jaoaBiEYzQQHKts+131A6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758098754; x=
 1758185154; bh=vP8y6tzjB9Mi/tDxP63pcN9KQm/k649gFy35vtWgBaQ=; b=f
 wk/WZx/m9zCKxlKL2NaTsFSLMl11b9uRgT/zj+uR9koKVDy7f3ht0ureAi+NN8WA
 9/dzBdwEXOHA3rFWq3+tYn5EPmhhClsLRKw45syBOI+X45tMziKLwsbCsJyFSLI9
 QDPP4yT8lXfdNM7uUrjP4ct1FimsiN5dhql0yOOJqlCoDa/bgLLx3DNkbwytFN3M
 S1UzFYVyZnbojTNgp1g3NK8bePutOtLijewFmlTYEsz0YIZOe6XGkAFe26dRMHnl
 umI8+SJeWO3Unx1fVLiiPmuz0LYiZw8aZQX3Kt/7OLScKUbXrIf4fSu8+nmptiKU
 H0b5o3w9ZMej1dEWn1uhg==
X-ME-Sender: <xms:QnXKaC3MpKYMrBLWM-t7lUYQ8SfVim1KsTXssviAdAyNpmLo5Upi8g>
 <xme:QnXKaKVmFlKT2aqE_yHgly8jQhhXf-8IWEJlnBnJtz0Z6o4P_s55Kb8Kbb0uqg9wP
 TbwokIv0BWGRA6yUg>
X-ME-Received: <xmr:QnXKaMmRcaJPocgQHwJQXyT_Se70CsI-VAGG19GfJ8cqskdLvHVGwr7A_Ebo-FsMzUj77NEctXncmmkoQjw7yu4rgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfedtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepvddpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:QnXKaMCe6hoWm-GJ_8XFYY67z2iARufpRXBqvjd0Az6vFIYRF1DDyA>
 <xmx:QnXKaMdgYEEm-wsmirL6T3Aa-mg-gK6hY3HvCIoA3Hiar3m5kgsgGQ>
 <xmx:QnXKaHJ8NiDUhUPd11THy5CEup8adahm8dRYEeqsYw4hpv8t6k_aCw>
 <xmx:QnXKaPdTsd0EIoGi_Nxxn6-ki6omViNRAbDxx8Kn3JeYwS5Ij-0cfQ>
 <xmx:QnXKaC3hTrlib3YQnHVDCXPhNMWh21Oy-T9YpvuACBRRMMNg0YgJaRsQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 04:45:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Shani Peretz <shperetz@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/2] Add jump flow support and queue menegment with new
 snippets
Date: Wed, 17 Sep 2025 10:45:51 +0200
Message-ID: <3252380.ElGaqSPkdT@thomas>
In-Reply-To: <20250825072346.25548-1-shperetz@nvidia.com>
References: <20250811143704.146795-2-shperetz@nvidia.com>
 <20250825072346.25548-1-shperetz@nvidia.com>
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

25/08/2025 09:23, Shani Peretz:
> v3:
> add comma in the meson.build file to fix build error
> 
> v2:
> sent mistakely as RFC - remove RFC tag, no functional changes
> 
> v1:
> This patch series adds port affinity matching for bonded ports and
> refactors queue management to support the new port affinity snippets.
> This refactoring also enables other snippets that require access to
> the queue number to utilize it more easily.
> 
> It also introduces support for jumping to specific flow groups,
> with three new snippets demonstrating this feature.
> 
> Shani Peretz (2):
>   examples/flow_filtering: add match port affinity snippet
>   examples/flow_filtering: add jump flow

Removed few doubled blanked lines,
and reworded title like this:
	examples/flow_filtering: add snippets using jump
	examples/flow_filtering: add port affinity snippet

Applied, thanks.


