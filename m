Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6371BC83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 10:24:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A349B402AE;
	Wed,  9 Jul 2025 12:24:40 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id DF9624021E;
 Wed,  9 Jul 2025 12:24:38 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 42855EC04BC;
 Wed,  9 Jul 2025 06:24:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Wed, 09 Jul 2025 06:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752056678;
 x=1752143078; bh=eA91j8AuihrCzOc1iH/UFNmpk07qn3I1VQ+PdlhP/xQ=; b=
 Y608GCX8wNHa/1sO3D3XSvIIt3H7p+8nlpCH8sJfCU0+HGQqd91nk2ikuI/oVAhk
 05HvRZT3WLnoPpYGrpR15eqRLiLxlW+0pBD6t47pTyebMlZ6lXsRtb4p+Fn1BQut
 jrTLY2t/ISJixcZNP9OZxvsbQw26nLeGeZ5me8wCkf2ury7ppxb6VrKmKZMMOcQV
 MceiPzwIsq+/cbVb/1SEvldZpUKkd5t2A2RdmR7TnDXL6WFxuyem8D83l5n/AVQ4
 ppCroAr5qWn1TNEr39sUf12iDJrWwTspaqF8phZE0JPi6p3+C6Ffi7vpNDTbeJa3
 JqbASEAypKNMdTbT1OTlpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752056678; x=
 1752143078; bh=eA91j8AuihrCzOc1iH/UFNmpk07qn3I1VQ+PdlhP/xQ=; b=N
 Hj4MVbH4WIOX+/QM139D2XHy3Q2/CKW1zbNzTrJHitFinHDKaHby529A6IGZnk8h
 z7EMF2dn6oqeJ93es3U68gpV/FOT65E8UstLBZogB+fc2mA9a4070gxDQ7DnxWmV
 N1NC0a7TILoZLYtF2E02mFB58AWMNHCx6/zEdN1ecj7Ajwq7oQtEiGoW2zlMm5nP
 R2wuHuPoQ/BY+uMG96roa+IyfiXnevtGqc2xQb/RXGZRJrNPK3dsM8ipX+TnZuSL
 DefYTxBSuD91QN/PitkOrWNcWBxqilr1w2mIh1HR3VMt7H5+4iemjKTiNR4/CjLL
 BB0KIlZfQHyvmdVo28dYA==
X-ME-Sender: <xms:ZUNuaCo6OJslEUwHho4onMeplZg-lozSdza8fO3xOv3sXnEehU3uPw>
 <xme:ZUNuaHbQrShLYxXRscT9Foa8WFX2ZRyCe7wVXK8fmVAoQXoArCSQfaNOosEmHWIDy
 VfTSJHCemwimLtXNA>
X-ME-Received: <xmr:ZUNuaI-mxy5P1JoE9buzlXdFSu863tMEGus-hFu4eiy6qSv_02fvL_uk1IB_DFxC0zkvuaESm73X4wKTJwmSJFLi3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeefudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepledpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepghgvthgvlhhsohhnsehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehsthgrsghl
 vgesughpughkrdhorhhgpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtg
 homhdprhgtphhtthhopehrrghslhgrnhgusehnvhhiughirgdrtghomhdprhgtphhtthho
 pegushhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgrrhgrvh
 esnhhvihguihgrrdgtohhmpdhrtghpthhtohepgihuvghmihhnghhlsehnvhhiughirgdr
 tghomhdprhgtphhtthhopegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhlrg
 gsshdrrhhu
X-ME-Proxy: <xmx:ZUNuaNk5mF-LqixHg6smZFXC6HXKIcPKRPAOh_LSf97nfeed8qYdoQ>
 <xmx:ZUNuaNxMYge81Y3eWpWIhqeOcurVvCHny5yt94Khy5CzyU2griWO-g>
 <xmx:ZUNuaH6ROJqCXROGs6MKxD7i0grDdjUxVWeyJF36EBKO-nkRDq-xwA>
 <xmx:ZUNuaNXclvLb4jcwodzXSoImXmI9Qi_LVkPtY7o9bN0ag_ouQ5OrJA>
 <xmx:ZkNuaExKoh7hKdCmEifoTO6BCK7txANNhwDFmw2HqH4xkCYL_k3hV3xa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 06:24:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] bus/auxiliary: fix auxiliary device port destruction
Date: Wed, 09 Jul 2025 12:24:33 +0200
Message-ID: <5064834.aBcLfjPe96@thomas>
In-Reply-To: <20250707100648.354190-1-getelson@nvidia.com>
References: <20250707100648.354190-1-getelson@nvidia.com>
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

07/07/2025 12:06, Gregory Etelson:
> DPDK auxiliary bus first creates a list of known devices in the
> `auxiliary_bus.device_list` and then tries to attach a driver to each
> device on that list.
> 
> If the driver attachment has failed, a device will remain on the list.
> 
> The device destruction did not validate driver existence and
> crashed.
> 
> The patch validates auxiliary device driver before accessing
> driver related resources.
> 
> Fixes: 1afce3086cf4 ("bus/auxiliary: introduce auxiliary bus")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Applied, thanks.



