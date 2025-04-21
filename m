Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A5C369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 15:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DA35402A9;
	Mon, 21 Apr 2025 17:12:17 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id F255E40299
 for <dev@dpdk.org>; Mon, 21 Apr 2025 17:12:15 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so5286061b3a.2
 for <dev@dpdk.org>; Mon, 21 Apr 2025 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745248335;
 x=1745853135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hI2Qf9O4znwrhEDNkAopW8+c2hziHoi1LNWoK3vNpD0=;
 b=lb0A1b3++DwKYQqNE07hTYpDwSa/ypdyKZhFH9n7LU3EfvnPiRCkBy5hQVV5Epc/hr
 So641asxkjLPADn2MRF1xH+7GtSifr3clUjnERDo0RMgAYAZAQvy3oE/xGX9A54/lanD
 CvrZD9GQddHDv5FAjU9YTsYj6Cfad++5+Ey18abiA6+OLM8AZB4x/RsS5OzjwN4TSapj
 KnmPpirPn2f6KF+95KVuDC1dyckdiUy/yQc6n4JVE5t9WT5nGoXEnniRQP8rOI68jH/R
 shSFQtP94HwGDopWO+uZ1CdhvSpDFTIbtDSoEJY5dw4CQftLJ6pUQXHjh7kVZF7h4dd6
 NQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745248335; x=1745853135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hI2Qf9O4znwrhEDNkAopW8+c2hziHoi1LNWoK3vNpD0=;
 b=gy+DT4r4nambjPx/2JPe9foe+Pqwi2Yt6U7k9vRngh0Rm+fSXVm7cWBMIXFCES1uWj
 L+j7+rk1XvfRSd4awYge1W3Rv/yR4yxlctPZ3b/EKswI7x8zdZ7f4UP+YCZi2bLu0R71
 puZSSilJb9ws76xSaA3GmWIWTIbir3B23zyTo8+JVPwPcQQinFi2DvyEiWB+cBKcp5qR
 HlFS2B7EXYUHlzPFQLWR+i5XO6yBFIUQkSJ5AAa0JVQgzWwRoU0bwOjaKRLI9c4fupop
 8XNSMw3f9PuABS9IkxXCP+Elmeh5pUvosnpNKlhikdqqU5WSU+G7mNADk/gJJLE8AUn9
 FcAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0IQ3U/HUCCrvnhvqzOSe1C4huaEumwSqxDZYR/NdUaGNTT7NrEw0oajwZ69Ut5S3fkLM=@dpdk.org
X-Gm-Message-State: AOJu0Yyhn+RvoMSbQr0EomYGjpC2+GQX4hmqKj+xyO/spXz7MuN/DUTT
 2gW+Go9eqIYBX4IUZjEZd82kvksaK3ZIK6UpK596Kj2SwyylZ2l7ElQ9CAbIShE=
X-Gm-Gg: ASbGnctbzS8UzkSKfr4dlTVBSKVhoaV/pZfDUFIzlo4KTnFm7lwOtKaxntf0mFikRv5
 sBite5NOYWNNbfa/0L/DWn2lSwQbJzDQn69LBcLbPMD90oDFFwt1fmoIPw4QqA5TVaqD9UF7KL/
 ltuwVzuF2ITdESGRY9tPjQnaDCq3JDrDNY9HN2/SN//Am1X2PmludV+uObnSi93HJImbXBF/YNJ
 2vBevmAjXutCvYj+LRnak1q9hYniXqIxulo31LgLSd0PDWWdrlM9wqlaZc0bghtrHRgIRUleW3n
 OdLlxiLp/88rXu02xjHbeWL4zoeHI9UrBzsa0yAxIrgF94AFGBOXAHUYCqN8QsDsqirKryQXjUV
 TTKb3GgoJClNvtpJ9
X-Google-Smtp-Source: AGHT+IHLdrIH5bRS4aKInXQVxBS7bFRVltxUTx3Kdc6PCZL/4b2z00N6nU6aqo1D6qij8+0fC0ovfQ==
X-Received: by 2002:a05:6a00:114d:b0:737:6fdf:bb69 with SMTP id
 d2e1a72fcca58-73dc14ccdc3mr13764962b3a.13.1745248335061; 
 Mon, 21 Apr 2025 08:12:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8beae7sm6716730b3a.32.2025.04.21.08.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 08:12:14 -0700 (PDT)
Date: Mon, 21 Apr 2025 07:53:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 1/4] app/testpmd: remove restrict of number of TCs in
 DCB command
Message-ID: <20250421075259.12683c28@hermes.local>
In-Reply-To: <20250421072229.33200-2-fengchengwen@huawei.com>
References: <20250225091929.25072-1-fengchengwen@huawei.com>
 <20250421072229.33200-1-fengchengwen@huawei.com>
 <20250421072229.33200-2-fengchengwen@huawei.com>
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

On Mon, 21 Apr 2025 15:22:26 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Currently, the "port config 0 dcb ..." command only supports 4 or 8
> TCs. Other number of TCs may be used in actual applications.
> 
> This commit removes this restriction.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  app/test-pmd/cmdline.c                      | 4 ++--
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index b4089d281b..e34e47aaae 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -3472,9 +3472,9 @@ cmd_config_dcb_parsed(void *parsed_result,
>  		return;
>  	}
>  
> -	if ((res->num_tcs != RTE_ETH_4_TCS) && (res->num_tcs != RTE_ETH_8_TCS)) {
> +	if ((res->num_tcs <= 1 || res->num_tcs > RTE_ETH_8_TCS)) {
>  		fprintf(stderr,

No longer need nested paren's here.

i.e
	if (res->num_tcs <= 1 || res->num_tcs > RTE_ETH_8_TCS) {
