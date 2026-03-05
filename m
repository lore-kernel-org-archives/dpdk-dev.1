Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFF4F3D32E
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:35:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 605C94029D;
	Thu,  5 Mar 2026 17:35:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3069240287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gqHwWXNhv9z1w20EihdkD9Q+3tlY/D4RECCtMGiFgSU=;
 b=DwOqXvJ0Vpac9HpvllPfmj+F2c3IYL9VJ272eArSs6DMdpNV/9OevW7WEpynvyOL4JGKiZ
 n8U5sn6z9EmJK3T8k1DFYVfG41qWJwpBlWTt6lx+Gj5VB1jbDg9iGdHpZGfo8IekWwjYGO
 6tR72uh4+CvRfxndkm+3rZ5enuVeK68=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-T9228S4EPaOeARw_652q3w-1; Thu, 05 Mar 2026 11:35:24 -0500
X-MC-Unique: T9228S4EPaOeARw_652q3w-1
X-Mimecast-MFC-AGG-ID: T9228S4EPaOeARw_652q3w_1772728523
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a1324aeb32so917095e87.3
 for <dev@dpdk.org>; Thu, 05 Mar 2026 08:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772728523; x=1773333323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqHwWXNhv9z1w20EihdkD9Q+3tlY/D4RECCtMGiFgSU=;
 b=S245VAJckke9/XiJDgZLalNWawWKUgOwFJLkgp55MM1TRFULgJZNlfnKSrc06RP311
 qAL0Aexos6QAA+J54/f44P7A4F/vQZJnpruSEPIFoT0K4ZdxKyNK/mS2tvO4tA6n6lKq
 1F/+VQzn6opHQIXkJt2vJNYTYCA2v1TRHfik4vpdJfUZ3r5GIhjhzaHg2zqJRuXneoql
 6CY1H2lfXpyEvtJ1g491T7q60TqiNkQcYEtLuG/BlZkqsWlSydWtz51XEVN2pxhBv8Tw
 p5jgX+9F3ups9+H88SvPeXimYQkkXWCcb0W5HTmtBORL0ZqDUCUQsEQx8Otr48PRk3Y6
 1qcg==
X-Gm-Message-State: AOJu0YxomhxHkcK0yyER+ZMO4na4+ZJobqHWIqiOAWsksJ3gX2bxMzUJ
 fIRzKFv+fapst/m8SmDRTUX2K/HC7ddDmu6zPvbD+iTOO60sl0iO9Wwp+1Jwozgvho0J0UnfveZ
 NB6HBRsfea0AG3Y1jJAH8U/dEBUWrMLif8XSfS2NJ7O6VjAMNG5i0eTYR0GHeTbWC1LKVAlYdEI
 Q/t61zDl4akOte+AKaK2Q=
X-Gm-Gg: ATEYQzwO0ruA7R8lFoFaJC2wJufCeOogdxOAZ6j4uEElAIsQdVbASsgHF9KlQ+C3xPd
 ogZljZwvjaAGaLipXzdNNK5b9vUrG4ooPtTxeur4lTZl9jNcEf3kGwT+2SndWwyYz7/AQxeKJUe
 XkWxjxKrZ4quFzNgvChe4RtS/bwOwW9q5pqWVCI38+TyWdKaCxEzVf/xEMR3Qfly0VRBO6c3jky
 NztyTCgHl4yeMZiFlueUFTh1H3rANmbFXCWLKeYunXxzewLpZIcUit7mjYZyNI3OCc6Eg==
X-Received: by 2002:a05:6512:3c94:b0:5a0:ff97:4374 with SMTP id
 2adb3069b0e04-5a12c27b159mr1001345e87.7.1772728522682; 
 Thu, 05 Mar 2026 08:35:22 -0800 (PST)
X-Received: by 2002:a05:6512:3c94:b0:5a0:ff97:4374 with SMTP id
 2adb3069b0e04-5a12c27b159mr1001337e87.7.1772728522175; Thu, 05 Mar 2026
 08:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20260220174952.2647744-1-bruce.richardson@intel.com>
 <20260225162044.3670045-1-bruce.richardson@intel.com>
 <20260225162044.3670045-2-bruce.richardson@intel.com>
In-Reply-To: <20260225162044.3670045-2-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 17:35:10 +0100
X-Gm-Features: AaiRm52zyHWKLYyYrtr2uWeBein5xXIL8p0LTA64bgD5o6AKET03DI5_pmscUos
Message-ID: <CAJFAV8xnjLN625Q7tmfv_WiZpiJj7N8zVsgXTCAUeBv2L=bP8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] app/test: simplify getting the current file prefix
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HIuBWFoupHZY-t9cyZgvH2wdKWEJG9faBiVhQkN_eIw_1772728523
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

On Wed, 25 Feb 2026 at 17:21, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Rather than opening particular fd's in the /proc directory, just use the
> rte_eal_get_runtime_dir() function to derive the file-prefix in use.
> Since the runtime dir call cannot return NULL, we can simplify/remove
> the error handling where it's used.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> Tested-by: Marat Khalili <marat.khalili@huawei.com>

Series applied, thanks Bruce.


-- 
David Marchand

