Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95634CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 17:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3AA340280;
	Tue, 11 Nov 2025 18:04:25 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 3AC6C4026D
 for <dev@dpdk.org>; Tue, 11 Nov 2025 18:04:25 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 8776F1D0016F;
 Tue, 11 Nov 2025 12:04:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 11 Nov 2025 12:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762880664;
 x=1762967064; bh=s7WXM10gu0tu89QzYJPnC0eWLlHMaYIIl3bcgGq2ZOI=; b=
 kWY8XNvQq9affrHXpwqHVRbXl473XxYwRRc2tCTB5updugvE3eIvMbHQwKc0tqVz
 4j+38ldaHEofnrpLz+9nQiQABM9LVLrrHLjriLRbeJCu/et56mxr2gPYGmN9jeaT
 CYGmEW18Oz9hPTvGtra9c67D36lVc/Bf35BLPgp09+4wzeBkoM2nOfCfScxXvrVF
 CFGXDJqCNtbdHMcIsgkWC1qIbm18ljNJkxlhpG/C65JSHSdL0K0fn4yW4FpDwx/k
 0kpgiL0Sg6mOwFFhugaMLHaOUwOV+1mzvH7bGIk5Ei9sO80wPL0N/gatB2kcN/CU
 dfAKZxdALoy9hh6YS+gNYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762880664; x=
 1762967064; bh=s7WXM10gu0tu89QzYJPnC0eWLlHMaYIIl3bcgGq2ZOI=; b=F
 ra9osJnII8eUsZsifrz424nxlh2w5iGWBjDbXL0looqy6mpIOlnvH5a/OIgQzO8C
 Aiu6UB7qNOp4GT2JfHGXb0og37G4mt+3dYBaB4a4f2cQE0p4wXTqxnTxatZcNig1
 BMeaG48NLK6JfdopUyzbFJNGZNc9tTcMrzjXPNO9e66wS28IszH5KmejfgJu/da7
 JhF03gftnyppUqL1RmJFYoNMoSHmPEKwHquoHqf75peYNVQe1zKA90Wqr6Qpj5Q5
 liZvDV+wcJn5mwPR4ClbdjlmGEkN5YIB45P63MXqfYiVOuCUK5/eSRTSlIYXqlUc
 JxdTgkrkyeQTCAMKkRiaA==
X-ME-Sender: <xms:l2wTaZdVOcjIzxqU1_9BigqAx-R8QVfCUSX0ZTCZx9JWTgxZeCgDTQ>
 <xme:l2wTaTgILl4rFRe7eqrnt1fAMaaTPwxXE_paFJpl1BbXJf-xRuNsEgAdRVbN7TJAG
 y36zVznB1236AlJcuwznkkSM9UonlTySGMVa7N9GQ1QflBH4WynUw>
X-ME-Received: <xmr:l2wTaVTZmqfQ9zRxjQPuHaWyTP-LmUgSkFjKNUk4g3dGwELNtIZCk-R2RcJ_O0Cd03_VXvJoboTU3LEpPMkOY6CUmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddujeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:l2wTaUygM4Y5zcILkAiaUkUntIS5Y9-d8WrmbJ1HBl4k0NnISW4vkQ>
 <xmx:l2wTaYd-WGhFD_r3jIA9fNBA9rYUN3DEPw0FzFYt09OgZaXKPOwqfQ>
 <xmx:l2wTaYJyqc3g-xHCbJH0ring_pjmW3pKFdhpUXKlbTbmcpgxAZ1Yaw>
 <xmx:l2wTaRELpQONy83D5Tqs-q8MGffU6v1d_UygW0DBlbnRokr5-tfo_g>
 <xmx:mGwTac_PX78sTezM7fzRrUZcBYSfmCchVUZ82R_yrUwS4TETAHMvx_4e>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 12:04:23 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 0/8] packet capture bugfixes and secondary support
Date: Tue, 11 Nov 2025 18:04:22 +0100
Message-ID: <4071013.yMk1gmxOD6@thomas>
In-Reply-To: <20251104180927.403355-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20251104180927.403355-1-stephen@networkplumber.org>
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

> Stephen Hemminger (8):
>   dumpcap: handle primary process exit
>   pdump: handle primary process exit
>   pdump: fix races in callbacks
>   dumpcap: handle pdump requests from primary
>   pdump: handle pdump requests from primary
>   pdump: forward callback enable to secondary
>   pdump: remove use of VLA
>   doc: update documentation on pdump library

Applied, thanks.


