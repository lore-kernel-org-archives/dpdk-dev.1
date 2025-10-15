Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B64CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 20:00:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD4CF40E68;
	Wed, 15 Oct 2025 22:00:03 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 3027240273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 22:00:02 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 734137A005A;
 Wed, 15 Oct 2025 16:00:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 15 Oct 2025 16:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760558401;
 x=1760644801; bh=AT/V76Oje2i/dW2YuCvUHjunjnb6yYAhJNRblNHsv/s=; b=
 QG3MDJiCc9efwJnxIIZfoTlVPfsWz/Q9DcrGCoXbLYs3mrx3GXrbs6IgtKsri9yW
 GR2GueXJtb70p6zAAckDhuILiUdzNDj9RLaoBjeL1VH/3rxuwdY5VHdwBfoeYXSh
 u4Fx+/+XV+Y8Dy72QlNBHCKSXjMNAOdYFP329rle7qBeNf7hHRL1hdQ1ecYogixM
 72LGeeh6bey7Lv+Ee2vTOgFfL5F34LGZ1KHk2bdIKeBS8ZHWy7sPoMqacACOlkVc
 l70DxpYhsZ5YckprDa7uV7GfRBR9j2+6nXrG1bQ8lppjeVmvj6YZdNLu5P9pobeZ
 fxxqwH4gbnPPEPDqOu/tDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760558401; x=
 1760644801; bh=AT/V76Oje2i/dW2YuCvUHjunjnb6yYAhJNRblNHsv/s=; b=F
 nur1fyXHJBiRhn+HxZ57YJMq5MNQSJtYmuLmFlI2WLPXwnLQWhAk4pqHkKTXQ/X+
 fhCKJxV2xFDxCdDs2jg+TG1AYZR9TbxCXIQJBfA1S4XY7V+rztjCGCKWQ78qGAY6
 n5XltQ1gaCmcvVsxcl07bpP0C8YmrBK2uwGNPi74OCVm/fKkpyHZ4Am5nE0M17zx
 537kF98LYDnlwlHHuALWtx3tAhJL9GXu7prDYrvW7EyX7VAexqIQa7qbGQWlRqcC
 bkWXIVrTjm9u6sWS9+p4L9tLoqVva+nyxYCC6MvZ7JA4G6QlX5Gob/zqC1fPTXwl
 QRFI/0zvAEAe+0SP6dTEA==
X-ME-Sender: <xms:QP3vaJhSU4oLzy6-ObBMv2SU8thSWKLYPZ73PMBwY_985rYL6P4ESA>
 <xme:QP3vaI_Z_kSsObl4KuyXb9jLlfs-nJhGXX_lzrgLSDxyBQohjoTN0GKkNGtVwiUVP
 d7yl_2dFFxs6s1mP9f0AKWvpmqi2d6371yBE9iWoRcMAlfGKq5oog>
X-ME-Received: <xmr:QP3vaIGS1fcG_NUbQFf4GfjbB8fejS7AXzR4Eo02l7KYV4nS9PhDCuaJatfaLqGWAWFkEulhjBA52mW8L8VfY8A1nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegfedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegtfhhonhhtrghinhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohephigrnhiihhhirhhunhgpudeifeesudeifedrtghomhdprhgt
 phhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehkihhrrghnkhhumhgrrh
 hksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurggsihhlphhurhgrmhesmhgr
 rhhvvghllhdrtghomhdprhgtphhtthhopehguhhvvghntgdrghhulhgtvgesghhmrghilh
 drtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:QP3vaDlLSVM047GlP-bImByNR0xebztmGrNbPc6xgrR_hMPR99T95A>
 <xmx:QP3vaEYZmgHYZZm4RJQikLnN0vHN1zRJzECwwxbo4iLsgn177RBN1Q>
 <xmx:QP3vaAEVibA_aMjrCPIh70-lfsSASmjPtPMKahfxqx5weDIpLBFOZQ>
 <xmx:QP3vaNKr3dVel08I-X6uCHDyUs4tXIBZRynD6MXxvzfVGkP_L9Zscw>
 <xmx:Qf3vaJWaO9dyuBHByR1ZnK9IUo8WKXh0CuTyNhS76OpK00H2BJ5uNfpi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 15:59:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Christophe Fontaine <cfontain@redhat.com>
Cc: Zhirun Yan <yanzhirun_163@163.com>, dev@dpdk.org,
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Guvenc Gulce <guvenc.gulce@gmail.com>, Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH 0/2] graph: dispatch mode improvements
Date: Wed, 15 Oct 2025 21:59:58 +0200
Message-ID: <17969458.Ash8RoxBsO@thomas>
In-Reply-To: <BY3PR18MB478556F4158B03FC20BB7A4BC81CA@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250723165001.11162-1-cfontain@redhat.com>
 <2836217.eGJsNajkDb@thomas>
 <BY3PR18MB478556F4158B03FC20BB7A4BC81CA@BY3PR18MB4785.namprd18.prod.outlook.com>
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

24/09/2025 16:30, Jerin Jacob:
> From: Thomas Monjalon <thomas@monjalon.net>
> > 23/07/2025 18:49, Christophe Fontaine:
> > > Small series to improve dispatch mode for lib/graph.
> > > In order to run an instance of the graph in a control thread (slow
> > > path defined as nodes) in addition to the datapath thread, we need:
> > >   - the ability to run graph_walk on an non-eal thread
> > >   - a signaling mechanism to wake up the control thread
> > 
> > Should I expect a review before merging? Someone?
> 
> @Zhirun Yan The changes are for mcore dispatch, please review.

No news after 3 weeks.

> In general, changes looks good to me.

Applied, thanks.


