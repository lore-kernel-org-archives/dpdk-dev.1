Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A7BCCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 15:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2394A4021E;
	Thu, 23 Oct 2025 17:25:11 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 0A48340151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:25:10 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6738714001AF;
 Thu, 23 Oct 2025 11:25:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 11:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761233109;
 x=1761319509; bh=zjX4lwntY1VnswPwkbk298DUteHy8P9jCrw0fmZKVPc=; b=
 Io1g+MLxqdIh5bzP7brMhs9PhDPT8o4wesfH6W4SEIu2AyW0mNzK8dBm7JCJOYKp
 2hQUB16Bvbs66n7GtG9at8EvpW1xjNUTqPi1OY0CMPKqtBUYO0zIxQCChtkpWpAo
 Wm5c8eRVW9m3wRLmZ9DVCJEMKHM0afXantjLVukI/3oV5qIokB/EwCA4H3w7OlHq
 sKgcdvrMhvF83BCd1XZBQbyTuYtdM9VNPTPKaxLo8cDgcD2YSZQs506/trcn8RLD
 HWlPYKnNismt8XpQYtaF9hN2XUaPWxjeyKokibu9jPDZEkUJlm+Nybv9+8eomk/p
 1kmIm+iF3t296FLmaxXVPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761233109; x=
 1761319509; bh=zjX4lwntY1VnswPwkbk298DUteHy8P9jCrw0fmZKVPc=; b=i
 9IOcSW8nKZ+yY6NAaKLzavqQ4KB7AUpCRyF6Wx0T5cQi7IEk8bvyAsS1VkRSfU1p
 6MXobW19ddwV/pZtC840Yn1I7ze14dl6XZnQp2HpKtUmbed5KjClAygTy2uEOlAJ
 76TU/hpNDLokoBaFwRPC8nO0PxsfVRzZZFgaE3FZcb9dRdvttbt5P3VudTQB6yXa
 MwOnOl7WMrfIFEhqGHMDOiy9MuzXyWZ9xhKr1AGnKyZUV6TIgdSVUyT0BftwxtRJ
 sIKgqRoK+kddWJPvHq2RdtThtteZN3TfGV/6n3vO3S5f2jZjd0yf/xaXARGJtlqz
 Y0YB3qrtCIDI3dV/tn5uA==
X-ME-Sender: <xms:1Ej6aOHshTmiZbdOSdm8rbS5HJoOIiUDtCvpr49NRrkrpbeNgaXjig>
 <xme:1Ej6aLru7g_OtJdvJvwds97a8U2ctC_tHy6peFgU7UabpvgrozI4Ynz1iXJjU_Tk3
 H14BJUWh8RJLjLo1UAYSNmtqO8OnCnST5Cw91y0MCvyyWoTTf3qVw>
X-ME-Received: <xmr:1Ej6aK7KreFnvqEkm8KxBVwcIgtWaxOPhfMytHoHLKzk3PVtf-RHRaBoI78KSpTbqkroq9-pVEdWf2_cedOVLEYrOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeikeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:1Ej6aJ4_E9DE191MGPRsSO_RLApTIZx-tS8W_HnFxC82BjJ0S-AEFw>
 <xmx:1Ej6aHEAS8G1ipTHYC24CfEOaGsIpo9DlpNRmgqiF0_y2dPBgUV46Q>
 <xmx:1Ej6aCT_Wj2MzJZwCPGbFtw1Jbd3NtaxERJkEJWYJvD3ODRj92rXAQ>
 <xmx:1Ej6aAt47zchTjXyiCh4wqc55g8XjbE0h-CBch3B2sqCJ2HEmFFGHQ>
 <xmx:1Uj6aLMLNps7__YRm4FkZDHx46qvftdvSV24bTX5DYqeUZQlWuXOxPjM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 11:25:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/2] improve mailmap file
Date: Thu, 23 Oct 2025 17:25:06 +0200
Message-ID: <3958057.AxlXzFCzgd@thomas>
In-Reply-To: <20251020140805.1361249-1-bruce.richardson@intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20251020140805.1361249-1-bruce.richardson@intel.com>
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

20/10/2025 16:08, Bruce Richardson:
> The mailmap file in DPDK is not always correctly sorted, and standard
> cmdline sorting tools don't always do the job correctly. To improve
> things, add a new script to devtools for working with the mailmap file,
> to make it easier to add new entries in the correct place, to check the
> file for correctness, and lastly to sort the file in place (hopefully a
> one-off operation).
> 
> Once that is done, commit the changes to the mailmap file to ensure it
> is correctly sorted in the repository.
> 
> V4: minor changes based on more feedback:
>  - sort imports alphabetically
>  - remove unused "operations" map
> 
> V3:
> * feedback from Robin's review:
>   - used builtin type annotations
>     - used argparse subparsers and callbacks for individual commands
>     * re-sorted latest mailmap in patch 2
> 
> V2:
> * address multiple feedback items on V1.
> * fix bug whereby adding an extra actually sorted the whole file
> 
> Bruce Richardson (2):
>   devtools/mailmap_ctl: script to work with mailmap
>   mailmap: sort mailmap
> 
>  .mailmap                | 356 ++++++++++++++++++++--------------------
>  devtools/mailmap_ctl.py | 209 +++++++++++++++++++++++

For consistency, it should be named devtools/mailmap-ctl.py

Applied with this minor change, thanks.


