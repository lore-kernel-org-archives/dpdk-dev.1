Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7046606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=GiOuU/i/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Y9rG2whi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F7734270A;
	Thu, 12 Nov 2026 16:07:29 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTPS id 23D6840682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:07:28 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 1B77CEC05FB
 for <dev@dpdk.org>; Thu, 12 Nov 2026 10:07:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 10:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794496047;
 x=1794582447; bh=RJpPjWS5YPB98S8DvGPM1oYBHsrAh4Ej6s8H6e6C2T0=; b=
 GiOuU/i/Ue+I6VPUn8BqzoQRW2WU05HG7g8Iq3mSUMTWCezmFnEfY7XXvHqY7GWh
 RIZEI+yYZazakv3hJoZB/0LqYlxX4jdui+nF4+24a0wAXU1NiKsXVY87zxtZhttP
 TIEZAclEMhi3hDIHX4mkHkmUU67o66yff+MnwIEfoG1YULlWFvadCCDeMdbt1Byo
 kyv1samN44BxtBheTmJ1LxwzVGEHg+XH6oIxYyQLdZDQsIRevqmpQQJkMGhnXNC9
 c3KTJreUWIrGAsLcpHVQUMcpXH2bIwetSxtlQhRdeOAJCyPH/bHEe4OSvU44wvcj
 R9P8zoIIq/9gIgy0A77LSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794496047; x=
 1794582447; bh=RJpPjWS5YPB98S8DvGPM1oYBHsrAh4Ej6s8H6e6C2T0=; b=Y
 9rG2whifM4cmnbIKBnVCD/43LLAmPTDjaf7aLSJAH5mSTZSmevlgp3RlMRPZmxgc
 Rggl6wuExrUDHzbmSz6dFzbfUobVw4EWjNuQ+iB+rg7Mhb9qG5/nSwGed2EcuiLx
 rQfMxaoRuDouowTCf4d//49w+oWD4WJIt/om5E+tZZy4FH/3c9HfQkDJ/iFykPlT
 S6aDzsayTesTPJDl8jq46R3xMHd3B+ro0wMEqw3cGxELljk9P86RV3nTIDwrycXu
 9iJ9C1tZbh94TrmwZjUTddMp62/vO8UxLTNzGxIgexSOX9XtPaS1QTB8RwOQcQQR
 nWPexuZOOtEczZUD/K3zQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794496047; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:mWeJZZrBg7CtkxjrES5/GqJz4E9Ys4dLgBIC++e+zhoYZ/t
 h1T9C+a/ZDTe/yqwG5RIc/dvi7KN3kyt/Ngr+iuYGqwQjCOQx8SsfnqBf+PXKMqQ
 kVzIhsol94u0qmoGZVCrYqy4+J0swq7+cziWtOjPdp95bHshpuUKZkiiwAIM70vM
 xv5pxvKcFCCH7hj6DslbfidKHFKCBaTnVZOTQQgS8T0xEyu1u1UPz0j4X9N8lyZc
 g2NpodpaEqN9Yv1xTlWvTiryi1nMm/+Xaedl8kXNCZqM3BwT/HjztgXcDh6BaIaV
 PU9trfA2dH9/Pt6jW6RGedOFdLeoNZq0dTjD9rQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:kcX8EsSFj/0q+30Jb73IsEPdJjzX7Sr1IsNwCZX2v3Q=:WNWOeb61JAUoyubAfmv70ie9HYUakNIiT8MYm6mK3yo=;
X-ME-Sender: <xms:Ltb1ams9LKmHKqyTqPOeTuXLBoNAzdjSqN2h9QjoAR17QUsWMPRzXQ>
 <xme:Ltb1arnJOTpme1rp888Ly-CuTZkbwHs-v_gSwHBHjujVEVI0shjS8D2R91CcxzfAh
 K6R45g_SmVcnp78jw7Do5Fotovgf-zzqLw0YbrzSpP3liMW69M>
X-ME-Received: <xmr:Ltb1apsjNohaq4wWW_jcG__SfWWoXA46OB_QysEilpFynvqcZxI1PMGp3JS7FrnC1jSkRVWUbAuJnp1iztR_WCY>
X-ME-Proxy-Cause: dmFkZTGRG5vmJzUxbU1WXWGrdhST52Sqy/NfCc7BfOrkhWlR7mFTprdlN05dP7I3es8XP9
 RgFfZaQB3JbHMLEar7S1VhiO5Qt4lMmRDD3MrG155GokVin6yqR5DixMEJjOsgDA97bnbC
 jrArkRZ4aRbE20Py21VXTLXjtz84qoRyf0zWZSlNBjGsrskkcuJsVdOMdFJQcAMrQ+CELZ
 +Opbrh8FWhM1ou5bwd33rem3rO16eV6t5/ZBXmM8lVopirO+fgxZ1E8c5YSwUPjwq6W3Vj
 2zBT4UhMItdZ6HTXiS2qKzRGPNLSkPNWKB6OoUcDZxfWNWBnTBHCrDMQnPxEnpHhFRWfmO
 cZ41blez/PeTEyoeh908GFtFTm0AVQFFtpYPoDiOgDNap7mnv5b99hZuIOLVUeB8IlXnYT
 rY30yOtnd0Pq27rXp1ihsJMaFrWuZMgwpelvlsRBaX0zJkdEFBNvE6nmLrCsrBu3+CiK1k
 p5JpBR0h4sJWNij1ik17ba+KNMbc+Q0LPVcEhBFgfaGr3GzQ2cO571m5Enr70+VXvWbsf5
 Nl42ap9xyeyhWAPkuJz8D2aG7EdsTwgURC9m6KZ7NmioiHBhTbuEiawrhw2PI/dPkHkw4x
 A9lQn4Fg8t03VrRJSCnmKK5lnYzO5AUlD1x8zxZjKjoR/OX3piYVQdxJa9Tg
X-ME-Proxy: <xmx:Ltb1apcrHUMt3TpDgT5e_8mYrZ33Kpdi7cTVZ74H26uitYmUsqZDwA>
 <xmx:Ltb1ahxHs1ezlauQtxTAGBklPPIqR4YWaqibHAvdEKVkfwBV-l8Rjg>
 <xmx:Ltb1avF8KBhfcyfa_yeFo8BP3WR5csOlm80Hhejjcsc0OR5GGK7yYw>
 <xmx:Ltb1alzu6oJlViGC-uOSRFFlkt-2pCjwzsXd9-3o97ESZDwf45mUAQ>
 <xmx:L9b1atuQuyx2S6jHMxC2bkihqlI4LkPGE1yaA1tIZtCxYVTuqUnE1EHo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 10:07:26 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robert Sanford <rsanford2@gmail.com>
Cc: dev@dpdk.org, Robert Sanford <rsanford@akamai.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 0/5] fib: fix full table overwrite on address wraparound
Date: Thu, 12 Nov 2026 16:07:24 +0100
Message-ID: <FjTiLH5pT-mRx0D6eYXzTw@monjalon.net>
In-Reply-To: <19f447a8-3ed6-46c9-80c0-39d746db6722@intel.com>
References: <20261027001423.3028072-1-rsanford2@gmail.com>
 <20261027145405.3454251-1-rsanford2@gmail.com>
 <19f447a8-3ed6-46c9-80c0-39d746db6722@intel.com>
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

> > Robert Sanford (5):
> >    rib: fix undefined behavior in bit test
> >    fib: fix full table overwrite on address wraparound
> >    fib6: fix full table overwrite on address wraparound
> >    test/fib: reproduce table overwrite on address wraparound
> >    test/fib6: reproduce table overwrite on address wraparound
> 
> Series-acked-by:  Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied, thanks.


