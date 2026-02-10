Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3B8EA8112
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:35:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03FCE40666;
	Tue, 10 Feb 2026 14:35:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B3209400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770730514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vmHA5SlBiHnfGrwQYlWR0I1z/jFegCcx5vz1CfZSt34=;
 b=J9Hg8p4Ydufqs2q49J2uVdq+Tk2i98dDcIqz4OmFXxozOeoyGmAjziqbbWbWG7Y4gR0hMR
 RJwXKKaLFij7eJ9e/g2mRS+gzJNHY3qNJMwJ0l6IPWKN145OOxMkvipTCmbkUSA7HhJUqe
 2V+OSkKaR99i+0FTs9yE7YqKU9OEsgg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-gFKjeJR1P3yf0M-5vtK_ew-1; Tue, 10 Feb 2026 08:35:12 -0500
X-MC-Unique: gFKjeJR1P3yf0M-5vtK_ew-1
X-Mimecast-MFC-AGG-ID: gFKjeJR1P3yf0M-5vtK_ew_1770730512
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b8f5bce308dso41027066b.1
 for <dev@dpdk.org>; Tue, 10 Feb 2026 05:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770730511; x=1771335311;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmHA5SlBiHnfGrwQYlWR0I1z/jFegCcx5vz1CfZSt34=;
 b=Bm9EAXLjUGs5czQN11Flge2l+ldpPH5q2FK39Js8h7Lp0xj9NCQcpBD4bUex8D9uip
 q25PdzbUJy35GAc3TnFmKiDFk3fpcl7V/bYWR39KOlL0mJVeI85F6IgWCwAKE3CAKyVC
 9G5GX87G2dhwoGEylQ57UhCNV43Dmn+4d+alGPND3xiIgi9uOG3C5b2UivMgHxHnrjMd
 KzlUz4XcYftmkKmqkEDdskMk21CQz2gRuizkc7YAmN0pFYxkLJ0eADAapeWT0hq1WD9c
 e6fqS0YGW6+j2M13RvJekZ7wCdpUFBLQaF+9NFTY7Q89JaRSVEqg0ziEts9w8QTvOm1R
 vZQg==
X-Gm-Message-State: AOJu0Yw7xmMsh3VUIoYQAk300EN23R4wIKJRzorQ2JhOsOKtJOtyaXmM
 H77nZIHEHURM4crnvXZxU09FzmVbzpkxwhia1QQGUYlV211DGAaB9j8tCvBjxL6NJ5d8PCPZBzT
 BCYqWzf9uxnFjfYalXbLOfA7qb+zcFVM3ClIPzvQ5V4EGIq2vIxHs
X-Gm-Gg: AZuq6aKHSpiH3huKlsZznOFfMTwZ3LWpv8DYnI+8etFeJCK15ZmQwJtGrjhI4Ihg3Vi
 /U4On/ODasYmtFG9oqPZ5fHK4xDRSz4BBbc3/68jJlK98ePltbIiQWT1wxyKDvVhKtzkutQ0QsB
 rmTX5zF5K84eF0cQoGXdd0w1QBLVHpIMf+8f22wOguwMPXYYpOP11q5W34zVoMVgW02t60Hxyzi
 BuCnbZArBBxvLL4O9PyQTFPguMrmq34dtvVHYnRb5yjlmy7nqOM6ACr1We1KLlenUraLpFyKZB0
 RuLs17dFPaps0GvKw7IO+SQ3x+8T8F55pNoMWcw+ATg6stSA+AmVMPXW2bqlbJm7dpJumaTnYFn
 VKHUs2z5ECxd5XtZam3P4BLaI
X-Received: by 2002:a17:906:4795:b0:b8e:14cc:917f with SMTP id
 a640c23a62f3a-b8edf23f0e2mr939035566b.27.1770730510333; 
 Tue, 10 Feb 2026 05:35:10 -0800 (PST)
X-Received: by 2002:a17:906:4795:b0:b8e:14cc:917f with SMTP id
 a640c23a62f3a-b8edf23f0e2mr939032466b.27.1770730509836; 
 Tue, 10 Feb 2026 05:35:09 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.210])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8efbaaf2f4sm428922966b.42.2026.02.10.05.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 05:35:09 -0800 (PST)
Message-ID: <d8187034-d30a-4887-9921-9603b8a8646b@redhat.com>
Date: Tue, 10 Feb 2026 13:35:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] eal/linux: handle interrupt epoll events
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, thomas@monjalon.net, david.marchand@redhat.com,
 dsosnowski@nvidia.com, viacheslavo@nvidia.com, stable@dpdk.org,
 Harman Kalra <hkalra@marvell.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260206172054.273858-1-ktraynor@redhat.com>
 <20260206172054.273858-3-ktraynor@redhat.com>
 <20260206221114.423e498f@phoenix.local>
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
In-Reply-To: <20260206221114.423e498f@phoenix.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o1wWcD4983igRjqyBAkw9zfWWBRR_vRAkU0vwQmysPw_1770730512
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

On 07/02/2026 06:11, Stephen Hemminger wrote:
> On Fri,  6 Feb 2026 17:20:54 +0000
> Kevin Traynor <ktraynor@redhat.com> wrote:
> 
>> Add handling for epoll error and disconnect conditions EPOLLERR,
>> EPOLLHUP and EPOLLRDHUP.
>>
>> These events indicate that the interrupt file descriptor is in
>> an error state or there has been a hangup.
>>
>> Only do this for interrupts that are read in eal. Interrupts that
>> are read outside eal should deal with different interrupt scenarios
>> appropriate to their functionality. e.g. virtio interrupt handling
>> has reconnect mechanisms for some cases.
>>
>> Also, treat no bytes read as an error condition.
>>
>> Bugzilla ID: 1873
>> Fixes: af75078fece3 ("first public release")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> 
> Minor AI review nits.
> 

Thanks Stephen/AI. I will wait a couple of days and address these and
other comments in v3.

> Code Review
> 
> Errors:
> 
>     Lines 295-298: Block comment uses incorrect style Same issue as patch 1 - should use /* not /** for non-documentation comments.
> 

Ack

> Warnings:
> 
>     Line 304: Return value inconsistency The function returns -1 to force rebuild of the wait list, but this happens in the middle of processing multiple events. The existing code had the same pattern for error handling, so this is consistent with the codebase style.

any interrupts not processed this time are not reset, so this should be
fine.

>     Line 342: Log level changed from ERR to WARNING For a condition that causes interrupt source removal, WARNING may be too low. Consider if INFO (as used in line 300) might be more appropriate for consistency.
> 

I will review the log levels based on David's feedback.

> Overall Assessment
> 
> Both patches address a real bug (busy-looping on interrupt errors) with reasonable solutions. The main issues are code style violations with comment formatting and a minor semicolon error. The logic appears sound for handling the EAGAIN and epoll error conditions.
> 

