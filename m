Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B3C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 13:25:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2F7E40ED1;
	Wed, 19 Feb 2025 14:25:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BD68440E39
 for <dev@dpdk.org>; Wed, 19 Feb 2025 14:25:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739971508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruLXW696IK9AaNsccS4xpQKFEa5B2bbhbVlxEMkG88Q=;
 b=hZ5ZnrevPnGxjJI7F7J3GxcKNOOxnA+QWwdL0kfjWmf0IMbJ1j62K1LViQUFg/pF6JvOpj
 aoz0ejmeOshUTPFjs/EXIE6ZpuffRqMk6wGnr9u63WkJCF7jkBWwa336Fk0AsuUPnEkBzm
 2xBf28StBlrquvuWd5/nCNd7SaDZwoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-BNIFLEddOECUP-UFxCNk1Q-1; Wed, 19 Feb 2025 08:25:03 -0500
X-MC-Unique: BNIFLEddOECUP-UFxCNk1Q-1
X-Mimecast-MFC-AGG-ID: BNIFLEddOECUP-UFxCNk1Q_1739971502
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-439858c5911so17624395e9.2
 for <dev@dpdk.org>; Wed, 19 Feb 2025 05:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739971502; x=1740576302;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ruLXW696IK9AaNsccS4xpQKFEa5B2bbhbVlxEMkG88Q=;
 b=LwtsUWjnuBKg1S42qT7/IqCChXOqrOfkB9kxq7Wo3Zjp4qONMv1Xa15rJNccmMLKcE
 vCfhhRyp3nv/1XtUSynnXm5YoUA5OMwxHoBJjGAug8SLHL4HWRKyARv6s1DGxdmj3XXV
 8Ho7K3pbDzDLC3aWUMxRH1Cqcxu3/5vwx4RPGqxDvGD62xLJmFMZQx0cC88wYHqgHJ3G
 NGCIwT/ig4ZG0MYBmBXH35jA/FfC9Cvv5NZjoAU3UifAI5jEE7RcY5LLLogq9SJWkZGb
 2NNX3crZBQcsDPNu9pIaOcKrSqXwsJAkTOFzfxsfC7OgbCXagOTFGfAEqu4Hy/HRMwoI
 50wg==
X-Gm-Message-State: AOJu0YxpkIIWEj+FKGNmqW9fhGrN5g+YizuIbwU1gu0CBa/GPb8UzPaM
 LfFGr2gBZdFCHewXqFlFgTnrOLuGMKZNgjoVIJskFyn+7BLBw7Sc48wwuWkEoasx4WORU52qJM7
 bnAylqEV002bKHdObsLCzppc7lZQ2h+0TT0LKe5nT
X-Gm-Gg: ASbGncv5Y3UBh5mGC8GpK4xzInM2CT8YxDSRaeB1zj4Ns6n+5Wa+HgviemaKA97Ltt1
 MZKracF9/9XNuvKKkhFZucTyA4r8NEWJrRovi26+XIG6NNGCU24Gj5Lw6AEKcubXVufFnx2/TjS
 qra2tN/wheIzSigyayw+3USc8dG/rOUaRo0j+pl5uB6EkmXuwyQPvU2yB9/gjQTc9IblnyQQ6JT
 dZXFQGiH4xdB0Th77cvzYUAPEHDfqGLl8ElkIzg68nqOMTBMLVw6D30QIx9cyz5kvWR9LZ67MNU
 WiiBKmjZf52lJdc8AeBWSLqUbCl0klrAeEFiQaFsNDc7weEV4pOyeaeCAZNrg0WXl+akGCc=
X-Received: by 2002:a05:600c:4ecc:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-43999daff2bmr34186895e9.15.1739971502398; 
 Wed, 19 Feb 2025 05:25:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvLMab+BsinflCQEBnjgJ7gcmJcONVGYz+G8rRrzMjTORDXRUzBq5rCSABYD2App5N1PnWhw==
X-Received: by 2002:a05:600c:4ecc:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-43999daff2bmr34186625e9.15.1739971502045; 
 Wed, 19 Feb 2025 05:25:02 -0800 (PST)
Received: from ?IPV6:2a06:5900:c00c:9000:15cb:18eb:b398:a6a8?
 ([2a06:5900:c00c:9000:15cb:18eb:b398:a6a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43984924201sm90599125e9.6.2025.02.19.05.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 05:25:01 -0800 (PST)
Message-ID: <dd65d524-a82a-4394-958e-c651b788692d@redhat.com>
Date: Wed, 19 Feb 2025 13:25:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Stephen Hemminger <stephen@networkplumber.org>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ciara Loftus <ciara.loftus@intel.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-3-ariel.otilibili@6wind.com>
 <2b6e60c0-4436-44dd-bba2-335c1b22a7e9@redhat.com>
 <CAF1zDgYZJLX7FBCpwMWrfiLm6si-8jpfppQaW1Cd36QoNOCOfw@mail.gmail.com>
 <CAF1zDgatvhGqZBYf0K=RkVJQvDxo+==WWDAAXREqHAuR15W-2Q@mail.gmail.com>
 <20250213090426.67ab2a8c@hermes.local>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <20250213090426.67ab2a8c@hermes.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pGoIPvlh-1RqyvRN38md6OtAe-IrKhMDPK9wEJ_sewA_1739971502
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

<snip>
>> Are you expecting anything from me? From what I understood, the series was
>> acked. Still, patchwork labels it as* Change Requested.*
>>
>> http://patches.dpdk.org/project/dpdk/patch/20250207104552.1663519-3-ariel.otilibili@6wind.com/
>>
>> Let me know,
>> Ariel
> I was wanting for discussion to end, there seemed to be open issues around testing
> and the new common code.
Yeah we are all good now discussion-wise. I've acked this patch.

