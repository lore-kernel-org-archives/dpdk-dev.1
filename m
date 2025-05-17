Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E27C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 May 2025 07:55:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60744402AF;
	Sat, 17 May 2025 09:55:34 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 5745E4025D
 for <dev@dpdk.org>; Sat, 17 May 2025 09:55:33 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso2389990b3a.1
 for <dev@dpdk.org>; Sat, 17 May 2025 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747468532; x=1748073332; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgENZbDytB3883FZXyXn7rFZ0eTrySZMJlh+tXHzI7Y=;
 b=ML1LbRor5nPghS5iCRpJvT1mosaN5ZqPBKWDWg7DZy8+Eq6oOnviKN9Ke/2Cp1eaho
 QB+EyUu9PyN4wsJJJhQL8jPVf4rgnTZkBBaL0A5x2MVaQfjQ9AS3mtRbIzTTfKdxSatY
 u3CI+OPEcmz5jLZ8Hi+6jKOfxlznVR0Qww4k+9nZRRLW9suQKveN+7DUk9PT2HkxDV4N
 we7otY9v0hKElpfRgCV6IT6ttk7UG+hAMYqAMzrcxPCFJn7Is4C5ShE0A7yx/XIGyL4Q
 OS46lSZUDfLI1GvjUV8a+r5h+4Kc3mibywIaZUseNUKrKXYh/2B19wveWFyS1XxDrGDW
 K59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747468532; x=1748073332;
 h=content-transfer-encoding:in-reply-to:from:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LgENZbDytB3883FZXyXn7rFZ0eTrySZMJlh+tXHzI7Y=;
 b=TiFBujdhfAGaDUEy4IOAhgy/p+QzQRF/8crBj50EGVEW8BkiD2frf9LFtAE3ztHEax
 6wYCpsgiIj1YkJWAPOuWkNqntsMUrDTsA1MRshv5Clm50Q2AISSHqFK4OhZAuBMhxCUc
 icBnM0ucInMF94M94WJnKFe6oeloCsL3ZPDvELrx3zJUBfnw4CBlZlcCOqa2Q3nFiP9U
 FF7EhNXph64X+Y5Ht6kVoFABV6VHWfYV0wP13SC7HVxBgxKQdZQkpASqGYW/jNcOMG+f
 x2dallikYTHGrxnmhfjFaESOFlB8JYuWNnpgabPKFUG8E3mUuoV9xpTDZgwJfZt+/OS2
 STUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+8edKmIHBt+VnXTvGez9c8Nl+B+jkBOfAUzY8lLc2ckb2/fsdm6t2ZggUtQTuIKAUI7I=@dpdk.org
X-Gm-Message-State: AOJu0Yyz70MhTeUB2U7raEDnlkxxl2j2ol6JzWTk8BUGFuJntjy79jP1
 LtT6jkLzIDceytl2FcRkGyIhf011JOle3GFO8nzS5vYN+JnW5HiZqJwb
X-Gm-Gg: ASbGncs2Zh9Y0L09Lw1AzaN/z97ZKdyZOhcHYd7IoKRwgwUGQdKBPzDzqlqPPDcM8tU
 1XWfaC127vmoLupdrW3XERrgX9KoPsRTDRXFz/fmqNYuZiSWGiBrab7xorQyIIrs8NjvbOc1wQc
 O+lFcbUqpkKQX3mSMxLdFaztaG6VyA8pilF6Oht7T6h5palglmA+BH8DAOM+/1c+vDTUrrUj6nd
 rbgTtPdKcK3PKWWeiUvrr65GthuaDKAdkLeQqlPiOc2Vim7v0sOyLmb+nswgrRrDYRBeHi1LQvQ
 BQaHKMSo2PUrYCo9DvP4sxinWYjqdXW3NnZezTrfV6Z6VWou1lJNU96nF6YG+Lj8l04ySaTDCQ=
 =
X-Google-Smtp-Source: AGHT+IHFC/cITOcw4mX1NK/IdAuhooKU3qSnf8p4NLmz1K/jTJfs3Hn+RL7+wmxcXuswbp/xIsYkMw==
X-Received: by 2002:a05:6a00:3d01:b0:740:58d3:71a8 with SMTP id
 d2e1a72fcca58-742a99fabb8mr7648312b3a.1.1747468531903; 
 Sat, 17 May 2025 00:55:31 -0700 (PDT)
Received: from [192.168.31.141] ([60.186.106.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970d5c4sm2749517b3a.65.2025.05.17.00.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 00:55:31 -0700 (PDT)
Message-ID: <cd5e0cf1-9428-41a7-89f7-8fecbb3cf2d3@gmail.com>
Date: Sat, 17 May 2025 15:55:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] eal/linux: skip vfio for non-privileged container
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 Yang Ming <ming.1.yang@nokia-sbell.com>, dev@dpdk.org
References: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
 <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
 <7e76aaa6-09c3-4721-afbb-aeb3bc9a42e2@intel.com>
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <7e76aaa6-09c3-4721-afbb-aeb3bc9a42e2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/16/2025 9:30 PM, Burakov, Anatoly wrote:

> On 3/27/2025 8:57 AM, Yang Ming wrote:
>> DPDK detect vfio container according the existence of vfio
>> module. But for container with non-privileged mode, there is
>> possibility that no VFIO_DIR(/dev/vfio) mapping from host to
>> container when host have both Intel NIC and Mellanox NIC but
>> this conntainer only allocate VFs from Mellanox NIC.
>> In this case, vfio kernel module has already been loaded from
>> the host.
>> This scenario will cause the error log occurs in DPDK primary
>> process as below:
>> 'EAL:   cannot open VFIO container, error 2 (No such file or
>> directory)'
>> 'EAL: VFIO support could not be initialized'
>> Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
>> to execute `vfio_container_fd = open(VFIO_CONTAINER_PATH,
>> O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
>> in this container.
>> This scenario will also lead to the delay of DPDK secondary
>> process because `default_vfio_cfg->vfio_enabled = 0` and
>> `default_vfio_cfg->vfio_container_fd = -1`, socket error will
>> be set in DPDK primary process when it sync this info to
>> the secondary process.
>> This patch use to skip this kind of useless detection for this
>> scenario.
>>
>> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
>
> With a few code grammar fixes below,
>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
>
>> ---
>>   lib/eal/linux/eal_vfio.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
>> index 7132e24cba..1679d29263 100644
>> --- a/lib/eal/linux/eal_vfio.c
>> +++ b/lib/eal/linux/eal_vfio.c
>> @@ -7,6 +7,7 @@
>>   #include <fcntl.h>
>>   #include <unistd.h>
>>   #include <sys/ioctl.h>
>> +#include <dirent.h>
>>     #include <rte_errno.h>
>>   #include <rte_log.h>
>> @@ -1083,6 +1084,7 @@ rte_vfio_enable(const char *modname)
>>       /* initialize group list */
>>       int i, j;
>>       int vfio_available;
>> +    DIR *dir;
>>       const struct internal_config *internal_conf =
>>           eal_get_internal_configuration();
>>   @@ -1119,6 +1121,15 @@ rte_vfio_enable(const char *modname)
>>           return 0;
>>       }
>>   +    /* return 0 if VFIO directory not exist for container with 
>> non-privileged mode */
>
> /* VFIO directory might not exist (e.g. unprivileged containers) */
>
>> +    dir = opendir(VFIO_DIR);
>> +    if (dir == NULL) {
>> +        EAL_LOG(DEBUG,
>
> "VFIO directory does not exist, skipping VFIO support..."
>
>> +            "VFIO directory not exist, skipping VFIO support...");
>> +        return 0;
>> +    }
>> +    closedir(dir);
>> +
>>       if (internal_conf->process_type == RTE_PROC_PRIMARY) {
>>           if (vfio_mp_sync_setup() == -1) {
>>               default_vfio_cfg->vfio_container_fd = -1;
>
>
Hi Anatoly,

Thank you for your review and the suggested improvements.

I will apply the code grammar fixes you mentioned soon in next version:

1. Updated the comment to:
/* VFIO directory might not exist (e.g., unprivileged containers) */

2. Modified the log message to:
"VFIO directory does not exist, skipping VFIO support..."

These changes enhance clarity and align with the coding standards. I 
appreciate your attention to detail.

Best regards,
Yang Ming


