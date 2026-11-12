Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC639606A88C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=Aq2zkgC7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LQD17Ndi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EBA8415D7;
	Thu, 12 Nov 2026 17:30:07 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTPS id CF7F040E32
 for <dev@dpdk.org>; Thu, 12 Nov 2026 17:30:05 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B13D414000CF
 for <dev@dpdk.org>; Thu, 12 Nov 2026 11:30:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 11:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794501004;
 x=1794587404; bh=tsaS7Ncen6LTwNEyin7eOKU/q0SirlQga8PYmQNOulY=; b=
 Aq2zkgC7PGGeg4yzWqf1MLMfrqSUY+7igORiov4AF3WsjQdpCN5Dy/w7TfoMFNBV
 FimCVSzTMks3jfOBUTiL5KCqdri9isAr2mYaSnD4sOB9E2qrXiWAP1IUGDTg/hDg
 O7HWryzLKfancOItV6ysUdogL3q6AQZgYZmFX4njLSW4cSI+AlkjcVWeqSTzFcXu
 W43MBbZvrzTmJc+C2bkuALeX/LGdl/oMItBS29Qh8Ivex9znvmCtGLJLQH0fmyYE
 pvXLdcewaVwyR0XNG67MdJj/IW+K6fJFse8Ij6ij4xegR92qqLXTx1vcj6AYSvy7
 GT08l1DE+tK1um7qoth1pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794501004; x=
 1794587404; bh=tsaS7Ncen6LTwNEyin7eOKU/q0SirlQga8PYmQNOulY=; b=L
 QD17NdiqHeZLKiI9TKyQBJJdN+H7Xey4eJQrg2qqHnn5Jtb/aXTf8vyclxp1sHzM
 yQhAeGIKun+7Xif2viUdWyvvcvZRtrTpc6i/vhGaNVTi2k58UNWstJgz1zh4LXFN
 QE+4k7GLV6D0Q72NiQw8TomrEm/3FpFhspe/K9Sht7qHwTN0khUGuFkSBS46Rd9L
 x7db4K2CYu4MozZhfySIvd57QntYP3U027OoFo8yOmNhvoU8IlPTjsElyZrRrsmW
 ZmuE/U2XXl2rVOvcH/A7DunVrmc4O5gnXBI/KMZVT+yBCxV+olYhaDplOqckIi6d
 ubxccQgeZ1zHQ4QNEVPoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794501004; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:wpH6M9/OuGnrwnnaTpDT5bMFAv2Zs/PMnnj+fFJFzsv+7wI
 TP1oOYGpMqaYOLUYRHCd9DegP/A6WLyj+zUanrzkXibfzuAOBWGKJ3eSXPo7WjLn
 kHaMcfvd1J+3wWvsM8IdSZHmLmaapgzo7h1kD+ldNMSg+Cs3CPRNj3uYi75h69yL
 Ascw0nGbgNPFVtHBhPFlmnZBMSwjM+1J9+29iELnzzaMK16gszaKSyEev+bSuDfz
 7hePruVBO4Pp+0UukzdQPMwpwEGAljBk2eZ90EVNnJigmKeZQ/tDotD8k4M3HYEq
 vBo+GMC08TGU5NFCUIkkcfiqXqSyx2exBdiXsOg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:4cM8o9ECtIsmXdcucptIywcZGTc+cSuAXJYpC7adziQ=:/m5+Rf7+eXfuKqU8803biHLUcACpROFtHE2VpmAz2cs=;
X-ME-Sender: <xms:jOn1akvKS_eCWfEmlajvtnRFa90R8TOApLZVlfUfg9yZ87Fyl57E3g>
 <xme:jOn1ancjvMISUjhE9iSo3w-ANVf2P1BpiLNwsAPTvwUuK_TlhvCR8Aw6l7rLVt_Ee
 KrKGDNqSUVkqEX-jCVFi2CJnlnLOEBheKy1m_yB2y-O18je-ENv>
X-ME-Received: <xmr:jOn1atb59AlYPQNkY2gz5T-zjMP6krZOaSDBW0RntYuua76ez90Z7Eu8EzZaCYBhxPFMNDXS50e9-uGaj4W4yNM>
X-ME-Proxy-Cause: dmFkZTF8NQzZ76c/lpGiGb5lcLPxGjr477YZqK5aEVM5yadgB/L4HuiRE1Gq21b2a1I41v
 1J6cjP+/xlfNpCM1c+AV1S12vvANlxZkdWB22nkp7KKy+RnKlQMqObQlfF31tDpgN0ByJD
 tgQ/DF2hacQymEMOi+kdB2vip453FOFj4YwXXSLuZ3BGojlGUecZxgrHOge6zdazXvAtee
 LtgjF7evMpWIkwD1LCStOt/WWd7ntQpXRX3BFa/QAlsGWQNXqyOLD160n+5rxor/ZDVazm
 508mpX8fiRf7lbYlaCdOQXT8tuFdIu3UAqTpfti/jC902oCwbp7sRysMw1nrtKj1ogKGly
 TCox4FsWKzj3/cVfBJtxFcVY/z3fMoaX1dZkfpy2wXInTY4s6t9FG89IqTTUJQwkfovsL+
 GSGqTQvTUZC2xpiv8e5MXcxHNWO3iRtz4ANjeu8J20ch7ro6P+V/c6yTZNFAyw1Z2uMaTa
 BjnfjiancghZ7kL1hYz3MO44ukggNw3+ntpUGfTc9ZHCRDXX3yTF0G7oKUaVBavswVf985
 VSqWywL/Xjw3C1fj7BrvnCsxHil0s/uguQl61eUhCQIKrD05LtxwaqxjstJRIOQk4BTjsp
 n3tojdRfUfvS0dQtV2ZUMO0AlcSyFqkTiWjlN2QKHyVA4SaJH6MnLoKDGqUg
X-ME-Proxy: <xmx:jOn1aiXt5mJezXziF0uPhT1ON-ssMfBiDUv9lL0xbKj7s4Lcekr2ig>
 <xmx:jOn1ani0RDOaM20IliXMwCaBpgSCDLs7Hmp8p29DkfHyPOeXuXucVw>
 <xmx:jOn1aoWSnJpazKS5O8up_XsNB2WgoxbwP4hKhe7p_ahNEMIzLem4kw>
 <xmx:jOn1amOTfsSK4MBu_GAdOcqtYL8hRIx9pS1UbZ9LnhvDM9weCzx55w>
 <xmx:jOn1ajCL9QVF3thUi5SXilpQmHKaV-cU-JIxOrEkHE0YRL8_s-1qRLe7>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 11:30:03 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] fix minsize build errors with GCC
Date: Thu, 12 Nov 2026 17:30:00 +0100
Message-ID: <Sue6eQoBTUaFYSgIltkaRw@monjalon.net>
In-Reply-To: <20261015125740.47008-1-jack.bond-preston@foss.arm.com>
References: <20261015125740.47008-1-jack.bond-preston@foss.arm.com>
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

> Jack Bond-Preston (2):
>   gpudev: fix minsize build
>   net/bonding: fix minsize build

Series applied, thanks.


