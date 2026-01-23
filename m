Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB8D72373
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 10:55:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80E1B4026F;
	Fri, 23 Jan 2026 11:55:30 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5F93240269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 11:55:28 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyFFD2DWFzJ468w;
 Fri, 23 Jan 2026 18:54:56 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 8DD1A40569;
 Fri, 23 Jan 2026 18:55:25 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Jan 2026 11:55:25 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 23 Jan 2026 11:55:25 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v5 0/4] devtools: add AI-powered code review tools
Thread-Topic: [PATCH v5 0/4] devtools: add AI-powered code review tools
Thread-Index: AQHcjAGF+Ovc0Y7CuUeGqoyEjX1nDLVflAOw
Date: Fri, 23 Jan 2026 10:55:25 +0000
Message-ID: <6e26cc4dd86545a18b7e7b7c9aec87d6@huawei.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260123004430.10951-1-stephen@networkplumber.org>
In-Reply-To: <20260123004430.10951-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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

Apologies if not the right venue for it, but I have an RFE. Can mostly
AI-generated emails be clearly marked in some way detectable by standard em=
ail
filters? They create quite a lot of traffic in the mailing list recently, a=
nd
it would really help to manage this traffic (tricks such as detecting emoji=
s
are not 100% bulletproof).
