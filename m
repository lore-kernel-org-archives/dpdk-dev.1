Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C6606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=U9+MWrh2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nr27ZSEZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48C2640299;
	Fri, 23 Oct 2026 12:11:27 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 8010D40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 12:11:25 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id DD1111D001DB
 for <dev@dpdk.org>; Fri, 23 Oct 2026 06:11:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 06:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792750284;
 x=1792836684; bh=zjOkoSLetaSAZKmhs7bS3xdh25zFhamzslBrlJ5bkYk=; b=
 U9+MWrh2ExqxKN2esmy+VB0BqGy1e60cL7Vpfc7EjWYeDTLXlDyHevl83ftOKOtE
 KFxwWnSUUo/qABDDq2qJeT53/cvC4RG21ZTBn/xnHGKUhpaBJ/PQr2IznwStoitw
 oxRyZoZoGH0oQHry+tWGK66szgCC7HYetieHt9I6eX+AiVb1dYFFIZhO8rVEP9uG
 /fDERce4JOFEgA/Jf4jKOD5P2jzOnudctbAE5SmU0dUMMQ7XWSp8ZBeGsQcxLc/V
 KtyTUtBweyVqIGNSpaTZUzOKnR9h5pmyCQM06gOd8qoxuFLQVnv2gq8d4uVRHRSe
 wYbGym96mP6DXiRLA2NkFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792750284; x=
 1792836684; bh=zjOkoSLetaSAZKmhs7bS3xdh25zFhamzslBrlJ5bkYk=; b=n
 r27ZSEZRjgJ1CCVtUKtADQPAZ2VJngtlSY+a8EUCOT24c0acRhKBs+rExmmF3rr9
 0u0VWRpvxv6yljmEeAFUtLx8rs//InJ3sG4IN6Z6hSYR2FvZd5VMvL1zgjq2nlku
 J67XN8SH7Y3kE5hjFXJFZ5q9d2RYdxqwEfd/SjjdB6gRL/olpxWIJ0K07c6kIam9
 iPEc/HAg0xn/phP9ocJ1s9TgywNhQO5KOa3VezOjmoOa4YHHV9dPTF8eZdgf54zZ
 F/f1s9ZnYI5CKMAFvrRMPKKf4ak2bZ7jrL3NWw62qCX14NDb9+WG7c1oZ+qCz4AP
 9wc2Ynstjy4xftm/MgJPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792750284; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:PET7XOVcqeaU3vF5J765wClK0zSGQ8odGxgRPr8IKVNOJpC
 SmnWwFmUdgy5df10R4vq3wYKSG7vB/7sGrbNLnbNDkfln1zpPkZZafDCghW9vTHq
 pQUDbKiRBjXbYLBhDPzDbTWTHmdnGptqPjlr59aGAL2JwVXEFsP4AAoUXVdqVgoQ
 vTsVGr5JlSV2MVffowzxK1+zUwonnd6TGctCKC760cI9h64dCyMJZXmXGAaZkGYN
 TpJ6ygjRR786h7YYDtOswJww0Ez9qRYoNYJie0kHKdlxuAHASWI6PSoJAbPJ2QYm
 4QE4JdkBwSN7o5yrfYOr7jTZkXU99ig7V1BhoDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:umv4pKn70hjRCXEoTgUtOHxgcK9L1GcjXzjs2GccdQY=:Ghbe1OX7Y35mbfort/WlKww2+Nlq2ZJFSqzn/xog2tw=;
X-ME-Sender: <xms:zDLbaoZO76hls_iCK_85q9K35VZxnKNY9fVDwml61xBY429UbYbKJg>
 <xme:zDLbavu_o0cd63lpuBHCWDSrrKWXGzMgfEFCOvoBg2XUc5VfQfnFTIYyjjISxRREW
 0LwK8CWFdL8ib6QDXLPD4UYkb-KXiRA4A1GB6KC7w8FedTGYBN1lBw>
X-ME-Received: <xmr:zDLbaltJl1M5sUBq0CDL_gPWIkb_2ofDPWqJNK_kPDIXxDr-wSe6-pilS93k6cy5pDA2qhUi9IwhLL2rdF1zT1w>
X-ME-Proxy-Cause: dmFkZTGnpGn2JojUICcISrFrAS85QmBBiPWfQ51Fj+3WSlEaLqm5Js3goYFpz8uXup8S0v
 LO2tS0muTdEGe9xpgIZUpffnN+qBad7orkXytNPr2BtRZXJ2OJpXxmHTfuginM+3w7Ynwp
 zaTQ4g9YTxQQH+Gw5TJeuUW1eXoAYOP58OnHsasziQ9imBO9skzh5iX27F71UqhYystvxf
 2E5aZFXc/fDrw5Rrt9m4+Lme/Ab4Raqgfj0vDn8pmoXGdEOOBQS7F7OlTubCBDNiuEE060
 47t24xaq39Y4Bx+8k7jNNGVwfTbQ18aa3vColm2DERIH5Me2podq3ViDUmOUvHTgZsboRX
 ZtG4P0ttOQ8uvmzv/x09Ox89pRcTG37ELhsEVna8myHNSo3Py9YmJR49aBcV/tY2cCnmcR
 rRKwSL3k2fKBH5RFYMAErNwRzEQPdGoG3Y3EWIMk0ACGlAWe8QVnp/nY9yvTvs256ws27P
 34N+m6Hvv1cwoLobHMCwiVaU+CWHCqLz3Fad5glgiXPPRZf+ZGztrXQX7SlxnqRTBMrRBb
 K3ISsw6NlZieNnKS5JGMKADdbESdd+We/eH2xRJUKRgveBIpXoaZxZUeqBnQbUYj5B7fP5
 1L9WzmVO6R9nhI+lShND5LGomSeT333xSk2CEEgZYgSBgYB+/6KZHnF8oxIA
X-ME-Proxy: <xmx:zDLbakedyeVgZVRhBCULsOtJA-UfLnZLU-Mji1nbUydVDGw1lceUcQ>
 <xmx:zDLbama34r2epYTWzzQSJrYZ2Zu6loRthC-2KbgLH6g75GRsN9AA9Q>
 <xmx:zDLbanUDMDjB3f8aU7YZrEKeIeKJ1v__xvbLpVkhOa6SY96jJ8RwHA>
 <xmx:zDLbaogUL59Y6rvCvRV0nElidOYygaY8i4iqJOqbwX4pf_oltO5_Kw>
 <xmx:zDLbarND2GtYy2JbL6wKwdpnwSMAfyAhc0QyRo9cRI50zTCMXVdaqPhr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 06:11:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 03/13] devtools: support Intel drivers in doc check
Date: Fri, 23 Oct 2026 12:11:21 +0200
Message-ID: <83FTH8swTf--wzT6s74L5Q@monjalon.net>
In-Reply-To: <20261022174447.412638-4-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
 <20261022174447.412638-4-david.marchand@redhat.com>
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

22/10/2026 19:44, David Marchand:
> Intel network drivers are located in a subdirectory
> (drivers/net/intel/) rather than directly in drivers/net/.
> 
> Update all_net_drivers() to find drivers based on meson.build
> presence, which handles both locations.
> 
> Add driver_code_dir() helper to map driver names to their actual
> code directory.
> 
> Update changed_net_drivers() to extract driver names from Intel
> subdirectory paths.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v2:
> - split changes out of original patch 3, now only dealing with Intel sub
>   directory case,

Acked-by: Thomas Monjalon <thomas@monjalon.net>


