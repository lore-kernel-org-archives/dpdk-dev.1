Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B4CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 23:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5685140144;
	Fri,  2 Oct 2026 01:00:53 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 2DA4C4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 01:00:51 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2db18fe433fso33085105ad.2
 for <dev@dpdk.org>; Thu, 01 Oct 2026 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790895650;
 x=1791500450; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E2omEHFwGydRaxxAqoH1By/mnmS9zqjBAdFd2XwEHNQ=;
 b=a/rYGy2fX3wTml26BVGQ8zYnhapgQjFaqf5Kw8Jr32Ebc0zr/1uiUAO9L2ieeCuIV/
 e/0ZFZvU3FQktKprni1CfXxoYPo5t0Rvm2IaNwUEaR2yRp6222l1MwJPGRPl7aGVnnWI
 BLDsl/BZ/TKYUdwjaNSZCCwu/Ez8rAzlrySPom1a//w0jnu7laxxVHS+xHnuxs8dcFVB
 0U8Tly59yx3LSBEQdkL0rhEWBF3zEUAOgBE94TFXKoKESvN7NWnKdVrlqTdlFxLdQdlB
 U38G7lN+O18YaQl2WUVA4SLmZUyHoKGJjcgKDuS6vyU38FBuQA9/WUahQaPXqDCXi8gx
 WDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790895650; x=1791500450;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E2omEHFwGydRaxxAqoH1By/mnmS9zqjBAdFd2XwEHNQ=;
 b=WAgG4erGkVii/TbotZNfMPbh615mYsnT3xo3uWCRgcazj2P2f2zNrbKoFy0vIlvzsi
 9q17rd4OUWREyoazDl0Z8V2X6DI0DiZCcZbunU45MOj/bNLx6YBA1rrcnubmxw6TMLfx
 OBZYs6t8ROR8aSSOu1z7oroAqjpV85tkV8p/2AsCKW+RzWEplCaY1rIaVyp7V6Bb5E0T
 dKN6k1yeGwa0BMNvXmTLYoDQxjlerbtAaFmoxN3yr0Xljs5K9kC6/ROlogmTPKewQeHs
 begg3Z8ExQi726B0oUhJOSo/vAoMwxZEF92u5P0hby6tOCPTiR+0u0WcOni0DJW/JAHC
 4LUA==
X-Gm-Message-State: AFq9FYISM68zLGBQFOW6JgE1kmMWeA9rk4Ama/ylzZujsHK5DOTSi11n
 0WPglnC3vAPFDFquyjuf5DX2LrwZRLCqPpwmj+NwE/YIQ34+jjGt3LMAZ/19T2oYT0s=
X-Gm-Gg: AYBFou3YVUxTzsRG3usGqmj42bn3weaLE3wRj9E35Qyow6UrcfOF1HmrujqyqijDfJ1
 llrJwH6VNeX16PTlD7aJl4qDXfKgxLfwUXOW21jIeGCmWiaLFbwssIM14Lus4kzB7iFx+S+fCor
 581LX/rFNxzWGBfQrhnZHemtKBLZxG23K82p0w4nmCRYzTnd9cENH0akSAlzuTLS9MlT28Yxl7O
 IjnCkZBiSiLasSMvO+lkrhkxLIY/20I3QpLTCuPiqe5GLVQFE5L1TiolUMLc8AiTWMhRbf10sUU
 rKbrqmPUdN4cEG45Wtq8zleO9ANB6ofyNx7f7XWlpb8HEczgdjNuR954JEAZ4a7j5v8yThaN68A
 v5XC+XoLst3kwUWW2/1iLZbmbBslfH4QgXr3z8igi0f457WLvBg3SDWBQbXKb/nnRTTNXt9BzgN
 ixkds7jAfChbWWVlD7yU1ODvg3utaQ81fmpX6MFJXumTT1jmcMSl1Jy4I4FYbEiDYPEcwksHPCQ
 DyOVfyP6ehRIUcL3YIVlBtypSstSYreOW17KJpn
X-Received: by 2002:a17:902:ec8c:b0:2dd:c100:b2c2 with SMTP id
 d9443c01a7336-2e49b7f32c5mr7514555ad.45.1790895650543; 
 Thu, 01 Oct 2026 16:00:50 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49e1f222asm1682175ad.3.2026.10.01.16.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 16:00:49 -0700 (PDT)
Date: Thu, 1 Oct 2026 16:00:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/4] add rpcap remote capture daemon
Message-ID: <20261001160046.61827fec@phoenix.local>
In-Reply-To: <cb600b10-6403-499b-af19-3f69d103510e@gmail.com>
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20261001025853.319860-1-stephen@networkplumber.org>
 <cb600b10-6403-499b-af19-3f69d103510e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 1 Oct 2026 19:50:34 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> >    pcapng: add API to read back capture mbuf header  
> Analysis with AI tells that there are some opportunities to make the 
> fast path of lib/pcapng both lighter and less .pcapng-centric to make 
> life of consumers that prefer other formats easier. It does not have to 
> (probably even shouldn't) be a part of the current patchset though.

Thought about that, and also looked at making rpcap another library
but it ends up with DPDK reimplementing libpcap...

The other option would be using dynamic fields. There already is timestamp,
but there is none for "original packet length". 

Third option is not using pdump callbacks at all and just having rpcap
specific callbacks. That is what the Wireshark extcap does. That is where
I think this will end up. Would like to not use pdump since it has
so many design problems baked in.


> >    app/rpcapd: remote pcap daemon  
> Ideally forwarding captured data could run in a separate thread with 
> minimum unnecessary syscalls, although it's hard to tell without 
> benchmarks how much current design is slowed down by them.

New version does use a data forwarding thread.
It has to write to a socket, which it does with sendmsg.
It could use liburing, to reduce syscalls further.

> >    app/rpcapd: add TLS support  
> This patch simultaneously adds authentication, but it's only required 
> for non-loopback users. This is a common security vulnerability, not all 
> loopback users can be trusted. So if we care about authentication at 
> all, it should probably also be required for localhost users, at least 
> by default.

Good point, but do not want to add DPDK specific user data base.
The problem is that TCP loopback has no way to identify who is on the
other end. Unix domain sockets do, but libpcap doesn't support that.

The real long term answer is having plugins in libpcap (Robin's proposal)
and make this one of the plugins. But that will take longer to reach
agreement on.
