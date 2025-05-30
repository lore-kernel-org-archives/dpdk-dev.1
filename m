Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22205C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 12:35:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1A314025E;
	Fri, 30 May 2025 14:35:42 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 836304021E
 for <dev@dpdk.org>; Fri, 30 May 2025 14:35:41 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4a43e277198so10307331cf.1
 for <dev@dpdk.org>; Fri, 30 May 2025 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748608541; x=1749213341; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXHE1erN7ak324PV97rVkHvmxFRRCab/CocLXoNLVhE=;
 b=NFkPSwZ0TTTy1oIvDYOWaXNn9zw+9TxUKmc+OTJTsAhf9Zg7SPzY0mtsYhBMy7Kfi5
 iCxcdA31GpStpNo03PaihcCfvpUIlQ1bpkZWv2lCiD1uJtUAVP/AqVVbenvvooIyZClU
 I7noMcb+IbRHZuGrgIFuXuyrKuXWxS3ymH0IA6+wLP3nzn0hR7voEfDrp2JgGK7HQB2T
 WOjej6KZMMMPswMA0NvKnBDUE6pPFBu4PfBujQOcoKwi6HmuZzrGHNDCRDnCy9a1DnQQ
 gz6DsCoQTqoOoTkm/pVbbimDXf86nmWee9F2571xqjuEEDa6CyiIpg2TYMkAzBzOErIa
 vzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748608541; x=1749213341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXHE1erN7ak324PV97rVkHvmxFRRCab/CocLXoNLVhE=;
 b=OmxK5+u7OvOOLcsQ6HWRz5Fi0Uh41h9HhmcQ9UrQmNARBM/Js+qGj8/RPDTbQnCNWi
 5MyWl86UGiK3aP5zlqOo/Z+M3UOzRbT9yxSvU/eGM0r78yOaDivz+AIYcbBI4jljx34X
 lg0Du7Xrz5Bwf8kHSQTv9+n+AWqCH2UPRziXVv+aO8TRJnISVFdPuqhSqS65HCoRg3/l
 O2M12N5Fm9yEJzDI3qe7lxvGCHHt+tfWS6irVfhD6B76MeP6GDbkRMU0OMuBQTPMO98u
 ux/T9njuCTrVYLFX23ikajYMratBjQFANiARN3Ij/c45UFUbPGEsfJEDG3bO7Jxy3pnO
 LkyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZoCsOD1ad3aMGnZwnJt6nUj+XKBfAXKVEZT1y+iMmwnkS5Ia9y0b6YAYaBIwEOx9UJDc=@dpdk.org
X-Gm-Message-State: AOJu0YzIm0amInKroptCI3pla5GZ161CDZ/3ordDGl0T3P8kU07fINEh
 TZbUiyk4LWc2YM+2GuvFN9a2q8DPI97+ouSNLlCrNtKBgdT8tWYen2S2CEboTNjHgT8jbIT4F7w
 2VZk1XKzBIrkKvvJxE7QrqoSRGGq+P10=
X-Gm-Gg: ASbGncsr3I0nAdXSHk7njr2rvoeislVDfRcLV2q49w7IlrR8eTPCbmTckr4GH5OrdwV
 mE8Q3AKx/tzEhXZUtuQ+p+soxijyo1kE8GqzFEt4d1/seEy2teB6MzMluCUZ+6nXI1NqvWwcd5M
 WJB0YgOV+Zlm1UG0uZ4rT5JtvvCoS7s06wDBw8bMdSqw==
X-Google-Smtp-Source: AGHT+IE1gCxxBKgSDMyBGJXTFtqQD+idGRHeefw1l4/7J+U3GcFup7IkdoDDwpus7bnWzHgAT4RjR9bIRO3D+qfN0kI=
X-Received: by 2002:a05:622a:540b:b0:4a4:3bae:8dd1 with SMTP id
 d75a77b69052e-4a4400eaac5mr53606971cf.44.1748608540866; Fri, 30 May 2025
 05:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
 <20250421151718.2172470-2-nsaxena@marvell.com>
In-Reply-To: <20250421151718.2172470-2-nsaxena@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 30 May 2025 18:05:14 +0530
X-Gm-Features: AX0GCFsT8lsdmzOO6U35Z-dcb2izPSefBxy5ACdjh_Jx82wSEdXGNg0j3CO9jIs
Message-ID: <CALBAE1OZP9B953DzvN969AG79UxbE_mdqu0avC08wbcMyDF4hQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] graph: add API to override node process function
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, 
 Robin Jarry <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
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

On Mon, Apr 21, 2025 at 10:06=E2=80=AFPM Nitin Saxena <nsaxena@marvell.com>=
 wrote:
>
> New API used by feature arc library to override node's original

New internal API ...

> process() func.
>
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>
