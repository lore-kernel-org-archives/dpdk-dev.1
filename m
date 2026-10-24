Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C343E606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmF5az6s
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FD1340269;
	Sat, 24 Oct 2026 16:24:15 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 8782D4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 16:24:13 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1806071f8f.3
 for <dev@dpdk.org>; Sat, 24 Oct 2026 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792851853; x=1793456653; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5VXJFoMlevQetR+x4hVtYGFlhath7DgN4oOSWi9CiYM=;
 b=bmF5az6sF3ZEyERjfOMz13p9lb71gI7QMfv4Zk5Pvfj5uO7lSLalGl2//O0ZuCAQWQ
 h1ulK0cracoaS1G1t2IDC02yEwofkitaeRLd6ER2ZneLy26xxrixCwluChdWE7desn9g
 c5cOWG1UoGWNaP9HQtPpClajqkdCBUEZ3st1CZhMVF9NPD495K6H6+HNrpFqzKWdN9sW
 V7irIEtuJ3cfWK/JvtH7a3eEkJO0f4vQ9luxs0XByZeQvBTmxuuPwx2awXM4zuXXnJkv
 koDhjycV0Y6HiMCSSdINk1k+TA7kZMl0CqjWw4g1XyX8sy8FmImwQT33EvJ7yknDC8Vw
 HwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792851853; x=1793456653;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5VXJFoMlevQetR+x4hVtYGFlhath7DgN4oOSWi9CiYM=;
 b=sjbGm1DKRnQgaZv06R5EIn9S4BXBjQlhDEs4UTSJqOBp49rq+KS28J5wP8RI93gQYQ
 ZTRaRMQHMc57b1eaS1vcjPfE3N6HC1Syl2swpelItp8+rOfN8p2yeGLBRSdvK2IJNaVC
 aF3d9SS7ZWqnsKgpR114G/zOLNMWr2Lso+9dDxTZyGhlwOov6xTJZAJ0wWUTbGl+3+Gh
 m0x1luEsQZs/1qs2KPUV729/VQDPBsPsusKBUyHKzjIBA1q93OUgrTC7cDcXN9Wobf82
 p9MHGIK/S63RZl5gf+6yuPLxqUIt2D7ebhLXQlxwCmXZIuhgzvPJXHJAyCUdTnvCCGZo
 iQ/A==
X-Gm-Message-State: AFq9FYKhjHLiX0BN1hnSaa9zfLH5LziaEstMEf9Pwfik+ykkInysIvwn
 dlra0LZKRYw+u66C+28gjtQRczWYNzbW39FeK4EKUUKRQv33b+MlAGTm
X-Gm-Gg: AYBFou2keRCYl9qCHbp0S3QQgZ0G9IRqJashSt9qwp4q2OgjcUxI/Q7RCoH0QJ6kSHB
 g3A1+oTnj9KwFwYjC4oMFwBCkqV3vd/DB+HEAcPy1z4vrrxvcg9JoD1FSuUBZBH2ieScxUzty67
 pJMRJlvFkzAiilatUBbQxuCv14BZeTiiaHIRfEStA25EENenwkyK5DjTyOaK9xHWNBuEQkfecBM
 wlINTIRjI/g2UvisVrjc+jcp17GU+pwQcgtMmYtMT3QbRMOzI7FnBM7BDB2Y13miPuyDg09YYug
 xWzZA2dJZohy+47b7MLPCbkkq68+ZO44FTkeN7fwqI/qv+arNrL7NnfnqLBOxKjws6KmBdIKv1P
 kE2TGUdY7tbR280PHqTBFSj+Hkno0qduH2QBQmz1gAyN6brqS2tx5v85Q+wemoeRkkSfAE8et5l
 8fU6d9ibKTCLrC/a0qXbZHC7Sdy59e8rIhku902/ndY3T2key7KzLTxT0X8mzYcqqe9ok2cV45l
 Q3MOEDkeq1qFWGXxj7UNi6suVGCIFCc6HraC4yI5dDUDVK5rYlj
X-Received: by 2002:a5d:6f0a:0:b0:48c:6cdd:ba89 with SMTP id
 ffacd0b85a97d-48e3eb7b616mr3271635f8f.36.1792851853044; 
 Sat, 24 Oct 2026 07:24:13 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.39.187])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm5558494f8f.44.2026.10.24.07.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 07:24:12 -0700 (PDT)
Message-ID: <a6c2138a-d029-4fd3-8296-dca57b319f18@gmail.com>
Date: Sat, 24 Oct 2026 15:24:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] bpf: make callback handle atomic with relaxed
 access
To: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-9-qm2k21@gmail.com>
 <52dfdbb3-76a4-4cd4-a789-d864156b949e@yandex.ru>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <52dfdbb3-76a4-4cd4-a789-d864156b949e@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 19/10/2026 22:27, Konstantin Ananyev wrote:
>> The callback handle member cb of struct bpf_eth_cbi is concurrently
>> cleared by the control plane on unload and read by the datapath to
>> decide whether to execute the BPF filter program. Without atomic typing,
>> this concurrent access constitutes a data race in the C11 memory model,
> Hmm... why is that?
> So far, I don't see any.
> Can you probably point where you believe is a data-race, and how using 
> atomic
> load/store can prevent it.

It follows from the standard (5.1.2.4 Multi-threaded executions and data 
races):

     Two expression evaluations conflict if one of them modifies a 
memory location and the
     other one reads or modifies the same memory location. [...]

     The execution of a program contains a data race if it contains two 
conflicting actions in
     different threads, at least one of which is not atomic, and neither 
happens before the
     other. Any such data race results in undefined behavior.

