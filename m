Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E068BCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 18:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF244021F;
	Thu, 28 May 2026 20:19:20 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 3BE984003C
 for <dev@dpdk.org>; Thu, 28 May 2026 20:19:19 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D29ED140010E;
 Thu, 28 May 2026 14:19:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 28 May 2026 14:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779992358;
 x=1780078758; bh=NAeNz0UjeInXjj1mUpGubu2pt27PL4k9nzrmE06fDz8=; b=
 gFYAfoWs3i8GTRJbGWSNIBBPpHffDDjAbnuFjOYH5wpR5ss3DZrkSs8cyzgGX5q+
 WMAm2yk2TR6F91GUR5vEtK2fKnQ1FDTHB6W+6NyVqgjXrlqAXe/mlj/d1Wy5PVmR
 /0IdYnUVm9Hu9TPNNJhpV9CoDKI7ZQHLAY0E7NT63/BFDM8Grac3dvGCbPE21xDl
 3vgFzvj+vgf2fKHxmpnoNQ9z9VnLwwwURqXyVf7zvKgTIwChoB4hnPJnUYi7bYJZ
 o3RkiprMylwn1zMIfDZfAkZgnmVNCTrqv/0Cx/aHMARHYwcr6K5oZxh57snQ3SFB
 TVTrAzkMJhkTLTEtW3kRVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779992358; x=
 1780078758; bh=NAeNz0UjeInXjj1mUpGubu2pt27PL4k9nzrmE06fDz8=; b=s
 h0mlILD07yfpC8g7Zc37gKoWV+r33ubfpvpn5XQJ6xWifL439AgmooKCMYOJUk9i
 5xyRl+Vg6mukTSK6vg+ca0wJBCRfjCgomRBCReyaDkmvgBwEyoNgSXvlO5TtUMwm
 R/G3PdzNGnWvzum1Xf0WTikwCVHayWeUigByM/C8L8XNXyRLuGz6mWjmVPbv1Fak
 wDokiqKxEamKDoOhBGIs7Uz8t6CtzWc1SMVMWyTm67qLzp7eNEXT4Pt7eMxoF9/u
 s9Zx+N/JQLOTl6gwvcu8pEZly0lUja4930ugtRacaJf1m1X4cXlpEQpalQGJBkpp
 uhPTmfJEHaash7F6VRpTg==
X-ME-Sender: <xms:JocYaqvxZojFAgHr3eZkd2HFlEBJBXx8WXYziCt70QcU9PtxblQpKQ>
 <xme:JocYarx0Q2YK7AaSEI51buT-N4ecVe9XOsqrSvx0k5mCZEJ1hcU-E6FsL7jtiK2Kq
 Qqvnkk_qusM-p0AeJu_ubwrUBQ5qvHC3-Up2_Cg32gOjbv-uRsv>
X-ME-Received: <xmr:JocYaoil6Nmw6P3w7AecFHJY73kzqFjRkyYMEyDKR1XC0mAaQyOctL_4FrnjfBfgdynfvzazT-PoW0KtQxmO3aDb0w>
X-ME-Proxy-Cause: dmFkZTGlCXNt8lvoYEQJwkI5hil6nuuZDUWQxfkYG1rqbcYy3D6I8U1hVetV3N0592ecOC
 /SJDg3bGysAoNqt9ThXJU3uUwoga2e8P1A8k25LUA4Yy3ZMg+4bUvcDrrKsuHNswlLx2AR
 ADxgxGQTk2Iz4XBgMDThcvuAn19Ylw841DG2NVfYj2DAI19mYlZ+sWBR+AKz4IPyK97Gd/
 sDnWe5kMpx946FFW01XuxsRAhyFS3O5Q6qtoUV/PYFaO3apNlxEFUpb9AxHAXpUNAYWL7+
 Ac0mcs8KhfAfCX2WYofzHvDIxdCfjk6X6JdfWHn0HXmLf3+/ca3zZ2tzz+SEPgUfT1Yta7
 i2KadYdXg75YeXIUHV2k7wUgqrwxbIi8WrwFNP9v6Pbow7ZgngHvL4WKKWy4aTIW+48/De
 LIbA1PHcVVB+vtbSqxe2SHQLeKwvfMCehU47bl2ReTN9GNxvB91S5nPnT1qbeucmPuZG0V
 ze1HPnWRC2oAhYMDVZCXmnMLcrEjWv8A1bzbJ35wmhVDrUj3RIH4v4usjNb52Vne1DRdw9
 qwTxztO2sQ49lERX6ifDASnItZEhDckUweOHzu5eQ8/uuaFZf2QwaFnZHAB/X+j8vo99RG
 8gPPYlEfC1rStYvSzrZ3Vhem/x9uH2RfVGdLZ18+BDaQ7aG/sSIRKoBu0Maw
X-ME-Proxy: <xmx:JocYanBKui7khBteiOojcIEfC0dIq8IQXvYfixfcrCvzs-dSWftaLg>
 <xmx:JocYattHuzdR4XXd3ZTVRDBsHmMzX3Im2_JAuw60rmtsNaaSzfp47Q>
 <xmx:JocYakajCk12BRVVu7TZRQr3LgY73Mhw9dYeS8EyzzmweE_m_Q5h3g>
 <xmx:JocYaoXmhn7QF_A4VA_T5meS2EbEsT8lFr57wNYgoIWT8gVoFjh-dQ>
 <xmx:JocYaoNtfOvNoL9u07e3tyJWfrK_C0mkLFuXD-UGTF4LneecV603VFKF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 14:19:17 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: announce removal of flow director
Date: Thu, 28 May 2026 20:19:15 +0200
Message-ID: <ED4MTOXhQ4iCVj0Gg4IMwg@monjalon.net>
In-Reply-To: <20260528170059.155964-1-stephen@networkplumber.org>
References: <20260528170059.155964-1-stephen@networkplumber.org>
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

28/05/2026 19:00, Stephen Hemminger:
> There are still leftover bits in ethdev related to flow director (fdir).
> Will be removing these in 26.11 so give final notice.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> +* ethdev: The legacy filtering data structures in ``rte_eth_ctrl.h``,
> +  including the flow director (FDIR) types (``rte_eth_fdir_*``, ``rte_fdir_*``)
> +  and the ntuple/ethertype/SYN/tunnel/input-set filter types, are superseded
> +  by the ``rte_flow`` API and will be removed in DPDK 26.11. The associated
> +  driver-facing definitions in ``ethdev_driver.h`` (``RTE_ETH_FILTER_FDIR``,
> +  ``struct rte_eth_fdir_conf``, ``enum rte_eth_fdir_pballoc_type``,
> +  ``enum rte_fdir_status_mode``) will be removed at the same time.

The problem is that some drivers rely on these structures for rte_flow.

Note: this file is big, please keep it sorted by moving this
close to other ethdev and flow deprecations.



