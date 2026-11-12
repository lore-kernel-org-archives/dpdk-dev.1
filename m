Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6A606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=stKxlr92;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tJQfI4aw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E13C1427AE;
	Thu, 12 Nov 2026 19:48:58 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTPS id 842854270A
 for <dev@dpdk.org>; Thu, 12 Nov 2026 19:48:57 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8D3037A0282
 for <dev@dpdk.org>; Thu, 12 Nov 2026 13:48:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 12 Nov 2026 13:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794509336;
 x=1794595736; bh=ChTKnUNC1kFG+o+wjEVQYxYY2JmLxXYfx6JboPqEokA=; b=
 stKxlr92AdMEHCA1I969vOqB48CtCAVSLscyfxGcO1KemmzN6YQl2vVgrzGdaWcz
 jiRa1fr6nPaIbp8OrrlwF1ADGFGIStWdayxmZvOJ/H0R1VeYEy1vd+Pgh3vbqsWP
 RDqpOzSkNGDc6BFj5a8D53++gNvki9d8Yrl6rMvvvg1rd3FG/N4pOXz+gcct6TWY
 amBSKt9O69mk20NBd53eiECAZN060iqp4l/hkjLt7D0DqT4159wup+8C316LmZUC
 /mZrtwdOA/UCC+UmHSqmYgNtZDwMhv4nbyEsSsyILhapkp6gnQ0m/zSzBuoDWy22
 8S2owAohUzzSV77UHKMzmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794509336; x=
 1794595736; bh=ChTKnUNC1kFG+o+wjEVQYxYY2JmLxXYfx6JboPqEokA=; b=t
 JQfI4awhDt12rZqJIhJNhiz4TkdfMqcVos+7ElrDClaKVJVyR6tXrmGbL3oyplcx
 eWsQb7dlH0BXceYB8yvfcCicSTny4cNtnFkdacLc5yDku5edqVtRZ1aAZ3i9kddD
 iFwUYlRmtt/44YpmV9mv9TxtWHq5bFKRyo5QZWdidlte8Oc4AFCov/Nx+ju/3Eyz
 cWK7JAuYEl6xk7krxj+X3faKfUBlUHZuo7oe1X8glengidwLMtFlFSY/xMxjiISy
 mlXERuBh2AVi1q6Cxty+94ybLMe5FMShDJCirBUA2BUfjAnycu37I2ym2FpfcBdH
 apArib/CePNu9wUHY2u+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794509336; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:030GRMj0/lsHS23IRrZVfKuNzAMnj2p7u/UgJUBLRUZKEoD
 j4t/qQYT5SdKlLoBjg18IjYKrAQoQ5GOM2fH/l1wAI+C2KwtcDYIzfddAjoYsqKA
 bSuvKQ1QghH4UfUYLD6262a/dVQAMbMhtoWtWHtpV/J+b7TM7oPJ2K9L1lNaFHSn
 mjHlLQBJKaLYtI6tdwIKjt3xqDAPf/Sx4PnPLL5ytyhTxa52OcEtKUag9B0+8sdS
 gWT3+nXO5fJ0fWI8oNlsrDP4fS+f42ZJdbOj5II1hATsQn30I3/Anfv5q4sxt0NY
 oseCdSEkoFSJTTI94twKdorQeDOUZlvxS4JEhKA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Qn7yWAvE1UZ4cBUhDvmLDKjYn4/0loyTksGHLB1zp7A=:37bKGny1dOy1t310yGEFFaXTOmFV287VNkYzyI4e+RY=;
X-ME-Sender: <xms:GAr2ao4ACKQ1xszwYkoyOyGiR9KddBSH9Yuf4P4UM3rFoBDZgfOP7g>
 <xme:GAr2amO9enB7UqqPAJQuo9i9E_N6raR5bTWkNTvgdo1YusPDb15wesKeNWqjuixi-
 tKP67DMpAhoB7EGXKFTrGNd4xVWizsWlGLFLzbJ8tNVCcBC2UjA3oo>
X-ME-Received: <xmr:GAr2aqOerKr2bjSbe4EHsnM8ql3Uw9pTPCEtNT1SlQHPGl9FsAoVihGF4TlE6EBDd6cs32r-l3EfWy_yVZb0iRY>
X-ME-Proxy-Cause: dmFkZTFy8s+wb476uUyCtcSJ6mPivjwajFeLA0L2HQOcoWMeEnPSm/i3fdtfjqlYVMr/nx
 CNbZ99KLjHmbYXWmzDaYQ/QxURH9pJm48jql6jOIxRRFEtvqxMQ5lOP75vZUy1U3Zvv9Je
 LAB4FW48+nYXQg/lgNUsA/P2lkI63HrI1TTXajEXWC0mb11AHGi1/ws/MoI4zTSe7SMBr2
 UPwg4DCnaYjlpJ1Gtlok/z3hvSsJcIBzCC+HH+n+TJ+v9q3QwDoSaCIM5LF1ymsGHR9dkX
 Gh7wcid28OaJ1QRjSfL83tV3QZ7BdOrCAfjMVr/D7lCDEaUMAB/N/ifOPM01bTWqO7XcT9
 7Wvnm8Wdpjw60UpVZe/TuJXow9Sipqx32+nhHK/qENd6uUFJC0W1eMLG8llFsB4//Q+bN+
 DoL9taH8MldoCjc6kqQlApiJWeXbx3bMOlDDfYePWI+wBYrTYI4kU0BG3XkXTFK1BizH5r
 7e/DcsWauWGHSqCzIkKbv29KANlVYijITnhSjvNW36aWIZkNYeHrOMkJIb2ww7qesas6Yy
 bYX0ygG7vVCVF/6k0Q0FNCx9dCgri5O/MszV8gkQldz8FWJTePhNC1FzDlRYQmhhsbpQK8
 drWS1T79jwWTI/lFWSpNgHfj8CDE08qoq5Fh3/oEgsNH6bQlp9H6jtTCqWbA
X-ME-Proxy: <xmx:GAr2au-c3TLEPMjmFeF0U-jw6OlxzJy35lLudBmwuVq1IYviXMHPgQ>
 <xmx:GAr2au6B9-W2-fFR9ZxAeKTQVNHHUaNN40CyqcaRPeonI9pEhyfUkQ>
 <xmx:GAr2al1vYJxDKJ8NnUseGBTyygskHB7zdoauWJRInuzPPquj99HffA>
 <xmx:GAr2alB2n3I8zfvEAwVVKJzFrSsmSX27g1C0ErQH5pMDMypz5Wq_YA>
 <xmx:GAr2aj5dzEER01vxl20BSFKaTzuicgd0xSPvlQmJ20gm8zSGa0GcvO2I>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 13:48:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] test/pmd_af_packet: cleanups
Date: Thu, 12 Nov 2026 19:48:53 +0100
Message-ID: <OGT2-z0UQRCnAsxBqpSHdg@monjalon.net>
In-Reply-To: <20260622232100.63865-1-stephen@networkplumber.org>
References: <20260622232100.63865-1-stephen@networkplumber.org>
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

23/06/2026 01:21, Stephen Hemminger:
> Fix two coverity bugs where fcntl() return value not checked.
> Also mark some other cases as FAILED instead of skipped.
> Such as failure to transmit or failure to allocate mbuf's.
> 
> Coverity ID: 503765
> Coverity ID: 503766
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



