Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6B7CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 20:51:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8015540658;
	Wed, 24 Sep 2025 22:51:53 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id B043E4064A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:51:52 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-271d1305ad7so3489165ad.2
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758747112; x=1759351912; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4RhfWXXIy9DX1uTcEHzzoNyLUa6c1bye7qisohxXqCc=;
 b=FX1PenPxdggBvE3378sEgNqK/29NioOagwsEmUfDk6gJnr4HqnGYdHnZ32hk9czzGY
 bU6Ein8lIYqLrmAFoiTF5bz7MgU1qb8DdX23+/pIQhRj3jV1iHMWQ9hKFLi84CzcxLqu
 u0ZT4/Z3acZUbhylEn1jO+3A/aJyzXgVMOdKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758747112; x=1759351912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4RhfWXXIy9DX1uTcEHzzoNyLUa6c1bye7qisohxXqCc=;
 b=j52JgY+Yyk19mQWKL+iQtutNDQAogkPVhG7lWnxTZcpYp70930Bkysti0o2OK/5Qg6
 WMZig0569TgqFZ97CJhGsTEAZY1y/MJn4KftTKYpWWFZhK5lbyr7+dnP8Hpeu40B/mGu
 lZ/FiBagTrFdX8hUpXpY0ihc+pNX3XDpKXoSUKCztQd0j0OdJIYfIZbl3lSKKPkU+ar3
 D3l0Y8fg41fGo9XNaZg9zVqkoU3sAmoh44IaaSGc0FgMrHD/dZJRug4vFOXRV2OQXx8r
 he7SbxXjADdOC1NzX4mjXmab9tWScOiPHKdI4Lf3FzLdaB3IMPx+IozCE5+p95m8Et8w
 yZEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaibWEPQessXPmnMPfwoFZaiMvg0ZAh6bdhx8hqDZFtIfzZWaKIVoWn0V6orsCaO7lkuA=@dpdk.org
X-Gm-Message-State: AOJu0YyE2WmtYXhf4lfFWt+y57XGnGEs/Jp+k+ixjbA8ZuM/OOjKDjSu
 kcYHX4RYZAt/hjNyOMHHw2w1m7sdmx5xP32Sr8NU4lEdixW/J5638bYNOXprrzAxOndtW7JHnl/
 6/ROd9yPQ31XD0Isai9ZerYl2/sW2bPDbV/I2paeMLJ6+m8XSCTso
X-Gm-Gg: ASbGncs4rHWqESSqOq5uxp7u0GePUsr9sQIIE/uaPQPBpdfVh5ihm4vdxnDR2fDAPbd
 lmYrJTknNd1VRvlw4uHq4NYAKYCD33VHqgxIb+rFPoS56PE/PiD73KKg9dLkxiASXi6MdELjTLR
 pdy0uMvEJNjXakYdsjCNAEUzGi6lAuqUUFm4+ALTEyk6b/hxXfFHGAguejamLLyK7FqF8OPoyZS
 955bEi2h1e9JulIqSNWtzACAuiN7dhgCemBu+pB
X-Google-Smtp-Source: AGHT+IEmmY6Zj7/BJn4p7ri/RkHcvOLtNWAQ3RFstQGDzrlU5sarMrx8j7iLN8O6mr4z9p5y9ECbGo/xfiZRh1DzzQM=
X-Received: by 2002:a17:902:d507:b0:265:982a:d450 with SMTP id
 d9443c01a7336-27ed4a492e2mr10023195ad.40.1758747111882; Wed, 24 Sep 2025
 13:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250924164725.168773-1-abailey@iol.unh.edu>
 <20250924164725.168773-2-abailey@iol.unh.edu>
In-Reply-To: <20250924164725.168773-2-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 24 Sep 2025 16:51:28 -0400
X-Gm-Features: AS18NWC48ILR8ycf8VP92R6g-U1L5Mol-lhkHYnO86_o4P0vShO2gRLKVeIFNGs
Message-ID: <CAJvnSUDm=yrVzxowvVdJsoz8hCJCyZFDYr9pca6=4CKKCaU2Hg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dts: allow mbuf_fast_free to be set with testpmd
 shell
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 ivan.malov@arknetworks.am
Content-Type: multipart/alternative; boundary="000000000000da951d063f9238e6"
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

--000000000000da951d063f9238e6
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000da951d063f9238e6
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000da951d063f9238e6--
