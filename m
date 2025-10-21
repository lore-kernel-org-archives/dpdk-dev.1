Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D1CCCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 15:20:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 609D740689;
	Tue, 21 Oct 2025 17:20:41 +0200 (CEST)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 4F231402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 17:20:40 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 89C347A00F7;
 Tue, 21 Oct 2025 11:20:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 11:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761060039;
 x=1761146439; bh=KxpHd5ch9YN8JlNvBmvEEQ+FBjkkV3Hu2Ds3qgHN5EI=; b=
 Wbvu4PQOlgYzNP5cnUJbDrXrWUzccpeXcK+GzwazB8K5B0Z4vgi8nq/6qMGqHYwS
 79rCCyCqu/Odp4cL2YXMAjBhSAHCnQDQ3NFConYBqmrSQx8ZFLVlqieAoDqlVU3a
 oVHtTUOEINskX0HJPpHUV4KahZSq30pehG6SwO/xhD+Kg/wf8rm8Z7uDefqw/XJr
 r+viCfi4OijgjZ1c3QRfieiN0ZL/HUWrtyA/OK4sVqavy5xTRtN7MhjdcnNryJtb
 wQNx733ZsRkAJxGUJXKHlrR83NAT/Y9zIHQc4bI8JQNc8R8ge3wm2978slmAjfIK
 FCerxPMNvo20KXDtSKnmPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761060039; x=
 1761146439; bh=KxpHd5ch9YN8JlNvBmvEEQ+FBjkkV3Hu2Ds3qgHN5EI=; b=Z
 ZuD8ktkNiXMqYmTGVqfDUkWu6OFK/kJ1Vw/6HGM8iG3l/36td7GfvW0sMMT0VX0r
 z1pJxNk87+5hHBefcjOv1oc7woXxg5/7lxjFA0arPXE1BnLePiDuo8QIwuFXOUlh
 5Ry6JoWze6sRNWUIRiR5OlhRKlkS4wUjhg5N+KnKDjLUwKFexALyKT2j8BmsZ1XL
 tki9NGZ82yv4KP/8fUdQBxBlCAOg+oMH/hGbxDE7RFFJ6KzeI4Rgkdcsy+rn6Qmk
 87vDk1ZaOhqz49fBruVh975JP8U+lfvlr9rxuqklTwtU6e98j6GkBjtSZS9SeIkP
 okqpUlBPjzYenlFSwV9Lw==
X-ME-Sender: <xms:x6T3aAla_VFAx3decSbW9p4mWYWrXezBNQdXgkCwUOYnMg645aXuOQ>
 <xme:x6T3aIzFC1preg3resZIlm1OrIV6HXSk8rSNr5nZMDMgdpAvj2FDLDQ_C2099xM09
 TzJeuvYhMOlRXALKkYTmf50oW_yW1auIIo4g3Q2jvK0VEAjUGEufQ>
X-ME-Received: <xmr:x6T3aKMsyMURQNkIsedDetcpSp_zxv1MqlHlQ5og-mr4XZSf1cURWpD6cmind64EhYFVqFRvizl76Y-tPjoyEGbx1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedutdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertd
 dttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevff
 fgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 shhilhdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepuggvvhesughpug
 hkrdhorhhgpdhrtghpthhtohepmhhkohdqphhlvhesnhgrphgrthgvtghhrdgtohhmpdhr
 tghpthhtoheptghkmhesnhgrphgrthgvtghhrdgtohhmpdhrtghpthhtohepshhtvghphh
 gvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:x6T3aMq0CoYv3KlzNvogI5VYWD0K83UgoLoIaj5OV2mxt8o87j1dgw>
 <xmx:x6T3aLHQ988XBNZGNI28VZVCk7HTgaVJABnijcOLnZwc4QirpXp_9g>
 <xmx:x6T3aBpRHPeVxAGfg8J7i3XLn5V7gkl_4KMaOGi4iRIUVi_gQl_6TQ>
 <xmx:x6T3aEazWV6QUHKDa-Z1maIwu6hsPKIctsik4UMIVE-RLjG4eJU_jQ>
 <xmx:x6T3aOzqA1aVfRI7U6ptpV1VBGwxsFlcTwFokpnY4JZQAll9tf91V12T>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 11:20:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, sil-plv@napatech.com,
 ckm@napatech.com, stephen@networkplumber.org
Subject: Re: [PATCH v1 05/24] net/ntnic: migrate adapter mon thread to service
Date: Tue, 21 Oct 2025 17:20:36 +0200
Message-ID: <12437241.F0gNSz5aLb@thomas>
In-Reply-To: <20251020163620.282312-6-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
 <20251020163620.282312-6-sil-plv@napatech.com>
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

20/10/2025 18:35, Serhii Iliushyk:
> --- a/drivers/net/ntnic/rte_pmd_ntnic.h
> +++ b/drivers/net/ntnic/rte_pmd_ntnic.h
> @@ -45,6 +45,7 @@ enum rte_ntnic_service_tag {
>         RTE_NTNIC_SERVICE_STAT = 1,
>         RTE_NTNIC_SERVICE_PORT_0_EVENT = 2,
>         RTE_NTNIC_SERVICE_PORT_1_EVENT = 3,
> +       RTE_NTNIC_SERVICE_ADAPTER_MON = 4,
>         RTE_NTNIC_SERVICE_MAX
>  };

Each time you will add a new service tag, you will break the ABI.



