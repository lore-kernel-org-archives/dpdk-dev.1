Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EA0C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 10:09:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA15F40609;
	Mon, 28 Jul 2025 12:09:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DE551402E0
 for <dev@dpdk.org>; Mon, 28 Jul 2025 12:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753697370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ljo+Ao6soWpRaBCYgUXJuc9uDsKRGh0cfH0PeH+MBjg=;
 b=IO6LDWDXlosMO2z00QWaYi1OR4fH4SCl4On6qb0Sc9oa+GZJjWl0uG+my8ACm1UjMrpA60
 u94txTg/Bc9SG8yzXVCNXqrO4ciiDXp8H6hBYBs+MlSbkBU0sVJrr3pTYg00AZBpv7YCvT
 7vOSNVsnFFuP+UDJFPkY7xwMaWU+BXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-VUt39y8eNUeiro9I4bxPSQ-1; Mon, 28 Jul 2025 06:09:29 -0400
X-MC-Unique: VUt39y8eNUeiro9I4bxPSQ-1
X-Mimecast-MFC-AGG-ID: VUt39y8eNUeiro9I4bxPSQ_1753697368
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4562985ac6aso29610555e9.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 03:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753697368; x=1754302168;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ljo+Ao6soWpRaBCYgUXJuc9uDsKRGh0cfH0PeH+MBjg=;
 b=tgtJ4vIl7YsHsGHLmKBO//Q7q/OHqvTSyozgU/6EpPplt9Iw1YRIhdja/+2nin2042
 uGh/7OLsxU+DtwuuLMx7vLvsJlOHS7o7I3xUq+wci0yUF6TpXVp6sHJo68RFHOQHUE6R
 2u5YxxgRwG6tF5/EgD5f7Qo/ln7rfR9H01fPsd4A0wIBPbg1Sz6dTttlvUM9pOhRJqY9
 y+UnmjWfkjcfEMikxPbK19oX7BPivVUrHT0d84rOVzM2gBvC32fXXx35SoZJkjqs1Oed
 +5aTNen9c3owyszCOjFtHbyY6jPerq0gnVFyjy/ffBAbm4s+2qiePT2pF0peioHYS61X
 4Tfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrkTKdRj2RMZRXJofvZ1R5izxb2uMxFXDnM+27liZLvW7cxN7If8S0eAJ7vVQdPoEUZVE=@dpdk.org
X-Gm-Message-State: AOJu0YyrxIoN5BV6OIDYDGLAuPawkfz+qg+lZPHVZ7TyaIu3qEWkqyVj
 1K2uI9aQA0VsoQUNAlmhbN2jDVjmXfdUVeAAvgrncEbPcAaw+CBVte0m5GRo+EV43q0YHMzAumQ
 nqta1vzxWGigyL7SX4SL2dAbXj6PFQ+4/mXgHv8+53kzZ
X-Gm-Gg: ASbGnctITIlPN0QARHUEHTgUodoxQvRdryKa94Is9jxpA6isFKcvD5+hWw4EFNCY7oI
 w94wuQCTByzKyBN8Yxm91jmadwVRCkWxxdG/p3EDaaEJ52UbD0RXtjWuR1oLzVP7Io0E4GO4ti+
 +HNb+ER+36Zux6eDG7n/pzMgqUA4iCcramwqmMJ6EVgncmbohSPPPc1o1pXwB5W0GcyiWFSymT4
 VjtSmq4wGfxj07ioYk4k1QjrITF/sZthZz/xfEpvoWyYkbIN1UmuKvCeZtJWwzK2cEG+0e5/bBM
 eSZoNB9bNfU17pVuTyQxAu8CBQLZMOg7yYZCNJr9PA==
X-Received: by 2002:a05:600c:4f0d:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-458791252f3mr72493765e9.0.1753697367652; 
 Mon, 28 Jul 2025 03:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgSq2qWMi0oOvMRvaTCAhS52pBgVsukBvq7byp6x8Lv78cDa6JFhlVWZVAaBBuajbFn7K81w==
X-Received: by 2002:a05:600c:4f0d:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-458791252f3mr72493345e9.0.1753697367157; 
 Mon, 28 Jul 2025 03:09:27 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587abc3735sm96023355e9.1.2025.07.28.03.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 03:09:26 -0700 (PDT)
Message-ID: <5d0336ab-f26d-4b7c-bc58-01c877061912@redhat.com>
Date: Mon, 28 Jul 2025 11:09:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.3 patches review and test
To: Yanghang Liu <yanghliu@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, Ali Alnubani <alialnu@nvidia.com>,
 John McNamara <john.mcnamara@intel.com>, Luca Boccassi <bluca@debian.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Chao Yang <chayang@redhat.com>
References: <20250724161514.396245-1-ktraynor@redhat.com>
 <CAGYh1E8dMW6p3RbikrcbdtNmcOq_VtbY2RBUn5oj26C18+MFqQ@mail.gmail.com>
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
In-Reply-To: <CAGYh1E8dMW6p3RbikrcbdtNmcOq_VtbY2RBUn5oj26C18+MFqQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0YvABJRKwXdu3cYy-lwUTbc5Mh8u65Y6SOr9y5TOmdU_1753697368
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

On 28/07/2025 10:14, Yanghang Liu wrote:
> I tested below 18 scenarios on RHEL 9.6 host and didn't find any new dpdk
> issues.
> 
>    - VM with device assignment(PF) throughput testing(1G hugepage size):
>    PASS
>    - VM with device assignment(PF) throughput testing(2M hugepage size) :
>    PASS
>    - VM with device assignment(VF) throughput testing: PASS
>    - PVP (host dpdk testpmd as vswitch) 1Q: throughput testing: PASS
>    - PVP vhost-user 2Q throughput testing: PASS
>    - PVP vhost-user 1Q - cross numa node throughput testing: PASS
>    - VM with vhost-user 2 queues throughput testing: PASS
>    - vhost-user reconnect with dpdk-client, qemu-server(qemu reconnect):
>    PASS
>    - vhost-user reconnect with dpdk-client, qemu-server(ovs reconnect): PASS
>    - PVP  reconnect with dpdk-client, qemu-server: PASS
>    - PVP 1Q live migration testing: PASS
>    - PVP 1Q cross numa node live migration testing: PASS
>    - VM with ovs+dpdk+vhost-user 1Q live migration testing: PASS
>    - VM with ovs+dpdk+vhost-user 1Q live migration testing (2M): PASS
>    - VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS
>    - VM with ovs+dpdk+vhost-user 4Q live migration testing: PASS
>    - Host PF + DPDK testing: PASS
>    - Host VF + DPDK testing: PASS
> 
> 
> Test Versions:
> 
>    - qemu-kvm-9.1.0
>    - kernel 5.14
>    - libvirt 10.10
>    - ovs 3.3
>    - git log
> 
> Commit 3fa2030f013bd7c7d102e576b37ee4dca83b9982
> 
> Author: Kevin Traynor <ktraynor@redhat.com>
> 
> Date:   Thu Jul 24 16:31:46 2025 +0100
> 
>     version: 24.11.3-rc1
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> 
> 
>    - Test device : X540-AT2 NIC(ixgbe, 10G)
> 
> Tested-by: Yanghang Liu <yanghliu@redhat.com>
> 
> Best Regards,
> Yanghang Liu

Thanks Yanghang for the testing and report,

regards,
Kevin.

