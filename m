Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4826CCF2563
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 00:07:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 201ED40289;
	Wed, 19 Nov 2025 01:07:37 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 282544027A;
 Wed, 19 Nov 2025 01:07:35 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 3BC0D1D0018D;
 Tue, 18 Nov 2025 19:07:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 18 Nov 2025 19:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763510854;
 x=1763597254; bh=Wi/VUKR4+GEEoCfHlg9e6sKXGLA4wQpgw3Ze3vV+b6Y=; b=
 rNmj3J+JvY//YWnvC57eO462oJ1f+zLhJikkGZjYRsHOarQSUyFPm7jtJPIAGOMv
 C6SldYFlCchMX8vQ/q5m8sbtlKwibQFSZUv+SnxQqNesSmo5awevDaN7HyShdDjZ
 1zob+QF9jpFAZGQkL1gwVKm1SRH7Acrt3UZkeFWmHQ9tmLAm8DclCSU76WZJuA0b
 RghmXUza/jw6OoVywXywcVDgHD8QB2wnGzmYdbk3QpPWugL6nxE8z8ydYp5VJ5//
 DMwGTbbUD91rH2BfpkGHPYEwpjXlcI5+mvjDdrFiWR0s8KihBsJlBTeHGsAyczl2
 u/eNZG7f58gA+1LmJ3uptw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763510854; x=
 1763597254; bh=Wi/VUKR4+GEEoCfHlg9e6sKXGLA4wQpgw3Ze3vV+b6Y=; b=M
 ThA0hNvZ96QJwtsBy2RXWcdLA6gThYi7CScocKNPkiv4VbhVNgypIzub4rF+k9FI
 aii/j4bRLQnMEPtkPpTclf3NcjSH+7Fn7mqanH+mJ3XJDbxqW6tBcdXidwxydaKo
 pZdr1+VZz4fwdUXztmgeGdX5y73VKBxAsD7KGlpeXpSLNGW/dD7+JUzMCtsjFfCs
 qHGZyJr6ec1nCv7LZ+YZaZFXtFdY9OwmRJSq3IS1Q7Lu/OyIb4RGpwkivFQPc1PY
 XjQzMw1AN6CcfzjuHc2Txjb9cOgLo1HPTZ0XKSsConUUbXTrVYg0FvDJAkCBfCNn
 Yvux69AXgqHuaqn/9D6aw==
X-ME-Sender: <xms:RQodaXilVAyNk6s4QeRJ6ZyB1aggRVK-ABj-GKJ1Bgv_j7tUvYk6GA>
 <xme:RQodafeR6jX_xzKdI5sMUiZ2dL6wl2b5i7j6tljSDuJhZGcCUDA9Nx102iMtOyC6l
 Z6ebhplZuhm4wXPx9h5Xt8c1UOicgTLmGZEtIiDHU0u53jfEB_p0w>
X-ME-Received: <xmr:RQodaakjo_2dqTSanM8H3JbMKK59skLeRIUvvrZTJatIbtsJIqd09QK3Eo2PQItrAR7XasJ_sfhdFZBiehVidg2Fxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddvjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopegtfhhonhhtrghinhesrhgvughhrghtrdgt
 ohhmpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomhdprhgtphhtthhope
 guvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:RQodaYvreBneq9QjqVrlLvC6m_ApFYebWfPjZZNugTAvFNfU6CSF7g>
 <xmx:RQodaQ-_Uc1Dvz2VGF97cU2qfAnIPSp9FazNKFkKQbZ3vgMi50xPoQ>
 <xmx:RQodaaP96ob4icmqdusAyNHdEKjT2P5FvtfUVnWVc5yu5eILwRrreg>
 <xmx:RQodaWEtSPN0cMEtT_tdc77BW-JVWUL8xXF5hiMtB1C21Alc3EhelQ>
 <xmx:RgodaVQreNF9_qqs67VeosfT87zo1WVyiJekvb820Arp8gc05v_6qYgK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 19:07:32 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Christophe Fontaine <cfontain@redhat.com>, Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH dpdk v2] net: ipv6 link local compliance with rfc 4291
Date: Wed, 19 Nov 2025 01:07:30 +0100
Message-ID: <3249247.iZASKD2KPV@thomas>
In-Reply-To: <20251118174526.321856-1-rjarry@redhat.com>
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251118174526.321856-1-rjarry@redhat.com>
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

18/11/2025 18:45, Robin Jarry:
> From: Christophe Fontaine <cfontain@redhat.com>
> > Modified EUI-64 format interface identifiers are formed by inverting
> > the "u" bit (universal/local bit in IEEE EUI-64 terminology) when
> > forming the interface identifier from IEEE EUI-64 identifiers.
[...]
> -	ip->a[8] = mac->addr_bytes[0];
> +	ip->a[8] = mac->addr_bytes[0] ^ RTE_ETHER_LOCAL_ADMIN_ADDR;

In all other places, we use the operator OR, so I'm not sure about this XOR.
Also, rte_is_universal_ether_addr() and rte_is_local_admin_ether_addr()
are comparing this bit with 0.
Is this bit always 0 by default in MAC addresses?


