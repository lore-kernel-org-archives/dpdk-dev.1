Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A80CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 08:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE96A40B98;
	Wed,  1 Oct 2025 10:46:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9D67840668
 for <dev@dpdk.org>; Wed,  1 Oct 2025 10:46:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759308397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NITh3NwUkImcmNFJENrIsehSWu/0PcdMeiagQMe7Fak=;
 b=NORVG3de+YPWd7pl2x68WUgmIdLvewBvrWdtea6FbeluAGJ2UxxQ559GW7+hBLmw98CpQl
 ioWvxI4i0CJ4GZUkkE/c9XaUOPQgR55IPvfMHCuAcmcQhl7RWO6R+3HxerbcMxI+wG13LR
 3oj2s7Tg/wuSiOpAVAwxuzSD6J/uang=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-CfAIdFqxN3CW_ce7cXyKSA-1; Wed, 01 Oct 2025 04:46:36 -0400
X-MC-Unique: CfAIdFqxN3CW_ce7cXyKSA-1
X-Mimecast-MFC-AGG-ID: CfAIdFqxN3CW_ce7cXyKSA_1759308395
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-333f8f1d00aso31052191fa.1
 for <dev@dpdk.org>; Wed, 01 Oct 2025 01:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759308394; x=1759913194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NITh3NwUkImcmNFJENrIsehSWu/0PcdMeiagQMe7Fak=;
 b=AYebi4Ans9pY3r/AfDu/gzCclYdJ3Bt1HSMW2o4waFr0Rl57hen+V8ixlsLDH2y0G4
 Al2/ijMtEMh76WezPzGgE2lXEpvk0FF/0LuGNlGBgJHdUjP/KgSwIj3jAqiEdTWFj7zF
 7JIB/y4rjLKAhcPlcLCsbrjqBhq2TuwycSKN1QF7hVrfdgfwulNRV3ziMm+ozQFLIV1U
 W5uXzZwbqY/6E9bU6fzu70pPMiRhnBy5JO+KG2BN2M3kPxVd9IpopnuhFS8zz533kmPW
 rMyiis2B3EGjTdp1HX6SVggy5y2HNVbQjaUgV7fmNClF4IQLYMnxBS0aBVMUppP+rA1o
 IS3Q==
X-Gm-Message-State: AOJu0Yz0Sn0FH7z/AgjdEQo+JPWSC6cFdZvHd/tEKcjLc9gPGIQRJ2gn
 OHJZxzUgvoSRSMIR953ImS3vuG+/Nl6jbUq/wFbE5ggAn1QnuJKAOO8nsW/5Cjkxrz5Csv0Sv4X
 c0+M1WEGtRFq5pt8esem8l89ZRpR7j0AroTYr4E9FS8hrttWkJREDtpTJfh3BMh+AaoxjOIKV2l
 QYYymXyDSQ6mE3LiS0HjA=
X-Gm-Gg: ASbGncutwrEYIJhaeGIchb1vOSdNlqdfoPF+fzqOuJ8nWe/CNICPZZQaaAX2xOY8JcR
 Jjhw8YTMBWBfyHmWiWjMF41YhKtY8cMaVnLyrd62BBSyZcpNfAKAQKeUIuKXG5h9x4oyJZx0guf
 o3EuM0+4Evspx7zUk7YfwcuBNdmP25
X-Received: by 2002:a2e:a99d:0:b0:36b:93b0:2a6c with SMTP id
 38308e7fff4ca-373a733b3f5mr7129221fa.16.1759308394508; 
 Wed, 01 Oct 2025 01:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH6OxEqAjuSAmnDDKQJWx0x9Ki39T/543ZiDDyV64k29WW33JiwB/H3imig5Ijw9sbj4YI4d558Ev7+cEaej4=
X-Received: by 2002:a2e:a99d:0:b0:36b:93b0:2a6c with SMTP id
 38308e7fff4ca-373a733b3f5mr7129151fa.16.1759308394042; Wed, 01 Oct 2025
 01:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-7-bruce.richardson@intel.com>
 <CAJFAV8yroWbRDO2CYBwvKCRkYotBEvA18aQ0HGa7HMJx5-nSig@mail.gmail.com>
 <aNvzcRQjOwRkydn0@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNvzcRQjOwRkydn0@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Oct 2025 10:46:22 +0200
X-Gm-Features: AS18NWDg3L_21NiBlZslBpPwdlAJ1jLaa59BO9AIEZ1RNwNo1QzJ7kob33Rc56U
Message-ID: <CAJFAV8w936Lb3rHWpfacVPBy=vchSyK6kWHRndC5Ytf6U-2gcA@mail.gmail.com>
Subject: Re: [PATCH v7 06/13] eal: define the EAL parameters in argparse format
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QRbDYPSS7G0FapMjlFTMsA_oxybVUGoacVmp6EuEuPg_1759308395
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

On Tue, 30 Sept 2025 at 17:13, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > It seems this comment got lost.
> >
> > Options don't change that often, but I would prefer we point at the
> > right release doc, rather than origin/main.
> > What do you think of:
> >
> > @@ -164,11 +164,17 @@ eal_usage(const struct rte_argparse *obj)
> >  },
> >  #define STR_ALIAS STR_ARG
> >
> > +#if RTE_VER_RELEASE == 99
> > +#define DOC_SUFFIX "-" RTE_STR(RTE_VER_MAJOR)
> > +#else
> > +#define DOC_SUFFIX
> > +#endif
> > +
> >  struct rte_argparse eal_argparse  = {
> >         .prog_name = "",
> >         .usage = "<DPDK EAL options> -- <App options>",
> >         .epilog = "For more information on EAL options, see the DPDK
> > documentation at: \n"
> > -                       "\thttps://doc.dpdk.org/guides/"
> > RTE_EXEC_ENV_NAME "_gsg/",
> > +                       "\thttps://doc.dpdk.org/guides" DOC_SUFFIX "/"
> > RTE_EXEC_ENV_NAME "_gsg/",
> >
> Yes, that can work, though RTE_VER_MAJOR doesn't exist that I can see. Will
> rework it a bit.

Ah sorry, it was in my previous comment:
https://inbox.dpdk.org/dev/CAJFAV8y5_O3T6hLbZov0LqhXyAu2s_n0P3C3Y+WSGVUjd8gbtg@mail.gmail.com/


-- 
David Marchand

