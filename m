Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498C4C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E29240292;
	Mon, 16 Jun 2025 09:03:49 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 8BA984027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:03:48 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CC7CC25401AF;
 Mon, 16 Jun 2025 03:03:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Mon, 16 Jun 2025 03:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750057427;
 x=1750143827; bh=uRYXK7NcxSxJomTRJK1pPebSlUDXB3u6VG6rfifUGKY=; b=
 fkE14qntWSfv3PxwXCNiGaSiRbFzv77qxaK57It6A+31ijdRzGb7094g3OkCFBGm
 B68cGiIt6lOmNWb5qwizldUeDbn7y5T9/I9viKu+PG2Eah2wFVJQfY+78IlmuDfj
 yxVgKvuibEK4eM5ZlxJM7fp/4jRfl0Sb8z2Drj9s24VeOknDSrjdr79Qr36HR0Kh
 mrFgYe7ikbnMpxwBGaW1aUggAHLrW3pZ7IW8jABjFqPnq07Vd7elKhv0dtFWHpVZ
 lHuO8kkupRUFtyGdHA+tLDubLQ5PYIsFS6dciAzs44bHxq/guDyrUnstdPAC9CW0
 6xze2MPglp1gSj9oz7zfgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750057427; x=
 1750143827; bh=uRYXK7NcxSxJomTRJK1pPebSlUDXB3u6VG6rfifUGKY=; b=B
 f3sBpcEjDSh0UOy7YXjqTw9rcXXNLVdte2zFo+B52kOEqNItXaWwMHzyX9DWfD/U
 7hTY2opXqfFTecYbUbOkOw0JpLheR3WWP8LPSOUV5MGqDH6ggeh0JnZbkld0hROD
 o/iVvaZzA0BRoAQlTucN1T0wUDudbRGeH/CaYIYf3Gd7Nfm4vX4Czx9FdVN6o7z0
 yPGJWj5S06pxtCvnpTNrFyzM1G1rGcftj3KdqtyjFBNL48rK3DkTB0yqoo9n1Toj
 BHipJ66W7lvV/ZWeZ4uGgGqllOOUUbyqlyFgoBLP5/I14l9y0/hgahWXj2DVCxW/
 TPlfS5Q1W7oI7qX5+5snw==
X-ME-Sender: <xms:08FPaIlLzm0dYdIs8VHdXR29nyDvnTxcjnIoOqzsBzdvIOQbEegqjw>
 <xme:08FPaH1b9dAbPUWMJZSGgGloqgoW23f87n7Z7vnob1MG6xYKBH-xo8iNqz7sxnb7e
 HZbNiFB9M0aUvoksQ>
X-ME-Received: <xmr:08FPaGqaRh3zeCYGL6wKecU5N3Lxo5H5wFmK72-aA37oAm8euMG8kYhCICwQLiBIgpotv7QfsvQaqN_w2KTEN1bc1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvheelfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthguuh
 hsiiihnhhskhhisehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrd
 gtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:08FPaElnZnCf2nvcLw7q5VfUe8au62oUgmYZG8zWvZY0cg5Y1bxd6A>
 <xmx:08FPaG1U9Z0v1j3JDYRj9eK1I9zsH6AFeT0eUAW98ODWus-V1DvSJQ>
 <xmx:08FPaLt8sYadwU3PrVtpMEf_H6bgnBB-zuk6nroK1_RbEiBiXlcwEA>
 <xmx:08FPaCWvo2gazbtdzuAyqBtv3cb9mL2wfTVL4gAkLVA49waZsg8VwA>
 <xmx:08FPaD1zPwdrykEtKMMS1k7qKiwK8w9Ui2bueltFWB3uTgzYpXtxHzbX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 03:03:46 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 jerinj@marvell.com
Subject: Re: [PATCH 3/6] lib/pmu: reimplement per-arch ops as callbacks
Date: Mon, 16 Jun 2025 09:03:45 +0200
Message-ID: <6962805.F8r316W7xa@thomas>
In-Reply-To: <20250616065341.3233106-4-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250616065341.3233106-4-tduszynski@marvell.com>
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

16/06/2025 08:53, Tomasz Duszynski:
> +static inline int
> +pmu_arch_init(void)
> +{
> +       if (arch_ops && arch_ops->init)
> +               return arch_ops->init();

These are not boolean values, please compare explicitly with NULL.



