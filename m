Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49828F41807
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 15:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F980402BE;
	Mon,  9 Mar 2026 16:27:04 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id F18A640261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 16:27:02 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b96dc65b886so257435966b.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 08:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773070022; cv=none;
 d=google.com; s=arc-20240605;
 b=icNkzsIDup6LDIMTbJGhso+KKB+YVuArOLRY4s48sOGUTbCA1V45gvnC9CdKcU10ou
 kR02G6AxAx0I0HETSlumitzQYPcdM4fhMV9FULCnUYmlOoRn7Jm/ttyOiINRVpJZSVxq
 ebkvLOm+2PF1SNUceQRZ+rSUCooFQsPX5DOsIlKerKAwogZh4Ty3wmfCxN1TN/TU8yDw
 Nn1uYggMcNOfSRMonCpMZTQCo1qwnjyo0A0rF/KVm0ZHM62nI+a2FgK/cLzqYx+7KdJk
 Tg/kFz5RNZwETNszdagDS9yfmQ4YOlrYVBLh8iCE7V/5JEU94rNANONzg8F/9bh7PuQf
 9ckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g484rmLByJB8r4pqOpxukPq+MrzGd7QR0u1H9f7Joog=;
 fh=REWM/rlr96AAeqjYDTLYIUcLcUOpkQse2N/Fg/YI5W0=;
 b=HrvLagBCsLURcY69k7KBYloXwv9u0nG14Rqhrehvn4AOjiNQ/zTFNXmaOyd5Pn9YH2
 /mJDtqzvYLR4JsjLLPop4G0jZQYH9qbSLYOswi74U219JkXhU6EAslodqQBNiCc3wSck
 b8HDMj0lptHwlBjEuRrPwP7poVPluCpjdnFBU1Afo8igw448YrtCo1EYjQfIWx5m9utA
 sEUXXcYoetKmkdpU8DRFst4Wn6hgZeLumtb2XoeIKuNa/ofVQ8ZpqQ16akv/2GwFbKrc
 suzKuGlIvgTj+usiFGvrxpexwhdF5AeTRSPx4L7zcKlRQw9v/SF2dOncPmp0bM8qycCx
 IXuA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773070022; x=1773674822; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g484rmLByJB8r4pqOpxukPq+MrzGd7QR0u1H9f7Joog=;
 b=e6GAnmC7rvdTqF6GvQZM3MfLLpbViONx6M21LIi56JmVzojPIyNvLqRAlBVgkEZ6Ip
 8F8lESjKqjUf650fFfOzca4gWkytDNgeoNbxoUdeMtFrfpLc1vOQxZK/Ppyg11fwmWCL
 VFXh09osvaaFfxBPxb02PvbLJEy+c9nceGrig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773070022; x=1773674822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g484rmLByJB8r4pqOpxukPq+MrzGd7QR0u1H9f7Joog=;
 b=jnJUWv6ik8PJrFMLIrSuTqUmAhwtJWc5vSB861f3eKBl7fs+qJkZ7mR//bF/0UxhIu
 p5ls7ENz7iUEI4natx8hZiR5TxZqwq1dWqyAd9Uezl7AMMpO5nWnKgYUn/8XLp8nwoRX
 7p2VD2DaXnEoIG/5xpq192Ywl9+ROwFBjDEXVov6g/w3zuN43zNWvMzoW7DVEnTsun4F
 XNtmB51vqyZ9DAh0TlsdRLbb8Upjq9qjGGm1Jxhewyo0MVfC97r8HvOnfjUppBDvZARE
 PQQwILtpotJozXteZ4iWds2kS4LJbdXxLhmkmXh0fxko9w2HPkft/MaO4xRAg4Hjhhck
 s3Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB/H/M0pFdVzGogE38xgNNI+OxzRn76QUU/YHjSGDrBo6Q6nA2tluL3TrCtJH35VbvCm0=@dpdk.org
X-Gm-Message-State: AOJu0YzZg9/gXEtpRV9L8fxc0plOPqhdwwGAlzXExpf80i+SrYV7WGSn
 xtlJsE9Nmd95CiMOw6wILxsdfncAPA1El4q1lihSczjgLQRPnaEc/dYKfeA6+22TPC504gawNPg
 LhK55B3cYR5V0M6G4hBL6TRrZGBe6mw8WJnPVqY7hdQ==
X-Gm-Gg: ATEYQzwSQNbKtl2HKLSYLWwMuQfkUGjIC6D5V0wTVpdWjrpas/C3FC8dB83PBVc7MFK
 ZLDK5zp1yfqB4cpkuNj8Gdt5k6fgFGiwPXf6ag+mmtD2JCTvNkQKqruPxbSpNPTxyh1Rk/Kqfcp
 ovHM/p1R5vBnynY+EJw1AEcvsy/5Xe9FBHPhqYpgTkP4CMEcD6fgth2qwMPv6nXXO4X82nmJ7nc
 VyrRWLywz1GEBES+9x3X3YKk/mX5AjuPEY12n3PQLk9xZDmuq8nex77CrYnX4MgaDMIIsAu83/+
 sgeRBVeX5R4YlTZIQXscRo8+3NdcY6tHRKLOOQ2t
X-Received: by 2002:a17:907:da4:b0:b94:3ae3:6af7 with SMTP id
 a640c23a62f3a-b943ae37f18mr527555266b.17.1773070022439; Mon, 09 Mar 2026
 08:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260220192510.37163-1-abailey@iol.unh.edu>
 <20260224163200.39360-1-abailey@iol.unh.edu>
In-Reply-To: <20260224163200.39360-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 9 Mar 2026 11:26:50 -0400
X-Gm-Features: AaiRm529NCp6mxgVtEwkIfxk-GFWLpkq_pHahHt-gjuwolYqR7gqlKDcuH4q7zQ
Message-ID: <CABJ3N2WhJZRQGqPMajVg3WO+wy=X+HbwrS-G8PMBDZcR7dE2+Q@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add support for no link topology
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000d98cbb064c9908fe"
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

--000000000000d98cbb064c9908fe
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-unit-arm64-testing

--000000000000d98cbb064c9908fe
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Recheck-request: iol-unit-arm64-testing</div></div>

--000000000000d98cbb064c9908fe--
