Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69A2FD376C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 15:58:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 851144027F;
	Wed, 25 Feb 2026 16:58:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 35390400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 16:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772035116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=saFISFcLQvlC2Ed9FfZ+o+67dSpylcUPE7UB4/U/oTw=;
 b=G9klxV9e33ChneQX+5pI3XM0kUJh+7++gc35OcAvXcJr52a6508LPCJWZONg3Tn/KHPpW8
 mglHmR4qtUXow5yBX0vrZJdqagNeS5mCe7AuxASJB7DOMLB5rCBt9OMw3e3WqE6NQM1ghg
 nzQIlk2aeNwWdw8CCuL3PPv2U93uoyE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-03ocEDSbMQuJDMKftSPUsw-1; Wed, 25 Feb 2026 10:58:35 -0500
X-MC-Unique: 03ocEDSbMQuJDMKftSPUsw-1
X-Mimecast-MFC-AGG-ID: 03ocEDSbMQuJDMKftSPUsw_1772035114
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso76753515e9.1
 for <dev@dpdk.org>; Wed, 25 Feb 2026 07:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772035114; x=1772639914;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saFISFcLQvlC2Ed9FfZ+o+67dSpylcUPE7UB4/U/oTw=;
 b=ceQErai3VyjeixeO6WCS6FSbDJCWrKz1vtvaxHnhOORq0hZEt/I8zaT1iACSTjIj2R
 LrKCKgX2ESxQnfYEAvIuLpKde7nuoNPUTEUsV31RzIZlQ7LrrNW1BXnt+nAkNqGi3n3Y
 MNdO/wFbPGeeqc1u/dMMspuIcRMnf36lweZxb2MMtKe3LGPu36Gym8QeiqExPnkISo+8
 sd1hvsCsBH1KtXbPSTx0xmhL0UvlwtCFaWRlHknBKS88hpTs7hpLs0iqTDTGjam3mCpq
 DlXe4p1ioKZdmYn9Pe4Ef6pf63qW877YJvxswysWEA+VJChWCFKp2mGEygie1O/3WQsR
 QFHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm0ZLcRxxwAtm0wqMq6QNgb+jP3CmIXh1JhjVVRw9dQrqdCBhcoiqGOMgPlq17+dLXPjE=@dpdk.org
X-Gm-Message-State: AOJu0YznZ5MI6AA1VVxC3IwXUjsWbLxLMoFACiwVrKXkkqCBxUOejopp
 fKKFbL4RJS2uAbwC86zO/mzr4Uh3J9p7AnEsCdQm8OY/zS1tbSBBGOsnL6MVTKa+UjYVViDF+l2
 Il8dl6s4OfHAr2PHIhGilRblx4hByUX+jz18oOtNbfzJq
X-Gm-Gg: ATEYQzxOB9DMAKTDlPoxafe3j3abwIhebZ+QReedFedsaBPXYFrwzzYj27FJBvre1ro
 50wHzqwNlS1yAZ+4/b6zRwQFtKroNFGS7Bc5tj6/31v46E9DxOPOreYY2omoWw4k8ZDdzh4Gf9Q
 OKqnybqG2jTsQJL9fFA0cCC/lvYp3O4EPz+bESlEDwNAh3wx1w7jl92FVCFywGTTRiDyDDoyAlq
 ki7S4UEt8nQ3FEjEhDqojU6K6MXXEHCvULSO5k2gkXL6WxZAT9z4SJCEQjnf58OZBkTAFpabAxR
 +/11hc58bRHGeN3i7DP/7z1zysfAUQaFDHeVb2QX73fTkuVLJ9cT0avxoe/gDcEJLfVHGOTdbUp
 BRyl/GG80SZTL13LxpBOi5din
X-Received: by 2002:a05:600c:a47:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-483c21a9b06mr14846455e9.29.1772035114047; 
 Wed, 25 Feb 2026 07:58:34 -0800 (PST)
X-Received: by 2002:a05:600c:a47:b0:47e:e87f:4bba with SMTP id
 5b1f17b1804b1-483c21a9b06mr14846035e9.29.1772035113555; 
 Wed, 25 Feb 2026 07:58:33 -0800 (PST)
Received: from [192.168.0.56] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb1afcbsm34637885e9.2.2026.02.25.07.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 07:58:32 -0800 (PST)
Message-ID: <6e46bb34-4195-4629-a861-77e881005d91@redhat.com>
Date: Wed, 25 Feb 2026 15:58:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mbuf: fix packet copy
To: Thomas Monjalon <thomas@monjalon.net>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <20260120072414.465240-1-mb@smartsharesystems.com>
 <9659693.EvYhyI6sBW@thomas>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <9659693.EvYhyI6sBW@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VYoH1_nbrp84rdy4zt5yj7rIQl1hnEoYzhdDJRnIdeo_1772035114
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 10/02/2026 17:21, Thomas Monjalon wrote:
> 20/01/2026 08:24, Morten Brørup:
>> mbuf: fix packet copy
>>
>> Requests for copying the at the end of a packet incorrectly returned NULL,
>> as if copying past the end of a packet.
>>
>> When allocating the mbuf for the copy from a mempool using pinned external
>> buffers, the external flag in this mbuf was not preserved.
>>
>> Fixes: c3a90c381daa ("mbuf: add a copy routine")
>>
>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
>> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> 
> Applied, thanks.
> 
> 
> 
Hi All. I see this is not marked for stable release. Is it deliberate
because of the flags changes ?

