Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E49CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 09:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 705F8402DD;
	Wed, 20 Aug 2025 11:58:24 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id B88D640292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:58:22 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id DAEAC1D000F8;
 Wed, 20 Aug 2025 05:58:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 05:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1755683901;
 x=1755770301; bh=jiALTAlEJNmdaMtkS4Dak62MCeKM4xF1EYGh4nbWWUM=; b=
 I6zdDRd5QV4sg+MZjQt55XJTe9vklOm5bixeae1apPqz+espvSjFQP/oMofn681m
 O+r5LRVHaGUIArJa5TELc7cte8uLhThTePT5b5DlsDycNppZrgDvrFWhSLNTu/NA
 M2/rFVX+8UWCdRerJ10PS3MUS2ZtKy57KUvGYThsjFWpdlk9Mcec0kJ6zBZweGrJ
 B6PKRKVGPbf9MKTNnOq+ZSk8njIjk/bbJH/mxWFqwc1WR3TeulbvFZ82dUJPOiqM
 igEF/Fdk4kxZdOjvBG9WLJvmMhTp7TIqkoTLYzcfpbMxU2sD/7mg/q3ASBGXzRPr
 Q7GEqSyNrIt5OP0d7rtDjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755683901; x=
 1755770301; bh=jiALTAlEJNmdaMtkS4Dak62MCeKM4xF1EYGh4nbWWUM=; b=T
 Ktlls0NLCaLTOf+22NQUshXhPDAWizNwHiIcuftF2f+Ay2/eXP+fU1Q8WUMZRlFN
 Xv8fz6371oDLUtUBG6e2mNnOpRkwhsM6n+bix/OUig7Q3BRaFRXz9Ud8rHsPahwb
 z2PZHWu5d4VFzMP5OywFPwH4y9gFoVt5nayIl50SC98sFLy+k156XHuI7WzTenBK
 xk6AHsPtZ1Mi9asrRLu+MgSrJf7EEmo58nM0SXcaWsNn2xobCH/mAaxxwudmcc4P
 rrTU/1iq8sMK6KSM//ZyNPtCUyTyZcKZIJeMdNeybTmfwm+Din+F/0RRIXufJaHg
 mBLQ/N2r+xFVEtmy1GsGw==
X-ME-Sender: <xms:PJylaHW-4NWnoFFa4lZilADL9Q2Difv_Fe38tAwsBEhk53YwUJAUtw>
 <xme:PJylaJPoPuF2OoZ4WwNoPBLKPi3U-BVAsGoEO5--3LsBvBVfy2rk3imDw6Viasu92
 Sc7KyDmqS-XUuSi8Q>
X-ME-Received: <xmr:PJylaDYQEwDrtmbp3alaEA5s1yeV4BNpCAYz8B68M50eRcsizS7RY504cYmirr7G--2Xzy8QPLMbMcvFfc72dMlqjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheektdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 oheprghnughrvgifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruh
X-ME-Proxy: <xmx:PJylaFpz9CJT0DfvenKuIPsJQ4fFIVwG5fBNmRumVq59eu1O3HfHig>
 <xmx:PJylaPZ8es1rKUCwMBzQC2AOJ6WVKtjuA4IxNUhQ6oJyZa0SYVjB6g>
 <xmx:PJylaFS0lXqd_QLmDEsu7iP1cSTZazS48Yb-ycxmd_nFmgqNzvYTVA>
 <xmx:PJylaO7AwtEXVHl_FgVov6LrUOxeD6UQ5knuAdkb_yahqj7J4LbkeA>
 <xmx:PZylaARCbLg2dbqbtmPxOPsILKLw1SCPhs-NrR9vYRWrPqBOPnHpVGZs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 05:58:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] ethdev: hide internal ethtool symbol
Date: Wed, 20 Aug 2025 11:58:18 +0200
Message-ID: <2281721.ZfL8zNpBrT@thomas>
In-Reply-To: <20250820084147.1253706-1-david.marchand@redhat.com>
References: <20250820084147.1253706-1-david.marchand@redhat.com>
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

20/08/2025 10:41, David Marchand:
> No code call this symbol out of ethdev, remove it from exported symbols
> and rename it.
> 
> Note: there is nothing particularly wrong with exporting this symbol.
> It is just unneeded, and this symbol referencing a linux kernel enum
> triggers a abidiff warning in the RHEL CI when this enum gets updated.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Thomas Monjalon <thomas@monjalon.net>


