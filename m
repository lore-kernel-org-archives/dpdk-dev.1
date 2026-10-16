Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD5CC6B2D
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 03:57:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49D3B402EE;
	Fri, 16 Oct 2026 05:57:21 +0200 (CEST)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51]) by mails.dpdk.org (Postfix) with ESMTP id CBAE140291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 05:57:19 +0200 (CEST)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-6798c4b882eso2029158d50.0
 for <dev@dpdk.org>; Thu, 15 Oct 2026 20:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792123039; cv=none;
 d=google.com; s=arc-20260327;
 b=NzW/aYnikaFCzuObW8vApx/lXf7HVVCMLgSAGrpdlxYjeJcxmD3uISNunFwx0TEMbs
 gIKvhurkDayf3AtFDUaAi9Oy27iT6CXLCm1/WD6ndZHNhNX22UeROUTbjYkG4utCoN32
 GqguCNl0R8emrPk3SqVk+q3/xoYNBp+/5nbP7M5VpSySwXFyhFHIrM5ScXeuUPEIfhkU
 sgDRQS1CqoG1iYWdoN7qJTLb7JPRUOR/ppsZE0kC7KWBPDurYWxv/sYETj6ohPGiJR4L
 DQnfQmHzHwPUJ+oqBKdBNM32VAQ8APt4AizDUFMEui1LeDfL0FdKbQWpNZhu4CjdqiDG
 Ti9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+K82WfCy+j6jSMStdY8tzRDGVP7yyktQi9/wPoNl2Vk=;
 fh=jUSJaRfwkhEl5V59lnRb35lhlc2JosPEpBUrKbJuuJE=;
 b=EIDeYCWcPWHSYzKrg1AlTCNDQPT15SoHOqWRyFPGx1nWTmJBDWbJmegJDBaSVW3Op/
 e3l7u55lDoN8HIO29dMa4qnIJz/GYAGJQZ4flYAbrDB71WITrLRHajP5LUIMDj4t6Plj
 uV7v+RWd/iZvWFPNFoHjQwyjY/MP4qlLVhaHBZ56Ug+kdPdrTJ5nUOEhNTH2m7kh8Db3
 KlVL/DTQ1oE9CoZBWo1BBUPgxaNTGFZnWfgNN9snm0iNwp9214onMhUlijlbqZ30XcIj
 /AMICw4SLC5QO7EGy87dDtrWzJgtFy0a+cKflyMjuClZTHiJ1z5bTw6u1ee4WkWLiRQj
 DFHw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792123039; x=1792727839; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+K82WfCy+j6jSMStdY8tzRDGVP7yyktQi9/wPoNl2Vk=;
 b=UO9ttJ8ATpPooRAh6HHmUfs8yK1LZkE8LnhSlqeCi6QiFPar0iwIiVv3SpLI3Ev0DB
 1j1QcaMJNsCv+Ob3sQRfpPc8Hkb5vvn1cB9knr9n4gMgWoOYC/HHkY0nMF9XLyjViHI6
 lKpEEUuQpajX7KOZmBIq5eganvG8uwvwIvMjBIN9XVdnXvM/+UvBXIcZI2k6d0ZazbtW
 HtxXoE2O9OymGXhcYxTkFZ5ViPTLKrLdgRB/M54BgieZ/jdWmnSinDVkikAunosbiQAJ
 q5p3ifvlpd8cLI34JXkGf3FYjVr/AKlqJDxtL0PPji1e03Le8lsqWmUluLYd5gDMbnd0
 mEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792123039; x=1792727839;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+K82WfCy+j6jSMStdY8tzRDGVP7yyktQi9/wPoNl2Vk=;
 b=ubMRQ6lnFr9t4Msu/YCtty77FEHszxmcITTJN2GzFrnOVoMoyZQ3pH9lGyLO+vKj6K
 Iq0LaNumta2R7XSGM6ptstzMeS+RlXT0kNNq4xgbTRkH3tjlq43r2xZIW8UmlJXfZRy7
 pd7dXJuJDYmUjeFs7FTfnEX1xUTWJy32doRiF8gaCOwJRhNGlTIpGhx0JaSfQcLjcN2r
 zqBCdkVAjTM0xGVsrqX5/S/bbiDHgjb8w3VACMHbm4w/tOxx0ha4UPw8Cb5FD8UOwmlU
 KH8OVVOIgCK5jLDvCFShKUcXdOKVa8AmU1/9kp9Nlo4X08UY2rmjD4sV9UpU01HUh2G4
 5ykg==
X-Gm-Message-State: AFq9FYIKPPrCkaXckZzAogcupm4dwzEDLcd3kMgurnWgQ0DBLwoRXaE0
 5r1GaP1s5sUd4c9eSW32FkOHiJMTt0fbPEPj9kQWLw9UAgzNZc27CF8Riq9XxUYA69oFD15/FDI
 7OG0ZO6c2TfFHZzbsupFRr9mwEXOginA=
X-Gm-Gg: AYBFou0lxSwR1hp88YFtZvVFtbNHdZ/hTaoGjWc0t16wcucVJcyKoU/5ETYE6kDrmNP
 AlMpa6j4txsIHBZhFaYVaAn+8bLz7w9AwUhWkHEPZMwAA8WRucbW1gtPEhSoWnqM6c0vQv00J04
 uq4yy3hKh6QINtGRmZiLyHT+V1d5GflL4LCLRGCEFCKHMnd8/L1vC663M/Jo53tdL1LLkRgwWGs
 ZCjYiqhH18cj5Pcjm5NW3G91KVgG8BSnqU9/tIm70Dm4+wZy1ouI7nclo/BWmEpmBrKCz334r7d
 OmY/djPF6MC89RKa9sxXSNj5tle18XJyr1H8kfdUEhukDntRcgEecST2OQNkzbtSAyj8Pr7QdfS
 g76kPw6BAnyuYyvlCWOt2CTi50EcXjAGGSs9svuWnNykqe5tj2ws/eD772IRVNRCUUtn3lu/OVt
 WtJXUcyWE6h0r7yZ/5y34010IZH1sG
X-Received: by 2002:a05:690e:4419:b0:677:d6b1:d993 with SMTP id
 956f58d0204a3-67936038458mr4864350d50.47.1792123038914; Thu, 15 Oct 2026
 20:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-14-rbhansali@marvell.com>
In-Reply-To: <20260917071016.2366467-14-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 16 Oct 2026 09:26:52 +0530
X-Gm-Features: AclHuK8fN35F7c90CFqjtzcZppi1igK5POdfLgwqrkxqysLVdtQytkD7Pm1_FoA
Message-ID: <CALBAE1Nu6z=RuKm0wX-oHC3aqKA+F630asaeyLBfYHQ4Bng3zA@mail.gmail.com>
Subject: Re: [PATCH 14/14] net/cnxk: fix custom inbound SA condition check
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, 
 Rakesh Kudurumalla <rkudurumalla@marvell.com>, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 17, 2026 at 3:13=E2=80=AFPM Rahul Bhansali <rbhansali@marvell.c=
om> wrote:
>
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
>
> Custom inbound SA condition should be check when inbound SA create
> and destroy.
>
> Fixes: 7eaa499dd0c2 ("net/cnxk: support CN20K inline IPsec session")
> Cc: stable@dpdk.org
>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks
