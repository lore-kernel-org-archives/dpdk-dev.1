Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF4C44501
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 11:09:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B373B402D1;
	Fri, 10 Jul 2026 13:09:33 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id BBA2B402D1
 for <dev@dpdk.org>; Fri, 10 Jul 2026 13:09:32 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 377581400052;
 Fri, 10 Jul 2026 07:09:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 10 Jul 2026 07:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783681772;
 x=1783768172; bh=RNalREvCY/83Va4Ar/PDZ1Pyx/c2dNqL0SKLaRbBSiE=; b=
 AfEoVPiv5iOdAeRO6prp8VoAGwwyaiLaoWPwnT+6rQZE0n4Owk4cWWAuCBP44OT9
 zCAMEeyorlXVUq1ZmZg/w3M/AuLWu6UJhQycfK2POmUPVGX1q/t2VYU+ADlxDJ5W
 mZvTXTSgTBP+eokCrSo6RKCBjhhxydAtNRtAYTZgFZbFH7vPzi4lliGH1jx8imgB
 m4NZebNOWCdSgX8YOUBba6i9hNJHFnSCbMIHgH/X4MusBXa4SW/h6EW9GL2pUH4a
 KBhea7TKXrT57wMurnkfcqlMYAxqs22AELkzXZfS7ONTW2KJNJElxFfByChdgDKZ
 6Tbruhc7Orb5727Qjy7otA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783681772; x=
 1783768172; bh=RNalREvCY/83Va4Ar/PDZ1Pyx/c2dNqL0SKLaRbBSiE=; b=a
 Vkd+mOEQRK6QPNZMWVT4v2qhQo7hJIFoiW8+77NwrWbK3K5YHLxamNWkW/mUc995
 7cAKJ3kJ/gVURVExq8wQufPt3eFpJiZzMjT6ZQVVMv1NZQkldg5seOL0X/wROuO9
 6bzxJqx8WndZpQj5uuuNlJFRYzl1LYBfDakGflRmtppUcTUBaJUscufZLqPOAZvp
 V6Cf1tkUZ5GrqDhmoQHRc5ntMDfjrBLywlc8jkPfVF6EFbiGvLGshFb0fcRb5RQU
 dO0BwJy6Ya7vaQ5GQalKLPtszsm5Jx2qsoCRcS3YaYIc9GrmAWnd9+vgcM/fzGcs
 aeqc7KuF82kH7l+tAauQg==
X-ME-Sender: <xms:69JQaiP-nBA0ztXC8aspuugWh0Pzg5DuEtzTm26Tsfzk1nqMbsXcmA>
 <xme:69JQatSTGoPe0Z1YjJeisrcwanUvi-WJ2LBy7i2JhqnEwTs7S4yZFVorGeP9kY6Wb
 qrCuAbee7rY15BvEn7OmkkCwATp2T4JjKFJyO286ZiQOCPfmqS1>
X-ME-Received: <xmr:69JQasBykOHUsm0Zb4PaJGE6jQN_0R5imquK2N0NviGMRSSjqWyu1SeuTAbKjsQ9Lvxoe4pkbCxza81uXNB6NtorNA>
X-ME-Proxy-Cause: dmFkZTGuoodmDz+620MgE4lzZg8VFIgyO0jkCrnxepb7X45rsZYASfrUYfXqskvIp1Nfpq
 5hRUK3N7Y0Eh/Ux0iiCj0/IZiIdVMLjhiM2ph8bqBW0WEUqp6sHGoLDsfRodDeRERpEGUx
 bECiNFmry3O71QIDJzQjzEHUcBbGf2cCQKZiqpn82t5lBjJen3CZTL6s6Zyhq9IcIfP6XX
 c3jIICH2vYz3SWs6sp67KB7+8gE94hfLMzPetsF43So7nEeexLbzmqfVyRVkNKXbBmvSeV
 /hVJF4zZ2EUshiUW4ERiVKvVhHp4qSSv/zrNOArJlflUkR59614tlTksPi/V8qhK73ZDSx
 tOZhO1fXwh+SUZwNBgf8h4L0uUSsp2q0XW2Fjhf+ZEQix982Wm0mnZh98Y4Cbi7e22UcX8
 JFF3KKZHXNATxpD+gDwdKzswWkwdxix0yk9z+BBp2DxdKpoYy7e10SyLjMdkwDJAjV51+a
 yDUY58DpsJueq2MFZw12Xun7dNVmlQua5SMkHOS20OxQKuDUrEzAEi9imEIdkiAXh/hxgZ
 9HgQK7XQ3IBCnLlfoAbglXvXuD/dutzPLur264Z5yKlodFrifT1ioCIIB3UYXp0hWzi1Hg
 iUq5MmeWREMXHKwk8IN89S6iLSDxmtVF2Sb+KEzb6VMdk4oWYc6IoZdjLuSA
X-ME-Proxy: <xmx:69JQakj7LPMRDpSjt1SMFNm07UhdRpJx9JKA3qk_USpTxu8rOi1Y9Q>
 <xmx:69JQatOjkj5iF8xdhLS9Vix-JTYoqdxsi4rN07yZsoMOnGqtTU_0Qw>
 <xmx:69JQat6b_Yt9cyM2OMQ1Yol4tFwO4cmgBlUIZgTI3_1VMei10xeMPA>
 <xmx:69JQaj1Pc5MqbjBHbdPIp5Xerv5O_7YXz9pG4FO3W2K_zaw6D-xyOA>
 <xmx:7NJQakj_flchg9Drg9RY6IgGGvLGW13ElyW-Tw9r-a3hyO87qAgiSZ2g>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 07:09:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] net/txgbe: fix coverity issues
Date: Fri, 10 Jul 2026 13:09:28 +0200
Message-ID: <fkEi3qYvTE-qbce1u8bYhQ@monjalon.net>
In-Reply-To: <20260706104723.25968-1-zaiyuwang@trustnetic.com>
References: <20260706104723.25968-1-zaiyuwang@trustnetic.com>
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

06/07/2026 12:47, Zaiyu Wang:
> This series fixes several Coverity issues reported against the txgbe
> driver in the 26.07-rc2 release.
> 
> Patch 1 fixes a REVERSE_INULL issue (CID 504601) in
> txgbe_dev_setup_link_alarm_handler_aml() by moving the null pointer
> check before the pointer dereference.
> 
> Patch 2 fixes INTEGER_OVERFLOW (CID 504602) and BAD_SHIFT issues
> (CIDs 504598, 504613) in the e56 backplane code by validating
> lane_num at the source in txgbe_e56_cl72_training() before any
> GENMASK operations are performed.
> 
> Zaiyu Wang (2):
>   net/txgbe: fix null pointer check order
>   net/txgbe: validate lane_num before GENMASK operations

Applied, thanks.



