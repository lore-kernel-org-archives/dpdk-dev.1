Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA4ACCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 14:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC7104067A;
	Fri, 10 Oct 2025 16:47:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 741BE4003C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 16:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760107646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/ATLdrj7pcB3/p+dF3ArD7pZ3wqpa2ot4DZ3KzzVe3A=;
 b=Gsriaww9ud09zq5HAW1ugrYIrr/2Hr5ZtnC66A1NAGg3mXbS4dSgpb8ndsgqJxeOGb3/Xh
 pdGGNi8AmMwSAtFz3ht3nJUBUbSyix0o1yhs1ja9jk9mV5oHnnX1GnNql0TaNkLmOWbUu2
 mKtCSw4i8gQ7Gt7nDeEeFc1GbkY5VZw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-cV3SxVkoMl2iYZYsWsAYxQ-1; Fri, 10 Oct 2025 10:47:25 -0400
X-MC-Unique: cV3SxVkoMl2iYZYsWsAYxQ-1
X-Mimecast-MFC-AGG-ID: cV3SxVkoMl2iYZYsWsAYxQ_1760107644
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b07c2924d53so231397066b.3
 for <dev@dpdk.org>; Fri, 10 Oct 2025 07:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107644; x=1760712444;
 h=content-transfer-encoding:in-reply-to:cc:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ATLdrj7pcB3/p+dF3ArD7pZ3wqpa2ot4DZ3KzzVe3A=;
 b=ijTGeMr6Rv9bWMjEqFMwZc6QBMmMCXdLaHdyA/4UKwXNhOIr1zx4WMAaijClrTGHNh
 omg6xTOggld2BYvYOQ7KRk8mV2r4RSNjbomqrcJKzg0sqfh/Dg+GRxCty/StC8I6QcCX
 qm6UujuoLwkICunF1IrSSziIzOBJuc4mEZ8QmEykdPRortxfXVr3mKxnQxLAAnBlOX5v
 AWZhg/eVZcKG6b3M5+hL3TRjvBcvrnvBZ1QXd2rQmnYYQ+YqI9Xk43b1gwQEkpyS/sQB
 3ntG3HLISTY2uRSVm1Y5uBoEz3orAT8W/O+nP0dzX7nC7x3wt62+oV6I4ZAxQNU9z5CX
 yz0A==
X-Gm-Message-State: AOJu0Yx72yAJ0eFgrHJeLzikS9VakK3F/oPI2JGOt+rLeGbfkl6h5J9X
 CUfYDSHcPRyyobCLKJOrm9cEpP0W8MtGIu/bJY+5Rzi7bKAQdhgsJSJDG0WwVNIORCKGdBm8XfJ
 myTECstja2twwm2RV8CYDReR07oCIzuBllwsNu+an1Wxu
X-Gm-Gg: ASbGncurIP5x5hBzHmE/tQiawz+bPXDkdLVvk+EmWBrlxcmH8W1YYlizZtb0NXp6fhP
 NkB1DBc6RUWUR0fVKSlAFAn7nRLmYGqlkaDbD+13wUsj6TbpJ3k716vf8qofKgP9moLgkt8GjyI
 6/ZtQslCi5cmKHGJrlRZM9IdbKZeD3fo8zP/byPMMzjVW3R93fFI9OIH0lyP1UvtiR8Tpc6thAy
 1hYWb7PFfvyBlvScFd1DajXkMoZly8cKkcUsgYZyHkpBmfghHBGcOIUX4e0c07im5JtSiX3tzTR
 t61EQrLXOh2tNkK0C3Cy4Tscmo3m/YZCDeOv346WNQ==
X-Received: by 2002:a17:907:26c8:b0:b3f:ccac:af38 with SMTP id
 a640c23a62f3a-b50ac1cc387mr1371295066b.30.1760107643886; 
 Fri, 10 Oct 2025 07:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHhb8X4O1QjX/14BKb5w+d3q8i0a1KmS/eG0TCPw8xk/MvNkdLPZeZqNI9zvKWo3iMh02UZQ==
X-Received: by 2002:a17:907:26c8:b0:b3f:ccac:af38 with SMTP id
 a640c23a62f3a-b50ac1cc387mr1371292466b.30.1760107643488; 
 Fri, 10 Oct 2025 07:47:23 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.128.95])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d900d7edsm244865066b.62.2025.10.10.07.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 07:47:22 -0700 (PDT)
Message-ID: <35718aac-0957-40a4-a0ba-a1eb7a74c32f@redhat.com>
Date: Fri, 10 Oct 2025 15:47:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DPDK/ethdev Bug 1782] net/zxdh shadowed declarations
To: wang.junlong1@zte.com.cn, shan.lijie@zte.com.cn
References: <bug-1782-3@https.bugs.dpdk.org/>
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
Cc: dev@dpdk.org, bugzilla@dpdk.org
In-Reply-To: <bug-1782-3@https.bugs.dpdk.org/>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LfF49Bf7bN2QOOFT6ZUmlXHIOR9BCCDwx8r_c1j_ieM_1760107644
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 28/08/2025 00:01, bugzilla@dpdk.org wrote:
> https://bugs.dpdk.org/show_bug.cgi?id=1782
> 
>             Bug ID: 1782
>            Summary: net/zxdh shadowed declarations
>            Product: DPDK
>            Version: 25.07
>           Hardware: All
>                 OS: All
>             Status: UNCONFIRMED
>           Severity: normal
>           Priority: Normal
>          Component: ethdev
>           Assignee: dev@dpdk.org
>           Reporter: stephen@networkplumber.org
>   Target Milestone: ---
> 
> Compiling DPDK with -Wshadow causes additional warnings about potential issues
> caused by duplicate shadow declarations. One driver with issues is net/zxdh.
> 
> [1528/3627] Compiling C object
> drivers/libtmp_rte_net_zxdh.a.p/net_zxdh_zxdh_msg.c.o
> In file included from ../drivers/net/zxdh/zxdh_msg.h:14,
>                  from ../drivers/net/zxdh/zxdh_msg.c:17:
> ../drivers/net/zxdh/zxdh_msg.c: In function ‘zxdh_add_vf_mac_table’:
> ../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of ‘addr’ shadows
> a previous local [-Wshadow]
>    94 |         uint8_t *addr = ZXDH_ADDR_OF(typ, p, fld); \
>       |                  ^~~~
> ../drivers/net/zxdh/zxdh_msg.c:1441:17: note: in expansion of macro ‘ZXDH_SET’
>  1441 |                 ZXDH_SET(mac_reply_msg, mac_reply_msg_addr, mac_flag,
> ZXDH_EEXIST_MAC_FLAG);
>       |                 ^~~~~~~~
> ../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
>  1428 |         struct rte_ether_addr *addr = &mac_filter->mac;
>       |                                ^~~~
> ../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of ‘addr’ shadows
> a previous local [-Wshadow]
>    94 |         uint8_t *addr = ZXDH_ADDR_OF(typ, p, fld); \
>       |                  ^~~~
> ../drivers/net/zxdh/zxdh_msg.c:1462:9: note: in expansion of macro ‘ZXDH_SET’
>  1462 |         ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_SUCC);
>       |         ^~~~~~~~
> ../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
>  1428 |         struct rte_ether_addr *addr = &mac_filter->mac;
>       |                                ^~~~
> ../drivers/net/zxdh/zxdh_common.h:94:18: warning: declaration of ‘addr’ shadows
> a previous local [-Wshadow]
>    94 |         uint8_t *addr = ZXDH_ADDR_OF(typ, p, fld); \
>       |                  ^~~~
> ../drivers/net/zxdh/zxdh_msg.c:1468:9: note: in expansion of macro ‘ZXDH_SET’
>  1468 |         ZXDH_SET(msg_reply_body, reply_body, flag, ZXDH_REPS_FAIL);
>       |         ^~~~~~~~
> ../drivers/net/zxdh/zxdh_msg.c:1428:32: note: shadowed declaration is here
>  1428 |         struct rte_ether_addr *addr =
> 

Hello Junlong and Lijie,

fyi above. Can you register in dpdk bugzilla (https://bugs.dpdk.org/) ?
Then I can make you aware of any reported issues without having to send
separate emails.

thanks,
Kevin.

