Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3EEC87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 15:41:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20B974027C;
	Thu,  7 Aug 2025 17:41:05 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7F35140270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 17:41:03 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-24049d16515so9590075ad.1
 for <dev@dpdk.org>; Thu, 07 Aug 2025 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754581262; x=1755186062; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Akl6mkUp4XN5itf3ucw+M23LBxZe+zz3Kta+JYUzSHM=;
 b=GRDP3zXC9gk3XO7H5KKj31hDOHM1nZDUtj1p1rJ42ighDxSwV9dWJ310zwjMuZf+q6
 bSWdq3tzRY45fPDUYC+6YUaUUzatfbPNBPQDPr/W3l7KQlaPTMj9EZT3CCHBP4CO3Vpu
 /KzxaR91zr+MNJb9LhYmJcCql+6n5uVUFZokw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754581262; x=1755186062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Akl6mkUp4XN5itf3ucw+M23LBxZe+zz3Kta+JYUzSHM=;
 b=PR4uOsvMtxdsLetK/Lx2GHsQe4lqIUcUxyTaPEB8BiMa2KwhfH8iCHvaKWFL+Uu/li
 QHZZvpZzZOg98x3Yxmnhj5hWrCJ3BgxsHaVvWpoY6cqG/YIx3KVAMK3tv03Cdy8BqL7L
 oFA4Gw8qc55JC0XTqD3hZ/aG3A4pl3FZ7mUo+kVhsaQS9rFYPTareUiLuSHcAoW27Zn1
 Ydxqp39oYsDXyB4eguHkXAFMRZFWBFuhL3wpEL7UZhYZt4OWJsaoXjYrJtubXfdf0lr7
 DMsQyHzyBzD95TGRAGGuUYof9or87Q7WEpwTUexVb0oyDMsLzYr47GYx4Sfd55s4ZUCA
 OFXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5RFgfYY1g8it+Xm6s+/FCZdi53yXRAdyaGa4cED/rJsxhAfvuyXHTVDR1Kt/qdnccG3Y=@dpdk.org
X-Gm-Message-State: AOJu0YygbpTeozYM4Z7yW9hRqHj0h9m6hQkQ8madr6HUs0Ym8Z0DF8X1
 pp/u1NTjObKWgDNcskPnVf1YlIQmn/KGCjK4CFcl2m+gugKMsh8y7rRy6Zig5ghL9cACNo1ksUO
 osrPvmwxWf1xmlbHdaj5FngfWD9fu0kl8aVw04Rz6sQ==
X-Gm-Gg: ASbGnctbFJg+D3/eZTsAOutby0mMSwbVPdWQsXxZrkrb2pZeJzCQLjsIIlysquHsoij
 FicAj23X2Ofo6V+kDrEd2Y9BILH96J3aQqQd5GIarMRT+lRK/IrN/+k6DDrh6jQBvNtTEdCwH1n
 YCetPhdbuEPlM5Hyjfj1F69QSnWgTfImqq/sys3S+x95Z8fa5htMOBzL4qYS4OdNIMjp2THCJNa
 la2jquEa4+DhdsDvea2AKYvea3tNKqzCQ1TcR8GAODNtNt3LMA=
X-Google-Smtp-Source: AGHT+IF7jBv21pKClq/9z0ZfxeBfc3II44Hqw4UK4MWj8imKhoIp5n6lgEEbytwWBhc3tLyEF1FtgPnp63QMr7O2LME=
X-Received: by 2002:a17:902:d50e:b0:23f:c945:6067 with SMTP id
 d9443c01a7336-242a0bbc6a7mr98921305ad.41.1754581262572; Thu, 07 Aug 2025
 08:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250722172214.202308-1-dmarx@iol.unh.edu>
 <20250807153358.304262-1-dmarx@iol.unh.edu>
In-Reply-To: <20250807153358.304262-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 7 Aug 2025 11:34:47 -0400
X-Gm-Features: Ac12FXzys-MbWXw6NN51lV5KySWiRDN2OKwKjfO5bA2vBPRUbSK6IVjQkx_4BcE
Message-ID: <CAJvnSUAicpBeqGZDJqeDsEv24SiX7ROH82CrZvS2+aYn-EjCDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: fix docstring typo in checksum suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e2b8b6063bc84836"
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

--000000000000e2b8b6063bc84836
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000e2b8b6063bc84836
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000e2b8b6063bc84836--
