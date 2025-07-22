Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F896C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 15:42:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B82BC402E1;
	Tue, 22 Jul 2025 17:42:32 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id CACA440269
 for <dev@dpdk.org>; Tue, 22 Jul 2025 17:42:30 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-704cb8b1314so33935986d6.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753198950;
 x=1753803750; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkjasW7kt7TvHWCljXwnYbll163oaa4RNUJklwUeq5k=;
 b=urZKqdls8MbcgddmBf+SNrktl6Ql84zrphWSwhHPv3E+aWsJJT1EYivPYrjW45USgl
 /ecboYAt/gwDKdcPcpw6qstsvNW/HzmcX9XJFURzfHLD0eWE82yPoRJRV0R/dJhTg0zZ
 KhxI7wbrX/SduPmAoqv2nlPx8yXufdFWXKH664bZM0kpyZemWMg81MXX4NfwojQJG11n
 NslbTaTR4bplE2ArywVzv6yR/I5KvUnb0utGt6uKcgbnlOCMr9IK8OdwXD4C+ry2ceBE
 hLTcW2f6Y01belp57AKzLYDElOzDSiXQKDBeVulVzBt4ptwSVaYNzw3STnustIsN65y2
 eUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198950; x=1753803750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkjasW7kt7TvHWCljXwnYbll163oaa4RNUJklwUeq5k=;
 b=VhIAxjT/n4zIgmUxvLEzSeV5K574yKJMy6h7swueclTChQ8a4GSnO01R403NsMV7ML
 emRczq/CBSukNmfVtxg7rL2d6cb9Kwb34ue3xUII/YURYfXQqEEMsMXLcsux+1Jb+8gm
 R8sOx/v7CY3IJnKDN2fehVwaN/9J7utQl4qc2lMxMDg9usLTD4sbyNLCxnPcNrhSu1BE
 1uqZvmtPS4dAhhY25ezq9Ri9OPM9VnWS22U3KzlkDrO8/EisOLLCo6Wf2u7HpzSaOTNA
 Ym21RS2u6KZd5hmgKnGeyXGWFFQZNK06E2NofuETc5dROMfm4Haz2PQ+5vUwYrAwfnFe
 SKHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQSqpyPQu3k/yh+Kqo/qv3FI5AgdREY22WNWheZ+LB5J8wwi2WEFv1+IgQwPdhWIKybmY=@dpdk.org
X-Gm-Message-State: AOJu0YyyfpEeHcYciIvDMDyUSRrzVz70z2NghPOLVHQQho3Pxtsae4Sx
 o1xTVxyaaixl6goan+74mCpBeuzDxjceZ3RdM+xXqVr5tHZbDO5cvH9FFRu3sXBVyzQ=
X-Gm-Gg: ASbGncu+Q9xn0bvubPFY88uVpCDAV+wZi7k6KPkVuwrrFrVNEiOZmR6uqZ+/M6vPPNQ
 GMzvmHaZnSA5xPnQC/OWV4l/H/HN7jt9JxkqN+hHu3dA0M0ObgBQw7ajJW4mz3h//rOu8/pFYus
 YN7VFqIhnt2v2AFD6aMMCxtLlRpyv9ffolDmV9ERclu08y1aoudiFOgx/Aa7JyGjxpWbc4DZCls
 VfDKDiavpZI+okrw0Ppioc5KCHDoaTpvzxfXdFrMNgZuNU8pypaJwYMvM4sFcJFhTcTJLLAHhex
 DxaSJoe45kYJActuRqEKnNybe/YPvhMyJo43bBc3VbVghJu7ebp8iVmNSDCyIvAL9IziCrolThA
 qGAkjvUfqvjVFiGS7IGEU5u69UgY2oZbdAh+pWX3QCLEFQSSxRHNcVVGABXHUYIH5r+qJxhkhXY
 w=
X-Google-Smtp-Source: AGHT+IEIM3YWgAKqDI9Aqv+IUmXbj7qor2AbpRZSgKLys97O0u4tZZWFwNaMZllew8jlWSApIR/cEw==
X-Received: by 2002:a05:6214:2e8a:b0:704:f94e:b5da with SMTP id
 6a1803df08f44-704f94eb9b7mr264942636d6.50.1753198950095; 
 Tue, 22 Jul 2025 08:42:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051ba8ea91sm53523306d6.80.2025.07.22.08.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:42:29 -0700 (PDT)
Date: Tue, 22 Jul 2025 08:42:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 dev@dpdk.org, dpdk stable <stable@dpdk.org>
Subject: Re: [PATCH] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Message-ID: <20250722084225.7a40e2bc@hermes.local>
In-Reply-To: <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250722063924.2f87f3f7@hermes.local>
 <CA++2-x7VPCtojdJ7+DXdK=ohAJtLu_3U8KPxHS9CNAqzMd1hoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 22 Jul 2025 19:30:41 +0500
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> Hi Stephen,
> Can we add only the check that fixes the segfault, or do you mean that it
> should be fixed at the PMD level?
> 
> Best regards,
> Khadem
> 
> On Tue, Jul 22, 2025, 18:39 Stephen Hemminger <stephen@networkplumber.org>
> wrote:
> 
> > On Tue, 22 Jul 2025 07:54:39 -0400
> > Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
> >  
> > > +     if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
> > > +             (dev == NULL || dev->data == NULL ||
> > > +             dev->data->dev_private == NULL ||  
> >
> > dev can't be NULL and checking it here will cause a Coverity warning.
> >
> > There are many other ethdev calls that will fail if primary dies.
> > stats, xstats, rx/tx burst, ...
> >
> > I don't think it is good idea to add checks here.
> >  

It needs to be fixed at the documentation level.
Make sure and document what applications need to do. Rather than adding
more checks in ethdev.
