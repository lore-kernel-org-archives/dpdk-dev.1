Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104B6C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 08:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FDCD40292;
	Mon, 16 Jun 2025 10:23:53 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 8F55A4027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 10:23:51 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso7770855a12.1
 for <dev@dpdk.org>; Mon, 16 Jun 2025 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750062231; x=1750667031; darn=dpdk.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b8UhMoxRUaU2XgT0ny1j8b0I38Q44O1uDFj/MWHouhQ=;
 b=QnxwZ2duxBlB5qE16mpWavyOZh4WliNA46/wgJT5s97Tz7xV91tIRqHQAAp1JAYh0o
 rmurx66LRV8S+ijYC90VRFLkGWFRNCQDdOUbHNdILNzI7N+CfN+Ic54Vo2YbI5SK89vc
 8Yj5SaeCzavODL2FsMBWaRRfUEYcmWQFw6WSpvJu5gzP0KbWiHPuf3/AOUbVLRQRBTh6
 wr1LF2kIkWNFLkJMRcJswGYdQ2xSqM7OeFF6mVsPJODMGyesag8kfY+zGKYQ8Ny17HwY
 sUOHXtcoR6Q/Wc+1x6iMM1QVThPfrlqKXWdrgGcduo+jgKLMyiCzXc9WcA4qhuEDanr3
 xMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750062231; x=1750667031;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b8UhMoxRUaU2XgT0ny1j8b0I38Q44O1uDFj/MWHouhQ=;
 b=RXEwrzyw2rGqptdlCwhThYG3tzCKKh0NBcobE0azppuG2VMsMQYL8H+c5XQNopjTAc
 R7XMN0iKIN72aPOBk+FnaUv0MQjlbkBVeX8mw1U+ZdsPY3k+BSknCXH/R/CpDAgtLTjx
 TyT4dIYaRCwRA/9axKUrLnV8GzedErRya84kZAcaGlrSG5/NKyzD8KApfqcbsj5Pk1wJ
 LW2AwG4jmmd6qA7gGU/NrePSk4WePF8PWPMaHl0jpTpmnNtAt93ly2JeCw83FsH76e/b
 VuzUY/YVt7Z+S9gysqR6vw0Wyj/odOBgr6c3nfZHWSVi+QaEqgChvMdgrpfIpcyuoRPA
 XFrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoa7qF1j/Hsqi6CY+gj1msIB19o3fC2Y9rl4jvJYAAQEdCLTuIxDm2xkiR24hF3n1gvA0=@dpdk.org
X-Gm-Message-State: AOJu0YwdcL2NNo66Mht1REHTtWqJ9At57RJOoledVbFzsbKe0Kl5pigP
 ItrIqTkCROSEyH311KsJhJ1Z5d8vbzeeCRy5uUc9cd43EHTE+l+t9lI/69JdMMoAXfA=
X-Gm-Gg: ASbGncsin5/OUb1LX7xctXDLEbxOZDgn1MPTtv+rmmijLp+gwbb6e+dCXif5TEWbh57
 oDcLprAYIUia4oiQhi7IB69w3APlX6MIZX1b5DKmU0/BAN6UGmMFtp15A+C1H4Jv8cHJOA94Fuv
 +IP//ZV+GVt1Fv7IRuCJKDmQjnKT2UraJYzX3rr18u6HGTKRN7sbMBgVc783t5249srEBkl8yVn
 ggB5FfurM68+05GgXDKMk0kpUFNteGTLKR1gnB2cUtvx4qPYieMURihIXtIdYfIVs4OWy1jz3tz
 ydU8IOb6DnT2YhmTVz8ESPhAEVM4UgkSXSmSzrM+y/LoA9euEWanF+53ReYon6iZLSTvOJvZ
X-Google-Smtp-Source: AGHT+IF0dghv0gm688J9QNmvwAsI9xOV+Y3xxL8aE/a54Cj3MzBTXzXQM0/lW1iEUxpoa6R1OgtmhQ==
X-Received: by 2002:a05:6402:2351:b0:607:4500:286e with SMTP id
 4fb4d7f45d1cf-608d0961a69mr7950744a12.18.1750062231007; 
 Mon, 16 Jun 2025 01:23:51 -0700 (PDT)
Received: from p620.fritz.box ([2001:9e8:13b5:da00:5ed:34a7:3b5d:3f22])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b48a9586sm5561084a12.10.2025.06.16.01.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 01:23:50 -0700 (PDT)
Message-ID: <4c07ffc166d99607736e0396ea01e8264406bd26.camel@suse.com>
Subject: Re: [PATCH v2] dts: fix deterministic doc
From: Clemens Famulla-Conrad <cfamullaconrad@suse.com>
To: paul.szczepanek@arm.com
Cc: nd@arm.com, dev@dpdk.org
Date: Mon, 16 Jun 2025 10:23:50 +0200
In-Reply-To: <20250611140530.51551-1-cfamullaconrad@suse.com>
References: <804d43cf-ff73-421b-a3a8-4b3dd3c3add5@arm.com>
 <20250611140530.51551-1-cfamullaconrad@suse.com>
Autocrypt: addr=cfamullaconrad@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
MIME-Version: 1.0
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

> Thanks. This needs to pass the linter, see my suggestions below.

Thanks for your suggestions!

The CI is still failing[1] in "Windows Server 2022" =3D>
dpdk_msvc_compile
I don't see a relation to my change and also other patches show the
same issue[2]. Not sure if I need to do something, do you have an
advice?

[1] http://mails.dpdk.org/archives/test-report/2025-June/885350.html
[2] http://mails.dpdk.org/archives/test-report/2025-June/885280.html
