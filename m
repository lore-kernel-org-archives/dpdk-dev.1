Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59FFC369D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 03:30:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECFF0400D7;
	Fri, 25 Apr 2025 05:30:53 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id EF511400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 05:30:52 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-30820167b47so1859614a91.0
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745551852; x=1746156652; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rbx6ARz05EDNqKeboHZzxx2vJeGvBMuNkLyTnT9Mjgk=;
 b=aYBMlqzMtmnUu0whKsjDLtMAI2ZxUnwq9tWXnkwyTEWSggwpgnQTqg2+hT8BBx0Le4
 0Qk8O3odaAR2cmBSsxPrxF3FpkGA0YCDHZiqGfEFYWEO2NLD49QWbkSMbzGxKuKSpcHU
 iBDhrOKpVFVVDxxZUvMK6aFOL/0KostbzDLQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745551852; x=1746156652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rbx6ARz05EDNqKeboHZzxx2vJeGvBMuNkLyTnT9Mjgk=;
 b=TsGaiTCwqfCM8Sc2i5cbekPi/78kxgIEIEpG5QHHDf/zYcpMGbDRep4pfCaNSJl4vx
 h1a9A7MggXuCLsRSxSnfOMsGFwhhhszr5JPnCXg1LM18ZpSIqiwYdORUN32CvGCBm3zk
 pIoSv0ciZITEEZQ0G0VQN5BBixn6Cx7BmXmq9iRj6cIOSnaKIOEHxUL8qlewH3/+Q+hk
 i/eQTV5o8sT3jMDfeC4uD/1zCKHfBVP2OrnzToprg6IMiTYKvW7ctUuUjyHus8W+Mksn
 aWV7kstSkdjBAKB3e9zTW6LG/S510BDN0bG8Ao/S/Vf2zk6CtX6Qv95yDAbPKtq+TE+e
 QXWA==
X-Gm-Message-State: AOJu0YywtC4AvpvKlhlGIkXz4Y4Sda/wQ/vr1QZT+t3hd5AtoYyO//hB
 PMtbRR/MyweX7QR+9pNdepkCIAPSudexBMykh3N20oeQaZtT9bQFH3gZ53/CZ2nCsJbhzwjHXcC
 Jidaxz7vliuuVYoXzu6E8ebcROqNVnZo94+kZT9M1WsFtqFCl
X-Gm-Gg: ASbGncv3QfQPH1RZX6uvGHhVSnMI8Z21hCsq+Pz5D3x2DkCMxRA5b1TkT1tz59bu7NH
 rOZOdqyVbE17YVSBNopCBzXHLf32FvaNHgCq46cg8CbcEj4AzFhfxCOjBf4rZ5Q3xcb7RTmYg1k
 mpzs58LaPMgdJ1unbXVjSaE/D6pQ76i4doe/QPFg==
X-Google-Smtp-Source: AGHT+IGVaBqV3GBlo2lUrnCrOotWSzJBYtyPZWRxnFpD+sOUOmZ6x4DdEJi12R0cTwIulWXbQHQjws8OWqe9F61nQcA=
X-Received: by 2002:a17:90b:2f45:b0:2fa:3174:e344 with SMTP id
 98e67ed59e1d1-309ee3f9db1mr6891420a91.14.1745551851709; Thu, 24 Apr 2025
 20:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-5-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-5-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 23:26:29 -0400
X-Gm-Features: ATxdqUGYAP4CBspjiriQFmwYCClHMgBKcOeMVAO32r_HIbRy3Z3fF3o2S1B5jvM
Message-ID: <CAJvnSUAojfR35+fm7usxfw6A8RRR==K9Ss=pspDvPuEa5RM5yg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dts: revert back to a single InteractiveShell
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000000efa9f063391f649"
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

--0000000000000efa9f063391f649
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000000efa9f063391f649
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div>

--0000000000000efa9f063391f649--
