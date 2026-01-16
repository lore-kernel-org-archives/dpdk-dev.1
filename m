Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3176D489A3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 13:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F7D342DC3;
	Fri, 16 Jan 2026 14:11:12 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 5F863410E3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 14:11:10 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so1133188f8f.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 05:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1768569070; x=1769173870; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vvroZaaDrsSTfprS0rIvx1wCJp41jozPCVKwPno28Q0=;
 b=GC2ZLAg3oHpQ0TXgBwzBTrvIB9D2sCF4hyoKV95ST3fUA4qS2oa+8kRLwtEoJBa9nD
 vf30Uhl06pimC4ytc1/DpD5/M24Aj4WVgeR0lp6Whagc9DEY3446nDW4W0tv8NUdQmeE
 HpIQNKanL8zqLC68Lr3F2HFLPCx5sSxeGvf5qB2nBin23Ttu1NjAAsiiTTvQ0BFRE0gm
 HmNiDktE2oLQEQr24SGFS2U5j/iscO7QfSNIxGXAMzmeOnxBhPoW5+mvZ2kuq0sp+tWu
 oe/1qcorecWdyly0dHMYK1xdUOswPnOHBxMOnaik350XigrqQq5oSjaULvUlNxAuLW4b
 1FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768569070; x=1769173870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvroZaaDrsSTfprS0rIvx1wCJp41jozPCVKwPno28Q0=;
 b=tMcO0r6kpetDjpyRkwV/Y3KFJBV9XwXUFKZBIJJwySwCEx4cw+b+G3QUF7wXtinQT6
 ej+uX3Cy6SlAgcWZ5Y6TmUFHD4wH8hB1FofgJjg8Bd0Kd26ZV/6TVpziBOrqbzMp7t8/
 8+ySsAfVcRfORHCwMb+PSw7/POHIi38XoiG/ztwNeyWxwp928mkWobElT7KuNY+9dn0l
 khnUHetNYnHcWDSrJBt3uS3YpTr4am7UxFqYg8dLMX3l/i1oakFWidAnvHlSGyG45nhz
 CMm5i81tUjQzRbsW4wV2POy9eF6IbUfPO8X1t0Lu37fH1eB3CezaZxIsQ86XZnA7fA8c
 dQEg==
X-Gm-Message-State: AOJu0YwWa669QVlDEaCRtgJ+c1Kvh0cvlc3uSIvd91vuUT32IMLphp9A
 3w/snpRdFp0ZEUf9tD4Ir39oAp1HWDNGnmzl4zgqPmx8npzfMhE2VfCOpYIE9ZlZFg==
X-Gm-Gg: AY/fxX6DvIknmk559Gfoi8uc0HgSPrwQaYjdsgXCILG8CWl5Q8TssIoa0MvwV8b3BMG
 iEkSh4a6HPw6tjMylWwbktaiwiKRYi/Uv88lKZ9jDAX2s/n8PtR43BXJ+kCzvLUJpo/X4yANNED
 dQPcP7v7Rr5IhDitlhGu0Oel1vHhTxRf3b357Ae038ITEK/oMN4ox88MlWqAhJW8C+DZCqnAuhJ
 Y2o6viFXLThv5OyZQYIsWkwDgK64k1tr7qRVmuQ0UnQXNhPKcaWR+QvP6XQ7b4we1sQhT8dA++H
 TD4nezKlxp9fnD56qaamFWh/+NlEJuYj5o3UhUcz4V4PvBat6cJp/7dOHWfgPZNrZOG91rYKdAV
 l+mU3KUKleqXMJ0GxZjVfX+5Mio4Tt0K6qgxjxId9RoxTJhbHET9GdMaeE9bCwuGwj0r+7EY/mC
 UnbBTRNi+tB7frIIlin3YUmTEVeQ==
X-Received: by 2002:a05:6000:240c:b0:430:f718:2388 with SMTP id
 ffacd0b85a97d-43569972efemr3191809f8f.8.1768569069638; 
 Fri, 16 Jan 2026 05:11:09 -0800 (PST)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992211dsm5218633f8f.7.2026.01.16.05.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 05:11:09 -0800 (PST)
Message-ID: <143c8136-5b87-44aa-9205-d4779af3175b@6wind.com>
Date: Fri, 16 Jan 2026 14:11:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/intel: update key_len when getting RSS key
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>
References: <20260112135311.2507243-1-thierry.herbelot@6wind.com>
 <aWo24YKyq18oV-g3@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <aWo24YKyq18oV-g3@bricha3-mobl1.ger.corp.intel.com>
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

On 1/16/26 14:02, Bruce Richardson wrote:
> On Mon, Jan 12, 2026 at 02:53:11PM +0100, Thierry Herbelot wrote:
>> When adding the i40e PMD, the rss_hash_conf_get function was changed to
>> update the RSS key len.
>> The corresponding functions for ixgbe & e1000 were not updated to
>> follow the new convention.
>>
>> Fixes: 8a387fa85f02 ("ethdev: more RSS flags")
>> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
>> ---
>>   drivers/net/intel/e1000/igb_rxtx.c   | 1 +
>>   drivers/net/intel/e1000/igc_ethdev.c | 1 +
>>   drivers/net/intel/ixgbe/ixgbe_rxtx.c | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
>> index cdd7a3338f61..d5c2bc013702 100644
>> --- a/drivers/net/intel/e1000/igb_rxtx.c
>> +++ b/drivers/net/intel/e1000/igb_rxtx.c
>> @@ -2042,6 +2042,7 @@ int eth_igb_rss_hash_conf_get(struct rte_eth_dev *dev,
>>   			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
>>   			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
>>   		}
>> +		rss_conf->rss_key_len = 40;
>>   	}
>>   
>>   	/* Get RSS functions configured in MRQC register */
>> diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
>> index b9c91d2446c0..9f6ada3bc6cd 100644
>> --- a/drivers/net/intel/e1000/igc_ethdev.c
>> +++ b/drivers/net/intel/e1000/igc_ethdev.c
>> @@ -2559,6 +2559,7 @@ eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
>>   		/* read RSS key from register */
>>   		for (i = 0; i < IGC_HKEY_MAX_INDEX; i++)
>>   			hash_key[i] = E1000_READ_REG_LE_VALUE(hw, E1000_RSSRK(i));
>> +		rss_conf->rss_key_len = IGC_HKEY_MAX_INDEX * sizeof(uint32_t);
>>   	}
>>   
>>   	/* get RSS functions configured in MRQC register */
>> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
>> index a7583c178a14..a2c5ffe0b3b0 100644
>> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
>> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
>> @@ -3756,6 +3756,7 @@ ixgbe_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
>>   			hash_key[(i * 4) + 2] = (rss_key >> 16) & 0x000000FF;
>>   			hash_key[(i * 4) + 3] = (rss_key >> 24) & 0x000000FF;
>>   		}
>> +		rss_conf->rss_key_len = 40;
>>   	}
>>
>    
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Code is correct. However, do you think it would be better to use
> IGB_HKEY_MAX_INDEX and IXGBE_HKEY_MAX_INDEX in those driver assignments? I
> realise the loops don't use them, but they probably should.

Hello Bruce,

I will resend the patch, using the symbolic constants, as suggested.

	Thanks

	Thierry

> 
> /Bruce

-- 
Thierry Herbelot
Senior Software Engineer
http://www.6wind.com/

Follow us:
https://www.linkedin.com/company/6wind/
https://twitter.com/6WINDsoftware
https://www.youtube.com/user/6windsoftware

