Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A5BE9D416
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 16:58:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7772402F2;
	Wed,  4 Feb 2026 17:58:20 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id ACAA5402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 17:58:18 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 65D9F7A00A7;
 Wed,  4 Feb 2026 11:58:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 04 Feb 2026 11:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770224297;
 x=1770310697; bh=/8an0Dh0rnfoOEhpwVRHDtz3hJhzN+lLepiBYP9at6U=; b=
 EhGB1H4I8llIJnK8UnQO2J9IjietgwEwykQiI6AmKnZ9v8bayE03L3nPLTmOYwfB
 1GAJBZxvFdmkgExWITpm6Si9q0e9F73UpotwNoA8n2+cG2gkjngJKYAUPCJWaLbW
 FuK4yJ6NKA1p410g83ouy4qPn6QdhJnR2AQnJdhom8AFnw5CeTfMjE+ljx1rA2t0
 IPhtnDs4QvwbdDkkW2ebYgrpldlaQz9e8PnNmnya8SWQk4WUwX1yzRRHcduWiTAE
 gvo/2TD0+ob6YDPkPOofxCfWM6WlWVJ7dxTRWzivGpWwx5w8oX7QUw+kPTa8NiBY
 s29uDRuQrqVbYFPiTV+v4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770224297; x=
 1770310697; bh=/8an0Dh0rnfoOEhpwVRHDtz3hJhzN+lLepiBYP9at6U=; b=G
 lefDTTH69AjWBX8QohV46B0a1bt+oMqwmhAfK/QoF1pMr5I7/2T5pwjfYHLrKcsX
 FtC2xpla/dSXJnCYHN2Mm9Aos2zlWSaNg3fvBNsRYIcCAWMoNbKTnexmKDd7AVNL
 oEGkOd8pFDML2be6kyjUpKFmU9u727g/YFSNGImK9RbiOM853gI2ULxopBM/lQMR
 bxknX/SuoRpj6qq4UnkLMMWClxv4bN8mginP7kBU8vhAnAI1U+GlgSSv23VWnwk1
 zhrRTJSIs4ZrbH+jrGTelDdvAl0r7vbzAhCDlqtkHm2yrgtIMneQh+K2man0BUwF
 Xyp9r1XGxT1TkrwKqliIw==
X-ME-Sender: <xms:qHqDabVU7_yAec8_USZnwa3mSsjfdKy7ncbiuWEwCiJ7_U8ZRFepRw>
 <xme:qHqDacgI2sgo2F_pJZfGiwMC7cGhO1D_ZWMVCy83mJ7eJl3zSD2Plgz9fUKjDVBWC
 P3iFpJ5OXbjXF_OVr1qVopVKXZ6YnII-_CXhX96YXobYcQ4Olo>
X-ME-Received: <xmr:qHqDaS-1UkeZlXk3Bhp3GTDOWyLQMsamO2G_UCHiQfvUmLE01YE3GOW1F-eWVXFkjSBi9zOHWkKl5Yzwco94d9IAEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrrghtrdhkhhgrlhhilhhisehhuh
 grfigvihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehjvghrihhnjhgrtghosghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhonhhsth
 grnhhtihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehmsges
 shhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopehsthgvphhhvg
 hnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:qHqDaWagxG15q54ANWwLlFjVMoS-QqpST8nSCb-mjnqmCBWZFGG94g>
 <xmx:qHqDaR1Kn_8XHUFkBw0Y3n981gTRquIYMs8k_LqumlbEhNBIFtrR7g>
 <xmx:qHqDaRYMElAjMNzA3ToDaTNhixuzjFgkCKEa3s4-wHjeQRf7qcQm0Q>
 <xmx:qHqDaZK4SO1zQxK1TxMtxf7WMD9sz6KqDTDSH7GEdY5w_jO7OQaq0Q>
 <xmx:qXqDaVwZqKRVdokKU2ySQ-BmEocnbT_M5n0rcSeEyhi6kuROJybydY_q>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 11:58:15 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, jerinjacobk@gmail.com, konstantin.ananyev@huawei.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: Re: [PATCH v4 0/6] bpf: simple tests and fixes
Date: Wed, 04 Feb 2026 17:58:13 +0100
Message-ID: <25146683.6Emhk5qWAg@thomas>
In-Reply-To: <20260127114944.35993-1-marat.khalili@huawei.com>
References: <20251217180141.60227-1-marat.khalili@huawei.com>
 <20260127114944.35993-1-marat.khalili@huawei.com>
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

> Marat Khalili (6):
>   eal: variable first arguments of RTE_SHIFT_VALxx
>   bpf: fix signed shift overflows in ARM JIT
>   bpf: mark ARM opcodes with UINT32_C
>   bpf: disallow empty program
>   bpf: make add/subtract one program validate
>   bpf: fix validation when conditional jump is first instruction

Applied, thanks.



