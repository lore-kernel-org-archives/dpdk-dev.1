Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749CF459EE
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 15:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 139324026C;
	Fri, 10 Apr 2026 17:16:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DF378400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 17:16:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775834179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hvFwOAI5O6VsbpN8gI9cc8UBMz3Bt8MqE2S7VKV1i9Q=;
 b=hpX/eqnPz4XX+IQl91QhkEaPv2lzh1XyqhMYWWmSdEE/cW1k/wfIMM2/GIwbdMyEf4211K
 99G1pe8S9QR9BZxaMn3totHv37jX/q6xDpnOyaoO2BWZzsJUzsJ5HUfODOUpQ2KQ9RJaIZ
 j6pms41fpOnXA/CrW5+94Te3Lgm1UqQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-CvVoH8prPvyMq_1FTiXfbw-1; Fri, 10 Apr 2026 11:16:17 -0400
X-MC-Unique: CvVoH8prPvyMq_1FTiXfbw-1
X-Mimecast-MFC-AGG-ID: CvVoH8prPvyMq_1FTiXfbw_1775834177
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488bd1ee9e7so14246855e9.1
 for <dev@dpdk.org>; Fri, 10 Apr 2026 08:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775834177; x=1776438977;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvFwOAI5O6VsbpN8gI9cc8UBMz3Bt8MqE2S7VKV1i9Q=;
 b=gsNnlkd2YBXSIyjWmvTeKVKBUWkm7wu7NV7PNmxp7KTgf0+c9qsqpn6tKa1WI/DT4J
 ddvgPLRf7/jYLMDuztiZdvrCOJvhJFQjTBeZPBOfQuSHQGcRQdfZgtVoD9rVKHEuKHNO
 5g6aykwdmTF3hLf9pUGQLomFYKdgCDHXncdi5ZU2ALphaSoswouQSm8XY/kl1OYPl6oZ
 hLT9RDzHGcXG7AfBqnam0HScjyofoxY5q09pGe28ShfbvbZwSIj8gqYmNChxu4XvlIWo
 /29NVdx3gs1JxjvQbHD7ue0HWzvgm/LQu6VBBhrTTnjeh3laVnS6B6OViNk+qvgQ+x3a
 tuvQ==
X-Gm-Message-State: AOJu0YxjiNRfpryiEi3QspqDD38nTwSEwkfaBDrZxfCcP42V98e5ZVr+
 6loULhOmsjHZFYH+VQKm89h8cFfLoNPg7JZxJOAjK+fnprvr5zVrLzoYikbRXfnvGnDOwMoO2EZ
 ouXpaaVDDcWYLfianJw1Y+4sd1Cu3wmSejhswc0RFCD65
X-Gm-Gg: AeBDieu0FogyN/OutAjqsCCrN3cqk/s5U0+1nwSEFkW1v90StRlf3230PIkLPCN9j27
 WE+JgIxEUB64T9FidtRbiDaNc2D9JFdaEmIBy9EmWbbaYfgqqNGjl8fnstpF5fLz55gag8pYRSb
 MJoNgoR1FHBBnK4N+58TPmEhx0hxkvos0vaYTAyaYoWY6of7baQb41jyv8CGd4b4dwB0U8FqRG1
 ozOToJ9sA1Htr4ZL8VUxkPwZcjaxZaAXucFhRNH4EDxUtwb8aRQzaV+0oZWVv3yBYzPbqN4U6lt
 7E4d1rsDCDgW9CmRXudJfah6hEYavU0p8suLjRdYkkk66Gu04uIft4Z0MY1jW+hb+DLku24BQPw
 XH7NFYjDjbecHHyoYsM8i3Io=
X-Received: by 2002:a05:600c:871a:b0:488:a2ac:a34a with SMTP id
 5b1f17b1804b1-488d67f4299mr48044845e9.10.1775834176620; 
 Fri, 10 Apr 2026 08:16:16 -0700 (PDT)
X-Received: by 2002:a05:600c:871a:b0:488:a2ac:a34a with SMTP id
 5b1f17b1804b1-488d67f4299mr48044285e9.10.1775834176157; 
 Fri, 10 Apr 2026 08:16:16 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5b3d4dbsm76203085e9.14.2026.04.10.08.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 08:16:15 -0700 (PDT)
Message-ID: <3af9931c-d23a-431d-8935-deb8cdef5a02@redhat.com>
Date: Fri, 10 Apr 2026 16:16:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Rework device probing
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H3JVnDRCAoanFn4DII72k6PkFKCU1Y1d-2NlsJx8sek_1775834177
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

On 4/10/26 3:34 PM, Morten Brørup wrote:
> Is there a workaround until this patch is added, if I don't want rte_eal_init() to probe any devices, but I want my application to probe devices later by calling rte_bus_scan() followed by rte_bus_probe()?
> 
> It's not something we really need, so if you don't know it off the top of your head, don't spend time trying to figure it out.
> 

The workaround we have used is '-a 0000:00:00.0' Only allowing a dummy
device, hence other devices are hotplugged as needed.

> 
> Venlig hilsen / Kind regards,
> -Morten Brørup
> 
>> -----Original Message-----
>> From: David Marchand [mailto:david.marchand@redhat.com]
>> Sent: Tuesday, 7 April 2026 13.52
>> To: dev@dpdk.org
>> Subject: [PATCH v3 0/7] Rework device probing
>>
>> Applications relying on device hotplug don't work well with the default
>> probing of all available resources.
>> This series proposes to change this behavior via a new EAL option.
>>
>>
>> --
>> David Marchand
>>
>> Changes since v2:
>> - rebased for late 26.03 fslmc bus changes,
>> - fixed devargs lookup,
>> - added debug logs,
>>
>> Changes since v1:
>> - restored per bus scan mode,
>> - fixed logic in device selection for dma/idxd,
>> - fixed raw/ifpga hotplug on ifpga bus,
>> - fixed some doxygen,
>>
>> Changes since RFC v3:
>> - removed per bus scan mode,
>>
>> Changes since RFC v2:
>> - went one step further and reworked devargs lookup in buses following
>>   Bruce comment (see patch 4 which is cosmetic, and patch 5),
>> - updated device selection helper accordingly and
>>   changed API to be device name based,
>> - renamed option, added check on -b presence, updated doc in the last
>>   patch,
>>
>> Changes since RFC v1:
>> - reviewed bus probe() and cleaned up NXP drivers,
>> - changed approach following Bruce comment,
>>
>> David Marchand (7):
>>   devtools: check packet forwarding in null test
>>   bus/fslmc: fix bus cleanup
>>   drivers/bus: require probe function for NXP drivers
>>   drivers/bus: cleanup devargs lookup in scan
>>   bus: factorize devargs lookup
>>   bus: factorize device selection
>>   eal: configure initial device probing
>>
>>  app/test/test_eal_flags.c                    | 63 ++++++++++++++++
>>  devtools/test-null.sh                        | 10 ++-
>>  doc/guides/linux_gsg/eal_args.include.rst    | 13 ++++
>>  drivers/bus/auxiliary/auxiliary_common.c     | 33 +--------
>>  drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 -
>>  drivers/bus/auxiliary/linux/auxiliary.c      |  2 +-
>>  drivers/bus/auxiliary/private.h              |  6 --
>>  drivers/bus/cdx/cdx.c                        | 34 +--------
>>  drivers/bus/dpaa/dpaa_bus.c                  | 71 ++++++++----------
>>  drivers/bus/fslmc/fslmc_bus.c                | 75 ++++++++------------
>>  drivers/bus/fslmc/fslmc_vfio.c               | 21 ++----
>>  drivers/bus/ifpga/ifpga_bus.c                |  8 ++-
>>  drivers/bus/pci/bsd/pci.c                    |  5 +-
>>  drivers/bus/pci/linux/pci.c                  |  2 +-
>>  drivers/bus/pci/pci_common.c                 | 51 ++++---------
>>  drivers/bus/pci/private.h                    | 11 ---
>>  drivers/bus/pci/windows/pci.c                |  4 +-
>>  drivers/bus/platform/platform.c              | 43 +----------
>>  drivers/bus/uacce/uacce.c                    | 39 +---------
>>  drivers/bus/vdev/vdev.c                      |  2 +-
>>  drivers/bus/vmbus/linux/vmbus_bus.c          |  2 +-
>>  drivers/bus/vmbus/private.h                  |  3 -
>>  drivers/bus/vmbus/vmbus_common.c             | 45 +++---------
>>  drivers/dma/idxd/idxd_bus.c                  | 18 +----
>>  lib/eal/common/eal_common_bus.c              | 54 ++++++++++++++
>>  lib/eal/common/eal_common_options.c          | 10 +++
>>  lib/eal/common/eal_internal_cfg.h            |  1 +
>>  lib/eal/common/eal_option_list.h             |  2 +
>>  lib/eal/include/bus_driver.h                 | 38 ++++++++++
>>  29 files changed, 301 insertions(+), 367 deletions(-)
>>
>> --
>> 2.53.0
> 

