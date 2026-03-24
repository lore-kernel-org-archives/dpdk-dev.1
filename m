Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D7F54ABC
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 14:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0A23402BE;
	Tue, 24 Mar 2026 15:16:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5B3914025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 15:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774361815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NM2B03dGKeWmOCBXw0PTBnZ87//G6ZcCROcBVcVbzTU=;
 b=HtCNbt8ODaDsmEbLUKtkZvxvT64kOYInjJkO+d9UmstX974cmYFAEqeXmg2M3riNIPxsJ5
 Kb9JIR7wvlLV1sQpKoie5T804jroifDVSxJfrGBul39yD0Bb4tlDB9JTEC+Nj2DC9ceS1O
 LeyO6xPHPLEdtTmmCFJs0GLYJstYsn4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-fSodgIMfNLWyrSqEen0ong-1; Tue, 24 Mar 2026 10:16:53 -0400
X-MC-Unique: fSodgIMfNLWyrSqEen0ong-1
X-Mimecast-MFC-AGG-ID: fSodgIMfNLWyrSqEen0ong_1774361812
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b86de58d9so337615f8f.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 07:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774361812; x=1774966612;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM2B03dGKeWmOCBXw0PTBnZ87//G6ZcCROcBVcVbzTU=;
 b=Qah+X2CeOe2dG7L0M1wlNEKJMpw96fyZz2tXPngS4MIj0ldI77s8UjqrODy/dy+r86
 Yp4LzE9CNwi8YATfaOAV9fAw7dr9GFBzinXrOwA9b++bs5DcwnT2IkGI4pDk4YWv2gzd
 UKecO7uhNHDkGKfNW/MFjmEstz1v92hy79wnFXC6o5XAKiHK/LwFMRwbkYkWjUw6mHsm
 TDwN9z5HL0wtb/IOVYDxQN5V0o6rYu7w8xp1cDPS2VK4MbU5+6dl13ELsLgdmjjpo966
 qGv96sRUUu2xJnjPlCi/D5jVYNs7aZHxLgFVlh6i0vEJl2GfvwbZeWIaAnSxN9jmtrLO
 zW5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVInrP+Ff5dFrzLHhw+5kxMveYk7GHO8pZXds/LI/3ABS4ylLMohaXS5VtnOBSxgXwZStA=@dpdk.org
X-Gm-Message-State: AOJu0Yy76uHzdoHjvIHrcmF4UDissjnzVn+KJ5FCId0PbqvIchmvVKI2
 Z4TZYzC2mFNscLkbPg7nXnoe767XNECShi/XZevlwK2nPfJu/kHSYEFUfGuoFVrtkN6ZqbTDgOz
 qqjHa3+i6cV+zR9F8feF33ZbQc9YvTv/wZ9t1aR+Vz4aI
X-Gm-Gg: ATEYQzyWyrocC+ASszQ3cQe50TEOwKOdsZnkTVZJ1U3JU0hGl2KY2qCzK4tsvqRFFEO
 B58/XnhwqeBolLyddNhQv2xgk4HvoaLbMVWrHwCNAfGML/0yIomi0fm6zZWZChUsefKAqDPZPM5
 5YsFiN0Jno6yGv2/9qxMQr2kGa5c0r+4yAJqMYnqcMFatfEmEqUHcOFIHJIQXfNzCDsHL3amq6x
 MbgwYJhKNSRcfoTFJ2v4oro/hLmO8gfF3aw1xxLiUZqmq8kqOpt7Dby9rO7A7790XK8YDluGwCN
 3tvhFvaFDIZ2C9j8qi6s0euHl3kDjoUm710chkkIVUJEeVzG6R/jqoDxInyZTcXopVhHgRVJDGi
 vWJR4tiY24N3cPyUwDx1/Vi2z
X-Received: by 2002:a05:6000:26c5:b0:43b:50d6:4f00 with SMTP id
 ffacd0b85a97d-43b64277fdbmr24643691f8f.30.1774361811915; 
 Tue, 24 Mar 2026 07:16:51 -0700 (PDT)
X-Received: by 2002:a05:6000:26c5:b0:43b:50d6:4f00 with SMTP id
 ffacd0b85a97d-43b64277fdbmr24643645f8f.30.1774361811433; 
 Tue, 24 Mar 2026 07:16:51 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd0dcsm37907249f8f.11.2026.03.24.07.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:16:50 -0700 (PDT)
Message-ID: <5329ae6f-e169-4f95-becb-2951ce0bcec5@redhat.com>
Date: Tue, 24 Mar 2026 14:16:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] bus: factorize devargs lookup
To: David Marchand <david.marchand@redhat.com>, dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-6-david.marchand@redhat.com>
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
In-Reply-To: <20260323105306.1531689-6-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X3UhJWCSLQo4P96O4VZLdRTKYr__71k0Iq5LVHnkjcc_1774361812
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

On 3/23/26 10:52 AM, David Marchand wrote:
> Each bus reimplements some similar devargs lookup code.
> 
> The differences are in how some bus (PCI, VMBUS etc...) normalizes the
> device names. We can't use the .parse existing handler from outside the
> bus code itself, as the size of the bus specific device location address
> is unknown.
> Introduce a bus specific helper to compare two device names and
> hide this ugly detail.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> Changes since RFC v3:
> - fixed doxygen,
> 
> ---
>  drivers/bus/auxiliary/auxiliary_common.c | 16 ++-------
>  drivers/bus/cdx/cdx.c                    | 14 +-------
>  drivers/bus/dpaa/dpaa_bus.c              | 41 +++++++++++++-----------
>  drivers/bus/fslmc/fslmc_bus.c            | 34 ++++++++++----------
>  drivers/bus/pci/pci_common.c             | 38 +++++++++++-----------
>  drivers/bus/platform/platform.c          | 17 ++--------
>  drivers/bus/uacce/uacce.c                | 19 ++---------
>  drivers/bus/vmbus/linux/vmbus_bus.c      |  2 +-
>  drivers/bus/vmbus/private.h              |  3 --
>  drivers/bus/vmbus/vmbus_common.c         | 30 ++++++++---------
>  drivers/dma/idxd/idxd_bus.c              | 14 ++------
>  lib/eal/common/eal_common_bus.c          | 20 ++++++++++++
>  lib/eal/include/bus_driver.h             | 31 ++++++++++++++++++
>  13 files changed, 132 insertions(+), 147 deletions(-)

Acked-by: Kevin Traynor <ktraynor@redhat.com>

