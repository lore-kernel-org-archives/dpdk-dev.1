Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FDFC71135
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 00:30:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 840CE4021F;
	Thu, 12 Jun 2025 02:30:02 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id DE33D40156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 02:30:01 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 4881411401AA;
 Wed, 11 Jun 2025 20:30:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 11 Jun 2025 20:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749688201;
 x=1749774601; bh=6+OQp1eWkELT/imwHiQn9BI/gQMMZqtCRshkbimknf8=; b=
 Euxn8Sz/vaRwNPkbmfPwIqvOxlDaoaGFM0X4bplQJjRsHoGC66lomuI959sdNw0c
 sJ56ZDG5tL0+Z4IK2VxKtUdargOFTsD8E7EEpKG1FbkNRbHgyJWVcSgcTutI74CP
 ijZq74nFjId64SBMRN2B3kbv0VfQBqbTNbi0OlbFACKPzzgaWBqSIqSAJXH7o6pP
 1cowQjQLPvGdDceSyfzV7P2YVurVof4cWBiyajJos/n8MmdRhK1tnCYjREeCMqB6
 WRHfDzUWGh/4vAIf/dDLV7i74WMc5cgiNJn5Bs2EuU6OoPl3mhQ12v24DqDLoay5
 c8maJCIIxMSX6QBDkuIIXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749688201; x=
 1749774601; bh=6+OQp1eWkELT/imwHiQn9BI/gQMMZqtCRshkbimknf8=; b=P
 O5TDL9Xtm+eMz9BagGsCWF/HjrTf0ASZVI1xAH8+dd9H/TxI3FX3akOw4ocwojwJ
 U8jfdktStFbJb7ALB5VwWOPcBA26lNn8cbmfhVoiBWf1tm5IHgoo72BHHlby3Nu8
 aHvKeh7y4E3EodSxBp/Nxb1tluKg5JjN/jtcNG6BUH3HK3ijbUGQFCh+wtXejrZi
 fx9g0Ovzho3//fVhyp8aqbN+F1AZsw75f2cAdhhv5Q0/z/xY1dK3I15F5/HksG14
 BL67xtPWkRQfr9ycE+tPL16l8Hwech8cYr4aBltF/UGQFxVCXmsq0yGOQVxmrtw2
 vwxnlJ78jr8iHP0YhMpEQ==
X-ME-Sender: <xms:iB9KaPL0XbE1QPopm6HhCqnaweQY7q8_kG291G1qFzAZxJn3_1Lxqw>
 <xme:iB9KaDLTIOJP5ZlB6SbnfeQ_5c3W3tT1yp09y8sLVkD-8okgNYATVTyBKL14Skghz
 tu3ZS6J4YCO8_VFtw>
X-ME-Received: <xmr:iB9KaHswMcs5GSBkFfcxHO4OaJh8VhEMcjUlQWXUi3MmJUSiRNpnxnfFrIn6-Eabaw_Ecs79faIPK20Wyn9LU7_7HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeeifecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirg
 ifvghnfihusehtrhhushhtnhgvthhitgdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopeiirghihihufigrnhhgsehtrhhushhtnhgvthhitgdrtg
 homhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhr
 gh
X-ME-Proxy: <xmx:iB9KaIaSx1U-wPAbNZM75_ukupT1FpQWKLRgx7CB5SNB0pvjQfnQZA>
 <xmx:iB9KaGaLaVethkfmp6iF38u7H5HIq9oo7ae7eWipxnnmBJHqBjqlcg>
 <xmx:iB9KaMCaHIIIKOTOYtRnyO0qA-EbS9t3lGdErXBZLOaM-yF6scSlow>
 <xmx:iB9KaEb107QsVCzHJub2nKEu3QiJ0GOUd0TLj_DrD3GFMkElhrGQew>
 <xmx:iR9KaAj-xI15oSYGN0bXJR9HQIfghfZK4NhmCnoTPG3_xBc6XMm3RCW9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 20:29:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 02/12] net/txgbe: refactor FDIR filter to improve
 functionality
Date: Thu, 12 Jun 2025 02:29:58 +0200
Message-ID: <11711540.2WqB4rESCP@thomas>
In-Reply-To: <2430F12A7223B66B+20250606080117.183198-3-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
 <2430F12A7223B66B+20250606080117.183198-3-jiawenwu@trustnetic.com>
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

06/06/2025 10:01, Jiawen Wu:
> There were some defects in the original configuration for flow director
> filter. Now make the following improvements:
> 
> 1) Fix incorrect parsing to ntuple filter when set the pattern likes:
>    flow create ... ipv4 / udp dst is ... / raw ... / end actions ... / end
> 2) Fix flex offset base to set item RAW relative = 1, and convert RAW
>    pattern string to hex bytes to match the hardware identification.
> 3) Fix to create FDIR rules for VXLAN/GRE/NVGRE/GENEVE packets, they will
>    match the rules in the inner layers.
> 4) Support IPv6 perfect mode.
> 5) Add packet type mask to match more types of packets if the pattern is
>    default.

That's a lot of various changes for a single patch.
Please could you split it?




