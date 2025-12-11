Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF8D3B9AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 02:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D4BE40289;
	Thu, 11 Dec 2025 03:22:53 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 10E7E40285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 03:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765419770;
 bh=4B8Q+HhIzRpHL1knqhJTYP9q3PADpVP71g8pZuPWPcU=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=GhLGcn9S9SLuxTFln+GY5H9MS3HHuB/4/MOn+MYwAM9Wv2hdmQMJxGx503mHqup6p
 nwULf454of8kXFYi9ScRV51dJfn04Gv/YVIIInn1VnMaySxekAdlSmrYZbzyJw4Xqk
 otRJCts0ohLXVJt8qkM9XIVAVgsRwBbfTJ2cT2mk=
X-QQ-mid: esmtpgz14t1765419766teefdfd53
X-QQ-Originating-IP: 9XlAE1SyNpZNICTmguAdQeZQ5ho4lq0pgni93luPc34=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 11 Dec 2025 10:22:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3492542117426248607
Message-ID: <5A777D22B9198593+9607d6a6-ce99-4a71-8151-df04ee06a887@tencent.com>
Date: Thu, 11 Dec 2025 10:22:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v3] acl: support custom memory allocator
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <20251211104625.39632870@stephen-xps.local>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <20251211104625.39632870@stephen-xps.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OXvkGtaK08fGdG2qB6/T4WIOxx444/WaCNQcQBxvnvU/QI7zV/DiLbRB
 8zRpdjDsLkz1tbASB2bJShF+djJl5TeNAoBUo6PFmUZc53rq/O+hIEr+UbzODh+hh+dE22W
 +h+SeyrNf9Cacie2YTfs9VYulmS/SD9+V95DQU6goVmjN8STQuX6iuIRXhQWg+uY0GJkVlK
 iyivYUCQfOQ72UUkb4SW0DO4zgeQ8sPzVmkRU5V1z5eRGfCCD4Y9FnnOvuJxHeEdkM40dEl
 URPBNoU/xJEVAw+NHIaAq/3F6jym9pIHiUTxJw57lWL8+/LM/vLDxYd4EzrClE3obJBJfDS
 NMR3RPDFELYrKOrSDExXGIkVaBiXL+gjZW9jH8YAQG1z8ey8ZFI2Zf0g26LsiJEHM8kJ81Q
 9Rcpy5rp5cwWzeMU0/inhieeqUPGPBUl1fu1KuN8VRGVUBXHfqMGNJidJJ7euE62vz79siR
 BiLvSuk/gq1U+Dn7cPHJBxt6mrxSto/bqRiBNYQu3CA2TxGXVr6lA2dxGBF3ZsMmWZzy4+I
 NwVB8JUeMQr7SJX42JJsUq9kkBuRIhO02l1whyZeKrA+0gJwOKOVDF0HL/n4vleGj97teNX
 LqUltMme8zTFDG6a16DZjGy5dXaBRSvln/Kc5qA7DGovY18ISb3F9oRCikoyharh9j/qbtz
 jhLSiLVPhlvSc19XL73qfQDvAZJa8UcpbZbrEtgh6paWrZLY5tYqQ7+DWIvqGrIgochLSgJ
 C+8pOc4zBeIhXhCc66tFzDCUQRjXGfHtIbG/4iG7D4Lja6qGUy5P0QxgM34mOGu4+sAsdZK
 hh9eNS7pCKPmQISjWW0YhHD6hgE0e19v8cLz46yGFXryyiL4SUNjXAKQzab5+yZl12+AEdy
 D+rntcabamdIC76nJIrmDxeFeVt2lp3UFYrTgDOtYlA5jE3to76x2pWpSb3hBAcfSgEJPM7
 CiPrcEzMP+slbMmRO0ZRV1tGt
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

In fact, my original goal was simply to bind a pre-allocated memory 
block to the acl_ctx so it could use that memory persistently, without 
reallocating and freeing it on each build. I wasn’t trying to specify 
any particular memory or object management strategy beyond that.

On 12/11/2025 9:46 AM, Stephen Hemminger wrote:
> Rather than custom allocators, I did a couple of quick AI queries about
> alternatives. It looks like there are some big global gains possible
> here:


