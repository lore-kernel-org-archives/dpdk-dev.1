Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96A1C7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 08:50:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB95F40264;
	Mon, 30 Jun 2025 10:50:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E77C64025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 10:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751273429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wLNT8C51kN6eu4Nw5xR4op4dSG3hb/caNnQth7GDoF4=;
 b=UbM1URmpmmmZzVFFwz4jDf8o8yPg5zXtwBqu4+fH/Jwbk7I2XecHGfjb0gp4TpdsAADWvR
 vtrWoxAs3AEPOJEOOp0JE2LggXfJsboyxqDcycmRkDBY4vOadxHxNkdYYGBq1HkAde4+pG
 fpU67PJhJ41VqYIz0Acz74Zjg7C8h5I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-pW7n4n3-P42FGCa__LP2pQ-1; Mon,
 30 Jun 2025 04:50:26 -0400
X-MC-Unique: pW7n4n3-P42FGCa__LP2pQ-1
X-Mimecast-MFC-AGG-ID: pW7n4n3-P42FGCa__LP2pQ_1751273424
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A12601809C8B; Mon, 30 Jun 2025 08:50:23 +0000 (UTC)
Received: from [10.44.22.8] (unknown [10.44.22.8])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3E3E30001B1; Mon, 30 Jun 2025 08:50:15 +0000 (UTC)
Message-ID: <108a1a35-b8ed-4b1f-b232-d0e01c9c9609@redhat.com>
Date: Mon, 30 Jun 2025 10:50:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] vhost: handle virtqueue locking for memory hotplug
To: Danylo Vodopianov <dvo-plv@napatech.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>,
 "aman.deep.singh@intel.com" <aman.deep.singh@intel.com>,
 "yuying.zhang@intel.com" <yuying.zhang@intel.com>,
 "orika@nvidia.com" <orika@nvidia.com>,
 "mcoqueli@redhat.com" <mcoqueli@redhat.com>,
 Christian Koue Muf <ckm@napatech.com>,
 "matan@mellanox.com" <matan@mellanox.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 Mykola Kostenok <mko-plv@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>
References: <20250602084025.1881768-2-dvo-plv@napatech.com>
 <20250602085005.1882499-1-dvo-plv@napatech.com>
 <20250602085005.1882499-2-dvo-plv@napatech.com>
 <6ee82aef-dbb1-4e5f-8a53-6a956161c1db@redhat.com>
 <PAWP190MB2160B45C3304F810ED0172918B6CA@PAWP190MB2160.EURP190.PROD.OUTLOOK.COM>
 <ecd5783c-8d16-42c5-9585-03035d5b78be@redhat.com>
 <PAWP190MB216097D1AF51B638F01595A98B7DA@PAWP190MB2160.EURP190.PROD.OUTLOOK.COM>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <PAWP190MB216097D1AF51B638F01595A98B7DA@PAWP190MB2160.EURP190.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zo8tsLOFKvUkehK0w5MFa7ArdKgUNnyDSPbGISxfg0I_1751273424
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

Hi,

On 6/19/25 3:01 PM, Danylo Vodopianov wrote:
> Hi, Maxime
> 
> 
> I understand your point. However we coould have a situation like this, 
> could resize twice:
> 
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4) read message
>     VHOST_USER_SET_MEM_TABLE
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4) guest memory region size:
>     0x40000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  guest physical addr:
>     0x140000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  guest virtual  addr:
>     0x140000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  host  virtual  addr:
>     0x7fde00000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap addr : 0x7fde00000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap size : 0x40000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap align: 0x40000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap off  : 0x0
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4) guest memory region size:
>     0x40000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  guest physical addr:
>     0x11c0000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  guest virtual  addr:
>     0x11c0000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  host  virtual  addr:
>     0x7fddc0000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap addr : 0x7fddc0000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap size : 0x40000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap align: 0x40000000
>     VHOST_CONFIG: (/usr/local/var/run/stdvio4)  mmap off  : 0x0
> 
> 
> When we set memory region twice. After first iteration 
> VIRTIO_DEV_VDPA_CONFIGURED flag will be unset here: https://github.com/ 
> DPDK/dpdk/blob/main/lib/vhost/vhost_user.c#L1425 <https://github.com/ 
> DPDK/dpdk/blob/main/lib/vhost/vhost_user.c#L1425> On the second 
> iteration, this leads to an rte_panic, as queues are accessed without a 
> lock.
> 
> So we should check vhost message id ( VHOST_USER_SET_MEM_TABLE ).
> 
> However, extend VHOST_USER_ASSERT_LOCK macros with additional check if 
> we work with this message VHOST_USER_SET_MEM_TABLE not handle this case, 
> therefore translate_ring_addresses function calls 
> q_assert_lock directly, without macros wrapper. In this function is 
> check access_lock vhost_virtqueue and this case should be handle.
> 
> To address the described issue, we need to make the following changes:
> 
>  1. *Extend VHOST_USER_ASSERT_LOCK macro*:
>       * Add a check for the VHOST_USER_SET_MEM_TABLE message ID.
>       * Skip rte_panic if the message ID matches VHOST_USER_SET_MEM_TABLE.
>  2. *Modify translate_ring_addresses function*:
>       * Extend its signature to include the id parameter (message ID).
>       * Add logic to skip vq_assert_lock if the message ID matches
>         VHOST_USER_SET_MEM_TABLE.
> 
> 
>  1.
>     Extend *VHOST_USER_ASSERT_LOCK* Macro:
> 
> 
>     #define VHOST_USER_ASSERT_LOCK(dev, vq, id) \
>          do { \
>              if ((id) == VHOST_USER_SET_MEM_TABLE) \
>                  break; \
>              if (!(vq)->access_ok) \
>                  rte_panic("Virtqueue access lock not held\n"); \
>          } while (0
> 
> 
>   2.
>     Modify *translate_ring_addresses* Function:
> 
> 
>     static int
>     translate_ring_addresses(struct virtio_net *dev,
>     struct vhost_virtqueue *vq, uint32_t id)
>     {
>          if (id != VHOST_USER_SET_MEM_TABLE)
>              vq_assert_lock(dev, vq);
> 
>          // Existing logic for translating ring addresses...
>          // ...existing code...
>          return 0;
>     }
> 
> 
> 
> This approach requires extending more functions with conditional checks 
> to handle cases where queue locking should be ignored when the memory 
> table is impacted.
> 
> Do you have any thoughts about this? Or I should rework my patchset 
> according to this described solution above ?

And if instead of relying on the VIRTIO_DEV_VDPA_CONFIGURED flag as I 
suggested, we rely on the vdpa_dev being set?

> 
> 
> ------------------------------------------------------------------------
> *От:* Maxime Coquelin <maxime.coquelin@redhat.com>
> *Отправлено:* 12 июня 2025 г. 14:38
> *Кому:* Danylo Vodopianov <dvo-plv@napatech.com>; thomas@monjalon.net 
> <thomas@monjalon.net>; aman.deep.singh@intel.com 
> <aman.deep.singh@intel.com>; yuying.zhang@intel.com 
> <yuying.zhang@intel.com>; orika@nvidia.com <orika@nvidia.com>; 
> mcoqueli@redhat.com <mcoqueli@redhat.com>; Christian Koue Muf 
> <ckm@napatech.com>; matan@mellanox.com <matan@mellanox.com>; 
> david.marchand@redhat.com <david.marchand@redhat.com>; Mykola Kostenok 
> <mko-plv@napatech.com>; Serhii Iliushyk <sil-plv@napatech.com>
> *Копия:* stephen@networkplumber.org <stephen@networkplumber.org>; 
> dev@dpdk.org <dev@dpdk.org>; Chenbo Xia <chenbox@nvidia.com>
> *Тема:* Re: [PATCH v4 1/1] vhost: handle virtqueue locking for memory 
> hotplug
> Hi Danylo,
> 
> On 6/4/25 10:32 AM, Danylo Vodopianov wrote:
>> Hello, Maxime
>> 
>> Thank you for your review.
>> If I understand correctly, you propose modifying the | 
>> VHOST_USER_ASSERT_LOCK()| macro so that a |VHOST_USER_SET_MEM_TABLE| 
>>   request does not trigger an assertion.
>> However, I believe such modification would not be appropriate, as it 
>> would revert the logic introduced in commit |5e8fcc60b59d| ("vhost: 
>> enhance virtqueue access lock asserts"). With this approach, we would be 
>> performing memory hotplug without queue locking, which could lead to 
>> unintended consequences.
>> Regarding VDPA device regression. We faced with this issue when we 
>> request the number of lcores that the default amount of memory on the 
>> socket cannot handle it.
>> So, regression occurred during the startup part, during device 
>> configuration when it creates pkt mbuf pool.
>> 
>> Let me know your thoughts regarding this.
> 
> No, my point was to modify VHOST_USER_ASSERT_LOCK() to no trigger an
> assertion in case vDPA is configured, as we don't want to lock in this
> case.
> 
> Regards,
> Maxime
> 
>> ------------------------------------------------------------------------
>> *От:* Maxime Coquelin <maxime.coquelin@redhat.com>
>> *Отправлено:* 3 июня 2025 г. 15:30
>> *Кому:* Danylo Vodopianov <dvo-plv@napatech.com>; thomas@monjalon.net 
>> <thomas@monjalon.net>; aman.deep.singh@intel.com 
>> <aman.deep.singh@intel.com>; yuying.zhang@intel.com 
>> <yuying.zhang@intel.com>; orika@nvidia.com <orika@nvidia.com>; 
>> mcoqueli@redhat.com <mcoqueli@redhat.com>; Christian Koue Muf 
>> <ckm@napatech.com>; matan@mellanox.com <matan@mellanox.com>; 
>> david.marchand@redhat.com <david.marchand@redhat.com>; Mykola Kostenok 
>> <mko-plv@napatech.com>; Serhii Iliushyk <sil-plv@napatech.com>
>> *Копия:* stephen@networkplumber.org <stephen@networkplumber.org>; 
>> dev@dpdk.org <dev@dpdk.org>; Chenbo Xia <chenbox@nvidia.com>
>> *Тема:* Re: [PATCH v4 1/1] vhost: handle virtqueue locking for memory 
>> hotplug
>> Hello Danylo,
>> 
>> On 6/2/25 10:50 AM, Danylo Vodopianov wrote:
>>> For vDPA devices, virtqueues are not locked once the device has been
>>> configured. In the
>>> commit 5e8fcc60b59d ("vhost: enhance virtqueue access lock asserts"),
>>> the asserts were enhanced to trigger rte_panic functionality, preventing
>>> access to virtqueues without locking. However, this change introduced
>>> an issue where the memory hotplug mechanism, added in the
>>> commit 127f9c6f7b78 ("vhost: handle memory hotplug with vDPA devices"),
>>> no longer works. Since it expects for all queues are locked.
>>> 
>>> During the initialization of a vDPA device, the driver sets the
>>> VIRTIO_DEV_VDPA_CONFIGURED flag, which prevents the
>>> vhost_user_lock_all_queue_pairs function from locking the
>>> virtqueues. This leads to the error: the VIRTIO_DEV_VDPA_CONFIGURED
>>> flag allows the use of the hotplug mechanism, but it fails
>>> because the virtqueues are not locked, while it expects to be locked
>>> for VHOST_USER_SET_MEM_TABLE in the table VHOST_MESSAGE_HANDLERS.
>>> 
>>> This patch addresses the issue by enhancing the conditional statement
>>> to include a new condition. Specifically, when the device receives the
>>> VHOST_USER_SET_MEM_TABLE request, the virtqueues are locked to update
>>> the basic configurations and hotplug the guest memory.
>>> 
>>> This fix does not impact access lock when vDPA driver is configured
>>> for other unnecessary message handlers.
>>> 
>>> Manual memory configuring with "--socket-mem" option allows to avoid
>>> hotplug mechanism using.
>> 
>> s/using/use/
>> 
>> It needs a fixes tag, and stable@dpdk.org should be cc'ed, so that it
>> gets backported to LTS branches.
>> 
>>> 
>>> Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
>>> ---
>>>   lib/vhost/vhost_user.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
>>> index ec950acf97..16d03e1033 100644
>>> --- a/lib/vhost/vhost_user.c
>>> +++ b/lib/vhost/vhost_user.c
>>> @@ -3178,7 +3178,13 @@ vhost_user_msg_handler(int vid, int fd)
>>>         * would cause a dead lock.
>>>         */
>>>        if (msg_handler != NULL && msg_handler->lock_all_qps) {
>>> -             if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
>>> +             /* Lock all queue pairs if the device is not configured for vDPA,
>>> +              * or if it is configured for vDPA but the request is VHOST_USER_SET_MEM_TABLE.
>>> +              * This ensures proper queue locking for memory table updates and guest
>>> +              * memory hotplug.
>>> +              */
>>> +             if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED) ||
>>> +                     request == VHOST_USER_SET_MEM_TABLE) {
>> 
>> It looks like a workaround, and I'm afraid it could cause regression
>> with some vDPA devices, or that it would not be enough and we would have
>> to add other requests as exception.
>> 
>> 
>> Wouldn't it better to modify VHOST_USER_ASSERT_LOCK() so that it takes
>> into account the VIRTIO_DEV_VDPA_CONFIGURED flag?
>> 
>> Thanks,
>> Maxime
>> 
>>>                        vhost_user_lock_all_queue_pairs(dev);
>>>                        unlock_required = 1;
>>>                }
>> 
> 

