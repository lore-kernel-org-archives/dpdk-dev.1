Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64904FE5202
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 11:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 475E5402A0;
	Fri, 24 Apr 2026 13:12:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5A27A40274
 for <dev@dpdk.org>; Fri, 24 Apr 2026 13:12:15 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g29JX3TyYzHnH6G;
 Fri, 24 Apr 2026 19:11:40 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 470F740575;
 Fri, 24 Apr 2026 19:12:14 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 24 Apr 2026 13:12:14 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 24 Apr 2026 13:12:14 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Weijun Pan <wpan3636@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Weijun Pan <wpan36@wisc.edu>
Subject: RE: [PATCH] test: parenthesize assertion macro parameters
Thread-Topic: [PATCH] test: parenthesize assertion macro parameters
Thread-Index: AQHc07mjaNfZv7wizk6bjM4u9S39fbXt62oQgAAi4hA=
Date: Fri, 24 Apr 2026 11:12:14 +0000
Message-ID: <86b215390cc9483ca5915ab852e7d23c@huawei.com>
References: <20260419164818.20609-1-wpan36@wisc.edu>
 <254bea4a0dcf4161bbecc563dc65b0db@huawei.com>
In-Reply-To: <254bea4a0dcf4161bbecc563dc65b0db@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

> The patch is technically correct and would work, neither of my comments i=
s a
> blocker (although last one might be a blocker from maintainer), but given=
 that
> there are three of them maybe you would want to send a v2 to practice the
> process. Don't forget --in-reply-to when sending it.

P.S. Please also consider if this patch needs Fixes: and Cc: stable@dpdk.or=
g headers and mention why in the cover letter if you think it doesn't.
