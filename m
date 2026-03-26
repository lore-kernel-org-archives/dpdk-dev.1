Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE9810A1E82
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 11:50:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8837B42B71;
	Thu, 26 Mar 2026 12:50:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 015D040E1E
 for <dev@dpdk.org>; Thu, 26 Mar 2026 12:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774525837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DE/Fv3IGLoTPOA2db34VKoZu1XGRdlYIkhHQzkcFDS0=;
 b=M7j8dK5VRCguErFwjeEE1jt3TIuk+7PpOmp+/TyvSwTMH7qXlOWbEw24HABCBDenNS9bGx
 N383Vw/kcF/xt4ce4cZhBaoGR1yu5Dehy36+nN5O3Vki1y2szNkE2KtnKeeVOdeh/okKOD
 tAgllVGm/WoOO05smu+uXkN03GPDxyE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-z25ivVQPNXaICo5RevO3Sg-1; Thu, 26 Mar 2026 07:50:36 -0400
X-MC-Unique: z25ivVQPNXaICo5RevO3Sg-1
X-Mimecast-MFC-AGG-ID: z25ivVQPNXaICo5RevO3Sg_1774525835
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48544725bdeso16892035e9.2
 for <dev@dpdk.org>; Thu, 26 Mar 2026 04:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525835; x=1775130635;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DE/Fv3IGLoTPOA2db34VKoZu1XGRdlYIkhHQzkcFDS0=;
 b=me83S8ntQ8IX85TlpDof/+HrluH2BRle0Vn4A0jz4ByaSxUgiuQ0AVJl7MERcsacVY
 z+Cld53QsAnKSVx2tZMyPfX/ngkEbI/fElZlpy8zuRovFhLEKMWzgzH2kO8OQmrylDn1
 5LkIiF1LhAGrL+XOGJ2FJMA2vDR4NiFyD+S1Fv1V+21xJIaqHiahu8A3uP4l1bGYosW+
 WLx3lmYhAKkdH6WvJiEq/DlnuEVWfvEBV1aA0S/T45OHd5Ig9vL0DiA4OWf6x1ZstG+9
 bvk2Z1uqCBlKwgouZtSHKXax3IlEdxRsA7htFGd9iA0uO2ImYje0OOo3bOWJ+yxTnIgG
 SbsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI3bWRcfP3AFksN7XVj5BKfB7dGGy5VaA2pWNAOx/fj19E1vZ0Cm8swQuv4M7W0ZADrEk=@dpdk.org
X-Gm-Message-State: AOJu0YzNkq9Xhzsbl5qjFOChxwfvY98vrDwRqfX17Gh4sXgVulwn5QX7
 ghLnhZQ8XdXtqNbSaLll9LIHrNkbtCaW653SM2jxmtbKv1qOIHRcibxiO/J1g15TKrKH/NpaVvT
 yQkX7v/I4Sii+dzsZlGCZ1/+7dsRQxq0+TVQmI4N3AmIt
X-Gm-Gg: ATEYQzxsNPkJZKw+n4F4ULQssbxgmcQMPngiHPwYREKzkQf0SgaFEO/d6gbNepJdTbg
 zzZvEriu412r2Ujh55UMjTIpwRwFs8Quig2wVal6OyH6HNAdwJcY0j6OLqkTBVBkEhkS67zyYDt
 SbO6pDP13QsEsC2pvi9rhJ+QM/s/Rmb4shSK4NtZfxldMzd3k5ifRckWNeWiQC41Ud+pFKPH/6W
 tScXgN5+r/YtHw2GYcemaCny2dU5xJ1gz6E1h8CsPASUYtKHERj5igszXcEa/zlYswM0/Or1Oa7
 lR9f3V3ITfyD51vckU64lvupqFk49SUc134EZrNEirXuhaYiN9Hzp2wLGF6/Gve3eGIRnSPgRPl
 HAw1Jfskeae+TlF+CmHgqDp+D
X-Received: by 2002:a05:600c:4447:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-48715fd50c2mr105470375e9.9.1774525834734; 
 Thu, 26 Mar 2026 04:50:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4447:b0:485:3f1c:d8a4 with SMTP id
 5b1f17b1804b1-48715fd50c2mr105469995e9.9.1774525834245; 
 Thu, 26 Mar 2026 04:50:34 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c789ecsm25032195e9.4.2026.03.26.04.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 04:50:33 -0700 (PDT)
Message-ID: <b760bb9a-1c4f-4ab6-ac63-9111683761ae@redhat.com>
Date: Thu, 26 Mar 2026 11:50:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] bus/fslmc: fix bus cleanup
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rohit Raj <rohit.raj@nxp.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
 <20260326102424.2361945-3-david.marchand@redhat.com>
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
In-Reply-To: <20260326102424.2361945-3-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ipl98hnphu1Ik4ahDrwV9Q5KD3xHVEL3VgLjYhI2ukk_1774525835
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

On 3/26/26 10:24 AM, David Marchand wrote:
> The close operation was never closing probed devices.
> 
> Taking a step back, reevaluating the devargs makes no sense during the
> close step, as a probed device must have passed the allow/block list
> evaluation initially.
> 
> Since the device contains a reference to the driver that probed it,
> simply call this driver remove op.
> 
> Fixes: 274fd921ff7f ("bus/fslmc: support close operation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> Tested-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  drivers/bus/fslmc/fslmc_vfio.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)

Acked-by: Kevin Traynor <ktraynor@redhat.com>

