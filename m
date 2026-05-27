Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEDFCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E93A34028A;
	Wed, 27 May 2026 13:18:47 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id DAB2D40285
 for <dev@dpdk.org>; Wed, 27 May 2026 13:18:45 +0200 (CEST)
X-QQ-mid: Yeas10t1779880720t258t10700
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 10467982473189671668
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-18-zaiyuwang@trustnetic.com>
 <20260517165307.6249117a@phoenix.local>
In-Reply-To: <20260517165307.6249117a@phoenix.local>
Subject: RE: [PATCH v4 17/20] net/txgbe: fix get module info operation
Date: Wed, 27 May 2026 19:18:36 +0800
Message-ID: <00c101dcedca$91701250$b45036f0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAkvPEfoBCEGfZ7VBs9aA
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NGHdgOcrWZQ9Y0hCfwRFCvhBYnymUhiAvYhU7vq4mkmTy5/YMbn36q5F
 ye8zy5CsKBxm58XBk6Ah/jQShgjY+rOBHa64L/vwFJJx9DdZpuYNE0HKntV49Z7NO+ZRv76
 dWBtErFIXoi3p4gmEL8WGAXsIyfb7N+5u6ClZvdxPAetwyOZgB8Nyj+xm9Ss/j1bEYCgoNj
 VjbbGYfzU6x5+HPafvInh6fkUeNoChAVnLX2Cnu2s2Y6jDakWJYPTJJHfGP1pd7sbjoI7Vl
 fn9I0jlmshCxaKpA3DuPq3/c7y1HQiWfTCDPtTlFuVahV9Ynt6W75v4QAV52UdznDIPJ8gj
 MN0zacNqmT7xhoYRVXF5b04vbRZflxSadrEcGI2tcxMs2DV23xgMnvewRAtEfa58J3x6sTK
 6DKcU1kfh4ii2YgJTO3Oo54OKY8xQ7bZ4lR+IK4QrJanbEjCKlfMFo3uWE8jXRhT4LI5zbu
 BgRbsFKn65+gKqwbkpdkjB4FiEbIKy8TcApe4h4/5bTe5vjRRPplF5pPvZY6LDe82hbABxL
 fKfVIUekvgbDa6vTkzHfT5wnDuxG6BASgi99SRLnW8hw5xI2Hx7+SDKSf869hZNEsoZG6k0
 tZJRFxAyt8XjEZX16o4baRqW9VmwC8NPsgWaIRAWqLh1JcVCYiCCpbDTiXCMGK8Tzig6kvw
 crQQOAQY9/cwPhtW4DWZDxCBTE6HjbEtUZ6wiI+2fPsSP1zIy5GVcS6NG5p15z97k26c3ty
 /S/v9MeFTttR1m7HKC8wYWB+t5HAL+xV7bW/H6fpUKT69R/wJEZ00FPTx+ECx6qoMgHtelj
 vLvuGtKvok7tPZyAQGm+F/OSAHJK358X19/LWnWLN/p6tNLqy4NEzraulY8gfp96dohDaVi
 Wb22E8XWw2DyaYAjHSivJYyPeVninX9VPr9ldz02ATQfjZ9xnPDeKTRuX5vvUcZtkHh2wbX
 KA6YMicZhOUhhrRJBemSkVn4tWgU6DkOtSwv1DqZDqlaJCHmVUKCdYQjBtS6TtTnoBarI/O
 bizf7l4sMIrhzlhWFza8TDwK2miRsCqL7EKob1YTaXNZbQq+CiIb4qwkG4RfviucfNA0Sny
 A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

> ## ERRORS
> 
> ### 1. Resource leak on error path after lock acquisition
The AI review suggested moving the module presence checks inside the lock, which I believe
is not necessary. The presence checks occur before acquiring the semaphore, so returning
early cannot leak the lock. All error paths after lock acquisition do properly go through
the ERROR_IO label and release the semaphore.

I've changed the pre-lock error from -EIO to - EINVAL to better distinguish "module not
present" from actual I/O failures.

> ---
> 
> ## WARNINGS
> 
> ### 1. Implicit comparison with zero
Fixed.

> ### 2. Mixed type usage: `u8` vs `uint8_t`
Fixed.
 
> ### 3. Unnecessary variable initialization
Fixed.

> ## INFO
> 
> ### 2. Error message clarity
> The error messages "I2C IO ERROR" and "SFF Module Type not recognized" are
> informative. Consider whether these should include additional context (e.g., the
> identifier value for unrecognized types) to aid debugging.
Added identifier value in error message.
 

