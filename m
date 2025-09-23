Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AD7CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 13:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20EAB402E9;
	Tue, 23 Sep 2025 15:08:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 58D1F402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 15:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758632922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j0DZvXB9PPguUBf1IYroTM352KDd4Li+DkT4lC1URbI=;
 b=NQz6tioIb/lGdFom0sisyyk1a9M8H/hKesBb8gf7g97JFEsQaNp/VtaxGWzdczfbuDub69
 c23g57FFi8VOlojmehoZmzzzcMyklhY7uRZ09b4lxUDMfyrNO51E3CrM1mV4IORlOyKnxh
 Ir3kZUSSABEXB7/EjeY006VDvPdj8lE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-NsSMItD0NDaOmD38DwMbrw-1; Tue, 23 Sep 2025 09:08:39 -0400
X-MC-Unique: NsSMItD0NDaOmD38DwMbrw-1
X-Mimecast-MFC-AGG-ID: NsSMItD0NDaOmD38DwMbrw_1758632918
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-40657e09e85so282909f8f.1
 for <dev@dpdk.org>; Tue, 23 Sep 2025 06:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758632918; x=1759237718;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0DZvXB9PPguUBf1IYroTM352KDd4Li+DkT4lC1URbI=;
 b=OK1CzEdVRmxCd3dQV2nqg/bXrZ57vtsa6vnRV743pk9Bq9+dwE4eumlePZtyIcveUl
 60Jy0jJIuffU7l/MuEeHzfkqw66a5IdwVDPaphB/LSlZHIDONJFw8QGC4Z5ITMvlz4x8
 KZAB9442NFDP0/dQpkI9DB9Jo9J8I1If3xs7+NXjnJVGw7VasnEtJrqM/9u7AU0Rw17L
 CibvKyo/x/FCzynjR6Ijo0tLA1t94a4GevEDXTU3ZoZlkMLhDOgamfHBQ2ySN6qoqm2n
 GuncvvqTRHDSGwipfTjKTJJ4/qPFHZm4XqQmd0akNfjLkzfYgL78lXK3KmLk7L/mavlO
 HvtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8+q28EWq8K78i0xgN8mEDGqeH6OuQhEjrGv+ct8Z9kUuHDrkwzM0WtKdPgNRjdrYy2cA=@dpdk.org
X-Gm-Message-State: AOJu0Yy2L42PoPdBOAKQzExyHXv1oIu2S/ccRTM7tjU8Hi+brI4VSTy+
 fhs4+SyjO3TjU6Ec6iWuvMwmX69Sy7FBB/zSdh+MhR1NVwd7i+ps3rxBXT12GCeCbALv0NzHxdp
 QNyzKzjTE7LlztEle43EEUpI43uhMRSf8MkPSoQc1Wz78
X-Gm-Gg: ASbGnctNB65Fe/AsJTLQEfGbD8UE+RVqh1n8F4Lxh400iKDb+HzgU2QH1bAGgegDNQB
 y2Zpi6ViNqI63Z2sB0xiP4OTwzHY6Fdf4riMHFIZs7i9ix8c1yauiL3Z4xUo4b1x1e7RN98hStX
 e1OmEbpHFuOgvLgOcr8lWxhEyJI8ri61lZ5Gou7PytixYT9EAbl/4m/n1tN2/oV5m5VkFt8UmvX
 H3o4rZ68j91a5hfpKpIpu4cDnIQPLLAdXJnZ3aj4b29+SyzSMd6GdCRLwBhFsjLapII1N3vh+sw
 9b48H44PP4TDFDbpKvhefYUlpR+QO4PUMjlmIWmE7Mo=
X-Received: by 2002:a5d:525c:0:b0:406:87ba:99a2 with SMTP id
 ffacd0b85a97d-40687ba9dc2mr1553714f8f.38.1758632918109; 
 Tue, 23 Sep 2025 06:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERkzmbBCzdXlhGCrFzb0vwVABbL0R7D9w2kHedLDCrJMkfqjVYn0m2CWQqku1W4lHnvm3cwQ==
X-Received: by 2002:a5d:525c:0:b0:406:87ba:99a2 with SMTP id
 ffacd0b85a97d-40687ba9dc2mr1553683f8f.38.1758632917610; 
 Tue, 23 Sep 2025 06:08:37 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.174])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d3ab09b27sm95707955e9.21.2025.09.23.06.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 06:08:36 -0700 (PDT)
Message-ID: <4a7059c1-43ad-4df7-a4fb-03ea938e6009@redhat.com>
Date: Tue, 23 Sep 2025 14:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] build: add backward compatibility for nested drivers
To: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Cc: bruce.richardson@intel.com, david.marchand@redhat.com
References: <20250922110708.47879-1-ktraynor@redhat.com>
 <2842623.IobQ9Gjlxr@thomas>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <2842623.IobQ9Gjlxr@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v8c2_etgLsJ1oyhTKgX7ITSQ5Ezo_H29M178i3ArVBw_1758632918
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

On 22/09/2025 16:51, Thomas Monjalon wrote:
> 22/09/2025 13:07, Kevin Traynor:
>> --- a/drivers/meson.build
>> +++ b/drivers/meson.build
>> -# add cmdline disabled drivers and meson disabled drivers together
>> -disable_drivers += ',' + get_option('disable_drivers')
>> +# map legacy driver names
>> +driver_map = {
>> +    'net/e1000': 'net/intel/e1000',
>> +    'net/fm10k': 'net/intel/fm10k',
>> +    'net/i40e': 'net/intel/i40e',
>> +    'net/iavf': 'net/intel/iavf',
>> +    'net/ice': 'net/intel/ice',
>> +    'net/idpf': 'net/intel/idpf',
>> +    'net/ipn3ke': 'net/intel/ipn3ke',
>> +    'net/ixgbe': 'net/intel/ixgbe',
>> +    'net/cpfl': 'net/intel/cpfl',
>> +}
> 
> Should we build this list inside a file drivers/net/intel/meson.build ?
> I'm not sure my idea is better...
> 

Not sure. It's generic as is, so any other driver moved anywhere could
add to this list here easily. Let's see what others think.

>> +
>> +# add cmdline drivers
>> +foreach driver_type : [['disable', get_option('disable_drivers')],
>> +                       ['enable', get_option('enable_drivers')]]
>> +    driver_list_name = driver_type[0] + '_drivers'
>> +    cmdline_drivers = ',' + driver_type[1]
>> +
>> +    foreach driver : cmdline_drivers.split(',')
>> +        if driver_map.has_key(driver)
> 
> I feel we need comments for above parsing.
> 

Ack, will add

>> +            driver_mapped = driver_map[driver]
>> +            warning('Driver name "@0@" is deprecated, please use "@1@" instead.'
> 
> Not sure about this warning.
> We can keep compatibility without saying it is deprecated.
> 

Yes, that is a good point for discussion. Seen as support for the legacy
names were already dropped and I wasn't aware of any ABI like policy
about it, I thought there may be a preference for deprecation
warning/continuing to move to the new name only.

I would be happy to keep the legacy name without a warning/deprecation
for a longer term and we could adopt this as general guideline by
default too. It should not cost much effort to do this.

Another minor point is, if this needs a Fixes tag? Yes, in the sense it
feels like it added a banana skin for users (the patches are because I
hit this issue with 25.07). I didn't add it for now, as no guarantees
were broken and there isn't an upstream stable for backporting to anyway.

>> +                    .format(driver, driver_mapped))
>> +            driver = driver_mapped
>> +        endif
>> +        if driver_list_name == 'disable_drivers'
>> +            disable_drivers += ',' + driver
>> +        else
>> +            enable_drivers += ',' + driver
>> +        endif
>> +    endforeach
>> +endforeach
>> +
>> +# add cmdline drivers and meson drivers together
> 
> This comment is not clear.
> 

I will remove this, it was previously for the enable/disable blocks of
code, but only relevant to the line that was expanded into the loop
above not the below one.

>>  disable_drivers = run_command(list_dir_globs, disable_drivers, check: true).stdout().split()
>> -
>> -# add cmdline enabled drivers and meson enabled drivers together
>> -enable_drivers = ',' + get_option('enable_drivers')
> 
> 

