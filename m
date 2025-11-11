Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A171CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 20:45:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28A2940280;
	Tue, 11 Nov 2025 21:45:12 +0100 (CET)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id B856F4026D;
 Tue, 11 Nov 2025 21:45:10 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id CA71D1D00147;
 Tue, 11 Nov 2025 15:45:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 11 Nov 2025 15:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762893909;
 x=1762980309; bh=EnZqFxgQjvvqBOvzO9vVTormV5a6taj99PcawpohHTw=; b=
 EMSNtAtRHGN3Sd9oW5CW3fyoigSYYWUtvH4CZYkF4EH3BSCfy+2BTWF2STQdwxYe
 UQlx3NmFUaSv4gQaAqyRHyrPPM4f3j2X4cUZk6vMvjdiJ9PKGi2l/Xl3EKfb4N4f
 bo/cd9ik97G55EAGN6lt0BMDgOsiy8/830Z/3r6axqz1/B09LoAuCz1u757ghrum
 aegUPriSQmSuQysP5AktqeMyigQ1EjH0VLW/PCbUtSnhNR7Mnn9IIl6W3UWBfRPh
 uwPWJdcvy3v9sbcQdj6Ehrxb4U9ZmIY3QGNGeCwov7Rtv6fGFLUM+fHtieZcczNJ
 UFLCHWEobnidzl9VKClxDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762893909; x=
 1762980309; bh=EnZqFxgQjvvqBOvzO9vVTormV5a6taj99PcawpohHTw=; b=Q
 BiNnq76r6LJK7ptEN9zOb89tpcSajTIvS+eY7Pav018DY3/AvfmwPfwwZWbu7UlC
 2aQt/R0DjW63XDq968000ZWAvJL6NlzDIkQnwmnwJcqSOUnp1XJV8V90hSgEEOVE
 0/ktEh5a7UVV+L93p5DqKMFum2D4mkvbXKGLdylctDd8gTnoN0utHoaoqgIH37Nz
 eoPPQYYCq4Xqx9Y5KsJonmy6kpW0m+sozbj1DNqNLdk0W9ENs7mtceQv53cPfLro
 g8PQMN4MCidznjHLyhii4+aqLwID1cqtQvutWzJQ/cYj79ovCz3YXgtGyQ0YxTcI
 nhNT82kOFwWjVYXGb2f2Q==
X-ME-Sender: <xms:VKATaSaJt5KO7jUrVzkSLd5MEENX5TLOdB0z5oF6f0O035PBELkOWg>
 <xme:VKATaRaHHaG0pq9XHNFhVqg7_uYpwXlb25TlFzxmSmbzJe-B86UxOEjjmJaC6Jfzx
 AAyOStOLsV-AEE66r4AmLpSY5RKV17oTqzQwal68cxP8XCPP5dteg>
X-ME-Received: <xmr:VKATafKY-z9ZAyIJMXxxcRRH3In0cmLqt4OSlWv_N3tEnLLFVCxFnSDQIZbM-m2Axp5-p1lL7pGJTIjaaxvnDiYVyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghthhhsrghlrgdrvhhithhhrghnrg
 hgvgesrghrmhdrtghomhdprhgtphhtthhopehhohhnnhgrphhprgdrnhgrghgrrhgrhhgr
 lhhlihesrghrmhdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhi
 gvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepohhlrgdrlhhilhhjvggurghhlhes
 rghrmhdrtghomhdprhgtphhtthhopehsthgvvhgvrdgtrghpphgvrhesrghrmhdrtghomh
 dprhgtphhtthhopehgrghhuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhtrggs
 lhgvseguphgukhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopeguhhhruhhvrdhtrhhiphgrthhhihesrghrmhdrtghomh
X-ME-Proxy: <xmx:VKATaVtrVVdiRzJY0QYGarU1fuMMdnR79-WP0ExrmpqEfyHfcz7qtQ>
 <xmx:VKATabVM1FZL_Es0o0mf1i_bXvgvr1GSEwZbJ-o9GZJd64xxcxh_zA>
 <xmx:VKATaYj8t2-s-KW0Cf2OYWjBrgvYM-46-2DhQ5mwM_W-D0cFI1yySw>
 <xmx:VKATabrlGB1Kdimsw8j7obcpMciCgFNJ8rduN2aeu3RDNFXegDk_eA>
 <xmx:VaATacLZB3GJGMxz7fyciJky3pJyXUPRAIedjLvrZEJrM-UuNlcHC7vB>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 15:45:07 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ola Liljedahl <ola.liljedahl@arm.com>, Steve Capper <steve.capper@arm.com>,
 Gavin Hu <gahu@nvidia.com>, stable@dpdk.org, dev@dpdk.org,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: Re: [PATCH v5 1/3] ring: safe partial ordering for head/tail update
Date: Tue, 11 Nov 2025 21:45:06 +0100
Message-ID: <2454376.h9gRbJKcGU@thomas>
In-Reply-To: <20251111183720.833295-1-wathsala.vithanage@arm.com>
References: <20251111183720.833295-1-wathsala.vithanage@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

11/11/2025 19:37, Wathsala Vithanage:
> The function __rte_ring_headtail_move_head() assumes that the barrier
> (fence) between the load of the head and the load-acquire of the
> opposing tail guarantees the following: if a first thread reads tail
> and then writes head and a second thread reads the new value of head
> and then reads tail, then it should observe the same (or a later)
> value of tail.
>=20
> This assumption is incorrect under the C11 memory model. If the barrier
> (fence) is intended to establish a total ordering of ring operations,
> it fails to do so. Instead, the current implementation only enforces a
> partial ordering, which can lead to unsafe interleavings. In particular,
> some partial orders can cause underflows in free slot or available
> element computations, potentially resulting in data corruption.
>=20
> The issue manifests when a CPU first acts as a producer and later as a
> consumer. In this scenario, the barrier assumption may fail when another
> core takes the consumer role. A Herd7 litmus test in C11 can demonstrate
> this violation. The problem has not been widely observed so far because:
>   (a) on strong memory models (e.g., x86-64) the assumption holds, and
>   (b) on relaxed models with RCsc semantics the ordering is still strong
>       enough to prevent hazards.
> The problem becomes visible only on weaker models, when load-acquire is
> implemented with RCpc semantics (e.g. some AArch64 CPUs which support
> the LDAPR and LDAPUR instructions).
>=20
> Three possible solutions exist:
>   1. Strengthen ordering by upgrading release/acquire semantics to
>      sequential consistency. This requires using seq-cst for stores,
>      loads, and CAS operations. However, this approach introduces a
>      significant performance penalty on relaxed-memory architectures.
>=20
>   2. Establish a safe partial order by enforcing a pair-wise
>      happens-before relationship between thread of same role by changing
>      the CAS and the preceding load of the head by converting them to
>      release and acquire respectively. This approach makes the original
>      barrier assumption unnecessary and allows its removal.
>=20
>   3. Retain partial ordering but ensure only safe partial orders are
>      committed. This can be done by detecting underflow conditions
>      (producer < consumer) and quashing the update in such cases.
>      This approach makes the original barrier assumption unnecessary
>      and allows its removal.
>=20
> This patch implements solution (2) to preserve the =E2=80=9Cenqueue always
> succeeds=E2=80=9D contract expected by dependent libraries (e.g., mempool=
).
> While solution (3) offers higher performance, adopting it now would
> break that assumption.
>=20
> Fixes: 49594a63147a9 ("ring/c11: relax ordering for load and store of the=
 head")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com>
> Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Series applied, thanks.



