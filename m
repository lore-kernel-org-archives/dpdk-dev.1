Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E72103A9AD
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 11:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8209140E2B;
	Wed, 25 Mar 2026 12:45:36 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 52D08402CE
 for <dev@dpdk.org>; Wed, 25 Mar 2026 12:45:35 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D7C7114002B6;
 Wed, 25 Mar 2026 07:45:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 07:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774439134;
 x=1774525534; bh=Bb4uSZGXCJo4xsHtPTx8R3/7igQGKFiFJnzvMUR3DJo=; b=
 H8CVmBeWRrMdy16latX2GFpXfWRdM9P81y4g9n+2sTLRrGnT6gmoMshgULVATUNB
 gEp+EC6DbGzWFl2hXwanKWd+5uueu6ulfdIUL96L6G/rav9m2TJpz8WMBzXeoQkZ
 1CpeqTxI+l2nSEsyiEkfsJjoUCZ1S2kmtZxrILVKuLggJ7LfrVwbr1iH7+4gD5V0
 Zx81egCzv6Q9mfj8AnLkAZsAMZarP5mSBN2iBqJhakOh/ybrV3+JwuCfwuCPjkzG
 RdjPL/gsUndSPS0ftWV5WzvQuuFN9GwQ3POW5niXkMqOYXusu+vULU8ZashbPWL5
 IXMlQwuKg/P4whIYQPw0Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774439134; x=
 1774525534; bh=Bb4uSZGXCJo4xsHtPTx8R3/7igQGKFiFJnzvMUR3DJo=; b=y
 yLH3PhS4fYikmRSWomkecspd5LoYv3UYn6jegCo3UrQ8uN02edbu02Uow1lW/WVW
 cVkoowac6a/BY8OWbb+8iu8nNMVAG/957yw5erfAZ5avJAaTsx7pafUrZSLRTdV3
 95K0YEUNDpFza35wmWpWeiM+tbwnoeSy8uaOqJJuiubxkZ332E6www72j0FXh2Mn
 6/wZ8CYiqs9OMogT1ZK3TLkF2Q0b14YyT2ezUYx1aJ+RJfFNWNh8TUQRc6ZDxKek
 jvWQmDG8cbunhSuK1E/r0rOvTRThMTCT1NnfLJXkDVK/GnLqw5WSEXLlTIe++Sq3
 uCpCGEXREgTWP4mTklQxw==
X-ME-Sender: <xms:3srDafEJVwezIiwnqLwYLNbqF08NNDKnTg_Cnkj-z4NBRdoocti4YA>
 <xme:3srDaYqu1Dwy7oSVNPbNHmMxWG07wG65RGaYX5_fq-FvXIi6nc3KofcH0k6Wvl0mj
 iE_q-L5yC1PAHWE3e5Bswnvjzfw7tZ9IvQs48gQgpmUitdq1FGsHw>
X-ME-Received: <xmr:3srDaT5WlZ1vMQLX1Y8uO-LJ8Oro8g5e3FvmfFl0HR7uh2ClhrRwF4fevoQfgddC7L2GoUuaaf8tl71uFd_6Uu8QBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegfeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:3srDae4LzWG_GbxzI4chSOBuP4c3LCobrZPVWpMuFvaSmf3eOsHNkQ>
 <xmx:3srDaYHetnQ7152Ex00JRWd1i_1eOj7XmsHo7OX9dsr_TgbJx9yAXg>
 <xmx:3srDafTriiIshf0ZnkQfyGhHdfmp5WJU60t8wk9bvX8T8PAtaeVdng>
 <xmx:3srDaZss2otXTqXe8El6vIuxf7xvyhzR6JvHlsdsvlfZM4BP3OuP5g>
 <xmx:3srDaXk7xLRvlcUgTxUzvaOFcVDY0sXhWLpWe9VSKdIZ8LLzWzNL47ri>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 07:45:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 7/8] doc: correct alphabetical ordering in ethdev
 toctree
Date: Wed, 25 Mar 2026 12:45:33 +0100
Message-ID: <4501086.iZASKD2KPV@thomas>
In-Reply-To: <20260128194722.480862-8-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
 <20260128194722.480862-8-stephen@networkplumber.org>
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
> The toctree entries should be alphabetically ordered for consistency
> with DPDK documentation guidelines. Move "flow_offload" before
> "qos_framework" and "switch_representation" to maintain alphabetical
> order.

Many toctrees are not in alphabetical order, but logical order.
I think we decided alphabetical order only for driver lists.



