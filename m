Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B6FF60EE
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 09:07:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C382F4042F;
	Tue, 31 Mar 2026 11:07:24 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 0C6EF4026A
 for <dev@dpdk.org>; Tue, 31 Mar 2026 11:07:22 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id BA106EC0128;
 Tue, 31 Mar 2026 05:07:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 31 Mar 2026 05:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774948041;
 x=1775034441; bh=FB2GgWWjPP1wVEMiEsfhjVpMVKJ2AJsl8V6gPz6N7uA=; b=
 I2rWa9aXR1X/xRsiz/aGD3Hamn0pfT1Oz/Bnq4YatHl7o1QQK7UiEcTnqMubY6mE
 ZXgastlVtkg5mILoxYc3/dotV6EGp7nojqWoh5YraAm1zus3bh9IciM5HQGTvO6C
 IS2n4OgB2a3ostL8UOH5BoeEkLU0/jEFH/1PGwwn9N+OSc4yHGMGN6xXLmjfurar
 XgNmRowYAYe5QcJUZzlX37+u3GIX4DvB51dFqpNL3XDYNvQdqoVZ5iXvnIRKZuuM
 qzwmx3Qj+3g0KcuXHiQeCkYBKvaH4Oa7mAYqdkjJnTyZ7SncQoW3pqBv3D5v2+sk
 N695yWL1Ch+B6u9MgXkzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774948041; x=
 1775034441; bh=FB2GgWWjPP1wVEMiEsfhjVpMVKJ2AJsl8V6gPz6N7uA=; b=f
 UQRwIthRiw2YP6WoKjbTHRmcUW2cuC9dD2Rd9k4LmjoT9R8+qAXnJyMZuwEQ6xWr
 3fLvrDtaxonjakdBQJOjZjh9TOJkgCoR9giTsJvBITQivJADX3qY2kYqsbggIEe9
 rZSefhTpwMOXUBCMvyb7ABufbkP9UaZDJpIxllc8pWaIKIzX69UY9j1IgyICRdAV
 pJ/E9xyt5UARTgw9LKVzOmDRdutcCb3QV5CqAubI9iwD0mkXS3yka/gV1F3OfG0g
 /I2b5To5eTiAUJejP2ZH/4tbTOJ1z1c67w7LvSW+UM2au0ybtn33VEgHryK4CiJl
 1wBQWjLKWU6/uxLqc/Pfg==
X-ME-Sender: <xms:yY7LaRCZvlwdf_W_w7MSjnCQRGvPuTpRoq1dMTVfcj33MYPR7aPBtg>
 <xme:yY7Lab14FnfsGom_Dy3ccvlDZRKt6pu9YMR1AInArziQrOErf1x_EuZRiP3moDWCl
 HWNaLfIofeCD8qypzPsoWQU_tVCQTe4-Keypc-W5_zm1FDwERTi6g>
X-ME-Received: <xmr:yY7LafU_Rigg8pTvajBkVVDcKBqVVNWtY_USgMEbCaqMjrSN2MFPfppsEtEJD7m_EnA0lp9ui9UANfev-zrwdbZc5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedugeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhnhdrmhgtnhgrmhgrrhgrsehinh
 htvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:yY7Ladn4zofrqlMTgl4yJ9btdRpd6oi5FmVkIYlaVXMcSs-mx6gbgg>
 <xmx:yY7LaZDgB5EcLCEVONCMwEjgKcfCDbwXVT6_BQSzFvtKwEHURwJIXg>
 <xmx:yY7LaVdGtuAQ86cjfgoX0qv-8ejIiAcVaWVem3fgvZ3JLpd0kndjPQ>
 <xmx:yY7LacKayKSfFBAE5wWaihjuEAKA1MAxnBrlVpoSLweQL1RS2Wmy-w>
 <xmx:yY7LaZpaX0LLQL7FgQN8K-YA5oO5QTF6DHjiFjtWk1FLB07SaCxsfOMr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 05:07:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: John McNamara <john.mcnamara@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1] doc: update release notes for 26.03
Date: Tue, 31 Mar 2026 11:07:18 +0200
Message-ID: <4226433.8hb0ThOEGa@thomas>
In-Reply-To: <20260327193034.2700185-1-john.mcnamara@intel.com>
References: <20260327193034.2700185-1-john.mcnamara@intel.com>
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

27/03/2026 20:30, John McNamara:
> Fix grammar, spelling and formatting of DPDK 26.03 release notes.
> 
> Signed-off-by: John McNamara <john.mcnamara@intel.com>

Removed helper comments in the file and applied, thanks.



