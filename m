Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20905C79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 14:10:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1947840E2F;
	Wed,  9 Sep 2026 16:10:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6CF9E4067A
 for <dev@dpdk.org>; Wed,  9 Sep 2026 16:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788963029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DqQFvqumJoFkJtqt0iTOhERZd2H8k3K6x3I3wzrUasw=;
 b=Yd6D3mde5sXjUHnXKjgDUnz/ExXLuMwDeS92dXe6pmnsMKlm2piKh8yzWU0UqhTGkaBa9g
 k7BnE+DY4/1C0/L+Jux11jaIR00z5fZ0siYv3rgjuj5fex5QBswNA5TEyyVcEh9ffl1Vf8
 +GTVolVLiR698W+ht3BombBFLOTZp5I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-zrrmI745MF-I-355uN8Q4A-1; Wed, 09 Sep 2026 10:10:28 -0400
X-MC-Unique: zrrmI745MF-I-355uN8Q4A-1
X-Mimecast-MFC-AGG-ID: zrrmI745MF-I-355uN8Q4A_1788963028
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939d6c515deso3725685a.3
 for <dev@dpdk.org>; Wed, 09 Sep 2026 07:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788963028; x=1789567828;
 h=content-type:mime-version:user-agent:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DqQFvqumJoFkJtqt0iTOhERZd2H8k3K6x3I3wzrUasw=;
 b=VOz4hehySiFUFlXP+DfU0egpO+C90jbchm/5EO4NGgqY7tyf65WWeZNtMMaE/Mp9Vh
 iW+6jLnkT69D7b6bLTVQe3fwUBFPOsMFxobkOr5Yakx7hZ9f9FpWrhSgUA+43ti2y3jk
 Y1Tzhu+Y12T20rCqkU+ylqeEtHo4xBIX1pWkXxAhcITyhcU5oukaiMzlGSyo53F5y+aQ
 8KBle1AqS5WvyTbLfztXyHeShv/YCkYEWde6OAmQeOO1IutOc7X2Pe35FgMKB5OK0HiJ
 h4N02ts0wHY/ixPOQeHRvgMTcdOARrNZBB3u2AKllz1OaWT6hxGT9+EtMnZn3zVe2xOR
 +eXQ==
X-Gm-Message-State: AFuF++kjW8t3C7ecgBMGudEzwAEOR7oEkswGjD+K9NmtFqsWND3JMfZd
 hAEcwu/jzeZUgBAvtqCyqsQxc8NSoW1dIi2KX7eCmah2iwvqOOrlmbXn6G8v6m2pXN/AKXTzuIG
 1UmqWy4WXHvzFR7VctWChyvpGIJg6k1bgFPCYxDu8/NZk
X-Gm-Gg: AYBFou3pU18STTNG3JJfZaqjFO0Q6xM0w97mcgKGuHYaPW6D3vBrGacW1BsMP0LdQ6h
 YKgyqdMrO7mtKpsfO10hZ42TI2c3R+Gs+Aa3FpoN+FG2Wz/gZhouzNxkQW2PQ5yZ6aqmk2EnJWe
 ImSwYaJlYsue1RcqsESUT5ezVBnZzA1gSCuMzwW6Fi72zpOwtB7eEMwaw/EcQ3HACqNgDfddi3B
 uLqs9QKQBNdO9IYYQ0JmqGJKCfmFH802y2cfbnmKFh1hESV73kil1+zz5C7e1xxs5qmqz3d56pd
 oDpX2aTcUs1oaPVFwhEKKX+KsUHV5OAILW1o85hsn8/V2R7DuqCDSxCHf7+grR2cnR6h/S/m69P
 0ezuN5TeuJBFClfuh1Wf5NdbB1s2X
X-Received: by 2002:a05:620a:4508:b0:939:639b:2e1f with SMTP id
 af79cd13be357-939d49184d3mr156648085a.7.1788963022562; 
 Wed, 09 Sep 2026 07:10:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4508:b0:939:639b:2e1f with SMTP id
 af79cd13be357-939d49184d3mr156626785a.7.1788963020542; 
 Wed, 09 Sep 2026 07:10:20 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb678b8sm1453946485a.30.2026.09.09.07.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:10:19 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC] devtools: add tool calling support to review-patch.py
In-Reply-To: <CAJFAV8zQRYO6pWubXc5rKfaK3edg=OOPyZdMkTrkCP2cUiiCEQ@mail.gmail.com>
 (David Marchand's message of "Mon, 15 Jun 2026 13:34:02 +0200")
References: <20260609182652.1053422-1-aconole@redhat.com>
 <CAJFAV8zQRYO6pWubXc5rKfaK3edg=OOPyZdMkTrkCP2cUiiCEQ@mail.gmail.com>
Date: Wed, 09 Sep 2026 10:10:16 -0400
Message-ID: <f7tbja6o6rb.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8hQuPtfZVRLqcEu_zH14CAEKBsV5I4xmvcH3aJ6Irvs_1788963028
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

David Marchand <david.marchand@redhat.com> writes:

> On Tue, 9 Jun 2026 at 20:26, Aaron Conole <aconole@redhat.com> wrote:
>>
>> Add an iterative tool-use loop to review-patch.py for the Anthropic
>> and OpenAI providers. The reviewer can now look up additional context
>> from the DPDK source tree when the patch alone is insufficient,
>> rather than having to guess at surrounding code, API contracts, or
>> function signatures.
>>
>> Tool calling is enabled by default with a limit of 10 rounds. Pass
>> '--tool-rounds 0' to disable it and restore the previous single-shot
>> behavior.  The round limit prevents runaway cost on large patches
>> that when reached will force the model to deliver a final judgement.
>>
>> Initial tool set:
>>   - grep           Searches for regex across the file system with
>>                    optional path restrictions and case-insensitive
>>                    matches.
>>   - file_read      Line range read of a specific path.
>>
>> Both tools are limited to the repository root to prevent path
>> traversal.  Path outputs are relative to the repo root.
>>
>> The system prompt is extended when tool calling is active to
>> encourage the model to use tools only when genuinely needed,
>> keeping unnecessary round trips and token costs under control
>> and to a minimum.
>>
>> Internally, _common.py gains send_request_raw() (returning the
>> raw response dict) so the tool-calling loops can inspect
>> stop_reason / finish_reason before extracting text.
>>
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
>
> - I got a strange comment that a (valid) sha1 (from a Fixes: tag) was
> unknown to the grep tool.
>
>
> - Are those tools returning results on the current working directory?
> If so, the result may differ depending on whether you applied the series or not.
>
> Did you consider wrapping around "git grep $pattern origin/main" /
> "git show origin/main:$file" ?
> (determining the correct git reference may be hard..)

I'll post a new revision.  I've been testing with expended tools.  Some
of the errors are a result of not having the git log / git show / awk /
sed commands available (model tool usage is *very* sensitive).  I've
added some safe versions and did quite a bit more testing.  The result
is quite a bit more promising.

