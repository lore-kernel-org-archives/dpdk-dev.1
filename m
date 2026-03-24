Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698CF54AD9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8246E402BE;
	Tue, 24 Mar 2026 17:27:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B01634025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774369651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/GoSiRM/O4OrxdZ6VeAVmw+EcFg8ysFIrifq1bHB0m8=;
 b=KSAqnJH4sehpHpHbIK2pyIsQtZ5eFNvvEgakz+QDFdrqGQPjtUc8uEc0IOE2fqmJFpZw5u
 lDzyN/IOJL7XEPvKwXzrOuAU7K1uxH1odprp1/xlYn1JfDvZs9tKrdifWTlCtsgfIONXCK
 WHnGjqSQey1ZoWGqrV8iEKJuUTwXcs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-eqg4xYy7PyyzBaSpZAu69w-1; Tue, 24 Mar 2026 12:27:29 -0400
X-MC-Unique: eqg4xYy7PyyzBaSpZAu69w-1
X-Mimecast-MFC-AGG-ID: eqg4xYy7PyyzBaSpZAu69w_1774369648
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48534941525so52094905e9.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774369648; x=1774974448;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/GoSiRM/O4OrxdZ6VeAVmw+EcFg8ysFIrifq1bHB0m8=;
 b=r3JFc6p+3ziN2iLf/ael2wnoKZMJ8U6MJOH+v0NEPEzAr/qDauvmdRG3iShpH1AqaK
 04w2EAwQlM3WNWq8Rrvgz5tKfDB0vZfeKQXdWNcFsTi+uWfQISwADZ5k8w2Zs126j0cR
 5U/NDxz0LAoFT1ejK7jUY7LCw7jWI0Gz9b+HdP6vlEktlueJlR06LA8ohqeCB73tEl88
 vOOPU4xcoVpvyPoS9KCIQ+z9Xbg1kI9nOLbGbe1waANuih9ekJAf5CIoIa33Ky0fRSb6
 T9sCiF9hBTYCD73iuTQyjW+Qn0htjpzQETfcJKC4vqdedTfWtmZ1xcgPQp0NJJoF0703
 z96A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlVj7phGGijkgKrnl5gnkx5/RjnK6d6uIFTz+p9EL3H82Y4XO6teeJSBdtwAT77TvbjY8=@dpdk.org
X-Gm-Message-State: AOJu0Yxb4knH1j7bs/8w8jAG8ZUXAuOOQLBrnWd0dMRdu4ahfxF8M4tx
 iycWTZLCjlyLzsyubLOMfQHPsm3uqWU4ttYRURFJ9Zc+9ACTwFagGvnWqKbyKT4DKiTgszuUpKl
 MPlZfJZfy/HS4dYMTh8rsRiy7pfY1n/MHePVe1TQiGIZf
X-Gm-Gg: ATEYQzwY+T2w0npQ0/7wQDB5C0nqOfnVKqM+v6ICuRKbRAP0+lTZv4yNK0nC7WDta2a
 NUZ7SbTaCg/eqlaZ015yTav7Faxmj6H3NzhJ6tw2TEsTnBGcFhWmKzHXiEaW8CkfOlc1HXQa0wD
 4HOUeUb40j5nZx+FLTRfKE8Um+SKbAe8u8J7qdcFTta9JDnednkuY7tbhis47ZcDlB19hic0ke2
 4I5AWuj5AETGTzV2pO52uU3hsBCvUgEiV/+/BHyJF+BIhY7/2CWmHILznliqlibfYxWm6sSdHzh
 a0FuBxFxCJ4lc+pvHEiTJh9xbANI+isg2Nrm5nmZusLZSCFRE/HadfReng8Sn4QEhB3qEJpIx1T
 64Q1J9Nx3NlTp693s2NWnwgat
X-Received: by 2002:a05:600c:350f:b0:485:4278:24fb with SMTP id
 5b1f17b1804b1-487160afca2mr4841155e9.32.1774369648289; 
 Tue, 24 Mar 2026 09:27:28 -0700 (PDT)
X-Received: by 2002:a05:600c:350f:b0:485:4278:24fb with SMTP id
 5b1f17b1804b1-487160afca2mr4840775e9.32.1774369647716; 
 Tue, 24 Mar 2026 09:27:27 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b87f80976sm1182235f8f.4.2026.03.24.09.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 09:27:27 -0700 (PDT)
Message-ID: <feebfa40-e002-464b-ac82-6cfdf309368e@redhat.com>
Date: Tue, 24 Mar 2026 16:27:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] bus: remove per bus scan mode
From: Kevin Traynor <ktraynor@redhat.com>
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-8-david.marchand@redhat.com>
 <37eb6e05-b27e-4412-9e55-d7629d94ae3f@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <37eb6e05-b27e-4412-9e55-d7629d94ae3f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Jpp5y2D0nH5fKjt4RbK7O3Uy0CVIJPSNRRIT3UXNwU_1774369648
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

On 3/24/26 4:02 PM, Kevin Traynor wrote:
> On 3/23/26 10:53 AM, David Marchand wrote:
>> Following the refactoring of device selection, it becomes more apparent
>> that there is no need for a per bus scan mode.
>> -a / -b options are mutually exclusive.
>> --vdev option works in parallel of allow/block list scan mode.
>>
> 
> -a/-b are mutually exclusive but does it mean "-a 0000:01:00.0" stops
> default probe for all devices on other buses ? Is it a change in behavior ?
> 

Given that -a/-b are not mutually exclusive, i suppose we can say the
current behavior is designed to be global and there should not be
independence between buses, which is in keeping with what is done in
this patch.

> (I could probably test but I guess you thought about this case given the
> nature of patch.)
> 
>> Remove this (internal) notion.
>>
>> Signed-off-by: David Marchand <david.marchand@redhat.com>
>> ---
>>  lib/eal/common/eal_common_bus.c     | 20 ++++++++++++++++++-
>>  lib/eal/common/eal_common_devargs.c |  8 +++-----
>>  lib/eal/common/eal_private.h        | 31 +++++++++++++++++++++++++++++
>>  lib/eal/include/bus_driver.h        | 18 -----------------
>>  4 files changed, 53 insertions(+), 24 deletions(-)
>>
>> diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
>> index 2ca0af7914..27a31bbefa 100644
>> --- a/lib/eal/common/eal_common_bus.c
>> +++ b/lib/eal/common/eal_common_bus.c
>> @@ -18,6 +18,8 @@
>>  static struct rte_bus_list rte_bus_list =
>>  	TAILQ_HEAD_INITIALIZER(rte_bus_list);
>>  
>> +static enum rte_bus_scan_mode bus_scan_mode;
>> +
>>  RTE_EXPORT_SYMBOL(rte_bus_name)
>>  const char *
>>  rte_bus_name(const struct rte_bus *bus)
>> @@ -252,7 +254,7 @@ rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name)
>>  {
>>  	struct rte_devargs *devargs = rte_bus_find_devargs(bus, dev_name);
>>  
>> -	switch (bus->conf.scan_mode) {
>> +	switch (rte_bus_scan_mode_get()) {
>>  	case RTE_BUS_SCAN_ALLOWLIST:
>>  		if (devargs && devargs->policy == RTE_DEV_ALLOWED)
>>  			return false;
>> @@ -266,6 +268,22 @@ rte_bus_is_ignored_device(const struct rte_bus *bus, const char *dev_name)
>>  	return true;
>>  }
>>  
>> +enum rte_bus_scan_mode
>> +rte_bus_scan_mode_get(void)
>> +{
>> +	return bus_scan_mode;
>> +}
>> +
>> +int
>> +rte_bus_scan_mode_set(enum rte_bus_scan_mode scan_mode)
>> +{
>> +	if (bus_scan_mode != RTE_BUS_SCAN_UNDEFINED)
>> +		return -EINVAL;
>> +
>> +	bus_scan_mode = scan_mode;
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Get iommu class of devices on the bus.
>>   */
>> diff --git a/lib/eal/common/eal_common_devargs.c b/lib/eal/common/eal_common_devargs.c
>> index c523429d67..8083bdebc2 100644
>> --- a/lib/eal/common/eal_common_devargs.c
>> +++ b/lib/eal/common/eal_common_devargs.c
>> @@ -330,7 +330,6 @@ int
>>  rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
>>  {
>>  	struct rte_devargs *devargs = NULL;
>> -	struct rte_bus *bus = NULL;
>>  	const char *dev = devargs_str;
>>  
>>  	/* use calloc instead of rte_zmalloc as it's called early at init */
>> @@ -341,14 +340,13 @@ rte_devargs_add(enum rte_devtype devtype, const char *devargs_str)
>>  	if (rte_devargs_parse(devargs, dev))
>>  		goto fail;
>>  	devargs->type = devtype;
>> -	bus = devargs->bus;
>>  	if (devargs->type == RTE_DEVTYPE_BLOCKED)
>>  		devargs->policy = RTE_DEV_BLOCKED;
>> -	if (bus->conf.scan_mode == RTE_BUS_SCAN_UNDEFINED) {
>> +	if (rte_bus_scan_mode_get() == RTE_BUS_SCAN_UNDEFINED) {
>>  		if (devargs->policy == RTE_DEV_ALLOWED)
>> -			bus->conf.scan_mode = RTE_BUS_SCAN_ALLOWLIST;
>> +			rte_bus_scan_mode_set(RTE_BUS_SCAN_ALLOWLIST);
>>  		else if (devargs->policy == RTE_DEV_BLOCKED)
>> -			bus->conf.scan_mode = RTE_BUS_SCAN_BLOCKLIST;
>> +			rte_bus_scan_mode_set(RTE_BUS_SCAN_BLOCKLIST);
>>  	}
>>  	TAILQ_INSERT_TAIL(&devargs_list, devargs, next);
>>  	return 0;
>> diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
>> index e032dd10c9..12db04dce2 100644
>> --- a/lib/eal/common/eal_private.h
>> +++ b/lib/eal/common/eal_private.h
>> @@ -469,6 +469,37 @@ int rte_eal_memory_detach(void);
>>   */
>>  struct rte_bus *rte_bus_find_by_device_name(const char *str);
>>  
>> +/**
>> + * Bus scan policies
>> + */
>> +enum rte_bus_scan_mode {
>> +	RTE_BUS_SCAN_UNDEFINED,
>> +	RTE_BUS_SCAN_ALLOWLIST,
>> +	RTE_BUS_SCAN_BLOCKLIST,
>> +};
>> +
>> +/**
>> + * Retrieve the current bus scanning mode.
>> + *
>> + * @return
>> + *   The current bus scanning mode.
>> + */
>> +enum rte_bus_scan_mode rte_bus_scan_mode_get(void);
>> +
>> +/**
>> + * Change the bus scanning mode.
>> + * Changing the mode can only be done once from undefined to allow list or to block list.
>> + * No change from allow to block (or vice versa) is allowed.
>> + *
>> + * @param scan_mode
>> + *   The scanning mode to apply.
>> + *
>> + * @return
>> + *   0 on successful change.
>> + *   < 0 on failure.
>> + */
>> +int rte_bus_scan_mode_set(enum rte_bus_scan_mode scan_mode);
>> +
>>  /**
>>   * For each device on the buses, call the driver-specific function for
>>   * device cleanup.
>> diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
>> index e67e052404..9045d64816 100644
>> --- a/lib/eal/include/bus_driver.h
>> +++ b/lib/eal/include/bus_driver.h
>> @@ -232,23 +232,6 @@ typedef int (*rte_bus_sigbus_handler_t)(const void *failure_addr);
>>   */
>>  typedef int (*rte_bus_cleanup_t)(void);
>>  
>> -/**
>> - * Bus scan policies
>> - */
>> -enum rte_bus_scan_mode {
>> -	RTE_BUS_SCAN_UNDEFINED,
>> -	RTE_BUS_SCAN_ALLOWLIST,
>> -	RTE_BUS_SCAN_BLOCKLIST,
>> -};
>> -
>> -/**
>> - * A structure used to configure bus operations.
>> - */
>> -struct rte_bus_conf {
>> -	enum rte_bus_scan_mode scan_mode; /**< Scan policy. */
>> -};
>> -
>> -
>>  /**
>>   * Get common iommu class of the all the devices on the bus. The bus may
>>   * check that those devices are attached to iommu driver.
>> @@ -277,7 +260,6 @@ struct rte_bus {
>>  	rte_bus_devargs_parse_t devargs_parse; /**< Parse bus devargs */
>>  	rte_dev_dma_map_t dma_map;   /**< DMA map for device in the bus */
>>  	rte_dev_dma_unmap_t dma_unmap; /**< DMA unmap for device in the bus */
>> -	struct rte_bus_conf conf;    /**< Bus configuration */
>>  	rte_bus_get_iommu_class_t get_iommu_class; /**< Get iommu class */
>>  	rte_dev_iterate_t dev_iterate; /**< Device iterator. */
>>  	rte_bus_hot_unplug_handler_t hot_unplug_handler;
> 

