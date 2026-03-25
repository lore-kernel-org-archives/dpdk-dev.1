Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF44103A9BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 11:41:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EED9C402CE;
	Wed, 25 Mar 2026 12:41:44 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 412E24028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 12:41:43 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B7A4F140009A;
 Wed, 25 Mar 2026 07:41:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 07:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774438902;
 x=1774525302; bh=wKHQpIKecOxmXzTU4IPVQrxd82+LRobLM+5WpCOpkVg=; b=
 Dd5yvs+u+koKEcCtWPC4wp1TE8DWQN1B6POH5wcQorLhsLwEOPVDJliXp6Bojx4h
 1v4zjGI6E1XArkPP2EgykEI0udRhjwuuAVc/6jyqMQKmgi7WyWg52Q9oFZ/zLYqR
 E4L8p0yeST8y5Iy4/2IQTzkdCsQp7CV1YYrqUgCKXa0U4RIdYXYX1FWF/mtdd6gV
 t9b6EMQI7orXuyBCjj52rvwGD7xxU1GoEGMIZG3/Cgay0MP71GN78V4OHnTOxUe9
 sZuTSgzQtJmagNR6WDLTcDoOxLY7/ITCkUMe1DGFq0CNn2ZOh6pEVBApXTOv9jdx
 IKfhRlfAYRlBhd6XCr3bLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774438902; x=
 1774525302; bh=wKHQpIKecOxmXzTU4IPVQrxd82+LRobLM+5WpCOpkVg=; b=b
 Zh5qFsVaPOxvBOZO4BWGd15cx6PJoFK9XqruGaaIK3GpS6qjM8QmEyEvGYv3WsdY
 dvLVWghGUSGurKl9Ace19MTWY2mF8yi3nS/LM/I4x4EqQCzfPoWoZulyE2898TeM
 Pzxy5OQnM7ByBcUUw+nloUuXCseeMyPy+HXCv67VPBNvTVnGg+jaljpYAzDb8/PD
 f1YiYkcDXI4blgRIRCL6wqyE1trFG/FVLPfYQsTPwj1GdSVQKvBXhALl0JBod91z
 ecVdp27oV/fbTmZvND/DZrh04zN4PmrK6thRu15y6ZBvUPpHgdTu58WzG9BeDJ/y
 ohanv1ZqcDjjL6z/GFQuA==
X-ME-Sender: <xms:9snDaWg705BUiaqtz4uQbLGFGez4kqH6tWcOvwWvTaKWXud4GACvrw>
 <xme:9snDaTWo2ibo1u-CvVFmIlvqP6Z81HJcANWlQT47dJYWn4FxEbuGtiyTaJpQwrh70
 fGSWqGeoneppxc--V9Q0eDK-V9n5AORzM2VE9lJH4jQ9mJDiPK_Hf0>
X-ME-Received: <xmr:9snDaQ1GFBRmLEjGketrfiBpGLVI-thUHcU_DqkMiIq9v0gBdKCrj6jIMK-H5tu8DGdBn-8YQPZpPEqtSzDnTMB1ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegfeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:9snDaREhIXb2K35ctJaevUHEff9MjbdkLNImz5xcPruTGlo41Pj52Q>
 <xmx:9snDaWhQxX0klOFNremUxF504VJFIzcPUJPQNXeyyzzfnuTsSUpMFQ>
 <xmx:9snDaU_1-kr0ilzs4dRbmIdzKQ_AhOXuG7y2MyDTRWfAXGSaCpL_JA>
 <xmx:9snDaVrq2fV6ucAxJS5bDtqfZ1KkC9zEfRfHLLDAZSxrsM9_QHbftA>
 <xmx:9snDaWije6BvsFniapdNgcvB1JfC7wkwHAv5n1qbVa4HzJHqZ3YM2mDe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 07:41:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 6/8] doc: correct grammar and improve clarity in ethdev
 guide
Date: Wed, 25 Mar 2026 12:41:40 +0100
Message-ID: <10815937.T7Z3S40VBb@thomas>
In-Reply-To: <20260128194722.480862-7-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
 <20260128194722.480862-7-stephen@networkplumber.org>
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

28/01/2026 20:46, Stephen Hemminger:
> Improve readability and correct minor grammar issues in the ethdev
> documentation. Changes include:
> 
> - Correct subject-verb agreement and article usage
> - Improve sentence structure for better clarity
> - Standardize terminology usage throughout
> - Remove redundant phrases
> - Correct punctuation in lists
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/prog_guide/ethdev/ethdev.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> -DPDK's Poll Mode Drivers (PMDs) are high-performance, optimized drivers for various
> +DPDK Poll Mode Drivers (PMDs) are high-performance, optimized drivers for various

This single change does not match the commit description.
I suppose I should just squash it in the commit changing the whole guide.


