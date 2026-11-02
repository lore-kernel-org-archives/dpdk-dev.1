Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A7606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=kvcMTuYJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vNQWyX64
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5D9E40E41;
	Mon,  2 Nov 2026 14:18:45 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTPS id E478A4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 14:18:43 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C3BDC7A0168
 for <dev@dpdk.org>; Mon,  2 Nov 2026 08:18:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 08:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793625522;
 x=1793711922; bh=3Bpd7yNLSmMqBT82JM9DH/VzMUnzsTlWfCojRkA/+IE=; b=
 kvcMTuYJYp+9s3tvoPGg7hPPM6tCM552wPHpJD/9u9WzGX2cHlxoiKkfbGddGSub
 VTLg0oTU6hguZVEhWyi9FDPcLLy0+bfm8rGxMWN1ko6oBMQpwOpZslNiO2ebdFLf
 XaDqBveMsmcdkpTutV9iVFNaPsoCnCfWCFvmcNBsM1k5DTpCfV/Fq60O0SUHVOIe
 pxw33TGO0SY+jZAmtih0v2cudfjjMI/sHp12aIo7CyIdi7j7L2COXQsih2H4aOvE
 tTUHc97ibPQzQ1RLLvkVtp8Cyp2/KxjyEOkJreQA9y7FpuEPfdsfbqo3voNK3wPq
 Z3YCRRZDTiWwal05+XDNGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793625522; x=
 1793711922; bh=3Bpd7yNLSmMqBT82JM9DH/VzMUnzsTlWfCojRkA/+IE=; b=v
 NQWyX643wOSJWQGMLSMWUN4GF2s3df+A9dsFc+GXfSWpxj17Nsw4d/S0N7NY9Z3J
 7xRE4vJceeTFLK438ZMwMn4vqkRgY42Fl/HHg/k6h+Hs2ugo4+xHJY91nnvozusT
 +D4bRJbun2N3SVzEclU1GQMZSfgq6koljnehexANZ6Ddsk0eyvlvPTFrjJKrhBe2
 ZoG8pUWyz95bZMaqbk/IAiQeAqeukleKyHf6FyLur+9uwWttgrbP1120xRPT1+mR
 O4zEt5z/8CdB3C8KrBNYj+H5CQn8fqe9oIlC3t1EFMsL5PScEOsaA+W492CO2swR
 F8wliz98t8O8tIwyDAQ6w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793625522; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:eR4Qx6YotXu9en8RVht1z6TnRQ1bJ0mCNGvIjXazj2VXPDd
 Pvu7QEcx03WMaAeOh6AQM4jJH815wMdOKZfSR+3rAnzaiWcxFCwZV6KYK0Ks/9Dn
 5j5ca4CYZM8EQsfamhdDTRmzAHbN8njz7fSg3n0ziDPjbQuO7NeaLSu6hgKOFeit
 uurxDRlXFA9QCzC7JS6A0DTNpxdOWOgU9SihNeu4fQSxTn2If5gtk48HqFH2Nxb7
 CsYyzOUy46XMsvAFBJUu0YPL5FWj/lrL5FtBOZSzrDreZtCpHBNbD38JxNLPQhKl
 9s/FhgobKoPuiziD5id8ILS4M9UgVvevSGQChQA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:TWePYLkGN9oura29vzyh+jqZWYddc0IFmMCen3dM8Xw=:Xxm8VuKqW7Svg0o8rD4QI29hAHk94SPv8a69TOAbmfw=;
X-ME-Sender: <xms:sY3oagccW_6OCUWH2a-IXpLCE8imOLm-hFE25-UIHkVl0VmJa_PvuA>
 <xme:sY3oarKSaRSZf709Cbh4aC-ACncCcU_ZxdxVmnSJ4uR4pfTNdhcgJEUzjZytoFM05
 Ey1--3illukGIy7scWKsEyhW-bZSt33To2YEix8CB5-X6ZE5r8XOf8>
X-ME-Received: <xmr:sY3oatGpEHl0f5kmQV269ETjEvmJbRq57ECK5sXQqqz1h5FK9YSOGwBE__TW9FH0t3wQAOGqVGiSGojhHfRlSR0>
X-ME-Proxy-Cause: dmFkZTEqz9uDl/IA8cc9gk734szg//7V7/T8V+hVmUSVP/plQ8f8YPYBnH2AThvckjyI0X
 pxbJcCtyMCpXMFNBE+BTUlbZRTpSYZ7kY7c9WBn2+lFIODjTQmDTHRizuDZxp/Yt1H+Sme
 RRrDBUThzzaucdMJ6nyAukq/hS9ptkZmvavd5huqtClqkBVzz1z0M6TkhJ2dYOZHT9behY
 kSR+txrEJ96T7HiX2VLHqFIRcaQ+8POQw+z+1oKr1URmTfMuQz+CjBCFrBmNb8CZwTRV/p
 6qkfjGy/+7MflEjnXqY3UeA1pC+EhXhwGHXeIubh5zAr/rLqmgfun7ZM9zYIATqsj/XAi7
 aoOiglYM+iC0ZCyP4lEqShc1V58XFmug8Lbfm7gFDFxpzGwa0+kbzT5clhitEGOMiFr/ec
 y7rJdod5cpl8WF2c1W89Coa7NVW/FDrF2YozTKCgVFDfLAUS1XBySKRKOaQ1CcC5LfSMyD
 1gKc4WchtdEnksyRdl0Tittq7z1bMZkVdQRf5KF3CIR6MQ2npQ5GBy0IVTi0IhdprAiYTX
 TRnfSAQTow4fi+CxyERqIUZy8DIpZ1F8HeNnt0fIYz4g5FS4ynyp604mj9hNaB9igiVXTf
 qyQmh04CwiBTpcSb26FVDqUxUAGQsKHDwcmB8sC0rCvVzurjlbovL0r44jVA
X-ME-Proxy: <xmx:sY3oamBVx0Y_wocsyykLhdlV8hEh1QVDCbudKEcdTZJ9oQFQB4jWZg>
 <xmx:sY3oao_01nZaxrilcMqWNKAYE_LjOHv4vegf-4jNUyX-66JxQe83pw>
 <xmx:sY3oaqAKABOPodd3qXUKD2gfaDgP73_yDqoi1jS7g7SqaCpRntJndA>
 <xmx:sY3oalQVhhLCLzZZlWxU3uixx4MQndzE6AtfkWIZMnDOjHRvLyER_A>
 <xmx:so3oanR3kTCgwE1E6GAIBtJVmRpDEiia2fgNoAeaMmxba4Ay64WhjKCC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 08:18:40 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org, stable@dpdk.org,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: Re: [PATCH] ip_frag: fix IPv6 fragmentation of short packets
Date: Mon, 02 Nov 2026 14:18:38 +0100
Message-ID: <YPo18bbNQc-cAvqus_0ltg@monjalon.net>
In-Reply-To: <6ccde5ff-f81c-4c2c-8bc6-e2ef64035129@yandex.ru>
References: <20261019101333.71145-1-bigalex934@gmail.com>
 <6ccde5ff-f81c-4c2c-8bc6-e2ef64035129@yandex.ru>
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

20/10/2026 10:01, Konstantin Ananyev:
> 
> > rte_ipv6_fragment_packet() does not check that the first mbuf segment
> > is large enough to hold the IPv6 header, unlike the IPv4 version,
> > which validates data_len against the header length.
> >
> > With data_len < 40, in_seg_data_pos starts past the end of the
> > segment, the expression (in_seg->data_len - in_seg_data_pos)
> > underflows and the loop never advances to the next segment, so it
> > keeps producing fragments and writing past the end of pkts_out.
> >
> > Reject such packets with -EINVAL, as rte_ipv4_fragment_packet() does.
> >
> > Fixes: 0aa31d7a5929 ("ip_frag: add IPv6 fragmentation support")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> 
> Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

Applied, thanks.



