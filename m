Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460ED59D77
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 16:41:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F17DC4028E;
	Fri, 12 Dec 2025 17:41:58 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 3494340268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 17:41:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765557713;
 bh=DqchSAKnxNwpHi7KrgCg9SHcvFHVKIBxOjRzlpPMgQM=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=vg36M9hGCIsnbdvQZNNo9HOLoB8HkIZZX6tpKygvs+kN/0bmzU3gWcvQW3SOD6SyW
 yhb85v0qkR6wO3U0kk+M+K/jCG5rBY4WZTnJn4BW+UBX3Tia8Xrc021vtEyaMWhtVJ
 3jAVZLw8w3Y/Yfw4sgX6IYG2Q6YPgT6lZg/Q6Ts4=
X-QQ-mid: zesmtpsz3t1765557711t684f3acf
X-QQ-Originating-IP: MTInVAxr2ElZRnZRla1GkOg0afeEwICpk0vuBudrLWQ=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 13 Dec 2025 00:41:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5552971112393397295
Message-ID: <06FCDC75F665F16F+8af591ec-40a4-4304-b02d-39c48357cd31@tencent.com>
Date: Sat, 13 Dec 2025 00:41:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: RE: [PATCH v8] acl: support custom memory allocators
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
References: <68D016D742174F42+20251208125716.19424-1-mannywang@tencent.com>
 <531B109557B40560+20251209125236.27095-1-mannywang@tencent.com>
 <e39d17c866a248829cef4bf45ac07602@huawei.com>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <e39d17c866a248829cef4bf45ac07602@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NRLj+a+1JRyJvZLIJaOcpQiGvZ5+cFsqk5ybk3YVkV5UeYE6BK0Ckg74
 CREuH3Gl6bBOrwlhJyZlf8JJYh3Y4JamCQyZXq8Pio1qHHyjFAHz/2IZtbYwAKOHegtpLJo
 VN+VhTRGK/L2rOngnhLK38LORTa0/93qd4w61nMT1FOlInpFO8MkOmc2K8J6cz91fOMIMv2
 9gN/H+CTYG25i9l259cjCRggeMAg7BAsrw2jrQ4S6TMukVdqotFgp5iGGC7ud/4ovDA7sN8
 dNUxf6qnd8hDmW4ce9Bq1zhOh+/4gaX9rPhKuHOBS84TWMSemGJM4jztFmN2l0s4ulgOsZX
 LHb6+l6Q9JT9CGa+WUpT/HsT0WUyXv1Ot54ybD6PkQuYbIk73mj1Nj46/sNxlv2Q3Ryf2wg
 Ig3mtKE7IThroJHQvcd918d92P89GSYBttTY1hJgWG6bLfx2IwD28SfGhw1qjgXQAqgjEKy
 QyqOmC0rpCr9OkB9wAYG917p1FxYbv29oU5YfcnwMJ+UCPXlSsCg7p/JbI5KKHqbdWT7NFh
 OmQdKLI/cZYZ8dlrOT36Lk3x2FAiGB+KpO6qFf8sDeKpv8XNUnaN75PB5H1vt6jumS2sfmy
 /SYmCjXl0g+7GXx05TqsqvKVOzrr177lIDqXjUqz9z4dTE5wNPB5f4+8FT/aVD+CP1y4Lms
 nMwtkzwl7pdDEjRG7s1O+M1xBHaJpy4juijUcQcEUUb73hwyTpE/baSY3MEk87Z/EZG38R9
 OpH8llYdv0WJjTRQjrZdSh9UQEKKCF9mDobpIMBCCrFq7gRieuxHlg3K4uy7RCNUWfZrQ9I
 iMXp0ayJvsnJnBPonMyNKrnvkGlB3WOOMWiS5uuKpqU7AiDGcJSsbsWM7G9yoB0KBbaN+VC
 v4HH3IySbMcMkCWYmarMo18Jnb+phUbCs1gdjie/duCN5ir0KMDSPFUdQF/ugxa1Guudjyy
 FBsU7zTFGb0KqQFQ3EjT5Wec1/73zRrnEJRMoHM4g9Os+RQ==
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

Thanks for the comments.
These issues have been fixed in v9.


On 12/12/2025 11:00 PM, Konstantin Ananyev wrote:
> memset(&new_hook, 0, sizeof(struct rte_acl_mem_hook));


