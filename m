Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82423C5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:19:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBEF040270;
	Mon, 24 Aug 2026 18:19:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2DFAD400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787588358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMAPWu9uXuNnEbpjN+ImU3ObIXY+0PfVQ7TH7xYUimM=;
 b=GMC7T7wpIriH288Q36hlJR1fTxZma8lqKdVoP4tsjbHm48B6FRc9BJ0t58zDqj5N5AmIUx
 Bdp5R0El68IjjK+6zIoI21FdCRQnf448h+7ilPPiMvrosSOswa97tibi3yGWEx5QBL/H54
 MpVk3cS/VwBqkNuWMGNadxBtrbmLzSk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-oJCQGIgOMmCG7ALeIXoJjw-1; Mon, 24 Aug 2026 12:19:15 -0400
X-MC-Unique: oJCQGIgOMmCG7ALeIXoJjw-1
X-Mimecast-MFC-AGG-ID: oJCQGIgOMmCG7ALeIXoJjw_1787588354
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aec6240ddbso2218114e87.3
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588354; x=1788193154;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iMAPWu9uXuNnEbpjN+ImU3ObIXY+0PfVQ7TH7xYUimM=;
 b=KSRmn8SRRmFeDPRTf/xSYoGc9zGsAju4YBvFkf2QBkm8oSkMJcpPRQTxkW9vKuYm+a
 WHcjWPGYzJ2kBxy2RpVocCHzLSg2Mchi/sCTfUmZ/K4GPtU1LHF4icamlB0SSkaJ8L/t
 2rkcAl9rWmAtsHGEhgLwjDxv8nRZ6NkjLw8EzGbh07g2FbdERxuUT+8JFgFv1B3GNgW+
 SRKeo2q0grZHxhLhKiHkerPclTmSzx1TXcmrMCkXTo6oBG6XpS8doPmz+5WCrmLtpWtW
 xlsWbbVhO3I6Wvgv22psoC7MDJPjrulQaIeBUgHVKUcaSmoZJGHp6mRFMQM7idOQgQdB
 pfVA==
X-Gm-Message-State: AFuF++mtxgcioC4j0PSwvH4DhOr1930DVjozXj+bxb+im5b+lqBoyMKB
 gPakJ2jDrWcgU+ZGrtKFgcOEYUrUhQhrLvsK1gABq0ntQ91nO76C3JSBakec3tq0xbSuQUsfSeQ
 LqXtKxF1z1fU1wuLwDrwgD3DpaVnE83Qc2OFpF5QEHIVC8m6xIfkI06oNc1EkGyiYAYyMKa/OZH
 KBTal+YLoxiJicqLBiGlQ=
X-Gm-Gg: AR+sD11rXHYzNyfg+DViU6PqoLY8e4VNDDxTM5NtxRoYaNrSvHpgQaWiv05rATTvCND
 FZJ6TFqXb23XxvxU1/2dGfHA2FGR26mR/ZeK9QCsDp9Z81N6x35xxtDJvgiXR8mtya8nX1DfKYH
 bSlI80vQ7vruoXSTAZM+QQtwnV9VYZ3J9n48nUKvOnjwYFoG0X/gvs1jqZdHBPfYaj/IaZSKJbP
 iGTB5dFbingmZs+I2Be4d5JL8E5EDwHF34DAA/Qwe/bvOvi
X-Received: by 2002:a05:6512:2528:b0:5b0:1b78:495d with SMTP id
 2adb3069b0e04-5b48b8b548fmr5744312e87.24.1787588354181; 
 Mon, 24 Aug 2026 09:19:14 -0700 (PDT)
X-Received: by 2002:a05:6512:2528:b0:5b0:1b78:495d with SMTP id
 2adb3069b0e04-5b48b8b548fmr5744282e87.24.1787588353672; Mon, 24 Aug 2026
 09:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260727070210.1281566-1-david.marchand@redhat.com>
 <20260727070210.1281566-2-david.marchand@redhat.com>
 <ZXWdfjrPRRuXz-Bm5UCJ1A@monjalon.net>
In-Reply-To: <ZXWdfjrPRRuXz-Bm5UCJ1A@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 24 Aug 2026 18:19:00 +0200
X-Gm-Features: AcwNN1XBiSUWeeoukI7vN8xWPHWvOWHKKJXmpYsEafU0fNzQKUz0rkRl8HkhY10
Message-ID: <CAJFAV8xVA4x97jDsfsLTM7CKJ_PYJvPAxjSSK3WApgu25ZWboA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: remove deprecated catch-all flag
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Gaetan Rivet <grive@u256.net>, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c5NX1sD6UJv_KyMai18q-FZLd2C0KvfGKCuxQI4ZiHg_1787588354
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

On Mon, 24 Aug 2026 at 17:47, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 27/07/2026 09:02, David Marchand:
> > This flag got replaced by RTE_PCI_ID_ANY in v21.05.
>
> Thank you for cleaning the place :-)
>
> >  /** Any PCI device identifier (vendor, device, ...) */
> >  #define RTE_PCI_ANY_ID (0xffff)
> > -/** @deprecated Replaced with RTE_PCI_ANY_ID */
> > -#define PCI_ANY_ID RTE_DEPRECATED(PCI_ANY_ID) RTE_PCI_ANY_ID
> >  #define RTE_CLASS_ANY_ID (0xffffff)
>
> Series Acked-by: Thomas Monjalon <thomas@monjalon.net>

Series applied, thanks.


-- 
David Marchand

