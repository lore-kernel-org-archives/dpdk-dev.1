Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56314CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 16:03:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C4E240647;
	Fri, 15 May 2026 18:03:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6EF4540269
 for <dev@dpdk.org>; Fri, 15 May 2026 18:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778861020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VGO+vLJOYCZgtekq15mcPEM5gexzcjQiG1+Lsj+ULTY=;
 b=Ib9PQvrAfm2KPtuJ2qe1xG814PFvLlpfCMO2WpyZvpmy8/XwuOkIecF7FhuNXzI8s2OE2q
 AiHWwUYoG7AWAi6fVPEaj5VqE3U4H28WR07KqWwe/VsArZrLcR2Mk9q4JrnVMYDb3Si9AM
 AOmOnmRQHUKHVVL5OB1+fHqQrFhb9ic=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-5km4ZQ93O8eC0iExieG_Cw-1; Fri, 15 May 2026 12:03:38 -0400
X-MC-Unique: 5km4ZQ93O8eC0iExieG_Cw-1
X-Mimecast-MFC-AGG-ID: 5km4ZQ93O8eC0iExieG_Cw_1778861017
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-676fb54c0cdso8229059a12.2
 for <dev@dpdk.org>; Fri, 15 May 2026 09:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778861017; x=1779465817;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGO+vLJOYCZgtekq15mcPEM5gexzcjQiG1+Lsj+ULTY=;
 b=iro2Y01cVPCUpiwiCrMRmMYQHJ00GNGc0fhNCm84SUZ2VdVBEYAOnDStjV3+cmFiMj
 sVRuKFWL3V4bSdNL2cIH/L/qqWTbrTaZ0MVnGNSjeuqzBgS6cB/ERcCOcb2GR0vDY2lZ
 SwpnSDMTKTfvS3RjQphjF6KJJs/EfPhysEslOmIsAC2aDUo+zLsj6nwZMiLrDFpC7k2y
 h8r0zCSgIrOlFoaPDcbv2m8OTeDtfUwQu34vGq1kMbaH2Lxe/vc3qPnukdc4yEhWDNo6
 Zwdq6tWoBkH7UFjJ/WULP6Cv0DGAX+2V+OzxcXoJRqJZJVugDAsrQiLl1U2D3xuyQIgl
 uoSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vvk9b91F55/8QUyD4V72Y+39y/d8D7Oz4SHYkWPG4793tIcfPpPDjsVqYoawxsR2m8fc=@dpdk.org
X-Gm-Message-State: AOJu0YxhgbYJdhpz/znoxHrCV2fqsKQQkogFlLqtLFjW3CiJWJE8VcMe
 tz8FyrqBZ6MLMjllmJNrlmKqPlQiA7LJjbxgN0bigAf6URFTWB9n7KBwuI7eES1zUwNTZAkCrvR
 v45Lwre75Vf0Ncl5UjEp1yAlGJ+iHhg7bbelVUSSzwyKS
X-Gm-Gg: Acq92OEugzOnjvnmlzbAgo7J8muyU/gGi4zsG9RmKDjd5q/negsyT5q1mlez1dhB3U0
 xSBLzFvndIzMLDt34GvyQN78P/7Vfi6caCsy81djsTfmqeYlcUY4Dx2/Mr/540agoOYcV15nFCK
 hzKSu4lRKiJCA9v7dSX6g0ielyrw1zexr6nsRttjwLL3FknXB1zxLpjy1H+qsQEPo3/YMDrvoAi
 Fog2CqtCUPSUxsGnlO4vcsE9rLtnKJtLb7ay8K9DB5RaBSCUesyVu2K/41I6Ojj/sbaR2zScZVV
 AKMHBQH0FMunOClP+ceAfdWnq17FJfXvnzTczl6vLyBfug7qBmo5iyTD1o7pODA7PmCFvspee2e
 aG+X+aj7nNqjdfs9cL2R26w==
X-Received: by 2002:a05:6402:a21c:20b0:67b:4e46:f12f with SMTP id
 4fb4d7f45d1cf-683bd392756mr1827282a12.25.1778861017429; 
 Fri, 15 May 2026 09:03:37 -0700 (PDT)
X-Received: by 2002:a05:6402:a21c:20b0:67b:4e46:f12f with SMTP id
 4fb4d7f45d1cf-683bd392756mr1827220a12.25.1778861016753; 
 Fri, 15 May 2026 09:03:36 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.88])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768bcesm16928478f8f.4.2026.05.15.09.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 09:03:35 -0700 (PDT)
Message-ID: <6f3be520-fb42-45d3-b5af-d86d7cb7669f@redhat.com>
Date: Fri, 15 May 2026 17:03:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 23.11.7 patches review and test
To: Luca Boccassi <bluca@debian.org>
Cc: Shani Peretz <shperetz@nvidia.com>, stable@dpdk.org, dev@dpdk.org,
 Robin Jarry <rjarry@redhat.com>, David Marchand <david.marchand@redhat.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20260421064637.2506152-1-shperetz@nvidia.com>
 <73da1ec3-d1cc-4efb-bedf-89b0f951ec5d@redhat.com> <2787587.q0ZmV6gNhb@thomas>
 <f27bd211-66c0-4a87-9d11-de6d83cae4c9@redhat.com>
 <91a6d5df-57c8-4045-9cc4-4ea0f5170f52@redhat.com>
 <CAMw=ZnSLnz8uxwPJgZThKUm4fpsge_dvb8+o4grBeNYYsmuBMw@mail.gmail.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 xsFNBF2J2awBEADUEPNhgNI+nJNgiTAUcw4YIgVXEoHlsNPyyzG1BEXkWXALy0Y3fNTiw6+r
 ltWDkF9jzL9kfkecgQ67itGfk1OaBXgSGKuw1PUpxAwX2Bi76LAR6M5OsyGM9TSVVQwARalz
 hMwRBIZPzPc7or6Pw7jAOJ8SQGJ1Zlp1YJCjrvpe87V1tH/LY8Wnxn/EuoseFmWILAQZAtYS
 tGjcrAgYn3SPMLR1B0BP5bTBY06vWQjiufH8drenfDnMJAzuBdG1mqjnTqCjULZ3Hunv4xqZ
 aMnkvL/K5Tj1c12Oe4930EE53LrXIBUltRg5mBudSWHnC7twjH0082HH9f963Z/2UI63SFIT
 iUvRvAzJYytgy7XnWLQ0+goZBADKYfolOuC0H8VgCaux8u8KFF28Dy+N6TV2KI58jTlyg1Zu
 l7QwykZpnOkJFiy37Gfbu3YEOzO72cP/S7/A+zvuqkxi63jyEkd+FY99vLt/HN2MUZwRmKDw
 UPbLkmrs8WU01/POVsqDcfvz7vu2St8hqqTiSIdQGS2zyTKB2/DvPSM3jws3udkIYSuhn+X4
 QBiV6lkVZ7DSE6a065gnAauAql+b32Eymy+xnG5jCt1tR+0Cp2VZYCR9OU2gmomUKBDoX/He
 pSgED01CqYPNjN+TddirwmQX7ep4DtXc8FWvv2g/pq9WZFQk2QARAQABzSNLZXZpbiBUcmF5
 bm9yIDxrdHJheW5vckByZWRoYXQuY29tPsLBjgQTAQgAOBYhBAoiOaH51tHF7VYtEI9CINER
 a+yJBQJdidmsAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEI9CINERa+yJoxIP/3VF
 2TIgW4ckxhRFCvFu/606bnvCPie88ake4uWVWMAWwcMc4fKEltRWRCpkSVOwgqoMHnyHxK5r
 kOKzx2CLJMX5TgTMfKzPuaBDHngHLUzl2DStpBzrod0cVg5TShdmmfjY61uxRJKz+DlSkwgJ
 riADdVF5PPosQXTkKSGf2ombpTGpx/pue9ocjnr3x4SDpRLlnooM6Jf/3Y3Ib4jX6HPEyWuY
 b+owIIk9y2nRRGPQ6jbqAhsrXd9V+77UL0QuGWloMuKMZFbNg8hbu7X5aFijAbfxj4YUgojS
 ba7gfGZQan8h32A9KGQWrmsCBc3j2GqEPsX0r05X7cn7WL6IOPgQJ5EiQ7PlazQYVLrvZg9B
 n0GKK0k6895mLG0ZZ5v/qajOPF52etSmvFD1WUPb4OqaHqGA9ZtMpaKFRt7Y6rpXqKNU1xzW
 F5KjbTPtTb9WF3An8dciVv+AYUI7totkZYkWvQtgss8lfaX3NKUvXLVxqK0z3dQyr7rF/tYz
 PneTKypSksjCgaEBLSrsRmM5zKfe7tSNF/fDntfIq/029Jtcw29TcWEP57peNu6TtejewQD9
 sTI+oqiXvW2D5l7LNUDYG8eMJp2oT7I0ZSBRvwcbmjH0DtN/bXCCFfCvk8Yic68F3tV1ctix
 wQARVKDBhT30uCxycRWojCYqTgNJJS71zsFNBF2J2awBEADP57PR2IpSYBeNSrsAjeIcsahE
 N4SQP2C4s50S8QEWAUhqMRI7WNv5cfeef0nDvcl1IUA6oz5SokbcsbMa+mRgaNF4N5KikWTO
 LPYxq2YVJoXwJ+tKmNzyOLFUIfFJ4NBJZple5dTfWzD00Dbb19Mri1hy1mWMqNTPGBee1+hw
 Qcp6n3mmGECvajs8G5A7NyXbwL8ihN7HX9D01ucD62b4G03yKe2g/hvKgcdUVmhCldJlF27I
 2fSR9tDxH9pZqRODY4rjbFZEey/vWKXqjE+DQ8AtMSEaDfFe5D+i4Aw6erWQ3Wr+DwZt1/7G
 dIAElGA/q90T1ENVwJX9y7fsQssawKYYdDqURHCl5JuDXI+VXUypExipUUT5SPycMmbLsx0D
 iKEqPPDQWKxkIDVKqj2+EhamSuJznZUwBLJKn0h4zrIWiXWUy07lRwtVuhaDXhF3GfW+5W/x
 wAg7Qg3w00ASsb/XTHBIhMnenKDfS7ihtQA8SacwX8ySdxb+15XPyiplM979qBQ0mhnilulm
 MIJzEf/JxoYR5huuj4f1PFqqrsP06Dl+YGB7dQZp3IKggS5c3/TAynARRg9N89UsDXNtp7X0
 tgIPFF5k6fnHE0J5O64GYHeTqN/1aE6dAEOV9WrGzQAJxU9ipikb8jKAWXzLewRIKGmoPcRZ
 WdB0NmIjmQARAQABwsF2BBgBCAAgFiEECiI5ofnW0cXtVi0Qj0Ig0RFr7IkFAl2J2awCGwwA
 CgkQj0Ig0RFr7IkkORAAl/NbX93WK5MEoRw7/DaPTo/Lo6Pj1XMeSqGyACigHK/452UDvlEH
 NjNJMzYYrNIjMtEmN9VVCfjT38CSca7mpGQVwchc0mC7QSPAETLCS+UacVf/Kwxz5FfkEUUw
 UT7A+uyVOIgW3d9ldlRzkHA2czonSSgTQU+i2g6DM4ha+BuQb4byAXH6HQHt/Zh1J64z0ohH
 v6iGsCzCY/sMWF8+LEGSnzMGRCLiiwSF0vJBHbzWK68fANaF4gBV0Z/+6tQRFN7YMhj/INmk
 qgvHj1ZzHFNtirjMGPRxoZs51YoLQM/aBPxKrnmXThx1ufH+0L6sGmFTugiDt0XSEkC5reH7
 a+VhQ1VTFFQrClA8NmDSPzFeuhru4ryaaDHO+uEB16cNHxHrQtlP/2hts2JM5lwkZRWJ5A57
 h8eDEIK5be47T85NVHfuTaboNRmgg1HygVejhGUtt69u/0MVRg/roUTa0FyEbNsvz4qAecyW
 yWzMcVrcGJDQLC9JLKEpoyUF6gdTKaiDL2Vao4+XRIA3Y57b6MO35a3HuzAv7+i5Z0mnDEJO
 XxXqTOmKYpMIGexzM/PtuA0712sT1abG9tAJ17ao/B7cqMW5IkKkalemFbWfI2unns4Papvo
 tk9igVqyp6EJDU98z5TJioCVojwK2laDaoIjTJk9YYv3iwCsqPd5feU=
In-Reply-To: <CAMw=ZnSLnz8uxwPJgZThKUm4fpsge_dvb8+o4grBeNYYsmuBMw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Db3a82no32lWIKtu0ejWTHKj_fBP8BpiWA9lGRPRdKo_1778861017
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

On 5/15/26 1:36 PM, Luca Boccassi wrote:
> On Fri, 15 May 2026 at 11:32, Kevin Traynor <ktraynor@redhat.com> wrote:
>>
>> On 4/30/26 12:02 PM, Kevin Traynor wrote:
>>> On 4/30/26 10:58 AM, Thomas Monjalon wrote:
>>>> 30/04/2026 11:32, Kevin Traynor:
>>>>> On 4/21/26 7:46 AM, Shani Peretz wrote:
>>>>>> The planned date for the final release is 30 April 2026.
>>>>>
>>>>> As discussed on thread [0] there was a quite serious regression caused
>>>>> by "net: fix packet type for stacked VLAN"
>>>>>
>>>>> As discussion on the fix is ongoing, I would suggest to just revert this
>>>>> patch for your release.
>>>>
>>>> I agree the revert is the best option here.
>>>>
>>>>> It doesn't require a new RC and re-validation as it's an isolated issue
>>>>> (and there wasn't test cases to catch before Robin's new patch anyway)
>>>>
>>>> I suppose 24.11.5 and 25.11.1 are also impacted?
>>>>
>>>>
>>>
>>> Yes, I was hoping we would have a fix in a few days and we could add and
>>> re-release. Given that there's now discussion on the patch and what
>>> functionality is needed, it's probably best to just revert and release a
>>> new 24.11/25.11.
>>
>> Hi Luca. Are you planning to do a 24.11 release with revert for above
>> issue ? If you have a time issue, let me know and I can help out.
> 
> Hi, is it strictly necessary? Could it wait for the next one?
> 

It's a user visible regression from the previous release that impacts
tap device with VLAN, causing good packets to be discarded. It's also
visible to any application using the net API in a similar way. Given the
effort is low as it's just a revert and we don't need validation teams
involved, then I think it's worthwhile.

