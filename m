Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D8F30955
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 12:19:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53DAA4065D;
	Thu,  5 Mar 2026 13:19:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C87EB4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 13:19:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772713147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+1TFo+EFhym8dZTP4RlYTX9LDSnxCBcYxfgf1kWv1b0=;
 b=W5GUHrf3nzdelTBNGg7v06aRGwSCcjPhDJJ5p6gTjgmG97rmceARxCn7VmcHfifMJK2agf
 Vx0X/1UEOBOf7ZxooKv/IDdQEmxhe5q7gId76y85mLTKM48GijgpPYktKZ825rCrj0A0zR
 bA+/3F/s1HS3WOPoGuipSca+wp4no8A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-12Gytr4BMZOtBuUueqN2yg-1; Thu, 05 Mar 2026 07:19:05 -0500
X-MC-Unique: 12Gytr4BMZOtBuUueqN2yg-1
X-Mimecast-MFC-AGG-ID: 12Gytr4BMZOtBuUueqN2yg_1772713144
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a12f7bb92fso509246e87.2
 for <dev@dpdk.org>; Thu, 05 Mar 2026 04:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772713144; x=1773317944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1TFo+EFhym8dZTP4RlYTX9LDSnxCBcYxfgf1kWv1b0=;
 b=ZW/RmivGhdbUNwdSkFeZc++lBz+YjIqAYdEiEg2S4igWxSmbHepPLTJSMBIDbIJAvd
 aZD+pQhEmtLiagg/MjxSHPCpansDOnh2KuwuQ6bYWzC1v5kyxCtw7kXlAd6/B19wM/aE
 eaTX+ikNC5clfz/n2zSehz2jBE6owUx/holfXnr4KhiwX1zGU/2LFnim8GsCPPAaAudD
 JGsEYsDDbivOKjGpwSqRs0ALzv1C+eNNMXowak4C4YDNQohshGNQExzdN7Dn26Kv2X/R
 zo+HpBVAY0ny+d18lPEueREOsLDvzt25dmzEQXRD9bwRtM+OrSveE1KsE7KMKtMpydgX
 iFMg==
X-Gm-Message-State: AOJu0YxutLh8G5SENrD5MaV75Gv20n8dQMVfVY7i43rnBFaxHETAO1y0
 hHVxC26KPV6nYSkizxwguAK7rxnF1pikkaSisPNncd9OuPmHyCXr0uK5ipukItbhtjZgYGJqsPx
 17tghEJe6TREYcAmwA074vaJgQ4NuCR5zRue2uDhVVe+rsWPH5TUXOmieb2+U94SN8vl3VyRLHx
 NVXvrVd6LrV6Rq5zMmxFo=
X-Gm-Gg: ATEYQzzCnWolIsdjwl12azgMY1EJjE49JjxDx+QM+Fu+S3+QOWlRTymsON6fyCtvIm3
 QMQVk5ig0By3SjyUX8Cr5RaPtP+6L2JARkDzKFfWnf1sy0qRYN348M73xq+TJjiQhsyeIFaANR/
 d+LVyETkq/RcM5Qo+gzCuD1lC4YsvV+LJUS9y2yCES+BmS4cMNbno5P/oHt+4S+6TBFXoEqiKrQ
 YvyrNJEzjbZPZ30D1ee7I4nz18QxNNoAP2fvUFqoroGhQoC/nMD3l0zozMW1JjvLciqAg==
X-Received: by 2002:a05:6512:1322:b0:5a1:22c7:b667 with SMTP id
 2adb3069b0e04-5a12c2be3b6mr868617e87.45.1772713144367; 
 Thu, 05 Mar 2026 04:19:04 -0800 (PST)
X-Received: by 2002:a05:6512:1322:b0:5a1:22c7:b667 with SMTP id
 2adb3069b0e04-5a12c2be3b6mr868607e87.45.1772713143899; Thu, 05 Mar 2026
 04:19:03 -0800 (PST)
MIME-Version: 1.0
References: <20260226142206.860737-1-radu.nicolau@intel.com>
 <20260227140128.1083814-1-radu.nicolau@intel.com>
In-Reply-To: <20260227140128.1083814-1-radu.nicolau@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 13:18:52 +0100
X-Gm-Features: AaiRm509_0Ui6axUzU_MNPi0mg_KLvkf_PXb2AGQYc1imejf7_Zmf-ERh3o_JaA
Message-ID: <CAJFAV8zdmXLEMv2CURdXscot778hwjk=V-=MfSwxynDsPqusBw@mail.gmail.com>
Subject: Re: [PATCH v3] hash: fix pointer alignment
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, marat.khalili@huawei.com, stable@dpdk.org, 
 stephen@networkplumber.org, Yipeng Wang <yipeng1.wang@intel.com>, 
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Yerden Zhumabekov <e_zhumabekov@sts.kz>, 
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fFisIUHfYh-oKYBn71ilnRn7V2sN1KXSuF9wmsvV3TY_1772713144
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

On Fri, 27 Feb 2026 at 15:01, Radu Nicolau <radu.nicolau@intel.com> wrote:
>
> rte_hash_crc assumes input pointer address is 8 byte aligned
> which may not be always the case.
> This fix aligns the input pointer before proceeding to process it
> in 8 byte chunks.
>
> Bugzilla ID: 1892
> Fixes: 504a29af13a7 ("hash: fix strict-aliasing for CRC")

This code has assumed integer alignment since day 0.
This was a 32-bit requirement until commit 614289298daf, and it has
been 64-bit since then.

So I updated the Fixes: reference to:
Fixes: af75078fece3 ("first public release")

> Cc: stable@dpdk.org
>
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>

I am surprised we did not catch the bug with the ipsec_sad_autotest
(as reported in bugzilla) in the GHA UBSan job...
But I can reproduce it locally.

We could probably extend the hash unit test coverage.

In any case, the fix lgtm.
Applied, thanks.


-- 
David Marchand

