Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E4BCDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 07:42:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31A6540280;
	Thu, 25 Jun 2026 09:42:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B68EA4025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:42:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782373332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JNoJKtORcdw62FaJTYRYWTGQ9kGBE9Q8XWUdNd+TaaM=;
 b=SrEIXUZLMiB+X/Q1OCKHYtOZodOmlE/CBnEJcj8FMpY4KyjyU5iZiuySAHIdF4f3leBR74
 2D8ZeqJ/6kxf0Tq3aDZDhgaFqTIBo0ewRARx7eoKtBEBZ/x0DBMer5l5/s460OWtNFmAgg
 9MADzOAExm76f99c4DKNhkcxyz94Tu8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-UdNrv9K5PZ6oxDnTb77FSw-1; Thu, 25 Jun 2026 03:42:09 -0400
X-MC-Unique: UdNrv9K5PZ6oxDnTb77FSw-1
X-Mimecast-MFC-AGG-ID: UdNrv9K5PZ6oxDnTb77FSw_1782373328
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3997b56afe0so9465701fa.3
 for <dev@dpdk.org>; Thu, 25 Jun 2026 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782373328; x=1782978128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNoJKtORcdw62FaJTYRYWTGQ9kGBE9Q8XWUdNd+TaaM=;
 b=lQ3+KIpeOFOVJ/UBL+6RESvXnMQ+7WPp8YZxp8zLlrQBMLwhFC5npfivDmgvSn+/r2
 j2OPmuR5sNOJHAac6tv67ClRZxSUf7WqBG6+1k/WYYK1qmSqaFN9bV/KBGfxyvX9J0sd
 pB8D8a5qGJfWobKpUXeQx3W22fLA7zXMe3XgaOuUN4vtQaXqyLE8TsWVYhBjhuoVQZgg
 csPUknhsbEtZpb3vwaAhGHwIrjGsgOcTrIeODxfdB/1gfQlMuPjapLPfUmDa0dqrhOCn
 KRD16CW4gWhy5aBadg8w3Mpku48vx6Zlqs2FZ5Q6mr7nqHHLDAPHi/CDdOAa7lHLIZpj
 DDmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RppC+57tjbb0/9ZRc5azNPttodITfcoePT42Ng56Uo02yqzf8L+Kgy+PZADMXVCzBM4eLY=@dpdk.org
X-Gm-Message-State: AOJu0YyqVf2KaDz7qKVosuRRy6oEEUZO5reQ0qq1NUNSIqYacIIMmBiu
 qPk05S9GqWyriw/MawJTnq04XEhezYRn5+wIsqxIJJxnOUcmuAOlAYy5pNRD8fVnMgfwDKuhrJt
 PIRh0vaOouRNMBLu1lxkaqEXB1Gwr32ymHSCaAtash8sbckX/RpWcXgRlVgXoosWx2xHzqDFESL
 IdJNHpTXvIWbVPErFvxzo=
X-Gm-Gg: AfdE7cn7/W8euCyoMSTONn3N9ZNDDA49Uz6KRhT6mOQvfCsJTlWnvXTsDsi3D2rcCfw
 +c4TGCBT9fAefWUf5vvj0BRV9gWSZqJ44DkTphnXHNOg6n0wMfomPXFrbKkwPL+sV5gmNulfWjT
 /1wfV+T85KuKgAb9jWZ6byYcEhsokRlol3WCljfQeR9aTyiZJq2HL5wQ9v4PBrdbAKF1LrHRZdj
 nhvtqTTMzFLNXGbO2vb3ldIEiGO/Y7mGX4FpklZvTR/xsOtjVuy9bdmPbY=
X-Received: by 2002:a2e:ab18:0:b0:396:8029:e2e5 with SMTP id
 38308e7fff4ca-39acb69fa18mr3366911fa.18.1782373327986; 
 Thu, 25 Jun 2026 00:42:07 -0700 (PDT)
X-Received: by 2002:a2e:ab18:0:b0:396:8029:e2e5 with SMTP id
 38308e7fff4ca-39acb69fa18mr3366821fa.18.1782373327529; Thu, 25 Jun 2026
 00:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-1-dsosnowski@nvidia.com>
 <20260624131337.1127323-4-dsosnowski@nvidia.com>
In-Reply-To: <20260624131337.1127323-4-dsosnowski@nvidia.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 09:41:55 +0200
X-Gm-Features: AVVi8CfPgoJWe4GeVnVmD27pC4Snu52hqxGeEk-de__O1h7hVX3hdXWQcXBY8cU
Message-ID: <CAJFAV8xxo9DvN=pfvk8Oetvd8OgOe_EekY_FE5tZuPMmsAKDKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] net/mlx5: fix stabilized function versions
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org, Yu Jiang <yux.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J481LPHGzRqVB0XQHsnwZhWJlhdcP7u5fxgGp4PgHy4_1782373328
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

On Wed, 24 Jun 2026 at 15:15, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>
> Offending patch stabilized the following function symbols:
>
> - rte_pmd_mlx5_driver_event_cb_register
> - rte_pmd_mlx5_driver_event_cb_unregister
> - rte_pmd_mlx5_enable_steering
> - rte_pmd_mlx5_disable_steering
>
> These function symbols were introduced in 25.11.
> Any application using these functions, linked against 25.11 version,
> would fail when used with 26.07 libraries, because only DPDK_26 versions
> of these symbols were exported.
>
> This patch fixes that by adding proper function symbol versioning
> to these symbols.
>
> Fixes: e8cab133645f ("net/mlx5: promote some private API to stable")
>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

