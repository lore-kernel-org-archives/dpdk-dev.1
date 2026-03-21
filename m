Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B51094486
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 16:14:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 334C6402EF;
	Sat, 21 Mar 2026 17:14:25 +0100 (CET)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 8E91A402C9
 for <dev@dpdk.org>; Sat, 21 Mar 2026 17:14:23 +0100 (CET)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c0fa90d47bso1131491eec.0
 for <dev@dpdk.org>; Sat, 21 Mar 2026 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774109662;
 x=1774714462; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4uZbSsfpDNDzqYVcnUSUUMcRz0ud1A/GoG7OdNReaM=;
 b=Iok2auzLGRdhCfNPv9jjfXxAFCmq1lJMc3/agdSaITZ6QKrnaMtznoWrUGy/uC+hSM
 kRXeOzUY9fzuBt3uPHaEIxsf85XBkOYSMGS/1P9LUPwb9VIXRjcfcTdheGigAdukXI0T
 qzfDQfQr3zoP+K0wiCuogk7gbIz5SokEVdioq8717msduqnik6y6nRrPl84QBKlmj1pK
 0zrDUVkAoiBYz8Qj5Kuy/PsoTcSzauaOm8+A7OnXZNgMAHu1ciuXm7C6wcLizvbbWKje
 L2fm1+L28pK7NvXONmpWpdE+NxL3Bak8bkuFX4SLn2s7exJu6zJZMQFfuj9zF8BDOOTK
 HxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774109662; x=1774714462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F4uZbSsfpDNDzqYVcnUSUUMcRz0ud1A/GoG7OdNReaM=;
 b=nl4nBf7gGUqddjz3V6lVxuPdraoRWlKarcr4xloE9Wkis6mP5BHQkQMnGOl6hxOLVM
 uClVSKNoyWUakT36lccWprUnV9YUl/YAOR365T6shyN3SaH3PAjdhZmR48I6gCQI+5hQ
 tOaWonq5OUAS2cAdtev1nrHDQGEzMnPf5YnOtl0EZz0vWICyd0TuiDnF8kNvhtq+Qdbn
 wLuvezNpIBDUBTfarRoa+wEbAYYpEZ9rkdgmyOusseAvFWoetnV5gjwLZEgpfqZ9LJoW
 7hzL7aDlI8MgKcLTwHrswr0CRepXZKB9s0lt3yg5Yur5EJdfBG+IsrSoKIhdJwjAbpbC
 VCfg==
X-Gm-Message-State: AOJu0Yz4rj81B8kmV8rb2cqnNvmd5fR75BPb+bYvjQ3FHL0UyY+0oPTD
 gQvXhunEJgGGMvWlxevapX+p5H1DzrM3FtYmcblSenLFrd+mab3AZmOJb2ziUrAUND8=
X-Gm-Gg: ATEYQzwAtlX+3unTSN3Pvgzzt15B06rRM+9YUKg3vw3Jloel82WDZopQoiDJ9cU0GfR
 IbSqtWAwFLknVxpTVBiAjY9S/yLZyV/QIzgPtXKKG877TZx58+5eOz1nxJ/svKW5+Nswdvq/Gyz
 8rkF1JaEPJX/2EOaLeypLrlhiCVS3PBKuGMUvewvfku6KQ4DWI40zf++QQ0kGqtDBbrVaNK7nQc
 JTYCmBzElAES5GpQrVLHDzQ0oz6wTMQ0LnuJx5/R1oAct0Yi+z1q16Yn5p09b4XUwSM6lX7k7Or
 7R1hEHSp68Vjfbt7tfJiuJSpCrFxZfRJ0tHP+uU3p287r3RM6zpMv1M3xNCbr23SuoAa25NZaGz
 +B/DipxJ6eFDUI0xjPOVJnbpQfBBxsQsE7vSt64xY9HoN8s+kvUSfqq5sV4J2zHUpaki4sc/MlU
 0M7uU5JFd/IXusJ2iPvOKYyaX2GPGA3iOytTT5wXZKFVYPqg==
X-Received: by 2002:a05:7022:6709:b0:11a:fb0a:ceca with SMTP id
 a92af1059eb24-12a6856a807mr3931101c88.16.1774109662388; 
 Sat, 21 Mar 2026 09:14:22 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14cadbsm8939969eec.3.2026.03.21.09.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 09:14:21 -0700 (PDT)
Date: Sat, 21 Mar 2026 09:14:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <probb@iol.unh.edu>, <david.marchand@redhat.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH 3/7] test/pdump: skip test on FreeBSD
Message-ID: <20260321091418.74534cc6@phoenix.local>
In-Reply-To: <abwva7QN2pBRD4Jz@bricha3-mobl1.ger.corp.intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-4-bruce.richardson@intel.com>
 <abwva7QN2pBRD4Jz@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, 19 Mar 2026 17:16:27 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Thu, Mar 19, 2026 at 05:11:37PM +0000, Bruce Richardson wrote:
> > FreeBSD doesn't support multiprocess so skip the pdump unit test which
> > requires multi-process support.
> > 
> > Bugzilla ID: 761 (partial fix)
> > Fixes: 086eb64db39e ("test/pdump: add unit test for pdump library")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  app/test/test_pdump.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
> > index 824caef2d4..9d1175b4b0 100644
> > --- a/app/test/test_pdump.c
> > +++ b/app/test/test_pdump.c
> > @@ -5,6 +5,7 @@
> >  #include <unistd.h>
> >  #include <stdint.h>
> >  #include <limits.h>
> > +#include <sys/utsname.h>
> >  
> >  #include <ethdev_driver.h>
> >  #include <rte_pdump.h>
> > @@ -197,7 +198,12 @@ run_pdump_server_tests(void)
> >  int
> >  test_pdump(void)
> >  {
> > +	struct utsname name;
> >  	int ret = 0;
> > +
> > +	if (uname(&name) < 0 || strcmp(name.sysname, "FreeBSD") == 0)
> > +		return TEST_SKIPPED;
> > +  
> 
> Self-NAK, I forgot to update this patch to just use
> "RTE_EXEC_ENV_IS_FREEBSD" instead of calling "uname". Will fix in V2.
> 
> >  	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> >  		printf("IN PRIMARY PROCESS\n");
> >  		ret = run_pdump_server_tests();
> > -- 
> > 2.51.0
> >   

Couldn't there be a common dependency in meson.build
would rather not build tests for platforms that are missing the
secondary_process support.
