Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE13E909DD
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 16:59:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4D6740616;
	Tue, 17 Feb 2026 17:59:41 +0100 (CET)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id E150E40616;
 Tue, 17 Feb 2026 17:59:40 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 619D7140008F;
 Tue, 17 Feb 2026 11:59:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 11:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771347580;
 x=1771433980; bh=P/wLiOS5KjzNI2ajVu9iMyQZO9wOwpY4ZAdZb4UDAvA=; b=
 K9JKPX3u/6G5jRrj82Cmsda5ftpyckiBidWMiYBqEMycd2fvkpYQriDODMjzLLDy
 rNTceTVBCK6pHdNCuEHgeG8M6ZTG5HQsp7uJx69DSwL6+8wK0p72d/JxY2Gwpxcr
 aeZdA/qHfG3PyJGPEimolcvUobfDwscL3dEHvH6CIMBO4cRQ38dolwdTl941XGvI
 yHLgpWSyJGrNmPIjwbiSYpTuPDaRymVzBZpHb6x+tGYW3Y6jW9waaTqlxHBTZoLG
 iwvuVonpiU7DVb/WVs7kfFFi0g5no9wZ/ZOpdlD8KS1Frj71FgG0BlR7miHtXRCn
 Ql7od6GCTNXGNR+PluTXzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771347580; x=
 1771433980; bh=P/wLiOS5KjzNI2ajVu9iMyQZO9wOwpY4ZAdZb4UDAvA=; b=I
 L0kx6Yow+AZupxBI+YI/ebQVL2rxDiIbrmZbEvsQDRE4qqdFz+ewXZpdXvkHn9HV
 jMiabU5gsg9q+AjrvNM8TYKQwGHsWI6g6M4x/mkd3eXuo7mDJ508RYkS/CPQT1Mf
 oSs9cZFbzDA+SBTud0J+ISO+PkdYj7q7GfUpFiwFDg8nS+V8tsRr1/aQ2NtzI0xV
 XEut10aMqNZv99RBXp3CjWnMzPSIl3EuPn/JRFCyEqGhF+k48NQZ/Dzf4t0LM8V4
 YCEat5cLwfEA9vD2ZGe5cch8W0qO20oRDvhGfOSRg1QIRqzbL8TYZ+t61j6bzFY1
 9m4Wb7xYcYH5f0w3QrXYQ==
X-ME-Sender: <xms:fJ6UaSWxz0HvL2W3mcEa8r6GsUseK31SZuvg1NSwqkwcCcKgkNvodQ>
 <xme:fJ6UaesrQw2GJKVG6BVy1RT5fTm0O8-zrZT0p7uuzB0tucayW8n0LcJI4a_CjNVfw
 AVvI9ep5pgnmSGWsquXZVze4qjd2vUap4FAye9VISEecn8nv1AA_Q>
X-ME-Received: <xmr:fJ6UaeXehbMcMHIdAfJC-WQEpVa-QTmKSaiK8EcFTA9WcetysAscMIxTMjO9yyT1mVbnxinTAG4csGvGpSfLSNkzyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtfedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggslhgv
 seguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesih
 hnthgvlhdrtghomh
X-ME-Proxy: <xmx:fJ6UaRlmjCqdvQHnPvIM0WbMipWOY5pvu-ws_Sw6EWi_pIiCnoHhtA>
 <xmx:fJ6UaXb8d3xx36kBAPNj1_pJStijhx7VMkiL81EYKPEnC0dnGuomvQ>
 <xmx:fJ6UaUOQ0LVGCd17r_L7FBmgDEtR2K7_JdLp2F6D1IuDeuap5dT-2g>
 <xmx:fJ6UaUbUbpAjUkMhxHITWGD2lc_6zUuhwmtM2XkReoVT2BAeaX4Ecw>
 <xmx:fJ6UaUQh6f1-2O13ckfwten21mJdZwJRQjxZrrU6tPFnk0x2NzRnURyE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 11:59:39 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH dpdk v2] telemetry: fix adding dicts in container arrays
Date: Tue, 17 Feb 2026 17:59:37 +0100
Message-ID: <3853339.RhXAfJsIN1@thomas>
In-Reply-To: <aV-Pne_XsGUwV0Oq@bricha3-mobl1.ger.corp.intel.com>
References: <20260107215129.1329960-2-rjarry@redhat.com>
 <20260108105036.1341037-2-rjarry@redhat.com>
 <aV-Pne_XsGUwV0Oq@bricha3-mobl1.ger.corp.intel.com>
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

08/01/2026 12:06, Bruce Richardson:
> On Thu, Jan 08, 2026 at 11:50:37AM +0100, Robin Jarry wrote:
> > Currently, adding TEL_DICT containers in TEL_ARRAY_CONTAINER containers
> > is not supported by rte_tel_data_add_array_container. It wrongfully
> > returns -EINVAL where it should allow it.
> > 
> > This is supported by the JSON formatter.
> > 
> > Allow the same value types than rte_tel_data_add_dict_container().
> > 
> > Add test case to verify it works as expected.
> > 
> > Fixes: c933bb5177ca ("telemetry: support array values in data object")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Robin Jarry <rjarry@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.


