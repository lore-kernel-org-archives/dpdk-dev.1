Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65BC10706D6
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 10:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF29A402A0;
	Wed, 18 Mar 2026 11:16:42 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id EB09F4026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 11:16:40 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5FAB5140016A;
 Wed, 18 Mar 2026 06:16:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 18 Mar 2026 06:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773829000;
 x=1773915400; bh=7MV+jHjq+stwVlTt1lUWtbUewFZR43nzY4nShlRI2bs=; b=
 I+D/B8BE2e/pNqbT+SJPHqMfRroQUariyZ6iCMjXBqCU2xxL8EmlpsHSuMXOuuJZ
 VlgrWsx3AJotnCU1rla6mvsKBlOmml8HGORSw+AsUODIhAjpknO/PyYgojUoSYDU
 52tl6o+etDdjDLyAG3zGft702nmzVkLjMynL9KIBFhJg87w+73po8iyQC56+H1qW
 5D6syVa2M4bQDAlL/AG5EbTcb4FXQtq1+BYJlSv3O868cZ2+TMtaSQEb/KgFylii
 LFFBgH2fHBsGMB9KUcT9mkyYyw913Wk3BXyW0zloxQqGt5W5T6/p0zERqnmkXaga
 UnrGrWHfhKJt1mR8trsayg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773829000; x=
 1773915400; bh=7MV+jHjq+stwVlTt1lUWtbUewFZR43nzY4nShlRI2bs=; b=N
 g6Z+3l92wXTqUEe/C65aL/O7lAly8sfrhtc9Tla7JzpzQcJqSiJlHxgjfIQlXTiR
 OjdgQQvKEnhCfZfYpY4Hhf5V4F5SZ2BasPRK9uPdj71R1qLMohnkN7MsSXFred0B
 ZAgkcDEzc8hAdm/aCXJORMfmxCT0+3mN+1AOV5xFK3HDqZZZa9djf5zisT8DgzQq
 lXeW1WP7o0oXFhlS39qwJ/yC/X/i504dF34kF1jkU3ciKOf2Dzhzftu3TURWRVMR
 UVs1uvnElMN3Qw7vJH+3QUCvme4xkVvhjbZH13Y/JEFeLU+3DgGd6B3frNCeAPtP
 mmdnJiioGPFgRQAo2hVYA==
X-ME-Sender: <xms:h3u6aaugWr6Hur5snWB1xKp051trcQo-M9rZYHXGfzvks-20U9XfeA>
 <xme:h3u6aW4CZpLJUp3ihD6F1QSyhUb4EJAKZ4ZAD3GnvUiifMXMrcYxAn3EEczqVSIsU
 smkngKWD1sJO3mKIxuWLTux2n8YVQvRc6BxAiOQlxFZ85CprynVgA>
X-ME-Received: <xmr:h3u6aTLlg9Ef0VLohMPU-YASJarmce3A7jgxCJ--5IaWhYSlcCB8lTAacJ8oXjT7cSaHbpV3isSx5D2vBEH_nD_n4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdefkeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohep
 figrnhhgrdhjuhhnlhhonhhgudesiihtvgdrtghomhdrtghnpdhrtghpthhtohepuggvvh
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:h3u6ae4F9kNuY1zqTgoqoc8jVlfNcQ58dyGY4kUAtLKN1TnUMgJ-Ig>
 <xmx:h3u6aezV3T5dJ6rHhL90d3OQWxeSLEIJe2Zrgl--lA1rOOjQz0BByQ>
 <xmx:h3u6aaaex_pLBkINiuQc19qByxGoiF-cjjXyPtZW0D7dRd1mH-j91A>
 <xmx:h3u6aYS6YsIdwR8XyoFON8fVBs0kLscSMB1YKEcsz2Bu7GdRa39Mhg>
 <xmx:iHu6aSEQk-L_Ue47MtBVd232w_b-vdpAbL-Mga1RKsh8RMr2f1ML-iPh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 06:16:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: stephen@networkplumber.org, Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [v3,
 5/5] net/zxdh: add support for GENEVE TSO and Rx outer checksum
Date: Wed, 18 Mar 2026 11:16:37 +0100
Message-ID: <5668926.29KlJPOoH8@thomas>
In-Reply-To: <20260318022159.589957-1-wang.junlong1@zte.com.cn>
References: <20260131062208.2445121-6-wang.junlong1@zte.com.cn>
 <20260318022159.589957-1-wang.junlong1@zte.com.cn>
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

18/03/2026 03:21, Junlong Wang:
> Sorry, I have a question.
> Some time ago, I submitted this patch ([v3,5/5] net/zxdh: add support for GENEVE TSO and Rx outer checksum),
> which was marked as accepted. However, when I fetched the latest dpd-next-net code, the for-main branch did not contain it.
> 
> Could you please let me know if I need to resubmit this patch?

It seems that the commit is merged but without its content:
	https://git.dpdk.org/dpdk/commit/?id=2aa7e28b41

It looks like a mistake during a next-net rebase.
Stephen, please would you be able to find the original commit
that you modified in your reflog?
Or I could get it from the mailing list if you didn't change it too much.


