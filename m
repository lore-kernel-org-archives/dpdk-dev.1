Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E1CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 13:55:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF6BA4026A;
	Tue, 11 Nov 2025 14:55:57 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 58C4D40144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:55:56 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 9E3591D00153;
 Tue, 11 Nov 2025 08:55:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 08:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762869355;
 x=1762955755; bh=ES5jXDe7pTBDJpJhzmFNmxdBF+D2nKQ0PK45UfOXEYA=; b=
 nbPUX7HW00dYEKnwE8x+DQPOTX9duvHqMVCiE5iy2yylHLDsmkK4OoPy9oDSlijG
 nuZAxOjwGDqB3DxnhOIbLnb6Fvep+gDHa0nySGCQ/tJA1rBL/8+qlJlhMLo2G97/
 BShvueYzQ2fpjMtRHg0IVVyt4wutemK7JN0KBhm06Few+HE44A41FZ12/uOoe5i1
 xfo6zpUVEgJl+WmLK7KvIi6CISeWfWgwMnGPzl+NAYSRqmiI7yjf0Ihbtixq1uNF
 NTeXgVHKjkwMXm9uzhMeahEC5NNhZ/EhJkg7/dPRkVq4TPMTpMcxUWT8Z/qk2Llf
 fESGFZWLTkwhGlG8dND44g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762869355; x=
 1762955755; bh=ES5jXDe7pTBDJpJhzmFNmxdBF+D2nKQ0PK45UfOXEYA=; b=y
 52dpfkW5G1rsD9aXfgYwAWzsxsFQf7ArNWRD4dNIcLHm05J9El93AVJFrMkJaLQy
 FTzzxMxHWXDrkCR6NF44/XfisdQQC3av/JDOSL3lsT4n+U1UlGzHlA1uoLl+vzMB
 T8th+YQI2Ols/TeKudeHQUQdWsIZjqkq6077itfkRo0yjk+TJ0PEcfVNhuUlHj+2
 AR4FuVpd3nETOJH8R8yn6iTLWBLMKksUHJsh4b0mwKIPAIFhThBwyVm/dfXSYZaz
 vYtyBfpeWzwgPNOBCqqB948w7XImAvvjIxVsdSWSFKfQZ+n91I4NmgYmkgL8vJNJ
 TkcyhdzFsL8MDgX1hp+dw==
X-ME-Sender: <xms:a0ATacUGBB2xGtn3YlZQN5OBsXpt-WqUd8JGHaIcsCuDzxpJzqi5yA>
 <xme:a0ATaU7L_6mU7WSaZvX-EsStOnOvSRDFotKDAkqnTqv6mxoaa7YUrPATi_H1FFQr1
 6UeZwvzRf4iQ7zKnsT84BFKRDq_5Y5QhiRTyyqtajD5hYIePs9nAw>
X-ME-Received: <xmr:a0ATafhWDh5vZVBGJs4HuMSOkr2A56IL-SvfU06ZPQrAfkKhpWmPhCu3IyyP-NcQ4iqq4yeVBrxP7_QbW92Pds5mtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddufeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepvhhlrgguihhm
 ihhrrdhmvgguvhgvughkihhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:a0ATaTfPr5xO0U1tJ4K1JUQ4Wf4JoHWTOEtcU0hisEHyY6Df-tFDdg>
 <xmx:a0ATacesOJjIpkguMufIjmL7XxsCVmsKBdUPiN6o1_XG3a34ZNS0og>
 <xmx:a0ATaV_emn29tZQzYzU-2VwhiOQTzVZV0z-LMPQPdX9p7FW4OG79gg>
 <xmx:a0ATaQmEr2riHFLEYKV0GwMNMv8cq1dFdXZfsHmnMi1v624b8cA50A>
 <xmx:a0ATab1bcLTiN429ESfzr8l_tIlpHcPmMVDcrQkBPvsaFiVHUeKtdBW_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 08:55:54 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH dpdk v3] fib6: implement RCU rule reclamation
Date: Tue, 11 Nov 2025 14:55:52 +0100
Message-ID: <3284089.CFs8Y8CuNP@thomas>
In-Reply-To: <909f51dc-aa74-4cdf-8799-13c7e777117f@intel.com>
References: <20250610145341.38271-2-rjarry@redhat.com>
 <20251028173703.548656-3-rjarry@redhat.com>
 <909f51dc-aa74-4cdf-8799-13c7e777117f@intel.com>
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

> > Currently, for the TRIE algorithm, the tbl8 group is freed even though
> > the readers might be using the tbl8 group entries. The freed tbl8 group
> > can be reallocated quickly. As a result, lookup may be performed
> > incorrectly.
> >
> > Integrate RCU QSBR support in rte_fib6 objects to support safe tbl8
> > group reclamation.
> >
> > Signed-off-by: Robin Jarry <rjarry@redhat.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied, thanks.


