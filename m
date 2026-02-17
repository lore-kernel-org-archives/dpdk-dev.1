Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B407EE68172
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:04:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92F0240269;
	Tue, 17 Feb 2026 13:04:39 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 7F70A400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:04:38 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id E4768EC0559;
 Tue, 17 Feb 2026 07:04:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 07:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771329877;
 x=1771416277; bh=RwHwMEWnZ+OGLx/nEVAn9Ettb80mnqhCuQrg+rp4+o0=; b=
 L7CvF4WPwVLNdGlLEOKCByZiNDnONKYLUPt2QR13EbjEXOGECOMFq0mqkfYmQyqU
 mcRMXd2Qg5kkb7xvBiUVn40/1l+Y0l5wbcui5mbb3Uu8oVCoZAawRtsmXIsIwTIo
 O6AdSXEoRuS/RGquARLkoYrmc+hgtMTKBB59BuM4atmpswtP5d/QRgVRdyedajOC
 qBbZIpL0o7ymdqmbqIOro3jQwnDKeZPmbp0x5Uj05gMHmR9W2dH2ILcjQ3O6GmDL
 FYWswM/Z4SUZ1J0Ba5AnxGeVywbWevrflWVzRHkBPqHQ3s/BlCbEFA/PJ0rxs169
 g7AnSup4Hr1KvFL6mWi/WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771329877; x=
 1771416277; bh=RwHwMEWnZ+OGLx/nEVAn9Ettb80mnqhCuQrg+rp4+o0=; b=H
 pGV9xJcZSBhiqAV2B+NC86N3ljQL9kw+BmpIRdTCVjw0uM9nTXyIkJITbRW05wV9
 B5f1Jfs/6YFTZi5HKEj/XKcWoPwhH5HfQLfjxzaQdCxsxXDMp73fHSVvn3mRa26I
 D29rw4VAK1vk3ZaFqD6C/mMWldIy2Aq7SbrknKWLex4Ft54qhGtTmhofASvomZLj
 k81XDkBkm5Zp054rTFpdY6fUlUKGj+gDafBLdjFF3PceT9aIObgeqkVJBUSPLJjI
 Tz+VXFbXitEr1L7SM6SRRw3PqYysPPhA7daP7upX7AVyTvkgG3mUtgEilUg4JymE
 JVrECOGVCIrK29PYm5zpg==
X-ME-Sender: <xms:VVmUaZbauclUWub3MKKvR1_wSmRBq1RO_OjeZDW674CwoacBvLj-wA>
 <xme:VVmUaQhXXn_fQUm0BWgWJizg0YoPiFOG5-4OPn_JygcZinFpOt5aoysWC0xPkjKjO
 2gDzLbrpF0sFIubusnygfNlEIfUSVDWAG_vA1iuciiKI2am-Dp7vA>
X-ME-Received: <xmr:VVmUaT5Ij5Z-eIxuy3mAMXpSCKLkjtfD6NhpyqnDhLLXFvNFUNK4GXPAhuohpuFJxUIkpVnfYbLU91-lt0s-9NAQrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeljeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghnnhihfigrnhhgsehtvghntggvnh
 htrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvsehhuhgr
 figvihdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:VVmUaf42QJaKS3hUZMZ0Ml94ZBZWDadezY_vb6HAbLTVGTeRP2WniQ>
 <xmx:VVmUafer0Q4MCeII5_z6GFYpL07C8oAQ3tvKDMQBB5-pShsBSRXjRg>
 <xmx:VVmUaTAwmkInYWveHjbIp_yz7GKw5FQXVJpBA40N73JCSGlnvpcugQ>
 <xmx:VVmUaS_acpw51gza2_d0KR0AeA-iSIT9nOKU51Z3Q1riBc7vO-aKuQ>
 <xmx:VVmUaTOp9bDTo1mAc1U5UkDsnMIHRrjhtP3d-iVZIOHZOstMvl8n-xIu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 07:04:36 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yongfeng Wang <mannywang@tencent.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org,
 =?UTF-8?B?bWFubnl3YW5nKOeOi+awuOWzsCk=?= <mannywang@tencent.com>
Subject: Re: [PATCH v12] acl: support custom memory allocators
Date: Tue, 17 Feb 2026 13:04:34 +0100
Message-ID: <5452560.l3KDuRtF6b@thomas>
In-Reply-To: <8C1540E8503F0A1B+20251217130637.19309-1-mannywang@tencent.com>
References: <F60FE144EB2491DE+20251215143802.4274-1-mannywang@tencent.com>
 <8C1540E8503F0A1B+20251217130637.19309-1-mannywang@tencent.com>
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

17/12/2025 14:06, mannywang(=E7=8E=8B=E6=B0=B8=E5=B3=B0):
> Allow users to provide custom
> memory allocation hooks for runtime memory in rte_acl_ctx, via
> struct rte_acl_mem_hook.
>=20
> Key changes:
> - Added struct rte_acl_mem_hook with zalloc, free, and udata.
> - Added rte_acl_set_mem_hook / rte_acl_get_mem_hook to set/get callbacks.
> - Default allocation uses existing rte_zmalloc_socket/rte_free.
> - Modified ACL code to call callbacks for runtime allocations instead
>   of rte_zmalloc_socket/rte_free directly.

I've simplified the doc to avoid copying what is already in doxygen
and may become outdated.

Applied, thanks.



