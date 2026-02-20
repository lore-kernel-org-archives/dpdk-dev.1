Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6A1C56207
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 15:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E609E4027B;
	Fri, 20 Feb 2026 16:49:59 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9E7AB4026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 16:49:58 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fHZSM2mJdzJ467Y;
 Fri, 20 Feb 2026 23:49:39 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 9F78C40569;
 Fri, 20 Feb 2026 23:49:54 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Feb 2026 16:49:54 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 20 Feb 2026 16:49:54 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: "stephen@networkplumber.org" <stephen@networkplumber.org>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Su Sai <spiderdetective.ss@gmail.com>
Subject: RE: [v3] net/cksum: compute raw cksum for several segments
Thread-Topic: [v3] net/cksum: compute raw cksum for several segments
Thread-Index: AQHcA53XV6oX7VAYW0CVHDbi9bVUZrRQ+PqAgADFOQCAAgdooIE5M5OQ
Date: Fri, 20 Feb 2026 15:49:54 +0000
Message-ID: <ac1777c39e66443789e6d45fb1b9d7fd@huawei.com>
References: <20250803090837.15589edd@hermes.local>
 <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
 <7c1a559c1d4d4e9bb58c318a95399138@huawei.com>
In-Reply-To: <7c1a559c1d4d4e9bb58c318a95399138@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
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

Hi folks,

What are we missing in order to merge this?
