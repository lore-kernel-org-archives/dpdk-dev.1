Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56CEC624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E586E40A77;
	Fri,  4 Sep 2026 15:09:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E74864021F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 15:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mpRPYGqZ7Uibks2oR4w4diG7gzkA9lzFXPoE9roNn88=;
 b=D/IXFnJRiqyicZunW6pdvVPsr308MfxfwXbz19XZZV+vLIDMIZJBcxVW+9C7raPP1H9obB
 Xa7AKOcsj4TTVn0Ud3N2N8VS59cpsBNkGyO5f/CcEyhnarHteublsjf57pP6HG4Js4PkjC
 1xlc4UA+VDFB1EzBiyPLNcvgcmmGQWU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-FQ7y2p7CPWy5Zt8l9EcuNA-1; Fri, 04 Sep 2026 09:09:06 -0400
X-MC-Unique: FQ7y2p7CPWy5Zt8l9EcuNA-1
X-Mimecast-MFC-AGG-ID: FQ7y2p7CPWy5Zt8l9EcuNA_1788527344
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39d93d95a21so7931151fa.0
 for <dev@dpdk.org>; Fri, 04 Sep 2026 06:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527344; x=1789132144;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mpRPYGqZ7Uibks2oR4w4diG7gzkA9lzFXPoE9roNn88=;
 b=acW6MyqS+k/YsHhQTJwJdilBZF2CVD6sJEVpKgpXjr6PlJZiJtjbBY65DXyRl7/p1i
 rm29hGdW2TYLc6A4gkS/zRUHulJqMCUxL9Y9J5ndXd7SmPOWFDB9IR9jkLbTWsYTY4G/
 Hqdh6HAFwG+qfOjMWcXxM10tEFLK4es1eYRcfq395nl7I7sDHPQ2h6IPobu6UDUfP7zu
 Q6IBkLVyPminG8ONOkuXwvgJUCgfZ0gvPBqW+niRDmcLm3WJD8oYrb8zdbsFquPHVrQl
 fICbMlOl1/+9L4EMk/6uY9lfW+c3LOTvDG+og8eHYyV/NVxQS1MWiDEH6kh6bJm6ufwO
 6yPg==
X-Gm-Message-State: AFuF++kUsp843+ST0X75119q4/JEynWd0PiQ74NvxkEj67Mah1jMcAc+
 qAmmGIsNo1OIh22AculMggDAdHt/0sd0VDTF+zpGDUZzWCgEU+RPN93weqUEgBjvCUlJviC9Ofl
 OC9rxQk7f+JPEA6ZDGyWV0vQAFPYaFvuG7gQZ7rgn40bSEYRJCwPCChp9GQOhuHYxO9fPAuQMKl
 26JkrZ6J+TlOWNVHmh6qifwtbjjJI=
X-Gm-Gg: AYBFou0/El2b7DbWJvuXgBVlEA2XgsFl88bvsSZPFvzOpBms5IlXk6xLCEB5nQ4pNd+
 fLP4HXsGbpkX5FJVd969wEzVezVdH9IGQNuDLa16EFCQ4HRSqLoTJ00ES2bwd2y+9aQ5ny/CmqA
 dEkqQmJtvSki9TZzTLpebbF+6rMBdmA3aatmY8cLEYF33mNHo7YOBmdYK8y2XWuRd8xhc0vcVeZ
 LAJ9Dx0yXbFgzHuG6K/S+pDPO0+Qyrq2A6+DZfryxk/C/Rd
X-Received: by 2002:ac2:4e10:0:b0:5b0:ceb3:1150 with SMTP id
 2adb3069b0e04-5b616f0ad41mr1252257e87.8.1788527343724; 
 Fri, 04 Sep 2026 06:09:03 -0700 (PDT)
X-Received: by 2002:ac2:4e10:0:b0:5b0:ceb3:1150 with SMTP id
 2adb3069b0e04-5b616f0ad41mr1252244e87.8.1788527343164; Fri, 04 Sep 2026
 06:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260904121651.2254684-1-david.marchand@redhat.com>
In-Reply-To: <20260904121651.2254684-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 4 Sep 2026 15:08:50 +0200
X-Gm-Features: AcwNN1VFMfmirgPdQJKVSIlZVan-x0hVZQ6RCpTVhAhxjJTv2J83mqhv2M0gq-U
Message-ID: <CAJFAV8xcQRDDp+B+KNN-hNwK4q9b+z+i_fOLiNEh_bmosi7ZjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/i40e: fix MAC address removal
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CX-y5ypAlbd-7tydfpbgXnlMDZ2j9zsPdiwEmHYyIF0_1788527344
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

On Fri, 4 Sept 2026 at 14:17, David Marchand <david.marchand@redhat.com> wrote:
>  drivers/net/intel/i40e/i40e_ethdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index b6b2d291ee..5bc3c22def 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -4513,7 +4513,11 @@ i40e_macaddr_remove(struct rte_eth_dev *dev, uint32_t index)
>
>         macaddr = &(data->mac_addrs[index]);
>
> -       pool_sel = dev->data->mac_pool_sel[index];
> +       vmdq = (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0;
> +       if (!vmdq)
> +               pool_mask = 1;
> +       else
> +               pool_mask = dev->data->mac_pool_sel[index];

Arf... some git commit -a --amend was missing before sending...
Will send v2 soon.


-- 
David Marchand

