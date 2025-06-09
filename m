Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7540C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 09:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE14240661;
	Mon,  9 Jun 2025 11:44:41 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 5F29840658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 11:44:40 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id DA99F1380501;
 Mon,  9 Jun 2025 05:44:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 09 Jun 2025 05:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749462279;
 x=1749548679; bh=V4e3LgVt1ah+4T9nUMDHkrIWDor2h5xACohnRtsf3ag=; b=
 kFDxdK2t67z4aHBdKUc0myD4N9Fnwl7IMGpmBLO4J9SUm2L5RsrJzEIxHCxjyuzh
 uCCBrhKqv40Fygjql4MPTIsxFZupkx18MH2yZJC0Fa0SBJEUMJwqiTpYEZEY+Biu
 DEw36MltF82xaUz+rvAkVNy4fL+exSxDcOTY70Wod7EAaWS9oRfTYU7jsqWvLNZ7
 gl8VI9ZEXMRHeyMDrmXiSe8SSkPk1syETupGgqg/lBobePhxDVCUfE1HAJs+OGqB
 hRgmBpbzSxKRfWdsYln2XUMTD+OdcQBu4+8j32R6LdpAk0VhS2mwY0tDCAexT7BT
 0kNTG9ljG37nEhf5irKCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749462279; x=
 1749548679; bh=V4e3LgVt1ah+4T9nUMDHkrIWDor2h5xACohnRtsf3ag=; b=n
 CzWr71Ii2Dy1H1QFFK+v8XgNLDAQti14tLFQDAlSLRYKSUuwf31/cZvwGcDBMzgl
 oyEXIXhswBxusyxYubjGaMu8vH8juSCaEOvp9aXRg9WAlsMi0G5amdf4f7jIS3w2
 fVQfGYFhuOrzOHNjWwp5PCw3zYLSsd9SeRAY+qvTa2A68nUWsjg1QdDFkURJBPDN
 Ir0esT6Rno+2Jtb09erg3cMa43S5MUg0HIdaGz+JtmdlFxadKCxG/6/jrypQhyIL
 jK8Tb6rQxQEd9M+xtUWvGeFF7RI5bm9x47GRa/AVj0Lwy9I735nTp8u15XB20m0p
 JjL6qgb73/l7vMnqmyZjQ==
X-ME-Sender: <xms:B61GaLnh1pVD0ChBr_DlIbw31f7U_KmjBZ3GjIeI8JdBniD7pZtyPg>
 <xme:B61GaO1tzKfce-xWQjn44kB7uAhgw5u_mD93SIbQhNOF-UM9dI7fIbROniyvRD2VT
 p2D16Ne5JfppeLgsg>
X-ME-Received: <xmr:B61GaBoUqvA9O7_6y2hT9MA8fq9cE-0SbxPCUMCVJFRreW99-rUsOkALTn_jlrmwnGwx4Srxv-Cn3i11Snqb7XzTZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeludefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeekkeelkeekueefhfevledutdehleej
 jeeifeejudehvdffvddvtddtveethfegueenucffohhmrghinhepthhhvgdrtghinecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghs
 sehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
 houhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgt
 ohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiug
 drmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgvphhhvghn
 sehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehprhhosggssehioh
 hlrdhunhhhrdgvughu
X-ME-Proxy: <xmx:B61GaDlXVZ-76Nf03Dx9xt0nwy6-BKEwzRGkwajLUVZSBzPtvOHYXA>
 <xmx:B61GaJ0dg5aB027xNai0BcYPJ6AMwobMi6Oreq8ngWq_A0TloJnL2Q>
 <xmx:B61GaCtGEdZmtctIX2um9wcVyrSs4Z9CfATFIOyuRVZaspmzPOn_LQ>
 <xmx:B61GaNUTpxZK2LCySyZGAzspH_dJS2AYCqO9NQtUunClEwJAXG5LMg>
 <xmx:B61GaPVRU1UcK8yw0mk4BkKj90vWwz7zqmn42cRT-E0j0BnKjx5wTNTv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 05:44:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com,
 Stephen Hemminger <stephen@networkplumber.org>,
 Patrick Robb <probb@iol.unh.edu>
Subject: Re: [PATCH v3] build: automatically report minimum meson version
Date: Mon, 09 Jun 2025 11:44:37 +0200
Message-ID: <9943152.lvqk35OSZv@thomas>
In-Reply-To: <20250515134647.932537-1-bruce.richardson@intel.com>
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
 <20250515134647.932537-1-bruce.richardson@intel.com>
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

15/05/2025 15:46, Bruce Richardson:
> Add a script to buildtools to report the minimum meson version given in
> our meson.build file. Then use this script in two ways:
> 
> 1. in the .ci/linux-setup.sh script, use the auto-determined minimum
>    version to set up the CI, rather than hard-coding it.
> 2. in meson.build call the script to report the version. This serves as
>    a sanity check to ensure that any changes to meson.build file do not
>    break the script.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>

Applied, thanks.



