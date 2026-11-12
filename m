Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBF606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=rOkKVjjc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FVhezFCF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5957C415D7;
	Thu, 12 Nov 2026 18:00:46 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTPS id 08C9140E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 18:00:44 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4278014000E4
 for <dev@dpdk.org>; Thu, 12 Nov 2026 12:00:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 12:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794502843;
 x=1794589243; bh=MTUESO9OBHkeyLy0HSnqUlmFlYj2+iyTKFaprksHpBs=; b=
 rOkKVjjcSb5m9Kk+vcwF6YErJRmbwCWMShcAxmN8Lqqi1k6DZgBphtGLuYBjtg1K
 uxU6Y03kqKMjUzlUkKD6toNCR7fXlHP8UJTEu6GN/4VnDCqYwPbY4BHn1FtpFX/o
 0VBQvFN1TcGds8k7c0STuH0s4lD/cCUzaj//oRLe3ShvRNSd01bv6VuHKdrwypS/
 Uf7XKI01NWp2Mf5DpRqpbuXugv5sfuwYGUlXwcvbYzeCgLZ39QFlJyqsZFcehEvY
 y3Yo9+7So7tjRDKbAKE344ncvacVvprwOEgC50B9X5tWBHzytqw9ZNWhAeJfAjKN
 tiRVxdmqRzuMo9k78yDFvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794502843; x=
 1794589243; bh=MTUESO9OBHkeyLy0HSnqUlmFlYj2+iyTKFaprksHpBs=; b=F
 VhezFCFmJedTWKSMeOULnXEz/UlpwBZfSW5csJpNJVaAPHGsI/ID+hkUspEVvv+c
 I5E0YmWHcou5o0u5SSiAA0wrf4uxakjBBCzxTmO2EYWKQTA3uWQcFUSXjCLahsJM
 GBCiA+1j6nnC5tMq24z9QMOEpr7mqE/9IRPeIUeb3DZNGludq2IUVrQGIpb+NwJU
 xxQlhRwNdlWdMuKwFMYGNjQhoOuX5bYu6KpCMNYwutGbg1ZevkGIOTGpGG8MewPK
 FK4D+MBrLllp5j8UWPPAWa5N8s/Ta5s6DqpxrgSYpcRdM6CprqeRONC9gQfMC+Z1
 xyebf2UDSf7EpsuSzqtTg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794502843; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:Ber+dI/1x/6/ptPwHZq1XiYfRMx+vVDGZg5LFfuYLwgtfSW
 NaUPLtqwLMLJIrSJEbVR8qR76pRb3CPBAE7tLqUGGRHB/FQ62FinvW2pouTw0wrf
 mOh8oH7TeXCo5ctmYe3k4oG5JSjGQSDhwbrpUg1ShqTpBiuJ3VlxPB1z1ZNNRkdq
 lhz3IdAyuvSTi5VZ1yYF/prrjnK/KdaBQh12ngJdKa85Qgg6CB/DR1n4RriQRg+Z
 r6EPL0MxLq/AZot7Lstiv3dIRUG8oe0ZF25rBo0jCEz1dgyS+gz4d7W/hCvwTgUp
 46P6EplDJO/Ow5LtYDHQM8I1oEKvA2JYbNJ0MQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:+MR9OWByoujBkhkHzrm74MT9S6zcAY75wJ/bD/fldJg=:MTUESO9OBHkeyLy0HSnqUlmFlYj2+iyTKFaprksHpBs=;
X-ME-Sender: <xms:uvD1ak6i7ZC0HHFvW3r-O2NMIji9YnZGrkcjT8MDacUpncLYkmKX_A>
 <xme:uvD1ahV9fsd67tcUsgAaQOrfmYng0BUltY69FxxZHnjjyspCsjyUXvtiW-nN14Up3
 vjRaWgDwXBG8UQ3ythlL9UqL-Ulf_J9MW77jQVM-Qp8lkfF3gMsItM>
X-ME-Received: <xmr:uvD1am8zg6LJeU6KIru_OID1WJDOIQ9DeitLEGZEXCGW1gE4PUnyDRXMckBci0ZQSQK3OXD3Al-HX8zoiKEkSDY>
X-ME-Proxy-Cause: dmFkZTFYLHv8fVkJgrnIelLG3W+VQuqo/aodVuUBPCoO67l0L35rI9fVhRZosVp/L5W2o/
 P3X7razm+Rtdf9CCO8/ae+ZCsMvueqy2rB/paU5zU9bUSGBlDhUndga4VEzfOlWdU+P7Wb
 e8XzgSrd5AOphqm3qqtsuFWin4cNlf90eqILQCLM+SaAzxnQeEY6LAYTDfeTbkfnXo4YUp
 pHgj9p/3gMsk/vSQOWJ65sU+TCnnfNlw4/q8w5NYtOIjlrlGw+aWp4C1chaRpDSdT4v57i
 g73qxul1N1Mm0aw8yzHdKZ82CU4RdzFh5HtCEmgtflF02SZZZfLqjowzdxrYbH2YIyRSoS
 nEh3+RZHa+S8h3ljrwh++03GMQTgq8+2pZxqxooGx/FM8UhJBi8AWr3kOWib2BKPoTb9Pb
 hjOaN9eRZGHR8VOlhvQWFkwGyM7C2FuWTmtJis/CjnTM4rV59ICpt0i43gr3myXNzU2ToP
 zfoWG1zgPS44atcDbo+1vg3qGSDBPBijej1vB3/hIKAMUrBLZRKCd96Bu43s6qQSW/j8I9
 7NLWiKKHL6vPyBjZze5MIs3e7Fi0c19AWngqeqQAH4eG4pHvNbWyYQRye4HWbfd0nQ3c57
 Cuhoy0iRxxQBtxo/JwHwJ6rKTBcOttMf0RHUhoMcOqixNf5juXQGA8sK5wQA
X-ME-Proxy: <xmx:uvD1atmGk9neHTvEAvjH_VBa4mB__lVM3oDXq3NaXgnSPGdalaydaA>
 <xmx:uvD1akXzFVDvJsalOCPvNKKLIwuXk2N_Q3Ea0TDCG3qCgwIvo7yg0Q>
 <xmx:uvD1aqG8JXFndtEJdlP8orTmORRX4bgiHDk4ew0ww7jAIDtXgD4kdg>
 <xmx:uvD1aoezC8yWcUk8SuE5rKwMX54EwRzCYKtbTX8RSfNvffacPI-Amg>
 <xmx:u_D1arJt5Fydd_dQqE31lRxVCPv6k8xR3uKayGLtjV5_zBY70Es962Zl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 12:00:42 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, hemant.agrawal@nxp.com,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 0/2] DPAA compilation fix ppc64le and riscv
Date: Thu, 12 Nov 2026 18:00:40 +0100
Message-ID: <r2kqH2i-RM-8OZ4ubzaEuw@monjalon.net>
In-Reply-To: <20261027093335.4109017-1-g.singh@nxp.com>
References: <20261027063131.3979699-2-g.singh@nxp.com>
 <20261027093335.4109017-1-g.singh@nxp.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

27/10/2026 10:33, Gagandeep Singh:
> V3-changes:
> - fixed num usage in bman_release()

v2 was squashed in next-net

It seems a change in v3 is not merged.
Do you want to rebase?




