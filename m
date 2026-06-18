Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390B9CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 16:00:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BACE4027F;
	Thu, 18 Jun 2026 18:00:43 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id A989440268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 18:00:41 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1397e093f90so2876357c88.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781798441;
 x=1782403241; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZMXVKIVJuzQti+k5GU5NQEw9ro7wZmFFdhTVkgAHjc=;
 b=NFP40g+Lfr1knuabq1u74nIyPyc3y1PVV66GAvcuBe3dpkmAFv8maqnp0AUXwNkM8l
 +fxHbVfl9NFN2HORZJj5zgsF4ywKn1vjhsjHUr1ZJiE6eez/m1dliljZcWrvjwObd+SD
 y/DiTeQLrw7sAVlhWOel1r9f1qeWbEk7vaOfpZnEYC7rrk0+AmOSeeINNn2zORPLkahj
 F5ts/m04c3IPM2Bw5miMritWZlmwKCCr0n4wi5j3hWDa9dysUYsmV39xNg7qfrXssdQV
 gOsKRJKRv0BYJ65LecdFXk/DprRSi0GLQlzrg2tJqcLQkASlLGhK+5xX/VY+gKDaifm/
 zSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781798441; x=1782403241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QZMXVKIVJuzQti+k5GU5NQEw9ro7wZmFFdhTVkgAHjc=;
 b=mRY+NNmZPr9rJ3lfeI9jdUnqgso2NSzVO0ROn5eil3ENVakY5xBRx9xPxa8DZY4oSV
 srw6vfV/Ml595TantqKDCR0AgWnizSUo5AMmuglOcIGt1hVLqp0nXYiTHfPI01+i3IGK
 4bNSpOw2A/v1rExaK1hfIc8ll3HhW5O1eTm0m+GnGkrh2gyimJkcQ7nSb0wool4D1pu0
 1Fc2vZPUtdcdArBHvi9jpptnGSsEVBglghLqrupfVje9B8ghNqrvDYTErr8lq6TBTUk8
 iyXlL1HwYSSCMUFW+ZIJOQQM+/HCSgRXmZ0XFQckNDpCl3tJC674n43BNszcR37BVQ20
 uYyg==
X-Gm-Message-State: AOJu0YwxZpPafYRinD3oerMVijmjycZBQdK29hwHkhMlMTMxNmRDp1T2
 cKY1U7yfggb+bEwRjZso8BwTYVzfPN8DbD8SRSQYDB2H4+xVzScn5w+iOQW7sZ+1LOK3AOVYrPP
 PCvv3
X-Gm-Gg: AfdE7ckLCDLgEL7xxS28bvUsHCiLKfVQnySJUeO6msiYU5eW418G8bSpBC96tNI/ngM
 SKErdTxnliVgVq/EeVEzmbEGvypBDEpYopPcLNIe3Bx/Q19ntFpQCfUcUbkZHaefoUIpXn9n17r
 T49ZKYsHvZ3MrxfUafEeXTwORH68UE3EdGisl/LXa9Vl/68mXbHglLdn8wJwtFXQpYywz9zG2/t
 oMo6y0TNy2wA8bONvme19QbVrrJUvwspHWommJazk2MYe+9mk7kmHtCjP++cy4x9MA3dClHgj/P
 QdpCKiOV4R+w1lE+tvUjOMvKOOZGAnQStk3In0Fj4pOiIj/nr5Np+N3BY/Xh5rror20t9PXj7aP
 Dpoj6NdQR+Ot0wuQjVaVFH1ohc5ziRgvc2zN8d0d8z37yBuj+EehUDlo+vIAJxuor/jRBcviQ5n
 iwPR9oOPOnyaPCbi4VYEYrmMsZwTjMQYFIZqv0G512+tRy/oK9ACOF1w==
X-Received: by 2002:a05:7022:913:b0:12b:ebb9:1c18 with SMTP id
 a92af1059eb24-139a21a67e5mr145193c88.31.1781798440260; 
 Thu, 18 Jun 2026 09:00:40 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bcbb684absm6085587eec.1.2026.06.18.09.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:00:39 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:00:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/4] net/bond: fixes and cleanup
Message-ID: <20260618090037.78d9659c@phoenix.local>
In-Reply-To: <20260529000157.235931-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 28 May 2026 16:59:12 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Automated analysis of the bonding found a few minor things.
> The bug fix is in patch 3 for secondary process crash does rx/tx. 
> 
> The cleanups are in handling of 8023ad mode setting
> and the logging macros.
> 
> v2 - feedback about the mode setting and log messages
> 
> Stephen Hemminger (4):
>   net/bonding: make 8023ad enable function void
>   net/bonding: check mode before setting dedicated queues
>   net/bonding: prevent crash on Rx/Tx from secondary process
>   net/bonding: remove redundant function names from log
> 
>  drivers/net/bonding/eth_bond_8023ad_private.h | 17 +----
>  drivers/net/bonding/rte_eth_bond_8023ad.c     | 16 ++--
>  drivers/net/bonding/rte_eth_bond_api.c        |  4 +-
>  drivers/net/bonding/rte_eth_bond_pmd.c        | 73 ++++++++++++++-----
>  4 files changed, 67 insertions(+), 43 deletions(-)
> 

Ping. Need review and ack for these patches
