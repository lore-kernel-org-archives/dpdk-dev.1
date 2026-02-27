Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF73FD5307
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 07:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81C4B4027F;
	Fri, 27 Feb 2026 08:54:47 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 33CE04003C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 08:54:46 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so10372455e9.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 23:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772178886; x=1772783686; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CHpiplWOWmJ29xrniAL95ptb8jigCsnAXK2OOiptqsA=;
 b=YjoVjujLzRorVeZPIj4I9o9/z3G8U1AbO7NOBM9OkbWxuvPbkM4zAEWykommXdc4Cv
 y/MMVr8H4DSpSqdcbm0mMagubE4eeYu2U0aTH5eCCXFtv0v/m6YIPTVGIC81XvtYw0zI
 rRJhx9aA9rRQlkUas+moR6DBTq6bSuPipo//3Qocb/iRwBz9omirK7DPCFeUD1mKjN7h
 0aZiJOS7XBOYqE4jR58HuIVcH+JTdcVIziuCDzqI62aDttOfqnX3hafJYjC6eWdkuFqv
 fzDCDebtZTUQQCJGu0aO4t/NYXX+zYzLvnFPufjHvTBdIFRpQSQN/DaAGL0XbZK5V2jT
 cCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772178886; x=1772783686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CHpiplWOWmJ29xrniAL95ptb8jigCsnAXK2OOiptqsA=;
 b=GuJzoZWrvbmXv+m9un+7w6FInk3FEgZL1MNhnYVUgLsUQiTyV66YeijL2iHi5UR2u+
 S/aHDCNxc3tcToCMIG5RfRdggt+RbmkXD6AYEcwrbEhlKxHUaIcDS2umMzBoQmoGik7z
 /uxbp312jsnxM/CHEJ2EHzkzA+Qfv8Y0cqcGYIG9VmVFPiW77xlykfBtC0Xe1Pd8orkb
 w+HDDADX4iWAY3VqdXYSmGcG8s9i8Gc0RNYmzl9jxgTGyYQUHzCBBlqTNx4Ief5x6nB9
 owK3YnjylCXjc9GTEgT1PTMXbYP6s9TnnlY3WoeD8t9hBLSCjIK7qHFfkc/Y+tbN3wFZ
 h38A==
X-Gm-Message-State: AOJu0YwARGdOEsFHiKf1sAzFxjFl/OBYK0OLviNjomUZvdWJoSnFLxdR
 UvfjvP58ZtfCMfRa7NVbwHPzrQx6oYRBg8KHqXQEru9nXFj2sTD8vwpM
X-Gm-Gg: ATEYQzwpXE5XvhLtndS5i6nzQfHXkD5SGbwS3mdgeX/H4on/sBp2+B1pFGorrzgXDvq
 /boYeBoWoj5Dyaf0DyZeZNHB24jYOwgXLvVhUZgbVbdpdXGb5GMEzi6DafjL0q9jPdUWXvV+XRE
 Utg4P/5GAaACNRfnuxms4f50ImB46evty35bYekZgUZPjWuDGnvDEjkLjAg8nmH2xoQp5ENCJYR
 8Bbunl+HhhMa7a24+VfkXNQYYOB4n11ZfkgGY7BEtPWFxYeV236vKCKM7QZZQ5m+isPbTEaRfkv
 8cAKtuTveuT7GdKdCErC7SQRMGA2LM7zy3QfLzp9ONTtPTr+3vCVDeeSfeREZS33uTAPtNgIOHl
 5tAQEd3aMtE/c+lbdiYtQ6vP6pvqBqZoVPzg0HtKVDzlCeV7uPK5+ILnTpjDfi4+5EAj1KbYse0
 D9/kaLtQTjgk79wmL25E2hcPAi5oaxz4OfvHLJxyc=
X-Received: by 2002:a05:600c:458b:b0:483:43da:6c87 with SMTP id
 5b1f17b1804b1-483c9bdb71amr26155675e9.33.1772178885490; 
 Thu, 26 Feb 2026 23:54:45 -0800 (PST)
Received: from [192.168.1.150] ([185.157.14.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b346ccsm83925655e9.2.2026.02.26.23.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 23:54:44 -0800 (PST)
Message-ID: <da7ab2ee-2a37-4536-92f2-5981840b7b81@gmail.com>
Date: Fri, 27 Feb 2026 08:54:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cryptodev: fix memory corruption in secondary process
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 Piotr Krzewinski <piotr.krzewinski@ericsson.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org
References: <20260226135727.4171394-1-piotr.krzewinski@ericsson.com>
 <431e978a-1763-43b0-a2c9-d285edbbfec8@intel.com>
Content-Language: en-US
From: Piotr Krzewinski <krzewinskip@gmail.com>
In-Reply-To: <431e978a-1763-43b0-a2c9-d285edbbfec8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 2/26/2026 3:53 PM, Burakov, Anatoly wrote:
> On 2/26/2026 2:57 PM, Piotr Krzewinski wrote:
>> When secondary process runs with --no-pci, it skips hardware device
>> probing, causing different cryptodev dev_id assignments than in primary.
>> Since memzone lookup is based on dev_id, it leads to secondary
>> attaching to wrong memzone and corrupting primary's device
>> data structures.
> 
> This probably would be the case even if you didn't use `--no-pci` but instead were using block-lists/allow-lists to only probe different devices in secondary processes? Maybe the problem is more general than that.
> 
Most probably yes, I focused on --no-pci as it is where it hit me.
Current memzone naming scheme forces all applications to have same dev_id assignment so any changes in the list in secondary would be a problem.
Another solution could be to store the cryptodev data for all devices in single memzone, similar to ethdev "rte_eth_dev_data". But it seemed more complex and had other drawbacks.
>>
>> Fix by making secondary process search for devices by name in existing
>> memzones instead of using local dev_id allocation.
>>
>> Signed-off-by: Piotr Krzewinski <piotr.krzewinski@ericsson.com>
>> ---
>>   lib/cryptodev/rte_cryptodev.c | 37 +++++++++++++++++++++++++++++++----
>>   1 file changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
>> index 7bddb154c2..50071935c2 100644
>> --- a/lib/cryptodev/rte_cryptodev.c
>> +++ b/lib/cryptodev/rte_cryptodev.c
>> @@ -1177,6 +1177,27 @@ rte_cryptodev_find_free_device_index(void)
>>       return RTE_CRYPTO_MAX_DEVS;
>>   }
>>   +static uint8_t
>> +rte_cryptodev_find_device_by_name(const char *name)
>> +{
>> +    char mz_name[RTE_MEMZONE_NAMESIZE];
>> +    const struct rte_memzone *mz;
>> +    struct rte_cryptodev_data *data;
>> +    uint8_t dev_id;
>> +
>> +    for (dev_id = 0; dev_id < RTE_CRYPTO_MAX_DEVS; dev_id++) {
>> +        snprintf(mz_name, sizeof(mz_name), "rte_cryptodev_data_%u", dev_id);
>> +        mz = rte_memzone_lookup(mz_name);
>> +        if (mz == NULL)
>> +            continue;
>> +
>> +        data = mz->addr;
>> +        if (strncmp(data->name, name, RTE_CRYPTODEV_NAME_MAX_LEN) == 0)
>> +            return dev_id;
>> +    }
>> +    return RTE_CRYPTO_MAX_DEVS;
>> +}
> 
> Nitpicking, but why not return `int` and -1? Returning RTE_CRYPTO_MAX_DEVS seems like an odd choice here. You can always cast the valid value to uint8_t at the caller.
Aligned with rte_cryptodev_get_dev_id and rte_cryptodev_find_device_by_name.
Both are returning RTE_CRYPTO_MAX_DEVS when the device or free index is not found (though the first one also has -1 as an error condition in some cases).
> 
> That said,
> 
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Thanks for quick review!
Best Regards,
Piotr
>> +
>>   RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_allocate)
>>   struct rte_cryptodev *
>>   rte_cryptodev_pmd_allocate(const char *name, int socket_id)
>> @@ -1190,10 +1211,18 @@ rte_cryptodev_pmd_allocate(const char *name, int socket_id)
>>           return NULL;
>>       }
>>   -    dev_id = rte_cryptodev_find_free_device_index();
>> -    if (dev_id == RTE_CRYPTO_MAX_DEVS) {
>> -        CDEV_LOG_ERR("Reached maximum number of crypto devices");
>> -        return NULL;
>> +    if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
>> +        dev_id = rte_cryptodev_find_device_by_name(name);
>> +        if (dev_id == RTE_CRYPTO_MAX_DEVS) {
>> +            CDEV_LOG_ERR("Device %s does not exist in primary process", name);
>> +            return NULL;
>> +        }
>> +    } else {
>> +        dev_id = rte_cryptodev_find_free_device_index();
>> +        if (dev_id == RTE_CRYPTO_MAX_DEVS) {
>> +            CDEV_LOG_ERR("Reached maximum number of crypto devices");
>> +            return NULL;
>> +        }
>>       }
>>         cryptodev = rte_cryptodev_pmd_get_dev(dev_id);
> 
> 

