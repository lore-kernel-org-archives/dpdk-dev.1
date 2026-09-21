Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED8EC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 16:43:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4144742D9F;
	Mon, 21 Sep 2026 18:43:35 +0200 (CEST)
Received: from mail-ej2-f18.google.com (mail-ej2-f18.google.com
 [74.125.228.146])
 by mails.dpdk.org (Postfix) with ESMTP id 400E340E2B
 for <dev@dpdk.org>; Mon, 21 Sep 2026 18:43:34 +0200 (CEST)
Received: by mail-ej2-f18.google.com with SMTP id
 a640c23a62f3a-c254fa65080so370992466b.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790009014; x=1790613814; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GdgyUyYHn4TUKZGq+7fZpupA+ZZSGJ14w/FYgsVpMFA=;
 b=S8pE4G8VctDQmWG3lfVAN4kBuqKNqJDlcV0U6b15Wtn2O8UwA2+GuX4O3B2MfjoKyd
 v6quFwPcOLpphrw4m22E4LBMxLS74gAwSuzHaHRbODOE/3XtozINL/dA++KRL2ciu+v+
 VTm/0ltdNo7JtzPOEVKVib+8n4Vk85Odu5NoAeN7JMSiUc2Ise2iUSgLmqRZkVhxUoGW
 xWWH1I6iVPf4goi7YFPJ8CdwVO/d5VrcaaYIAJMbkf/8LoACjFpiuqHEpDXJaUjsb4mO
 v6Kyxt9LZrFrSoMlSxQt+v7R1XHmQ+24O0i6fWDZQXwCgTr0FQGX3FercjR/VBKxJY6F
 JgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790009014; x=1790613814;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GdgyUyYHn4TUKZGq+7fZpupA+ZZSGJ14w/FYgsVpMFA=;
 b=vovz7iEhGZBCR15Bnh818+yeS/xJJNtD52Nob2pxv4jUwobPpphh8m4kaeMrPZspe0
 MnhFKXpC2QjMyC96K/mwcOiekDgXSEX7uKaILJfKNhydmukXv7/hMn4fOLKuWhJsoApn
 DZReAyK/UPhMmvmnzaPWXbYnvYLQ5hqq3l5axHOc7qflCmwaqqoGqeYVmV2MirfoBl63
 80hi5x5Sd4vLyDLH+1uwxLAOKBGMFAEh9pvcnoWICjo32f1LpzWMsoLoBqbo/nu5b4g/
 pTi5ptwFf56U/TDYeDqYE9+Z1q2JH8avTneO8Vx9piPwZEe0DK07PZMnhEkXg55W13Pl
 RGow==
X-Gm-Message-State: AFuF++k7axY1+6o+x7b68GoiRYIRhyQZ3W8+LnLApmeDOceLWoLe1qyZ
 x8Wbm3HdVY3+TogtK8m24VR0nEjFdiIR2wbG2koXIPZZNL7JgKAxAu+l36bVx02u
X-Gm-Gg: AYBFou2XRtZvNbHeSNn7EDq4r+zCAQFJloB5iq3EVftdCsJtFCRYp8njKLkZRD4NGon
 TdOu0zQghKTtiqr8QpqNL+m/XvghbTA19UBbzkNQHKjgcA/p/HWoDp3ueE15v+94+k9CvFr4WXO
 xwLZ2fB7kh/Ox/s+JfD7AiEIyYWHevjA+54lGwC5OIiOZXYgjsrz7C6WW/+kDIopTrNiIBEBLS0
 cQpRR2DGu7BD8vrp4G43o//Icn3pn1ni3EwpDcj5j+YrqhlRTUklQDO+7gddhhUMTQy0LpXUN1/
 DExKuPdw1y/hGg/9WGpmMMIwYtmxQElbf9QzCJQrF7IowFNLUuyB6vY5jyrAHwwVsp2RgcX3YR6
 ANemjROxrVazE2PjH9Jhrjb3Ip3z5j7xV3Zad5vn9+q7LDh1G8tvUYgVs4eHYtZNddZAXgv6sQC
 qwrNFLAl67TOf3dhGzArTdzzWv5bv15ZJneUethm6aHSKmyMJQVxUKDjNxH2ixnNtVGioBNVM53
 7o=
X-Received: by 2002:a17:907:c20e:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c2a1564868cmr950763966b.9.1790009013566; 
 Mon, 21 Sep 2026 09:43:33 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.32.7]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a35239469sm330214966b.6.2026.09.21.09.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 09:43:32 -0700 (PDT)
Message-ID: <886c5070-d766-4119-971b-7470f71fc8c2@gmail.com>
Date: Mon, 21 Sep 2026 17:43:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] examples/rpcapd: demo version of packet capture daemon
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260920190007.1128720-1-stephen@networkplumber.org>
 <2801d980-791c-4552-a9cd-4ad705ebb196@gmail.com>
 <20260921085859.5de77f91@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260921085859.5de77f91@phoenix.local>
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

On 21/09/2026 16:58, Stephen Hemminger wrote:
> On Mon, 21 Sep 2026 10:51:39 +0100
> Marat Khalili <qm2k21@gmail.com> wrote:
>
>>>    examples/rpcapd/meson.build            |   19 +
>>>    examples/rpcapd/rpcap-protocol.h       |  127 +++
>> Could we just use one from libpcap?
> Could but since most distro's don't enable rpcapd the header
> file is not exported. We could "vendor it".
Is it possible to use your new app without having a full version of 
libpcap in the system (that would have this rpcap-protocol.h anyway)? In 
"Client Setup" you mention that libpcap must be rebuilt with remote 
support enabled, and at this moment our own abridged copy of 
rpcap-protocol.h becomes redundant. Our copy allows building the 
application in systems where rpcapd is missing or built without the 
remote support, but then the build result cannot be used. Am I 
misunderstanding something?
