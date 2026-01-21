Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D44C4453B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 13:53:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EAB7427E1;
	Wed, 21 Jan 2026 14:53:39 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id EB587400EF;
 Wed, 21 Jan 2026 14:53:37 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id DDDB31D000A4;
 Wed, 21 Jan 2026 08:53:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Wed, 21 Jan 2026 08:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1769003616;
 x=1769090016; bh=wm8xJLQZZNm9TqhDbymiHOEhRxVj1NTDQXBpgYxyyIM=; b=
 GLSKZY+vyTXEPSS0cxd36NDN5fVwIxOZPrjfxs1Ar9fQuqDho0SocLlRq+OTHgLP
 TZtsl+L5AYzSpqTJZbo+To5njcRlsxFwqTOy1EU9lTP0pP5p4zEbUjNonZrKb1YL
 9lDz1TWN7tmNDap80Y7og/1QGTQsk6E17RXoiQ5elJTc+Uj60kec9mGFtvuTyCol
 Zt+m3ocj+GVjq1OctB/oPhauZfQ/gHEPWavqMCzqr/zdmsGUobokBq/wf3yXZefP
 gb9tLBCnfdeGdvYFCJPzVSAPdDue7UB/lROlFpJ4dSD8+6FIeGTHPpU6+l9MY7gK
 ZF792a1Z2T6jr2HpV4/upA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769003616; x=
 1769090016; bh=wm8xJLQZZNm9TqhDbymiHOEhRxVj1NTDQXBpgYxyyIM=; b=D
 X3cJP/cTbBG7ETpc+RpbX9qKhtfdXTFUR8NKA1x4zj2qXLehnMCLt72doZ2ANEAT
 UMDHyNOPFSBThR7eDZRCBCs8e+mKQ3NrsLtuPL8Qalspe5eLIywynRGT62aUmvmC
 CviXrTvIL+00KQOgJrMRALxBkUaI3jL2dNqssOCMQI4dTT7tAA4z+4Bnefw38GkY
 xrOcp739q5wvH9c1Fma70moNMXfbrhBd+Ujx3LR7u5DCvI4M3GvClAp07BVUksZA
 U4nm+iJ+r2/sXeok2ly2wuga3AWxd5hP5Zv9TdQHX+9RRbF5FXv4rmx1Wb0orST1
 s0e4VWwbifDx3RuS6nEpw==
X-ME-Sender: <xms:YNpwaYHh5bjH1z9K3lr2WhkEVkkJq9q3-T40i9j8qVCBnhKV9532iw>
 <xme:YNpwadXnHuQjjId1MD-l5EsV9rUOGpXDOCFAATxfbq1034ix-br55zk9oz90njbCp
 mingKBQ-wPcwuQJZU9OfxUfDPgKarkFf3AlxSf6wPoW7HQrIHDesh4>
X-ME-Received: <xmr:YNpwaUVkkdZCljtbzqNO-W2VGBHvOpCp9I55YSd6OEA_u9sK7ZaPWTV7uR8pb55FPufWpvNF3RVkX14bFT446KYeRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefgeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeelpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehgvghtvghlshhonhesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdho
 rhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepughiughivg
 hrrdhprghllhgrrhguseeifihinhgurdgtohhmpdhrtghpthhtohepmhhkrghshhgrnhhi
 sehnvhhiughirgdrtghomhdprhgtphhtthhopeholhhivhhivghrrdhmrghtiiesieifih
 hnugdrtghomhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtghomhdprhgt
 phhtthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:YNpwabKPTXRdGysAyA1oKy2HQqYubKxSitVhZRnMkGjuqwGaVuwyLA>
 <xmx:YNpwacDvVY9JM4FyY3fkundXTqDC_OAn2m4UX0bcEe2N5AtVi_JOyQ>
 <xmx:YNpwaTdKis-yBIzbK3eHrx6R_xSKyLH8lPD_nsZppEjpYnBj4zwBWA>
 <xmx:YNpwaT0zwzpkXiNIROsIDxLPK96EBRaAC6tCHAW0sZEbDEvlYaMgLQ>
 <xmx:YNpwaSuJUQuvIdSiIBtPXE7ou5BMH40atKjI0v18SyJxl3GskYres47m>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 08:53:34 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, didier.pallard@6wind.com,
 getelson@nvidia.com, mkashani@nvidia.com, olivier.matz@6wind.com,
 rasland@nvidia.com, stable@dpdk.org
Subject: Re: [PATCH v2] net: fix parsing of frames with arbitrary VLAN stacks
Date: Wed, 21 Jan 2026 14:53:31 +0100
Message-ID: <3188990.CbtlEUcBR6@thomas>
In-Reply-To: <20260115131456.554948-1-getelson@nvidia.com>
References: <20260114113327.3618b433@phoenix.local>
 <20260115131456.554948-1-getelson@nvidia.com>
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

15/01/2026 14:14, Gregory Etelson:
> The rte_net_get_ptype() supported only 2 types of VLAN headers frames
> that are defined in the IEEE standards 802.1Q and 802.1ad:
> 
> frames with a single 0x8100 VLAN header:
>   eth type VLAN / vlan / [IPv4 | IPv6 ]
> 
> frames with 0x88A8 QinQ header followed by 0x8100 VLAN:
>  eth type QinQ / vlan type VLAN / vlan / [IPv4 | IPv6 ]
> 
> The function did not parse frames where VLAN headers were stacked in
> different configurations.
> Such frames should also be allowed to provide HW vendor flexibility.
> As a result, ptype bitmask and header length returned from
> rte_net_get_ptype() for a custom VLAN frame were wrong.
> 
> For example, the parser result for the frame
>   eth type QinQ / vlan type QinQ / vlan type VLAN / vlan / ipv4
> was:
> pkt_type:=0x120007
>    RTE_PTYPE_L2_ETHER_QINQ         0x00000007 OK
>    RTE_PTYPE_INNER_L2_ETHER_VLAN   0x00020000 wrong
>    RTE_PTYPE_INNER_L3_IPV4         0x00100000 wrong
> 
> hdr_lens:={
>   l2_len       = 22 wrong
>   inner_l2_len =  4 wrong
>   l3_len       =  0 wrong
>   inner_l3_len = 20 wrong
> }
> 
> The patch changes:
> 1. Allow frames with up to RTE_NET_VLAN_MAX_DEPTH:=8
>    number of VLAN headers.
> 
> 2. Set each parsed VLAN type in the returned ptype bitmask.
>    Multiple VLAN headers are referenced by a single
>    RTE_PTYPE_L2_ETHER_VLAN bit.
>    Multiple QinQ headers are references by a single
>    RTE_PTYPE_L2_ETHER_QINQ bit.
> 
> 3. Preserve RTE_PTYPE_L2_ETHER bit if VLAN or QinQ type was detected.
> 
> Fixes: eb173c8def0a ("net: support VLAN in software packet type parser")
> Fixes: 218a163efd67 ("net: support QinQ in software packet type parser")
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

There's no ack, probably because the parsing code looks complex.
v1 was sent in November with a review helped by AI.
v2 solves the only issue found.
So it's time to merge.

Applied, thanks.



