Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034EDC982DC
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D971943289;
	Fri, 18 Sep 2026 13:34:51 +0200 (CEST)
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by mails.dpdk.org (Postfix) with ESMTP id B03AE40276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 13:34:50 +0200 (CEST)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a1a631f6aso58234966b.3
 for <dev@dpdk.org>; Fri, 18 Sep 2026 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789731290; x=1790336090; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xRnNYdQV6sLsRuY7b9qmAA34xqsTGsKAyA8bTd03TmU=;
 b=HqQsabIh67x7PxoDpmchNX6+r1zjU+RPgDxPylUcYaRzXO9ncjanrIDtl9ZdAhJJL0
 3oyrAyf98X3+f3l52ztBKpD2rA2vHEmLQ3zH+WFNF0Soc5is6w2B2+7DjORo5k0Z+cUD
 DXeEZWI437MCrbyUygqaRqP+LXtTRF+/6eT3hJcudh6Vb2Dazf8iYe9vZyXDqsjjde16
 Fm6xALj9B/LwZJhY8NlRQogKEya7amaHH4edXVqjWxLHLRYGUYggVrwPxKFtfS0Q24mF
 7PNyiFLAlOK1OcCT3eYpe/jwGWeAXrl58mgn4DpZHTWQSe8T31smFa87V4JJ4IjpR7pM
 wwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731290; x=1790336090;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xRnNYdQV6sLsRuY7b9qmAA34xqsTGsKAyA8bTd03TmU=;
 b=XJtP5CQ+kezo5g0Zm13DmAWAjfAl+BfrNS8nxkoQqYq21i9pzYb8DCtzTthXqy3sc6
 Wb/nm/JawMJeflH+sEpe8O7kwOCsF8SuT6b5W85zgr3yGup+rXTb1+axCHB7riLjFZX6
 viD8XwYim5zvaR7+EzVFmNSgL/P1XaSrLrxep22s+wX5IESmEquLtlEx2IOVAdLVLtlh
 +fxcJVrzAy6W2WKBfsBprVRucIOkhF1onlUopZvLTRkFHHpr9Wh/Rb2nakB06obdJeTn
 NECm8spFBuc51Pw9mV0Zy4niHxk1eZkU+6hTW9OxJb6CzsbXmc99NhBPbUHc6OZjSzZJ
 adng==
X-Gm-Message-State: AFuF++nsZw48QVXUO+O0PqmuKXuwqF0rvDyWOnPCVXFu14WxA1Z5ycA0
 l4Es545jVMKsh/BZ7S2USG4LLECNo313eCm8MvYMXGMQ4O+3iE0ppWzmZbAOnJGVlcM=
X-Gm-Gg: AYBFou13oRDAXdI4eTvUVOtQ6xmHgv9nmXW+U5dOKcftwa2pqePUI74lVRRCgx78A/j
 S/V4iMqyj7jBJmttXHajxXiPP6HyaSt1J049T1h40Kwsi/raA71gSgT2TsJFxvK82DOr1vwXSuW
 MgRBGUYtLz38LND6VIz2t9iG0ZROOOAZqboqMkBi8KqdwhrPSFqzDkc7XVqKguoLQ/smRX34VHE
 q22oh2j4lPaKpHPjju3LwZGgyoveTLE8QqwvTdgw54oYdVbUJ6Fl0AdzgWnKl/VMtSgjhPihQVF
 GRy4r4noMaH1t5ShVRq+e2dvL0liPQX6JYtYF1H3NLIf/y26NK3Y++Z+E33mTBxGYU9nk4Akcj8
 G4SvGT021OeTVkOQlWpNbly0qfPix65/bvg2ykaXwUerSlYhL75RfZB5j2sbfey77d82jW20mwh
 QMgmXRLgtx779Js066+z0sB0VvrXzMSeSke47+8zGsmD+PHunI2dWHNHqh+CtdLXrMRtENZw==
X-Received: by 2002:a17:906:6a28:b0:c29:f742:c532 with SMTP id
 a640c23a62f3a-c2a15888d0amr203521166b.40.1789731290089; 
 Fri, 18 Sep 2026 04:34:50 -0700 (PDT)
Received: from [192.168.103.32] ([89.101.57.120])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1b7a369esm47177866b.9.2026.09.18.04.34.48
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 04:34:48 -0700 (PDT)
Message-ID: <4aae7483-8b7c-4baf-bed7-f932fc0cce0b@gmail.com>
Date: Fri, 18 Sep 2026 12:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] provide a complete set of BSD list macros
To: dev@dpdk.org
References: <20260917172116.660120-1-stephen@networkplumber.org>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260917172116.660120-1-stephen@networkplumber.org>
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

The patch set generally looks good to me, and ensures that DPDK itself 
builds. However, there might be a problem with building external 
applications IIUC: if DPDK header using any of the macros missing in 
system <sys/queue.h> is included after <sys/queue.h> the build will fail 
for reasons not immediately clear to the user.

I think this specific case can be improved in one of the following ways:

1. Remove the _SYS_QUEUE_H_ guard and undef or guard each macro 
independently (the file should still define _SYS_QUEUE_H_ to prevent the 
converse failure).

2. Detect the situation described above and provide more helpful 
diagnostic suggesting a workaround (remove <sys/queue.h> or move it 
after DPDK headers).

I myself prefer #1, since swapping or removing includes might be 
difficult in big projects.

