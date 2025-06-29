Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975CEC7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 20:44:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C1184025D;
	Sun, 29 Jun 2025 22:44:57 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id E30BB40151
 for <dev@dpdk.org>; Sun, 29 Jun 2025 22:44:55 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3F0F37A0087;
 Sun, 29 Jun 2025 16:44:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 29 Jun 2025 16:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751229895;
 x=1751316295; bh=0MlU4W59gIA7GHGmbLlziM9RogEQKDlx6Bo2WtfOsdU=; b=
 jH4hU3eHeqvIyKNJnDy4qLYPYP+67V4ghavD4u/xYpAXH4U/60fSE3uHQkHyIRkq
 +RY/WebC4aF65detnRKD+9WpQsljP7Smts+bypjND+QG8pOpJgu3iLXT+efAAJyv
 jy2o5yG/JztlCqDFtNlwfaYzRc0si05hbBQwMrG3jhD/L/3wu7tN/lcu8QP6nBxY
 D5QgIsAdohBiRTPskawStHCF3diRfZziZIEPE8OTrlRYJ92fr1wk+qfBCAcw1ZfV
 8a2gQlrDoqoCKUICmXW9xoZ2gOdjdXWfmtjx/dcRlyK/wJ5bZTqw2B0UXRV37W5A
 EqLoaQEyIYQ1r/lXP2OlLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751229895; x=
 1751316295; bh=0MlU4W59gIA7GHGmbLlziM9RogEQKDlx6Bo2WtfOsdU=; b=N
 wl1itHhSklP8IVmeddTJ6VWXUMA+GC1RmQ3Q3PSyJQY+7r/h7kcKh0wdN949IbGK
 TAfRjnF4eh7E3mjRirOBozYX8AAYaQDUvvPJJ7dvi0doKIhJ91NLTxdOgk1YoXvq
 2bN1UQesXvq//RxXHB7hvzLGtJnJfDbPcunty01O9jkayUUajEypPMFVzFSAvCQC
 XzlytkRlINVnJ/JiM2aOORDfO659WeQVVIQgwL+0bErIv1q5YZw3+lePvD5Wm1mQ
 eUmhseiDZTVwRwje6egpqDPIcdj07upSxpW/jrs4hMlR8188RGsIYKMnxa0D84Fi
 OWhLlnMe3eBpLswTnjbiA==
X-ME-Sender: <xms:xqVhaM8V88Y7WVvw8k_RjLCw7xGpEFOsiMaRdq192X683XSrYrbYHw>
 <xme:xqVhaEtf4v_EhUc8X50vUdgiFTEnTlSlCjiutFaRh5s_7dyPWGcUicUwn3DwfX7By
 FiKMEidEUpv1ybWfA>
X-ME-Received: <xmr:xqVhaCBNhC-tqX82EQmdlmqf9WFIwQOGVFcPBcijSPKts2D3X6iS6NcIX_sDlzViCy2KVJ3Ak5imoUy7SqMp_Ykz2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehmrghrrghtrdhkhhgrlhhilhhisehhuhgrfi
 gvihdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgv
 lhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:xqVhaMcCAzc1tecmCCihCvpbP7SrD-p_dV6CcW3A4wZulz3MX3fMGw>
 <xmx:xqVhaBO9fn6P9n08aWxycvuw3wxGas3EbfMlz8a1b7OJDua-EAzx7Q>
 <xmx:xqVhaGkvQALfnnGfF-28yINDbGpTlKAnanb-zP_ysKdZ4BUgCmEQBw>
 <xmx:xqVhaDsXVtU26BEdw8GFvlR7GzgxyrFqTpq6KICagz6wbJz5aoRgeA>
 <xmx:x6VhaEdYL2L40GrWnX1uc-nD6ZoixObBdbQxTBuAyAHi36yJ2hKRfJHo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 16:44:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org
Subject: Re: [PATCH] buildtools/get-test-suites.py: muti-line macros
Date: Sun, 29 Jun 2025 22:44:52 +0200
Message-ID: <4979497.e6Ti0vRb3T@thomas>
In-Reply-To: <20250618123946.66915-1-marat.khalili@huawei.com>
References: <20250618123946.66915-1-marat.khalili@huawei.com>
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

18/06/2025 14:39, Marat Khalili:
> Test list is currently generated by scanning all files for macros
> starting with `REGISTER_` and ending with `_TEST`. Unfortunately, this
> was done line-by-line, and macros split into several lines were silently
> ignored resulting in tests being excluded from test suites without any
> warning.
> 
> Make regular expression multiline, capturing everything until the
> closing parenthesis. (There should be no nested parentheses due to the
> nature of the arguments these macros accept.)
> 
> The rest of the functionality stays the same. The result was manually
> compared to be identical to the previous version.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>

Applied, thanks.



