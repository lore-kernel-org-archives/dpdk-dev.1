Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8482CA5FD2
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 18:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA1A40698;
	Thu,  1 Oct 2026 20:50:38 +0200 (CEST)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by mails.dpdk.org (Postfix) with ESMTP id 4ED0640698
 for <dev@dpdk.org>; Thu,  1 Oct 2026 20:50:37 +0200 (CEST)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so45807365e9.0
 for <dev@dpdk.org>; Thu, 01 Oct 2026 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790880637; x=1791485437; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=juUgCgB6+H2DJxo6mwr7mbW8AN7r8F7Kvmfnq1Wa9bw=;
 b=ZB7ahaAYxnpvEt65xr9Z6zMVq6oGyB/26PBoTuIcKuGxkbDY56dI1FCP087l0mt8tC
 nBR1oIdD+qlixaJkMGFb/neGxshjOncS3JUVNIz4jwjkjBpqft6W2DoN2eu2RTUCVDHs
 3UEgAKlvGKfynvEYlnvLKSJjoAQN5AxwlJl9G5qv7THV+2GYXi6ZBBnfwZJynD7eTdUA
 WmuDlSahwdafA6vpXuIG0Bij+njHsxvnES3AHocNVajCweF4fdzWrNG2fztESVl/xcvf
 iH/MAF9qhuS6nGHcwT9JY8bOuoi1frD8EGajG7uc19b3wCXrSwjgY8qtAK62f4lvWUc8
 b8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790880637; x=1791485437;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=juUgCgB6+H2DJxo6mwr7mbW8AN7r8F7Kvmfnq1Wa9bw=;
 b=EcU6xWH3hCx5bSGAYjOz4pnC5Q0nDYIbVQy8ry5LJNQoQ4lz22kejGD35sjJp15dAb
 VSKpqVdtzCMQ0sxhAglOcJkFMhoFgnsfjn9cR4I9AYCm9zZY/AHdX9Tz6G8/LxAuH/KG
 nAorHfMhdiUVDbGL9+X7mRjl5PAtcQ55htAFUgJoOY6nGEb+yepPQUpmdKC2VksZ66rj
 lWb42Gm8qprPlC1Gs8SkOuZqTRZP4tURaHP7ISO0aueRrCyomOXo8D3cI/sawA7UHy0C
 zVRURsv7QMMN34gMGOg8xQTCusrqY1cdKyf7SqcZkGjTNh8O+9DtlTnDtE8bDTY3WncS
 rvYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJQLwtRVKLTpJ515LiZw8ZS0l7WaVgUBZjfYPeVhbMFsY09/zX5EPqixSgQG99DaEc8HU=@dpdk.org
X-Gm-Message-State: AFuF++nXl+WR44JRvPTY+O4jFjI3HpF769SiCiiTNF589OnwKZ7Dsvg7
 XSddX/Ovq9ObP7ZhGT9xVSqhkgOdQYWQD3ckEBqPATW/euMkzZ3BryUOCV58sZvibms=
X-Gm-Gg: AYBFou28IQA4HFakAnxcwSJnDgFTV5k8/UI5u1fJGaY29mwnyh/R0jijyhJ1iZjPM5c
 drH30jAWAz/qfLpMrwurtMEMJcJ1PbdufslqMtrJKHYhT9DEIKJOxdwVlIFqcwzGg0XuzOZLg7u
 W8Gl3DaVSNochQNB49lrrdGpGJEjpc1pcUsGp1rE5hPmKy4u5XccuMEBO5a2CAz4Y4nm9k/kHNk
 93i3yoIZ1eADnbpaSWC19AZF/l7GwIF5fjjQw4sGbvxRtm+h9JE+qZWtN26JziKGK7WXExJzGAQ
 VyZ2F1i5XNxOc+kMgyvQNfb36TSzrDPsfc1PTAYK7ni2SKyQ8TM+Di6ILID//MQjczjIIIcoHsE
 8zlUZ3QJnicKLphgX+wsz+tdosw2dKE0K7k569p89nw0JjERiOoCgHcmkNtoQ5HLqgN6quuNejM
 Z70g027bwMIF4RncWw30olAHjWebPvg65h3TTNQBjoL4lKpUARQy/yFWoQA/OdCqtftC6d
X-Received: by 2002:a05:600c:4e13:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a02757999cmr10049755e9.16.1790880636621; 
 Thu, 01 Oct 2026 11:50:36 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.33.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02783af28sm10064095e9.15.2026.10.01.11.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 11:50:35 -0700 (PDT)
Message-ID: <cb600b10-6403-499b-af19-3f69d103510e@gmail.com>
Date: Thu, 1 Oct 2026 19:50:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] add rpcap remote capture daemon
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20261001025853.319860-1-stephen@networkplumber.org>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261001025853.319860-1-stephen@networkplumber.org>
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

>    pcapng: add API to read back capture mbuf header
Analysis with AI tells that there are some opportunities to make the 
fast path of lib/pcapng both lighter and less .pcapng-centric to make 
life of consumers that prefer other formats easier. It does not have to 
(probably even shouldn't) be a part of the current patchset though.
>    app/rpcapd: remote pcap daemon
Ideally forwarding captured data could run in a separate thread with 
minimum unnecessary syscalls, although it's hard to tell without 
benchmarks how much current design is slowed down by them.
>    app/rpcapd: add TLS support
This patch simultaneously adds authentication, but it's only required 
for non-loopback users. This is a common security vulnerability, not all 
loopback users can be trusted. So if we care about authentication at 
all, it should probably also be required for localhost users, at least 
by default.
>    app/rpcapd: add host list option
>
>   MAINTAINERS                            |   2 +
>   app/meson.build                        |   1 +
>   app/rpcapd/capture.c                   | 541 ++++++++++++++++
>   app/rpcapd/filter.c                    | 164 +++++
>   app/rpcapd/main.c                      | 840 +++++++++++++++++++++++++
>   app/rpcapd/meson.build                 |  40 ++
>   app/rpcapd/rpcap-protocol.h            | 146 +++++
>   app/rpcapd/rpcapd.h                    | 122 ++++
>   app/rpcapd/session.c                   | 292 +++++++++
>   app/rpcapd/sock.c                      | 365 +++++++++++
>   app/rpcapd/tls.c                       | 273 ++++++++
>   app/test/test_pcapng.c                 | 133 ++++
>   doc/guides/rel_notes/release_26_11.rst |  13 +
>   doc/guides/tools/index.rst             |   1 +
>   doc/guides/tools/rpcapd.rst            | 288 +++++++++
>   lib/pcapng/rte_pcapng.c                |  40 ++
>   lib/pcapng/rte_pcapng.h                |  46 ++
>   17 files changed, 3307 insertions(+)
>   create mode 100644 app/rpcapd/capture.c
>   create mode 100644 app/rpcapd/filter.c
>   create mode 100644 app/rpcapd/main.c
>   create mode 100644 app/rpcapd/meson.build
>   create mode 100644 app/rpcapd/rpcap-protocol.h
>   create mode 100644 app/rpcapd/rpcapd.h
>   create mode 100644 app/rpcapd/session.c
>   create mode 100644 app/rpcapd/sock.c
>   create mode 100644 app/rpcapd/tls.c
>   create mode 100644 doc/guides/tools/rpcapd.rst

With or without addressing any of the comments above,

Series-Acked-by: Marat Khalili <qm2k21@gmail.com>

