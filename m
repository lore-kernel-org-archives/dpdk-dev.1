Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E8CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDFA740276;
	Wed, 15 Oct 2025 14:00:45 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id A8B9640273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:00:44 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Uey1aH8ka4eE3vJtB30VGYjIdA584OOljE3Bl0iti9M=;
 b=OdmO9fneq/u0/7QJRfQv0SM6zG239XYq2hxGLOgHOjk9K5/9oMA7wG3rxuxbRYRYINHZpDHfd
 yMvTO0rddpLgqDeuc5pCS1QrfxMsMKqJ69Ndx20hKCpX5uguGw+HOj0vWxOp97bs70hOJgApeh3
 789Qjj6rPeK/ZXj+Orhsfeg=
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cmqQt3DnbzKm5G;
 Wed, 15 Oct 2025 20:00:22 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B09491A0188;
 Wed, 15 Oct 2025 20:00:42 +0800 (CST)
Received: from [10.82.20.40] (10.82.20.40) by kwepemk500009.china.huawei.com
 (7.202.194.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Oct
 2025 20:00:42 +0800
Message-ID: <0311d8dc-e85c-dfd0-9e46-30db2848194d@huawei.com>
Date: Wed, 15 Oct 2025 20:00:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v11 05/21] argparse: add documentation on supported value
 types
Content-Language: en-US
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
 <20251009130056.2630343-6-bruce.richardson@intel.com>
 <a6ca7fc0-d7d7-4f8f-b04b-df637097a374@huawei.com>
 <aO9d-cPpkkKXo4J3@bricha3-mobl1.ger.corp.intel.com>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <aO9d-cPpkkKXo4J3@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.82.20.40]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

On 2025/10/15 16:40, Bruce Richardson wrote:
> On Wed, Oct 15, 2025 at 03:53:09PM +0800, fengchengwen wrote:
>> Minor comment on paragraph layout, with that fixed:
>> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
>>
>> On 10/9/2025 9:00 PM, Bruce Richardson wrote:
>>> The different value types supported by the argparse library are not
>>> discussed in the documentation, so add some reference material about
>>> them.
>>>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>> ---
>>>   doc/guides/prog_guide/argparse_lib.rst | 73 +++++++++++++++++++++++++-
>>>   1 file changed, 71 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
>>> index b309260d20..7868af5672 100644
>>> --- a/doc/guides/prog_guide/argparse_lib.rst
>>> +++ b/doc/guides/prog_guide/argparse_lib.rst
>>> @@ -160,6 +160,75 @@ both use this way, the parsing is as follows:
>>>   - For argument ``ooo``, it is positional argument,
>>>     the ``ooo_val`` will be set to user input's value.
>>>   
>>> +Supported Value Types
>>> +~~~~~~~~~~~~~~~~~~~~~
>> This paragraph should be the inner paragraph of 'Parsing by autosave way'
>> I suggest delete the ~~~~~, and move the whole after "Parsing by autosave way"
>>
> I actually disagree on this. I think the value types needs its own
> subsection to hold the various value-type sub-subsections together. I had
> originally considered making this a subsection of the autosave one, but
> that left us with too many levels of nesting. I think having it at this
> level works ok.

okay


>
>
