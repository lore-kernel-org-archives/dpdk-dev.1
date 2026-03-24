Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B690DF54AD0
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FEA9402BE;
	Tue, 24 Mar 2026 17:02:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 055B84025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:02:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774368138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bw54hiqjzPXqqKC0RDMQk+RqkWWmLCMLFvObDAHHQuo=;
 b=JDgcTOUduL1CLtbVmAH8UMIMKlFOHqUDgk2W2VzMesga2UAUhFYjp0ilb4g7UcedOaqlHk
 OCq3kMdzEFRKTCsYLWbkEjaeK9ph9RKTQk9uyjN18iFYe5cAmRjMOJjunrmoNZIl53/nP5
 4LH5fnC7Tk0cYW2oUs75aZkCqlMkf1I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-C2GZIRIGPqeC4vbXdP6AIw-1; Tue, 24 Mar 2026 12:02:16 -0400
X-MC-Unique: C2GZIRIGPqeC4vbXdP6AIw-1
X-Mimecast-MFC-AGG-ID: C2GZIRIGPqeC4vbXdP6AIw_1774368135
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-485345e2fdfso22909465e9.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368134; x=1774972934;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bw54hiqjzPXqqKC0RDMQk+RqkWWmLCMLFvObDAHHQuo=;
 b=kN6+TQYCwb7u4K9WThHs8xlnLkb9HNNYYdRSH09WSfdMDORquH53frY6czP5vMSIlw
 UkHpECIhZDGqGWOLJey1ValPVXqFy3zQ/yZBlgXsw/fbwC99S6NUdvKE2aXkC1rEllOb
 kVhPiLsafoMnrwm6VrYKl+cvQdpjtqLvbQjp3kDenbRUUtKMrbld2aAQ6fguU1GcK0zt
 Lqj9kCqGdZWJ7gVxB5Gk1eOutmsuYT+T5uajPc/xCy4UXjZiKsdvwek8DTBfrBBMy3qt
 nyA0yqAD305XIoIphAIEsVlcJKU8cOozz+T0dK7/F1h64RcLCDd9JwkIj3Hmlgu3nO+u
 cx6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJJGK7OfB19oSTJd97k9dV82kyhWq3Ukgficp7akRFfuTh/0OOCagq4MGiAWvXv2jznQ0=@dpdk.org
X-Gm-Message-State: AOJu0YxR2FKj8UPNOIAS+70Y1YvOedWO8VjGQkebypTJo3rlLdgTcf1E
 Td9+m/gxcBNufRZ16dgF/LU1Zw2xK87AM+kV60GL7dVmxsI4HIT5tf1yFGdzn8aVKtdJa+WgsXL
 jLHfAMoa445mk2BBt12qx2a9AIHUQZh2lGb7eKQa5FOaQ/PXKwINH
X-Gm-Gg: ATEYQzyvFvU9lhDps8ncGWam7uxj8xn/4IIgB3SamFFxK+ReCa6wqchhQuNqY97HJeG
 Mc5OJ22hSnLgMtCKrj+sDyb2xERW2SGVp/Ww2BYvOZsj94doscab9facCQ765CPtoH+orfb9JrK
 EygbCZJlzsGLmSjSSMRdn1GWy/4ciyU6Bn4/QGzOzzlXB0OBaftljECsFwmg0jSmJ4o4YYod0DB
 Pdxwnruy3ijFTwUaaqz/mXCuJeHggQEINg+qdvKsIKKLZHkafUO3Q+83kEvQc3AKfYB9CGiZnrk
 Lg56sZ+Ci18cOe4fc7GFGRNWMb3BWsxHHN1zhgHPCPQXaSDpVAQuSsUpSn4yTLfEX16+aViBYm5
 wI7k8h5mzOm4SNZJS2feub7Xm
X-Received: by 2002:a05:600c:64c6:b0:485:34a2:919e with SMTP id
 5b1f17b1804b1-487160a681bmr3900135e9.33.1774368134385; 
 Tue, 24 Mar 2026 09:02:14 -0700 (PDT)
X-Received: by 2002:a05:600c:64c6:b0:485:34a2:919e with SMTP id
 5b1f17b1804b1-487160a681bmr3899475e9.33.1774368133670; 
 Tue, 24 Mar 2026 09:02:13 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b647177e8sm38338893f8f.34.2026.03.24.09.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 09:02:12 -0700 (PDT)
Message-ID: <37eb6e05-b27e-4412-9e55-d7629d94ae3f@redhat.com>
Date: Tue, 24 Mar 2026 16:02:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] bus: remove per bus scan mode
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-8-david.marchand@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260323105306.1531689-8-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dzPP10jCf_0rYSMvOlk62seQlTPRHJIwx6qkssHRK_U_1774368135
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 3/23/26 10:53 AM, David Marchand wrote:
> Following the refactoring of device selection, it becomes more apparent
> that there is no need for a per bus scan mode.
> -a / -b options are mutually exclusive.
> --vdev option works in parallel of allow/block list scan mode.
>

-a/-b are mutually exclusive but does it mean "-a 0000:01:00.0" stops
default probe for all devices on other buses ? Is it a change in behavior ?

(I could probably test but I guess you thought about this case given the
nature of patch.)

> Remove this (internal) notion.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/eal/common/eal_common_bus.c     | 20 ++++++++++++++++++-
>  lib/eal/common/eal_common_devargs.c |  8 +++-----
>  lib/eal/common/eal_private.h        | 31 +++++++++++++++++++++++++++++
>  lib/eal/include/bus_driver.h        | 18 -----------------
>  4 files changed, 53 insertions(+), 24 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
> index 2ca0af7914..27a31bbefa 100644
> --- a/lib/eal/common/eal_common_bus.c
> +++ b/lib/eal/common/eal_common_bus.c
> @@ -18,6 +18,8 @@
>  static struct rte_bus_list rte_bus_list =
>  	TAILQ_HEAD_INITIALIZER(rte_bus_list);
>  
> +static enum rte_bus_scan_mode bus_scan_mode;
> +
>  RTE_EXPORT_SYMBOL(rte_bus_name)
>  const char *
>  rte_bus_name(const struct rte_bus *bus)
> @@ -252,7 +254,7 @@ rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name)
>  {
>  	struct rte_devargs *devargs = rte_bus_find_devargs(bus, dev_name);
>  
> -	switch (bus->conf.scan_mode) {
> +	switch (rte_bus_scan_mode_get()) {
>  	case RTE_BUS_SCAN_ALLOWLIST:
>  		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
>  			return false;
> @@ -266,6 +268,22 @@ rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name)
>  	return true;
>  }
>  
> +enum rte_bus_scan_mode
> +rte_bus_scan_mode_get(void)
> +{
> +	return bus_scan_mode;
> +}
> +
> +int
> +rte_bus_scan_mode_set(enum rte_bus_scan_mode scan_mode)
> +{
> +	if (bus_scan_mode != RTE_BUS_SCAN_UNDEFINED)
> +		return -EINVAL;
> +
> +	bus_scan_mode = scan_mode;
> +	return 0;
> +}
> +
>  /*
>   * Get iommu class of devices on the bus.
>   */
> diff --git a/lib/eal/common/eal_common_devargs.c b/lib/eal/common/eal_common_devargs.c
> index c523429d67..8083bdebc2 100644
> --- a/lib/eal/common/eal_common_devargs.c
> +++ b/lib/eal/common/eal_common_devargs.c
> @@ -330,7 +330,6 @@ int
>  rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
>  {
>  	struct rte_devargs *devargs = NULL;
> -	struct rte_bus *bus = NULL;
>  	const char *dev = devargs_str;
>  
>  	/* use calloc instead of rte_zmalloc as it's called early at init */
> @@ -341,14 +340,13 @@ rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
>  	if (rte_devargs_parse(devargs, dev))
>  		goto fail;
>  	devargs->type = devtype;
> -	bus = devargs->bus;
>  	if (devargs->type == RTE_DEVTYPE_BLOCKED)
>  		devargs->policy = RTE_DEV_BLOCKED;
> -	if (bus->conf.scan_mode == RTE_BUS_SCAN_UNDEFINED) {
> +	if (rte_bus_scan_mode_get() == RTE_BUS_SCAN_UNDEFINED) {
>  		if (devargs->policy == RTE_DEV_ALLOWED)
> -			bus->conf.scan_mode = RTE_BUS_SCAN_ALLOWLIST;
> +			rte_bus_scan_mode_set(RTE_BUS_SCAN_ALLOWLIST);
>  		else if (devargs->policy == RTE_DEV_BLOCKED)
> -			bus->conf.scan_mode = RTE_BUS_SCAN_BLOCKLIST;
> +			rte_bus_scan_mode_set(RTE_BUS_SCAN_BLOCKLIST);
>  	}
>  	TAILQ_INSERT_TAIL(&devargs_list, devargs, next);
>  	return 0;
> diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
> index e032dd10c9..12db04dce2 100644
> --- a/lib/eal/common/eal_private.h
> +++ b/lib/eal/common/eal_private.h
> @@ -469,6 +469,37 @@ int rte_eal_memory_detach(void);
>   */
>  struct rte_bus *rte_bus_find_by_device_name(const char *str);
>  
> +/**
> + * Bus scan policies
> + */
> +enum rte_bus_scan_mode {
> +	RTE_BUS_SCAN_UNDEFINED,
> +	RTE_BUS_SCAN_ALLOWLIST,
> +	RTE_BUS_SCAN_BLOCKLIST,
> +};
> +
> +/**
> + * Retrieve the current bus scanning mode.
> + *
> + * @return
> + *   The current bus scanning mode.
> + */
> +enum rte_bus_scan_mode rte_bus_scan_mode_get(void);
> +
> +/**
> + * Change the bus scanning mode.
> + * Changing the mode can only be done once from undefined to allow list or to block list.
> + * No change from allow to block (or vice versa) is allowed.
> + *
> + * @param scan_mode
> + *   The scanning mode to apply.
> + *
> + * @return
> + *   0 on successful change.
> + *   < 0 on failure.
> + */
> +int rte_bus_scan_mode_set(enum rte_bus_scan_mode scan_mode);
> +
>  /**
>   * For each device on the buses, call the driver-specific function for
>   * device cleanup.
> diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
> index e67e052404..9045d64816 100644
> --- a/lib/eal/include/bus_driver.h
> +++ b/lib/eal/include/bus_driver.h
> @@ -232,23 +232,6 @@ typedef int (*rte_bus_sigbus_handler_t)(const void *failure_addr);
>   */
>  typedef int (*rte_bus_cleanup_t)(void);
>  
> -/**
> - * Bus scan policies
> - */
> -enum rte_bus_scan_mode {
> -	RTE_BUS_SCAN_UNDEFINED,
> -	RTE_BUS_SCAN_ALLOWLIST,
> -	RTE_BUS_SCAN_BLOCKLIST,
> -};
> -
> -/**
> - * A structure used to configure bus operations.
> - */
> -struct rte_bus_conf {
> -	enum rte_bus_scan_mode scan_mode; /**< Scan policy. */
> -};
> -
> -
>  /**
>   * Get common iommu class of the all the devices on the bus. The bus may
>   * check that those devices are attached to iommu driver.
> @@ -277,7 +260,6 @@ struct rte_bus {
>  	rte_bus_devargs_parse_t devargs_parse; /**< Parse bus devargs */
>  	rte_dev_dma_map_t dma_map;   /**< DMA map for device in the bus */
>  	rte_dev_dma_unmap_t dma_unmap; /**< DMA unmap for device in the bus */
> -	struct rte_bus_conf conf;    /**< Bus configuration */
>  	rte_bus_get_iommu_class_t get_iommu_class; /**< Get iommu class */
>  	rte_dev_iterate_t dev_iterate; /**< Device iterator. */
>  	rte_bus_hot_unplug_handler_t hot_unplug_handler;

