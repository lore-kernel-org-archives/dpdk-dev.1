Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F45C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 08:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62CC24026C;
	Tue, 29 Apr 2025 10:31:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CD2AD40263
 for <dev@dpdk.org>; Tue, 29 Apr 2025 10:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745915459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R7tTaP2AA6yd2/QPYDV+OKwJVTb+jqSfwpJpV1pN7Zo=;
 b=MxepOAcQtz8dyzelirn/tUIsfeV2AYbUemj2uKcK1GipDcGIg4a3C46O1KBtKaOF45S2uR
 5VwB4pBqMuEd0W03RPAGO0iz2cS8t2HWMJpaLn2riFGpsmYS7yCImqBcslbwqUOtR0Ftuu
 KCnnBZ8JD/LzL9km+IFE8xueYvD4Vag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-P4yqel7yN4aBBKDRLL5TZQ-1; Tue, 29 Apr 2025 04:30:57 -0400
X-MC-Unique: P4yqel7yN4aBBKDRLL5TZQ-1
X-Mimecast-MFC-AGG-ID: P4yqel7yN4aBBKDRLL5TZQ_1745915456
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d3b211d0eso27626965e9.1
 for <dev@dpdk.org>; Tue, 29 Apr 2025 01:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745915456; x=1746520256;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7tTaP2AA6yd2/QPYDV+OKwJVTb+jqSfwpJpV1pN7Zo=;
 b=bA1Rj/uF+xxfV/x4A8Muw1hJVAJzVVJVKEfV+cd61i6Tg3IFzE3Va0nkecg+91wMHd
 MS53V5gYWrrP0YAsuzC+arhVG3OVbe4XodqNpvnfNKsu/yNSsgqioXtPL0QFt085Slje
 GV/HhAZ48Ja3zbfO2lewRJJZ/Iun3d1kjpmMJzpXPbRz0cRCH7OctwKm2eiudLpKQO46
 R0gkeV+jVmE+Q9JM1IYcW4spxZ8Rn6vploryeGgVVfEGb/z/tjKRzTlheUgqBLarKPr1
 diE8PnnclOuwsveJmzDPiwXLTWwpG5vXIc7q4BrqddZciF9moSzy0ZImi7vCEK4GQrLt
 FMoA==
X-Gm-Message-State: AOJu0YygJw7glCcf6wBANaIaHtFkThaymMRVspAse08WRynq74m2imM7
 xbFDfcaiQfDkfjOsgf0yb2Ag+oYY3d++QLYmNT6cHkVBS+fdX9k355ovu5hq6njP1USOHfE28nh
 jXdgUw1L6lDSERWolKn9GaGC8xPAj4lkUb5b45H9O
X-Gm-Gg: ASbGncsjEqxf9hlE8ILpZPhAqs0sceB1KnWtsX/ru2cYSk8TgpnsU/SLUJhL/nQEyfa
 jC9sU2K0ZllyHTqoGd3D9jKUKXZqo1O6U9+8BLIjpS1/wea9bG12/ArjjYCWXi3+1Hy4VPwsnx/
 jxbqkfSQ7Pw2tPdbV2TVOZHFNd0cXC3LC5oz0pvwL0fju0QpDd08U1oBeOkiv7eoaNlsfEy0KK7
 DZhDkg2EDfkaWG8zI/U48bMY6dptz1oXhNMXPp0sJoWNzgVwii9yXEcZofj3SmH+49a3gLrixnV
 rZPWyY8jHhvL/A==
X-Received: by 2002:a05:6000:2c8:b0:3a0:7c88:8f02 with SMTP id
 ffacd0b85a97d-3a08a50211cmr1642319f8f.1.1745915456363; 
 Tue, 29 Apr 2025 01:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs3hubjB8jWoiVUMiV+EsRwcG68d39XUQBRWfG6HUcCwFOYdIyTIbrbmK3xJKM2JOZNpFBbA==
X-Received: by 2002:a05:6000:2c8:b0:3a0:7c88:8f02 with SMTP id
 ffacd0b85a97d-3a08a50211cmr1642302f8f.1.1745915455995; 
 Tue, 29 Apr 2025 01:30:55 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.131.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca497esm13165198f8f.24.2025.04.29.01.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 01:30:55 -0700 (PDT)
Message-ID: <8fd14d21-dea3-48ea-afd3-ae347f566bb1@redhat.com>
Date: Tue, 29 Apr 2025 09:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: meson error on ARM Grace server 23.11/22.11
To: Patrick Robb <probb@iol.unh.edu>, ci@dpdk.org
Cc: dev <dev@dpdk.org>, Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 stable@dpdk.org, Luca Boccassi <bluca@debian.org>,
 "Xueming(Steven) Li" <xuemingl@nvidia.com>
References: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
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
In-Reply-To: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 83Y-S0wex41iR6Mx6n3pWFfhAVN0GfaWXcTBz6nz-9I_1745915456
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

+cc Luca/Xueming

On 29/04/2025 03:43, Patrick Robb wrote:
> Hi,
> 
> At the DPDK Community Lab we have been running CI tests with a new ARM
> Grace server for the past couple of months on main and next-* branches. I
> am trying to add LTS runs now, and ran into a snag with 23.11 and 22.11 for
> this system. Stable maintainers I'm not sure whether this should be
> addressed or not for hardware which is new and didn't exist when 22.11 and
> 23.11 were released... but I figured I'd make the tickets and find out. I
> attached the meson logs to the tickets and if for whatever reason you guys
> want to remote into this machine, I'm happy to setup the VPN and SSH
> access.
> 
> 22.11: https://bugs.dpdk.org/show_bug.cgi?id=1703
> 23.11: https://bugs.dpdk.org/show_bug.cgi?id=1702
> 

