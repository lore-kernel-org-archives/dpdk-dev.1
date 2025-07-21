Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BFDC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 12:40:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22C894021E;
	Mon, 21 Jul 2025 14:40:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E66564014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 14:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753101625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=irA6B6BQOeKXdQQ+r31bSbuke7dKx4694Ga/U+XG5Ys=;
 b=V+K/hUiMG/Zy03h3lTh/s5tLjzo0woMJQHsZGTyd7ALjpZk1P/miPMlk2Zq+rrATn7/nmQ
 mcD63ekM0TOeLRlcnqH+4KN0TT6Mi1b/3/fRCGXlfH/xgHO++70d+UeEUtZTDG8HqrcjMS
 KFnQL2SpgL7vq9c10E2kXngPPog4+CQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-JKsJaPboPj6Z7W8f2wnxnw-1; Mon, 21 Jul 2025 08:40:24 -0400
X-MC-Unique: JKsJaPboPj6Z7W8f2wnxnw-1
X-Mimecast-MFC-AGG-ID: JKsJaPboPj6Z7W8f2wnxnw_1753101623
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso2907875f8f.1
 for <dev@dpdk.org>; Mon, 21 Jul 2025 05:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753101622; x=1753706422;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=irA6B6BQOeKXdQQ+r31bSbuke7dKx4694Ga/U+XG5Ys=;
 b=wiscxq94Y1unVGaTe8yrF0gfFuh3idcMviCtqepLcDbXG7XmdENU9kivACGBI+HxcH
 E2ZyiPW/ZeUtB3k4+dc0a1fhk8RuvJQjqCnCnw1moszLtVgRbMV5MYVZ/owlaU6SfBS2
 6izO+z9MU0MUh1e8Q/VOW+mhh8tS1j34pglMgmcuRIGS+3Ov9U9zH7v0x9Q0LEpeynTP
 5q4v6PVZ6UgmXUsB2Qypa++T7HgxILBpFZwFK3qTU2pP+aHGfFH2brvl/+prUXk8tex2
 i5/oRnlYWLRcOXoT8zE6lFrAsuYVsCehg8bNC5RVXAeLaRxuJjf/MdJnDgUCDIXGn8gP
 YkJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXquOkgXgcDRmh9Vw9bx0wWsWEGFQ+7IsONtL5pQAXLr0FjAj7mb2e0vww7TNl3708SLlg=@dpdk.org
X-Gm-Message-State: AOJu0YycZyWYDZMTVg8t3vosyHq4FBeArRHDtMiThR9xQPDPY43kkCFT
 /MXZ9Z9/hFnX99DJ4aiOQY8zCyuhdON4mAhzWV6c700jJz09USmE8jHOyURtHt8b4/vW3bqtSdD
 tIWWnQ1JSLqp+HeWrlPBTbG/xCzE9ipdhVzUa5XEa+z5tOQxhnUZx
X-Gm-Gg: ASbGnctaFIVcyMlsDHCH/nCV3pibMYDNS9a59xZvUSAPzh2kHGJW1zu2zYf7XpWwRCv
 pz/bW9YTLHXdUJ5vPdi9JAsi6A4JTfIZximmUFi0QlaJU5YSR4gQ59mY6rqMCryUVw4izVi68M9
 wmzAju+37EemHu/B4jFl8OLx/4u2nVLzoIeryikeWsdYsPZFnT6/tCoowfTf0cI0mXJEuJxZwcr
 bU9jGnR9ZLDy/1ioqcf8w7HmoddwCZfEvRNkgWUbVChuACcWUMvBZd2kri8t+4aXRLYX5eZTTQR
 14gGALMfePgch8538XmPOsKZ8CLMoUz4ZHud09JS6w==
X-Received: by 2002:a5d:64e8:0:b0:3b1:3466:6734 with SMTP id
 ffacd0b85a97d-3b60e518db9mr17013923f8f.44.1753101622399; 
 Mon, 21 Jul 2025 05:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+5GdmAzZHdkWbsOhxrVTnGLFd+WVs/fBnOVN9ypF1UiB/kJUdFcWYGcFMQHpoHQT7e4bcqw==
X-Received: by 2002:a5d:64e8:0:b0:3b1:3466:6734 with SMTP id
 ffacd0b85a97d-3b60e518db9mr17013901f8f.44.1753101621945; 
 Mon, 21 Jul 2025 05:40:21 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca5c952sm10342045f8f.86.2025.07.21.05.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 05:40:21 -0700 (PDT)
Message-ID: <f6ac9083-c8ac-460f-8aa1-5e35c0c1e8be@redhat.com>
Date: Mon, 21 Jul 2025 13:40:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: no longer support end of life CentOS versions
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20240730234228.89967-1-stephen@networkplumber.org>
 <20241119230915.74118-1-stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
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
In-Reply-To: <20241119230915.74118-1-stephen@networkplumber.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ECDekLshwer_4DqeS-HIqYYHL7TmLdN37IzQzYTmyWI_1753101623
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

On 19/11/2024 23:09, Stephen Hemminger wrote:
> The CentOS Project has shifted focus from CentOS Linux to CentOS Stream.
> Both CentOS 7 and 8 are now end of life (EOL).
> 
> 	CentOS Linux 7 EOL: 2024-06-30
> 	CentOS Linux 8 EOL: 2021-12-31
> 	CentOS Stream 8 EOL: 2024-05-31
> 
> Update the documentation and release notes. There is no explicit
> test in the build process that would block these older versions
> but any bug reports or problems will rejected as invalid.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/linux_gsg/sys_reqs.rst      | 4 ++--
>  doc/guides/rel_notes/release_24_11.rst | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
> index 13d632cec7..8b39dce938 100644
> --- a/doc/guides/linux_gsg/sys_reqs.rst
> +++ b/doc/guides/linux_gsg/sys_reqs.rst
> @@ -53,7 +53,7 @@ Compilation of the DPDK
>  *   ``pyelftools`` (version 0.22+)
>  
>      * For Fedora systems it can be installed using ``dnf install python-pyelftools``
> -    * For RHEL/CentOS systems it can be installed using ``pip3 install pyelftools``
> +    * For RHEL systems it can be installed using ``pip3 install pyelftools``
>      * For Ubuntu/Debian it can be installed using ``apt install python3-pyelftools``
>      * For Alpine Linux, ``apk add py3-elftools``
>  
> @@ -110,7 +110,7 @@ System Software
>  
>      The kernel version required is based on the oldest long term stable kernel available
>      at kernel.org when the DPDK version is in development.
> -    Compatibility for recent distribution kernels will be kept, notably RHEL/CentOS 7.
> +    In addition, DPDK maintains compatibility with recent distribution kernels (such as RHEL 8).
>  
>      The kernel version in use can be checked using the command::
>  
> diff --git a/doc/guides/rel_notes/release_24_11.rst b/doc/guides/rel_notes/release_24_11.rst

It will be for 25.07 release notes now

> index 48b399cda7..447c24237a 100644
> --- a/doc/guides/rel_notes/release_24_11.rst
> +++ b/doc/guides/rel_notes/release_24_11.rst
> @@ -345,6 +345,12 @@ Removed Items
>  * ethdev: Removed the __rte_ethdev_trace_rx_burst symbol, as the corresponding
>    tracepoint was split into two separate ones for empty and non-empty calls.
>  
> +* **Removed support guarantee for CentOS 7 and 8.**
> +
> +  DPDK can no longer guarantee support for older CentOS releases.
> +  CentOS Linux 7 reached end of life (EOL) on 30 June 2024
> +  and CentOS Linux 8 stream EOL was 31 May 2024.

CentOS Stream 8

> +
>  
>  API Changes
>  -----------

Again, I would remove all references to "guarantee" as it implies a
level of support that doesn't exist in the project.

Other than those minor comments,
Acked-by: Kevin Traynor <ktraynor@redhat.com>

