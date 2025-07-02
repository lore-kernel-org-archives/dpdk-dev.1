Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB933C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 10:00:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A93A40A87;
	Wed,  2 Jul 2025 12:00:40 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id 55626402D4
 for <dev@dpdk.org>; Wed,  2 Jul 2025 12:00:39 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8F1AC7A026E;
 Wed,  2 Jul 2025 06:00:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 02 Jul 2025 06:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751450438;
 x=1751536838; bh=o3QiNuqiQq42vkwb1Z/5EeqTi/DBEfTN8UTPbnEkIvg=; b=
 c9cv3ag2cf2+FEBvBFNUn1O4YBtsVowxeNcjyAOSsMsFdJA+toSd81Dy8Kidz5WG
 MUEJ4pq9BMXlgN8UFzVlDMDRyksi4zp8LoWpYPkprxxolOiACIR9IGHc2NwHseZw
 um3NiNQPbBeHDbKcu+sdjYC7twvH3zHSyITZT1BVWuXnRCMakMxTnLJfr0G5MLCg
 q9td+oo8UbKBMUz13lb81mFZkwTlOrYKtnidgrfOtffmG/ARBJ7iefAJASwpHYoI
 SDN+F/IyLArKgyGmXy9X8HUVGCqBsxkkjb9bgr/Oytf2GefR0k7eNulzS5x5y08o
 spt+B1enSve1vpeYw3lbQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751450438; x=
 1751536838; bh=o3QiNuqiQq42vkwb1Z/5EeqTi/DBEfTN8UTPbnEkIvg=; b=b
 xgBSPZYxIH3+kadgbLOi+iJcj69RgxbteqGMWQGtx/SwAPiD52hiWl7wZzLccDxk
 nBg84j9FhQEhHOvT3/s7vxFan9yPHzVth2OcAVWguyN8Tik4U84VJmpiDvx2j7NK
 elCpEOTtJpVy04wpxopmxZg2r3wnNfkmkxwHbiYBcBDoKrOJeS0Ef59+YwC47KXp
 exdv2n2uRCvsnjZlGBNtxcqoVayjYYRxFhKxJYOezNGA3Iji+vFAeIWuwzavx2vU
 2r62mPbsYrrHerZ8RFM574L7pJI9MRyVc8rwkApfhJWPl0T0wSXnja9u3y7soeEm
 qV7KURDsKHdfFKeHnvKnQ==
X-ME-Sender: <xms:RQNlaPhjSw-t0SuMd7Lk1LjppIB2fcLqPNumwJto8a_UHURAZ0GsCw>
 <xme:RQNlaMB8gL_bDw9CHephBI13zYBQWcyv05J8ywvtVRXY_8yWeEVrmo8lCXoeizPyz
 5sr6dSPjRoNJPYqCA>
X-ME-Received: <xmr:RQNlaPH1KXL1qJJp87h3iTse7-XGBwym54yBqHPmE9phSOKTFKqopVJo2EN6oNm2meiJ1XfT2rSyQQiHmzQZH_1vnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnse
 hinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepnhhsrgigvghnrgduieesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RgNlaMSp40vfXO9Z1HpxnvleiRY1yBjnv5SXxwZNca0-HfM59sgEeg>
 <xmx:RgNlaMwkaY9rRMxVYegewW3fMyJhTEwOOYDpV5oh6F9jD1P-BKj7xg>
 <xmx:RgNlaC6Pytvw_Tqg3HdW7QSE5StZfTk7Ysap7wwfLXqLio5Qb9mVjA>
 <xmx:RgNlaBzc5-Z6FjjwKTPQmTorYn-i9eIDzbAP4yGsbRqZHYwyVTeB7Q>
 <xmx:RgNlaKgRBVg790S8KaH3Pc_CricZvYZ5b3ZkIdZyG6gol5TxbnMDaJGS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 06:00:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
Subject: Re: [PATCH] node: fix C++ compatibility errors (option 2)
Date: Wed, 02 Jul 2025 12:00:35 +0200
Message-ID: <9169126.6MygDL6H9D@thomas>
In-Reply-To: <CAG6-93xWTK=mWb2Y2jjQgJAFjAE83vMUUexmP=GX1BN4s0NvFA@mail.gmail.com>
References: <20250630105025.2265901-1-bruce.richardson@intel.com>
 <CAG6-93xWTK=mWb2Y2jjQgJAFjAE83vMUUexmP=GX1BN4s0NvFA@mail.gmail.com>
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

01/07/2025 16:48, Nitin Saxena:
> On Mon, Jun 30, 2025 at 4:27=E2=80=AFPM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > C++ does not allow zero-sized unions - they end up being of size 1-byte,
> > which leads to C/C++ compatibility issues, flagged by the compiler.
> >
> >   lib/node/rte_node_mbuf_dynfield.h:78:2: error: union has size 0 in C,
> > size 1 in C++ [-Werror,-Wextern-c-compat]
> >    78 |         union {
> >                  |         ^
> >                  1 error generated.
> >
> > Fix the error by omitting the persistent_data field when it is
> > zero-sized, since it's unusable. Any app using the field must already
> > specify a size for the persistent data.
> >
> > Fixes: 746e8736da70 ("node: add global mbuf dynfield")
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> Acked-by: Nitin Saxena <nsaxena@marvell.com>

Applied, thanks.



