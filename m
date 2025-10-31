Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CA9CCF9FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 13:28:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D4D240612;
	Fri, 31 Oct 2025 14:28:36 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id BBDB940609
 for <dev@dpdk.org>; Fri, 31 Oct 2025 14:28:35 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 5BBE7EC0083;
 Fri, 31 Oct 2025 09:28:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 09:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1761917315;
 x=1762003715; bh=BJ0TsvOLvoW63htN2K3MXwaTnpXJdztdeVYlgA8mdrw=; b=
 hoTmRA+L31wny8p4DlxAtzcf3kIXMEhMm7/dDDwW0vTqkZnb8rYsJtunMsSBlKM0
 XBtLu6cl/dBIZ27dKgnUJMGsd9xatPZJMJJUu9J6D/stGNhbVp2x5DKFnsFequpJ
 5X9miUNSd9XsXK3Yg1Aqr3JqWdNN1m/dRd0OYMOuxFcZN2RvzZ8XV5RBmBJht1Vh
 +3bIsvAT7PLw95KG3gDeepx+2qf6qBYY6QkFF86bmncf8Vw/aE/pCCKJaC6/X+eC
 intf9dUqSqLBnuqOMJWgp5RFvcmnyPtiCPrf8Raef6wfmiN5mt75LRXCDtJkf2s0
 ZAdegKRtPBXy7HAP5vXSFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761917315; x=
 1762003715; bh=BJ0TsvOLvoW63htN2K3MXwaTnpXJdztdeVYlgA8mdrw=; b=a
 lzzYGLmJlaUDdiuqopGXwtnTk/wSLa37d14t+4rWc+nJiEIRtpy5NwI2QSugcnK1
 XY26aaBQWO71PP7vGT4S9lU2+qk+3PBHm66gg1426dXlwQIQmx/z/gAOxTp+WWSJ
 PhD0qmfgc1rc4Ld+2mlPB8xrgors93ENxWDqNegKEvlw0slMD4CjhiXuTP9lDMEN
 Bx4BHcDu6ksTYvVNkZMFSPS8VCMQ+fYKlFUrnjrq/XWe1zkAU5NwDd5OKTEigYh+
 GMqNojgWJO/AebxywdyRnX/2IPMetdAoekW9PeTI80lPl3zXq40yqVljmzpi09Vs
 Uoc2zBbwVrYoDkh/+4iOg==
X-ME-Sender: <xms:g7kEaeppg3g8q0kdYJ6TuVGVHPhYXevWsMX7qqxT1M-RnnpdM9Id4g>
 <xme:g7kEaQ9AbI4LMsDg2LBjuOIDPCbur4lLVeIsgFzfeByLyNjWDEXbXWC62qzqe6nvE
 bVymlTrb08LW20ApK2tBli9_tfZsQ8e0Gur-1No1zK8OMeZ5MJZSA>
X-ME-Received: <xmr:g7kEaSVzDdF5MLO17JORAijN68IvtoDGW60ExfwwFg67bAnw7gpAULqfVnhrkognEXHpdn3A8J00WWoouyNb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieelieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgrvhhinhdrsggrthhhihhjrgesug
 gvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 phhrrghvihhnrdhmrdgsrghthhhijhgrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:g7kEaWA8GwY_if5XIUwaKUMEFQN8YRkGb0RpmDMZJVx3m0W_5Y7Sfg>
 <xmx:g7kEaTz91C7JMcyNv09ozQ0AzGcPktNhPu0rwtALGnJp8F1C_bJXEw>
 <xmx:g7kEaTA-TrBBe0NaVv0dX0_rmGwAfpTgSH9v8zCE-ehxcxGgepgAVg>
 <xmx:g7kEaQYW0bsCgmVhSG89jrcBZswbQAyczSDqRhBleQk2b48Ork_MQA>
 <xmx:g7kEaaAerJslkyC9zrzvb-YZnGT5rsTHL2qgAHEHU-vIrHiy4_jat52h>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 09:28:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pravin M Bathija <pravin.bathija@dell.com>
Cc: dev@dpdk.org, pravin.m.bathija.dev@gmail.com
Subject: Re: [PATCH v2 1/6] vhost: add define for configure mem slot
Date: Fri, 31 Oct 2025 14:28:32 +0100
Message-ID: <4112055.uBEoKPz9u1@thomas>
In-Reply-To: <20251008090444.2689652-2-pravin.bathija@dell.com>
References: <20251008090444.2689652-1-pravin.bathija@dell.com>
 <20251008090444.2689652-2-pravin.bathija@dell.com>
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

08/10/2025 11:04, Pravin M Bathija:
> * add user to mailmap file
> * add define for configure memory slots
> 
> Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
> ---
> +Pravin M Bathija <pravin.bathija@dell.com> <pravin.m.bathija@gmail.com>

The mailmap file is for tracking adresses of the patch authors.
Why adding your gmail address here if you don't use it for DPDK dev?


