Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7FCD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 19:49:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34D55402EB;
	Mon,  1 Jun 2026 21:49:07 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 4478C402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 21:49:05 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 114281D000F8;
 Mon,  1 Jun 2026 15:49:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 15:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780343343;
 x=1780429743; bh=FdDb7AyMPCnUBfkxQv7jIMblHMIxYbF3QXGK4+aobxc=; b=
 vvV294eqKlzxthVK0JICLNya3pWL7Pvf7CzPFuJ0YisFw4wfvpWtNaVCCvI+Bh/z
 zyafry/kumksKVzt6N6kuC9lAacaA1pdZS26zCuIPt71aqyvEyFswHz2SUWin4HR
 k61eycHLK+2BXyuk3QKJJ1g7S0b/aNESskqZTyEDg7QCFMoaJD6yWmG+9xo/n1uU
 8+0ncuV1eRabtuT5wlYgYzcgzMg/mxJ4qUbzehafm+t4Yn+SctJxlGaPmcGbg0A3
 pNzsmvPrmW5jNGIPuosnVUQiOl4itw9+QzrQBOtIzNMJ7dj3bI53z/CndGlh6s5j
 +cqROKAGl21nSSn4GTx07w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780343343; x=
 1780429743; bh=FdDb7AyMPCnUBfkxQv7jIMblHMIxYbF3QXGK4+aobxc=; b=E
 e6SVSLvX3VV9J5Xzds/94j9LqN9TLRrI6ry+aCWr+4OZbpjlmih1N1iXYLxwbmIG
 9GWVfqxSkexMUIViapdbHdzbjyszAIelTTkh5vtlAVzzUgv3dO07pkGues/4Vpon
 5/Ms6+lL4tYo/dEGKyfkH/+QDm2eEwH7TRpqfH8wemBidmlPaGTWqxFP42WFy5vd
 Vcl3q0g9v0I5wgUZ9cnZN7AVEU/h/CnjaJBHbFsVc7cH/b7oKVLJwQzZDQJIZBZ6
 TPhV2e6wCkKzFQqP0wGpj7F91KwXyPXHv6i0VlDEgXFg2GaAEUThfPLMYVc2oGNm
 2bCyZp2V4rPDthpqVZMsw==
X-ME-Sender: <xms:LuIdakDZs4hFeRVlad9RE_vAr0xnA1Ffr5-T-q2n20HryMlIJt1E8A>
 <xme:LuIdaurRwbvg-R8Jj9leCkaVI4vtYvjX0GIIVYc1HFe1bVI2q--KRkd5wEeBxSpmq
 4E-4StNlXswL1MB7G5F-fZgNtlSVz8tpZaQFXJQzsO-AsjML4vsHg>
X-ME-Received: <xmr:LuIdanGqb00EwltjJWdTGTzIKDfc39D4Lq_wpczsl0DmkrgKg_KihduMCLmEVvQnUdI_mNtwn2FWsTBAepe2stAypA>
X-ME-Proxy-Cause: dmFkZTGy4Lcm9vpqTSD1/GMHcE+UZB1iw7XInbblVfcmNpQOER/Tjre95WuqJKzmQ8dvQ3
 1281+znY/l7Ea0glmOJvdHcMici9Zroqir7MK+DjpyRE/AEbb5OKC/xePKlvGXoJklNylU
 MQmHBI6gIjyOGSo1Dc49j45ZbYmfxqtHXlk5gIZLNvMqHMv8m2cpLjNlnmIonS9udAaqdZ
 qKI8gBLR0RLMByEciApJQqzEMcTK0ahmkVhhcB4dSR6cR+lJ42HGXYzTOzejGn6n1l3IyJ
 fG47K/l19i+ipQchbXi36OWtn9BGzP/IXRVDXJC+GPro6UMZ/gijcI4fDb6faecMe5Zdag
 Oh+juPEpiIzmYxwn3SfR01bx/4c8AcGIiFf7/4E/6YtfOquzFpx+bC1j9AyUOxxtkujMul
 NPHWBvKtnnkV6nEODkqLTh4D7qGHAi77e3CuKTeCoGzTgUhVheIvyzJ06osfEJTUeheVdQ
 7FD/ts1nFliNgQ98d67cApQeYeiCCgBrcBY2A7twKOEWkLoo0E8JZOPSO0Man+lBSoO2ha
 OgMvk6iwEdo5vpXFHf8XqnBsAYuCLMHGN7B62Y46YEU76ScZggokVFPynZBjNDYHxnhYdA
 dohR/0FY/HeeSUox/89L5vlG0ETmISAZD8VednlCMeQE/Dj0cgcH1OebeYYg
X-ME-Proxy: <xmx:LuIdaquWQ7xnMS9hcPsu0IHo40FdgJB84vXKP1Jpbll3b7-Ebg2KCA>
 <xmx:LuIdalbquI5DmOzLHhcon6yaTzlz-21fEIE0l0GwuIfbFRHuNfGVpw>
 <xmx:LuIdai6q-uckk43QaXggl7Wbc_FFgrnI2lAZDwl9IL3I2K7Hd6vzDg>
 <xmx:LuIdal_U8VktwyZjIByG8Atthe2nuTxO4G5zcf7VnDz60eoTbsXZFg>
 <xmx:L-Idah-hlXyxdAiXPf4MEzGXulC7f_RZMG7RDofLW3tUIuVpTPRclcKW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 15:49:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Liangxing Wang <wangliangxing@hygon.cn>,
 Thiyagarajan P <Thiyagarajan.P@amd.com>,
 Bala Murali Krishna <Bala.MuraliKrishna@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v11] eal/x86: optimize memcpy of small sizes
Date: Mon, 01 Jun 2026 21:48:59 +0200
Message-ID: <y_jYezxuRP24paX-Kxb_Ig@monjalon.net>
In-Reply-To: <20260521185631.116046-1-mb@smartsharesystems.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260521185631.116046-1-mb@smartsharesystems.com>
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

21/05/2026 20:56, Morten Br=C3=B8rup:
> The implementation for copying up to 64 bytes does not depend on address
> alignment with the size of the CPU's vector registers. Nonetheless, the
> exact same code for copying up to 64 bytes was present in both the aligned
> copy function and all the CPU vector register size specific variants of
> the unaligned copy functions.
> With this patch, the implementation for copying up to 64 bytes was
> consolidated into one instance, located in the common copy function,
> before checking alignment requirements.
> This provides three benefits:
> 1. No copy-paste in the source code.
> 2. A performance gain for copying up to 64 bytes, because the
> address alignment check is avoided in this case.
> 3. Reduced instruction memory footprint, because the compiler only
> generates one instance of the function for copying up to 64 bytes, instead
> of two instances (one in the unaligned copy function, and one in the
> aligned copy function).
>=20
> Furthermore, __rte_restrict was added to source and destination addresses.
>=20
> Also, the missing implementation of rte_mov48() was added.
>=20
> Until recently, some drivers required disabling stringop-overflow warnings
> when using rte_memcpy().
> For some strange reason, these warnings were disabled in the rte_memcpy
> header file, instead of in the problematic drivers.
> With series-38174 ("remove use of rte_memcpy from net/intel"), the
> problematic drivers were updated to use memcpy() instead of rte_memcpy(),
> so disabling these warnings is no longer required, and was removed.
>=20
> Regarding performance...
> The memcpy performance test (cache-to-cache copy) shows:
> Copying up to 15 bytes takes ca. 4.5 cycles, versus ca. 6.5 cycles before.
> Copying 8 bytes takes 4 cycles, versus 7 cycles before.
> Copying 16 bytes takes 2 cycles, versus 4 cycles before.
> Copying 64 bytes takes 4 cycles, versus 7 cycles before.
>=20
> Depends-on: series-38174 ("remove use of rte_memcpy from net/intel")
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



