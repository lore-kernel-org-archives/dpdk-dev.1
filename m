Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029F6C531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F273406A2;
	Thu, 23 Jul 2026 15:54:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 61E9840A7F
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GN2DmnUTnMf+PdWtXtfhwCsZC4Q6EYRWvL+8T1R/nn4=;
 b=B/KYEOj4sPjg33m3/4x/LznZQfdIX8B32/BfGUsy9BOMvVihqG8BOm3BGXV7cozw22Ds8j
 vL864S8117SJg3IBfGjWSyN0b1/8RYOU1jyy4dONsvkonuEBKsE1yKGYvIda/aBUsrjqqy
 ldV8XQBaZ2cFtSREzD5EfBZ6y83BMNA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-6RbMf5ByNkCLNm7nuI8H9w-1; Thu, 23 Jul 2026 09:54:34 -0400
X-MC-Unique: 6RbMf5ByNkCLNm7nuI8H9w-1
X-Mimecast-MFC-AGG-ID: 6RbMf5ByNkCLNm7nuI8H9w_1784814873
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb9e6a8feso632600e87.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 06:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784814873; x=1785419673;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GN2DmnUTnMf+PdWtXtfhwCsZC4Q6EYRWvL+8T1R/nn4=;
 b=nt4bdpdLaYpaQhzOJEI19cXtXAW42bonT2kyzV6AdhpDtstCF9vte35pVhskgbzeVa
 sgJNgMCgyTUNrf7f1E68TLS70uDuqsIg7w47DqzSt3FBlWZaDL/mw+O8m+zjOr48R67q
 k45ka/z+k0kmv1BUot9DG4vSoEBDgDJNO7GqxSI2bSBm4b7xdWTXQmeERasjSb1k0TLN
 hClPGPETr2w055iyJl98B0e3GQ3dWlIVjQ6pdg39h/crDQZCHqVyZYpx7cG0r9A5Med5
 ZVqZ7cOpbzsOB/E3RGyvSa4AjXO3rdqkqd+vASnq+H+SV3FQNSWrOL/qVdSnyL7JsaBd
 eDYQ==
X-Gm-Message-State: AOJu0YxidOAzZpKcwKmZf1iF31WC2h0UNCuHDGfdum5p3K87AsoZgy03
 ANBH0+ir6f2pXXLK6xPDckuUKM+CrWscCjg9VQzaqtRo4Yf6Sve/sMf/9BW9fLGx1JV4BnOhlDv
 0l6cZ+f/wGfEKx3MlXfuOzCP4ypO24XoBhljIa15yUrdjS5ws5VhA6P4hKzYOlwHKItNad78gCW
 dOXd9tbtIyJcKaZu8aZmc=
X-Gm-Gg: AR+sD10oEamqenWbPLer+ZTDe+sIJzUwR9BKBji/824guonvp3FQMs3cDRACXdPA0BP
 eEoVDs3FuoqS5vW/8uWdSRmzenj3+Et8BqA6cPmp+pjeU3s/sQ7Vz8iGMf33/uabWV3bnx5clZL
 6h/3bvdjnWJcTEpYvik4cFV2bwwImrXtyB3PsSsDAgmdTYXTxAIo7FPKfDmAEi8zEyzOvlBNbC2
 lHcq0vvj9TqrTuKz8INyjoDgJKuVE7UtlslQKgRnBAHtxcO
X-Received: by 2002:ac2:5397:0:b0:5b1:1b50:7201 with SMTP id
 2adb3069b0e04-5b2b2f6ab01mr498732e87.36.1784814872978; 
 Thu, 23 Jul 2026 06:54:32 -0700 (PDT)
X-Received: by 2002:ac2:5397:0:b0:5b1:1b50:7201 with SMTP id
 2adb3069b0e04-5b2b2f6ab01mr498724e87.36.1784814872443; Thu, 23 Jul 2026
 06:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260723131908.3313223-1-david.marchand@redhat.com>
 <20260723131908.3313223-2-david.marchand@redhat.com>
 <amIYn1U_a0WmjMSs@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <amIYn1U_a0WmjMSs@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 15:54:21 +0200
X-Gm-Features: AUfX_mytxoRnfd8WwltS5XjfTVyga3PYF471tYh-f7sRJHwAbtboH5yGY3N2dqA
Message-ID: <CAJFAV8wqcNPWffRmFLcUNcSL4KD3T0v5v-kjLX886BqFiV4XWQ@mail.gmail.com>
Subject: Re: [RFC 1/4] bus/pci: fix check on interrupt FD for FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, hkalra@marvell.com, Chenbo Xia <chenbox@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Tetsuya Mukawa <mtetsuyah@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GowtKe33GQJAH5YNqoo8DmG1DR0etJIAi7lbXtEZME4_1784814873
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

On Thu, 23 Jul 2026 at 15:35, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jul 23, 2026 at 03:19:04PM +0200, David Marchand wrote:
> > A 0 file descriptor is valid. And a negative value is not.
> > Only close a positive file descriptor.
> >
> > Fixes: 5a60a7ffc801 ("pci: introduce functions to alloc and free uio resource")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  drivers/bus/pci/bsd/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
> > index c6df31d486..bbe08605af 100644
> > --- a/drivers/bus/pci/bsd/pci.c
> > +++ b/drivers/bus/pci/bsd/pci.c
> > @@ -93,7 +93,7 @@ pci_uio_free_resource(struct rte_pci_device *dev,
> >  {
> >       rte_free(uio_res);
> >
> > -     if (rte_intr_fd_get(dev->intr_handle)) {
> > +     if (rte_intr_fd_get(dev->intr_handle) >= 0) {
> >               close(rte_intr_fd_get(dev->intr_handle));
> >               rte_intr_fd_set(dev->intr_handle, -1);
> >               rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
>
> Unlikely that we actually have fd as 0 for this call, but change is
> technically correct.

Yes, this is why I did not Cc: stable.
Thanks.


-- 
David Marchand

