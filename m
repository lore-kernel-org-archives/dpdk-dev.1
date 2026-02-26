Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD1CFC5910
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:01:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69CE1402E9;
	Thu, 26 Feb 2026 11:01:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B466C400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772100070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j4kHCcGp/yKVbY9gDWRp1dCy7qaLWqwFM+yyj0NUVqI=;
 b=h16RvEwN8vedNwFBKusxRJoT+cndehiBJp7ch06OXL3XpAjuduqeu+xdqItkrqMRYe2lKp
 nQiEm0WvK+XhDzvGCDY7FFVxamQeRO1ImBQ2D5DoYjmE8WpfZkeBXOlFgcmqhAOfE2fFfx
 5T34fmEUgEuKnmrD5m01gvOzYHlaihU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-rBXp4I-xO6Sm3TtlxRyZcQ-1; Thu, 26 Feb 2026 05:01:09 -0500
X-MC-Unique: rBXp4I-xO6Sm3TtlxRyZcQ-1
X-Mimecast-MFC-AGG-ID: rBXp4I-xO6Sm3TtlxRyZcQ_1772100068
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43630b02fb4so559617f8f.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 02:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772100068; x=1772704868;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4kHCcGp/yKVbY9gDWRp1dCy7qaLWqwFM+yyj0NUVqI=;
 b=mz6mNpwjFJLKxZXC4N9pYVjcXiq0S53U/O6fQahwO4zm5rIOLpIfh2GjvBFa9XufeZ
 hrCznFO4Y96hD4CEBt5VNbaT7OqNp2+vZXop4fmqJIjFZAcDXLuBp1w9dcsvd1G48ZVH
 45gSipqjz1g17FOhscEgHvBdqtyglIml68yL6SMZUdbrCcmMz60f68TCHEzH4CgZzY6A
 UWY/Awim5+4mUXUb2Rim9ppX7oEra7vAtQDbUHRFm8u2OFCP0L/GSHwudCpOvoIpRCn8
 1Z6T5L1Ks4vh+FwKW/D3RrftV8iXWW06cjgboCG7IOMZxIDlWzpXCrhp+TTbu5qiwj2r
 LgJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWaeD0Qe8lxPRSohwT1vpG8HgQXmCS0oWHX02ZQYsIfkzEqqLrLCmpP3s1x1/6SqYMEVE=@dpdk.org
X-Gm-Message-State: AOJu0YxR6g7mSX8FMsbi0JpVgQ2FF8Tjo45qFo7P3SHqa6kqDQpycL5r
 uxbyCBf9YH/NF3Xmpy3gBH0o0NkD/l/thcFS01vVo7Ota+YwpgaCk4GSD9SxbzX9d8QqJVD03rm
 H2+NmfOocJBnds0yK1O/VeJ6QpYPnhSLI1M03kRUdpzm5
X-Gm-Gg: ATEYQzxGUWtpIW1dGo1ixVE6DGxEBL+8j7xiFvX56hcLAuW9OrUNgAKDJtqq4YoBGqL
 SvutdsnlKIM3pTiJdzbwC1sOK1X785kQ0AiXH2sh/epUW0qEMEq+MrNNby152Ce9NFK9UTlVkwW
 VBGPr/AhJeUikHIWTQ0xt3vuGO8S7x71BLrAMYaRZKWjsPqnLFb573ET5s4iBJez6JGLFkDp5iR
 uTVizE9ueSQPylGRlsCN8gMy1FeR4zSqa1nY/8X1Oe13w257qWNlgVuLJrdIc5qkYZeuMdrNniH
 lTbhoBnBYPvXwEuF7IuyG2oFG/gUggslS1ZSFhqkzQ4rhavlC/sYgKe6R/Xo6hhXOLTZ4qTl7c7
 Q5mS1SKNwY8ySxrf0yrchrgmL
X-Received: by 2002:a05:6000:4203:b0:439:9025:156a with SMTP id
 ffacd0b85a97d-4399025171dmr8609938f8f.31.1772100066798; 
 Thu, 26 Feb 2026 02:01:06 -0800 (PST)
X-Received: by 2002:a05:6000:4203:b0:439:9025:156a with SMTP id
 ffacd0b85a97d-4399025171dmr8609777f8f.31.1772100065739; 
 Thu, 26 Feb 2026 02:01:05 -0800 (PST)
Received: from [192.168.0.56] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398fefa3f8sm9985021f8f.36.2026.02.26.02.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 02:01:04 -0800 (PST)
Message-ID: <49efe45f-e396-4a25-b789-17719a783921@redhat.com>
Date: Thu, 26 Feb 2026 10:01:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mbuf: fix packet copy
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>
References: <20251119120403.907511-1-mb@smartsharesystems.com>
 <20260120072414.465240-1-mb@smartsharesystems.com>
 <9659693.EvYhyI6sBW@thomas> <6e46bb34-4195-4629-a861-77e881005d91@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6574F@smartserver.smartshare.dk>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6574F@smartserver.smartshare.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7WLorToDcNjfp64A73781c7VaI0vbjJGTeVXyvvnOR0_1772100068
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

On 25/02/2026 17:17, Morten Brørup wrote:
>> From: Kevin Traynor [mailto:ktraynor@redhat.com]
>> Sent: Wednesday, 25 February 2026 16.59
>>
>> On 10/02/2026 17:21, Thomas Monjalon wrote:
>>> 20/01/2026 08:24, Morten Brørup:
>>>> mbuf: fix packet copy
>>>>
>>>> Requests for copying the at the end of a packet incorrectly returned
>> NULL,
>>>> as if copying past the end of a packet.
>>>>
>>>> When allocating the mbuf for the copy from a mempool using pinned
>> external
>>>> buffers, the external flag in this mbuf was not preserved.
>>>>
>>>> Fixes: c3a90c381daa ("mbuf: add a copy routine")
>>>>
>>>> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
>>>> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
>>>
>>> Applied, thanks.
>>>
>>>
>>>
>> Hi All. I see this is not marked for stable release. Is it deliberate
>> because of the flags changes ?
> 
> IIRC, the consensus was that using pinned external buffers is considered exotic, so the bug is unlikely to occur in real applications. And if it did happen, we would have heard about it.
> 
> But, since you ask, we really should have left that decision to the stable tree maintainers.
> 

Thanks Morten. Background knowledge and context is important, so it's
fine you made a decision on it, I just wanted to check.

> -Morten
> 

