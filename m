Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64D4E85372
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:23:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1641640296;
	Fri,  3 Apr 2026 16:23:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id ED6014028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 16:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775226179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUY7LFHlM8WSv3V1y508CgVBQMkmXFODVleTw0Ardzs=;
 b=Q7I+/h0fH1nHFdVG0RRWCXDO5M8uCcnd2DeGoygRRRasffaByPHIyMnrDrMArLpRw2urPs
 L6bxnAxHzkXoh88HMMZs9CH4hE8Ok9IsYGoxf/wEu+zKlUyDR9ekuqCWXdWGdg73HyBYSX
 MExd8XWfzpTOlJ3A+ViBoZtMB+YjSOw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-OX-ZaRKpOfS6ijrdfckTpQ-1; Fri, 03 Apr 2026 10:22:56 -0400
X-MC-Unique: OX-ZaRKpOfS6ijrdfckTpQ-1
X-Mimecast-MFC-AGG-ID: OX-ZaRKpOfS6ijrdfckTpQ_1775226174
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38bf3edb13fso19744461fa.1
 for <dev@dpdk.org>; Fri, 03 Apr 2026 07:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775226174; x=1775830974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUY7LFHlM8WSv3V1y508CgVBQMkmXFODVleTw0Ardzs=;
 b=HyEdgY5+qJDsNfQCF5ZLufgr2r9AuIChtasuwDXNsbLX7jkdv0hcUeQC8aRhOa1UFl
 oJUuO408p2Liy/S6Csm3dEBWsvtLAYKdjUFXzN6da00eqvDuI0c07TNGecufYR5BnAnk
 riIALx8p1r7/bRfAIYWO4IzIIk97yzW99HxmCC6xwYD4DzpAIaJItPySKx6PrUmQWWKF
 7aSbRwn3bOvPqGyiNfwonZlF4stXpSXxBjJplQLQ7mU/sXs+10s9iPq7tUxdpQVMgNmZ
 ytMnQc0BicCC3blc6IkvZWQrk2wMg6CUu6FR06NIAmcNPchKE2X6z2bZ7mgufCM597u9
 Trzg==
X-Gm-Message-State: AOJu0Yz5sBRQbUo/lHdxpffGDgLV3y0WtATqY21TFtDLjbCvGvVgLA1z
 MgJBnjH/qujt2ByQP6s3/MQdAEP8E6SA7gIBOkFlL05MsU3IcZH7iyzyrdxEg+3xRCX+JFWXFoQ
 kYuErjYjCcgMk45nziwad3MoTPAEVxyU1oVB1W2eiVQJMCr5jdJ1TJz89I8yLIrbF1vocoEpHDU
 kbm6FmoQsV1JQjl0PwvZA=
X-Gm-Gg: AeBDietiWmDBunAy+BGDWdZx/q58V2EZsMNjvw5ge0iS8q2dMa+vVm4ZD6cStGW6yAk
 hWeRWZJiatqoIkgUpuhh0NB+CHlJYv8AevXOLqr6LgMCmJyCyhl9k+Fjlld/+4mvFlBQ8uPukzG
 Ir9vUg+A6bGtRCb7wWHOuK1bjdmhOPfYJDJUudU6DfpJF1HAci0qTrlkfb9W5JxYWgEfN1i/YhV
 75uI5yWs9i+kexKFahCFsY3pOmLoLxNJ4PXJIsQYWijhIgst+by8JMLz0anZUxBBjGvdQ==
X-Received: by 2002:a2e:bc84:0:b0:38b:f0f0:e39b with SMTP id
 38308e7fff4ca-38d654f9f5fmr10284811fa.10.1775226174326; 
 Fri, 03 Apr 2026 07:22:54 -0700 (PDT)
X-Received: by 2002:a2e:bc84:0:b0:38b:f0f0:e39b with SMTP id
 38308e7fff4ca-38d654f9f5fmr10284611fa.10.1775226173813; Fri, 03 Apr 2026
 07:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
 <20260326102424.2361945-6-david.marchand@redhat.com>
 <7d6d9c0e-722b-408d-878f-bac6c699ee46@huawei.com>
In-Reply-To: <7d6d9c0e-722b-408d-878f-bac6c699ee46@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 3 Apr 2026 16:22:41 +0200
X-Gm-Features: AQROBzChDkdyPz-lolBtcKAOq3L4Q1Mb1BuXsB9XfpwWHIyvH0C3rc2cdwkCpO8
Message-ID: <CAJFAV8yL8U6VZBgth=peuJuSY1uwtfrDcTQEuaYHa1nc+8upHA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] bus: factorize devargs lookup
To: fengchengwen <fengchengwen@huawei.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>, 
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Tomasz Duszynski <tduszynski@marvell.com>, Long Li <longli@microsoft.com>, 
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O7Vf1K-P-Iu7-S4T4tI7VArghXV41qPhQ9-WC67DiNE_1775226174
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

Hello,

On Sat, 28 Mar 2026 at 04:33, fengchengwen <fengchengwen@huawei.com> wrote:
> > diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
> > index 06a3643290..e6963dc18a 100644
> > --- a/drivers/bus/uacce/uacce.c
> > +++ b/drivers/bus/uacce/uacce.c
> > @@ -70,25 +70,10 @@ extern int uacce_bus_logtype;
> >  #define UACCE_BUS_DEBUG(fmt, ...) UACCE_BUS_LOG(DEBUG, fmt, ##__VA_ARGS__)
> >
> >
> > -static struct rte_devargs *
> > -uacce_devargs_lookup(const char *dev_name)
> > -{
> > -     char name[RTE_UACCE_DEV_PATH_SIZE] = {0};
> > -     struct rte_devargs *devargs;
> > -
> > -     snprintf(name, sizeof(name), "%s%s", UACCE_DEV_PREFIX, dev_name);
>
> For uacce, application should pass device with prefix uacce, e.g:
>   dpdk-testpmd -a uacce:hisi_zip-0,queues=2 --file-prefix=feng -- -i
>
> And the scan device is hisi_zip-0, so in match we should combined which is
> above snprintf does.

Erm, strange that I did not see this during my tests, but I think you are right.
It means the matching is broken in rte_bus_find_devargs().

I'll respin (I need to, anyway, as there was some fslmc change that
got merged late in v26.03).


>
> > -     RTE_EAL_DEVARGS_FOREACH(uacce_bus.bus.name, devargs) {
> > -             if (strcmp(devargs->name, name) == 0)
> > -                     return devargs;
> > -     }
> > -
> > -     return NULL;
> > -}
> > -


-- 
David Marchand

