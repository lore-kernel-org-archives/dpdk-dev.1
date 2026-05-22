Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3B7CD5BAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 00:42:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 645464029F;
	Fri, 22 May 2026 02:42:21 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 3691E40287
 for <dev@dpdk.org>; Fri, 22 May 2026 02:42:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=br4ER+4ArvxjFQbcRowmzrvPqLAtGX59+Xid/2cTFqY=;
 b=bZEHpzpT4BjApHW1yrhNfwGGNzZ43d64VvtrS8ltl4cQuK6tic4IHW5FGBZ8OuJN5+DT4rtf5
 hk4cqeYvNNz1dPIG/7XML1LvLvpZZjwrQh7rjJG5GzeBldWX/bQop+Mwj/ddupGqwq8RL0bJivs
 xp8BMS/OkZjPTEHuoq0Epig=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gM5rW59cnz1K96Y;
 Fri, 22 May 2026 08:34:35 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id BDF36402AB;
 Fri, 22 May 2026 08:42:16 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 08:42:16 +0800
Message-ID: <757fc51c-624d-4a05-af65-8862fb3e1287@huawei.com>
Date: Fri, 22 May 2026 08:42:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
To: Bruce Richardson <bruce.richardson@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520093804.29102-1-fengchengwen@huawei.com>
 <20260520093804.29102-3-fengchengwen@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65887@smartserver.smartshare.dk>
 <ag3ME5EBdDSAhaW8@bricha3-mobl1.ger.corp.intel.com>
 <cd4f1bcd-3d66-4ffe-91d7-7ac1fdfe8c2e@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6588F@smartserver.smartshare.dk>
 <20260521073716.3a788175@phoenix.local>
 <ag8jF4E2RnQcFrYu@bricha3-mobl1.ger.corp.intel.com>
 <ag8oZodLjw0cp5Kf@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <ag8oZodLjw0cp5Kf@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 5/21/2026 11:44 PM, Bruce Richardson wrote:
> On Thu, May 21, 2026 at 04:21:59PM +0100, Bruce Richardson wrote:
>> On Thu, May 21, 2026 at 07:37:16AM -0700, Stephen Hemminger wrote:
>>> On Thu, 21 May 2026 14:40:47 +0200 Morten Brørup
>>> <mb@smartsharesystems.com> wrote:
>>>
>>>>> From: fengchengwen [mailto:fengchengwen@huawei.com] Sent: Thursday,
>>>>> 21 May 2026 14.25
>>>>>
>>>>> Thanks for the feedback.
>>>>>
>>>>> I intend to keep the current dict format. This concise ID-name
>>>>> mapping is quite helpful and easy to read especially when there are
>>>>> massive ports, which is exactly the main purpose why I submitted
>>>>> this patch.
>>>>>
>>>>> In my opinion, adopting OData-style query would require
>>>>> architecture- level refactoring of telemetry framework, which is
>>>>> way too heavy for this simple requirement.  
>>>>
>>>> Agree.  Refactoring the telemetry framework is different task, not
>>>> related to this patch.
>>>>
>>>>> For complex query demands, we can implement them by extending the
>>>>> upper-layer Python telemetry script instead.
>>>>>
>>>>> So I suggest we keep this simple form here.  
>>>>
>>>> If it is generally acceptable for DPDK telemetry that a request for a
>>>> list does not return a list type, but returns an object type with
>>>> "index": "value" fields instead, then Series-acked-by: Morten Brørup
>>>> <mb@smartsharesystems.com>
>>>
>>> It is necessary since port list may have holes due to hotplug or the
>>> ownership API.  It would be good to have a more complete query function
>>> that returns more about each ethdev.  I wouldn't worry about the size
>>> of the response. This is JSON and it is meant to be read by scripts not
>>> directly by humans.
>>
>> That's where I think we have a difference - if the output is meant to be
>> read by scripts, we should not need extra commands like this, since the
>> information is already available via existing commands. The only
>> compelling reason that I can see for adding a new command to return a set
>> of ethdev names is for human interactive use.
>>
>> Personally, I think the output should be just used by other scripts, but
>> it does appear that this quick-and-dirty telemetry script is being used
>> extensively for human interactive querying. Therefore, I'm working on
>> extending the script to make it more useful for such cases. I'd prefer to
>> add the extra smarts into the script rather than seeing a proliferation
>> of endpoints providing the same data in different formats.
>>
> Here [1] is my proposed generalised solution, quickly prototyped with copilot,
> composed of two parts: firstly, support for querying values across a range
> of ports using a foreach command, and then secondly, support for aliases to
> make the use of those foreach commands easier on the user. It's not
> intended as a mergable set of patches as-is, but rather to demonstrate how
> we might be able to come up with a more general solution (that keeps to the
> DRY principle) entirely within the python script rather than extending the
> C code.

Great

With the newly introduced FOREACH compound query capability, the port ID and
device name mapping can be fully acquired by existing telemetry commands.

The new command satisfies my original requirement perfectly.

> 
> /Bruce
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=38197 
> 

