Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B507C3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38D2A402A4;
	Wed, 14 Oct 2026 18:47:38 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 6913E4013F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:47:37 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3550c917fd3so1666233eec.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996456; x=1792601256; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KBi903Sazc4ggjIykaPK8BvCsbiuqnMxbJsO+Rweato=;
 b=bGrfUuIRxw6/CXg7VOlCpWIUd2xCXFFsUigLv4wfRVkZw5Zk6yLjYlfitXV9zJ4UMW
 Rwe7uAQXa7NoO0v8pDhAlFJTErivZs/MTm5UsvWLBBGEWbbFD1q//XebkNLNgiSVG6ot
 F+aTpY2mWA1tcl9qe2bxInfjam4ktqnC/xVTrcE5kQCvT3jHWw5lC4UB/uI+2Wdyfy7o
 iUy2cFhHZi3R8LZqDgpfkXG9cOX662a+48DnSoqOidfcanK5FO2/7ZOFCxnJLYip6pjC
 +4wedtz546mXKrQDYgdoyKVpprEwTJqrzytak+OHk8QeWo621DIuJzv65pae5+xET6dm
 IyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996456; x=1792601256;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KBi903Sazc4ggjIykaPK8BvCsbiuqnMxbJsO+Rweato=;
 b=v05CA4umf8ppThOJ8HdnWVEingIaZp1yHySm94Awcg2zxdyHKPBiJOTQxHGa12q2TR
 pMXY3KX6VjjetyaJaQEjccvkEBPyxo9c8E3IZYU1e6ltR3TnUmYwP/OyF1xW1ny9rlzz
 3VcZKJ+wqvdb6RaojKAHnKoticWfjwXOBpEzfAIF5K/hJcmbAbAzN6O7SzcXc4rJ44J9
 eXmv2uaBP81Vuq2EzltPeVML4XwjLockeCgkWxIGB8SH9q3FEL9o5facYMXuim172GX9
 lkTaMeHCQ6eAN/DNxf/X9yh5r6ZI6YZ8nZNjHhCTKwmrVyMg/2mlmOE2GWOMyPvjlIqt
 kS9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByg+9/uzByEPFjEk1ZhRiLsYNFmsWzZILg4V++x7O5t4wZNDOETcXUlfK93DTaAWwA2ca0=@dpdk.org
X-Gm-Message-State: AFq9FYLKi6d1rFMLSps6i0pnav3Tuu4j2fkYu8vhuslAzA7jKwGF5vRI
 s0v6R3qLiyVKhfSs+NGf3TZCLADX/Xxx29oeqYV0F+J0F4fsWrQjJQDP
X-Gm-Gg: AYBFou2g4xIpWs+H/jcDcfiAs2zRXCJzo8oi2dvdaCRTX45WyaXLRAQy1FewEAGkNhs
 WWYm6+fgFdvKb41ouF7Oei2sWDrQLeYwcXt+LyNcWzHozxmoT3Mym4Z5Ouz9OtQEBFO4DxoCJKJ
 ymwdGCeaTvSJ02cKVegB0s+iz4qfRKkea0pXoXGFk5rsaw/a9uWIMmH9JqFRKHsdH3BrnXYxudR
 L6ifGfDER0WKrkSyObLzk4kb4JeERZLd4+b5GbrdovXJalQWQYKnGhSKsQXCLlOp9kcs9oHTi3U
 Lku/DMZoU4wTqNCUM7r26v7D+3SWLe0yMWy/hF6JCBYil2E+ghvEeJXGWta5Eem9xwdWd+8il+4
 VO5fwV8kzAl16cgFwAwzkDbY3iJ41lhasLo7GohmFPlTu5jnds/aRXIMW5xaDXzry9dUDtwnxLv
 wI0LuU3S34O4nN0mRr206cpwYDw46P+9V6SCry6EqSumdEa2QYrbI42gY8yty/lk8fqi5PkG/9w
 GWJf1R7Sz22vw/URnRqFV+Z4Jg=
X-Received: by 2002:a05:693c:8957:10b0:35b:cb8a:8d0e with SMTP id
 5a478bee46e88-35bcb8a91d1mr9873276eec.16.1791996456214; 
 Wed, 14 Oct 2026 09:47:36 -0700 (PDT)
Received: from [192.168.1.112] (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm28685859eec.24.2026.10.14.09.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 09:47:35 -0700 (PDT)
Message-ID: <54095ca6-afe3-4c28-bfce-4456d9e30e4b@gmail.com>
Date: Thu, 15 Oct 2026 00:47:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
To: Jiawen Wu <jiawenwu@trustnetic.com>, dev@dpdk.org
Cc: stephen@networkplumber.org, zaiyuwang@trustnetic.com
References: <cover.1791898970.git.zhtfdev@gmail.com>
 <017d01dd5b7c$dedc3a30$9c94ae90$@trustnetic.com>
Content-Language: en-US
From: Zhang Tengfei <zhtfdev@gmail.com>
In-Reply-To: <017d01dd5b7c$dedc3a30$9c94ae90$@trustnetic.com>
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

On 10/14/26 09:39, Jiawen Wu wrote:
> 
> 
>> -----Original Message-----
>> From: Zhang Tengfei <zhtfdev@gmail.com>
>> Sent: Tuesday, October 13, 2026 10:00 PM
>> To: dev@dpdk.org; dev@dpdk.org
>> Cc: stephen@networkplumber.org; Zhang Tengfei <zhtfdev@gmail.com>; jiawenwu@trustnetic.com; zaiyuwang@trustnetic.com;
>> stephen@networkplumber.org; Zhang Tengfei <zhtfdev@gmail.com>; jiawenwu@trustnetic.com; zaiyuwang@trustnetic.com
>> Subject: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
>> The same issue was fixed in ixgbe:
>> <https://patches.dpdk.org/project/dpdk/patch/20260927042545.45152-1-zhtfdev@gmail.com>
>>
>> Compile tested only.
> 
> It should to be tested with the actual NICs.
> 


v2 is out. I do not have a txgbe NIC, so it is compile-tested
only.
Would you be able to test it on a txgbe NIC?

With the port started: create and delete one FDIR rule ten
times, then check that PBRXSIZE(0) (0x19020) does not keep
shrinking and that FDIRCTL (0x19500) is 0 after delete.
flow validate must not change either register. A rule with an
out-of-range queue must fail and leave them unchanged. flow
flush must restore PBRXSIZE(0). SP and AML if you have both.
