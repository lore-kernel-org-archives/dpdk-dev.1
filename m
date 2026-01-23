Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44D0D77882
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:57:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC0240651;
	Fri, 23 Jan 2026 17:57:44 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id EACBB40649
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:57:42 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so1544676f8f.2
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1769187462; x=1769792262; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ae2JqFE2CXpJOF83wlRjlcogv8U8gfLu969nuhb8hLA=;
 b=ai3kYSTZHbtluvQo1idL7jhcKwGV/w9G2YGun7h78pXPBKAFq3c56o3o5auHZllT5X
 u0GraI6shMlkzDDHf5irTsXGXT0P2oTLX+c/2vh/VL3oy4HZJrBcwr3QeMmDZBLPQN4/
 3wYdBcU+sZ8Ld9sqavfYA05Qx43Y4RZbooalI0v3awrBfAchRsQwLeZRNRnT390cg3By
 FYt/EPjV6UcJ39QbS3fflx7vxHQutaNA5a3y0CXHIs+r2ho9iTl5qUpw1iGZlbyixh5P
 Toy6AJqtjVxvtSOvBO90uHiix9zVXROYNoAE5pAoCwnKbP2mRWKVOnYZ5pIII9+jRU94
 QvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769187462; x=1769792262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ae2JqFE2CXpJOF83wlRjlcogv8U8gfLu969nuhb8hLA=;
 b=cshJ0UJGM5F9IfceTEQ7pdlgUZNSzhQ6omjHYNbFmSPOCXcQ5Dgn0hT8AodFhYucsT
 mh/gsvgMkgIrgD83ZiTNhFifhDzfNRvpwZ0WeNTV4SEkRO6dV5FNEKf+17GsaQVaH1Bn
 32abg89EhY4t8UYSUcgvZAJN08LI4xITp7y1dH7LrHGXIfaCTB5/wGT6AezGuRCDaK3O
 lkvTHn5M1CkbvwsauXsWSvPdGlpfQ10WVwKwh6QeRFtcPLZSf7INKB63q75NchjxTNCC
 bCb1JO/v6VrZFpn1DzoJJavCSNmCTRLkUGPU850NGt6kzCTgkdlkEeQ1MV0ecIIieEFj
 gcOw==
X-Gm-Message-State: AOJu0YxwxdnWkQW/PtrSFNtKeDNlyhEfqbeso1FqX7yNDsCty1dqBuhV
 deegILHIG3HvgpA7/WqgxNg7MFOhxpJ1FGRJ8ngAaPe5jsLFQtB5SG2FpAGUx89pTw==
X-Gm-Gg: AZuq6aKZxiBtNiU/M6PM20N8sunbFOfrIWznH+UOSI6SgucB5cgOTRR67pUimRdpn29
 JCtKzfsxafYu7Yt1OLnOx1TuuURUdSFI1LBQVxr01Z90QOJYYA0oo63OVD5Qrmcru2ntXHTMcK7
 2r+qwXkJjboahUvaO0pBBnH1OW5NpT0IwxGbZm4/Yp7x73DUYStr70o74vwNPi0wgKsSplGqEP6
 e/CQh7lsCO0mJzZxfi/5+D4aSIVt1EIZswR2idlra76bSWHtaiN/9prkucEqUq78Fj2/7/q6uyT
 c+uJNIEcWstRlECR1tNNe8rHyqc9Fy1EgJz49dp3iexn/tgXP7Q1J2b/5ngDn2Q+vNHtjdFczcv
 Yfgp0vbsMhEclYJWJI0AOSQJ9y80J7YF0KwumviIbZ/doiBdtUX6XNxsUBJAGKeAcH6PeP6ZeA/
 mTMyUa4F6m39Rmqqx5eShJHrEivg==
X-Received: by 2002:a05:6000:250a:b0:430:fd84:317a with SMTP id
 ffacd0b85a97d-435b1604eeemr6673059f8f.38.1769187461952; 
 Fri, 23 Jan 2026 08:57:41 -0800 (PST)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24f15sm8235937f8f.18.2026.01.23.08.57.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jan 2026 08:57:41 -0800 (PST)
Message-ID: <82710dcc-d2f9-4e69-9f5f-ac70135e2333@6wind.com>
Date: Fri, 23 Jan 2026 17:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] drivers/net: reorder Intel drivers list in meson script
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260123162707.1854505-1-thierry.herbelot@6wind.com>
 <aXOm1Xep0eINPO3y@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <aXOm1Xep0eINPO3y@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/23/26 17:50, Bruce Richardson wrote:
> On Fri, Jan 23, 2026 at 05:27:07PM +0100, Thierry Herbelot wrote:
>> After an upstream patch (see Fixes), net_ixgbe_vf is no longer
>> declared in testpmd PMD info, when compiling under Redhat-9:
>>
>>> $ meson setup build && ninja -C build
>>> $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
>>>      "name": "net_ixgbe",
>>
>> Name 'net_ixgbe_vf' should also be reported.
>>
>> One workaround is to move 'intel/ixgbe' as last in the list of Intel
>> drivers. This restores net_ixgbe_vf under Redhat-9:
>>
>>> $ meson setup build && ninja -C build
>>> $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
>>>      "name": "net_ixgbe_vf",
>>>      "name": "net_ixgbe",
>>
>> Fixes: 04f1b16c54f3 ("drivers: merge common and net idpf drivers")
>> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
>> ---
>> V2: use shorter lines in commit log.
>> ---
>>   drivers/net/meson.build | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/meson.build b/drivers/net/meson.build
>> index c7dae4ad273c..8d96244cdbb0 100644
>> --- a/drivers/net/meson.build
>> +++ b/drivers/net/meson.build
>> @@ -32,8 +32,8 @@ drivers = [
>>           'intel/ice',
>>           'intel/idpf',
>>           'intel/ipn3ke',
>> -        'intel/ixgbe',
>>           'intel/cpfl',  # depends on idpf, so must come after it
>> +        'intel/ixgbe',
>>           'ionic',
>>           'mana',
>>           'memif',
> 
> This is a strange one - did you do any investgation into why or how this
> fixes things? You describe it as a workaround so any hints towards a proper
> root cause and fix are welcome :-)

Hello Bruce,

This is indeed a bit puzzling: it seems that the expected ELF section is 
present, a 'strings' dump shows no difference between a 'full' testpmd 
and one missing ixgbe_vf. Still pmdinfo is missing one PMD.

The issue was not seen when using Ubuntu-24.04.

	Best regards

	Thierry

-- 
Thierry Herbelot
http://www.6wind.com/

Follow us:
https://www.linkedin.com/company/6wind/
https://twitter.com/6WINDsoftware
https://www.youtube.com/user/6windsoftware

