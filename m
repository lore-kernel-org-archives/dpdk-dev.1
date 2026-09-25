Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39371C98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:59:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2B7A4026A;
	Fri, 25 Sep 2026 20:59:57 +0200 (CEST)
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12]) by mails.dpdk.org (Postfix) with ESMTP id B1FB9400D7
 for <dev@dpdk.org>; Fri, 25 Sep 2026 20:59:55 +0200 (CEST)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-33be7dfcfc1so1612835eec.1
 for <dev@dpdk.org>; Fri, 25 Sep 2026 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790362794; x=1790967594; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uID2DhlXtSj/7MdCh96y3I1N1E8V8q3aJVFO0p6PjxY=;
 b=hrjV7Hvw5easYkky1ag2x2esAeaEnPO8E1n53DXTkYBL0WFsunN/slxYtOa9htnHox
 iHJqc5DGuxrJr/MsuFqd0H2c0iUcNLFt8Hu1FxazILqEbEOTYUlVPFN/dJ2AVSpV/8W8
 e+tgbZlxzshdf4kWWfI1QCs0mhfyixSsa5TfuNY/FGwkJ1NW6TuI9o6Xavgv5L47RoX/
 B2WffVBP/+04NLafRtidj7fYJPNOVUjdj6avhcKzWHKLIXZTxtf+EYnyLuawq6S/q4Vv
 fBjXw/Az56XdTjQMz62jK0s8gVPof7cnJRU3ey/YE2yv9LAAxeD6oJLeojNLAkGDysjc
 cb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790362794; x=1790967594;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uID2DhlXtSj/7MdCh96y3I1N1E8V8q3aJVFO0p6PjxY=;
 b=PCxqyzqc0tYUC4eQB4WcBYAwORb6BYJHpN0QYBTF5SbHcDmFecxKmPpBnubjhz4WU8
 jJ6w5aB3+DUFz4wEp1O5tq/FY8ITSSpC0Unc0gGh7+krJCl79O7+0EBG+HIFaTW6qXMI
 W0rZko72DaPs54Ya9xWuUHMQ5hHNw00dyilrWbzPvDGs74yy+IA3xsdGmna5lg1+sMPi
 UrlrG0SogVDwcmSH6T9DQ/6pTQGfBlFW1a5JTcdyqZlBa95DPZgNpoC2zVaQvZXzSlAv
 ra/MlcfoOhv726S2QQH4zdj3WmKIYjKpeg+eK489HpSSLZQ3M3SbIJ9hchTaVxI+bPE1
 noMg==
X-Gm-Message-State: AFuF++nEs5OYTYLGvLANvkdwCODIaCYAmV1I7illd9rL4FirAyLeJZnX
 hwVTZUCDJno5KcFVqYXZZYyjfZ4+8kIFrDYlYtWl7WQADHbUUUyRdJOY
X-Gm-Gg: AYBFou2X/+vneqO0KP2VxopIS3cZI2tuu0x1IFEefjs2He34ux6xohK84ffsbuqCE2N
 lvn3zKBcq6h+w1mFxNzqNB4EDhNTZeHyGSinnkqptbvxUmOffg6I1Xgs2rbpXCBasL4AHD5hS+C
 irsxetP3bX2UV5YJ2JrfbNshfUo/7cUd1TdFyqn0wC7otNxtLHbii2RyBynkFe5hydp04He2Y2d
 1NEuBJXQA9ahc0iW+7hD3AnZWsji9AhIbyoauVhEbzCNoQ/fkrzuAa17cHoCpnEDSyD5zdJo/oS
 HkFuFi0hcgl1z9kkEP1ru4WM64efTgdHJXbGCeou0l4mv/k3UBj72f3aRpQwV44UqeUYRyzbROJ
 qeHTYB9D7E/5REvJfknZwklWqBhPMAhFoz4QwH36AOdOc49TVH31p9UdWEu8BILpGiAwiZKVzIA
 Mf+anqpXgu4uGm6B2fBaKNJNC9urK/SPEeSJOmckl6SE4s5U/r6mbFNCuXLSMWdRnKy5azAXylc
 PuEX5LLMC4cyCqO
X-Received: by 2002:a05:7301:f05:b0:341:67fc:98df with SMTP id
 5a478bee46e88-342705b233amr982535eec.12.1790362794345; 
 Fri, 25 Sep 2026 11:59:54 -0700 (PDT)
Received: from [192.168.1.112] (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172d8asm7937842eec.5.2026.09.25.11.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 11:59:53 -0700 (PDT)
Message-ID: <757938af-4936-44e7-9de4-8904d34c5e41@gmail.com>
Date: Sat, 26 Sep 2026 02:59:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: fix repeated Rx packet buffer shrink for FDIR
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260916135827.116145-1-zhtfdev@gmail.com>
 <a46db9e8-1513-4e19-b029-2d55e28d42b4@intel.com>
 <b653e89e-d67d-40c6-afea-61d3fc5b1c3e@intel.com>
Content-Language: en-US
From: Zhang Tengfei <zhtfdev@gmail.com>
In-Reply-To: <b653e89e-d67d-40c6-afea-61d3fc5b1c3e@intel.com>
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

On 9/25/26 18:05, Burakov, Anatoly wrote:
> On 9/25/2026 11:47 AM, Burakov, Anatoly wrote:
>> A general comment: instead of reducing/bringing things back and 
> 
> I asked an AI to implement a fix based on this, and here's what it came 
> up with, it is roughly what I would like to see instead (obviously, 
> please review/rework as appropriate e.g. to properly support VMDq as well):
> 

Hi Anatoly, Bruce,

Thanks for the review. Agreed, keeping the FDIR mode after the last rule 
is gone
is wrong (a later rule with another mode fails with "Conflict with
existing fdir mode"). I'll drop the flag and do v2 along the lines of
the draft: RXPBSIZE(0) computed from the default size on enable,
restored on disable, and FDIR disabled on the configure error path and
when the first rule fails after FDIR was just enabled.

Unless you object, I plan to:

1. Use hw->mac.rx_pb_size as the default size (512 on 82599, 384 on
    X540/X550/E610) instead of saving RXPBSIZE at init.

2. Leave VMDq out: ixgbe_fdir_configure() rejects all DCB mq modes, and
    the non-DCB VMDq/SR-IOV paths don't write RXPBSIZE, so PB0 is the
    only buffer whenever FDIR can be enabled.

3. Not address the fact that FDIR enable/disable from the flow API
    changes RXPBSIZE/FDIRCTRL while Rx is enabled if the port is
    started. Enabling on the first rule already works this way today;
    restoring the buffer on the last rule removal adds the disable side.
    dev_start only touches these registers with Rx disabled.

I'll send v2 rebased on next-net-intel in the next few days.

Thanks

