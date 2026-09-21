Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951BAC982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 17:53:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FC3240E2B;
	Mon, 21 Sep 2026 19:53:34 +0200 (CEST)
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by mails.dpdk.org (Postfix) with ESMTP id DBA014067D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 19:53:32 +0200 (CEST)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c254f56039dso435295966b.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790013212; x=1790618012; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VUilT8iUULo6H+vHUXZX6AkVvHb/edrgt1p+idklReU=;
 b=s8mVfWCtFFj7Z8JdnQ+zvEiXEO4fAqWMu4umz0Tj22HlAlGcEJgTxojDzPS9kMFAyT
 WYMmNrwlXDL3pz5VSorc3VOzQzT+iluOjEts3uoqFgE++AKvZbVCE1yXoKiWSX8+2zhM
 oKk0o76YGedJYUxLG1IlCog1E5dgY8FJ8aAHDqbJeK0idtaKACd77bw43SRkdsG8EIt7
 mC14zYuqe2mqbiYZFnajR4xmbVTy+WqELrQw4HXHRy5hoN40Q0Sga/9BfKmJxHREY+PZ
 5EKpTccjBXwvIaJ1buKEJXhSIjdOumR18StUFFtC6fC73gUw93s7RVG3CQeA1WMpwf48
 doog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790013212; x=1790618012;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VUilT8iUULo6H+vHUXZX6AkVvHb/edrgt1p+idklReU=;
 b=W6BPo310BtWKvMaEbLHMf0xA9Ci9ML+4z9E+m9okbxnFntAPkfPAhEnBtwEtR4+0Ay
 9jnW6lIhXbBlFJUuCT8RiBvAdEoldhqB2uUzyDSaV6k2uG28iqzeZxNNHnfY24DMhmXc
 2kXd4eklpX7mLn+VtZZJPjQjmo9UMiJESzENo28IozHJmoU/E+gBiyRwxrDH7E/rc0m9
 k9kFkFaH3mBl2DieeBy7lC1Jcomwghhc2sLFfkmZantvwXydHX3y/BTY8W7QbwXv3jKt
 /x9hgbL1O6TZDWSJ0mZwgXiw+YoHFM/Epw/vt2aarXK9TRx+m62VJXyJzk/TcqQbvngg
 IQUw==
X-Gm-Message-State: AFuF++lnqLM0ZivFJA283sbuRkzIdY/SaVscoiTUzBI9vAdIV2dg+TO2
 ZS7k4q+k16EI4ipRZPAHWz1FfTAhVxlRInVNCGxDDp46GE/2NCvoMArKB7cyFtQE
X-Gm-Gg: AYBFou34HLqF0qqRsYkHQ6xCAHDnJnl3VOh2jwCJiXojPrYjTyAB538Sh+Jg3YHqxBN
 nxh/ynQx3c9PKlj+rzvMbfvWSO7LfdGb4A1e85nLzLkItCSmNlx0d1MXiRpBiXk4jtz1WwKY3TS
 AazYhhVHLyXO5s4abbDFfMu0r4ZGZcmUQBBgN+6l3SGV7DdQPGmzejYhzSeHHb+B9Vt5H9GVCGi
 308mKA+xQR28R4eUELLQolxx+sJklvF+S4QN2hVsZYMHcW9EoYbgSKy6dUNjp5V+5EENLM1exHX
 8eY9cTgctSZlJfbylahNqzK/Xc/IkTxxbjuCby5GmdnTBcxcbVpQ0dcxffl0nr/FJKYXT5wcFwd
 /ZKYBOHCzBIPSMLuXOMAoqSopWjwbDKS+mxzPzhjHZxMJRtqja6z43Isw7PF6/LJthP08i57Ja/
 uGypdONVOfQPlNd85fPnJYrL3+txCTNtK7K2UVvOz80RRP/5mG2zS0VW5yjHr/q4cp6LgliMcCV
 JPF
X-Received: by 2002:a17:907:c28:b0:c28:e01d:1d08 with SMTP id
 a640c23a62f3a-c2a15e1d305mr1123186866b.49.1790013212147; 
 Mon, 21 Sep 2026 10:53:32 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.40.14])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a3586b497sm336472266b.42.2026.09.21.10.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 10:53:31 -0700 (PDT)
Message-ID: <1b9c3b66-bacb-4b80-b1cb-7ff46108753e@gmail.com>
Date: Mon, 21 Sep 2026 18:53:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] examples/rpcapd: demo version of packet capture daemon
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260920190007.1128720-1-stephen@networkplumber.org>
 <2801d980-791c-4552-a9cd-4ad705ebb196@gmail.com>
 <20260921085859.5de77f91@phoenix.local>
 <886c5070-d766-4119-971b-7470f71fc8c2@gmail.com>
 <20260921103118.405e396c@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260921103118.405e396c@phoenix.local>
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

>   2. The rpcap-protocol.h file is not exported by libpcap and
>      considered internal. The original is too damn messy to use
>      in DPDK as a copy.
Ok, I missed that part, Strange that they don't have a public header 
with protocol constants, but I guess there is little we can do, we have 
to have our own version. Maybe worth explaining it in the file header.
