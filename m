Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8324CD5B175
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:43:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F483402D3;
	Mon, 15 Dec 2025 15:43:41 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 0B15C4026F
 for <dev@dpdk.org>; Mon, 15 Dec 2025 15:43:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765809813;
 bh=E7t4druH7+04fvTieQ05oA/xcWF5y5TPwrCZ5R7+J4w=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=E2qGNdi7aSaRbBTn9MLVsg6r9r/sr+TKUIu3vCerApcXjr0UEMgMwh+E0SCMmCC3t
 DXULqIbttSLEThNp6afzInqhSH7TKVVmeXbseUtdx3eonDROQjpAyMja/r6m3DoEfq
 RBFr4QX3nBL6Guk7HeeNSt0h3Ef5+qo5mUeu9jeo=
X-QQ-mid: zesmtpsz8t1765809811t37b9c9ef
X-QQ-Originating-IP: KIX6keiqCpuXtfbAy30bZg5AQmZtxd1c44vLShjER24=
Received: from [127.0.0.1] ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 15 Dec 2025 22:43:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13024611054802844278
Message-ID: <DBAE163C97CEE5DC+03a00fd8-7746-49e9-8f55-5e8ba5659ea4@tencent.com>
Date: Mon, 15 Dec 2025 22:43:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: RE: [PATCH v10] acl: support custom memory allocators
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
References: <531B109557B40560+20251209125236.27095-1-mannywang@tencent.com>
 <052877E03EF66856+20251213012735.34054-1-mannywang@tencent.com>
 <55475b963f0e456ca529b0fc718208c1@huawei.com>
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
In-Reply-To: <55475b963f0e456ca529b0fc718208c1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M44hTGryyoPCFoPRAFkyciMmNDrBH3QPRvkYsifQkY1BzR+jbDGQwvKX
 S5XgkuRFyPom4uGjAbBhIzQwzTE7TUmlaA3aYq+rRZSVsrIfl6IctCn4zEpDFnrrtv+ddqn
 Rpt9UTO3MJFaiVq3FRBZwvfQht7ove65Df4sZPWwI+iTt1YeO35VN/vp1y+dP2GjtIRg8tR
 sYfX+97Sz+zwkgZ5+DgAmkzMIQ1RN93vqd9RgnUcYAlWZtBvrRAOQZPmhxx9IRujEKo9rCS
 dzcugmLadMaO5YxAhhyQhv1evxIQImS8Pzi3EzLDdCgGid57aYuIRhXYKEy2YovQfXXToGT
 ehctN5nZByORs/YOmWXydhGE7SbcBF4R7tG9M6hpTLcXjOMTSiuQ4Bsy/pD01aqj6U9hsSi
 mzWvehpJ/ojlxWK16fWwM16J+IwuWNI42Fy8PlQCUj9T68Y0xr7jTNBSebTdkht9qDpO5Oa
 RdsTgtkZoV0qg7yJXZNWyH1Hs4YOnQlMfqrH94sY4M6Teh5zk/Zmo7bwXsbQUgzvllltwn2
 S0H6Wg2LQtgDL+s7R/cfShZGc/kuSjsHAv1plpDxBQXtlwcGSRBjDR03BnXPXF95XMrc8hu
 OnuyoaahgZk+TshyCI4lOQb7BAoAlNjdiuAdYFUzjcG7Gpzlc8iz9kwztVBmz7GPjvTAXWx
 GUn+LEZ9pQfr3rNVTkvVxKculpLEvEektwdcTYCOMKwRtTHz9x3OUmCEYM4a5w3Q8I1pazN
 iZvBjvojj8eGFI5VeUQu6bvln/42JkIwDdE3MmacCmwdc8klP16Jf/+LMLZ0HNncRHuz28O
 lo26eBjqjmQk81O/1PQ1o0gsuw07RjVmKlnK6aFbE1WoB0OC9fe/IfvS49nRGnp9KqIPdli
 RtYRXzrImEGSjRks82Z2CJuwOWvdfhgzPPHv5XL7td/Bb7UkHAZ0u70S5FAOdKqBPQDir9e
 I7lDgbtLmbhUiljrfDfsVb06OoEO7YbcIg/xsbYSTgCPa06WYteH+dfXiWb32TOjQx/nL6R
 Tp+50otzIc5fCB/oqq
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

Thanks for the review, v11 sent addressing the comments.

On 12/15/2025 5:48 PM, Konstantin Ananyev wrote:
> Acked-by: Konstantin Ananyev<konstantin.ananyev@huawei.com>


