Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75E4F54AC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 14:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 353FD402BE;
	Tue, 24 Mar 2026 15:37:01 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id A02AF4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 15:36:59 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12a695044a4so2453359c88.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774363019;
 x=1774967819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMobfBaUSq6XzjSOKBzoXSSzfl6wFcC8H5eiaRD6370=;
 b=dFPYbaYhQ+7vsq+PpNksOWGnNn6414RWr8Ti+EizQrVb8nx69Q0BeiISHCOjJEJcnn
 M/b3f0tx0h2L7POLjRFOkI46PZ4BLgUu76QPAhfZns4F+Yr8IU64wYLBK1MuKNHXFWXz
 HEmNpwUGS82DRnqa/lycRkagZmCUqPJvhAeVeVNY4rZbyuqa10GicUkinhWLk9+80Rkt
 KhY8qCJ2uyyIrOYUOTF0BbbVb8Io8oFPy8JJTTDHd4NBeQN2pC2wIfpKejoydtrnzoxA
 cRIIvCwVd97EuT0C4o7t09Q61wurtI+feVJFVQxFv0Xng/WP5mTd45ZwqZyD89/7XvQt
 IEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363019; x=1774967819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EMobfBaUSq6XzjSOKBzoXSSzfl6wFcC8H5eiaRD6370=;
 b=px1bCd7dkW5Cu/mUAw8eo2+4i6AqpRrbFmRMiPN6noSxzbJvj2plFqW6OzfPbcJpKT
 YWOXCqN4wjOAYh75BCHaaVkOPL8aX3ILvkAeRvdy20OiW38L9SjthVV5ijRZHbfax9dh
 gS7ek9Lv/veopKoAIxkBfiomzxVn/zCa+UxTtSj1xzWv99DCb+ccFqz+KS81MPR+TeKW
 RW1g9SflxDQY0RARsa1EedlcZqEreA/emx0nX6XYHhztRmlpnexc+5hOSvlTP7pUjI6H
 Y4Sq7Ronb1b5/CqlQaVq3EydREHO49Vkq+LOzhONNYhy9X8Mju0Xn4aVrvIX2b7TuiX+
 OKtA==
X-Gm-Message-State: AOJu0Yx9QTR2H4AoNTeVmI6CpYp88IwofUUpWyeEQQ6SK83byoeuUmD0
 Bu76PIIP7wADhGP6EN2Drb45zgMYA7O3nYWIpaqcmC3lxRCOdCCFLAnd7J/WNpFYSHE=
X-Gm-Gg: ATEYQzxr79NqHeIGf+EkLuFORLI7ckqCyQPxJdmfQf8p/o/MaQyANZoDhCdXxkwXQFk
 yA17hpYEP/0SY6NhDVXbMPCRhSmBEmgm+Uc9r5A3ez3XPTU0s7SWIDzAuoE7LmRIyB7bEQbkVTt
 66uBa8srY76IJ5nvvhHaqFR6pnj5lWRht5qU/avKWxPAJj+7NlH+ncJwuTls4WeUuQUkWbUGe5K
 7p7suJ2RjARr6S3/06jkOG2C5WWTjjnArwTwaga5jV7IVCc40qJwVbZLtEiGYk/+2bV1cHnrO2Z
 F4DNjazFz1mUqtfGM2jHEFqVNZU78ecne58sEXgO7tEfhUQr6gcqK8Q0OB3oTpmq5mrcCxFcXi1
 EkilJJLP9QsjwO29C8Wk7rUSRy00VbvUDwT9TwNUPevwF0l1DOmNk8CPw4LqbGBgeodnVJM2cqt
 vI2nPZH54hykt8mqz3Qq0F2tqPnyVm3pccqGaaXe2iBNa93g==
X-Received: by 2002:a05:7022:985:b0:11d:f440:b743 with SMTP id
 a92af1059eb24-12a7265643emr8462606c88.7.1774363018485; 
 Tue, 24 Mar 2026 07:36:58 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733b49afsm12010315c88.2.2026.03.24.07.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:36:58 -0700 (PDT)
Date: Tue, 24 Mar 2026 07:36:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Aman Singh
 <aman.deep.singh@intel.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH] app/testpmd: fix memory leak in port flow configure
Message-ID: <20260324073653.07fe3625@phoenix.local>
In-Reply-To: <20260324081045.6022-1-shperetz@nvidia.com>
References: <20260324081045.6022-1-shperetz@nvidia.com>
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

On Tue, 24 Mar 2026 10:10:44 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> When "flow configure" is issued multiple times on the same port,
> port_flow_configure() allocates a new job_list via calloc() without
> freeing the previous allocation, leaking it. The old pointer is
> simply overwritten.
> 
>   testpmd> flow configure 0 queues_number 10 queues_size 256 ...
>   testpmd> flow configure 0 queues_number 10 queues_size 256 ...  
> 
> The patch fixes this by freeing the existing job_list before allocating
> the replacement.
> 
> Fixes: df503d757b36 ("app/testpmd: fix flow queue job leaks")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  app/test-pmd/config.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
> index f9f3c542a6..f0a784bf2f 100644
> --- a/app/test-pmd/config.c
> +++ b/app/test-pmd/config.c
> @@ -1836,6 +1836,7 @@ port_flow_configure(portid_t port_id,
>  	port->queue_sz = queue_attr->size;
>  	for (std_queue = 0; std_queue < nb_queue; std_queue++)
>  		attr_list[std_queue] = queue_attr;
> +	free(port->job_list);
>  	port->job_list = calloc(nb_queue, sizeof(*port->job_list));

You could use realloc here, but it doesn't matter much
