Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D01BCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 12:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03F7540673;
	Tue, 30 Sep 2025 14:21:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9852F400EF
 for <dev@dpdk.org>; Tue, 30 Sep 2025 14:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759234909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGPWasn2zzruxEsV86Se5dKyl8fzh8WzjLKVDVtuA3I=;
 b=M4LnBc3jEY/+GKZARuvRDWiiobwrKgY+PUSbHqnqPmIhj74tildXHEqIpp0mC+mOejRoO6
 IqsEJH5nGT5ahWVEbylsZ12vEasrvxHXNzDa/S279HrIE0RobjeE8T1hzo+gwdjxSie2Nz
 abLvRfZYeZaB4DrUFYp0aRV2tbvc1CA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-_1hIOpqAPR2H9mH4FU-DlA-1; Tue, 30 Sep 2025 08:21:47 -0400
X-MC-Unique: _1hIOpqAPR2H9mH4FU-DlA-1
X-Mimecast-MFC-AGG-ID: _1hIOpqAPR2H9mH4FU-DlA_1759234906
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-333f8f1d00aso27530461fa.1
 for <dev@dpdk.org>; Tue, 30 Sep 2025 05:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759234906; x=1759839706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sGPWasn2zzruxEsV86Se5dKyl8fzh8WzjLKVDVtuA3I=;
 b=G7HD2lPP/l6WjAWy6+q3BJFoeNNUFViycrApmsJ8iUlekCLk+GcCcMPpCul8RTcfIY
 FS6Y9dXwrkAXnZI0mDiMGRaM658vTddBHAr7u/YhLeLcvPriW4RliWSsg8jKgueL5S5U
 QZ+AWNc06HK1M7FzBQqWlO5rHW0aLLTpyk6pLfdMkxo8Ps7FcTHcYY6+seLtdQr1Yhrv
 xbe0kmMsVoS3CYnEzFPO8cAyXP0gZaZVAaOiFkmsIbbwNNo3pmtJVUEi3Bb83IIrxOa9
 znJyCGfJnsD7R9NflsIeHviFk9KcPzLRYKrcFflqOvqIb1bvByxedHXLyS/Bnftc74u6
 45Bg==
X-Gm-Message-State: AOJu0Yw0mxuBoNM9vDcjkVqCMCW/wuxNCHWSMPMHtskpEuUm8jHf7IfD
 ixpOKPoZLEVhbZzQ5UzSKGktLbNP/x7DidQgyDS3yGeZa/KTCq/URKNpaj3/wqgJyKuy277KEi6
 CVKAATkzSuNTYsSDqzYcPNSYHr3JHpVROP932shWqjtiupvCLYnqYGEWGYp06WEkEXeWI1UO//H
 aDF7Q1UkC6OU5xhgGv+Ok=
X-Gm-Gg: ASbGncvEYk2d3ZBuyifrM7jjsYb4xxxiTFCmnbkM/bE/Np6xvyTyM6SPiEJnsyYS4Lf
 ogGjTa9ytYR0G8Jo+826oRGCtxSnUhO6FNTWHiANFvHQOHGXEuJ2chA65IgduygSPiMW+kNPlgr
 YBNmV1bM0fCs46LE2IUm75Ii/MhfWC
X-Received: by 2002:a05:6512:3d8c:b0:57b:234f:5299 with SMTP id
 2adb3069b0e04-582d36d427emr5575629e87.47.1759234905908; 
 Tue, 30 Sep 2025 05:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0GBfGriOcRX8zhlXIJxFJY1QTMulQxq7kQ9Rguf0iNLPJPXdINNUay1MElwP/Mpuc0J2BquCDVUnrwJExLVA=
X-Received: by 2002:a05:6512:3d8c:b0:57b:234f:5299 with SMTP id
 2adb3069b0e04-582d36d427emr5575619e87.47.1759234905443; Tue, 30 Sep 2025
 05:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-7-bruce.richardson@intel.com>
In-Reply-To: <20250723162013.2392-7-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 30 Sep 2025 14:21:33 +0200
X-Gm-Features: AS18NWBvmu8ZPT1qHhUev5alBGKlk45Gby9kQsFEOnf3yYfQfX0NoZ8Itnoo5_s
Message-ID: <CAJFAV8yroWbRDO2CYBwvKCRkYotBEvA18aQ0HGa7HMJx5-nSig@mail.gmail.com>
Subject: Re: [PATCH v7 06/13] eal: define the EAL parameters in argparse format
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FpBeSXs-ASWGlPdXI5sM4PEtSL-wkNk_ZdQzdbRDzlU_1759234906
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

On Wed, 23 Jul 2025 at 18:21, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
> index 226acea467..ebb9f7063d 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -28,11 +28,13 @@
>  #include <rte_version.h>
>  #include <rte_devargs.h>
>  #include <rte_memcpy.h>
> +#include <sys/queue.h>

Nit: system headers are usually going in the first group of includes.
This can be fixed when applying.


[snip]

> +struct rte_argparse eal_argparse  = {
> +       .prog_name = "",
> +       .usage = "<DPDK EAL options> -- <App options>",
> +       .epilog = "For more information on EAL options, see the DPDK documentation at: \n"
> +                       "\thttps://doc.dpdk.org/guides/" RTE_EXEC_ENV_NAME "_gsg/",


It seems this comment got lost.

Options don't change that often, but I would prefer we point at the
right release doc, rather than origin/main.
What do you think of:

@@ -164,11 +164,17 @@ eal_usage(const struct rte_argparse *obj)
 },
 #define STR_ALIAS STR_ARG

+#if RTE_VER_RELEASE == 99
+#define DOC_SUFFIX "-" RTE_STR(RTE_VER_MAJOR)
+#else
+#define DOC_SUFFIX
+#endif
+
 struct rte_argparse eal_argparse  = {
        .prog_name = "",
        .usage = "<DPDK EAL options> -- <App options>",
        .epilog = "For more information on EAL options, see the DPDK
documentation at: \n"
-                       "\thttps://doc.dpdk.org/guides/"
RTE_EXEC_ENV_NAME "_gsg/",
+                       "\thttps://doc.dpdk.org/guides" DOC_SUFFIX "/"
RTE_EXEC_ENV_NAME "_gsg/",


        .exit_on_error = true,
        .callback = arg_list_callback,
        .print_help = eal_usage,


-- 
David Marchand

