Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4636AC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 14:05:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53C964028C;
	Wed, 30 Apr 2025 16:05:28 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id E750140280
 for <dev@dpdk.org>; Wed, 30 Apr 2025 16:05:26 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22c33ac23edso68147285ad.0
 for <dev@dpdk.org>; Wed, 30 Apr 2025 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746021925;
 x=1746626725; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcNi5Y58gGk18u0g4ImgzQsH1dpVFAp+sz3fQ8Ikic4=;
 b=AvKRjf/vFUmcq0gX6XT1J2NrMuBCu7ZAAawMztmPiSgU9YLXetqnie7IEfJ6TAJ26+
 db2oFcS4zaoFpoP9KputIixEvhsi5JSiETVPx7WcV83LztC1mQAosGSSi4WfvjrM2hYy
 Za/P+0rMwBKi43j/Cfr/UWsx6nB/YDMIKJjLWhI7Y0jT3wO1SQoFVqu5SCEA0vUY403C
 8n66+3gbWZPIVhd4hUnCAt5OWMKTLy9wUh4nuhyxdfletTa2bTBMXgjZT7W3mPwMC32A
 8JAPR4NOigq+cUKROvRfQ2eKNPfVBd6eizMUO1GBcSocwxu1oPKFxNqaI0PwIcC8IzNU
 VTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021925; x=1746626725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcNi5Y58gGk18u0g4ImgzQsH1dpVFAp+sz3fQ8Ikic4=;
 b=EC/Zfsb1VAlTJHteBsdMeI9q3dCpUwVsPgQ3WxeqWymYicOUo6pxQb6LUFuM58ZIdj
 vKSv9a9udpEQma2gtA0yTFgc5VHCv2AJcX606Q5fjQ2VFFZ8pH6B9bTE0SsVezO7c2Bn
 pgM7B7ss0HkZnYw2RVYBFWs8eLgmt9Ndo4TWyBw2aBs7Wa9wPl5Q3+MsmN7uB0FCjjfi
 qwXserz6KZyMQ9PS9lWd0nrq0bDoeNDBUDmF/Tzoi684D5uAoC3qg/mOYPbBvQOOy9UK
 xIqckqp5vC1CGqlw7kubYnt0pF3nmNbFDv/UEQJI1SFrpI0QbzoBiTthu9HCL0iggtX/
 IR4Q==
X-Gm-Message-State: AOJu0Yyyc419UhIxhm3o27hqqkHCemnOMBTWu469qb2EaHHfmKIf28XR
 8tK7cNZR8qAQmtsxzq71puyJ4yO5PDHPzKCXoZSxcYqkLok6Xi4DPbVLzCsJ0B30dhJCfH35LVE
 Z
X-Gm-Gg: ASbGncvoBHA1No40L2IDAC/mrlX7c5xVs7i3ZDv0NZ6ntoyevwY5PWSCq3LpAcckrdQ
 3hbz5iUJ5hzCtk3QnbvdEE3jnwlzyAef2fPMsfA7xo30kqmGb3JKFsYafzdjOV09fp0Qm0tH9k5
 lzSzyUknkA6O1tMsQV7NOcHm+OOFjfPR7wWYhs/bNb2ogRVDHkh2oMSR9Hi0aJFIOUI3kTobZKe
 LL7QWtv7gaxgfTyNbkV0n8YjSo9HvIdmexU/0LJIpHUU9uuTH/jmDCyiEy9AN5LgmikP54+gpDI
 MHTyJngxoXm30zToW5ZlNmcVsvEPpiHtUONFipcgmckucdRl4W82HtpfnrKCYyfruvA3gfzWe89
 A50i09/fOQbAkWxkK
X-Google-Smtp-Source: AGHT+IHh2DfDRIPwZ6hnrFDs0/tNkZIALqaHvOAcX0d2/Guc++55OMtcoOmtb1Fv94PZ5XKd0x/yjA==
X-Received: by 2002:a17:902:cec5:b0:215:acb3:3786 with SMTP id
 d9443c01a7336-22df34d5d89mr51857435ad.19.1746021925380; 
 Wed, 30 Apr 2025 07:05:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db510219bsm122459295ad.165.2025.04.30.07.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:05:25 -0700 (PDT)
Date: Wed, 30 Apr 2025 07:05:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oleksandr Kolomeiets <okl-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, sil-plv@napatech.com,
 ckm@napatech.com, thomas@monjalon.net, Danylo Vodopianov
 <dvo-plv@napatech.com>
Subject: Re: [PATCH v1 24/25] net/ntnic: avoid possible deadlock
Message-ID: <20250430070521.0249e86f@hermes.local>
In-Reply-To: <20250430134840.402553-25-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
 <20250430134840.402553-25-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 30 Apr 2025 15:48:36 +0200
Oleksandr Kolomeiets <okl-plv@napatech.com> wrote:

> From: Danylo Vodopianov <dvo-plv@napatech.com>
> 
> Sometimes during  high flow learn performance two threads
> could cause deadlock using queue and mutex.
> 
> learn_ignored variable sets when flow learn and gets
> when flow removes. Hence, learn_ignore should not be protected
> as far as two thread could not access to the same flow
> at the same time.
> 
> Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>

If you are going to do this, then you need to use rte_atomic_store/fetch.
If two threads read/write same variable outside of lock, need the CPU
to use special instructions on weakly ordered platforms like ARM.

> --- a/drivers/net/ntnic/include/flow_api_engine.h
> +++ b/drivers/net/ntnic/include/flow_api_engine.h
> @@ -297,7 +297,7 @@ struct flow_handle {
>  	enum flow_handle_type type;
>  	uint32_t flm_id;
>  	uint16_t caller_id;
> -	uint16_t learn_ignored;
> +	RTE_ATOMIC(uint16_t)learn_ignored;

The preferred spacing would be:
	RTE_ATOMIC(uint16_t) learn_ignored;
  
