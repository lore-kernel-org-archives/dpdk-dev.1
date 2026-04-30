Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6888CFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 10:03:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC66240661;
	Thu, 30 Apr 2026 12:03:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 32ED740661
 for <dev@dpdk.org>; Thu, 30 Apr 2026 12:03:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777543385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OMT7gq6vGlXwli8pmc+ChnQiSPHPxKr98S29nNw4ZR8=;
 b=PBwmwNpbGX1J+dKoTqGEVIpjosCA6PMN7MUIDgTTvo/tKSFpX0uGhjONvPzqg0vW7CAT+3
 foK0nqypNFd7SKxHLzgNwD3GKSZRgVGojQc4ridzN9zv6dupwuhQvmQWGuIQyEp0dybFiU
 Z2Nq8qf7fpJEJLVSXbzEHiVJwGm0+6Y=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-PTqVK96GMGOtnsxxle2rqw-1; Thu, 30 Apr 2026 06:03:02 -0400
X-MC-Unique: PTqVK96GMGOtnsxxle2rqw-1
X-Mimecast-MFC-AGG-ID: PTqVK96GMGOtnsxxle2rqw_1777543382
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-479d900d222so1177821b6e.2
 for <dev@dpdk.org>; Thu, 30 Apr 2026 03:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777543382; x=1778148182;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMT7gq6vGlXwli8pmc+ChnQiSPHPxKr98S29nNw4ZR8=;
 b=OqMhjHcsD0BuKX9Fm5xzQEDypLjtWQH8kJZi26/V5mSLVB7JJfaVcLokq7zdpgwoB7
 EKtwDOtLencY7uyxZIJovwpfuyL8aITDLcMaPs4le3qihxdGg6DdQnZTq9M0o9PK+7kL
 KoJL6OcyU8RJUB34eUdPGEVs8CIcdh9zrWvqcditMsoy8RPkztEBmuDOkX5yXP7Sku7t
 Nms9ykIUqZWISo0Kswc9Ie4pjToIvSvIx3YtKsOl4Mj8IlgF3bRHv4PA1X4WPw9b6/5m
 oB4pOn+jqwQRQ0s9GT96uTfex4uU41VyINpUE/ErpTAMmadEMp04tH4T5+EqBa2oYxX1
 C//Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Q7+pSCngrMFlCFmsoSmVwShxHp+5QG4INUpGU62Uo4D2Jf19lwpXFevCmp0Nux5jMtGo=@dpdk.org
X-Gm-Message-State: AOJu0YyF/mAARcizlAAJb9dNtLN4BrEa9o4V4HOewVmnvg+3t3ppAj0b
 Mh5bME9H1YJry115YPGJ2LC6A5mZjaiDiPNwye2exSIu7iIHghKGr9L5aaNboKrRMq8y9X5dcMl
 M6LihRa6ooVdgAfefpN5SWLRhjq2workUqGjztcY8VUn4
X-Gm-Gg: AeBDievICjFp2EuVybjr5pjJBmtdFwEZ9QH0mm1hoUzLGuBi0XRWQUesKuSHch+wBZN
 Yt3jemC/WuImCWQnNPX973NzDgWg39bnTgFH1w2CBUO65YQ9Sa34AZmZjf0ESDDPxfxvA4knt73
 GoycBhwG2OVcFLbXDP9jRZUG9c5tsKu4JVYrW/NTfa/vLFO+0earfMf7hUDbB+111uo9Qzl9bGM
 l8KMPnWO23ikF+QuXbeKeQ2pggQn44/Ha+QQLNi6aqc/XUz8JpW74A0lb4GZ8JttRY6ZHnjcPK6
 yKfJurHy5JP4ozghav5a4nwwmnv/6RncOIpv4Szkqs/5KSkm858m8C1AKInCcEncoH65GOnWK0g
 jVK0lQa6OsnHIeMBzg6VRMt+IyJVoQQfIZFU=
X-Received: by 2002:a05:6808:444b:b0:46a:7718:c519 with SMTP id
 5614622812f47-47c5fd909cemr1025077b6e.38.1777543381354; 
 Thu, 30 Apr 2026 03:03:01 -0700 (PDT)
X-Received: by 2002:a05:6808:444b:b0:46a:7718:c519 with SMTP id
 5614622812f47-47c5fd909cemr1025052b6e.38.1777543380791; 
 Thu, 30 Apr 2026 03:03:00 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101aeb6e46sm41737541cf.31.2026.04.30.03.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 03:03:00 -0700 (PDT)
Message-ID: <f27bd211-66c0-4a87-9d11-de6d83cae4c9@redhat.com>
Date: Thu, 30 Apr 2026 11:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 23.11.7 patches review and test
To: Thomas Monjalon <thomas@monjalon.net>, Shani Peretz <shperetz@nvidia.com>
Cc: stable@dpdk.org, dev@dpdk.org, Luca Boccassi <bluca@debian.org>,
 Robin Jarry <rjarry@redhat.com>, David Marchand <david.marchand@redhat.com>
References: <20260421064637.2506152-1-shperetz@nvidia.com>
 <73da1ec3-d1cc-4efb-bedf-89b0f951ec5d@redhat.com> <2787587.q0ZmV6gNhb@thomas>
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
In-Reply-To: <2787587.q0ZmV6gNhb@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gU2cCWqGj7JDnC3RRJ4Y_2_bv5C2vKUs7XLy2ddzW9Y_1777543382
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

On 4/30/26 10:58 AM, Thomas Monjalon wrote:
> 30/04/2026 11:32, Kevin Traynor:
>> On 4/21/26 7:46 AM, Shani Peretz wrote:
>>> The planned date for the final release is 30 April 2026.
>>
>> As discussed on thread [0] there was a quite serious regression caused
>> by "net: fix packet type for stacked VLAN"
>>
>> As discussion on the fix is ongoing, I would suggest to just revert this
>> patch for your release.
> 
> I agree the revert is the best option here.
> 
>> It doesn't require a new RC and re-validation as it's an isolated issue
>> (and there wasn't test cases to catch before Robin's new patch anyway)
> 
> I suppose 24.11.5 and 25.11.1 are also impacted?
> 
> 

Yes, I was hoping we would have a fix in a few days and we could add and
re-release. Given that there's now discussion on the patch and what
functionality is needed, it's probably best to just revert and release a
new 24.11/25.11.

