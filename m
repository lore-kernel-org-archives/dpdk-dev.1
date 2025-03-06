Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB64C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:15:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AC37406B6;
	Thu,  6 Mar 2025 17:15:34 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 893A04069F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 17:15:32 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id EF13F1382821;
 Thu,  6 Mar 2025 11:15:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 06 Mar 2025 11:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741277731;
 x=1741364131; bh=Usleu61T21LHNkERn7nFHsVJ85tLrp3Odqu47nZu/7c=; b=
 O5ER4zd/9JO+t3IOMtDs1BbnP/KDFFlnjh1QUnGLpixHcLQoy01JOR4tgEzQi000
 Vgs2nRhugSwHFwPc42AsxMVQWuV+cCrY+75liEFmRq9aesMjxXSy8hWj9AH1umJS
 qzY8Zw+Em+uUkCLdxoOufY/XdLXEzmYGrmP8XrTL6fK4Lgh3mWnu5BzjoGtvw35O
 myGM2hzOEql1+EgitNV+zjHIHCTRL4tzCFQAk6pBnaaZkb/tc3xx4zM8EmdYsnor
 ZmM404aojsNGOoQrAPCX9bFCVHpLyOCy1D6BCPVSCKOp8opdTFFtrY23vlD1a1Rp
 9YFyvQ/n3Mh7Lr//VMeTOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741277731; x=
 1741364131; bh=Usleu61T21LHNkERn7nFHsVJ85tLrp3Odqu47nZu/7c=; b=R
 LQh37LLht3iTG/u2bX+zwDQkSM6DdMUx+29rZf130qz0AleiTANesaXOxr2HfeXo
 89h4UuxH1UyXMYN3jgD1lw8sdAhadYrJXvkDWHMi/6jvJVSuOnXbAX6Djw/EG2YQ
 NysGF1NIbuo6/bG4fhRTsabwHxrjuNFwCUcU824my8xLuw4L7OizatlkEZwx0LBH
 6SV/YccYKUUKwwMtjWn+l2rz6cr9jq3Bz0Evw84VtMhBHF2Irg1p5ctrrjtglSd8
 Nlxe7cKDnVJ9CJa6yecseM24P6nT+CWnBnZNwQmXlGhyQyaO9NnAZ0ZV2tyeqpP+
 Lbb0WAUxbIdeFfXccDESg==
X-ME-Sender: <xms:I8rJZ_2hwzAWaGSny0yIm-RCtgFqTzXJF0jGskhpJpxaFkoKiqpZBQ>
 <xme:I8rJZ-FiB4qTygYmW0MsptpECpUWV_saPQwpf40RBDG2aU6jW-ig7vBYyOsHpYhqj
 Iq52KZDGh3l602ksg>
X-ME-Received: <xmr:I8rJZ_6Xx6SZ1w0u3FqBewZ2PiAzTPv3Wgwu5JccscTyyniwtPOvKeCfeHZQTIhXmnLN4O6wcHC5tszVpufvgRx28Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 evufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhj
 rghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhoh
 hmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepphgshhgrghgrvhgrthhulhgrsehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthht
 ohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:I8rJZ01XlSIq1En7ZBwbjrBdS79FmTe_yNEDgp-upg_kUKgLCMAf8w>
 <xmx:I8rJZyEeRWMSHktvEIupar3I5e6Mn3XJcoIZWmsC78Je2w7QdFS7Dg>
 <xmx:I8rJZ18W0kL-BfDbMHqhYsGYx5z6ww3FuKqw03iOg71RHXRlrBRYGQ>
 <xmx:I8rJZ_lxvqdlBY1MktYAIui6-ZaQPsdVy9LbO6EZaWqPP4R6ivS8wA>
 <xmx:I8rJZ-BIXTtGh8o7SGJ0DGJTWelzo1iRvBW054KHpxdkC7ATpKyp3TQU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 11:15:30 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: jerinj@marvell.com, dev@dpdk.org
Subject: Re: [PATCH] devtools: fix regex of cnxk skip files
Date: Thu, 06 Mar 2025 17:15:29 +0100
Message-ID: <5438880.RUnXabflUD@thomas>
In-Reply-To: <20250306152516.2594-1-pbhagavatula@marvell.com>
References: <20250306152516.2594-1-pbhagavatula@marvell.com>
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

06/03/2025 16:25, pbhagavatula@marvell.com:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> SKIP_FILES should include the path of the file.
> Update the regex to match the path.

Can you please also check this one:
	-v SKIP_FILES='osdep.h$'
Is it really working without the full path?


