Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA2D25B44
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 11:19:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01AE840274;
	Wed, 28 Jan 2026 12:19:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A6F9F400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 12:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769599162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2p1pjliCLMYXus3STj7OL3ZPAbq+UX8kN6DFv3chhY4=;
 b=GMrH6vZXx95t23KuFeFnTI4IL+Jy1gH5HDN6EDvgQSZR2L7k5df2L+Id4+bKpDim8MI6rs
 zF5xgbMwR0cRo6bnYZPHL9+N44d+J01ghIFNQrJ6SUJ1tePS9rrbJC1SoB9DIX9TdHnWmJ
 ynlz4uJGMHn7e/1AfjL6pu9emcKzD5o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-R2TH6nhHOZmkOJ98MNEa9A-1; Wed, 28 Jan 2026 06:19:20 -0500
X-MC-Unique: R2TH6nhHOZmkOJ98MNEa9A-1
X-Mimecast-MFC-AGG-ID: R2TH6nhHOZmkOJ98MNEa9A_1769599159
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso5374418f8f.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 03:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769599159; x=1770203959;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2p1pjliCLMYXus3STj7OL3ZPAbq+UX8kN6DFv3chhY4=;
 b=L8ngvD98JtUG3uLvjmZWZIwrccVtSGaeHgaZ7jdd8Xfif5nCpOTlukDUwAsyGlITHS
 0QS6z6OMyf0xBcx5ZGvZFzIqPwOWpK6gSBGtCWtzDFaFRrXSgzwTvgEro8XoCxXahg7O
 UG4d0XzsZyljhT8ZyQY61FBsSexA0Nz+5tkvK+I+2cFNvn710vIYbNI6MiK4EqLTWFAi
 E2VTFjpDqsy6euZX9DCYCcgjtvkW+LQFVkRzC8oQLMCslcfpvhF54ZwV/tPBthwDLIrA
 GMIVFWqx0dYkfLEWwaW1/TiIT9naAi/WoabhNy67qMEHO7h4ZSiQdvbdTcQu4yR/JJ/z
 M9pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjDtskO6jlyVq8TTLOqVAXbDeTJo63sCcKDElrE/LUwMagoTrT2SzYQXnGGhqS7/m1Vag=@dpdk.org
X-Gm-Message-State: AOJu0Yxjqm27wfsIbivDIBe34ujJxvoy5Ob8P6yr2kFPMO1oFhsNTrHM
 8e/cwCg2jtXL5dTy9D77opxkyRdHC7D6X+CNYSNvTXVrf9qANb+tL/KdXNGhSuJmc2E+Ic4Xzmc
 9WVCd0jq9oe7HeRbXKUckYt7sz45sX9D8aXUHbfcuvGZGBAiXEKuo
X-Gm-Gg: AZuq6aKIVZHO4ImqcNmCqVLYVXcxZULgCuzUgcyUU4Q2dzn5fuAqm6cjuG9GhaDdmB0
 NrKe6I79TIN4MA2BCMpat+1ZrQangD9eeAJF3QV73hMDLyjECYhAo+rHAXsMzdiKv3obH6kB+R2
 /rOPbDaccEP5XlgGz/WrMolvux2T2CTAX1idiafIby6a23p1QUHAC5f7nW3XfrZJkzrAf/x5Fsx
 2vRodVl4HtpIr790g9+VKYvGpecdYCZlbT/EcNp2r3qpBTQ7gCUbK/qvtqFGAmLFSzY3C2FEhr+
 mIYWQPl1DhobF6+M/c+vUQGeNapeDLKrhdTr9dUUjRpvrcHafVR7PsWvCW0cQvIDwSQVoiIe5Lw
 oJ/UeTD0iLqaf
X-Received: by 2002:a5d:5f53:0:b0:431:266:d134 with SMTP id
 ffacd0b85a97d-435dd1cec11mr7113774f8f.53.1769599158656; 
 Wed, 28 Jan 2026 03:19:18 -0800 (PST)
X-Received: by 2002:a5d:5f53:0:b0:431:266:d134 with SMTP id
 ffacd0b85a97d-435dd1cec11mr7113737f8f.53.1769599158249; 
 Wed, 28 Jan 2026 03:19:18 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.210])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfe7sm6103388f8f.14.2026.01.28.03.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 03:19:17 -0800 (PST)
Message-ID: <8c80d03b-cd24-4b84-b5cd-22fb34ea7d36@redhat.com>
Date: Wed, 28 Jan 2026 11:19:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: bump meson version to remove warnings
To: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Si95BbvMA-V3Tf5o8DkH9tVHb3BvArhyqp4RGjhzL64_1769599159
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

On 05/12/2025 12:28, Bruce Richardson wrote:
> On Fri, Dec 05, 2025 at 12:13:01PM +0000, Bruce Richardson wrote:
>> The build of DPDK now uses features from version 0.6 of meson, which is
>> greater than the current minimum of 0.57.2. Although these features are
>> non-critical, they do cause warnings to be emitted on build. Increase
>> minimum meson version to 0.61 (== version in Ubuntu 22.04 LTS) to remove
>> these warnings.
>>
>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>> ---
>>  meson.build | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> With this patch, and the previously submitted patchset for assigning test
> cases to the various categories/suites, all warnings in the meson
> configuration stage should now be gone.
> 
> In terms of the specific version, as noted above I chose the version of
> meson present in Ubuntu 22.04 as a reasonable baseline. Both debian stable,
> and debian old-stable have newer versions than that in them. For the RHEL
> line, I'm not sure what the baseline is, but I believe that RHEL 8 shipped
> originally with a meson version even older than 0.57, so moving to a later
> one I hope doesn't matter. [I wasn't easily able to find out from Google
> what the current meson version in RHEL 8/9/10 is]
> 

fyi - RHEL-9 has 0.63.3, RHEL-10 has 1.4.1

> Regards,
> /Bruce
> 

