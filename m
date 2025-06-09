Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901D8C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 22:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5D77402D4;
	Tue, 10 Jun 2025 00:42:40 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id E4D8D402CD
 for <dev@dpdk.org>; Tue, 10 Jun 2025 00:42:38 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 583631380494;
 Mon,  9 Jun 2025 18:42:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 09 Jun 2025 18:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749508958;
 x=1749595358; bh=n0y+EPAO+CO8O+1hsBUHiyLE52M2D3MCz3FJGBnD9bM=; b=
 d7UQ6R5pCjsYMZnJP6BvEnmQgrkSNXbNc956zAAqhb9AsrAo4ciqOXhORFkRNxtS
 vup/D1XDwhmHgR6xIYSe9gkwshIaXY2YRnE1X9Z2ZBzsKQ99talorhM3WOPtNHe1
 SDVTkTJvjRgjw0ZzRTcPJEOvc3z+Q9eOtEYRmb3dKQiDdItiyWfCUwcSLEpOP8+q
 poFKkUuqqnqz41RUyiLl7fQ4f0gmcoPjx8WEbPuixqTSXPnPe1RcR0HBWrjIOQs7
 cOW/LQSzDas9iQPFVJa4PAKVMrUMbj3JSw3WxVD/tCmoFKXRk3WALJjVIKZK5Equ
 AgG7QtWfIjf+VdmuSLGhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749508958; x=
 1749595358; bh=n0y+EPAO+CO8O+1hsBUHiyLE52M2D3MCz3FJGBnD9bM=; b=R
 /y01hi9d/j5EV2I/H90GbeJFYrc2UKEQ2xC4vVQHZnjs4nVS9e/t/EMNfGR/5M5v
 ZhK9sNJIsFThoVjzW0pw2dnmVBxtwt+g3CHd7uQ1h1yE2RK8hk70oIJ9egbp55uD
 ArRZQus9EKzxNLifVUFYen9XYAXst93O/3AUNoSHq2t14/T/Iwgh0fkGK4mu2dXR
 W29Ay/VbDzrXiKXDX1kqdoUaTxhiG0GO+MVWrUytr0y5yxxpOuDixaGhST7PgPFw
 Lr2apFz+TV06Mprmhb2NYQYMt8DQ9wQxRkKjXqwM6QtD8en126J1AHQDI+ZBq9p0
 6Tu6c1me4hMIoFbYWRBdg==
X-ME-Sender: <xms:XWNHaBxisL7s_niQreqqoswMR5wQM8lgARdFMIYgC_lsae0ZeXlyvA>
 <xme:XWNHaBQKBat23xKrrzMjdy6vYdPGwvOJcqvsMCK9XL1G-KeuTzfgE69Wlw05EDLoW
 VALebjF84SfMo5PBA>
X-ME-Received: <xmr:XWNHaLWaA_LF2lZiFfq8w5TBPGAM5ftYXAA3od4AllIxT5fEF1QwriEVxKT2EAB3k7DpJRVa5TVCEFBThy0Jjqu2sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelleduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeek
 ueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvph
 hhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrgh
X-ME-Proxy: <xmx:XWNHaDjpRiJVrczWjXaz0W7SwcO1SxsM-TNaOR2J85NmcO4qJM5uTw>
 <xmx:XWNHaDBhnRn4XY6UqGuX5di1CxxOHr1kwioMl54cQ4bjGU46lJhnfg>
 <xmx:XWNHaMIdegbzUGv4QZzmqoOOqebDOigYjntexY7Lz6KkohCB0aMSbw>
 <xmx:XWNHaCCJMJZc3VbLCAElb8RikU5ld4GX3jPPVULUl3vY_LbL7jXpag>
 <xmx:XmNHaEmCXaLudhR8s0zaSQC4TNwVy6sqZBgiQFR5A3_LpHAZbf0fkVnd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 18:42:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] eal: force compilation of RTE_ASSERT expression
Date: Tue, 10 Jun 2025 00:42:35 +0200
Message-ID: <5336192.N7aMVyhfb1@thomas>
In-Reply-To: <20250204194759.723484-1-stephen@networkplumber.org>
References: <20250204165516.168106-1-stephen@networkplumber.org>
 <20250204194759.723484-1-stephen@networkplumber.org>
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

04/02/2025 20:46, Stephen Hemminger:
> Even if RTE_ENABLE_ASSERT is not enabled, the expression used should
> still be checked for compiler warnings. Use sizeof()
> and ternary operator in same manner as the assert() macro to
> cause the expression to be evaluated but not generate code.
> 
> This was motivated by detection of problems in a driver submission
> that was not detected until compiled with non default flags.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



