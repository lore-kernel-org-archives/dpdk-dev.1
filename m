Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36328CD5BAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 01:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58FD94029F;
	Fri, 22 May 2026 03:05:09 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 3224540287
 for <dev@dpdk.org>; Fri, 22 May 2026 03:05:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=x5wqojYZ+oM1N1B0GLz8DkSygvddKxcqzskL8zex/w0=;
 b=jAMzcMbp/P6sXdXKVm2XVekRg/WYP83RsDWfMDaiKa1JHfTIryZTvRbw7/Oz3bhG1TnzRvXDJ
 IRJ+OGQ7uEtIXpN5CToi0+MLc74xN8TxnXWmgGVP57FzfqKtEqsuTU8Bm0SkTDxmX4FmmDYGwhM
 ec3hIgjwJevk1pdBh5uCRGY=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gM6Lr1Qwqz1cyVx;
 Fri, 22 May 2026 08:57:24 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 5959540572;
 Fri, 22 May 2026 09:05:05 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 09:05:04 +0800
Message-ID: <c0f24426-19b2-42bf-9432-a1c58ac19c66@huawei.com>
Date: Fri, 22 May 2026 09:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bus/uacce: support driver forward compatibility
To: David Marchand <david.marchand@redhat.com>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <qianweili@huawei.com>,
 <liuyonglong@huawei.com>
References: <20260302110206.49670-1-fengchengwen@huawei.com>
 <20260302110206.49670-2-fengchengwen@huawei.com>
 <CAJFAV8wbj3oKRoF-0+jr1ceWMgVDZT-a9Rd5Ptdx9=N+1_WA7w@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAJFAV8wbj3oKRoF-0+jr1ceWMgVDZT-a9Rd5Ptdx9=N+1_WA7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 5/21/2026 9:06 PM, David Marchand wrote:
> Hello Chengwen,
> 
> On Mon, 2 Mar 2026 at 12:02, Chengwen Feng <fengchengwen@huawei.com> wrote:
>>
>> As we know, the uacce driver (e.g. hisi_acc DMA driver) reads the API of
>> the hardware device (through /sysfs/class/uacce/xxx/api) and compares it
>> with the API supported by the driver to match the corresponding hardware
>> device.
>>
>> Hardware devices will continue to evolve, which means their APIs will
>> change, but business requirements demand that they support old
>> programming interfaces as much as possible.
>>
>> To adapt to this situation, this commit supports forward compatibility
>> of driver APIs. For example, if the driver supports the hisi_qm_v5 API,
>> it can drive the hardware device that supports the hisi_qm_v6 or
>> hisi_qm_v7 API.
>>
>> In addition, a driver flag (RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV) is
>> introduced. The driver supports forward compatibility of APIs only when
>> this flag is defined.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/bus/uacce/bus_uacce_driver.h |  5 +++
>>  drivers/bus/uacce/uacce.c            | 51 ++++++++++++++++++++++++++--
>>  2 files changed, 53 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
>> index 618e0f9b76..c7445778a6 100644
>> --- a/drivers/bus/uacce/bus_uacce_driver.h
>> +++ b/drivers/bus/uacce/bus_uacce_driver.h
>> @@ -50,6 +50,7 @@ struct rte_uacce_device {
>>         char dev_root[RTE_UACCE_DEV_PATH_SIZE];  /**< Sysfs path with device name. */
>>         char cdev_path[RTE_UACCE_DEV_PATH_SIZE]; /**< Device path in devfs. */
>>         char api[RTE_UACCE_API_NAME_SIZE];       /**< Device context type. */
>> +       uint32_t api_ver;                        /**< Device api version used for compatibility. */
> 
> I have some problem with this field.
> See below.

...

>> +
>>  static bool
>> -uacce_match(const struct rte_uacce_driver *dr, const struct rte_uacce_device *dev)
>> +uacce_match(const struct rte_uacce_driver *dr, struct rte_uacce_device *dev)
> 
> A matching helper should only match, and not modify the object.

Yes, you are right

> 
>>  {
>> +       bool forward_compat = !!(dr->drv_flags & RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV);
>> +       uint32_t api_ver = uacce_calc_api_ver(dev->api, NULL);
> 
> This conversion from a string to integer could be placed in the scanning step.
> Why place it here?

I think it's OK to place in the scanning step.
Should I submit a commit to fix this?

> 
> 
> The dev->api_ver has no in-tree user.
> This field was (silently?) dropped by my best AI friend in the bus
> refactoring series I posted.
> https://patchwork.dpdk.org/project/dpdk/patch/20260506155201.2709810-12-david.marchand@redhat.com/
> 
> Please advise if I can drop this field (it is just the integer value
> extracted from dev->api afaiu), or if it should be moved to the
> scanning step.

Please keep this field.
This field mainly used for driver to know which api-version the device support, so driver could do
bug-fix for specific device by judging this field.

Thanks

> 
> 

