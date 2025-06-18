Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35ABC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 09:43:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E9A8427E5;
	Wed, 18 Jun 2025 11:43:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8295340EE2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 11:43:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750239789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BwUzst6NSWrPF+bmYRfK2Gq28PaILhCDDmKyjaprVg=;
 b=Ko8SL23pz6NAWJMOiS3XxmPgDJWIPfceEdZuNFHAORRfepMF83cSn1At80urLNmNzt/X3v
 80ezkVCbei+PFyz8XI8mOZdOK1T6AxVaJCaZeyPzZTxgL7isE3hy+pYuAVOHvZt8ZP/80c
 Lt4P0XtEZLNxWnVZrKmdgrM8fhIrs9I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-55Ih4fh-PeCkpyau8w43BA-1; Wed, 18 Jun 2025 05:43:07 -0400
X-MC-Unique: 55Ih4fh-PeCkpyau8w43BA-1
X-Mimecast-MFC-AGG-ID: 55Ih4fh-PeCkpyau8w43BA_1750239786
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-553addbf0beso3483599e87.2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 02:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750239786; x=1750844586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BwUzst6NSWrPF+bmYRfK2Gq28PaILhCDDmKyjaprVg=;
 b=cDkd0iWBQRmx6W6682vFT1+9YCD+U3gehcMfHZnnOHeFVHQmHgEU45Bd9gG0eTV8iq
 NSqX/ZMbmiIzpqIymjmUWM+kh7FugH7LS40MnzSjksXOS+GZbl6lPfhqhYADPwNvq6MA
 XeECndbQlvo8dl5cqwGFNh6L7iSYqGE/ftXDiyVmfXd71Ctn9P2YlMsWvIRSHP61Ex2b
 HrqVrgAdUMGjoz4CUFLNiUa/kI5vuny4jFJ9VitVJEnS5VS72Atfr//iZ97d97Bkd7pj
 4324wLxqEXIWqM6D5MCmRjQh/FXk+qE+MWyuh0NsguxMElc2kmcyaa6ARzB5GuuPTKot
 EuwA==
X-Gm-Message-State: AOJu0YxngugP31b7hwgssJqNNMNprSN58tNQbe4ETJqVC687Ddj1enkl
 Tfd0MsiNCwLYZYUxZ3mrvdiNHilh9QEdAnSkXbXNLC9EVMicuHDo1U8GZrmXDgtGu5yBFZMbvTV
 UZwsGXIA5EvjRfkc3+EnQCeNI4+ezbioclgn7IYmCadOTOpxn6K56MtkoaYtePWjUDnE19s9Xr9
 cMvhG569quObopS6jCCO0=
X-Gm-Gg: ASbGnctXPe8HAkGdVN2HQjoIBF9MYKd8Nb6B+ap4PzlYWUNx7LpXcdc4B7ZinKr7YZL
 +eBg9AXLTcc+1IpLDEE6eZMTtKlotdv7XXpWAQ3BJlMdIUD3EvZf0MtA0ygYYDHA90qDzLg707v
 uBK/kTEQ==
X-Received: by 2002:a19:8c11:0:b0:553:30fc:cee4 with SMTP id
 2adb3069b0e04-553b6f4c989mr3088452e87.49.1750239786065; 
 Wed, 18 Jun 2025 02:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlG9GUkQMYvkJrY8cZB/T/Zz/jqdz61uxhqVthLNgh0YW5/e5Lqz4qT53EKuWErYEkanop29qS/PiKfByC2zA=
X-Received: by 2002:a19:8c11:0:b0:553:30fc:cee4 with SMTP id
 2adb3069b0e04-553b6f4c989mr3088439e87.49.1750239785635; Wed, 18 Jun 2025
 02:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250613081018.2790825-1-david.marchand@redhat.com>
In-Reply-To: <20250613081018.2790825-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Jun 2025 11:42:53 +0200
X-Gm-Features: AX0GCFvMqA5S7fXt-8iwybjpqPS9Tym4ok3LUqhUvsKCCWH_4N8hnPyRWq_YlNc
Message-ID: <CAJFAV8w5wG2S=KwZuG96f0Law8nBL7R3GcbYd65Ksb-hL=7=ZQ@mail.gmail.com>
Subject: Re: [PATCH] common/mlx5: fix dependency detection on Windows
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, probb@iol.unh.edu, andremue@linux.microsoft.com, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Tal Shnaiderman <talshn@nvidia.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hdWhGZv2gNTJOxEsWGlxRzQMDqukwHykv-ler2qmEJ4_1750239786
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

On Fri, Jun 13, 2025 at 10:10=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> Don't *require* mlx5dev library when testing its presence.
>
> Fixes: 85c51a4ffab8 ("common/mlx5: get Windows dependency from standard v=
ariables")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied with updated commitlog.


--=20
David Marchand

