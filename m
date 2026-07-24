Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B897C531F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 07:26:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAD70402A7;
	Fri, 24 Jul 2026 09:26:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B01174029B
 for <dev@dpdk.org>; Fri, 24 Jul 2026 09:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784877986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bvo/Ds9tviyvyCrtY8XJRmb23LhEJQxMfoddhAK+YYk=;
 b=JyyNJ3vj7CO8Q20f9g1Fqwc3Ogm0RC+n60tsVKBFsGFVNUr5ZuHHfGMhcmi7T2lgRcGECU
 b4hSsJYKNo/+4Wnr7ctbM8EmRHl1ITjajp6uqazHv8q6muly96E9HYn/gezOw7fhThLNZh
 iEWd76Z9NdArdiFKEH4BuAGvu8oIt/I=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-wpZmE5ZiPt2X-EcTKOaNWw-1; Fri, 24 Jul 2026 03:26:24 -0400
X-MC-Unique: wpZmE5ZiPt2X-EcTKOaNWw-1
X-Mimecast-MFC-AGG-ID: wpZmE5ZiPt2X-EcTKOaNWw_1784877983
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb711dff7so123052e87.3
 for <dev@dpdk.org>; Fri, 24 Jul 2026 00:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784877983; x=1785482783;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bvo/Ds9tviyvyCrtY8XJRmb23LhEJQxMfoddhAK+YYk=;
 b=r5QPKXbIrwYSRZz2UpGhWD7V8olq/l6u4pDYZxh9I3RCq8LeMsJ4ul1AnC+1Qwn9NW
 MEDBG8zrsP+CpdqQHrKIUSPynKsZZAUeUAhitWDSHgYAI9DE6ZWGCIXcHAkHWMjySCGP
 FLmFB/6namzLLCYfI43R0aBghda45AONsVaToGEHJrc6/RKZpMIQu+sgct+6yRgHd3P2
 +tl3F4GFp90UwctWpCaqre1IyPldYy1a8yL6E68NlG/0J+bUzzfqWJa3vi0KqBTH3WW4
 Tmyso5pj2uVhEtiuzV7bfmOxLpMio+JtqtiBCOJMjAeyshYXDHAkvTKYIPRnVgy8vTvm
 vthQ==
X-Gm-Message-State: AOJu0YwhGFQ07ca+b3+OPhWhGc0jbrJk+NXj8sxlhdCQlzEYOYnRLtMF
 OWeer8NUPNJY62b8chaoncuj0bTNt+VmImV4l7rZeZcWrpgxBtuR24mvMNEm952JW8/4RvBUw7q
 midLAIQ4BuLe6+QoXx3LSQe1g3AWczZI9ZquZ3e4dYzHvkkt8WhtxfZa89bcMrd+TgSMyFUHC+n
 brksynKWpoL9fuiFlUT6Q=
X-Gm-Gg: AR+sD11/OUaqtqqCmfZtRbOZA1dTExa/3HYoP8BhSqIJzRMz7ONLG6Y0iwH3zkY6Ogq
 HFRKVLwB2JxYFlHD/SZH3cFnzvm6+GFfIR9TXqiR7eyb7bBjPCng/sMwvyeIOpvCT60jztSdOmF
 rGtPaVMUuNOEi39TsrzDTO+RWHeGb9K4z63eqGOMhR5TkNdXOmZJbqRJlB7Tmb7s3/3gRjzVS6N
 K7MlSde19otfIr8Nab0DdFHpcKyPwgRD+q5FflRt0hUfKCr
X-Received: by 2002:ac2:4988:0:b0:5ae:a995:c16c with SMTP id
 2adb3069b0e04-5b2b2f525a4mr1015218e87.27.1784877982997; 
 Fri, 24 Jul 2026 00:26:22 -0700 (PDT)
X-Received: by 2002:ac2:4988:0:b0:5ae:a995:c16c with SMTP id
 2adb3069b0e04-5b2b2f525a4mr1015205e87.27.1784877982523; Fri, 24 Jul 2026
 00:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
 <20260723202936.378793-5-stephen@networkplumber.org>
In-Reply-To: <20260723202936.378793-5-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 09:26:10 +0200
X-Gm-Features: AUfX_myEII-p2cOOrkg_uS6S_-X1bpRLOZ2atjvx_5RsVC7DHNhqjmornjWa-n4
Message-ID: <CAJFAV8x3t=CFs=q0uw=fhCncUMKQ82wmOpzsOz-LKEN4ez9r1w@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] net/cnxk: remove queue stats mapping
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -Pe6dIq83YUDWX5TNY6kAGqgE4sy4cFexYhnS_WcX5c_1784877983
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

On Thu, 23 Jul 2026 at 22:30, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c
> index d57659ef51..e5d29a78b3 100644
> --- a/drivers/net/cnxk/cnxk_stats.c
> +++ b/drivers/net/cnxk/cnxk_stats.c
> @@ -14,7 +14,8 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
>         struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
>         struct roc_nix *nix = &dev->nix;
>         struct roc_nix_stats nix_stats;
> -       int rc = 0, i;
> +       unsigned int i;
> +       int rc = 0;

Nit: rc is set the line after.

>
>         rc = roc_nix_stats_get(nix, &nix_stats);
>         if (rc)
> @@ -33,31 +34,35 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
>         stats->ibytes = nix_stats.rx_octs;
>         stats->ierrors = nix_stats.rx_err;
>
> -       if (qstats != NULL) {
> -               for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
> -                       struct roc_nix_stats_queue qstats_data;
> -                       uint16_t qidx;
> -
> -                       if (dev->txq_stat_map[i] & (1U << 31)) {
> -                               qidx = dev->txq_stat_map[i] & 0xFFFF;
> -                               rc = roc_nix_stats_queue_get(nix, qidx, 0, &qstats_data);
> -                               if (rc)
> -                                       goto exit;
> -                               qstats->q_opackets[i] = qstats_data.tx_pkts;
> -                               qstats->q_obytes[i] = qstats_data.tx_octs;
> -                               qstats->q_errors[i] = qstats_data.tx_drop_pkts;
> -                       }
> -
> -                       if (dev->rxq_stat_map[i] & (1U << 31)) {
> -                               qidx = dev->rxq_stat_map[i] & 0xFFFF;
> -                               rc = roc_nix_stats_queue_get(nix, qidx, 1, &qstats_data);
> -                               if (rc)
> -                                       goto exit;
> -                               qstats->q_ipackets[i] = qstats_data.rx_pkts;
> -                               qstats->q_ibytes[i] = qstats_data.rx_octs;
> -                               qstats->q_errors[i] += qstats_data.rx_drop_pkts;
> -                       }
> -               }
> +       if (qstats == NULL)
> +               goto exit;
> +
> +       for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
> +               struct roc_nix_stats_queue qstats_data;
> +
> +               if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
> +                       break;
> +
> +               rc = roc_nix_stats_queue_get(nix, i, 0, &qstats_data);
> +               if (rc)
> +                       goto exit;
> +               qstats->q_opackets[i] = qstats_data.tx_pkts;
> +               qstats->q_obytes[i] = qstats_data.tx_octs;
> +               qstats->q_errors[i] = qstats_data.tx_drop_pkts;
> +       }
> +
> +       for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
> +               struct roc_nix_stats_queue qstats_data;
> +
> +               if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
> +                       break;
> +
> +               rc = roc_nix_stats_queue_get(nix, i, 1, &qstats_data);
> +               if (rc)
> +                       goto exit;
> +               qstats->q_ipackets[i] = qstats_data.rx_pkts;
> +               qstats->q_ibytes[i] = qstats_data.rx_octs;
> +               qstats->q_errors[i] += qstats_data.rx_drop_pkts;

It was already there, but I find it suspicious that only Rx errors are
handled like those are reset on read.


-- 
David Marchand

