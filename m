Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314AFCD4F21
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 16:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 463E8402B6;
	Wed, 13 May 2026 18:30:45 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 7527C40041
 for <dev@dpdk.org>; Wed, 13 May 2026 18:30:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gFzTh51jpzHnGj3
 for <dev@dpdk.org>; Thu, 14 May 2026 00:30:32 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id D62C640575
 for <dev@dpdk.org>; Thu, 14 May 2026 00:30:42 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 18:30:42 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 13 May 2026 18:30:42 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Arin Kharkar <arinkharkar@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] Updated skeleton example code to better emit error
Thread-Topic: [PATCH] Updated skeleton example code to better emit error
Thread-Index: AQHc4tUINr4k8nZga02V0cqaJKyq1LYMJVLw
Date: Wed, 13 May 2026 16:30:42 +0000
Message-ID: <fc1544b27d75489fb7f3b95abbebc0a3@huawei.com>
References: <20260512192834.130651-1-arinkharkar@gmail.com>
In-Reply-To: <20260512192834.130651-1-arinkharkar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

> --- a/examples/skeleton/basicfwd.c
> +++ b/examples/skeleton/basicfwd.c
> @@ -188,11 +188,9 @@ main(int argc, char *argv[])
>  	/* Check that there is an even number of ports to send/receive on. */
>  	nb_ports =3D rte_eth_dev_count_avail();
>  	if (nb_ports < 2 || (nb_ports & 1))
> -		rte_exit(EXIT_FAILURE, "Error: number of ports must be even\n");
> +		rte_exit(EXIT_FAILURE, "Error: number of ports must be even, found %u =
ports\n", nb_ports);

Maybe "positive even"?
