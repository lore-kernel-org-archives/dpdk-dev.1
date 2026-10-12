Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB0FCA9EDE
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0245540272;
	Mon, 12 Oct 2026 20:52:43 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 397A14026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 20:52:42 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so18291535e9.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791831162; x=1792435962; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2hoS8W/rogQubEGWDymmsFTI77rm0rNQVvJWd0RKxVw=;
 b=AobUpHiUfwgh1R5MOOhImGzkUDzkg3Os2FcRnwqBVlMwwNacmh0eQxHCswilPl8kfO
 iCbLX1Skk2eXRVoeEXWoAVfD0lcd7jZULmCjJ3npoqrxdPmGKStJ20ZdC+5rMJ1nx2VJ
 /3+jH9Z87fbfpUp0LRlkadZpk330l8Fy8P6xZx02jM8FeaGDHYW7m1dBO686ZaptRrPh
 JaLXpmdA6fuIQ7QS4GFd6ObpW/VzLDv87GQkN47cYD+7GzMpo3OMdxcvyirjo9Aoecp9
 RREOV7MdBOeVd1KwXfk64a2k4DRt5eocOYTYX9FusTtX0v/EC3y7zivMigfYRjtRF4bj
 S01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791831162; x=1792435962;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2hoS8W/rogQubEGWDymmsFTI77rm0rNQVvJWd0RKxVw=;
 b=nexxHvE9gS22/qL5+uTcg2E4+BxJzOsrXW6DB2ZrkGruiag6i/6htWXw3M+/8qCfwo
 qeXlqWcsg6ZTaZvnA+X4sWyRrao3IcbCDITkYyrzo2Ehao/4mQizAJ38X5Gjh83m1hFh
 tIzMeG0BKnTK01/IYHfICcL8ajWYz74ToVsP2+FQp1UtP0XCQQvvzBqdjUJxA9UdrXG5
 iiuyjGDEihn/cTZ6YaZA4CP8ttEEXKl8NQB4gjQL/LmlFJChsarU4IpA8zWGzXqdRKRf
 M8Otdjr7NERUhLUsCtHMfHXmSklizTjjs5blo1jEVg7mB4NwF1+QVSJw7IlzCyDvcAo/
 ZjiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSNLaM4t5qRgw5GWWA064oukUO87qgeawOhrGn/pBi4zgcP1CnoS2/Lk6b8T1DBsFd50Y=@dpdk.org
X-Gm-Message-State: AFq9FYLM/b3iDf8OeTWVqKQs1wTvq/zAgaOZiOoDmPbPR8deGQDsUTcu
 SLDxoNnjl4Jo0+0O6Aa8VLM5Tlb9qexv7L4bRnFjbJQt0Ayewn9uyGZL
X-Gm-Gg: AYBFou3tx7RP9a6/vRN2HlAMRJxD8jA86ZWdvn8oIGkkTOCk04i8YlV/Mw7jmKpHMKi
 R+rHuy/moYLAuhGc6hFVBvhdCL8aSCjYluPY4sVvisCVSRDAlq0OWxEKH6H+EAQnYymEdRa0GML
 44mDCgbNrrTLsDt2EtX0iLkKS9XD6BsED0XorwgvPkdk7ZotQvvqWlFq85kzSAYaoIPNPDI8Xj4
 FhVodY7oUHUANCEtOp8PRgia5t2/JYBozn9SQ0amOHrBL+7Qi1SYjKPIEAKWaPJzkJOfvcfmhyR
 vmSQbDXQtMVdwwh/QFZxNFeEdcNodUzfc9wkQCITt9a8BA8mw5Zw5dgOlTKaArq+mEclrPMYa98
 oOzXffCwUO6MHWIFf/pDcUEE20kGeGQd8HhBVBBDdIeSJfmnB+OuTwxNbNHPyJhOpbgIPZ2IKjD
 8grr0G430LppU2ycygJCHJAo5QkdVcDWI3+0d5Y4MXHT8drnejd9+xSLVwKiF57pxD+0s=
X-Received: by 2002:a05:600c:4ecb:b0:4a1:6916:798 with SMTP id
 5b1f17b1804b1-4a18e4a3f69mr196573145e9.14.1791831161496; 
 Mon, 12 Oct 2026 11:52:41 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.48.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e49792bsm491124605e9.4.2026.10.12.11.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 11:52:40 -0700 (PDT)
Message-ID: <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
Date: Mon, 12 Oct 2026 19:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
To: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 09/10/2026 07:05, Wathsala Vithanage wrote:
>>   /*
>>    * Marks given callback as used by datapath.
>>    */
>>   static __rte_always_inline void
>>   bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
>>   {
>> -    cbi->use++;
>> -    /* make sure no store/load reordering could happen */
>> -    rte_smp_mb();
>> +    rte_atomic_store_explicit(&cbi->use,
>> +        rte_atomic_load_explicit(&cbi->use, 
>> rte_memory_order_relaxed) + 1,
>> +        rte_memory_order_relaxed);
>> +
>> +    /* full barrier: count must be visible before cb is read */
>> +    rte_atomic_thread_fence(rte_memory_order_seq_cst);

NAK: optimizing this increment makes little sense when more careful 
analysis shows that it can be simply removed.

I highly recommend keeping this patchset dedicated to removing 
rte_smp_XX barriers and moving other bpf_pkt.c improvements elsewhere.
