Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA667C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 09:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFA9242E4E;
	Fri, 13 Jun 2025 11:42:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1DD7140151
 for <dev@dpdk.org>; Fri, 13 Jun 2025 11:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749807762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkJh0F4UE/DmL5WT9CJdhB031JFSvATdVQVE5/ty3WE=;
 b=R9QCV+vMetI6Na8QK7tfpsvgjvIKK0bukXHbGg9XB48Zr5sowHNytsL6xryeZVeURag7/m
 +NHqldmoPImzDxedfbluEjG88/1EaRSoJI1JA/NZZJGKvpym3z1bKsXyR6C2Pz244G10D+
 XvzM0bMteXo3Y7yi+5Nd+WRm6jna/wo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-FwN-SA2vPhqpJgAyFg62ig-1; Fri, 13 Jun 2025 05:42:41 -0400
X-MC-Unique: FwN-SA2vPhqpJgAyFg62ig-1
X-Mimecast-MFC-AGG-ID: FwN-SA2vPhqpJgAyFg62ig_1749807760
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-553acdcd5a1so946140e87.2
 for <dev@dpdk.org>; Fri, 13 Jun 2025 02:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749807759; x=1750412559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkJh0F4UE/DmL5WT9CJdhB031JFSvATdVQVE5/ty3WE=;
 b=Aqni5i7OzhvRcGbL+K8oyiCnLQ0qC/4vauWsarSA0eW5/fbEEwV0tM6432DS6IAN78
 hpv1fo+EHz3yjpxueBrOTxdCxQm1iTMpNqr8N5v4qKPufS2Wwd9sgjUWVCxjLxie4gVN
 5ocCybWuCHdeMSGkJiX1Hs2r4wWXbHegKp/pamcbaeEfwbtt1nHO4eufUEhxldwti/De
 zjl8PhDPyrxo91AevHH6UCGVal6uPoaQJdQdY7OB1qzx1nAinnI4Fe9Np52gKtbMq1Ws
 hbmcXauIAaDYbu3u2V5ctGEhXcTqNoKKxGPZZFvn7b75OCJqlVdZsejyhwmjVs0izKm+
 S+6g==
X-Gm-Message-State: AOJu0YzaucrysOlE2TnequI4Y+WYpiNxMu0zwPueQttcPvwsmXs+OlnP
 dFvPEN965W9JixuXgA7nhDKnPa+WNyzgZ+GP2Ee7CR/V/Mh4aEu8UQJz7YVoPmTRpzlA5nmC+0g
 8Zm3Yf4Vs/6S7+WBumiPhr1lzmSJ1zfjR2OEWvmMeiw20qAFig0iQ2q25AoUchQ0/XLxybAzYOp
 Gu8Dz89P4G2YDIb3U+SZOLaHxr8LAmTA==
X-Gm-Gg: ASbGncsWXiUWGKMgWvtlxtuFvvuPjSU166plA3Zsmqgq3YLVo1NrW+fJdgZKj/IWvdb
 fSoD233HuGDTKWabb/xvemoEjAMpGDaR7rGrDem2AFtRFPxzhjzXIzXyHuIhTRuRoG5/gwcUm3i
 WzR7UM8g==
X-Received: by 2002:a05:6512:318e:b0:553:af30:1e8b with SMTP id
 2adb3069b0e04-553af98e506mr628310e87.38.1749807759199; 
 Fri, 13 Jun 2025 02:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFwzgh2J5ajq5h3aSBdXV5OJQ2uZ1hRuErfRrgB32gZ81u1NcbfWDhmODweAyrL+oTnUhvDlg0znoaI89nOxA=
X-Received: by 2002:a05:6512:318e:b0:553:af30:1e8b with SMTP id
 2adb3069b0e04-553af98e506mr628293e87.38.1749807758811; Fri, 13 Jun 2025
 02:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250613081018.2790825-1-david.marchand@redhat.com>
In-Reply-To: <20250613081018.2790825-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 13 Jun 2025 11:42:27 +0200
X-Gm-Features: AX0GCFuywHPgP8BkBhp0i2VH1kS_scQ_zPUBeZ4mcxRquaxTNbE6fWYH9lGsfGs
Message-ID: <CAJFAV8ziisXinUmbOSZ7r2EHoioqgEL-KS7Y1dCY=MH2AmnxDQ@mail.gmail.com>
Subject: Re: [PATCH] common/mlx5: fix dependency detection on Windows
To: dev@dpdk.org
Cc: probb@iol.unh.edu, andremue@linux.microsoft.com, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Tal Shnaiderman <talshn@nvidia.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JHrJP6uqJihZOPpwJRqPvdps0AwDa8UK-FKq7wplea0_1749807760
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

For the record, this was seen in a UNH env that seems to have
partially installed mlx5 dependencies.

Has header "mlx5devx.h" : YES
drivers\common\mlx5\windows\meson.build:10:0: ERROR: C shared or
static library 'mlx5devx' not found

>
> Fixes: 85c51a4ffab8 ("common/mlx5: get Windows dependency from standard v=
ariables")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>


--=20
David Marchand

