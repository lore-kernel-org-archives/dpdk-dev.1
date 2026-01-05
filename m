Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90398C79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 15:07:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D1124026F;
	Mon,  5 Jan 2026 16:07:53 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1B48D40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 16:07:52 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlHhB4FpHzJ46dP;
 Mon,  5 Jan 2026 23:06:50 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 275A540565;
 Mon,  5 Jan 2026 23:07:51 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 5 Jan 2026 16:07:50 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 5 Jan 2026 16:07:50 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Kerem Aksu <kerem.aksu@i2i-systems.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] cmdline: update clear screen behavior
Thread-Topic: [PATCH] cmdline: update clear screen behavior
Thread-Index: AQHcfjeZ8gPmPrMasEC+3UNfmZDDJ7VDq3kg
Date: Mon, 5 Jan 2026 15:07:50 +0000
Message-ID: <f9a34decfa0340dbaeb62b8854567d58@huawei.com>
References: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
In-Reply-To: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
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

> -----Original Message-----
> From: Kerem Aksu <kerem.aksu@i2i-systems.com>
> Sent: Monday 5 January 2026 11:35
> To: dev@dpdk.org
> Cc: Kerem Aksu <kerem.aksu@i2i-systems.com>
> Subject: [PATCH] cmdline: update clear screen behavior
>=20
> Control+L should clear screen and redisplay prompt at the top
> line. DPDK rdline library will not change anything on the screen when
> fed with Control+L.  When prompt is lost after too many text written
> to the terminal, users will press Control+L to clear screen and put
> the prompt to the top line. This is expected behavior in bash(1) or
> applications that are using readline(3). Updated to behave as users
> expected.
>=20
> Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
> ---

Acked-by: Marat Khalili <marat.khalili@huawei.com>
Tested-by: Marat Khalili <marat.khalili@huawei.com>

Interestingly, currently supported combinations also miss Ctrl+U.
