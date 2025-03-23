Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE70C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 12:33:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1D544064A;
	Sun, 23 Mar 2025 13:33:57 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 2513140277
 for <dev@dpdk.org>; Sun, 23 Mar 2025 13:33:56 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 464A91140098;
 Sun, 23 Mar 2025 08:33:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Sun, 23 Mar 2025 08:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742733235;
 x=1742819635; bh=2Chh1iS9oEJDwZICz20yitL3Fr32iadNUVzcXHRt1D4=; b=
 MpK3zDskHbiWSZJxmpsM3xuTCnXQcehJ3xunU4GQ6BbwVMN9CHz7Jg9gC1XTMv9W
 4r95xb+6wX3Z11BxufPM0T4zwTpZzGMtTtS7kgsKGBMRJ8gtwgW+to9S3D+uBnaH
 YAENJzdfU4K+/JuwDqHs/Fbvu+NyXAF3hJSD901AtSD2UOXhS5JibR2cvqVquhsf
 hvPyygrl2k1+ufF8PuvNn5tbiQp4eSSYnHaeie8vo+OAd2edlJYJvxuE6LQz04QF
 AX8kpU9rqNn7fySmtsjkY0qsP5zjP/7vrdCJwuufie7l6S+fq66AqfPOVY0zxaKm
 HETY5uSdCSHtq8ueo0MQZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742733235; x=
 1742819635; bh=2Chh1iS9oEJDwZICz20yitL3Fr32iadNUVzcXHRt1D4=; b=F
 cHUT6rw2gQQwGWtUuEhprBhEnJkDBIRYU+YXhvouDSHWtD9Ibym6oNH3X/rFtc8F
 TF0w/4jQ0EJP4VXmfiVDNgfRfw62BYkwZ+0k55ks9tsodq7RR39SlvwPI93ubZNV
 kdsvz/eGjheKQX7Ok1VYhk4g/ZSlWzZls5o7Uh0rPrr1exCdrrxyxVTkZXnYPlTD
 3dG36VUSoskoeoSzbq/fTChPYAYdIp3UcCfNKYvRy6DJqo0KmquTmF+cTL7lsRoU
 sQnzC0qL/KuBgWRCSBeWP/V2udFhkxh4zCPsGpSVW8q9bWTrcqzVwCECasHStovo
 FY5MblgAPXgo5BVl98P1g==
X-ME-Sender: <xms:sv_fZ7MZ2KCAB3CMof6aqcBZtfE0nxOPl-vUNNFomZ7xGv2vvJMSiQ>
 <xme:sv_fZ1_fE9aM8tUc84y0AMdaQxpBbbpv_HwpMRY8YuaynCPSYla3yR7sZpG4V5kw5
 0igiUH670lxMlsGxA>
X-ME-Received: <xmr:sv_fZ6TNGUZ4YYGW_Z_t2ZI0NDGzF3LfVjwo_X48G9377QNxygei13eXIk4LC057l8AsjCbRhem1-rUhHw-l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeikeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 evufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhj
 rghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhoh
 hmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohephhgrihhlihhngidrgihusehinhhtvghlrdgtohhmpd
 hrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhi
 tghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhgrjhgvshhhrdhtrd
 hpuhhtthgrshifrghmhiesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhhnhdrmhgt
 nhgrmhgrrhgrsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:sv_fZ_tS0RfV6NccMwxRCInhLXeG_7GM1Uy8xUsrixNru2QiLXOt8g>
 <xmx:sv_fZzebVZrNzHZs_fbRYS5PCIwZFAYZl8Za5GqV-S_C-TLv3S-b9w>
 <xmx:sv_fZ70cgelpzRYSgtCYln0ulOgippOOqL0EqDwo6JAV47enJ7_OOg>
 <xmx:sv_fZ_-bpEI137UPqaeoFpTHi4IgFvSrgfS7-Eqh4QkXGnciHUxKMg>
 <xmx:s__fZ0FD_KrDoq0dmeNbRE3BjcyK66hZZ4eRyJHbBt8gY3Y6vGhv9zyb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 08:33:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: hailinx <hailinx.xu@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, rajesh.t.puttaswamy@intel.com,
 john.mcnamara@intel.com
Subject: Re: [PATCH v1] net/i40e: updated latest recommended matching list
Date: Sun, 23 Mar 2025 13:33:48 +0100
Message-ID: <11878275.CDJkKcVGEf@thomas>
In-Reply-To: <20250321003651.988509-1-hailinx.xu@intel.com>
References: <20250321003651.988509-1-hailinx.xu@intel.com>
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

21/03/2025 01:36, hailinx:
> Signed-off-by: hailinx <hailinx.xu@intel.com>

Applied, thanks.



