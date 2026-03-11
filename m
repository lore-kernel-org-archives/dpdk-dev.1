Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ADB1125866
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 18:29:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B76040A76;
	Wed, 11 Mar 2026 19:29:39 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 698244060A
 for <dev@dpdk.org>; Wed, 11 Mar 2026 19:29:38 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 460DE7A017B;
 Wed, 11 Mar 2026 14:29:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 14:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773253777;
 x=1773340177; bh=5OPRB2cbyZBPS9IeL8IoJAtla4XmiD2VDN/Vau5Nmz4=; b=
 M4WR25/XQ3G3kub4YZvvbQyM0SSst9t+hpp9y4j1eLYb+FjFxlzW7PXmcm6CTdNx
 KQ41nXmQlgSaVDFb3LJsi1Hp5Q+Da0usuvrX4QU7jrtSqAYAMx5Gm6lhhQfGN7GW
 +8tAqg/qdGzhhjOMHUt4Psa7WzjNxFEUjezVpmFFX76dAVmiT55SDrj4ZW2ek2Dw
 eZXCR4tQM0hGxTQTDZ+C5V/UwrSmAwr32TzabM/S+Xf06TpUV4aSMXkKQJyWPuYR
 2sxXq3zHTyPpQ6ppqJkXRhwZRTVDw1tShvL9zmK8wQRIg6t3vsJ2BbmCotKN7vyQ
 CynMPhl/9HOaxlawNaSIZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773253777; x=
 1773340177; bh=5OPRB2cbyZBPS9IeL8IoJAtla4XmiD2VDN/Vau5Nmz4=; b=X
 ENtVhd6QqeFAKY7VBGfHWNS3fVA96cQC5eLqqqG2/AxSBFX3rXyCpQSjLC4zPIrr
 UEc3iovyChyEGQ+YEYyMuZDzOXNuBQBeK9DCy0HDZVKU7L6xwREMCimvWHP1O+Nf
 HXtFvT91YZNFWG1+1QSnx/8jWH+GsoCJN21s45uzGeU+aoMEeoe/6R7JLCdw8F5Y
 iXpdF3qoXY0mJehJNrqVASRkRf/Aci6t/8I/g5h8wIU+TCaPrjc3m2QQC1K1hNHC
 xCy1fGcnhGCGCT8zIktOEElsiwu+/Cdrxbc3RF7fczqARrnBBHL+Gx3H6lvvVHcO
 FW5YN8PZLKz6WBVSLQL6g==
X-ME-Sender: <xms:kLSxaTlIP06R28YZEe0TxGYaTQFE72CdrqJbBD4EvM_HFHHjSOg2eg>
 <xme:kLSxabLh-MvWBoQ3ZSYFi6BTQkecVbzM_WCs4i3D9SsoKKvjZlLoNyxEeO0cFX5yP
 CKl73Ow53LMbWCnZN7ZsNJiJlcsPQ1KI2zJihSCAduVR9egoFe3GA>
X-ME-Received: <xmr:kLSxaYy3arsgnvj0wiqODj-1gm8FFK3dbZxOE8ePAgt949ix2C-tp_qHxRhJaPRjBXHQUz-PgwkKNICfb_6yFKhdoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegiedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmohhhrghmmhgrugdqshhhuhgrsgdrsh
 hiugguihhquhgvsegsrhhorggutghomhdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehkihhshhhorhgvrdhprggumhgrnhgrsghhrgessghroh
 gruggtohhmrdgtohhm
X-ME-Proxy: <xmx:kLSxaTvmOfySHn3ughduvOZZiN1l5QHI10dbV43kkVQ2HOtPlpV9eg>
 <xmx:kLSxaXsRYgYTvNspWju5OV22MxsQXCzjPQP-ZQQ-jAlmw-Wh_DbeTg>
 <xmx:kLSxaQN3pIOV7w7HZywdTqVc2mkmnSRT4xcBQBcx2amd8DvbkAIbbA>
 <xmx:kLSxad3ZGIuAeWvnsME_Sc4zZ7YW-p_HeEeA_kuUlHSYLpXDuxJ3xA>
 <xmx:kbSxaTJqZJ3mcTupmstoL3noDDBTulDSTnakwfQofFNkT9JywOHjs21C>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 14:29:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com
Subject: Re: [PATCH 0/4] net/bnxt: PTP support series
Date: Wed, 11 Mar 2026 19:29:33 +0100
Message-ID: <2401272.ElGaqSPkdT@thomas>
In-Reply-To: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260302171236.98625-1-Mohammad-Shuab.Siddique@broadcom.com>
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

02/03/2026 18:12, Mohammad Shuab Siddique:
> This series adds and extends PTP (IEEE 1588) support for the BNXT PMD:
> 
> - Patch 1: Support handling of PTP frames in the Rx path (scalar path),
>   including ol_flags and packet_type updates for PTP timesync packets.
> 
> - Patch 2: Pass Rx timestamp to the application via the mbuf dynfield
>   and add ptp_cfg NULL checks to avoid segfault when ptp_cfg is not
>   created.
> 
> - Patch 3: Support timestamp parsing in Tx (tx_free_thresh, fast-free
>   handling at dev_start and in queue setup when PTP/ieee_1588 is enabled).
> 
> - Patch 4: Enable PTP for Thor 2 VFs by creating ptp_cfg when the device
>   reports PTP support (BNXT_CHIP_P5_P7), fixing "RX/TX timestamp
>   registers not valid" in testpmd ieee1588 fwd mode on VFs.
> 
> Ajit Khaparde (3):
>   net/bnxt: support handling PTP frames in Rx
>   net/bnxt: pass Rx timestamp in mbuf
>   net/bnxt: support timestamp parsing in Tx
> 
> Mohammad Shuab Siddique (1):
>   net/bnxt: add ptp_cfg struct support for Thor 2 VFs

Applied, thanks.



