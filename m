Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E79CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 13:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36A65402E9;
	Tue, 23 Sep 2025 15:09:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 65AC8402E9
 for <dev@dpdk.org>; Tue, 23 Sep 2025 15:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758632962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iImsVoEUzfWqzeTJSxh1n1pTKlQ73tec81ryuilXAPI=;
 b=aZvg3cE770WLTA3CY/brLubnOXm+AbbN+TVPvndmZ0tjvxJWMfDXyenIZA9exx38WArz0C
 TIsOHr3FK8sI8qNIc231ZWhPfclQrchvzwCmZ7SchTZU4u0mDV0GviniXetEmIcEj8zaP6
 q/PJO36heK4vkw5OV90L+DRlrjciRuw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-x-CyBqoXM4GyfideBLwfHw-1; Tue, 23 Sep 2025 09:09:21 -0400
X-MC-Unique: x-CyBqoXM4GyfideBLwfHw-1
X-Mimecast-MFC-AGG-ID: x-CyBqoXM4GyfideBLwfHw_1758632960
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3eb8e43d556so2826182f8f.1
 for <dev@dpdk.org>; Tue, 23 Sep 2025 06:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758632960; x=1759237760;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iImsVoEUzfWqzeTJSxh1n1pTKlQ73tec81ryuilXAPI=;
 b=nv907lefMD+TVgp7MmUUcTlIveF/g5zHljE27TNz7r/5kP8zdZhlWk9r0RMIa8AiUB
 SABWfJvKH4B0IlJtnoC/IXCd/GJK/lg3v4UMgYIfe4/Kt6esFJSqjtABQ9FfYwdJW63b
 m0Xjel649K/Cpz2N55H3BwbRxCC+Mtsh+nlTjmgrVYW6V/Vm/F58o1BH8Y/wJqsLMRbe
 6L/oteYOaTH7SGMXEM0fIMvDb4SXgCudCyXoD6VvGXj2p/9cgBBk4BsqFdn6M3Zjouxy
 XNDJgnRKXY/2fkSwh/WUpI09ywdlUxO6HuTGAi/Eks7OW5zEn1ed58s2lWqfgoV9sMWz
 84Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5bvVuKzEPQUB5ah59fiYbsQVsop8fIhcgka165aXcaP04HlRtMe+MW3Dedf3p+2v49ko=@dpdk.org
X-Gm-Message-State: AOJu0YyH2+P5Gsgf09TrQAxq5tZUjiunaD3ifcGmljHYR9RId/50HO4+
 d3HIuxi/VxhFxw5wVtppyufyt6xfUhCXyJNuVhqsbYAxxFB/ikfBNFyGItU9xxTedNwJuLUPIMU
 OIm714S1i5hlq0FJBlU11UgWh+/SqsET2XE0i1f+xJ95P
X-Gm-Gg: ASbGncus7szxOBvinYdkw8qTmaKcEYm0QaPQbfMoj8z0yeCCz+Zo/cfIPyVkOOrhw6y
 JxQPS/qrhK5EdI0VY25yL0OelIzrWAVzaNZwRDVSDdEtEFKTWcIa0xdJC0sgoE1R76S+zhKxwsT
 ydZv7sr6I2wZGVXyI3+QCGTy2Zam+EpXV6ZVHWpJTp5cO/GU02tmk2le0tOlGWaGniL31KFylNJ
 siYzy2tzZvXzL5XafTmhO/HUF0ltF9qKxkGAG6VTpqQ0SGS8z00XtOS5GsN/gYLN9Mmj+hARv4u
 y1GB+EgTMC+j9nQUD2qTazBuYZirzWELcLH2iZjQ7MA=
X-Received: by 2002:a05:6000:1acf:b0:3f3:97df:a2b9 with SMTP id
 ffacd0b85a97d-405d28ab596mr2481442f8f.24.1758632959928; 
 Tue, 23 Sep 2025 06:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtOIWY9QbpdD+pPSKi0Gt9IZt+yrx7O+oPV466QJXLnvPkuw4ysHoOXs9OTOHk8/oChV8OfA==
X-Received: by 2002:a05:6000:1acf:b0:3f3:97df:a2b9 with SMTP id
 ffacd0b85a97d-405d28ab596mr2481414f8f.24.1758632959536; 
 Tue, 23 Sep 2025 06:09:19 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7478sm23804064f8f.38.2025.09.23.06.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 06:09:19 -0700 (PDT)
Message-ID: <3e90d7b4-ed82-4c9b-81bb-9dbf069ca39a@redhat.com>
Date: Tue, 23 Sep 2025 14:09:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] build: add backwards compatibility for wildcarding
 nested drivers
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: bruce.richardson@intel.com, david.marchand@redhat.com
References: <20250922110708.47879-1-ktraynor@redhat.com>
 <20250922110708.47879-2-ktraynor@redhat.com> <8866794.lvqk35OSZv@thomas>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <8866794.lvqk35OSZv@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: klAt0bC5ePcidxtKsMez4j4StEF9fiULr1T5-TuIoxc_1758632960
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

On 22/09/2025 16:52, Thomas Monjalon wrote:
> 22/09/2025 13:07, Kevin Traynor:
>> Up until DPDK 25.03 'net/*' could be used with meson options
>> enable_drivers or disable_drivers to explicitly enable or
>> disable all net drivers.
>>
>> In DPDK 25.03 commit
>> c1d145834f28 ("net/intel: move Intel drivers to a subdirectory")
>> moved Intel drivers to 'net/intel/*' and 'net/*' no longer enabled
>> or disabled the Intel drivers.
>>
>> Expand wildcards handling to include nested drivers.
>> e.g. 'net/*' will also enable/disable drivers in 'net/*/*'
>>
>> This adds backwards compatibility so that so that 'net/*' will
>> continue to enable/disable Intel and any future nested drivers.
>>
>> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
>> ---
>>  drivers/meson.build | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/meson.build b/drivers/meson.build
>> index 3fbf04e1cd..ccd25e4d18 100644
>> --- a/drivers/meson.build
>> +++ b/drivers/meson.build
>> @@ -58,4 +58,9 @@ foreach driver_type : [['disable', get_option('disable_drivers')],
>>                      .format(driver, driver_mapped))
>>              driver = driver_mapped
>> +        elif driver.contains('*')
>> +            if driver.endswith('/*') and not driver.contains('/*/*')
>> +                # for wildcard add nested wildcard
>> +                driver = driver + ',' + driver + '/*'
>> +            endif
> 
> The special pattern ** does not work in Meson?
> 
> 

I will check, thanks.

