Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EAEC83F34
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Jul 2025 01:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99A94402BB;
	Sat, 19 Jul 2025 03:48:45 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id C4C09402B5
 for <dev@dpdk.org>; Sat, 19 Jul 2025 03:48:43 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E32B47A00B5;
 Fri, 18 Jul 2025 21:48:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 18 Jul 2025 21:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752889722;
 x=1752976122; bh=D149p8MbwyWtcVyzqZXJVR8gV2t+CW+hWwYOXyWMJWc=; b=
 xsrB5Gnqf6KTQhgaFbi3KyWl8TmOLLBWLakgyY8aYQ+BtaCtZmnD3IIwDcoLn1bG
 Nd461UReOOtCz0EXrH2YNz6G+X8tzjR5XZMBMIMn3h77rrGCLF+i/u9Z7VzdMICQ
 q5DV3hMp5k5/T1ViEDuX9dG6MTrWuMahcsIXxp4djy1rKOhncV7uNpIdYo4a3lHf
 kmmsNO2gMZF5VcrmpDz1xpKCTBGRuL9F6ZCIUk4i3UUmiwLn75VbSfGj6iBLBb1A
 jQzAvLG95p2UjS1j9h6gxMleGjdFYCEma81/P2jSSXyxrN7fwzVZsd3XVI9CHvwO
 t6CPJZl+I8SaRN3XKMjcAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1752889722; x=1752976122; bh=D
 149p8MbwyWtcVyzqZXJVR8gV2t+CW+hWwYOXyWMJWc=; b=URRtCH3VxOqVSB/kI
 cY7FUQJRaQF56l4My0NjDys/tVm/ytqMbMtyRyxiXyRYvI8kvIbATbhCH87kH3kk
 uV0uax6hiuH0SjNNs2VLkQWe172BDRdw+VE1BzfGpiH5yGvjmue2Yo6w7wqFbI+a
 XFX4SidI/1laome4dXNh06rUM/5vKAHmNFoySYneN/lqKDZZ7vSwOFpjkq0ZvdtE
 kzEOlG5BjdE1rfWttnuAzZcsxwBK6odbrK2aRdabEFSc5di6owapQfIzpPMXFxCp
 L2LNlaLQFRIV3AmdgzSHYoTZZ+X8PPAVtavTvHRXm3hkb0A0Uapzv5zEEyM9H0QA
 sU+tA==
X-ME-Sender: <xms:evl6aJsFv3yduE7VKaKMKf8pWUaSoI_bpRrk1YDpfvBM0_jaxVcHKA>
 <xme:evl6aNtx81mHX0l5ILiEXAuQ_YBhT-7MgvzM36R-L9EGVkbf0hDZhsG-69Geg1SxM
 WIl0jvJoXFYauYtgw>
X-ME-Received: <xmr:evl6aNZQdosUCSOZ8BNPTpSFqp5RbzwgywrqS5QT9Ri2d6TgY5etkHZzmEm1Ksv5jumSfVTYWgqFCHreVVKKfBfIog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeihedthecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgjfhgggfgtsehtufertddttd
 ejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhn
 jhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepledvhefhudduudefhfffhfetfe
 fgjeethefhteefudekvdefgfeludegtedvtdegnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvth
 dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggv
 vhesughpughkrdhorhhg
X-ME-Proxy: <xmx:evl6aGYaa0Md3TGYABBE9Q2bpK1kvMQe-BbOdtrzB2aVj1dah5HZdg>
 <xmx:evl6aJVizyDiPvUAScE5-1Lz_Oa2iHgVcSUJALhAfxxSaxY3Av7OcQ>
 <xmx:evl6aN3MXwO8KxuhY-qcR_JAmpBgU-JwdItxq3F4on-tOwJOoDYI8g>
 <xmx:evl6aAa1P8U3_0rks6Od7eyLc5ixrYGAuC0ai_QVhW3_lLSZ2CzXXA>
 <xmx:evl6aFv6W08dxs5HNo2iqUbx0kG74_aQ3fTSBKhwOB5qaD7Bbb8jhFqo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Fri, 18 Jul 2025 21:48:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: Re: [PATCH 0/4] rework mlx5 guide
Date: Sat, 19 Jul 2025 03:48:40 +0200
Message-ID: <3643036.iIbC2pHGDl@thomas>
In-Reply-To: <20250717220912.376503-1-thomas@monjalon.net>
References: <20250717220912.376503-1-thomas@monjalon.net>
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

18/07/2025 00:05, Thomas Monjalon:
> The main mlx5 doc (for net driver) is improved
> with better explanations, better organization, better readability,
> and will be a better skeleton for future detailed explanations.
> 
> Maayan Kashani (1):
>   doc: add testpmd command examples in mlx5 guide
> 
> Thomas Monjalon (3):
>   doc: simplify mlx5 devices lists
>   doc: add table styles for guides
>   doc: rework mlx5 guide per features

Applied with few fixes and improvements.



