Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF21C83F1A
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 08:57:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46C354014F;
	Sun, 20 Jul 2025 10:57:09 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id E797C400D7
 for <dev@dpdk.org>; Sun, 20 Jul 2025 10:57:06 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-235a3dd4f0dso20448515ad.0
 for <dev@dpdk.org>; Sun, 20 Jul 2025 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753001826; x=1753606626; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPTqC2VHHPSn2KJIeZQ7HTuMvYlXjR8Xl2Lnbro+SPI=;
 b=IbFY4GCWkIV1YC+UV49ZssEV4DRmNpXjk0qAPEr+gl/ckasjMJNtkHollKtYnRBRRG
 BZNrnT0lpbD8AmDHHZhdl2b4HR3hmCdqUL6ikk+oAKKaMAV6fjdiiUuMTYu2mi2jrvrA
 1O0xhK+YAXRuho8C9UtjbmDVemqFk/vlxKq2nK/PTcomo+qTu1/KU4BKT68J21qGm1Fq
 gTisNiJDGBKgXsqwgJqdZdRtUzRS7/KtH/hqMWVcG4aBfLfyMCSRC4sKhUhNWQqYb853
 J1xkLxWMZKap7HheCNcmcNJsMPLDyL/gAZ/sLXjS3+vg7t34pGo3xJkku+pYUnbYzMKp
 eDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753001826; x=1753606626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DPTqC2VHHPSn2KJIeZQ7HTuMvYlXjR8Xl2Lnbro+SPI=;
 b=q/MlmIsOKmeYQRwD0f5WUdw7uvvi4+poqxu5/yxu60bVGXY3uYi7iEh/Je1Zh5Ksyk
 tN1XeKa0mCF05nsJQpLIlSX2O6FGSYdXCcufL3HI4Sp7fVO5VpqnCMtjGLX4sjU1IKBk
 9IbMOffMiBB9s7o5CfVF5G8ydxDKpADr1T9VqJXFfsJ09vY7dEinRAsIu6x9YOvx2Wb9
 7uGPhTh6apKScy/ELGmYgglHjsZEbgqTuabmh5z9M7MkStXu17DXfo8Q4lV1z2LSKpwa
 E+HOGpYuBce/aFowGZ6UH0Kzp6LkXBHYJzntmOXYT06/2WCyc9PYht5ohT2E1x8lWNqg
 qI5A==
X-Gm-Message-State: AOJu0YzwJSo6+uEbnRFYIlY0hCVTB+WcgPwJ/tVFEz9ZHsr795ZXU9uh
 VfNC/y0mKXn4kirIhxC2ZY/DWkLbAs1iGm/rVa4oMx+raUB0D4kTEtpJ
X-Gm-Gg: ASbGncvbRgOqXOm2b64ZxEd/65Reefhh83v3ky6V2wNMsMqN8XgYq3nmhpW67LNOqQr
 InXY9Ae5HLg15VzHMEJcwWfmShbYKU7/nI5JwH/XQ62hUozzP/EcR/FdVPApmhpZEWaYRGgtrPc
 qvCcQi5rzX6X9HSR7mE0f3lJ70iVhdd900tKk6EpqoeF+aI0cdpvlbvvNwMOueX+zc8D/MKfyuQ
 Jvphwyi/K2E/1ik3a1cBBmwiaDb0GRBSrOhZaZ+moz6orftF05xlKTYbLBypwsTZTCCRzKGH0do
 tE0Sjcoxm60rEKHY3ZsPjfOzmbtohAlUEFvPgepymfMEqL8Dstqyi9upzMmV5pC9JO1Hz9P+TDY
 4bTYIC3tcaUrec8Dwf0GJ9AnZkAKBZRQpjfd6C1h0wLR7
X-Google-Smtp-Source: AGHT+IG+PupO54rmP6SNie6Oq+d/sK/3eZUPISI6xNu9RFDLeU6zN8iPzZPDdvv7DsXSob/Pyuv3Rw==
X-Received: by 2002:a17:903:2ad0:b0:23c:8f13:1381 with SMTP id
 d9443c01a7336-23e24eddbf8mr211769395ad.19.1753001825670; 
 Sun, 20 Jul 2025 01:57:05 -0700 (PDT)
Received: from [192.168.31.141] ([60.176.146.11])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6efac9sm38769325ad.215.2025.07.20.01.57.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Jul 2025 01:57:05 -0700 (PDT)
Message-ID: <856a0191-a3b9-4a06-a6c2-22f1f5958dd4@gmail.com>
Date: Sun, 20 Jul 2025 16:57:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net/mlx5: enhance log file path
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Bing Zhao <bingz@nvidia.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "julien.meunier@nokia.com" <julien.meunier@nokia.com>,
 Maayan Kashani <mkashani@nvidia.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250321132750.4237-2-ming.1.yang@nokia-sbell.com>
 <59bb400d-5e49-4ecb-941e-2513894d6930@nokia-sbell.com>
 <0a6576b7-5981-4a7d-b33f-aae011b86a00@gmail.com>
 <PH7PR12MB701812C6D5EBD32CCB17D1D0B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
 <20250626130637.c4a5jtfoglb3ssha@ds-vm-debian.local>
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <20250626130637.c4a5jtfoglb3ssha@ds-vm-debian.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Dariusz,

Thanks for your comment. I will try to fix this issue in next version.

Brs,

Yang Ming


