Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4079C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 11:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF5D940287;
	Mon,  7 Jul 2025 13:53:37 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 5E8244025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 13:53:36 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id DC47416B5B
 for <dev@dpdk.org>; Mon,  7 Jul 2025 13:53:35 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id CC50916C2A; Mon,  7 Jul 2025 13:53:35 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 7E7D116BCC;
 Mon,  7 Jul 2025 13:53:32 +0200 (CEST)
Message-ID: <fc296811-c40a-4853-b2d9-323e9cd55b3b@lysator.liu.se>
Date: Mon, 7 Jul 2025 13:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode support
To: "Pathak, Pravin" <pravin.pathak@intel.com>,
 Jerin Jacob <jerinjacobk@gmail.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>, 
 "Chen, Mike Ximing" <mike.ximing.chen@intel.com>,
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>,
 "Marchand, David" <david.marchand@redhat.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>,
 "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>,
 "harry.chang@intel.com" <harry.chang@intel.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
References: <20250628045112.655999-1-pravin.pathak@intel.com>
 <CALBAE1NrMu3znG6N+iSQacxHWpoGmCe=azvTbkjEUQZGLY+DmA@mail.gmail.com>
 <bc0299d2-052d-4188-ab18-987360d65cb4@lysator.liu.se>
 <CALBAE1MUrpZqWA=E78QiWy7k=H8QrYQ-=4vme4eHqSm8avBHJg@mail.gmail.com>
 <BL1PR11MB5461AD27C632B62C4A81FC59F446A@BL1PR11MB5461.namprd11.prod.outlook.com>
 <47e87bef-a862-495c-ad96-fb82c840f443@lysator.liu.se>
 <BL1PR11MB54613D5082A1DACD884D8F3AF446A@BL1PR11MB5461.namprd11.prod.outlook.com>
 <efd0a370-d13b-4848-870b-a49f4d6f5f55@lysator.liu.se>
 <BL1PR11MB5461841B6FF2D7F57B69888FF441A@BL1PR11MB5461.namprd11.prod.outlook.com>
 <4ef04c34-69be-4d87-bc1b-3bd11f465d09@lysator.liu.se>
 <BL1PR11MB546155938A88BA1E18EA1F4CF44DA@BL1PR11MB5461.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <BL1PR11MB546155938A88BA1E18EA1F4CF44DA@BL1PR11MB5461.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 2025-07-05 06:11, Pathak, Pravin wrote:
> 
> 
>> -----Original Message-----
>> From: Mattias Rönnblom <hofors@lysator.liu.se>
>> Sent: Thursday, July 3, 2025 5:25 AM
>> To: Pathak, Pravin <pravin.pathak@intel.com>; Jerin Jacob
>> <jerinjacobk@gmail.com>
>> Cc: dev@dpdk.org; jerinj@marvell.com; Chen, Mike Ximing
>> <mike.ximing.chen@intel.com>; Richardson, Bruce
>> <bruce.richardson@intel.com>; thomas@monjalon.net; Marchand, David
>> <david.marchand@redhat.com>; nipun.gupta@amd.com;
>> chenbox@nvidia.com; Sarkar, Tirthendu <tirthendu.sarkar@intel.com>; Pavan
>> Nikhilesh <pbhagavatula@marvell.com>; Shijith Thotton
>> <sthotton@marvell.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
>> Sachin Saxena <sachin.saxena@oss.nxp.com>; harry.chang@intel.com;
>> Mattias Rönnblom <mattias.ronnblom@ericsson.com>
>> Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode support
>>
>> On 2025-07-01 23:08, Pathak, Pravin wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Mattias Rönnblom <hofors@lysator.liu.se>
>>>> Sent: Tuesday, July 1, 2025 4:16 AM
>>>> To: Pathak, Pravin <pravin.pathak@intel.com>; Jerin Jacob
>>>> <jerinjacobk@gmail.com>
>>>> Cc: dev@dpdk.org; jerinj@marvell.com; Chen, Mike Ximing
>>>> <mike.ximing.chen@intel.com>; Richardson, Bruce
>>>> <bruce.richardson@intel.com>; thomas@monjalon.net; Marchand, David
>>>> <david.marchand@redhat.com>; nipun.gupta@amd.com;
>> chenbox@nvidia.com;
>>>> Sarkar, Tirthendu <tirthendu.sarkar@intel.com>; Pavan Nikhilesh
>>>> <pbhagavatula@marvell.com>; Shijith Thotton <sthotton@marvell.com>;
>>>> Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
>>>> <sachin.saxena@oss.nxp.com>; harry.chang@intel.com; Mattias Rönnblom
>>>> <mattias.ronnblom@ericsson.com>
>>>> Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode
>>>> support
>>>>
>>>> On 2025-06-30 19:34, Pathak, Pravin wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Mattias Rönnblom <hofors@lysator.liu.se>
>>>>>> Sent: Monday, June 30, 2025 12:51 PM
>>>>>> To: Pathak, Pravin <pravin.pathak@intel.com>; Jerin Jacob
>>>>>> <jerinjacobk@gmail.com>
>>>>>> Cc: dev@dpdk.org; jerinj@marvell.com; Chen, Mike Ximing
>>>>>> <mike.ximing.chen@intel.com>; Richardson, Bruce
>>>>>> <bruce.richardson@intel.com>; thomas@monjalon.net; Marchand,
>> David
>>>>>> <david.marchand@redhat.com>; nipun.gupta@amd.com;
>>>> chenbox@nvidia.com;
>>>>>> Sarkar, Tirthendu <tirthendu.sarkar@intel.com>; Pavan Nikhilesh
>>>>>> <pbhagavatula@marvell.com>; Shijith Thotton <sthotton@marvell.com>;
>>>>>> Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
>>>>>> <sachin.saxena@oss.nxp.com>; harry.chang@intel.com; Mattias
>>>>>> Rönnblom <mattias.ronnblom@ericsson.com>
>>>>>> Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode
>>>>>> support
>>>>>>
>>>>>> On 2025-06-30 18:18, Pathak, Pravin wrote:
>>>>>>>
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Jerin Jacob <jerinjacobk@gmail.com>
>>>>>>>> Sent: Monday, June 30, 2025 7:44 AM
>>>>>>>> To: Mattias Rönnblom <hofors@lysator.liu.se>
>>>>>>>> Cc: Pathak, Pravin <pravin.pathak@intel.com>; dev@dpdk.org;
>>>>>>>> jerinj@marvell.com; Chen, Mike Ximing
>>>>>>>> <mike.ximing.chen@intel.com>; Richardson, Bruce
>>>>>>>> <bruce.richardson@intel.com>; thomas@monjalon.net; Marchand,
>>>>>>>> David
>>>> <david.marchand@redhat.com>;
>>>>>> nipun.gupta@amd.com;
>>>>>>>> chenbox@nvidia.com; Sarkar, Tirthendu
>>>>>>>> <tirthendu.sarkar@intel.com>; Pavan Nikhilesh
>>>>>>>> <pbhagavatula@marvell.com>; Shijith Thotton
>>>>>>>> <sthotton@marvell.com>; Hemant Agrawal
>>>> <hemant.agrawal@nxp.com>;
>>>>>>>> Sachin Saxena <sachin.saxena@oss.nxp.com>; harry.chang@intel.com;
>>>>>>>> Mattias Rönnblom <mattias.ronnblom@ericsson.com>
>>>>>>>> Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode
>>>>>>>> support
>>>>>>>>
>>>>>>>> On Mon, Jun 30, 2025 at 4:47 PM Mattias Rönnblom
>>>>>>>> <hofors@lysator.liu.se>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On 2025-06-30 11:19, Jerin Jacob wrote:
>>>>>>>>>> On Sat, Jun 28, 2025 at 11:17 AM Pravin Pathak
>>>>>>>> <pravin.pathak@intel.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> DLB2 port interrupt is implemented using DPDK interrupt
>> framework.
>>>>>>>>>>> This allows eventdev dequeue API to sleep when the port queue
>>>>>>>>>>> is empty and gets wakeup when event arrives at the port. Port
>>>>>>>>>>> dequeue mode is configured using devargs argument
>>>> port_dequeue_wait.
>>>>>>>>>>> Supported modes are polling and interrupt. Default mode is polling.
>>>>>>>>>>> This commit also adds code to handle device error interrupts
>>>>>>>>>>> and print alarm details.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
>>>>>>>>>>> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       doc/guides/eventdevs/dlb2.rst              |  20 +
>>>>>>>>>>>       drivers/event/dlb2/dlb2.c                  | 236 +++++-
>>>>>>>>>>>       drivers/event/dlb2/dlb2_iface.c            |   7 +
>>>>>>>>>>>       drivers/event/dlb2/dlb2_iface.h            |   8 +
>>>>>>>>>>>       drivers/event/dlb2/dlb2_priv.h             |  18 +
>>>>>>>>>>>       drivers/event/dlb2/dlb2_user.h             | 112 +++
>>>>>>>>>>>       drivers/event/dlb2/pf/base/dlb2_hw_types.h |  70 ++
>>>>>>>>>>>       drivers/event/dlb2/pf/base/dlb2_osdep.h    |  46 ++
>>>>>>>>>>>       drivers/event/dlb2/pf/base/dlb2_regs.h     | 149 +++-
>>>>>>>>>>>       drivers/event/dlb2/pf/base/dlb2_resource.c | 825
>>>>>>>> +++++++++++++++++++++
>>>>>>>>>>>       drivers/event/dlb2/pf/base/dlb2_resource.h |   6 +
>>>>>>>>>>>       drivers/event/dlb2/pf/dlb2_pf.c            | 223 ++++++
>>>>>>>>>>>       12 files changed, 1711 insertions(+), 9 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/doc/guides/eventdevs/dlb2.rst
>>>>>>>>>>> b/doc/guides/eventdevs/dlb2.rst index 8ec7168f20..a4ba857351
>>>>>>>> 100644
>>>>>>>>>>> --- a/doc/guides/eventdevs/dlb2.rst
>>>>>>>>>>> +++ b/doc/guides/eventdevs/dlb2.rst
>>>>>>>>>>> @@ -477,6 +477,26 @@ Example command to use as meson
>> option
>>>>>> for
>>>>>>>> credit handling:
>>>>>>>>>>>
>>>>>>>>>>>              meson configure
>>>>>>>>>>> -Dc_args='-DDLB_SW_CREDITS_CHECKS=0 -
>>>>>>>> DDLB_HW_CREDITS_CHECKS=1'
>>>>>>>>>>>
>>>>>>>>>>> +Interrupt Mode Support
>>>>>>>>>>> +~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>>>>> +DLB dequeue supports interrupt mode for the API
>>>>>>>> rte_event_dequeue_burst().
>>>>>>>>>>> +The default port dequeue mode is polling. Dequeue wait mode
>>>>>>>>>>> +can be configured on per eventdev port basis using devargs
>>>>>>>>>>> +argument 'port_dequeue_wait'. In interrupt mode, if the port
>>>>>>>>>>> +queue is empty, the application thread will block on the
>>>>>>>>>>> +interrupt until a new event arrives. It enters blocking mode
>>>>>>>>>>> +only after any specified timeout. During the timeout, it will
>>>>>>>>>>> +poll the port queue for
>>>>>>>> events as usual. Interrupt mode uses the DPDK interrupt support
>>>>>> framework.
>>>>>>>>>>> +
>>>>>>>>>>> +    .. code-block:: console
>>>>>>>>>>> +
>>>>>>>>>>> +       --allow ea:00.0,port_dequeue_wait=all:interrupt
>>>>>>>>>>
>>>>>>>>>> Adding other eventdev PMD mainatainers.
>>>>>>>>>>
>>>>>>>>>> Looks like it can be a generic feature. i.e set this option is
>>>>>>>>>> dev_configure() If there is no objection, Please send a new
>>>>>>>>>> patch around
>>>>>>>> that.
>>>>>>>>>
>>>>>>>>> I've considered implementing this in DSW, although in a
>>>>>>>>> different manner (with eventfds and poll()).
>>>>>>>>>
>>>>>>>>> The dequeue timeout will still be honored in "interrupt mode",
>> correct?
>>>>>>>>> It wasn't obvious from the description.
>>>>>>>>
>>>>>>>> How is it in Intel PMD?
>>>>>>>
>>>>>>> It would be best if we configure it per port using
>>>>>>> RTE_EVENT_PORT_CFG_*
>>>>>> flags. Will it be, OK?
>>>>>>> The dequeue timeout will be honored, and the decision to block or
>>>>>>> return
>>>>>> will be made after the timeout.
>>>>>>
>>>>>> That doesn't sound like the timeout is honored.
>>>>>>
>>>>>> The reason an application wants the dequeue call to complete within
>>>>>> a certain time, even though there wasn't any events, is likely
>>>>>> because it want to go do something else with that thread, after the
>> timeout.
>>>>>>
>>>>>> Thus, you can't decide to block the thread *after* the timeout. If
>>>>>> you block, you have to do some time *before* the timeout, and wake
>>>>>> up in time to meet the deadline.
>>>>>>
>>>>>> For example, if the event device is given a 1 ms dequeue timeout by
>>>>>> the application, it could go busy-poll for 10 us, then busy-poll
>>>>>> with a short tpause for 100 us, and then put the thread to sleep
>>>>>> blocking on some fd for the remaining 890 us.
>>>>>>
>>>>>> The hardware-specific nature of the timing and exact mechanism to
>>>>>> use speaks against having this kind of configuration in the Eventdev API.
>>>>>
>>>>> The mode is not for what to do during a timeout, but after a timeout.
>>>>
>>>> My comments were not so much concerning any DLB-specific extension,
>>>> but rather how this kind of function should work, if it was a part of
>>>> the standard API.
>>>>
>>>>> We can enter sleep mode immediately by setting the timeout to 0 if
>>>>> we need
>>>> to.
>>>>> This mode is not changing the current timeout behavior.  After the
>>>>> timeout, it allows HW devices supporting interrupts to block on
>> an interrupt.
>>>>
>>>> The current API specifies that control is returned to the
>>>> application, after the timeout has expired. If you change that with a
>>>> PMD parameter, the DLB behavior will be in violation of the API
>>>> contract. Applications using
>>>> rte_keepalive_alive() between dequeues is one example of those that
>>>> will break. In fact, all applications that use more than one RTE service will
>> break.
>>>>
>>>>> It will wake up only after a new event arrives at the port. If the
>>>>> application needs control back then it can use the current default
>>>>> non-blocking mode. A better mode to save power during timeout will
>>>>> be to use umwait-based sleep.  Consider this as extension to current
>>>>> timeout
>>>> behavior if device supports interrupts.
>>>>>
>>>>
>>>> What about applications that both want power efficiency *and* require
>>>> a timeout?
>>>>
>>>> It makes no sense to me the change the semantics of the dequeue
>>>> timeout parameter from "the time until I want control back" to "the
>>>> time I want the event device to use polling, after which it should put the
>> thread to sleep".
>>>> Those two are pretty much orthogonal.
>>>>
>>>> The current API doesn't specify what happens during the timeout. If
>>>> you by "non-blocking" mean "busy-polling", that is not an API
>>>> requirement. I don't see why the event device couldn't put the lcore
>>>> thread to sleep during a long timeout (and I also see why you may not
>>>> want that to be the default behavior).
>>>
>>> I got your point. Application will prefer to return and not block
>>> after the timeout as per current API description. Current API
>>> signature is = 0 no-wait, returns immediately if there is no event.
>>>> 0 wait for the event or timeout
>>> Will it be OK to extend it to treat max timeout 0xffffffff as block
>>> for event with PMD specific Mechanism to wait for the event ? Port specific
>> configuration will not be required in this case.
>>> Devices supporting interrupts then can use interrupt blocking mode
>> internally.
>>>
>>
>> Correct me if I'm wrong here, but I think an event device is free to block using
>> a PMD-specific mechanism with any non-zero timeout. The longer the
>> timeout, the more sense it make to put the thread to sleep (blocking on an fd).
>>
>> I also think that the details of how to spend the timeout time probably needs
>> to be configured by the app (at startup). Different modes, thresholds, etc.
>> Maybe such are best off as PMD parameters at this point.
>>
>> Is there some limitation in the interrupt APIs, or what is preventing the DLB
>> driver to both honor a finite timeout and block/put the lcore thread to sleep?
> 
> Current API definition does not specify or put restriction on timeout mechanism PMD decides
> to  implement.  But it will be nice to have application some control on it. DLB PMD supports
> polling, umwait and interrupt blocking as three modes. Current configuration is devargs based
> and specific to DLB PMD. If application has choice at each dequeue call, it can decide what
> mechanism to use. Polling for lower latencies, umwait for power saving and interrupt blocking
> to make a de-scheduling call and release CPU for other thread. We had implementation supporting these
> using most significant bits of timeout value on per dequeue call basis. But as it breaks API, now it is done
> with devargs.  If control over dequeue wait is useful to applications, then it can be standardized instead of
> being PMD specific. Else, we will keep it the way it is now in the patch.
> 

I agree it makes sense to allow the application (or the user deploying 
the app) control over power management / latency parameters.

It's not obvious those need (or should) be specified on a per-dequeue 
call basis. Wouldn't it suffice to make it a per-device or per-port (~= 
per-lcore) configuration?

Maybe this kind of configuration is better off starting as PMD devargs, 
since it will vary both with hardware/ISA and event device 
implementation. When we have a couple of different implementation, we 
can try to generalize a common API from them.

> I took look at ethdev PMD and there additional APIs are used for blocking.
> rte_eth_dev_rx_intr_enable
> epoll_wait()
> rte_eth_dev_rx_intr_disable
> And other APIs to configure interrupts.  But Eventdev mechanism of doing all inside dequeue API looks
> Simple.
> 
>>
>>>>
>>>>>>
>>>>>>> If not interrupt, it can be called blocking vs polling mode.  If
>>>>>>> the port config is
>>>>>> fine, I will create a new patch with it.
>>>>>>> Also, we should have this as a capability for eventdevs.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> What's being configured should just be a threshold time at which
>>>>>>>>> the event device would go from busy-polling to blocking the thread.
>>>>>>>>>
>>>>>>>>> Maybe it should be called something with "blocking" or
>>>>>>>>> "sleeping", instead of "interrupt", since interrupts are never directly
>> involved.
>>>>>>>>
>>>>>>>> Agree. or make it a power save mode or so.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Anyway, seems like a good candidate for a generic feature to me.
>>>>>>>>>
>>>>>
>>>
> 

