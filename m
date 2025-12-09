Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3184FD3B7E2
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 02:30:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0195B40270;
	Tue,  9 Dec 2025 03:30:41 +0100 (CET)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id EE39F4025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 03:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765247437;
 bh=ZCFkfH7QgYtUcw2J4pXoJFqJFR4H8v9xg/DIN7JBI7I=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=vt5s7z9ad1I6J/CZoMx4zpyrTxed3IIbjL7ecIYqppuVbdYsPqaZGl9MJjrhGeG7W
 boa8C+w+pyVq3caI7Rwjo9y7kGZuC4pWzFfrpkLwpMPuS/a8lZNRr6QHwS7c7Hlw01
 4W/0VeeV9ACahO52LVzcWhrU67FLdhamUfb9nTi4=
X-QQ-mid: zesmtpgz1t1765247433t3d7983d5
X-QQ-Originating-IP: jAuXglt1p56bDZuJLc/C4b1CnUE2UZi82L0IAffxilw=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 09 Dec 2025 10:30:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 734143473917541928
Message-ID: <ACCDEF5FF0444B4A+74e02010-42f4-4b59-bb14-66aeccfe9bfd@tencent.com>
Date: Tue, 9 Dec 2025 10:30:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Internet]Re: [PATCH v6] acl: support custom memory allocators
To: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
References: <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
 <BFA8D0B9488D3A67+20251202092502.165081-1-mannywang@tencent.com>
 <2571c074e438491e837c51d1bdc5a538@huawei.com>
 <20251208112916.2743f596@phoenix.local>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <20251208112916.2743f596@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MjqaYNLY8QZGCMINOEup+XmQuWq8eKITx679rXufeLYU2NuYE9pplrHe
 qTHVLADjnTFb1JU+xQfRJ2o7hfO0EEzJawo4glx4tXN2um6XTXk6a1XP2/vnYewXONA54aH
 pnQtL4gT7QuJyHMJCed6FHp6WK84YXIc3dM5K/+Tz/5KhD146spYCx7dvkO03JTEkutrJpI
 duY0V6UXDXCdARb11WyTvPbsvhpOKWd5km2DWddaebG3dagL3OdN9KjwNsJxLNYnU4NjcLz
 v5ngXyPYnYtnyXxn5qX5zumbKCrCTwig2SX4imtpfFDtx8IU7JCVgx2ZVDTnnYBrqt0ElLt
 +RRt99IRdgY5egAxy155InX7uJCkFgLh5iuemNrNjsSrdmJ9bA3fqlul7Zr/Da9NjEnPdIJ
 ORICEHCBoQSh1ptEbyvQdHrqLXq0XWfdCn6uywoSUvni1O0m74eMpEs96mWFcDoYKfMhMUB
 MREHCcTMxlabzaTCQHW+d6u5+EaOtML2U9x+B4fCN32Qc5aU9EqVlTY6t7Z7GVpGZSZ0/3e
 lVpE3WlJRh660hLbpxRI6QVvRcHlzOjD18XMe3JLnbZkRfqnKre9elB2jH42AWF5e+R+0bC
 YJljXYAxRvtUd66FwOUKrXczEQ5Kx/T2a2D0Gi9hlQxGDqLJi0dJEZmJ5pvzCh7BkGLw0H1
 Pfxzolof3bCeAAQEpcNzDkJVPcZbIQnktzr8ak5AWRfjqPJNIwHM1yEaKBhrEB/805bep35
 IugUV5bvoDCSd1o34AObZcZqUmQkAAqaO+qm+pTEpP5T0Z4l7rlkpLlz99CwFkOGKYDhx3y
 cjnutB0cbiKSrD7GCfICpK7DWbfLB7BfjUUnrcoSGNOg+Ez9lSit42N4K9EngoUoN8+DK08
 7XD4xbg9HGfkQAl0TfmpCpW4GL3rnyntYX4ay4FlcOJtnlnesBJSh2UNSova57iBaOMAOmr
 XDar92evTcjL/szuHCl1WPoyG
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

Just to add some background on how ACL currently allocates memory:

ACL has two types of allocations:
1. The memory used for the ACL match trie is NUMA-aware.
    This part relies on specific NUMA placement, so replacing rte_malloc 
with
    regular malloc/free is not feasible.

2. The temporary memory used during the build phase already uses 
malloc/free,
    since NUMA locality is not required there.

On 12/9/2025 3:29 AM, Stephen Hemminger wrote:
> A lot of the problems would go away if ACL just used regular malloc/free more,
> and rte_malloc/rte_free less. The existing rte_malloc is slow and fragments badly


