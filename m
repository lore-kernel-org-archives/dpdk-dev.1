Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE65AC43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 22:46:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7315B40274;
	Sun, 12 Jul 2026 00:46:16 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 37EEC4026F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 00:46:15 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 8E9B3EC009F;
 Sat, 11 Jul 2026 18:46:14 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-05.internal (MEProxy); Sat, 11 Jul 2026 18:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783809974;
 x=1783896374; bh=fPF94KOvSSxoYmsQxA6fGoyrSP3R/1uFDvdsPs0x0WI=; b=
 evKV+v4OzTdDzUddGB52Auas/Vkn0ipTjvBEJKYAmPZjUDSCP9Kzg5nLcW9+b12u
 xf9kRk8XI0xrcOshM4OIXruOL3NpAXiI8j5sH4lLa/1V5kzzWqx5vzB7fRbreE5N
 QUpH38ur3erRLiWdNVBG8SdZnwAk9DN+dRl/8L7aGwi2VQTfJl4NuKxyGCBzlsRT
 zvk+T7DQC94hxAmN5eWqYPjSJdK6VwMEJoA0T4+5OF3QekeDna3IWV5LAN74J+ED
 O4dBkbZAVxM9nej+5rTWPCRR7ceFkCEL5RHoh9ioaOAkLZMxfH695xuCxdCVLkbY
 Zw4VV7dLKNt7L4359YGzfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783809974; x=
 1783896374; bh=fPF94KOvSSxoYmsQxA6fGoyrSP3R/1uFDvdsPs0x0WI=; b=a
 ubzGFwpEpJnSloPyjzjfTa5HlH7T2UPYUSucWlH1zttcl+SlzZxgLnNHsrPIFUCu
 Y7wpw1Xb63AqmKeB2SVhHTbOxlviJflDt7y+IpLyXrIrfUVoiZdSYq1+5S1unFpF
 EG/jaO8G/OiMkYP7CBd6+x69SlFU7J3wzSn9XMBR8niYdexSX3opZtHwjnAjsTZ5
 3DMWoHN9PqlQiU4Sz/zBx0AzTc4sfpy03P69UoWk2gaOeYDKKlBREL56o2SrsmEh
 VrDOqMZoRcFfheRunqbF1ge+hzAMBWYZPbZxNwbiPtVxWPYcTsNzE1O7WHuWL/HE
 dj9nPGeScP5syKbXvZMsg==
X-ME-Sender: <xms:tsdSakxkUOmYhzBpGImiTUin50vY8NRJIer9sav9nqaDpbRzIVmnEg>
 <xme:tsdSajHQ9co_TMHe-GFYkp7tpu84XerCUMULdlEM8eP5_FHz8izTuBZZb_E5hgGs8
 e55CpYRSPKW4cqWS48Ua0ZitdeJ1mH6-AH4KPboMp9ihXud8jQ-eQ>
X-ME-Proxy-Cause: dmFkZTF0i6L/xHQhshmcxsMeaTu6DAh+9s7teZmC1Rv4qchZjsynLxCiUGv5+2WoogvnYn
 6yjf1z8ial6vGrqR0OhEIC5lTa6AuSaWAlemM0NxlCme3u5h+s9ysVCvHtD4+IyjPITx2N
 1Zxa5mLaDmD9vZ4YZLaNPYZWnDe+IDPIKIoRgeFVs4tEBTK2OaRJp/5cvBaOKMgGRRghSJ
 XScHXcjfd3/aV4IepiCWF2ZyEtqtNsAbCLt0cH9oVpDvrXE3tlmFNjtpFRSOjiQbShJDcf
 V29zs42KwCWlLhfqdrYnphdJNjtlu51gA8Ugkiy1S1KB7oqhrTgA4u52RZhH2VIRNfwjX0
 l7ruaqzBFsmidJq0hFxC0ZdnsnKuRIBguOo/IGcKPWp5cI/ma52JE1jK55sf/8/xFj7Kdy
 wrcHuubwi33kIUZKUsr6ka4chVGs8WzjaS7SG+BhASIZKfsX5KB/M2VrxZmaNk/jduHtyu
 BqdHVlfVw81QP3s8/rydftSE3kqc+nVI+7d1yMqoMexYlu6fdqU1cUbKgdyJFRcbKze4yk
 y1ZTwIk2bJOcPTBRyhUko05ktoCgPoiJayZlF06bITnYHMg29g/dp8qhzlU+/vXpMVWqqI
 JUHsT9oOqEgtkAVKlTQqZ28PBt4epmCD6Y3EnwJaUYQBA5tqrg6kXk+Ht6dA
X-ME-Proxy: <xmx:tsdSahSZ2b_WphozXv7-az4vHUMpgFyabmrDxzd9BV322zdDej9Tag>
 <xmx:tsdSaiMdcFfy7-ZioQ8pMEXe_AgwUt4HmXxchsRDYskzCLGzuY7Uyg>
 <xmx:tsdSakPiq18DFcASV4nkiy9eNRiA_SumNy7823AASTkWlBbeaD1OcQ>
 <xmx:tsdSaisMBsJP5GJTM5w-HHaZWf85wFnNQTlfuLv9CMqYOp3SxKYHxg>
 <xmx:tsdSavCXZpL_VwvHoLpgJO0dNZt4Yhs9goXOsN5aeKnkAFF5DD7D7O0X>
Feedback-ID: i47234305:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 3C8B4240009A; Sat, 11 Jul 2026 18:46:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Sun, 12 Jul 2026 00:45:53 +0200
From: "Thomas Monjalon" <thomas@monjalon.net>
To: "Harold Huang" <baymaxhuang@gmail.com>, dev@dpdk.org
Cc: "Wisam Jaddo" <wisamm@nvidia.com>
Message-Id: <b56380ab-da8d-4642-9f07-320c6e948ee8@app.fastmail.com>
In-Reply-To: <20230312020009.288-1-baymaxhuang@gmail.com>
References: <20230312020009.288-1-baymaxhuang@gmail.com>
Subject: Re: [PATCH] app/flow-perf: replace RTE_BE32/16 with
 rte_cpu_to_be_32/16 for variables
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

> In DPDK, the macros RTE_BE32 or RTE_BE16 are usually used for
> constant values. And functions such as rte_cpu_to_be_32 or
> rte_cpu_to_be_16 are optimized for variables.
>
> Signed-off-by: Harold Huang <baymaxhuang@gmail.com>

Sorry this patch was forgotten.
Applied, thanks.
