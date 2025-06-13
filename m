Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E93C61DB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 07:35:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3599402E2;
	Fri, 13 Jun 2025 09:35:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 06D25402A1
 for <dev@dpdk.org>; Fri, 13 Jun 2025 09:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749800124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xyo7ntYXPNHkGqY+zH8RuzVPq6zsSd09zjy6E6fI7DM=;
 b=GACc+Q9IWwpQxh1M2SEyYATRJ10pPO4IsJ+S+REakjWdb3x2dnoTxjs+Yf+dCNcmuonmOL
 408QegSKJ0Cv662O0pR4IEbRaI6iB9UW/hsixKNZq8HjllmffHXrq2M2g7SeU11Om3bIw2
 JReWgnOPIa+bgjmgjGQqHH1wtrvmEV4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-iZNMi30oNUeKuIfcse2GOg-1; Fri, 13 Jun 2025 03:35:23 -0400
X-MC-Unique: iZNMi30oNUeKuIfcse2GOg-1
X-Mimecast-MFC-AGG-ID: iZNMi30oNUeKuIfcse2GOg_1749800122
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553acdcd5a1so850772e87.2
 for <dev@dpdk.org>; Fri, 13 Jun 2025 00:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749800121; x=1750404921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xyo7ntYXPNHkGqY+zH8RuzVPq6zsSd09zjy6E6fI7DM=;
 b=AhZ73YgOkUWIo3nL7LG+p0WCfUN8tjH/imXwfJ+sfRK6625Ix936ddgiENWpl0pRHU
 t0hSrmqEkvWR7f3U8Lnq/0kyUJZp56HwAEaMv1MnqOUu09MbmCKfZQWknF3sTndFa84I
 2qulsUv+nColODAa+GmjeBF1Nuge3fv0pNTpQ5qjxWRhspYPXoVyVm0NN20tJCxWDhDO
 p4fD9lBRthRD6A2O0IKKk2RKRsOmCTcwZTDbozT+hv2JVgkXZ89Kqdu1FRs/dkHqfDX4
 cEpwg7qP25518ftAV5iK0b2jnaHwHQr3T1zP302k50x9iR1o3o4OQT36kD9z87zJG+CZ
 htXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB7t0r1vVOOlUycuT5kNlXRx8vk8OoYkuBxlV8RrbmbBrZ3V9SvD0Mya+RVz8wYStbkFY=@dpdk.org
X-Gm-Message-State: AOJu0Yyh2XCmuZuSxxZicJgNR8A/gQa/INKUnPKi6Nj6mq2r2uggoitc
 W6/txpFCPqaDbFt146zay/X5nOdzXeWHp84OSVrXVRR/EhuK2/MRJmpOmDwBtJeJfDlNZ+aBVf4
 LoI3hjZGKjK3rOf9HhviJ97jck5jAiC8dC0eunZXjBpfEj8cazazMg/ZGKLsR/URCPH+rUOIAD8
 vfYul4Givgty34CUyfA3k=
X-Gm-Gg: ASbGncvwLia6LuLtXVdX9fgJhV3XCSNOn+z62VO5vpMTBYgEo9BLD8lkZvn1iOLyJcX
 iDJC+YkfPuAPuNN/WQqcE/me88pRlSApUc/2rpwH4SDrOjMVRiMNXhMjxn6qXPgftWdemEHS3uO
 lvu1pZXQ==
X-Received: by 2002:a05:6512:528:b0:553:5d3c:e444 with SMTP id
 2adb3069b0e04-553af94f134mr378808e87.25.1749800121484; 
 Fri, 13 Jun 2025 00:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9IilrPMfU1LmlsV7IsvzWWrwkdCB2tPkDJN/apz+ygeMcYzasUQU978pYGVM1X8X3B15Z4gXnsr5wHP+K1NU=
X-Received: by 2002:a05:6512:528:b0:553:5d3c:e444 with SMTP id
 2adb3069b0e04-553af94f134mr378800e87.25.1749800121015; Fri, 13 Jun 2025
 00:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
 <20250612085840.729830-11-kyo.liu@nebula-matrix.com>
 <20250612104034.5d5abac9@hermes.local>
 <7e74f0d2-d947-405e-86ea-ea532dcaca95.kyo.liu@nebula-matrix.com>
In-Reply-To: <7e74f0d2-d947-405e-86ea-ea532dcaca95.kyo.liu@nebula-matrix.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 13 Jun 2025 09:35:09 +0200
X-Gm-Features: AX0GCFvtb3LpccWNGNPKSlzNl-2y4eEyS8osxtz-tABVyDE7QGZINR2oqCc8szs
Message-ID: <CAJFAV8zNO-7aJJfrkZi+FPOZMCWf3iGHJyXFZjGn9gc-5BQhDw@mail.gmail.com>
Subject: Re: [PATCH v1 10/17] net/nbl: bus/pci: introduce get_iova_mode for
 pci dev
To: "Kyo.Liu" <kyo.liu@nebula-matrix.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev <dev@dpdk.org>, 
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2GlOh6SqWrjxKrip70z_nuJTsPOHib03Bm2T2mxgIkU_1749800122
X-Mimecast-Originator: redhat.com
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

On Fri, Jun 13, 2025 at 4:28=E2=80=AFAM Kyo.Liu <kyo.liu@nebula-matrix.com>=
 wrote:
>
> Hello, Stephen:
>          Thanks for your review.  This patch is particularly important fo=
r our NBL driver because our coexistence implementation depends on it.

"important" is different from "required".
It seems safer to plan for an integration in DPDK without this
dependency, then add it later.


> Unlike RDMA devices that support hardware page table translation, our har=
dware requires a software-managed approach to avoid IOVA conflicts since bo=
th user-space and kernel-space DMA operations share the same domain. This a=
rchitectural constraint makes the patch essential for:
> 1. Maintaining correct memory isolation
> 2. Preventing IOVA collisions in shared DMA operations
> 3. Enabling safe driver coexistence
>
> We'd be happy to:
> 1. Provide additional technical details if needed
> 2. Make any necessary adjustments based on your feedback

Is the kernel driver being upstreamed?


--=20
David Marchand

