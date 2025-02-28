Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6FCC282D0
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 08:51:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8786240609;
	Fri, 28 Feb 2025 09:51:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 594B64028C
 for <dev@dpdk.org>; Fri, 28 Feb 2025 09:51:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740732705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R+lFeszRDS4iDUTPdiezKyz/YYNGudF5t/R4l7Zf3ZE=;
 b=Jfv71BQjk1tIOOgTfOSEuNp3B2l1xo+M28wxM8Rvftz97kFrjhhPgtjwpWWIlXUaUKyaF5
 vVcO1OOigCrEqoDeagwfmbPUEPFRmrI8tAvIWQ42qGTh926faKDyjxPcT2PIT8HBQ1/5HN
 el15kO+jA8O62fMJGRMc4EAFIejX6yg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-40MJKkcMOVO-TctqsI9Tyw-1; Fri,
 28 Feb 2025 03:51:39 -0500
X-MC-Unique: 40MJKkcMOVO-TctqsI9Tyw-1
X-Mimecast-MFC-AGG-ID: 40MJKkcMOVO-TctqsI9Tyw_1740732698
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C1AA1800875; Fri, 28 Feb 2025 08:51:38 +0000 (UTC)
Received: from [10.45.242.8] (unknown [10.45.242.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0FF11955BCB; Fri, 28 Feb 2025 08:51:35 +0000 (UTC)
Message-ID: <3eb26ee2-1130-446b-a0ce-4789ba21f14c@redhat.com>
Date: Fri, 28 Feb 2025 09:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] baseband/acc: add internal logging
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 "Chautru, Nicolas" <nicolas.chautru@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "Vargas, Hernan" <hernan.vargas@intel.com>
References: <20250123225519.2469167-1-nicolas.chautru@intel.com>
 <20250123225519.2469167-4-nicolas.chautru@intel.com>
 <20250123152425.0663a626@hermes.local>
 <SJ0PR11MB6694A42B032D97C9D9CF0D77F8E32@SJ0PR11MB6694.namprd11.prod.outlook.com>
 <20250124100058.5b4de64f@hermes.local>
 <0df7deea-a6f9-4078-9dee-de42a1e647f8@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <0df7deea-a6f9-4078-9dee-de42a1e647f8@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qTkwUvoOIvCqH8cCkMS0WyR-yMdr6Pe0cAYDLt0pSHQ_1740732698
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Nicolas,

On 2/7/25 10:52 AM, Maxime Coquelin wrote:
> Hi Nicolas,
> 
> On 1/24/25 7:00 PM, Stephen Hemminger wrote:
>> On Fri, 24 Jan 2025 17:52:43 +0000
>> "Chautru, Nicolas" <nicolas.chautru@intel.com> wrote:
>>
>>> Hi Stephen,
>>>
>>> The commit message may be misleading, the logging interface doesn't 
>>> change here. Note also that I reuse existing trace point framework 
>>> for some of the error logging when relevant (see previous commit).
>>> Here the scope for that buffer is more limited, not a new logging 
>>> method really (the commit message is misleading).
>>> The queue_ops_dump() already provides api to dump device specific 
>>> information related to queue into file (logging in real time is not 
>>> an option) based on information already in PMD memory.
>>> This new buffer is purely there to add storage for the string out of 
>>> rte_bbdev_ops_param_string() for failed operation on that queue, so 
>>> that extend that capture as this info is not stored by PMD.
>>> The name of the buffer could be renamed probably, or I could store 
>>> copy of the actual operation instead of the string in case that makes 
>>> a difference for you.
>>>
>>> I guess it would possible to move this to trace point but I thought 
>>> it would be quite convoluted. That information would fits nicely in 
>>> the queue dump capture, and this would require adding trace point for 
>>> each operation type (I don't believe it can manage arbitrary string) 
>>> and would be a bit of an unconventional use of trace point.
>>>
>>> Any thought?
> 
> I think the introduction of trace points in patch 2 is a good addition,
> and could be extended further to not just emit a simple string but also
> the necessary values to enable debugging (basically what you write in
> the buffers).
> 
> It would have the advantage of having the different traces to be
> synchronized (bbdev and acc ones), and also would have less performance
> impact.

What do you think of this proposal?
how do we proceed for v25.03?

Thanks,
Maxime

>>> Thanks
>>> Nic
>>>
>>>
>>>> -----Original Message-----
>>>> From: Stephen Hemminger <stephen@networkplumber.org>
>>>> Sent: Thursday, January 23, 2025 3:24 PM
>>>> To: Chautru, Nicolas <nicolas.chautru@intel.com>
>>>> Cc: dev@dpdk.org; maxime.coquelin@redhat.com;
>>>> hemant.agrawal@nxp.com; Vargas, Hernan <hernan.vargas@intel.com>
>>>> Subject: Re: [PATCH v2 3/3] baseband/acc: add internal logging
>>>>
>>>> On Thu, 23 Jan 2025 14:55:19 -0800
>>>> Nicolas Chautru <nicolas.chautru@intel.com> wrote:
>>>>> Adds internal buffer for more flexible logging.
>>>>>
>>>>> Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
>>>>
>>>> Inventing another device specific error log seems like a short sighted
>>>> concept.
>>>> Why doesn't existing DPDK logging work well enough?
>>>
>>
>> My feedback is that why can't you just use DEBUG logging for this.
> 
> Or indeed could use the existing logging mechanism.
> 
>>
> 
> Thanks,
> Maxime

