Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1881DCAC58E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 09:39:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70DBD40613;
	Mon, 15 Sep 2025 11:39:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 740224060C
 for <dev@dpdk.org>; Mon, 15 Sep 2025 11:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757929155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rG6nFHnADSurordTi+CwCE43FVoNjLCXW3XItm9F2S4=;
 b=MuuySeIyAhF7ZL9ox4sW8WlckkxpiIAWsQ0TFkwvydOmpZgEVIBQXwxUhJRIkU67YBm2ew
 BVOu+9CmUszVn2zDtnv6qiH/SHwkYdHnRWThSbMM7xoA72yifd4B6XTWcmLoauAsTrSPrZ
 Nku4cFK8yiGWhdpyvAK42hjl/qcO49g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-IhSWLvTxPvehtb8SExU-xA-1; Mon, 15 Sep 2025 05:39:13 -0400
X-MC-Unique: IhSWLvTxPvehtb8SExU-xA-1
X-Mimecast-MFC-AGG-ID: IhSWLvTxPvehtb8SExU-xA_1757929152
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45cb612d362so22052545e9.3
 for <dev@dpdk.org>; Mon, 15 Sep 2025 02:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757929152; x=1758533952;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rG6nFHnADSurordTi+CwCE43FVoNjLCXW3XItm9F2S4=;
 b=kumoICXM1GhYmsdAc2A9cCVCauAOCDrj3xRwwi4opiLa7aNxMqFm/TvdtW4VCvC1HM
 LxeldE663w7D0U3mJFohvuuIecpHMsPN1w/Nnuf+F4GN+CrqK85LB29HqO4ryHVXLP0k
 0wVAdNTtIwaXU6yEeYpvMNeCsLlDI3Gu1jdR6ETrI0UVufgAzKtbYf6uABAELwVcf2hc
 tGEzlcVSkjrLWbXX2+xWqvU8lr375nucXN1K3sRypf7L0DreeWSd7fB54St9Tc7zGLgp
 A3Uc+j2NP/vVh9dlgjBn9CXVzPw87cxuHRyRCK702BF/8c6WVgmdvRI4a7Pf0Ec3Y6u1
 Mx7Q==
X-Gm-Message-State: AOJu0Yx5PnlVVzttxuz7ibzm6u3Jofq3BqBbgzn8vEgSI4R0od4sLdn1
 Hm4Zn6xWUVYA1/VSaXjtR34Us0jyol77L26oQIuyNLk+wTVNpS35jLcO9fETReyED3O50J3PbI6
 6pVRxdM+6ArZX/p9EF4O+gyylfeapTSkWZKUecr/tqalH
X-Gm-Gg: ASbGncv+wm5yeQnbwyCvb4Gr5sKYuImv1fDyUncccqSvca/r/P0otk+T96FCNGsUgGl
 FypV910FZnV0YiY9WLXamVN4PqjXjTPlRKAYvI/rIZgTYzM6GEpDsPso87M9HE+cza9eVptzuef
 mrqYHAm24tClwvVFy/0Y+O7x0d0dGrum5Wn5HMIZ0qWcvWqLzB9iAepTfpR31gVOOZdTxBzglEV
 RqP/wpeF5qGPklS5OCKIEr12iokBkdqvBZ2zg1Azbzyi5IxaZR3aNLfvbjU2UrrNosdeMkAML7v
 oeGYm6FKRboKZiJhvx3AdlCH6wf9epvR+nvfnO5kEb8=
X-Received: by 2002:a05:600c:8284:b0:458:c094:8ba5 with SMTP id
 5b1f17b1804b1-45f211d5735mr112339445e9.12.1757929152066; 
 Mon, 15 Sep 2025 02:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6FHa+SbuMC7uH7TI381O+BksJAdaTUEKkgxx20lIhAiJsL9vaja/KBPa8cZn9bRjtIdMLdg==
X-Received: by 2002:a05:600c:8284:b0:458:c094:8ba5 with SMTP id
 5b1f17b1804b1-45f211d5735mr112339195e9.12.1757929151670; 
 Mon, 15 Sep 2025 02:39:11 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.128.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037c9d91sm167615785e9.20.2025.09.15.02.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 02:39:11 -0700 (PDT)
Message-ID: <d9b7790c-1a71-4438-a9ad-6efc3cf51e7b@redhat.com>
Date: Mon, 15 Sep 2025 10:39:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] net/ice: remove unsupported Rx offload
To: David Marchand <david.marchand@redhat.com>,
 "Loftus, Ciara" <ciara.loftus@intel.com>,
 Luca Boccassi <luca.boccassi@gmail.com>,
 "Xueming(Steven) Li" <xuemingl@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 dpdk stable <stable@dpdk.org>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
 <20250818105914.169732-11-ciara.loftus@intel.com>
 <CAJFAV8wu3jQh2WAY_aUdS-Y1xFMFFtYrGGh_hgbROmMaEpWcgQ@mail.gmail.com>
 <DM3PPF7D18F34A18F628B6488BAB7ADD7608E15A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <CAJFAV8xp1Bckbudei4JFAFAacFYi8wTd50TnWXT0BqFSOMixSg@mail.gmail.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <CAJFAV8xp1Bckbudei4JFAFAacFYi8wTd50TnWXT0BqFSOMixSg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bDYpt-LEZ3h8wF4nIC_Y5-Qhz1femJCH9dEVUNpVPvU_1757929152
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

On 15/09/2025 09:59, David Marchand wrote:
> On Mon, 15 Sept 2025 at 10:45, Loftus, Ciara <ciara.loftus@intel.com> wrote:
>>
>>>
>>> On Mon, 18 Aug 2025 at 13:00, Ciara Loftus <ciara.loftus@intel.com> wrote:
>>>>
>>>> The offload RTE_ETH_RX_OFFLOAD_SCTP_CKSUM is not supported in the ice
>>>> driver so remove the one erroneous use of it.
>>>>
>>>> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
>>>> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>>>
>>> I just noticed this fix in main.
>>> Fixes: 808a17b3c1e6 ("net/ice: add Rx AVX512 offload path")
>>>
>>> This looks like something worth fixing in LTS.
>>> Was it intentional not marking it for backport?
>>
>> Apologies, it was not intentional not marking it for backport. I should have added that.
> 
> The fault is not yours.
> Let's blame the reviewer instead ;-).
> 
> 
>> Shall I submit a new patch to be backported or can this one be used?
> 
> It is ok.
> Just, the scripts won't catch this fix, so let's ping people.
> @LTS maintainers, fyi.
> 
> 

Ack for 24.11

