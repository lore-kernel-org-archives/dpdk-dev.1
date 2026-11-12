Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F761606A32A
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=ct3RF0lA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eFaUGpnF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FDE642D7F;
	Thu, 12 Nov 2026 22:00:59 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTPS id F2E2442D3F
 for <dev@dpdk.org>; Thu, 12 Nov 2026 22:00:57 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DB5D57A0710
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:00:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 12 Nov 2026 16:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794517256;
 x=1794603656; bh=W3TS05qPi0bH2sRMOj11CIHCM3kDO1wdnpm4WyCsjDE=; b=
 ct3RF0lA27NcxqsvUYi+MC8kxMq7sdyglw9dMJUOfW7P8HnHNoU22lNyM1rL2UBt
 tKga0Hdp58PSwU6YIKMJbLWQ2MqEQ1YbPRQPPs6Fsy+onMS4xQIN1eUT5UwpfuoZ
 2ZiLqnZtnv0gqjFZ1UEcxutDtMezb32pc/rLyGJ7sXpwnuyPxp/YrnqiNGAEkrlt
 Opy5McP1Ug7QBbmoMtuTrNNKOxe+WET+30ams20Q61GstEubiyPzHh42xSd76QLy
 aHF4UyzfYhyi8pv67DZZOU1Yt9vYgVlhnhaJ81CKsVz9zfkDg4iCCR03lmy/GDHo
 p4L4VetQnS/WcSuZ6ady3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794517256; x=
 1794603656; bh=W3TS05qPi0bH2sRMOj11CIHCM3kDO1wdnpm4WyCsjDE=; b=e
 FaUGpnFipKmOapPBg1ESqJmcQSP1Qho6WCXSCckzZTS0ntzY+YAMH6ZrDB8YDoMf
 sjJi91LXcBAHY62KgD5KEjw3UJf64Md3z4kdfzebEI6hpJSv2yJzTGwPB/ERcoEL
 cRalNB8xhrIiB/CJ5es6Emfm+BRYHoxPVbDtznKRRwjGEnfGQj2BW0H+OkGhkadI
 yrVawD2Uus0ROEOvsAtB/xkKh00itB1WKEFIsjHCbAEcL/RMhV5WYliczqIVPL4x
 IT+mrnQWS+zcb+wy61CW7fAJ9wZoqjuBmrSM+R8UYZWomzioDGqm/nr2leaMrVYt
 1Y4uSbn0e+K7oYxnDVfAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794517256; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:c0YVjiHs/h0CwrKlL7vLEa6jHGFi4O8jKkG9sa/LENWQmda
 4Se4wAgIDCPqkcxHluB7JTwfS0NPgVqOCTiM0RgDIJ5rs2xHKkMNS6df6rILkorz
 dye2PIvoLeX6AgvBbBtKOs2a49JiNPPBBahCwQiZk1FCx19CM1hmim4gtex5nZWY
 120jKiur0eJ+CfcmlIfo0+Rd4W9bEkU2L3WyaIPLq7UDHncX5SxSWVOK2efaH1iu
 ckXVf9NdR9XY5lfA47umfL4zlPqvtfj4siwxih/lqXwNtG2tJtm3XJrz9GEauJmX
 WvS3cPvtH6nsV+0negj1A3tk9YfNezjPDWNO3cw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:+ifSFQo332NsjY39snD9PexH7xMS7WiO22LjBtHQHlE=:JUI1JDNUvE+hZGBIuGdJLfAILMc2zdrS1/jj6R5cAjw=;
X-ME-Sender: <xms:CCn2apXBu6Kld1Vi_Ov5VAX0pA9G9CHgig3s5Oy9S6lRu82ZsStTmQ>
 <xme:CCn2akdUDBMoeKr0sHTUbnMwIhgVYLQ-kVOTPaMPxlJRhn9V6InlzBv0Wh2yyAH-5
 iW9xKgJDUXg9fZuw1rcO2fGKn-X4bp5VMnzrSpGLuDSCmV8ZAq5avw>
X-ME-Received: <xmr:CCn2atNsmtYJGZ19RlDItK-BtNa16tud5LnfvdAXfaAMcXgs58eJ_a9Ic5xGuI2znYCdDBIhvsRNEsHwy5rWavk>
X-ME-Proxy-Cause: dmFkZTFz5OTn7RgoSG9e1Y29Z635kmlXp773wBRIjaVfPplaexNX92988yX/4RlOyfLEKK
 BtU6m9KCGk8aW0Q7wSyXe8S0BPfzCKz8zbyeEp0pjjinDadO5D/Ng/eIKap5MOCtbFWZvS
 LgMjqMTtFa0hy3aAu4opZK32bnEX5K9ZmFKTkm0X9i/jSRCrc+1Di9GpZf0LNet215KPta
 mTpZJ/zNhvpc17BZpjBcIFV/XNPhtmqZZEHIsnygOzg6hZVvmTtiA82JeprnUmKuEwpWkr
 eYbmfLcnexoAiYnSlF3+xRnX1GP5ocgxw0tqb9X4Bu+/AZsDlBRtOxl4GbayEcBBn90+EF
 SXNCsnAByfXEdPB0sRRC3iaBuFlXOj2ejD4EebDNIppKWcTiTDSVN1tZDk/aGO9NVEC3we
 qiJTKr1LTzc8X/xdRQbk8a1Ad5hFcpPX2h7ZBK0uDRuG2cNFtd717cNUexHObiSWc8ijad
 ee1wL6/ZcpBv5dAfMJ9KBphAw82dm5yRLYpA6XraZgt08O5j1VY5mgvWvS//LElQBzkeGs
 7x4S8CCEL38EFt7N12j2+T17m4pn1cINoRzyePlVbVvKLtpWT19Ppzsoc5WdEaL7YWXyDk
 nxkQddeOpmqOYYH0w4MW8MCpp5mH4ft1zt27I/yuhIbTjZt3NTtholWoIerg
X-ME-Proxy: <xmx:CCn2aqj189diw-Unrpma9-iVXEnM-5-8IX_Uzr7e0AiZz0Z15rF7Iw>
 <xmx:CCn2ao2WlCHX18ezZSwFr3We3BdLQWym_F7RPqbpNHilIgctPp7KFA>
 <xmx:CCn2asj9w4icVrOozT_SEkapM5HaHfte2Gg8oXuP635C3SeRp-pDaA>
 <xmx:CCn2agcMawS2IUO8A4t4211GWBbq7yPEUSAIUZKTbeKYyc3fLN7LCw>
 <xmx:CCn2auUrEC4Bbd73GdygTsPVWEtES9_LmH_Yk2nFx7ux-gf-0TBKL791>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 16:00:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: stephen@networkplumber.org, dev@dpdk.org,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [PATCH v4] examples/l3fwd: dynamic NUMA-aware alloc lcore_conf
Date: Thu, 12 Nov 2026 22:00:53 +0100
Message-ID: <ePWBbDOaRuCbdpFEqlBxbw@monjalon.net>
In-Reply-To: <08a81384-6088-4a20-982a-91843b2ac604@yandex.ru>
References: <20260623032301.17570-1-fengchengwen@huawei.com>
 <20261029120914.32707-1-fengchengwen@huawei.com>
 <08a81384-6088-4a20-982a-91843b2ac604@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > Currently lcore_conf is a global static array. When multiple
> > ports/lcores are distributed across different NUMA nodes, datapath
> > suffers from severe cross-NUMA memory access penalty.
> >
> > On Kunpeng platform, sizeof(struct lcore_conf) reaches 133760 bytes.
> > Such a huge per-lcore structure significantly amplifies cross-NUMA
> > overhead in multi-port multi-NUMA deployment scenarios.
> >
> > This commit refactors lcore_conf to pointer array and implements
> > per-lcore NUMA-aware hugepage allocation, allocating each lcore's
> > configuration on its local socket to eliminate remote memory access.
> >
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

Applied, thanks.


