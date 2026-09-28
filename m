Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57508CA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 16:18:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10391402F0;
	Mon, 28 Sep 2026 18:18:45 +0200 (CEST)
Received: from mail-wr2-f36.google.com (mail-wr2-f36.google.com
 [74.125.225.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3CD8E40275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 18:18:43 +0200 (CEST)
Received: by mail-wr2-f36.google.com with SMTP id
 ffacd0b85a97d-4843c3ee4cfso1550007f8f.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790612322; x=1791217122; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N9m1kSogbYriZwp5/nyMLlM89GCvszIEEp/XWSto3TY=;
 b=omDr74F8Ez6/Nipc6ShmJltzQJ5oU6FUIcL/QuUk3Ou5TNGh4kNU0CJULNb1zdjl0A
 Rx1Ylpyyqjcz54mcKH7FsN431tFrk8brtueeGYqwk3eiJV37DK3leykJPHMHddGS5jcp
 zTkDjbno/gvWhXLW8kB/6roimS5Wv1T7Uz3xEf9QU3mpX0huiKknvS9ZYskgIVJlaGmS
 ozz4joKQRQqdr/WhRfNnG9uAB1X4NYggFhI6ilBD6RQMBE9oYZdA8KNO8a5ErlbFr9BH
 twsW6XITOikGysWEm6nHijbNYrwfNo/zBg4Gp+hvIz1fEfnKZK7Lc4NYLaqfrX49ECwu
 0svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790612322; x=1791217122;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9m1kSogbYriZwp5/nyMLlM89GCvszIEEp/XWSto3TY=;
 b=S3662qkUvBovv5JL3f4EXuqFKoSUoIBvfTGcbR7JxqnrVTuDsghBV+77jZ0ibqcLWn
 V1jjgUQ1R9PUTfsy4QW6wjTVUtJjs9w8weNSBfnWl2v2BklyZCAH+em/UffcLjdfYgCS
 rlrilEwrZqdPYOA5TjUUZIn2IyN12wRg3PJOQ5/2OsoRWkPx4ihUhaE3mm5OwHfilnSw
 Px9KFanYLnH62TpdXjMS85u6530qFq7Nw5FL1l94HPrnGJlINnYzZvjKGAqSUKJ/p4+5
 rJDlFTYSz8/7OoeurG6Dtbfx+RCSjLXTiLHWZco/eugZ8xbOrW8ZmpREYNrmdh/7pj8a
 1tgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5yiRMwJ4Dn+qbU+7GjdmiZx2nU/1Lt/MKhsB0tRFXHF8/8VaxH3xzp3Hkpgb4ysODD5s=@dpdk.org
X-Gm-Message-State: AFq9FYLTmDS9aXocqBflANQ8u+nTBNBW9k/+Vs+5OMXeU+uL1o7TjnuE
 v7IcRwGCe2XuE2TYhXIsZkrzavnmxLj/U6vBaTJ4lLfGd/Op/gWQIQXN
X-Gm-Gg: AYBFou0IMlEWbJXwXy0W79lGysjxMlUF8INFhXgfpi3f3SAt9/R/YxnvmEmjH+rXDVP
 weoeqEqh6f7McJm59X/FfLmOpSEOngUs3i9s10h6S28ELQOWRNAuBDurBGoHbgJVmSCqkmEbfMQ
 JL9mdze91Pmtdu02ba92ZFUDLwdZ0xC7GP3MXLw98EMmyKZcRQOYAuGUa1X+EVj++VBLNYum2Dk
 e7BF3tfWA6TsAmasQVkfpPREZd2R76HcUeqPU18nLcKMMWLUPCmfCCzNT/conKNEmMrp45lrt95
 6bMetjUa7bnmwhaOI4p55QBgnrN81zJEF4VZhnryEYDSNAoKOTCiZPjlKfStItLMumP5DbvI3LZ
 mUA7Tc1XtbafDpxJsqUuId7BjcywPRI1qBF501ffwlqnSKPcsTZqOIg5p4SHlEU8KGsVeUqZJ6o
 Y7hAcuWtaa/WSC65Qh/2cMN5n/qgNLVzSSj04LgMKxEvyjTqeNxvj1ppaJDAF7/KHZz0A=
X-Received: by 2002:a5d:64e7:0:b0:485:8c16:a34b with SMTP id
 ffacd0b85a97d-488716f4653mr23372295f8f.35.1790612322498; 
 Mon, 28 Sep 2026 09:18:42 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.41.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a638sm27716848f8f.9.2026.09.28.09.18.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:18:41 -0700 (PDT)
Message-ID: <2ec5b83b-54b7-4b69-afbd-33d4e4e81967@gmail.com>
Date: Mon, 28 Sep 2026 17:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] examples/rpcapd: demo version of packet capture daemon
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, dev@dpdk.org
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260922213130.90138-1-stephen@networkplumber.org>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260922213130.90138-1-stephen@networkplumber.org>
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

Summarizing the exchange to v2, our own copy of rpcap-protocol.h is 
unavoidable here since one included in libpcap is an internal header 
that is not installed by design (irrespective of package maintainers). I 
am ready to ack the patch after this is clarified in the code to prevent 
other people from being similarly confused since situation with the 
dependencies here is quite complex.

My request to better mark sections of main.c responsible for different 
concerns still stands, but is not a show stopper. Same for my request to 
make it a part of dpdk-testpmd instead of a secondary process. Anyone 
interested can probably do either or both locally in half an hour in a 
code agent anyway.

