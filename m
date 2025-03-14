Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5BC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 14:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A30A040289;
	Fri, 14 Mar 2025 15:24:42 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id AF54F400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 15:24:41 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 109CF1140190;
 Fri, 14 Mar 2025 10:24:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Fri, 14 Mar 2025 10:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741962281;
 x=1742048681; bh=tST4Qb95COhtw+iUA1S4gcZ/91IDub5jSD3v1VmdPV8=; b=
 dSHaJunyNunCmZLv0P0F84B6srsSsKkA5ivk6UVE6bUWFyphPsELvHBifimBBGcc
 CC6aPl7E3eYquXi4qnER0KnBV8rqeFM10c0vVYDKE2LuqVGp6g1sIOEHwdrjb+2s
 omIhCenBS5bmZyKiEqHHJq3fwo/O1QLABQYeqRr39zKjSmMCdlf253LCInzGRrZI
 wYa4VT6kaOjM06wZ5w6TlvKl+LBmaBUs0LljmqFVjtwTSRBonVpqk46SSSg5uHAs
 cEf20NJ669JmpgeafB3Qqkqyr2rf3NckclHTNT612GgOKmoGFnG2SbZAmGnigKhY
 R6qpLcb3+r/Jo9ilhU1p5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741962281; x=
 1742048681; bh=tST4Qb95COhtw+iUA1S4gcZ/91IDub5jSD3v1VmdPV8=; b=G
 BVJxVkoHDYh0brw6RbSvfsvTm43bV9OYKP/TbtxoxAVaKdg29PV6HPgwp63IQlnO
 jWlKfiTdt1C6w1E//2Q+rzcKBxE51RSIAnfNXzQHhLkk2zV7ky/ZEguGhQuj9qCH
 tHC2rge0hjf2+dDchKPnpMP4vUgFzKoEErkOlH5EBSkrQjRHPt3CFaNEKJJKRWgu
 VRqXRxFL/bENjg8Vm0BaoxDJCx0DP9LQtO7u8qyr7YkRuWFkeMxd+LPQTwlNknjE
 yChS1aVdSMk39Uxb9gBsf6uuo+2Soutc1DMHZtLNsVf9M+qVcAXlY5rb1KELb/TS
 14VZMug7FMhEPoJhQWGEA==
X-ME-Sender: <xms:KDzUZx_rTBY7b2QEP06yrx717AlMltaO02T2RSneUVBAqD85r44fqA>
 <xme:KDzUZ1sSiISl3o6Xvp-nDpX9MdcKeqNzwz55FFd4-Ri8UiLyOBGjW1Wml0q8NKqP-
 4t8u9_qV29LSAbmLg>
X-ME-Received: <xmr:KDzUZ_DqsXvG5hLYKgcoTy4S5uGDGMwx5Vncq0q-qKt7ZS41wPRn7A1X6AeUcel1Wrc0RPlJMFvoK6UTrT0qcOZiaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedutdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmihgtrhho
 shhofhhtrdgtohhm
X-ME-Proxy: <xmx:KDzUZ1cU-H2h7qMZoJ4_ZaGQiBR-zJSppPxXuWSwLmGs2ngy_W5uEw>
 <xmx:KDzUZ2OXXvNnVywHD2scKieshh06Cxakn7X3ir6AvtxGztulZRsk5g>
 <xmx:KDzUZ3kDdIV2hYakzDNHmxe3tbztm68hEkWS8n9kgZRkM2Hzu6KhUA>
 <xmx:KDzUZwvCraETVHJhfua7X-t7uvpJJpx_jiGFGFGAHQMz2vcpejh6Pg>
 <xmx:KTzUZzpnc_jKTIdyGkmG5F5pHBPsJzl81Vt_w0iE1TXfj70MTbeaLH_A>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 10:24:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com
Subject: Re: [RFC v3 5/8] build: generate symbol maps
Date: Fri, 14 Mar 2025 15:24:38 +0100
Message-ID: <3431217.izSxrag8PF@thomas>
In-Reply-To: <20250311095609.194523-6-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-6-david.marchand@redhat.com>
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

11/03/2025 10:56, David Marchand:
> +        if is_ms_linker
> +            link_mode = 'msvc'

It can be MSVC or clang.
mslinker may be a better naming.

> +        elif is_windows
> +            link_mode = 'mingw'
> +        else
> +            link_mode = 'gnu'
> +        endif




