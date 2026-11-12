Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33630606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=ZQX36h6u;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A7OOyPCV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BA494270A;
	Thu, 12 Nov 2026 19:42:18 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTPS id 3A327415D7
 for <dev@dpdk.org>; Thu, 12 Nov 2026 19:42:17 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2B77F7A00CC
 for <dev@dpdk.org>; Thu, 12 Nov 2026 13:42:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 13:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794508935;
 x=1794595335; bh=jZ68XnaTEl9nlaVmKbmvEPVo6Dl7m5dIpeeY5NUrTko=; b=
 ZQX36h6uUbn0ujUE63TvCm5hSs2e+f/VEj4eC2auko2vD7ZIUxPJaY54G45YEcRk
 h2OT4pBuiQEfxpmOKKjwCGZrNc6eIcsAdOobLOVQQY9Sg940r/2tQBtFYOutJDOn
 untoIVsPXFX+3V05vfMXOmWT9Mizvf5O7MZn4ojWTNbAkIGx/c14na6rAy2ufMbE
 OYLAkqcf9p5ig85Wu4ZlI6H3HL0GEK1vjU2Lw4XhA5eza9gqChwB0LelnUuvWQFX
 GbVtBmwUgxlz9KgwHaTHj+MhgcTanwZ850PaFAz8tM79U2NnwCBWP1cSTLrW0Ejm
 3UbtlVF/Dk6+FQ6Boo9vxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794508935; x=
 1794595335; bh=jZ68XnaTEl9nlaVmKbmvEPVo6Dl7m5dIpeeY5NUrTko=; b=A
 7OOyPCVSr2eAfRKzUIoegp2tJku+DPKS8lmXiYj8NSmgiNQh+A5UU67r0rkIrxo4
 57AE58+Okr1YgFfoSDrMhiXNC3t4/yrI4JupiCQfx1e6hl1B0XTB9lwc+rS5Wr4k
 ieDFAomdrBL4jO91sIw6wyuHr0h6M9gTKKEMa6w41JnaKkswHQRHs/BkjySgnqEr
 EBnFkFGf2NoiCl8DeBcgmy0qteDcuwlKbdjscoTnESb8EHbon/Zb1t7mVf47/j6z
 2yf3ZF1P0hV9jxuCUuv8sURjX0KEjMSA92mbpfQ4KSm9dSnMOru+j9vXXZDSLNlq
 MqOB8PPQsd4EgzNq0JAfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794508935; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:XihV2Rc0uHlWV61D9p7Rx19ig9QGgLPcib0HMHcHq+mGJIJ
 PLG/ydstVYW0Y1Qxhz21ANhyr/d77iHVdEqKAqXl9Ca/CMfN1INTrv//dQjwyxza
 UNAyvHoqtF8buyWdwRAp3NHSwqRkI2yReAVFR3Zf0YGmuNOg/OfNJdDMVi5jAjvL
 KKG7Y7Q+IOlAvgUbt6NrtUbF+fsxHO5TaZ5AFY9y/WG1nzxNPBtXq46dl/T7TsKI
 a3IKv2QeSkwONA6bpGpo9bBohjKhUMS/M2nite46+BSJ+XFm7qc0/foHh/KOc2a1
 nJSBCAiYwzGI3/aLC5AChzfoiiDlLc1sRJ/AayA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:pnlwXLQVKI2gjIVLx4o7Sj6Xit2PcBwn5TuOv1Ni+bI=:KgsV8AF7ZTxYzj7crvU/UulS52KE9tDM7cjZ+ojA+0w=;
X-ME-Sender: <xms:hwj2agq7LbQmjtOUlG6fcHV41ACHIaW4qAKnZawBbBWMrppSD-gEpw>
 <xme:hwj2aq-KU4SPUU6pyvgPcwmW0sKxmCkKUpDyvt5MiyaObPPRtPezt54_JyEq-PfbK
 LjN-3t5MeHQa1VxGSWSSUbNrTQO5Z-VGOZSDfUlWCUJEtAYdpacag>
X-ME-Received: <xmr:hwj2akX5E91eH0IjHxosTpWtv_qFzNQURjtxeSSOQx4fHSJ_Ocweu8LkyJCWphKSuxjSbitV0jhVIzxm9LdYgEI>
X-ME-Proxy-Cause: dmFkZTGc/zRQU6vectHT6mmAVhyUeFovIhfeL0iE0NeD6EBeoftyFBGwr05d1T+bUgBek7
 rCh/bWT+oH1/MCpxzkipnzBa+l+dpR5KTCmzWAyDZgaGU7qQt9mkac/1S1AXQ8q6zge65C
 NQrS66amOi9sPT99Kqg35WvG91fFwpULPYySfXvLeSvQsvBwZgUweotqZl5g1vYpZ2CqrD
 X5vz8y25K6y9+Z9WZTGpcBslnGc0+CZw+6bFan7xGEEjHq4i3gAuzDDb/HrP8OqZFollFv
 v6nC955A16yLnv4LIKSA9lL8DNMSby/l2nKnLaRBsGaKz8neLK8uUetGS5IYoE/g9XhZTz
 PaelKqjlEakaPXHgS4J+qT3JiHVMx8J5B3jeS/OX4AydizzNGI8LPePSf3MAMKgzWEtcab
 NSt74SofxPyZK64nSqfpmQeW9eYiO7U88rtXHOtwzRlX8M2035YWJ1R0Jkew8Ommpjmoo4
 XodLmBKcNBbhakqbfnJEm5Amn3RkYSbi3iVQqpm2IcobGmfcdGAsIo2mRr5UxvZOO0DHUn
 WqznrCrvqD9JYRsaCRdZJ4fDBgvMYFSYbCyceFjS4DhTAggy+Nd+MB05sXrGNYto2RlE6v
 H0VcoAcr48rpQd8Ww8sBuJnb9IBjkgirVW4429cZziM2I3X73Q2gaU6fQPJA
X-ME-Proxy: <xmx:hwj2agAY42YBYeyG1tgO7wvdU_84Yv8rj9lnpbnkOXsszOu-ZdEfrQ>
 <xmx:hwj2alxAvyoLC-TOwhSsYOLZrb-vOpOyD0GTsCB_cx6T4KQxA8xPBA>
 <xmx:hwj2atCS2wxtWce-9znGglcXShInzLLshwPWMzN7FvlwtJ9_uKB9QQ>
 <xmx:hwj2aibeheHV_qGoXcDFT3EiXkzSKS1w2bmOG-A57fHcYVrwG9Qejw>
 <xmx:hwj2apQEw3k7eFCSuFhx6q-0bYUPMUKKKTGO_d97OBVKURG-GTf_9Et6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 13:42:14 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: Re: [dpdk-dev v11 0/2] app: add cryptodev validation applications
Date: Thu, 12 Nov 2026 19:42:12 +0100
Message-ID: <aoLxq0f-RTCUdgN0nuzopA@monjalon.net>
In-Reply-To: <20261106161441.3818963-1-kai.ji@intel.com>
References: <20261105163151.3744179-1-kai.ji@intel.com>
 <20261106161441.3818963-1-kai.ji@intel.com>
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

> Kai Ji (2):
>   app: move FIPS validation under app/
>   app: add Wycheproof validation app
> 
>  rename doc/guides/sample_app_ug/{fips_validation.rst => crypto_validation.rst} (70%)

The directory for the doc must be doc/guides/tools/.
I've fixed it and the dependency check message.
Applied to make progress.

A quick AI pass shows some issues in the code:
	- bad timeout handling
	- MAC validation
and in the doc:
	- no mention of the Jansson dependency
	- no link to the Wycheproof vectors repository
	- no coverage details

Please address in following patches, thanks.


