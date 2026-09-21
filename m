Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F7C982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 11:52:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4644E427C5;
	Mon, 21 Sep 2026 13:52:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D811F40E0F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 13:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789991540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tQUava4sqs9q++yfJxY+7i61jH54Y8j2+nVHhGdF9P8=;
 b=iuC2OXfygIEpkG4XAaAME1Llmcim2P8L9jmrQLi/9DIBQg90yMr6bXIv1rE2dOH1eiP3xM
 2lwK8cgtqwyI68UgmNmqIOKF5p2WNDVY2TdDmoTdLINYLwSyuKzuFxCXw9z9Z69IpvVnbo
 tIlVbJk5Gn7YwcC627KAr4OcrFY1dqo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-QghLiODOPrS81Wq5TY0k8w-1; Mon, 21 Sep 2026 07:52:19 -0400
X-MC-Unique: QghLiODOPrS81Wq5TY0k8w-1
X-Mimecast-MFC-AGG-ID: QghLiODOPrS81Wq5TY0k8w_1789991538
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b767658227so1607223e87.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789991537; x=1790596337;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tQUava4sqs9q++yfJxY+7i61jH54Y8j2+nVHhGdF9P8=;
 b=xVux4SWlRhyakOVyDA1KN3jynqO4ighW81Yndf7sDv6SKmSSxpwtDGq2VVxnRYVmmv
 jzVb1bsjW1m4TjKr1UzuH8nvRTm90ZLfLrv1ZF4FDQOuK+NaBxhbwQ4DtW9qLos5N9d8
 u5TB7FqPcvMbACGf6i5KQASNC5ejHGVinWfFGqSYWB6nThIJUGJ/5O1dWdDw/qvVaAwf
 DCyTJdXprUDL2iYfmtDMG/F6hK5+L3QF6hIawhkBEXBezruJlxktknnBMS+CO9ViSKRE
 UZG8YFgQpfuFa13cCiOYlQ0s3BG1OiiIqtQLYw5roQcpaQekKVqZCb2STDqqTc4ulO/Y
 WBbQ==
X-Gm-Message-State: AFuF++kEUHeG0l9SSdclrldmhfjvsSwlNQ0C++eDXN/WxlIWgyUYiwmn
 F2QvVsfIdwucHAbiHV4uXzEdtMR1/7vHf13cLVBlA82EaIXxjfIlFzjHzdk3xS+8u0BY5Q2tUHZ
 jM6ia87xt+1UkYX7YXXuBcoYHA+pTMv1/M94qOxvs9e9N82WEhQk+GZ0+rVVSQ3etM+1lfFzcQf
 NA0EyUUHzUPFWw9XgkN+3+eVH7fxzGFA==
X-Gm-Gg: AYBFou1KTMJ81lnW8oy9Xssn40ULDOUvAXVxFM49MrV7LVzR1yPVnPeibhRTELYz4dK
 75vuX/AVe8irXRe6CF4QRcvFup0MrFQaXVPBmwSCTr9DpJSwPFC25uCEuqExmNhdxVLEcI2nOci
 cGVYWhB9kHvDEkWXdzm0IaPFlMlQG3sKI0t9r5Ui9E8DfdLNbUL6pb4eNJKGnJMo5kO6GX8P5pW
 LM4OV9LdjKwdMSfi1qsjx4/jz4/kuXfhdyGNkxc3z+U8jca
X-Received: by 2002:a05:6512:6ce:b0:5b6:4ae:3ff6 with SMTP id
 2adb3069b0e04-5b8c181900bmr3337335e87.30.1789991537221; 
 Mon, 21 Sep 2026 04:52:17 -0700 (PDT)
X-Received: by 2002:a05:6512:6ce:b0:5b6:4ae:3ff6 with SMTP id
 2adb3069b0e04-5b8c181900bmr3337321e87.30.1789991536833; Mon, 21 Sep 2026
 04:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260921115033.2335147-1-david.marchand@redhat.com>
 <20260921115033.2335147-5-david.marchand@redhat.com>
In-Reply-To: <20260921115033.2335147-5-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 21 Sep 2026 13:52:05 +0200
X-Gm-Features: AcwNN1UGk0MfXXHW2j-L80w3Cy0ZGtjB7U3n9Pj1C5mxxByQsrOGhrDY7QxgUik
Message-ID: <CAJFAV8wXu3NFNOkT9kjP126Heamj_j9y6DTsLT-J9rr-M8oYrQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] net/mlx5: accept more unicast MAC addresses
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kFXm6Hu1H8TZ4twq2TB_VSkOcMlu2h47WfSKpjOIENY_1789991538
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 21 Sept 2026 at 13:51, David Marchand <david.marchand@redhat.com> wrote:
>
> Starting firmware version 22.49.1014, the number of mac addresses
> per VF is not capped to 128 anymore.
>
> The value can be increased via devlink:
> $ devlink dev param set pci/0000:3b:00.2 name max_macs value 4096 \
>         cmode driverinit
> $ devlink dev reload pci/0000:3b:00.2
>
> On the DPDK side, we must retrieve the maximum number of unicast
> and multicast addresses supported with a query to the firmware.
>
> Then, dynamically allocate the mac addresses arrays and report the
> limit instead of the previous hardcoded value.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Sorry, I forgot to add:
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>


-- 
David Marchand

