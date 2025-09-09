Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA98CAC585
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 05:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AC8540281;
	Tue,  9 Sep 2025 07:27:59 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id EB01B40270
 for <dev@dpdk.org>; Tue,  9 Sep 2025 07:27:57 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45ddddbe31fso16710545e9.1
 for <dev@dpdk.org>; Mon, 08 Sep 2025 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1757395677; x=1758000477; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yraJQWPOVKhw19x2agjkx4cuajaz3SOTMoT3YT9dyxk=;
 b=iMEZdqcRuCP7VQQNp0oPOpTt3vP2o0F1SDKrqo7NE/saVtvvtSWWtGnXPx4MBD/t3L
 gU0FowIZs/tQcWRn6mjSRbhBNEDhGIfHF7mHz+1n9HcXPlhWvYsEetrHP4fOptQFRdoB
 mvWw9MvWUG9evdM1BT8gy7utz6ebo09rDzWGNNDSetek6mzbhK24GENvECz0EN6mUGC+
 qNrNGlzSaZvglB4O0DcZkwNT/Li/QtbNRFtgy3N+Ii+xxTsusjpi1fHoUes/p00Vy6tB
 11Na1SZn3E4FYkL37ZwCfR1hOj9i3MnIYFQ0pbx6TEurWIW1ajCDXOubLPG7FWyhvV+e
 kn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757395677; x=1758000477;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yraJQWPOVKhw19x2agjkx4cuajaz3SOTMoT3YT9dyxk=;
 b=e0F8/V8GQ3vAvs9DcweQCkBoNPuVNC8QzEhSdtSlOJvJwoPe9oNGjtVIjOD14945XH
 VBfnwIVSDiT9AcwTLHZZmUs3c93qR/qCMrllZUDsaYEIkaV7HTTF6SUW5uEa201CxEz1
 0xLWNodjuwEmQEkhbTCiB25GTFFhSVcULBzHTXfBgUnN34ik/XdykOtUhlrdlWQzgzGO
 fyfQYnmf/vPP9ZvTY/XkzwykzCOSssKQ/c4+vZEVA8bbb+7JomXP9dwKa5sqz5qGQEkx
 zIoPqXrLlY72UaaQOTD4ofBwhhKq9ST0txfUbta8FvoWMvH0ziv+FPQczJ16fIGyTKFg
 6/rQ==
X-Gm-Message-State: AOJu0Yzwe9cF0xSAML1ovbOXZoAhpcqp1fHpd+Aey3uRW76ol078UUP8
 +i4iQ7oJRYV/HnudbwrLx5gU/kauKksVvvH5mVanPTcdYYgFpw0r84N2vnHDPaHfIw==
X-Gm-Gg: ASbGncsjxnF+g+WUV/65dSqJDtvjobC/AikGRu6O7EXT8KNmLSO54XOyK/3OGrwj1Qd
 tLXmNCvhYcW52M86krcMLmZQ7+0/OmSA2VpqaZjm+cLbTwX3tS7leSLqJpxMWKhnZtueCIJRL+B
 sm0G/PU04fttZI1qJ4PvSdqDFSw2jriY/NSV8bpY72AQafKnkFbuVVAw7RGBwrnaVcBIQGzoD7P
 NEYZw+pZhoeBaKNEJFfvC4gE4kE3qUlebjWV2zT1MXwic148Lj4X6h2erKtjsXN49q1b46SvzGz
 j7N9Bijo3J/jeAwXOJAGl19Pk3WwjLgisdEbN1Xww2HZVxnZKyeYjdzYUrvk2iAY09iYvkfeQtd
 wlE9plrz75j4kFrt8k1MKh5yMLqxjGZvuRd27vZXIqyo9nvfn
X-Google-Smtp-Source: AGHT+IFeLvxWLRqgrWKSOYVcmpd9CzCGg1D12b+e3ZUClUBNU3k71pcVwO0GgufNIsbrNYwcIjySLg==
X-Received: by 2002:a05:600c:3113:b0:45b:9a3b:34aa with SMTP id
 5b1f17b1804b1-45dddea2e63mr112839635e9.16.1757395677436; 
 Mon, 08 Sep 2025 22:27:57 -0700 (PDT)
Received: from [10.17.1.39] ([185.13.181.2]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dda2021dfsm162905285e9.24.2025.09.08.22.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 22:27:56 -0700 (PDT)
Message-ID: <90baf334-0c66-42f1-a4dc-0aa74e1ed6bd@6wind.com>
Date: Tue, 9 Sep 2025 07:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] net/qede: reduce the optimization level for gcc > 11
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
References: <20250903113252.2496087-1-thierry.herbelot@6wind.com>
 <20250908070414.1297844-1-thierry.herbelot@6wind.com>
 <20250908125913.7deb6fe6@hermes.local>
Content-Language: en-US
From: Thierry Herbelot <thierry.herbelot@6wind.com>
In-Reply-To: <20250908125913.7deb6fe6@hermes.local>
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

On 9/8/25 21:59, Stephen Hemminger wrote:
> On Mon,  8 Sep 2025 09:04:13 +0200
> Thierry Herbelot <thierry.herbelot@6wind.com> wrote:
> 
>> +# no packet Rx with gcc > 11 with compiling with default -O3 or -O2
>> +if (cc.get_id() == 'gcc' and cc.version().version_compare('>11.0'))
>> +    base_cflags += '-O1'
>> +endif
> 
> Did you test with Gcc 14 and 15, it may be the bug is already fixed.

As said in the commit log:

"The same issue is also seen with gcc-12 and gcc-14."

I did not test with gcc-15.

The issue is not seen with clang20 (qede PMD compiled with -O3 works as 
expected).

	Best regards

	Thierry

-- 
Thierry Herbelot
CSE - Titulaire au collège Cadres
Senior Software Engineer
http://www.6wind.com/

Follow us:
https://www.linkedin.com/company/6wind/
https://twitter.com/6WINDsoftware
https://www.youtube.com/user/6windsoftware

