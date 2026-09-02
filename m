Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D0CC61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 11:56:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D0DA40E21;
	Wed,  2 Sep 2026 13:56:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6DF4F40E21
 for <dev@dpdk.org>; Wed,  2 Sep 2026 13:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788350176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lD3L5TDEiyfCOjgKfaYLSKQkvALY87AitxXMzJtDxao=;
 b=A7QAq74S40f+flYd3pO43D3v7YfSzRHE0XDSD4evOP5Gq6gTtCrhU86kVOOiYsly55VICP
 JgDx6Ifj2+68n0aVh/54GKD7RCAI5UDLfzszfkdpWDyzoX7CChG4JxYLMEBx3ksD3TOkqE
 QBl/3ImoxM6sHVU7dsKIybqrMkZPFPw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-ogeigZgZPfiOOu1zy8Oa8A-1; Wed, 02 Sept 2026 07:56:13 -0400
X-MC-Unique: ogeigZgZPfiOOu1zy8Oa8A-1
X-Mimecast-MFC-AGG-ID: ogeigZgZPfiOOu1zy8Oa8A_1788350172
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39f6d16661aso6972291fa.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 04:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350172; x=1788954972;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lD3L5TDEiyfCOjgKfaYLSKQkvALY87AitxXMzJtDxao=;
 b=PZ+NuUqiE8nwyC15C7E+wcBJhpBboKZKXwEz3zPQWvAEjkTUF0Yw14LdK31klaoxOi
 DR69D4HQY7L20v2VJWa1W2FjsXYDNUxqPpdQt7AHJdwCrF5XyT+e5dron7ZbfhFullOF
 oUG2BYYt1xt+d8AxitR+BMHebPURnUWB4RKYWgsWrb7LGRoW+e3FMDk6mkdS+tA43k9k
 Al+w7PS/833gv+nEP3nx48EYJ8DlsFStlcuxv5qRL7vnGOCAFfqARTwzr5Zgmnw6/4n+
 hNpg3bYaCLW4PcBSE+U0Wb0hMuDs9cb1HXARjT0HyM1ps0iEOL2mpyA+6xDfcGvJurvv
 snlg==
X-Gm-Message-State: AFuF++kxXnNsXkGVrRhm4SPR9dhuOGg6U5J7/dHBfoLxV1mhdaaaRLaa
 kRs5HQ5eN/ARW7xgeGOCubYTbLDrzfgTH4aKyx4rBGkJmOhYWWjF7EGgmdo707a/bV++SmeGVPx
 Fa4wtQV0Aft00e9fxdfbBFC2eYZR8n+2XzRk9mAdbhYiv1I50WaBdc5h4sDuSgRjD1E3jbB8/F7
 5EJ2u0T0fu+BsqtSz9nx8=
X-Gm-Gg: AYBFou30pB3DTAJ/+LGo8QIlLNAUYucOPH8PK/Vd/CL3ALqsYTinTfGJSvDMUvwh17e
 B2aqsG9FQ8zLA52fiHOwqQJvr5PDpJ/TimqNWi/PZecADhEoHsRU0qWFfTxz4zt2YTHe8yZR6K3
 Inf8H5BIrVMRgsPdV925u8xflOEXOBXg/3riuQiTy4L/uzoAEOrBqtP138kDNy89vq2+qxsihYZ
 eipI6y7pgsSbtUIe4m1uZKKC4SyUOQ51EbkizeRQRz+CjSG
X-Received: by 2002:a05:651c:31cf:b0:39f:1b37:82bd with SMTP id
 38308e7fff4ca-3a34fda5fb5mr10894221fa.11.1788350171842; 
 Wed, 02 Sep 2026 04:56:11 -0700 (PDT)
X-Received: by 2002:a05:651c:31cf:b0:39f:1b37:82bd with SMTP id
 38308e7fff4ca-3a34fda5fb5mr10894111fa.11.1788350171310; Wed, 02 Sep 2026
 04:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260902092938.111197-1-dhanush.bt@chelsio.com>
In-Reply-To: <20260902092938.111197-1-dhanush.bt@chelsio.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Sep 2026 13:55:59 +0200
X-Gm-Features: AcwNN1VxHasgc0NH4zF5YiyWwOnuFNaR7gBIP2fk55dmu2-J0u8L-a4gfBCXfcQ
Message-ID: <CAJFAV8z=uuUzFF38uR1MM85_QQfP1mqmcLw94T5nGgPv=oqkBg@mail.gmail.com>
Subject: Re: [PATCH] net/cxgbe: fix use-after-free in control queue teardown
To: B T Dhanush <dhanush.bt@chelsio.com>
Cc: dev@dpdk.org, bharat@chelsio.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T_QIlvKRvxcsQ5RmbH5dt3DLxCyl7VVaS5xwF4vPxbk_1788350172
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

On Wed, 2 Sept 2026 at 11:47, B T Dhanush <dhanush.bt@chelsio.com> wrote:
>
> t4_free_sge_resources() frees ctrl Tx queue and firmware event queue
> DMA memzones using adapter->eth_dev, read at teardown time. This
> runs only once, when the last port on the adapter closes.
>
> rte_eth_dev_close() frees a port's eth_dev->data right after that
> port's own dev_close() returns, regardless of other ports' state. If
> port 0 is not the last port closed, adapter->eth_dev->data is already
> freed by the time t4_free_sge_resources() runs, causing a NULL
> pointer dereference in rte_eth_dma_zone_free() and a crash on exit.
>
> Fix by not dereferencing eth_dev at teardown. Store the port_id used
> for each queue's memzone name at allocation time instead, and free
> each memzone directly via rte_memzone_lookup()/rte_memzone_free().
>
> Fixes: 36c46e738120 ("ethdev: cleanup shared data with the last port")

This commit may have made the bug more visible but I doubt this is the
reason for the reported issue.

> Cc: stable@dpdk.org
>
> Signed-off-by: B T Dhanush <dhanush.bt@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>

I don't understand the issue for now.
Something looks wrong in the driver, and the description above.

The adapter object seems to embed shared resources across multiple
eth_dev objects, is that correct?
If so, any function taking only a adapter pointer as input can only
deal with the first port related.

This is probably the reported crash and then I would point at:
Fixes: 6b78a629954c ("net/cxgbe: fix queue DMA ring leaks during port close").
Which releases only the first port DMA resources even for another port.

If those DMA resources are shared, the driver should not use
rte_eth_dma_zone_reserve() and this driver should come with its own
helper.

But otherwise, if each eth_dev object has its DMA resources (which
seems more likely to me), then my suggestion is to pass a eth_dev
object to the related functions.
And a followup cleanup would be to remove the back reference to the
first eth_dev in the adapter object which I find really confusing and
could be a source of bugs.


-- 
David Marchand

