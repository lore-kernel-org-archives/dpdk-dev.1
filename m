Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C92FD3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 12:56:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09A2740270;
	Tue,  9 Dec 2025 13:56:20 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 9AD934025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 13:56:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765284975;
 bh=yqGAOXnukzygTHieU5lJMcV5XJ50SDFaB9U3W+uM8lQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=V1TCIkavJUdJxFZlE4RxV5XfFr8Nto6pF2+neAOsRGU12cochMsfmIm8/LN6gdVbR
 G/aq/xESNXy+bhiNCpaFkusKjDqCix7vwfphMwOI5ZDIWssvopMvktO3I+jaw7jjKZ
 /chcuGcjjN4xdz2kYAU/HOBUuUqeyE/qLidse/bY=
X-QQ-mid: esmtpgz16t1765284972tc51ab975
X-QQ-Originating-IP: 4mCapG5XUFMM+Rw6ApYV47nW+cd+AP6kgdH7c6BTcmk=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 09 Dec 2025 20:56:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9438044959225631944
Message-ID: <DF324D1D0FA61EA8+07c5be16-e072-482e-a443-a1c424464ce2@tencent.com>
Date: Tue, 9 Dec 2025 20:56:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]RE: [PATCH v7] acl: support custom memory allocators
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
References: <BFA8D0B9488D3A67+20251202092502.165081-1-mannywang@tencent.com>
 <68D016D742174F42+20251208125716.19424-1-mannywang@tencent.com>
 <0887b8f3045744199342bcb94e33f65b@huawei.com>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <0887b8f3045744199342bcb94e33f65b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OO2wLqYBHUeBSmhVCy1Y5P1A4q7YrEYMJuLfX+BWlYuqlB1IrCRcNUeq
 Gml8X7FfAdTgRbjNI+1oxkoRW4Pli8RNi123tFbaB5vCtH2smO6GawTIE25j/ojhc/aTBBd
 3rq2R6/WTQHR14/xO5/34QzmjIeBOmDvgVfHXuG3dQ022FPo22BoRF7DXTK/rq5PnESZgNf
 aSCbJ2qyim45I7m6fmqCO9jcplPfCTej1WxOukVzjHaXSVf6hwzmgv6iCm78wbLlcRmctCn
 Vn+8GWP8OLZeDJHKuzVdplVzKd2lQS/8hnxyg/GqYZ5dvx+QnbkE5dK6cTWGpXEHGRZCDqR
 yM1Kw+Wv0dcYZrW7JVJ8W5OfqK4gkic3hUrtMGkUzTw3z2FAha/epi+qBAS/RRnbnJQIPfQ
 J3jDAJIsHOE+/VgrQjbH7ilU3Ma9OX5UJkoKZBdbGSuVLn5blThbz01+wEKH0o2KCI9HhOB
 1a90DPpbte+lC3SH6SYyYy/5cYjpyif6rAvOSNhRfCTP/gB637ofjeG64DGSgipdY9+LyL6
 F0ckIIO4eHpZ/SXdXCvCe0FVVIrOE1ebGIsw5r6sOlv2ACFKYM7VfdcFnEp2C4HhUmetMhZ
 DYezRuKnvGvzgT5T6ieZvVFA1zt65SyOiO3Jl/cquy/eQ/jChGvK4PNyA7BE7OsmecQKKtH
 494vlyKoB/cgsBTdbkc1qsxSBoWi5+Og3hkqi1MHR3liI6+rAOuDJt6+eT+Q3WWb9dpL4H4
 r5+FkxaV8C1kNTLA7FIb9f1oN19npvjfVnJF0OLTuSPpkVoYF0JWDOtgqLgF+L+ifHHgKYt
 xKngK3Ur/nELrLxtq/dDqdCx8FemrYevlMzxPBy0rpsajyTLuYVB9Qgt3Nq+Z+YFB2hy9x/
 40aJtXONzxc2sJcDWehDZ14qbSMOHg6hhPF0KTcEfQXiaTVOEmRcyqUBj5O5N9mJx2g1CL1
 CteQ844P3zbuGLIK+YOWLqod5RsO1V/aFI+yIAvkskfJJww==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

Thanks for the clarification, and sorry for misunderstanding your 
intention earlier.
I’ve updated the implementation to use malloc/aligned_alloc() directly 
in running_alloc()
as you suggested. Please check whether the new version matches your 
expectation.


On 12/9/2025 6:59 PM, Konstantin Ananyev wrote:
> Sorry, I didn't express myself clear enough.
> My thought was to use malloc/aligned_alloc() directly in running_alloc() function.
> To be more specific here:
> static void *running_alloc(char *name, size_t size, size_t align, int32_t socket_id, void *udata)
> {
>     ...
>     /* just for the API correctness check */
>      If (udata != <expected_value>) {
>             /* report error */
>            return NULL;
>     }
> 
>     addr = aligned_alloc(align, size);
>     if (addr == NULL)  {
>          /* report error*/
>     }
>     return addr;
> }


