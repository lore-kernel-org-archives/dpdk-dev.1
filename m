Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EE8CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 13:38:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CEFE402B0;
	Thu, 21 May 2026 15:38:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 24EE44025E
 for <dev@dpdk.org>; Thu, 21 May 2026 15:38:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779370695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TzDeUUEaj11S5zGjgIuDiFvCTnaJQTECRQM0JNt/5/g=;
 b=diDjt+YT4vt6AZVtqXU8dUQOqU6R3QsmiGEQQ4oxhYWLXC3zNUnQozoINz7/Jrp5DeToro
 0w9Tt8obR33/OIa0zaQDpbcjkKIIevP5VyaXDERtSr6kMfTzt2/O4pCJA/NmSSksQ3qJPi
 knSNOvLT8fPzylyLucdZ8bKWGbMtXyY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-GMfXeoBBNnWxuBlodNug1g-1; Thu, 21 May 2026 09:38:13 -0400
X-MC-Unique: GMfXeoBBNnWxuBlodNug1g-1
X-Mimecast-MFC-AGG-ID: GMfXeoBBNnWxuBlodNug1g_1779370692
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45e78dd7baaso4752405f8f.0
 for <dev@dpdk.org>; Thu, 21 May 2026 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370692; x=1779975492;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzDeUUEaj11S5zGjgIuDiFvCTnaJQTECRQM0JNt/5/g=;
 b=ar5h50/EDfOM8UOqOyTM18Y1ed/MwZnSOTVg4Z2RBSZj/kZAWuBQNeYMMnlazrdBzd
 pv19TK3n3/1iuCrV1KEbtUj90eHFnUFfomlJU4pQ+pB/SY7PrrORaI9Sy6By8BZEzLYf
 bzzVFPFAc1x7KRPMT7JyTOHSK2uD6eWUkDkalMB9w6wOhw8gGWQ/TGuQtI2Vo8pGWr/r
 4v7/N1hSvo0lAWAUbLXSQ96cXfW00O0EK1V207TAtesmR8xdcYs6OgRtrm+RuCVj4GIO
 DyOE8bZglga2GtBNmsDy82lOJ4lOvsoohgkYPcrw2xQ3ZKqjRZ6kAZ61IPZ8GDMXwhxH
 kXkA==
X-Gm-Message-State: AOJu0Yw8PEVBSvAknwhhUOvZ+2NuIIMQQ/C67Q7aj8uZ+f2mnGBNU+by
 JXhAlf+2/kX7rg+JFMRgW4Glmhnmk+46nkrq2Ptp5ZDgfI46NgWumSupooLu/Y7gKabrP/pN5yy
 LKhp5jUb2ycNm95fbWoDccsgKTs3dBRR0SpT4Hhcz2tHj
X-Gm-Gg: Acq92OFmDOtRbj5j4wWLHxVOEyR8AFa3q1e2o1/6K65i8pwjLBniasV1Q91cgRyuh52
 OgE+x2oPvELKHTQEFUFSPsmx+AgDdeSdbCEJmPUBUtrjyJ/xsaW+UCc11Q6HuP61WVKHpDiDtIo
 HOPf9aB6Xv0hPE0dGR6U/rE/Sm6T0TArbU4M3f5+Ri7Aulces8IkraaCbuU10ULCy41hZutrqlw
 Bpo1YURcfMXioibcag0ty3t8FU3mgI6zNdWz2nZK9Yqzjo+4o7NXcJXB6Q02AVxEMafQg/IdK/A
 Lx8Zm95OPdbgscELMpDSiugdVD3bAQ+PSkmD5spvmIm9C/TzKxaBhANUTceCfE6CSmnlFW/HQDn
 ZRsACs6X8zbR4DnWs+OOiAw==
X-Received: by 2002:a05:600c:42cc:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-4903604ce1bmr30449745e9.4.1779370692484; 
 Thu, 21 May 2026 06:38:12 -0700 (PDT)
X-Received: by 2002:a05:600c:42cc:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-4903604ce1bmr30449435e9.4.1779370692012; 
 Thu, 21 May 2026 06:38:12 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3515asm75449185e9.1.2026.05.21.06.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:38:10 -0700 (PDT)
Message-ID: <37a1af72-6118-47c8-86e3-4d1b0de4f056@redhat.com>
Date: Thu, 21 May 2026 14:38:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v5 2/5] net: support multiple stacked VLAN tags
To: David Marchand <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-10-rjarry@redhat.com>
 <CAJFAV8xdkhcmY53VRJf3qbsVsYB-hM3DaxMxr=GS5MNvb1MPGA@mail.gmail.com>
 <DINGHEW3M9WT.3F4XUUTLNKEL3@redhat.com>
 <CAJFAV8yTyFoWYCNhzcJUBM=DdTDz4qQaN7-=m9_HGQeTc3P0eg@mail.gmail.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <CAJFAV8yTyFoWYCNhzcJUBM=DdTDz4qQaN7-=m9_HGQeTc3P0eg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xXKJIZourxHUCswLQzi3SeMDrZ8JTzh0Bu3oWc2P00A_1779370692
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

On 5/20/26 1:42 PM, David Marchand wrote:
> On Wed, 20 May 2026 at 13:09, Robin Jarry <rjarry@redhat.com> wrote:
>>>> -       } else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
>>>> -               const struct rte_vlan_hdr *vh;
>>>> -               struct rte_vlan_hdr vh_copy;
>>>> +               if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
>>>> +                       pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
>>>> +               else
>>>> +                       pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
>>>> +
>>>> +               do {
>>>> +                       vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
>>>> +                       if (unlikely(vh == NULL))
>>>> +                               return pkt_type;
>>>
>>> Kevin noted that it is weird to report back some packet type when the
>>> packet is malformed.
>>> Maybe return RTE_PTYPE_UNKNOWN here so that the application is forced
>>> to validate the packet? (it should already be doing it, in any
>>> case..).
>>
>> If we do this, we need to fix it in the entire function. There are
>> several other places where the "current" value of pkt_type is returned
>> on error.
> 
> There is this point and the code has been behaving like this for
> years, so some applications may have been relying on this behavior.
> I don't mind leaving as is.
> 
> 

I can agree with Hyrum's law :-) https://xkcd.com/1172/

