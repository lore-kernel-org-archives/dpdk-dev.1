Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088AECAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 21:31:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D837402A9;
	Tue, 16 Sep 2025 23:31:41 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 1F05840288
 for <dev@dpdk.org>; Tue, 16 Sep 2025 23:31:40 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D4FD07A0147;
 Tue, 16 Sep 2025 17:31:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 16 Sep 2025 17:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758058298;
 x=1758144698; bh=AenYQRTXLmZU8nN3YRqPQ+Ns6w/g2Jfm6+YQdkhMjTA=; b=
 gpxKXfq2ONSSmOEz6izqPgO3FImyteZW2T2XpTtchGTAHBt+fRDKsrC+4G6QvZ3X
 iIvXBwTBFmIAKoqMyggUiDw4ByVDjCiP2b2eS82YM6GTIUZBlKValbWKQ9uLXRCb
 kexnd9Nw8xHtM4sc8HoQ0kLjNu2MV+Jkm8ypdisIe2SxYjTVqkrSVeYFphP22CLH
 1QlvxKEStt9ELbmYpJZCzi6+V5gCFSt6ptJpSAESUwx49vwIVaS/MhbtY8sd9h8c
 Fe0n6668tmVdkJFfQdA4A0ITxqKvz80g1Eb58aA2l1B5Y7xX/R4lO/IYREavNGv7
 WkvyrhRWy7+FLZU354DrkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758058298; x=
 1758144698; bh=AenYQRTXLmZU8nN3YRqPQ+Ns6w/g2Jfm6+YQdkhMjTA=; b=i
 d/H5Z8Ox0p/h7bDA+s0vkHXvZPaDVVHfop9Y+nrGCY5HAjXowre/yDG9aSbtjoTd
 kzBTrl75Quf+eMfAciIMIMjfu6KDMElO2JTmA4lMrawLRH6hnpnxILdXHXUKRfzO
 gpw7U081MKg98HLRAv0x7W+RKeC4F7+QAKKn/l10HG9HXrm9lik+LQm++F1h8DmD
 iipx9hfwDzsrAepVNdewGfRupGY4uXrIT4OEgq+ZndX8tabkCStUc8UsiP9W5Jcu
 i006u4QYXT32fOCCIFKIURKFePid5aACrlHwtTl3GIRPvIHc24NSid1y1LZPMORv
 NpCehucK2J2ejwjTxcAAA==
X-ME-Sender: <xms:OtfJaDtBA2Vpe52eAt4gobuKvY-wZz4m0bm3VmI-T9TE5mI9mCCUSg>
 <xme:OtfJaARQs08xu9_K2koReLXp6Sev6vRdOa8MC13fCJvq-OYbsfveD3oCmptZDkiex
 iIpnMYJiedsnlFPmA>
X-ME-Received: <xmr:OtfJaMTnciRDJZ4pkcNNw88mNzuSu5_Oe9BqIFa_Exx_nfmZMdCBtydLTpSdXrYltl2adkW1OMS_5meFxMHcqpVwZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudeihecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepudejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopehshhhpvghrvghtiiesnhhvihguihgrrdgt
 ohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepmhgssehsmh
 grrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhi
 tghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghjihhtrdhkhhgrph
 grrhguvgessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghr
 vhgvlhhlrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdhvrdgrnhgrnhihvg
 hvseihrghnuggvgidrrhhupdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehr
 vgguhhgrthdrtghomh
X-ME-Proxy: <xmx:OtfJaEri0tcoWhDvu0UvG6YY-KN_67IPthip70vaBcXHTuEvPzLHcQ>
 <xmx:OtfJaEAht_UEXwBlUaohcu1YcfxyMtSnNDkXO7jOBrDPbayO3Zjc8Q>
 <xmx:OtfJaBvm1x1ebdmq7qflGDnHPcHhoUgNIzITLbb087_UKOn0jI5d7g>
 <xmx:OtfJaLa5xXQfK9j883h9YzcAmIF3cMG62KoUBAX2c7NNf7YlLO1SLg>
 <xmx:OtfJaDcObBaL-0IbPcPcOy_RlOKBO-FO12jzpxXrZKeiMRby9qOUj96j>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 17:31:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Shani Peretz <shperetz@nvidia.com>, dev@dpdk.org,
 mb@smartsharesystems.com, bruce.richardson@intel.com,
 ajit.khaparde@broadcom.com, jerinj@marvell.com,
 konstantin.v.ananyev@yandex.ru, david.marchand@redhat.com,
 maxime.coquelin@redhat.com, gakhil@marvell.com, viacheslavo@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH v2 2/4] net/mlx5: mark an operation in mbuf's history
Date: Tue, 16 Sep 2025 23:31:34 +0200
Message-ID: <13612908.O9o76ZdvQC@thomas>
In-Reply-To: <20250916141427.67caf4bb@hermes.local>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250916151207.556618-3-shperetz@nvidia.com>
 <20250916141427.67caf4bb@hermes.local>
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

16/09/2025 23:14, Stephen Hemminger:
> On Tue, 16 Sep 2025 18:12:05 +0300
> Shani Peretz <shperetz@nvidia.com> wrote:
> 
> > record operations on mbufs when it is allocated
> > and released inside the mlx5 PMD.
> > 
> > Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> > ---
> 
> If you are adding this to one driver, it means it should be
> done to all drivers. Which means it is creating lots of churn
> and testing.

Why a new feature should be applied to all drivers?
We never force a new feature to be implemented by all,
it is impossible to do.

> For me, this amount of churn and #ifdef is not worth it.

I agree we could avoid the #ifdef with a dummy function
which would be optimized out by the compiler.

> Think of a better way using some other mechanism.

Except avoiding the #ifdef, I don't see what better to do
for tracking what the driver is doing with mbufs.


