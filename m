Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390D5606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JnGq0Icv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 855D840269;
	Sat, 24 Oct 2026 15:37:06 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id BC76D4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:37:04 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1267616f8f.3
 for <dev@dpdk.org>; Sat, 24 Oct 2026 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792849024; x=1793453824; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XQlYwyf82XsbSmjhlOBFDHNVzjrNjcsZPdhKOnC2bRM=;
 b=JnGq0Icvgt8Qg8L2x/QhDrjrzoGjqYU3JnrNKo66O/yAlAzfzoANRskwunclN8FFvV
 LY1RnkOkabufSF3XjFnSsdjhMT3LEQvAh/UpXRqnIigUvBBzaN/N7rJqZQr0oAXIhPNA
 c06I72gOjnWssorJ8jrqPSn72z3YOFWtG+j0LKU/IV8WRUv1emRmRkL/jffRc6JABQmv
 EzwyX4ohrBfCuLUf8PYaQes8bfhemuDKqNeJzg4O4CRgIzZAHMlUoMu4jkN+2lvgBIcL
 cI0cODAZyFn4xPeH7yyidwzzj/w1JZwhq69SUscJzx8ajJyrCm3q9aE85jGWVxB+PAJL
 SzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792849024; x=1793453824;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XQlYwyf82XsbSmjhlOBFDHNVzjrNjcsZPdhKOnC2bRM=;
 b=tCehWN1jIN/1Fl58i63an+3SYWh9Q/pKFjGz1ZPFBJBzlMFWy9gkEqxROOsWyV673I
 fYgTr+dKft2eKxlfR5VQUMxjdmm0fNCWq6LWLOMdii32X2J9r2YDruN52fIydUQoQmgy
 VD5belFwjvvCLHiSwnZ1C0JrKKfNj9R5ghKRkfstlCAjVzwWfU9vVw0Sh9xzQwJnMFuF
 h1laeRm6dstSQdPlYf+Hp3GepAhrtIx8uNHIk9H01NU/eodtL1cwn67t10IJhmN/0pb8
 4t4oPLLoWqOHBTnscT2fQ0IcoNI+S1pYfLTFv+DqdlLFOtK3Bg8clo3GS6PhTNFz/obj
 Alzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykmdGlz2/fjsrhLCOlfkJG7wr6Id0OSmCh/sLveZlQgjK+3KPLAOA+tY45WHGHTT3zlyo=@dpdk.org
X-Gm-Message-State: AFq9FYJ2DGt6uz17qOpS0/pb1DN9hwhWchY+ka1iI/dALxcuzn/QxzzD
 J7B0L0OkpuO3hDkIcq69Q2IvVfiKf65rubQ4PR0SYXQD1vQVdDKuc64H
X-Gm-Gg: AYBFou1TlU719njPdXFny15cNuhz2vEoqBaPoi2CdgZdFSl8ZRcWlFzPNWZQLQXhKeP
 B+1i88751nLL/GJ5q6IU7ZWNpQqdrma++Mw7bpCXmHU8WpUP38nfU2jh9ZyXdhNnJC1ZkjsRqO7
 mplZ/pGKhle2EFmjLzRF+lJMnOXwwLQhF89yz5OJTSRGw5bFU/yli1w8TB/cvEZKIqPbH0RHMzd
 ZWZ0HhX6iCTkHQi7zgYj+8a3w0d6PCXR+gZg6V7AFQKerRuSyyrpaPOdr6VQeTpyEj+cxmcslRR
 lHDstP9FF3Ef/27qKVBDOULbeViEwqeppzaX2pAyZn3pDxWGVwubVXmm8UHxi13YjHr2IMiZX3Y
 wWXW/aTXIVInyZKU0UnKTeOXWc806XJyc3fSiCpb7DM0gxckHzniWeTV23pziKOBNp9MoAUYAd6
 dWYlqfmnHYNitM6QONhmcTLagX9TqORwqI3WXwEhARu1T7H23o86AvmszAx4WLwz/FNIeW63/5Q
 5Kv2yOfTKmhYdf82n/LGfFQ+VIoHarzRsJbK9dIOS8QaoAwq3k=
X-Received: by 2002:a05:6000:149:b0:48e:389:d2d5 with SMTP id
 ffacd0b85a97d-48e3eb9d881mr2421717f8f.51.1792849024058; 
 Sat, 24 Oct 2026 06:37:04 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.35.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f305sm4121742f8f.3.2026.10.24.06.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 06:37:03 -0700 (PDT)
Message-ID: <482a2b83-e4b0-4752-92f9-d189d24d7377@gmail.com>
Date: Sat, 24 Oct 2026 14:37:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/29] bpf: replace deprecated SMP barriers with C11
 fences
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
 <20261013222410.2257622-2-stephen@networkplumber.org>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261013222410.2257622-2-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stephen,

Do you plan to make a stable revision of this patch to address 
https://bugs.dpdk.org/show_bug.cgi?id=2055 ?

Do you think we can just close it? There are no reports of this ever 
becoming a problem, and the probability seems very low.

